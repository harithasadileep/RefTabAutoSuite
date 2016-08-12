<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ include file="Header.jsp"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page isELIgnored="false"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<html>
<head>
<link rel="stylesheet" type="text/css" href="resources/css/myStyle.css" />
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title></title>
<script language="javascript">
	function toJavascript(javaArrayList) {
		var array = javaArrayList;
		array = array.replace("[", "");
		array = array.replace("]", "");
		array = array.replace(" ", "");
		return array.split(",");
	}
	function addRow(tableID, columnListArg) {
		var columnList = toJavascript(columnListArg);
		var table = document.getElementById(tableID);
		var rowCount = table.rows.length;
		var row = table.insertRow(rowCount);
		for (var i = 0; i < columnList.length; i++) {
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
	}
</script>
</head>
<body>
	<div id="main">
		<form:form name="insertRecordIntoTableForm" method="POST"
			action="/suite/insertRecordIntoTable">
			<h4>${tableName}</h4>
			<div id="table-scroll" style="overflow-x: auto;">
				<table id="dataTable">
					<tr>
						<c:forEach items="${columnList}" var="columnName">
							<th>${columnName}</th>
						</c:forEach>
						<td><input type="button" value="Add Row"
							onclick="addRow('dataTable','${columnList}')" /></td>
					</tr>
					<tr>
						<c:forEach items="${columnList}" var="columnName" varStatus="loop">
							<td><input type="text" name="${columnName}_1_${loop.index}"
								id="${columnName}_1_${loop.index}" /></td>
						</c:forEach>
					</tr>
				</table>
			</div>
			<input type="hidden" name="numOfRecords" id="numOfRecords" value="1" />
			<input type="submit" value="Insert" />
			<input type="button" value="Home"
				onclick="window.location.href='/suite/dashboard'" />
		</form:form>
	</div>
	<c:choose>
		<c:when test="${not empty path}">
			<p style="color: green;">Script Generated at : ${path}</p>
		</c:when>
	</c:choose>
</body>
</html>
<%@ include file="Footer.jsp"%>