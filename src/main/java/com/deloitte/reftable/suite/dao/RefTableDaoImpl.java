package com.deloitte.reftable.suite.dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;
import java.util.Set;

import javax.sql.DataSource;

import org.springframework.dao.DataAccessException;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.ResultSetExtractor;

import com.deloitte.reftable.suite.bean.ColumnObject;
import com.deloitte.reftable.suite.bean.RecordObject;

/**
 * The Class RefTableDaoImpl.
 */
public class RefTableDaoImpl implements RefTableDao {

	/** The jdbc template. */
	private JdbcTemplate jdbcTemplate;

	/** The data sources map. */
	private Map<String, DataSource> dataSourcesMap;

	/**
	 * Instantiates a new ref table dao impl.
	 *
	 * @param dataSourcesMap
	 *           the data sources map
	 */
	public RefTableDaoImpl(Map<String, DataSource> dataSourcesMap) {
		this.dataSourcesMap = dataSourcesMap;
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see
	 * com.deloitte.reftable.suite.dao.RefTableDao#setJdbcTemplate(java.lang.
	 * String)
	 */
	public void setJdbcTemplate(String env) {
		this.jdbcTemplate = new JdbcTemplate(dataSourcesMap.get(env));
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see com.deloitte.reftable.suite.dao.RefTableDao#getTableList()
	 */
	@Override
	public List<String> getTableList() {

		String sql = "select name from rt_table";
		return jdbcTemplate.query(sql, new ResultSetExtractor<List<String>>() {

			@Override
			public List<String> extractData(ResultSet rs)
					throws SQLException, DataAccessException {
				List<String> tableList = new ArrayList<String>();
				while (rs.next()) {
					String tableName = rs.getString(1);
					tableList.add(tableName);
				}
				return tableList;
			}
		});
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see com.deloitte.reftable.suite.dao.RefTableDao#getColumnList(java.lang.
	 * String)
	 */
	@Override
	public List<String> getColumnList(String tableName) {

		String sql = "select name from rt_field_domain where field_id in "
				+ "(select field_id from rt_table_field where ref_table_id in "
				+ "(select ref_table_id from rt_table where name = '" + tableName
				+ "'))";

		return jdbcTemplate.query(sql, new ResultSetExtractor<List<String>>() {

			@Override
			public List<String> extractData(ResultSet rs)
					throws SQLException, DataAccessException {

				List<String> columnList = new ArrayList<String>();
				while (rs.next()) {
					String columnName = rs.getString(1);
					columnList.add(columnName);
				}
				return columnList;
			}
		});
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see com.deloitte.reftable.suite.dao.RefTableDao#getTableData(java.lang.
	 * String)
	 */
	// Earlier Used method to fetch data from the table view 
	/**
	 * Gets the table data old method.
	 *
	 * @param tableName the table name
	 * @return the table data old method
	 */
	// @Override
	public List<RecordObject> getTableData_OldMethod(String tableName) {

		String sql = "select * from rt_" + tableName + "_mv";

		return jdbcTemplate.query(sql,
				new ResultSetExtractor<List<RecordObject>>() {
					List<RecordObject> recordList = new ArrayList<RecordObject>();

					/*
					 * (non-Javadoc)
					 * 
					 * @see
					 * org.springframework.jdbc.core.ResultSetExtractor#extractData(
					 * java.sql.ResultSet)
					 */
					@Override
					public List<RecordObject> extractData(ResultSet rs)
							throws SQLException, DataAccessException {

						while (rs.next()) {
							RecordObject recordObj = new RecordObject();
							recordObj
									.setColumnObjectList(new ArrayList<ColumnObject>());
							for (int i = 1; i <= rs.getMetaData()
									.getColumnCount(); i++) {
								ColumnObject colObj = new ColumnObject();
								String columnName = rs.getMetaData().getColumnName(i);
								colObj.setColumnName(columnName);
								if (rs.getMetaData().getColumnTypeName(i)
										.startsWith("VARCHAR")) {
									colObj.setColumnValue(rs.getString(i));
								} else if (rs.getMetaData().getColumnTypeName(i)
										.startsWith("NUMBER")) {
									colObj.setColumnValue(rs.getInt(i) + "");
								}
								recordObj.getColumnObjectList().add(colObj);
								// Logic for other data types....
								/*
								 * if("CODE".equalsIgnoreCase(columnName))
								 * recordObj.setCodeColumnObj(colObj); else
								 * if("DESCRIPTION".equalsIgnoreCase(columnName))
								 * recordObj.setDescColumnObj(colObj); else{
								 * recordObj.getColumnObjectList().add(colObj); }
								 */
							}
							recordList.add(recordObj);
						}
						return recordList;
					}
				});
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see
	 * com.deloitte.reftable.suite.dao.RefTableDao#getColumnObjectList(java.lang
	 * .String)
	 */
	@Override
	public List<ColumnObject> getColumnObjectList(String tableName) {

		String sql = "select name from rt_field_domain where field_id in "
				+ "(select field_id from rt_table_field where ref_table_id in "
				+ "(select ref_table_id from rt_table where name = '" + tableName
				+ "'))";

		return jdbcTemplate.query(sql,
				new ResultSetExtractor<List<ColumnObject>>() {

					@Override
					public List<ColumnObject> extractData(ResultSet rs)
							throws SQLException, DataAccessException {

						List<ColumnObject> columnObjectList = new ArrayList<ColumnObject>();
						while (rs.next()) {
							ColumnObject columnObj = new ColumnObject();
							String columnName = rs.getString(1);
							String columnValue = "DUMMY";
							columnObj.setColumnName(columnName);
							columnObj.setColumnValue(columnValue);
							columnObjectList.add(columnObj);
						}
						return columnObjectList;
					}
				});
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see
	 * com.deloitte.reftable.suite.dao.RefTableDao#getRefTableFieldID(java.lang.
	 * String, java.lang.String)
	 */
	@Override
	public int getRefTableFieldID(String tableName, String columnName) {

		
		String sql = "";
		if ("CODE".equalsIgnoreCase(columnName)) {
			sql = "SELECT REF_TABLE_FIELD_ID FROM RT_TABLE_FIELD WHERE REF_TABLE_ID IN (SELECT REF_TABLE_ID FROM RT_TABLE WHERE NAME='"
					+ tableName + "') AND FIELD_ID IN ('2')";
		} else if ("DESCRIPTION".equalsIgnoreCase(columnName)) {
			sql = "SELECT REF_TABLE_FIELD_ID FROM RT_TABLE_FIELD WHERE REF_TABLE_ID IN (SELECT REF_TABLE_ID FROM RT_TABLE WHERE NAME='"
					+ tableName + "') AND FIELD_ID IN ('3')";
		} else {
			sql = "SELECT REF_TABLE_FIELD_ID FROM RT_TABLE_FIELD WHERE REF_TABLE_ID IN (SELECT REF_TABLE_ID FROM RT_TABLE WHERE NAME='"
					+ tableName
					+ "') AND FIELD_ID IN (SELECT FIELD_ID FROM RT_FIELD_DOMAIN WHERE NAME='"
					+ columnName + "')";
		}
		return jdbcTemplate.queryForInt(sql);
	}


	/* (non-Javadoc)
	 * @see com.deloitte.reftable.suite.dao.RefTableDao#getTableData(java.lang.String)
	 */
	@Override
	public List<RecordObject> getTableData(String tableName) {
		String sql = "select ROW_ID,COLUMNNAME,COLUMNVALUE,VERSION,EFFBEGDATE,EFFENDDATE, ROW_ID,FIELDID from V_RT_ALL_MV where V_RT_ALL_MV.tablename='"
				+ tableName + "'";
		return jdbcTemplate.query(sql,
				new ResultSetExtractor<List<RecordObject>>() {
					List<RecordObject> recordList = new ArrayList<RecordObject>();
					Map<String, RecordObject> columnMap = new HashMap<String, RecordObject>();

					@Override
					public List<RecordObject> extractData(ResultSet rs)
							throws SQLException, DataAccessException {
						while (rs.next()) {
							if (!columnMap.containsKey(rs.getString(1))) {
								RecordObject recordObj = new RecordObject();
								List<ColumnObject> colList = new ArrayList<ColumnObject>();
								ColumnObject colObj = new ColumnObject();
								colObj.setColumnName(rs.getString(2));
								colObj.setColumnValue(rs.getString(3));
								colList.add(colObj);
								recordObj.setColumnObjectList(colList);
								columnMap.put(rs.getString(1), recordObj);
							} else {
								RecordObject recordObj = columnMap.get(rs.getString(1));
								List<ColumnObject> colList = recordObj
										.getColumnObjectList();
								ColumnObject colObj = new ColumnObject();
								colObj.setColumnName(rs.getString(2));
								colObj.setColumnValue(rs.getString(3));
								colList.add(colObj);
								recordObj.setColumnObjectList(colList);
								columnMap.put(rs.getString(1), recordObj);
							}
							RecordObject recordObj = columnMap.get(rs.getString(1));
							List<ColumnObject> colList = recordObj
									.getColumnObjectList();
							int count = rs.getMetaData().getColumnCount() - 2;
							boolean isAdded = true;
							for (int i = 4; i <= count; i++) {
								String columnName = rs.getMetaData().getColumnName(i);
								for (ColumnObject columnObject : colList) {
									if (columnObject.getColumnName()
											.equals(columnName)) {
										isAdded = false;
									}
								}
								if (isAdded) {
									ColumnObject colObj = new ColumnObject();
									colObj.setColumnName(columnName);
									colObj.setColumnValue(rs.getString(i));
									colList.add(colObj);
								}
							}
							recordObj.setColumnObjectList(colList);
							columnMap.put(rs.getString(1), recordObj);
						}
						for (Entry<String, RecordObject> entry : columnMap
								.entrySet()) {
							recordList.add(entry.getValue());
						}
						return recordList;
					}
				});
	}
}
