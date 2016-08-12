package com.deloitte.reftable.suite.servlet;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.deloitte.reftable.suite.bean.ColumnObject;
import com.deloitte.reftable.suite.bean.ErrorMessagesBean;
import com.deloitte.reftable.suite.bean.RecordObject;
import com.deloitte.reftable.suite.bean.TableBean;
import com.deloitte.reftable.suite.dao.RefTableDao;
import com.deloitte.reftable.suite.service.GenerateScriptService;
import com.deloitte.reftable.suite.util.NavigationUtil;

/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {

	/** The context. */
	@Autowired
	ServletContext context;

	/** The session. */
	@Autowired
	HttpSession session;

	/** The navigation util. */
	@Autowired
	NavigationUtil navigationUtil;

	/** The ref table dao. */
	@Autowired
	RefTableDao refTableDao;

	/** The service. */
	@Autowired
	GenerateScriptService service;

	/** The error message bean. */
	@Autowired
	ErrorMessagesBean errorMessageBean;

	/**
	 * Home.
	 *
	 * @param model
	 *            the model
	 * @return the string
	 */
	@RequestMapping(value = "/home", method = RequestMethod.GET)
	public String home(Map<String, TableBean> model) {

		return "home";
	}

	/**
	 * Dashboard.
	 *
	 * @param model
	 *            the model
	 * @return the string
	 */
	@RequestMapping(value = "/dashboard", method = RequestMethod.GET)
	public String dashboard(Model model) {
		model.addAttribute("errorMessageBean", errorMessageBean);
		return "dashboard";
	}

	/**
	 * The Enum actionSwitch.
	 */
	public enum actionSwitch {

		/** The Create. */
		Create,
		/** The Update. */
		Update
	}

	/**
	 * Collect details.
	 *
	 * @param request
	 *            the request
	 * @param model
	 *            the model
	 * @param modelMap
	 *            the model map
	 * @param obj
	 *            the obj
	 * @return the map
	 */
	@RequestMapping(value = "/collectDetails", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> collectDetails(HttpServletRequest request, Model model,
			Map<String, TableBean> modelMap, @RequestBody Map<String, Object> obj) {

		Map<String, Object> res = new HashMap<String, Object>();
		String environment = (String) obj.get("environment");
		String selectedAction = (String) obj.get("selectedAction");

		service.setRefTableDao(refTableDao, environment);
		res.put("errorMessageBean", errorMessageBean);
		switch (actionSwitch.valueOf(selectedAction)) {
		case Create:
			model.addAttribute("addNewTable", "Yes");
			model.addAttribute("environment", environment);
			model.addAttribute("action", selectedAction);
			return res;
		case Update:
			model.addAttribute("updateTableOperation", "Yes");
			model.addAttribute("environment", environment);
			model.addAttribute("action", selectedAction);
			res.put("updateTableOperation", "Yes");
			return res;
		default:
			return res;
		}
	}

	/**
	 * Creates the new table.
	 *
	 * @param request
	 *            the request
	 * @param model
	 *            the model
	 * @param obj
	 *            the obj
	 * @return the map
	 */
	@RequestMapping(value = "suite/createNewTable", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> createNewTable(HttpServletRequest request, Model model,
			@RequestBody Map<String, Object> obj) {

		Map<String, Object> res = new HashMap<String, Object>();
		String tableName = (String) obj.get("tableName");
		String tableDesc = (String) obj.get("tableDesc");
		List<ColumnObject> columnObjList = new ArrayList<ColumnObject>();
		int numOfColumns = (Integer) obj.get("numOfRows");

		for (int i = 1; i <= numOfColumns; i++) {
			ColumnObject columnObj = new ColumnObject();
			columnObj.setColumnName((String) obj.get("columnNm_" + i));
			columnObj.setColumnDataType((String) obj.get("columnDType_" + i));
			columnObj.setColumnMaxLength((String) obj.get("columnMaxLen_" + i));
			columnObj.setNullsAllowed((String) obj.get("nullsAllow_" + i));
			columnObjList.add(columnObj);
		}

		String scriptPath = "";
		try {
			scriptPath = service.generateCreateNewRefTableScript(context, tableName, tableDesc, columnObjList);
		} catch (IOException e) {
			e.printStackTrace();
		}
		res.put("errorMessageBean", errorMessageBean);
		res.put("path", scriptPath);
		return res;
	}

	/**
	 * Update existing table.
	 *
	 * @param request
	 *            the request
	 * @param model
	 *            the model
	 * @param modelMap
	 *            the model map
	 * @param obj
	 *            the obj
	 * @return the map
	 */
	@RequestMapping(value = "/updateExistingTable", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> updateExistingTable(HttpServletRequest request, Model model,
			Map<String, TableBean> modelMap, @RequestBody Map<String, Object> obj) {

		Map<String, Object> res = new HashMap<String, Object>();

		String tableName = (String) obj.get("tableName");
		String operationName = (String) obj.get("operationName");

		session.setAttribute("tableName", tableName);
		model.addAttribute("errorMessageBean", errorMessageBean);
		if (operationName.equalsIgnoreCase("Add")) {
			res.put("addNewColumn", "Yes");
		}
		if (operationName.equalsIgnoreCase("Delete")) {
			res.put("deleteRecord", "Yes");
		}
		if (operationName.equalsIgnoreCase("Update")) {
			res.put("updateRecord", "Yes");
		}
		if (operationName.equalsIgnoreCase("Insert")) {
			res.put("insertRecord", "Yes");
		}
		res.put("updateTableOperation", "Yes");
		res.put("tableName", tableName);
		res.put("operationName", operationName);

		navigationUtil.navigateToPage(model, tableName, operationName, service, session, res);
		return res;
	}

	/**
	 * Adds the new column into table.
	 *
	 * @param request
	 *            the request
	 * @param model
	 *            the model
	 * @param obj
	 *            the obj
	 * @return the map
	 */
	@RequestMapping(value = "/addNewColumnIntoTable", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> addNewColumnIntoTable(HttpServletRequest request, Model model,
			@RequestBody Map<String, Object> obj) {

		Map<String, Object> res = new HashMap<String, Object>();
		List<ColumnObject> columnObjList = new ArrayList<ColumnObject>();

		int numOfColumns = (Integer) obj.get("numOfRows");
		String tableName = (String) obj.get("tableName");

		for (int i = 1; i <= numOfColumns; i++) {
			ColumnObject columnObj = new ColumnObject();
			columnObj.setColumnName((String) obj.get("columnName_" + i));
			columnObj.setColumnDataType((String) obj.get("columnDataType_" + i));
			columnObj.setColumnMaxLength((String) obj.get("columnMaxLength_" + i));
			columnObj.setNullsAllowed((String) obj.get("nullsAllowed_" + i));
			columnObjList.add(columnObj);
		}

		String scriptPath = "";
		try {
			scriptPath = service.generateAddNewColumnIntoTableScript(context, tableName, columnObjList);
		} catch (IOException e) {
			e.printStackTrace();
		}

		res.put("path", scriptPath);
		res.put("errorMessageBean", errorMessageBean);
		res.put("addNewColumn", "Yes");
		res.put("updateTableOperation", "Yes");
		return res;
	}

	/**
	 * Insert record into table.
	 *
	 * @param request
	 *            the request
	 * @param model
	 *            the model
	 * @param obj
	 *            the obj
	 * @return the map
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/insertRecordIntoTable", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> insertRecordIntoTable(HttpServletRequest request, Model model,
			@RequestBody Map<String, Object> obj) {
		Map<String, Object> res = new HashMap<String, Object>();

		List<RecordObject> recordObjList = new ArrayList<RecordObject>();
		
		int numOfRecords = (Integer) obj.get("numOfRecords");
		List<String> columnNameList = (List<String>) session.getAttribute("columnList");
		for (int i = 1; i <= numOfRecords; i++) {
			RecordObject recordObj = new RecordObject();
			recordObj.setColumnObjectList(new ArrayList<ColumnObject>());
			int j = 0;
			for (String columnName : columnNameList) {
				ColumnObject columnObj = new ColumnObject();
				String paramName = columnName + "_" + i + "_" + j;
				String columnValue = (String) obj.get(paramName);
				columnObj.setColumnName(columnName);
				columnObj.setColumnValue(columnValue);
				recordObj.getColumnObjectList().add(columnObj);
				
				/*if ("CODE".equalsIgnoreCase(columnName))
					recordObj.setCodeColumnObj(columnObj);
				else if ("DESCRIPTION".equalsIgnoreCase(columnName))
					recordObj.setDescColumnObj(columnObj);
				else {
					recordObj.getColumnObjectList().add(columnObj);
				}*/
				j++;
			}
			recordObjList.add(recordObj);
		}
		String scriptPath = "";
		try {
			String tableName = (String) session.getAttribute("tableName");
			scriptPath = service.generateInsertRecordIntoTableScript(context, tableName, recordObjList);
		} catch (IOException e) {
			e.printStackTrace();
		}
		res.put("path", scriptPath);
		return res;
	}

	/**
	 * Update record in table.
	 *
	 * @param request
	 *            the request
	 * @param model
	 *            the model
	 * @param obj
	 *            the obj
	 * @return the map
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/updateRecordInTable", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> updateRecordInTable(HttpServletRequest request, Model model,
			@RequestBody Map<String, Object> obj) {
		Map<String, Object> res = new HashMap<String, Object>();
		List<RecordObject> recordObjList = (List<RecordObject>) session.getAttribute("recordObjectList");
		int recordLoop = 0;

		for (RecordObject recordObj : recordObjList) {
			int columnLoop = 0;
			for (ColumnObject columnObj : recordObj.getColumnObjectList()) {
				String columnNewValue = (String) obj
						.get(columnObj.getColumnName() + "_" + recordLoop + "_" + columnLoop + "");
				columnObj.setColumnNewValue(columnNewValue);
				columnLoop++;
			}
			recordLoop++;
		}

		String scriptPath = "";
		try {
			String tableName = (String) session.getAttribute("tableName");
			scriptPath = service.generateUpdateRecordIntoTableScript(context, tableName, recordObjList);
		} catch (IOException e) {
			e.printStackTrace();
		}
		res.put("path", scriptPath);
		return res;
	}

	/**
	 * Delete record from table.
	 *
	 * @param request
	 *            the request
	 * @param model
	 *            the model
	 * @param obj
	 *            the obj
	 * @return the map
	 */
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@RequestMapping(value = "/deleteRecordFromTable", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> deleteRecordFromTable(HttpServletRequest request, Model model,
			@RequestBody Map<String, Object> obj) {
		Map<String, Object> res = new HashMap<String, Object>();
		List<LinkedHashMap> mapList = (List<LinkedHashMap>) obj.get("items");
		String finalCodeString = "";
		for (LinkedHashMap map : mapList) {
			String code = (String) map.get("CODE");
			if (finalCodeString == "") {
				finalCodeString = code;
			} else {
				finalCodeString = finalCodeString + "," + code;
			}
		}
		String tableName = (String) session.getAttribute("tableName");
		String codeValue = finalCodeString;
		String scriptPath = "";
		try {
			scriptPath = service.generateDeleteRecordFromTableScript(context, tableName, codeValue);
		} catch (IOException e) {
			e.printStackTrace();
		}
		res.put("path", scriptPath);
		res.put("errorMessageBean", errorMessageBean);
		return res;
	}

}
