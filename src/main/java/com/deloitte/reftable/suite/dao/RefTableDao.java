package com.deloitte.reftable.suite.dao;

import java.util.List;

import com.deloitte.reftable.suite.bean.ColumnObject;
import com.deloitte.reftable.suite.bean.RecordObject;

/**
 * The Interface RefTableDao.
 */
public interface RefTableDao {

	/**
	 * Sets the jdbc template.
	 *
	 * @param env
	 *            the new jdbc template
	 */
	public void setJdbcTemplate(String env);

	/**
	 * Gets the table list.
	 *
	 * @return the table list
	 */
	public List<String> getTableList();

	/**
	 * Gets the column list.
	 *
	 * @param tableName
	 *            the table name
	 * @return the column list
	 */
	public List<String> getColumnList(String tableName);

	/**
	 * Gets the table data.
	 *
	 * @param tableName
	 *            the table name
	 * @return the table data
	 */
	public List<RecordObject> getTableData(String tableName);

	/**
	 * Gets the column object list.
	 *
	 * @param tableName
	 *            the table name
	 * @return the column object list
	 */
	public List<ColumnObject> getColumnObjectList(String tableName);

	/**
	 * Gets the ref table field ID.
	 *
	 * @param tableName
	 *            the table name
	 * @param columnName
	 *            the column name
	 * @return the ref table field ID
	 */
	public int getRefTableFieldID(String tableName, String columnName);
}
