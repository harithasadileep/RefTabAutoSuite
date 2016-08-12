<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
  <!DOCTYPE html>
  <%@ include file="Header.jsp"%>
    <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
      <%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
        <html>
          <head>
            <link rel="stylesheet" type="text/css" href="resources/css/dashboardSample.css" />
            <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
            <title>
            </title>
            <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
            <script   type="text/javascript" src="<c:url value="/resources/js/documentReady.js" />" ></script>
            <script  type="text/javascript"  src="<c:url value="/resources/js/validation.js"/>"></script>
            <script  type="text/javascript"  src="<c:url value="/resources/js/documentOn.js"/>"></script>
          </head>
          <body>
            <div id="main" >
              <form:form name="environmentForm" method="POST">
                <div id="mainTableDiv">
                  <table id="mainTable" align="center">
                    <tr>
                      <td>
                        <label class="label">Environment : 
                        </label>
                      </td>
                      <td>
                        <select name="environment" id="environmentSelect"></select> 
                        <input type="hidden" name="environment" id="environment">
                      </td>
                    </tr>
                    <tr>
                      <td>
                        <label>Operation:
                        </label>
                      </td>
                      <td>
                        <select id="selectedAction" name="selectedAction"> </select> 
                      </td>
                    </tr>
                  </table>
                </div>
                <div id="table2Div" style="display:none">
                  <table id="table2" align="center">
                    <tr>
                      <td>
                        <label> Table Name :
                        </label>
                      </td>
                      <td>
                        <input type="text" name="tableName" id="tableName" />
                      </td>
                    </tr>
                    <tr>
                      <td>
                        <label>Operation: 
                        </label>
                      </td>
                      <td>
                        <select name="operationName" id="operationName">
                        </select> 
                      </td>
                    </tr>
                  </table>
                  <input type="button" value="Home" id="home1"
                         onclick="window.location.href='/suite/dashboard'" />
                </div>
                <span class="environmentSelectError"
                      style="color: Red; display: none">${errorMessageBean.environmentDropDownErrMsg}
                </span>
                <div id="table3Div"  style="display:none">
                  <table id="table3" align="center" >
                    <tr id="trAddCol">
                      <th>
                        <label for="table3Lbl"> Column Name 
                        </label>
                      </th>
                      <th>
                        <label for="table3Lbl"> Data Type 
                        </label>
                      </th>
                      <th>
                        <label for="table3Lbl"> Max Length 
                        </label>
                      </th>
                      <th><label for="table3Lbl" > Null Allowed </label></th>
                    </tr>
                    <tr>
                      <td>
                        <input type="text" name="columnName_1" id="columnName_1" />
                      </td>
                      <td>
                        <select name="columnDataType_1" id="columnDataType_1">
                        </select> 
                      </td>
                      <td>
                        <input type="text" name="columnMaxLength_1"
                               id="columnMaxLength_1" class="numeric_1" />
                      </td>
                      <td>
                        <select name="nullsAllowed_1" id="nullsAllowed_1">
                          <option value="sampleAllowNulls">--Select--<option value="Y">Yes<option value="N">No</select> 
                      </td>
                    </tr>
                  </table>
                  <div id="table3BtnsDiv" style="margin-left:180px">
                    <input type="hidden" name="numOfRows" id="numOfRows" value="1" />
                    <input type="button" value="Generate" id="addColumnSubmitBtn" />
                    <input type="button" value="Add" id="addNewColumn" />
                    <input type="button" value="Home" id="home"
                           onclick="window.location.href='/suite/dashboard'" />
                  </div>
                </div>
                <div id="table4Div" style="margin-left:100px; margin-right:100px;overflow-x:scroll; display:none">
                  <table id="table4" align="center" >
                    <tr>
                      <th>
                        <label style="text-align:right">Table Name :
                        </label>
                      </th>
                      <td>
                        <input type="text" id="tableName_newtable" name="tableName_newtable" />
                      </td>
                    </tr>
                    <tr>
                      <th>
                        <label style="text-align:right">Table Description :
                        </label>
                      </th>
                      <td>
                        <input type="text" id="tableDesc_newtable" name="tableDesc_newtable" />
                      </td>
                    </tr>
                    <tr>
                      <th>
                        <label style="text-align:center"> Column Name 
                        </label>
                      </th>
                      <th>
                        <label style="text-align:center"> Data Type 
                        </label>
                      </th>
                      <th>
                        <label style="text-align:center"> Max Length 
                        </label>
                      </th>
                      <th>
                        <label style="text-align:center"> Null Allowed 
                        </label>
                      </th>
                    </tr>
                    <tr>
                      <td>
                        <input type="text" name="columnNm_1" id="columnNm_1" />
                      </td>
                      <td>
                        <select name="columnDType_1" id="columnDType_1">
                        </select> 
                      </td>
                      <td>
                        <input type="text" name="columnMaxLen_1"
                               id="columnMaxLen_1" class="number_1" />
                      </td>
                      <td>
                        <select name="nullsAllow_1" id="nullsAllow_1">
                          <option value="sampleAllowNulls">--Select--<option value="Y">Yes<option value="N">No</select> 
                      </td>
                    </tr>
                  </table>
                  <div id="table4BtnDiv" style="margin-left:180px">
                    <input type="hidden" name="numOfRows" id="numOfRows" value="1" />
                    <input type="button" value="Generate" id="createBtn" />
                    <input type="button" value="Add" id="addColumnsBtnForNewTable" />
                    <input type="button" value="Home"
                           onclick="window.location.href='/suite/dashboard'" />
                  </div>
                </div>
                <div id="deleteTableDiv" class="deleteTableDivClass" style="margin-left:100px; margin-right:100px;overflow-x:scroll; display:none">
                </div>
                <div id="dataTableDiv"  style="margin-left:100px; margin-right:100px;overflow-x:scroll; display:none">
                </div>
                <div id="table5Div"   style="margin-left:100px; margin-right:100px;overflow-x:scroll; display:none">
                </div>
                <p id="scriptGen" style="color: green; display:none ; word-break:break-all"/>
                <center>
                  <label class="errorSelect" style="color: Red; display: none">${errorMessageBean.dataTypeDropDownErrMsg}
                  </label>
                  <label class="tableNameError" style="color: Red; display: none">${errorMessageBean.tableNameErrorMsg}
                  </label> 
                  <label class="tableDescError" style="color: Red; display: none">${errorMessageBean.tableDescErrorMsg}
                  </label> 
                  <label class="errorColumnName" style="color: Red; display: none">${errorMessageBean.columnNameErrMsg}
                  </label> 
                  <label class="error" style="color: Red; display: none">
                    ${errorMessageBean.numericErrMsg} 
                  </label>
                  <label class="codeValueError" style="color: Red; display: none">${errorMessageBean.codeValueErrMsg}
                  </label>
                  <label class="checkBocSelectError" style="color: Red; display: none">${errorMessageBean.checkBocSelectError}
                  </label>
                    <label class="userInputsError" style="color: Red; display: none">${errorMessageBean.userInputsError}
                  </label>
                </center>
              </form:form>
            </div>
          </body>
        </html>
        <%@ include file="Footer.jsp"%>
