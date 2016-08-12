package com.deloitte.reftable.suite.bean;

import java.util.List;

/**
 * The Class RecordObject.
 */
public class RecordObject {

	/** The code column obj. */
	private ColumnObject codeColumnObj;

	/** The desc column obj. */
	private ColumnObject descColumnObj;

	/** The column object list. */
	private List<ColumnObject> columnObjectList;

	/**
	 * Gets the code column obj.
	 *
	 * @return the code column obj
	 */
	public ColumnObject getCodeColumnObj() {
		return codeColumnObj;
	}

	/**
	 * Sets the code column obj.
	 *
	 * @param codeColumnObj
	 *            the new code column obj
	 */
	public void setCodeColumnObj(ColumnObject codeColumnObj) {
		this.codeColumnObj = codeColumnObj;
	}

	/**
	 * Gets the desc column obj.
	 *
	 * @return the desc column obj
	 */
	public ColumnObject getDescColumnObj() {
		return descColumnObj;
	}

	/**
	 * Sets the desc column obj.
	 *
	 * @param descColumnObj
	 *            the new desc column obj
	 */
	public void setDescColumnObj(ColumnObject descColumnObj) {
		this.descColumnObj = descColumnObj;
	}

	/**
	 * Gets the column object list.
	 *
	 * @return the column object list
	 */
	public List<ColumnObject> getColumnObjectList() {
		return columnObjectList;
	}

	/**
	 * Sets the column object list.
	 *
	 * @param columnObjectList
	 *            the new column object list
	 */
	public void setColumnObjectList(List<ColumnObject> columnObjectList) {
		this.columnObjectList = columnObjectList;
	}
}
