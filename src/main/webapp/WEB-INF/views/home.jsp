<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ include file="Header.jsp"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title></title>
</head>
<body>
	<form:form method="post" action="processTable" commandName="tableBean">
		<table>
			<tr>
				<td>Table</td>
				<td><form:select path="tableName">
						<form:option value="" label="Please select table" />
						<form:options items="${tableList}" />
					</form:select></td>
			</tr>
			<tr>
				<td></td>
				<td><input type="submit"></td>
			</tr>
		</table>
	</form:form>
</body>
	</html>
<%@ include file="Footer.jsp"%>