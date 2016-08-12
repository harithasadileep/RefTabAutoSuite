
package com.deloitte.reftable.suite.config;

import java.util.HashMap;
import java.util.Map;

import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.PropertySource;
import org.springframework.context.support.PropertySourcesPlaceholderConfigurer;
import org.springframework.jdbc.datasource.DriverManagerDataSource;

import com.deloitte.reftable.suite.bean.ErrorMessagesBean;
import com.deloitte.reftable.suite.dao.RefTableDao;
import com.deloitte.reftable.suite.dao.RefTableDaoImpl;
import com.deloitte.reftable.suite.service.GenerateScriptService;
import com.deloitte.reftable.suite.util.NavigationUtil;

/**
 * The Class SpringAppConfig.
 */
@Configuration
@PropertySource({ "classpath:config.properties", "classpath:errormessages.properties" })
public class SpringAppConfig {

	/** The dev host name. */
	@Value("${dev.hostname}")
	private String devHostName;
	
	/** The dev service name. */
	@Value("${dev.serviceName}")
	private String devServiceName;
	
	/** The dev user id. */
	@Value("${dev.userId}")
	private String devUserId;
	
	/** The dev password. */
	@Value("${dev.password}")
	private String devPassword;

	/** The sit host name. */
	@Value("${sit.hostname}")
	private String sitHostName;
	
	/** The sit service name. */
	@Value("${sit.serviceName}")
	private String sitServiceName;
	
	/** The sit user id. */
	@Value("${sit.userId}")
	private String sitUserId;
	
	/** The sit password. */
	@Value("${sit.password}")
	private String sitPassword;

	/** The uat host name. */
	@Value("${uat.hostname}")
	private String uatHostName;
	
	/** The uat service name. */
	@Value("${uat.serviceName}")
	private String uatServiceName;
	
	/** The uat user id. */
	@Value("${uat.userId}")
	private String uatUserId;
	
	/** The uat password. */
	@Value("${uat.password}")
	private String uatPassword;

	/** The column name err msg. */
	@Value("${columnNameErrMsg}")
	private String columnNameErrMsg;
	
	/** The data type drop down err msg. */
	@Value("${dataTypedropDownErrMsg}")
	private String dataTypeDropDownErrMsg;
	
	/** The numeric err msg. */
	@Value("${numericErrMsg}")
	private String numericErrMsg;
	
	/** The operation drop down err msg. */
	@Value("${operationDropDownErrMsg}")
	private String operationDropDownErrMsg;
	
	/** The environment drop down err msg. */
	@Value("${environmentDropDownErrMsg}")
	private String environmentDropDownErrMsg;

	/** The operation name error. */
	@Value("${operationNameError}")
	private String operationNameError;

	/** The table name error. */
	@Value("${tableNameError}")
	private String tableNameError;

	/** The code value err msg. */
	@Value("${codeValueErrMsg}")
	private String codeValueErrMsg;

	/** The table desc error. */
	@Value("${tableDescError}")
	private String tableDescError;

	/** The portion of target folder. */
	@Value("${portionOfTargetFolder}")
	private String portionOfTargetFolder;

	/** The check boc select error. */
	@Value("${checkBocSelectError}")
	private String checkBocSelectError;

	/** The user inputs error. */
	@Value("${userInputsError}")
	private String userInputsError;

	/**
	 * Gets the error messages bean.
	 *
	 * @return the error messages bean
	 */
	@Bean
	protected ErrorMessagesBean getErrorMessagesBean() {
		ErrorMessagesBean errorMessagesBean = new ErrorMessagesBean();
		errorMessagesBean.setColumnNameErrMsg(columnNameErrMsg);
		errorMessagesBean.setDataTypeDropDownErrMsg(dataTypeDropDownErrMsg);
		errorMessagesBean.setNumericErrMsg(numericErrMsg);
		errorMessagesBean.setOperationDropDownErrMsg(operationDropDownErrMsg);
		errorMessagesBean.setEnvironmentDropDownErrMsg(environmentDropDownErrMsg);
		errorMessagesBean.setOperationNameErrorMsg(operationNameError);
		errorMessagesBean.setTableNameErrorMsg(tableNameError);
		errorMessagesBean.setCodeValueErrMsg(codeValueErrMsg);
		errorMessagesBean.setTableDescErrorMsg(tableDescError);
		errorMessagesBean.setPortionOfTargetFolder(portionOfTargetFolder);
		errorMessagesBean.setCheckBocSelectError(checkBocSelectError);
		errorMessagesBean.setUserInputsError(userInputsError);
		return errorMessagesBean;
	}

	/**
	 * Gets the navigation util.
	 *
	 * @return the navigation util
	 */
	@Bean
	protected NavigationUtil getNavigationUtil() {
		return new NavigationUtil();
	}

	/**
	 * Gets the generate script service.
	 *
	 * @return the generate script service
	 */
	@Bean
	protected GenerateScriptService getGenerateScriptService() {
		return new GenerateScriptService();
	}

	/**
	 * Gets the data sources map.
	 *
	 * @return the data sources map
	 */
	@Bean
	public Map<String, DataSource> getDataSourcesMap() {
		Map<String, DataSource> dataSourcesMap = new HashMap<String, DataSource>();

		DriverManagerDataSource devDataSource = new DriverManagerDataSource();
		devDataSource.setDriverClassName("oracle.jdbc.driver.OracleDriver");
		devDataSource.setUrl("jdbc:oracle:thin:@" + devHostName + ":1521:" + devServiceName);
		devDataSource.setUsername(devUserId);
		devDataSource.setPassword(devPassword);

		dataSourcesMap.put("DEV", devDataSource);

		DriverManagerDataSource sitDataSource = new DriverManagerDataSource();
		sitDataSource.setDriverClassName("oracle.jdbc.driver.OracleDriver");
		sitDataSource.setUrl("jdbc:oracle:thin:@" + sitHostName + ":1521:" + sitServiceName);
		sitDataSource.setUsername(sitUserId);
		sitDataSource.setPassword(sitPassword);

		dataSourcesMap.put("SIT", sitDataSource);

		DriverManagerDataSource uatDataSource = new DriverManagerDataSource();
		uatDataSource.setDriverClassName("oracle.jdbc.driver.OracleDriver");
		uatDataSource.setUrl("jdbc:oracle:thin:@" + uatHostName + ":1521:" + uatServiceName);
		uatDataSource.setUsername(uatUserId);
		uatDataSource.setPassword(uatPassword);

		dataSourcesMap.put("UAT", uatDataSource);
		// System.out.println("The columnNameErrMsg Error---
		// "+columnNameErrMsg);
		return dataSourcesMap;
	}

	/**
	 * Gets the ref table DAO.
	 *
	 * @return the ref table DAO
	 */
	@Bean
	public RefTableDao getRefTableDAO() {
		return new RefTableDaoImpl(getDataSourcesMap());
	}

	/**
	 * Gets the property config.
	 *
	 * @return the property config
	 */
	@Bean
	public static PropertySourcesPlaceholderConfigurer getPropertyConfig() {
		return new PropertySourcesPlaceholderConfigurer();
	}

}
