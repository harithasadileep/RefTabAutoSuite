package com.deloitte.reftable.suite.bean;

import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.servlet.ServletContext;

import org.apache.velocity.Template;
import org.apache.velocity.VelocityContext;
import org.apache.velocity.app.VelocityEngine;
import org.apache.velocity.runtime.RuntimeConstants;
import org.apache.velocity.runtime.resource.loader.ClasspathResourceLoader;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

/**
 * The Class GenerateScriptsBean.
 */
@Component
public class GenerateScriptsBean {

	/** The error message bean. */
	@Autowired
	ErrorMessagesBean errorMessageBean;

	/** The date format with time. */
	private static String dateFormatWithTime = "MMddyyyy-h-mm-ss";

	/** The date format without time. */
	private static String dateFormatWithoutTime = "yyyy-MM-dd";

	/** The output dir. */
	private static String outputDir = null;

	/**
	 * Inits the.
	 *
	 * @return the velocity engine
	 */
	public VelocityEngine init() {
		VelocityEngine ve = new VelocityEngine();
		ve.setProperty(RuntimeConstants.RESOURCE_LOADER, "classpath");
		ve.setProperty("classpath.resource.loader.class", ClasspathResourceLoader.class.getName());
		ve.init();
		return ve;
	}

	/**
	 * Generate create new ref table script.
	 *
	 * @param context
	 *            the context
	 * @param tableName
	 *            the table name
	 * @param tableDesc
	 *            the table desc
	 * @param columnObjList
	 *            the column obj list
	 * @return the string
	 * @throws IOException
	 *             Signals that an I/O exception has occurred.
	 */
	public String generateCreateNewRefTableScript(ServletContext context, String tableName, String tableDesc,
			List<ColumnObject> columnObjList) throws IOException {
		VelocityEngine ve = init();
		Template t = ve.getTemplate("templates/createNewRefTable.vm");
		VelocityContext ctx = new VelocityContext();

		ctx.put("ref_table_name", tableName);
		ctx.put("ref_table_description", tableDesc);
		ctx.put("columnObjectList", columnObjList);

		String fileName = tableName + "_CreateNewTable";
		return writeIntoFile(ctx, t, context, fileName);
	}

	/**
	 * Generate add new column script.
	 *
	 * @param context
	 *            the context
	 * @param tableName
	 *            the table name
	 * @param columnObjList
	 *            the column obj list
	 * @return the string
	 * @throws IOException
	 *             Signals that an I/O exception has occurred.
	 */
	public String generateAddNewColumnScript(ServletContext context, String tableName, List<ColumnObject> columnObjList)
			throws IOException {
		VelocityEngine ve = init();
		Template t = ve.getTemplate("templates/addNewColumnIntoExistingTable.vm");
		VelocityContext ctx = new VelocityContext();

		ctx.put("columnObjectList", columnObjList);
		String fileName = tableName + "_AddColumn";
		return writeIntoFile(ctx, t, context, fileName);
	}

	/**
	 * Generate insert new record script.
	 *
	 * @param context
	 *            the context
	 * @param tableName
	 *            the table name
	 * @param recordObjectList
	 *            the record object list
	 * @return the string
	 * @throws IOException
	 *             Signals that an I/O exception has occurred.
	 */
	public String generateInsertNewRecordScript(ServletContext context, String tableName,
			List<RecordObject> recordObjectList) throws IOException {
		VelocityEngine ve = init();
		Template t = ve.getTemplate("templates/insertNewRecordIntoExistingTable.vm");
		VelocityContext ctx = new VelocityContext();

		ctx.put("recordObjectList", recordObjectList);
		String fileName = tableName + "_InsertRecord";
		return writeIntoFile(ctx, t, context, fileName);
	}

	/**
	 * Generate update record script.
	 *
	 * @param context
	 *            the context
	 * @param tableName
	 *            the table name
	 * @param recordObjectList
	 *            the record object list
	 * @return the string
	 * @throws IOException
	 *             Signals that an I/O exception has occurred.
	 */
	public String generateUpdateRecordScript(ServletContext context, String tableName,
			List<RecordObject> recordObjectList) throws IOException {
		VelocityEngine ve = init();
		Template t = ve.getTemplate("templates/updateRecordIntoExistingTable.vm");
		VelocityContext ctx = new VelocityContext();

		ctx.put("ref_table_name", tableName);
		ctx.put("recordObjectList", recordObjectList);
		String fileName = tableName + "_UpdateRecord";
		return writeIntoFile(ctx, t, context, fileName);
	}

	/**
	 * Generate delete record script.
	 *
	 * @param context
	 *            the context
	 * @param tableName
	 *            the table name
	 * @param codeValue
	 *            the code value
	 * @return the string
	 * @throws IOException
	 *             Signals that an I/O exception has occurred.
	 */
	public String generateDeleteRecordScript(ServletContext context, String tableName, String codeValue)
			throws IOException {
		VelocityEngine ve = init();
		Template t = ve.getTemplate("templates/deleteRecordFromRFTable.vm");
		VelocityContext ctx = new VelocityContext();

		ctx.put("ref_table_name", tableName);
		ctx.put("code_value_to_be_deleted", codeValue);
		String fileName = tableName + "_DeleteRecord";
		return writeIntoFile(ctx, t, context, fileName);
	}

	/**
	 * Write into file.
	 *
	 * @param ctx
	 *            the ctx
	 * @param template
	 *            the template
	 * @param context
	 *            the context
	 * @param fileName
	 *            the file name
	 * @return the string
	 * @throws IOException
	 *             Signals that an I/O exception has occurred.
	 */
	private String writeIntoFile(VelocityContext ctx, Template template, ServletContext context, String fileName)
			throws IOException {
		createOutputDir(context);
		File file = new File(outputDir + "/" + fileName + "_" + getCurrentDate(dateFormatWithTime) + ".sql");
		FileWriter writer = new FileWriter(file);
		template.merge(ctx, writer);
		writer.close();
		System.out.println(writer);
		return file.getAbsolutePath();
	}

	/**
	 * Creates the output dir.
	 *
	 * @param context
	 *            the context
	 */
	private void createOutputDir(ServletContext context) {
		outputDir = context.getRealPath("") + errorMessageBean.getPortionOfTargetFolder()
				+ getCurrentDate(dateFormatWithoutTime);
		File dirName = new File(outputDir);
		System.out.println("Output Directory Name: " + outputDir);
		if (!dirName.exists()) {
			dirName.mkdirs();
			System.out.println("Wo ho....directory created");
		}
	}

	/**
	 * Gets the current date.
	 *
	 * @param dateFormat
	 *            the date format
	 * @return the current date
	 */
	private String getCurrentDate(String dateFormat) {
		String currentDate = "";
		Date curDate = new Date();
		DateFormat df = new SimpleDateFormat(dateFormat);
		currentDate = df.format(curDate);
		System.out.println(currentDate);
		return currentDate;
	}

}
