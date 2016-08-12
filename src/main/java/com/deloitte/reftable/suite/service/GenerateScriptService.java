package com.deloitte.reftable.suite.service;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletContext;

import org.springframework.beans.factory.annotation.Autowired;

import com.deloitte.reftable.suite.bean.ColumnObject;
import com.deloitte.reftable.suite.bean.GenerateScriptsBean;
import com.deloitte.reftable.suite.bean.RecordObject;
import com.deloitte.reftable.suite.dao.RefTableDao;

/**
 * The Class GenerateScriptService.
 */
public class GenerateScriptService {

	/** The bean. */
	@Autowired
	GenerateScriptsBean bean;

	/** The ref table dao. */
	private RefTableDao refTableDao;

	/**
	 * Sets the ref table dao.
	 *
	 * @param refTableDao
	 *           the ref table dao
	 * @param env
	 *           the env
	 */
	public void setRefTableDao(RefTableDao refTableDao, String env) {
		this.refTableDao = refTableDao;
		this.refTableDao.setJdbcTemplate(env);
	}

	/**
	 * Gets the ref table list.
	 *
	 * @return the ref table list
	 */
	public List<String> getRefTableList() {
		return refTableDao.getTableList();
	}

	/**
	 * Gets the table column list.
	 *
	 * @param tableName
	 *           the table name
	 * @return the table column list
	 */
	public List<String> getTableColumnList(String tableName) {
		return refTableDao.getColumnList(tableName);
	}

	/**
	 * Gets the table column object list.
	 *
	 * @param tableName
	 *           the table name
	 * @return the table column object list
	 */
	public List<ColumnObject> getTableColumnObjectList(String tableName) {
		return refTableDao.getColumnObjectList(tableName);
	}

	/**
	 * Gets the table data.
	 *
	 * @param tableName
	 *           the table name
	 * @return the table data
	 */
	public List<RecordObject> getTableData(String tableName) {
		return refTableDao.getTableData(tableName);
	}

	/**
	 * Generate create new ref table script.
	 *
	 * @param context
	 *           the context
	 * @param tableName
	 *           the table name
	 * @param tableDesc
	 *           the table desc
	 * @param columnObjList
	 *           the column obj list
	 * @return the string
	 * @throws IOException
	 *            Signals that an I/O exception has occurred.
	 */
	public String generateCreateNewRefTableScript(ServletContext context,
			String tableName, String tableDesc, List<ColumnObject> columnObjList)
			throws IOException {
		return bean.generateCreateNewRefTableScript(context, tableName, tableDesc,
				columnObjList);
	}

	/**
	 * Generate add new column into table script.
	 *
	 * @param context
	 *           the context
	 * @param tableName
	 *           the table name
	 * @param columnObjList
	 *           the column obj list
	 * @return the string
	 * @throws IOException
	 *            Signals that an I/O exception has occurred.
	 */
	public String generateAddNewColumnIntoTableScript(ServletContext context,
			String tableName, List<ColumnObject> columnObjList)
			throws IOException {
		return bean.generateAddNewColumnScript(context, tableName, columnObjList);
	}

	/**
	 * Generate insert record into table script.
	 *
	 * @param context
	 *           the context
	 * @param tableName
	 *           the table name
	 * @param recordObjList
	 *           the record obj list
	 * @return the string
	 * @throws IOException
	 *            Signals that an I/O exception has occurred.
	 */
	public String generateInsertRecordIntoTableScript(ServletContext context,
			String tableName, List<RecordObject> recordObjList)
			throws IOException {
		for (RecordObject recordObj : recordObjList) {
			for (ColumnObject colObje : recordObj.getColumnObjectList()) {
				int refTableFieldId = refTableDao.getRefTableFieldID(tableName,
						colObje.getColumnName());
				colObje.setRef_table_field_id(refTableFieldId);
			}
		}

		return bean.generateInsertNewRecordScript(context, tableName,
				recordObjList);
	}

	/**
	 * Generate update record into table script.
	 *
	 * @param context
	 *           the context
	 * @param tableName
	 *           the table name
	 * @param recordObjList
	 *           the record obj list
	 * @return the string
	 * @throws IOException
	 *            Signals that an I/O exception has occurred.
	 */
	public String generateUpdateRecordIntoTableScript(ServletContext context,
			String tableName, List<RecordObject> recordObjList)
			throws IOException {
		return bean.generateUpdateRecordScript(context, tableName, recordObjList);
	}

	/**
	 * Generate delete record from table script.
	 *
	 * @param context
	 *           the context
	 * @param tableName
	 *           the table name
	 * @param codeValue
	 *           the code value
	 * @return the string
	 * @throws IOException
	 *            Signals that an I/O exception has occurred.
	 */
	public String generateDeleteRecordFromTableScript(ServletContext context,
			String tableName, String codeValue) throws IOException {
		return bean.generateDeleteRecordScript(context, tableName, codeValue);
	}
}
