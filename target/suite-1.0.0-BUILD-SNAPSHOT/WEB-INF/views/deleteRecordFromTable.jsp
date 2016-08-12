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
<script type="text/javascript">
	function validateForm() {
		var codeVal = document.getElementById('codeValue').value;
		if ('' == codeVal) {
			alert('Please provide code value...');
			return false;
		}
	}
</script>

<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
<script>
	$(document).ready(function() {
		$('#deleteBtn').click(function() {
			
			var name = $('#codeValue').val();
			if (name == '') {
				$(".codeValueError").css("display",
						null ? "none" : "inline");
				return false;
			} else {
				return true;
			}

		});
		

	});
</script>
</head>
<body>
	<div id="main">
		<form:form name="deletRecordFromTableForm" method="POST"
			action="/suite/deleteRecordFromTable"
			>
			<table id="dataTable">
				<tr>
					<td><label> Code Value : </label></td>
					<td><input type="text" name="codeValue" id="codeValue" /></td>
				</tr>
			</table>
			<input type="submit" value="Delete" id="deleteBtn" />
			<input type="button" value="Home"
				onclick="window.location.href='/suite/dashboard'" />
				<span class="codeValueError"
				style="color: Red; display: none">${errorMessageBean.codeValueErrMsg}
			</span>
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