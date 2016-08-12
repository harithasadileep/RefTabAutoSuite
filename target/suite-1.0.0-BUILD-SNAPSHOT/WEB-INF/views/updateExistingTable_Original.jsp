<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ include file="Header.jsp"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<html>
<head>
<link rel="stylesheet" type="text/css" href="resources/css/myStyle.css" />
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title></title>
<script type="text/javascript">
	/* function validateForm() {
		var table = document.getElementById('tableName').value;
		var operation = document.getElementById('operationName').value;
		if ('' == table || '' == operation) {
			alert('Please select form values...');
			return false;
		}
	} */
	
	function validateFields(){
		
		$(".tableNameError").hide();
		if($('#tableName').val() !=''){
			if ($("#operationName option:selected")
					.text() == '') {
				$(".operationNameError").css("display",
						null ? "none" : "inline");
				return false;
			} else {
				$(".operationNameError").hide();
				return true;
			}
		}else{
			$(".tableNameError").css("display",
					null ? "none" : "inline");
			return false;
		}
	}
</script>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
<script>
$(document).ready(
		function() {
			var myOptions = {
					Add    : 'Add new column',
					Insert : 'Insert a record',
					Update : 'Update a record',
					Delete : 'Delete a record'
				};
				var _select = $('<select>');
				$.each(myOptions, function(val, text) {
					_select.append($('<option></option>').val(val).html(text));
				});
				$('#operationName').append(_select.html());
				
				 $('#tableName').on(
						'change',
						function() {
							validateFields();
							
						});
				
						$('#nextBtn').click(
						function() {
							if(!validateFields()){
								return false;
							}
							
						}); 
				
				
			
		});
</script>
</head>
<body>
	<div id="main">
		<form:form name="updateExistingTableForm" method="POST"
			action="/suite/updateExistingTable" >
			<table id="dataTable">
				<tr>
					<td><label> Table Name </label></td>
					<td><input type="text" name="tableName" id="tableName" /></td>
				</tr>
				<tr>
					<td><label>Operation : </label></td>
					<td><select name="operationName" id="operationName"></select>
						<!-- <option value=""><option value="Add">Add new column<option value="Insert">Insert a record<option value="Update">Update a record<option value="Delete">Delete a record</select> <input type="hidden" name="operationName" id="operationName" /> -->
					</td>
				</tr>
			</table>
			<input type="submit" value="next" id="nextBtn" />
			<input type="button" value="Home"
				onclick="window.location.href='/suite/dashboard'" />
			<span class="operationNameError" style="color: Red; display: none">${errorMessageBean.operationNameErrorMsg}
			</span>
			<span class="tableNameError" style="color: Red; display: none">${errorMessageBean.tableNameErrorMsg}
			</span>
		</form:form>
	</div>
</body>
</html>
<%@ include file="Footer.jsp"%>