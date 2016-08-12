package com.deloitte.reftable.suite.util;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.ui.Model;

import com.deloitte.reftable.suite.bean.RecordObject;
import com.deloitte.reftable.suite.service.GenerateScriptService;

/**
 * The Class NavigationUtil.
 */
public class NavigationUtil {

	/** The page ID. */
	String pageID = "";

	/**
	 * The Enum operationSwitch.
	 */
	public enum operationSwitch {

		/** The Add. */
		Add,
		/** The Insert. */
		Insert,
		/** The Update. */
		Update,
		/** The Delete. */
		Delete,
		/** The Value 1. */
		Value1;
	}

	/**
	 * Navigate to page.
	 *
	 * @param model
	 *            the model
	 * @param tableName
	 *            the table name
	 * @param operation
	 *            the operation
	 * @param service
	 *            the service
	 * @param session
	 *            the session
	 * @param res
	 *            the res
	 * @return the map
	 */
	public Map<String, Object> navigateToPage(Model model, String tableName, String operation,
			GenerateScriptService service, HttpSession session, Map<String, Object> res) {
		switch (operationSwitch.valueOf(operation)) {
		case Add:
			pageID = "dashboard";
			break;
		case Insert:
			insertRecordNavigation(model, tableName, service, session, res);
			break;
		case Update:
			res = updateTableNavigation(model, tableName, service, session, res);
			break;
		case Delete:
			updateTableNavigation(model, tableName, service, session, res);
			break;
		case Value1:
			break;
		default:
			break;
		}
		return res;
	}

	/**
	 * Insert record navigation.
	 *
	 * @param model
	 *            the model
	 * @param tableName
	 *            the table name
	 * @param service
	 *            the service
	 * @param session
	 *            the session
	 * @param res
	 *            the res
	 * @return the map
	 */
	private Map<String, Object> insertRecordNavigation(Model model, String tableName, GenerateScriptService service,
			HttpSession session, Map<String, Object> res) {
		List<String> columnList = null;
		columnList = service.getTableColumnList(tableName);
		session.setAttribute("columnList", columnList);
		res.put("tableName", tableName);
		res.put("columnList", columnList);
		return res;
	}

	/**
	 * Update table navigation.
	 *
	 * @param model
	 *            the model
	 * @param tableName
	 *            the table name
	 * @param service
	 *            the service
	 * @param session
	 *            the session
	 * @param res
	 *            the res
	 * @return the map
	 */
	private Map<String, Object> updateTableNavigation(Model model, String tableName, GenerateScriptService service,
			HttpSession session, Map<String, Object> res) {
		List<RecordObject> recordObjectList = null;
		recordObjectList = service.getTableData(tableName);
		session.setAttribute("recordObjectList", recordObjectList);
		res.put("tableName", tableName);
		res.put("recordObjectList", recordObjectList);
		return res;
	}

}
