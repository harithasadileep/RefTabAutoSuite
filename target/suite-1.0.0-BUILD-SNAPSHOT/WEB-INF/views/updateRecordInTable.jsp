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
</head>
<body>
	<div id="main">
		<form:form name="updateRecordInTableForm" method="POST"
			action="/suite/updateRecordInTable">
			<div id="table-scroll" style="overflow-x: auto;">
				<table id="dataTable">
					<tr>
						<c:set var="recordObj" value="${recordObjectList[0]}" />
						<c:forEach items="${recordObj.columnObjectList}" var="columnObj">
							<th>${columnObj.columnName}</th>
						</c:forEach>
					</tr>
					<c:forEach items="${recordObjectList}" var="recordObject"
						varStatus="recordLoop">
						<tr>
							<c:forEach items="${recordObject.columnObjectList}"
								var="columnObject" varStatus="columnLoop">
								<td><input type="text"
									name="${columnObject.columnName}_${recordLoop.index}_${columnLoop.index}"
									id="${columnObject.columnName}_${recordLoop.index}_${columnLoop.index}"
									value="${columnObject.columnValue}" /></td>
							</c:forEach>
						</tr>
					</c:forEach>
				</table>
			</div>
			<input type="submit" value="Update" />
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