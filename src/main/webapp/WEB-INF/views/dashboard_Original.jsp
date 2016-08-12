<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ include file="Header.jsp"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<html>
<head>
<!-- <link rel="stylesheet" type="text/css" href="resources/css/myStyle.css" /> -->
<link rel="stylesheet" type="text/css" href="resources/css/dashboardSample.css" />
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title></title>
<script language="javascript">
	function validateForm() {
		var operation = document.getElementById('selectedAction').value;
		if ("action" == operation) {
			alert('Please select an operation...');
			return false;
		}
	}
	/* function addRow(tableID, columnList) {
		var columnList = [ "CODE", "DESCRIPTION" ];
		var table = document.getElementById(tableID);
		var rowCount = table.rows.length;
		var row = table.insertRow(rowCount);
		var i = 0;
		for (i = 0; i < columnList.length; i++) {
			var columnName = columnList[i];
			var cell = row.insertCell(i);
			var element = document.createElement("input");
			element.type = "text";
			element.name = columnName + "_" + rowCount + "_" + i;
			element.id = columnName + "_" + rowCount + "_" + i;
			cell.appendChild(element);
		}
		var rowCountElement = document.getElementById('numOfRecords');
		rowCountElement.value = rowCount;
	} */
	/* window.onload = function() {
		alert('Hi : ');
		var val = ${selectedAction};
		if (val != null) {
			document.getElementById('selectedAction').value = val;
		}
	} */
</script>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
<script>
$(document).ready(
		function() {

			/* $('#environmentSelect').on(
					'change',
					function() {
						$(".operationSelectSelectError").hide();
						var name = $("#environmentSelect option:selected")
								.text();
						if (name == '') {
							$(".environmentSelectError").css("display",
									null ? "none" : "inline");
							return false;
						} else {
							$(".environmentSelectError").hide();
						}
					}); */

			/* $('#selectedAction').on(
					'change',
					function() {
						$(".environmentSelectError").hide();
						var name = $("#selectedAction option:selected")
								.text();
						if (name == '') {

							$(".operationSelectSelectError").css("display",
									null ? "none" : "inline");

							return false;
						} else {
							$(".operationSelectSelectError").hide();
						}
					}); */
			
			
			
			$('#nextBtn').click(function() {

				$(".environmentSelectError").hide();
				$(".operationSelectSelectError").hide();
				
				var name = $("#environmentSelect option:selected")
				.text();
				if (name != '') {
					var nameOperation = $("#selectedAction option:selected")
					.text();
					if(nameOperation !=''){
						return true;
						
					}else{
						$(".operationSelectSelectError").css("display",
								null ? "none" : "inline");
						return false;
					}
					
				} else {
					$(".environmentSelectError").css("display",
							null ? "none" : "inline");
					return false;
				}

			});
			

		});


</script>
</head>
<body>
	<div id="main">
	
	
		<form:form name="environmentForm" method="POST"
			action="/suite/collectDetails" onsubmit="return validateForm()">
			<table>
				<tr>
					<td><label class="label">Environment : </label></td>
					<td><select name="environment" id="environmentSelect">
							<option value="DEV">DEV<option value="SIT">SIT<option value="UAT">UAT</select> <input type="hidden" name="environment" id="environment"></td>
				</tr>
				<tr>
					<td><label>Operation : </label></td>
					<td><select id="selectedAction" name="selectedAction">
							<!-- onchange="document.environmentForm.submit()" -->
							<option value="Update">Update an existing table<option value="Create">Create a new table</select> <input type="hidden" name="selectedAction" id="selectedAction"
						value="0" /></td>
				</tr>
			</table>
			<input type="submit" value="next" id="nextBtn" />
			<span class="operationSelectSelectError"
				style="color: Red; display: none">${errorMessageBean.operationDropDownErrMsg}
			</span>
			<%-- <span class="environmentSelectError"
				style="color: Red; display: none"><%=session.getAttribute("environmentDropDownErrMsg")%>
			</span> --%>
			<span class="environmentSelectError"
				style="color: Red; display: none">${errorMessageBean.environmentDropDownErrMsg}
			</span>
		</form:form>

		<%-- <c:choose>
			<c:when test="${not empty tableList}">
				<form:form name="updateExistingTableForm" method="POST"
					commandName="tableBean" action="/suite/updateExistingTable">
					<table id="dataTable">
						<tr>
							<td>Table :</td>
							<td><form:select path="tableName">
									<form:option value="" label="Please select table" />
									<form:options items="${tableList}" />
								</form:select> <input type="hidden" name="tableName" id="tableName"></td>
						</tr>
						<tr>
							<td>Operation :</td>
							<td><form:select path="operationName"
									onchange="document.updateExistingTableForm.submit()">
									<form:option value="" label="Please select operation" />
									<form:options items="${operationList}" />
								</form:select> <input type="hidden" name="operationName" id="operationName"></td>
						</tr>
					</table>
					<input type="submit" value="Next" />
					<input type="button" value="Home"
						onclick="window.location.href='/suite/dashboard'" />
				</form:form>
			</c:when>
		</c:choose> --%>

		<%-- <c:choose> --%>
		<%-- <c:if test="${columnList.size() > 0}">
			<form:form name="insertRecordIntoTableForm" method="POST"
					action="/suite/insertRecordIntoTable">
					<h3>${tableName}</h3>
					<table id="dataTable">
						<tr>
							<c:forEach items="${columnList}" var="columnName">
								<td>${columnName}</td>
							</c:forEach>
							<td><input type="button" value="Add Row"
								onclick="addRow('dataTable','${columnList}')" /></td>
						</tr>
						<tr>
							<c:forEach items="${columnList}" var="columnName"
								varStatus="loop">
								<td><input type="text" name="${columnName}_1_${loop.index}"
									id="${columnName}_1_${loop.index}" /></td>
							</c:forEach>
						</tr>
					</table>
					<input type="hidden" name="numOfRecords" id="numOfRecords"
						value="1" />
					<input type="submit" value="Insert" />
					<input type="button" value="Back"
						onclick="window.location.href='/suite/dashboard'" />
				</form:form>
				<c:choose>
					<c:when test="${not empty path}">
						<p style="color: green;">Script Generated at : ${path}</p>
					</c:when>
				</c:choose>
			</c:if> --%>
		<%-- </c:choose> --%>
	</div>
</body>
</html>
<%@ include file="Footer.jsp"%>