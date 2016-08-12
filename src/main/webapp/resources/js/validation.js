function clearMainTable() {
	$('[name=environment] option').filter(function() {
		return ($(this).val() == 'DEV');
	}).prop('selected', true);
	$('[name=selectedAction] option').filter(function() {
		return ($(this).val() == 'Sample');
	}).prop('selected', true);
}
function table2Clear() {
	$('#table2 tr td input').val('');
	$('[name=operationName] option').filter(function() {
		return ($(this).val() == 'Sample');
	}).prop('selected', true);
}
function table3Clear() {
	var size = $("#table3 tr").length;
	size = size - 1;
	if (size > 2) {
		deleterowsTable3();
	}
	$('#table3 tr td input').val('');
	$('[name=columnDataType_1] option').filter(function() {
		return ($(this).text() == 'VARCHAR');
	}).prop('selected', true);
	$('[name=nullsAllowed_1] option').filter(function() {
		return ($(this).val() == 'sampleAllowNulls');
	}).prop('selected', true);
}
function deleterowsTable3() {
	var size = $("#table3 tr").length;
	for (var i = 2; i < size; i++) {
		alert($("#table3 tr:eq(" + i + ")"))
		$("#table3 tr:eq(" + i + ")").remove();
		if (size == 2) {
			break;
		} else {
			deleterowsTable3();
		}
	}
}
function clearTable4() {
	$('#table4 tr td input').val('');
	$('[name=columnDType_1] option').filter(function() {
		return ($(this).text() == 'VARCHAR');
	}).prop('selected', true);
	$('[name=nullsAllowed_1] option').filter(function() {
		return ($(this).val() == 'sampleAllowNulls');
	}).prop('selected', true);
	var size = $("#table4 tr").length;
	if (size > 4) {
		deleterowsTable4();
	}
}
function deleterowsTable4() {
	var size = $("#table4 tr").length;
	for (var i = 4; i < size; i++) {
		alert($("#table4 tr:eq(" + i + ")"))
		$("#table4 tr:eq(" + i + ")").remove();
		if (size == 4) {
			break;
		} else {
			deleterowsTable4();
		}
	}
}
function table5Clear() {
	$('#table5 tr td input').val('');
	var size = $("#table5 tr").length;
	for (var i = 2; i < size; i++) {
		$("#table5 tr:eq(" + i + ")").remove();
		if (size == 2) {
			break;
		} else {
			table5Clear();
		}
	}
}
function validateFields_updateExistingTable() {
	$(".tableNameError").hide();
	if ($('#tableName').val() != '') {
		if ($("#operationName option:selected").text() == '') {
			$(".operationNameError").css("display", null ? "none" : "inline");
			return false;
		} else {
			$(".operationNameError").hide();
			return true;
		}
	} else {
		$(".tableNameError").css("display", null ? "none" : "inline");
		return false;
	}
}
function validateFieldsonInsertNewRecords() {
	var length = $("#table5 > tbody > tr td").siblings().children().length;
	length = length - 1;
	for (var i = 0; i <= length; i++) {
		var value = $("#table5 > tbody > tr td").siblings().children()[i].value;
		if (value == '') {
			var id = $("#table5 > tbody > tr td").siblings().children()[i].id;
			$('#' + id).focus();
			$(".userInputsError").css("display", null ? "none" : "inline");
			return false;
		}
		
	}
	return true
}
function addRow(tableID, columnListArg) {
	$(".userInputsError").hide();
	$(".checkBocSelectError").hide();
	var table = document.getElementById(tableID);
	var length = $("#table5 > tbody > tr td").siblings().children().length;
	length = length - 1;
	for (var i = 0; i <= length; i++) {
		var value = $("#table5 > tbody > tr td").siblings().children()[i].value;
		if (value == '') {
			var id = $("#table5 > tbody > tr td").siblings().children()[i].id;
			$('#' + id).focus();
			$(".userInputsError").css("display", null ? "none" : "inline");
			return false;
		}
	}
	var columnList = columnListArg;
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
function validateFeilds() {
	$(".errorColumnName").hide();
	$(".errorSelect").hide();
	$(".error").hide();
	$(".tableDescError").hide();
	$(".tableNameError").hide();

	var tableName = $('#tableName_newtable').val();
	if (tableName != '') {
		var tableDesc = $('#tableDesc_newtable').val();
		if (tableDesc != '') {
			var length = $("#table4 > tbody > tr").length;
			length = length - 3;
			for (var i = 1; i <= length; i++) {
				var columnName = $('#columnNm_' + i).val();
				if (columnName != '') {
					var selectValue = $(
							"#columnDType_" + i + " option:selected").text();
					if (selectValue != '') {
						var maxLength = $('#columnMaxLen_' + i).val();
						if (maxLength != '') {
							i = i;
							if (i == length) {
								return true;
							}
						} else {
							$(".error")
									.css("display", null ? "none" : "inline");
							return false;
						}
					} else {
						$(".errorSelect").css("display",
								null ? "none" : "inline");
						return false;
					}
				} else {
					$(".errorColumnName").css("display",
							null ? "none" : "inline");
					return false;
				}
			}
		} else {
			$(".tableDescError").css("display", null ? "none" : "inline");
			return false;
		}
	} else {
		$(".tableNameError").css("display", null ? "none" : "inline");
		return false;
	}
}
function addMoreColumn(tableID) {
	var table = document.getElementById(tableID);
	var rowCount = table.rows.length;
	var row = table.insertRow(rowCount);
	var cell1 = row.insertCell(0);
	var element1 = document.createElement("input");
	element1.type = "text";
	element1.name = "columnName_" + rowCount;
	element1.id = "columnName_" + rowCount;
	cell1.appendChild(element1);
	var cell2 = row.insertCell(1);
	var myOptions = {
		value14 : 'BFILE',
		value13 : 'BLOB',
		value6 : 'CLOB',
		value10 : 'DATE',
		value11 : 'INTERVAL',
		value16 : 'LONG',
		value4 : 'NCHAR',
		value7 : 'NCLOB',
		value9 : 'NUMBER',
		value5 : 'NVARCHAR2',
		value15 : 'RAW',
		value12 : 'TIMESTAMP',
		value2 : 'VARCHAR',
		value3 : 'VARCHAR2'
	};
	var element2 = document.createElement("select");
	$.each(myOptions, function(val, text) {
		var option22 = document.createElement('option');
		option22.value = val;
		option22.text = text;
		element2.appendChild(option22);
	});
	element2.name = "columnDataType_" + rowCount;
	element2.id = "columnDataType_" + rowCount;
	cell2.appendChild(element2);
	$('select option[value=value2]').attr("selected", true);
	var cell3 = row.insertCell(2);
	var element3 = document.createElement("input");
	element3.type = "text";
	element3.name = "columnMaxLength_" + rowCount;
	element3.id = "columnMaxLength_" + rowCount;
	element3.classNme
	cell3.appendChild(element3);
	var cell4 = row.insertCell(3);
	var element4 = document.createElement("select");
	var option40 = document.createElement('option');
	option40.value = 'selectValue';
	option40.text = '--Select--';
	element4.appendChild(option40);
	var option41 = document.createElement('option');
	option41.value = 'Y';
	option41.text = 'Yes';
	element4.appendChild(option41);
	var option42 = document.createElement('option');
	option42.value = 'N';
	option42.text = 'No';
	element4.appendChild(option42);
	element4.name = "nullsAllowed_" + rowCount;
	element4.id = "nullsAllowed_" + rowCount;
	cell4.appendChild(element4);
	var rowCountElement = document.getElementById('numOfRows');
	rowCountElement.value = rowCount;
}
function addMoreColumnForNewTable(tableID) {
	var table = document.getElementById(tableID);
	var rowCount = table.rows.length;
	var row = table.insertRow(rowCount);
	var loop = rowCount - 2;
	var cell1 = row.insertCell(0);
	var element1 = document.createElement("input");
	element1.type = "text";
	element1.name = "columnNm_" + loop;
	element1.id = "columnNm_" + loop;
	cell1.appendChild(element1);
	var cell2 = row.insertCell(1);
	var myOptions = {
		value14 : 'BFILE',
		value13 : 'BLOB',
		value6 : 'CLOB',
		value10 : 'DATE',
		value11 : 'INTERVAL',
		value16 : 'LONG',
		value4 : 'NCHAR',
		value7 : 'NCLOB',
		value9 : 'NUMBER',
		value5 : 'NVARCHAR2',
		value15 : 'RAW',
		value12 : 'TIMESTAMP',
		value2 : 'VARCHAR',
		value3 : 'VARCHAR2'
	};
	var element2 = document.createElement("select");
	$.each(myOptions, function(val, text) {
		var option22 = document.createElement('option');
		option22.value = val;
		option22.text = text;
		element2.appendChild(option22);
	});
	element2.name = "columnDType_" + loop;
	element2.id = "columnDType_" + loop;
	cell2.appendChild(element2);
	$('select option[value=value2]').attr("selected", true);
	var cell3 = row.insertCell(2);
	var element3 = document.createElement("input");
	element3.type = "text";
	element3.name = "columnMaxLen_" + loop;
	element3.id = "columnMaxLen_" + loop;
	element3.className = "number_1" + loop;
	cell3.appendChild(element3);
	var cell4 = row.insertCell(3);
	var element4 = document.createElement("select");
	var option40 = document.createElement('option');
	option40.value = 'select';
	option40.text = '--select--';
	element4.appendChild(option40);
	var option41 = document.createElement('option');
	option41.value = 'Y';
	option41.text = 'Yes';
	element4.appendChild(option41);
	var option42 = document.createElement('option');
	option42.value = 'N';
	option42.text = 'No';
	element4.appendChild(option42);
	element4.name = "nullsAllow_" + loop;
	element4.id = "nullsAllow_" + loop;
	cell4.appendChild(element4);
	var rowCountElement = document.getElementById('numOfRows');
	rowCountElement.value = rowCount;
}
