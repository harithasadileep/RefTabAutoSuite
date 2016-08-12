$(document)
		.ready(
				function() {
					var myOptions_operation = {
						Sample : 'Select Operation',
						Update : 'Update an existing table',
						Create : 'Create a new table',
					};
					var _select = $('<select>');
					$.each(myOptions_operation, function(val, text) {
						_select.append($('<option></option>').val(val).html(
								text));
					});
					$('#selectedAction').append(_select.html());
					var myOptions_envi = {
						DEV : 'DEV',
						SIT : 'SIT',
						UAT : 'UAT',
					};
					var _select = $('<select>');
					$.each(myOptions_envi, function(val, text) {
						_select.append($('<option></option>').val(val).html(
								text));
					});
					$('#environmentSelect').append(_select.html());
					$('#operationName')
							.on(
									'change',
									function() {
										var operationNm = $(
												"#operationName option:selected")
												.text();
										var tableName = $('#tableName').val();
										var operationName = $("#operationName")
												.val();
										var params = {
											tableName : tableName,
											operationName : operationName
										}
										if (operationNm == 'Add new column') {
											$(".userInputsError").hide();
											$(".checkBocSelectError").hide();

											if (validateFields_updateExistingTable()) {
												var tableName = $('#tableName')
														.val();
												var operationName = $(
														"#operationName").val();
												var params = {
													tableName : tableName,
													operationName : operationName
												}
												$
														.ajax({
															type : "POST",
															contentType : "application/json;",
															accept : "application/json;",
															url : "/suite/updateExistingTable",
															data : JSON
																	.stringify(params),
															success : function(
																	response) {
																var error = response.errorMessageBean;
																table3Clear();
																$('#home1')
																		.hide();
																$(
																		".errorColumnName")
																		.hide();
																$(
																		".errorSelect")
																		.hide();
																$(".error")
																		.hide();
																$(
																		".tableDescError")
																		.hide();
																$(
																		".tableNameError")
																		.hide();
																$('#table4Div')
																		.css(
																				'display',
																				'none');
																$(
																		'#dataTableDiv')
																		.css(
																				'display',
																				'none');
																$(
																		'#deleteTableDiv')
																		.css(
																				'display',
																				'none');
																$('#table5Div')
																		.css(
																				'display',
																				'none');
																$('#btnDiv')
																		.css(
																				'display',
																				'none');
																$('#table3Div')
																		.css(
																				'display',
																				'inline');
															},
															error : function() {
																alert('Error occured');
															}
														});
											} else {
												return false;
											}
										} else if (operationNm == 'Delete a record') {
											$('#deleteTableDiv').empty();
											$('#deleteTableDiv').hide();
											$(".userInputsError").hide();
											$(".checkBocSelectError").hide();
											$.ajax({
														type : "POST",
														contentType : "application/json;",
														accept : "application/json;",
														url : "/suite/updateExistingTable",
														data : JSON
																.stringify(params),
														async : false,
														success : function(
																response) {
															$('#deleteTableDiv')
																	.append(
																			'<table id="deleteTable"  cellpadding="0px" cellspacing="0px" >');
															$('#deleteTable')
																	.append(
																			'<tr>');
															var thContents = "";
															var records = response["recordObjectList"][0]["columnObjectList"];
															var recordsForSecondLoop = response.recordObjectList[0]['columnObjectList'];
															$
																	.each(
																			records,
																			function(
																					index,
																					value) {
																				thContents += "<th>"
																						+ value["columnName"]
																						+ "</th>";
																			});
															$('#deleteTable tr')
																	.append(
																			thContents)
															$('#deleteTable')
																	.append(
																			'</tr>');
															var rowsList = response["recordObjectList"];
															$
																	.each(
																			rowsList,
																			function(
																					index,
																					value) {
																				$(
																						'#deleteTable')
																						.append(
																								'<tr>');
																				var tdContenets = "";
																				$
																						.each(
																								value["columnObjectList"],
																								function(
																										colIndex,
																										colValue) {
																									tdContenets += "<td><input type='text' "
																											+ " name= "
																											+ colValue['columnName']
																											+ "_"
																											+ index
																											+ "_"
																											+ colIndex
																											+ " id= "
																											+ colValue['columnName']
																											+ "_"
																											+ index
																											+ "_"
																											+ colIndex
																											+ " value= "
																											+ colValue["columnValue"]
																											+ " /></td>"
																								});
																				var abc = tdContenets;
																				$(
																						'#deleteTable tr:last')
																						.append(
																								tdContenets)
																				$(
																						'#deleteTable tr:last')
																						.append(
																								"<td><input type='checkbox' name='deleteCheck' class='deleteCheckClass' /></td>");
																			});
															$('#deleteTableDiv')
																	.append(
																			'</table>');
															$('#deleteTableDiv')
																	.append(
																			"<input type='button' value='Delete' id='deleteBtn' />");
															$('#deleteTableDiv')
																	.append(
																			"	<input type='button' value='Home' onclick='window.location.href=\"/suite/dashboard\"' /> ");
															$('#deleteTableDiv')
																	.show();
															var error = response.errorMessageBean;
															$('#home1').hide();
															$('#table3Div')
																	.css(
																			'display',
																			'none');
															$('#table4Div')
																	.css(
																			'display',
																			'none');
															$('#table5Div')
																	.css(
																			'display',
																			'none');
															$('#btnDiv').css(
																	'display',
																	'none');
															$('#dataTableDiv')
																	.css(
																			'display',
																			'none');
															$('#scriptGen')
																	.hide();
														},
														error : function() {
															alert('Error occured');
														}
													});
										} else if (operationNm == 'Update a record') {
											$('#deleteTable').empty();
											$('#deleteTableDiv').empty();
											$('#dataTable').empty();
											$('#dataTableDiv').empty();
											$('#deleteTable').hide();
											$('#deleteTableDiv').hide();
											$(".userInputsError").hide();
											$(".checkBocSelectError").hide();
											$
													.ajax({
														type : "POST",
														contentType : "application/json;",
														accept : "application/json;",
														url : "/suite/updateExistingTable",
														data : JSON
																.stringify(params),
														success : function(
																response) {
															$('#dataTableDiv')
																	.append(
																			'<table id="dataTable"  cellpadding="0px" cellspacing="0px" >');
															$('#dataTable')
																	.append(
																			'<tr>');
															var thContents = "";
															var records = response["recordObjectList"][0]["columnObjectList"];
															var recordsForSecondLoop = response.recordObjectList[0]['columnObjectList'];
															$
																	.each(
																			records,
																			function(
																					index,
																					value) {
																				thContents += "<th>"
																						+ value["columnName"]
																						+ "</th>";
																			});
															$('#dataTable tr')
																	.append(
																			thContents)
															$('#dataTable')
																	.append(
																			'</tr>');
															var rowsList = response["recordObjectList"];
															$
																	.each(
																			rowsList,
																			function(
																					index,
																					value) {
																				$(
																						'#dataTable')
																						.append(
																								'<tr>');
																				var tdContenets = "";
																				$
																						.each(
																								value["columnObjectList"],
																								function(
																										colIndex,
																										colValue) {
																									tdContenets += "<td><input type='text' "
																											+ " name= "
																											+ colValue['columnName']
																											+ "_"
																											+ index
																											+ "_"
																											+ colIndex
																											+ " id= "
																											+ colValue['columnName']
																											+ "_"
																											+ index
																											+ "_"
																											+ colIndex
																											+ " value= "
																											+ colValue["columnValue"]
																											+ " /></td>"
																								});
																				$(
																						'#dataTable tr:last')
																						.append(
																								tdContenets)
																			});
															$('#dataTableDiv')
																	.append(
																			'</table>');
															$('#dataTableDiv')
																	.append(
																			"<input type='button' value='Update' id='updateSubmit'/>");
															$('#dataTableDiv')
																	.append(
																			"	<input type='button' value='Home' onclick='window.location.href=\"/suite/dashboard\"' /> ");
															$('#dataTableDiv')
																	.show();
															var error = response.errorMessageBean;
															$('#home1').hide();
															$('#table3Div')
																	.css(
																			'display',
																			'none');
															$('#table4Div')
																	.css(
																			'display',
																			'none');
															$('#table5Div')
																	.css(
																			'display',
																			'none');
															$('#btnDiv').css(
																	'display',
																	'none');
															$('#scriptGen')
																	.hide();
														},
														error : function() {
															alert('Error occured');
														}
													});
										} else if (operationNm == 'Insert a record') {
											$('#table5Div').empty();
											$('#table5Div').hide();
											$(".userInputsError").hide();
											$(".checkBocSelectError").hide();
											$
													.ajax({
														type : "POST",
														contentType : "application/json;",
														accept : "application/json;",
														url : "/suite/updateExistingTable",
														data : JSON
																.stringify(params),
														success : function(
																response) {
															var columnList = response['columnList'];
															var columnListNew = [];
															columnListNew = response.columnList;
															$('#table5Div')
																	.append(
																			'<table id="table5"  cellpadding="0px" cellspacing="0px" >');
															$('#table5')
																	.append(
																			'<tr>');
															var thContents = "";
															$
																	.each(
																			columnList,
																			function(
																					index,
																					value) {
																				thContents += "<th>"
																						+ value
																						+ "</th>";
																			});
															$('#table5 tr')
																	.append(
																			thContents);
															$('#table5')
																	.append(
																			'<tr>');
															var tdContenets = "";
															$
																	.each(
																			columnList,
																			function(
																					index,
																					value) {
																				tdContenets += "<td><input type='text' name="
																						+ value
																						+ "_1_"
																						+ index
																						+ " id="
																						+ value
																						+ "_1_"
																						+ index
																						+ " /></td>"
																			});
															$('#table5 tr:last')
																	.append(
																			tdContenets);
															$('#table5Div')
																	.append(
																			'</table>');
															$('#table5Div')
																	.append(
																			'<div id="table5BtnDiv" style="margin-left:200px">');

															$('#table5BtnDiv')
																	.append(
																			"<input type='button' value='Generate'  id='isertSubmitBtn'/>");
															$('#table5BtnDiv')
																	.append(
																			'<input type="button" value="Add" id="addRowBtn"/>');
															$("#addRowBtn")
																	.on(
																			"click",
																			function() {
																				addRow(
																						'table5',
																						columnListNew);
																			});
															$('#table5BtnDiv')
																	.append(
																			"<input type='button' value='Home' onclick='window.location.href=\"/suite/dashboard\"' /> ");

															$('#table5Div')
																	.append(
																			'</div>');
															$('#table5Div')
																	.show();
															$('#table5BtnDiv')
																	.show();
															var error = response.errorMessageBean;
															table5Clear();
															$('#table3Div')
																	.css(
																			'display',
																			'none');
															$('#table4Div')
																	.css(
																			'display',
																			'none');
															$('#deleteTableDiv')
																	.css(
																			'display',
																			'none');
															$('#dataTableDiv')
																	.css(
																			'display',
																			'none');
															$('#home1').hide();
														},
														error : function() {
															alert('Error occured');
														}
													});
										} else if (operationNm == 'select operation') {
											table3Clear();
											clearTable4();
											$(".userInputsError").hide();
											$(".checkBocSelectError").hide();
											$('#deleteTable').empty();
											$('#dataTable').empty();
											$('#table3BtnsDiv').hide();
											$('#table4BtnDiv').hide();
											$('#dataTableBtnDiv').hide();
											$('#deleteTableBtnDiv').hide();
											$('#table5BtnDiv').hide();
											$('#deleteTableDiv').css('display',
													'none');
											$('#dataTableDiv').css('display',
													'none');
											$('#table3Div').css('display',
													'none');
											$('#table4Div').css('display',
													'none');
											$('#home1').show()();
										} else {
											return false;
										}
									});
					$('#selectedAction')
							.on(
									'change',
									function(event) {
										$(".errorColumnName").hide();
										$(".errorSelect").hide();
										$(".error").hide();
										$(".tableDescError").hide();
										$(".tableNameError").hide();
										$(".userInputsError").hide();
										$(".checkBocSelectError").hide();

										var name = $(
												"#selectedAction option:selected")
												.text();
										var selecAction = $(
												"#selectedAction option:selected")
												.val();
										var env = $("#environmentSelect").val();
										var params = {
											environment : env,
											selectedAction : selecAction
										};
										if (name == 'Update an existing table') {
											$
													.ajax({
														type : "POST",
														contentType : "application/json;",
														accept : "application/json;",
														url : "/suite/collectDetails",
														data : JSON
																.stringify(params),
														success : function(
																response) {
															var error = response.errorMessageBean;
															table2Clear();
															$('#table3Div')
																	.css(
																			'display',
																			'none');
															$('#table4Div')
																	.css(
																			'display',
																			'none');
															$('#scriptGen')
																	.hide();
															$('#table2Div')
																	.css(
																			'display',
																			'inline');
															$('#table2')
																	.css(
																			'margin-left',
																			'147px');
															$('#table2').css(
																	'position',
																	'left');
														},
														error : function() {
															alert('Error occured');
														}
													});
										} else if (name == 'Create a new table') {
											$(".userInputsError").hide();
											$(".checkBocSelectError").hide();
											$
													.ajax({
														type : "POST",
														contentType : "application/json;",
														accept : "application/json;",
														url : "/suite/collectDetails",
														data : JSON
																.stringify(params),
														success : function(
																response) {
															clearTable4();
															var error = response.errorMessageBean;
															$('#table2Div')
																	.css(
																			'display',
																			'none');
															$('#table3Div')
																	.css(
																			'display',
																			'none');
															$('#deleteTable')
																	.css(
																			'display',
																			'none');
															$('#scriptGen')
																	.hide();
															$('#table4Div')
																	.css(
																			'display',
																			'inline');
															$('#deleteTableDiv')
																	.css(
																			'display',
																			'none');
															$('#dataTableDiv')
																	.css(
																			'display',
																			'none');
															$('#table5Div')
																	.css(
																			'display',
																			'none');
														},
														error : function() {
															alert('Error occured');
														}
													});
										}
									});
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
					var _select = $('<select>');
					$.each(myOptions, function(val, text) {
						_select.append($('<option></option>').val(val).html(
								text));
					});
					$('#columnDataType_1').append(_select.html());
					$('[name=columnDataType_1] option').filter(function() {
						return ($(this).text() == 'VARCHAR');
					}).prop('selected', true);
					var _select1 = $('<select>');
					$.each(myOptions, function(val, text) {
						_select1.append($('<option></option>').val(val).html(
								text));
					});
					$('#columnDType_1').append(_select.html());
					$('[name=columnDType_1] option').filter(function() {
						return ($(this).text() == 'VARCHAR');
					}).prop('selected', true);
					$('#addColumnSubmitBtn')
							.click(
									function() {
										$(".errorColumnName").hide();
										$(".errorSelect").hide();
										$(".error").hide();
										$(".userInputsError").hide();
										$(".checkBocSelectError").hide();
										var lengthNew = $(
												"#table3 > tbody > tr td")
												.siblings().children().length;
										for (var i = 0; i < lengthNew; i++) {
											var data = $(
													"#table3 > tbody > tr td")
													.siblings().children()[i].value;
											if (data == '') {
												var id = $(
														"#table3 > tbody > tr td")
														.siblings().children()[i].id;
												$('#' + id).focus();
												$(".userInputsError").css(
														"display",
														null ? "none"
																: "inline");
												return false;
											}
										}
										var tableName = $("#tableName").val();
										var length = $("#table3 > tbody > tr").length;
										length = length - 1;
										var params = {
											numOfRows : length,
											"tableName" : tableName
										}
										for (var i = 1; i <= length; i++) {
											var columnNameVal = $(
													'#columnName_' + i).val();
											var maxlength = $(
													'#columnMaxLength_' + i)
													.val();
											var dataType = $(
													"#columnDataType_"
															+ i
															+ " option:selected")
													.text();
											var nullnotallowed = $(
													"#nullsAllowed_"
															+ i
															+ " option:selected")
													.text();
											var arr = {}
											var columnnameId = $(
													'#columnName_' + i).attr(
													'id')
											var maxlengthId = $(
													'#columnMaxLength_' + i)
													.attr('id')
											params[columnnameId] = columnNameVal
											params[maxlengthId] = maxlength;
											params['columnDataType_' + i] = dataType;
											params['nullsAllowed_' + i] = nullnotallowed;
										}
										$
												.ajax({
													type : "POST",
													contentType : "application/json;",
													accept : "application/json;",
													url : "/suite/addNewColumnIntoTable",
													data : JSON
															.stringify(params),
													success : function(response) {
														clearMainTable();
														$('#table2Div').css(
																'display',
																'none');
														$('#table3Div').css(
																'display',
																'none');
														$('#mainTableDiv').css(
																'display',
																'inline');
														$('#scriptGen').show();
														$('#scriptGen')
																.text(
																		'Script Generated at :'
																				+ response.path);
													},
													error : function() {
														alert('Error occured');
													}
												});
									});
					$('#addNewColumn').click(
							function() {
								$(".errorColumnName").hide();
								$(".errorSelect").hide();
								$(".error").hide();
								$(".userInputsError").hide();
								$(".checkBocSelectError").hide();
								var lengthNew = $("#table3 > tbody > tr td")
										.siblings().children().length;
								for (var i = 0; i < lengthNew; i++) {
									var data = $("#table3 > tbody > tr td")
											.siblings().children()[i].value;
									if (data == '') {
										var id = $("#table3 > tbody > tr td")
												.siblings().children()[i].id;
										$('#' + id).focus();
										$(".userInputsError").css("display",
												null ? "none" : "inline");
										return false;
									}
								}
								addMoreColumn('table3');
							});
					$('#columnDataType_1').on(
							'change',
							function() {
								$(".errorColumnName").hide();
								$(".errorSelect").hide();
								$(".error").hide();
								var name = $(
										"#columnDataType_1 option:selected")
										.text();
								if (name == '') {
									$(".errorSelect").css("display",
											null ? "none" : "inline");
									return false;
								}
							});
					var myOptions = {
						Sample : 'select operation',
						Add : 'Add new column',
						Insert : 'Insert a record',
						Update : 'Update a record',
						Delete : 'Delete a record'
					};
					var _select = $('<select>');
					$.each(myOptions, function(val, text) {
						_select.append($('<option></option>').val(val).html(
								text));
					});
					$('#operationName').append(_select.html());
					$('#operationName').on('change', function() {
						validateFields_updateExistingTable();
					});
					$('#nextBtn').click(function() {
						if (!validateFields_updateExistingTable()) {
							return false;
						}
					});
					$('#createBtn')
							.click(
									function() {
										if (validateFeilds()) {
											var tableName = $(
													'#tableName_newtable')
													.val();
											var tableDesc = $(
													'#tableDesc_newtable')
													.val();
											var length = $("#table4 > tbody > tr").length;
											length = length - 3;
											var params = {
												"tableName" : tableName,
												"tableDesc" : tableDesc,
												"numOfRows" : length
											};
											for (var i = 1; i <= length; i++) {
												var columnnameId = $(
														'#columnNm_' + i).attr(
														'id')
												var columnNameVal = $(
														'#columnNm_' + i).val();
												var maxlengthId = $(
														'#columnMaxLen_' + i)
														.attr('id')
												var maxlength = $(
														'#columnMaxLen_' + i)
														.val();
												var dataType = $(
														"#columnDType_"
																+ i
																+ " option:selected")
														.text();
												var nullnotallowed = $(
														"#nullsAllow_"
																+ i
																+ " option:selected")
														.text();
												params[columnnameId] = columnNameVal;
												params[maxlengthId] = maxlength;
												params['columnDType_' + i] = dataType;
												params['nullsAllow_' + i] = nullnotallowed;
											}
											$
													.ajax({
														type : "POST",
														contentType : "application/json;",
														accept : "application/json;",
														url : "suite/createNewTable",
														data : JSON
																.stringify(params),
														async : false,
														success : function(
																response) {
															clearMainTable();
															$('#table2Div')
																	.css(
																			'display',
																			'none');
															$('#table3Div')
																	.css(
																			'display',
																			'none');
															$('#table4Div')
																	.css(
																			'display',
																			'none');
															$('#table5Div')
																	.css(
																			'display',
																			'none');
															$('#mainTableDiv')
																	.css(
																			'display',
																			'inline');
															$('#scriptGen')
																	.show();
															$('#scriptGen')
																	.text(
																			'Script Generated at :'
																					+ response.path);
														},
														error : function() {
															alert('Error occured');
														}
													});
										} else {
											return false;
											;
										}
									});
					$('#addBtn').click(function() {
						if (validateFeilds()) {
							addMoreColumn('dataTable');
							return true;
						} else {
							return false;
							;
						}
					});
					$('#newTableColumnDataType_1').append(_select.html());
					$('[name=newTableColumnDataType_1] option').filter(
							function() {
								return ($(this).text() == 'VARCHAR');
							}).prop('selected', true);
					$('#addColumnsBtnForNewTable').click(function() {
						if (validateFeilds()) {
							addMoreColumnForNewTable('table4');
							return true;
						} else {
							return false;
							;
						}
					});
					$(document)
							.on(
									"click",
									"#deleteBtn",
									function() {
										$('.checkBocSelectError').hide();
										var name = $('#codeValue').val();
										if (name == '') {
											$(".codeValueError").css("display",
													null ? "none" : "inline");
											return false;
										} else {
											var finalValue = "";
											var checkedCheckboxes = $("#deleteTable :checkbox:checked");
											var tableData = {
												items : []
											};
											for (var i = 0; i < checkedCheckboxes.length; i++) {
												var checkbox = $(checkedCheckboxes[i]);
												var checkboxValue = checkbox
														.val();
												var siblings = checkbox
														.parent().siblings();
												var val = $(siblings[0])
														.children().val();
												var arr = {};
												arr['CODE'] = val;
												tableData.items.push(arr);
												finalValue = tableData;
											}
											$
													.ajax({
														type : "POST",
														contentType : "application/json;",
														accept : "application/json;",
														async : false,
														url : "/suite/deleteRecordFromTable",
														data : JSON
																.stringify(finalValue),
														success : function(
																response) {
															var error = response.errorMessageBean;
															$('#table2Div')
																	.css(
																			'display',
																			'none');
															$('#table3Div')
																	.css(
																			'display',
																			'none');
															$('#deleteTableDiv')
																	.css(
																			'display',
																			'none');
															clearMainTable();
															$('#mainTableDiv')
																	.css(
																			'display',
																			'inline');
															$('#scriptGen')
																	.show();
															$('#scriptGen')
																	.text(
																			'Script Generated at :'
																					+ response.path);
														},
														error : function() {
															$(
																	".checkBocSelectError")
																	.css(
																			"display",
																			null ? "none"
																					: "inline");
															return false;
														}
													});
										}
									});
					$(document).on(
							"click",
							"#updateSubmit",
							function() {
								var tableData = {};
								var size = $("#dataTable > tbody > tr").length
								var siblings = $("#dataTable> tbody > tr")
										.siblings()
								for (var i = 1; i < size; i++) {
									var columnsLen = $(siblings[i]).children()
											.children().length;
									var updateRow = {};
									for (var j = 0; j < columnsLen; j++) {
										var id = $(siblings[i]).children()
												.children()[j].id;
										var value = $(siblings[i]).children()
												.children()[j].value;
										tableData[id] = value;
									}
								}
								$.ajax({
									type : "POST",
									contentType : "application/json;",
									accept : "application/json;",
									async : false,
									url : "/suite/updateRecordInTable",
									data : JSON.stringify(tableData),
									success : function(response) {
										clearMainTable();
										var error = response.errorMessageBean;
										$('#table2Div').css('display', 'none');
										$('#dataTableDic').css('display',
												'none');
										$('#dataTableDiv').css('display',
												'none');
										$('#deleteTableDiv').css('display',
												'none');
										$('#mainTableDiv').css('display',
												'inline');
										$('#scriptGen').show();
										$('#scriptGen').text(
												'Script Generated at :'
														+ response.path);
									},
									error : function() {
										alert('Error occured');
									}
								});
							});
					$(document)
							.on(
									"click",
									"#isertSubmitBtn",
									function() {
										$(".userInputsError").hide();
										$(".checkBocSelectError").hide();
										if (validateFieldsonInsertNewRecords()) {
											var length = $("#table5 > tbody > tr").length;
											length = length - 1;
											var params = {
													numOfRecords : length
											};
											
									var siblings = $("#table5> tbody > tr").siblings()
									for (var i = 1; i <= length; i++) {
										var columnsLen = $(siblings[i]).children().children().length;
									
										for (var j = 0; j < columnsLen; j++) {
											var id = $(siblings[i]).children().children()[j].id;
											var value = $(siblings[i]).children().children()[j].value;
											params[id] = value;
										}
									}
											$.ajax({
														type : "POST",
														contentType : "application/json;",
														accept : "application/json;",
														async : false,
														url : "/suite/insertRecordIntoTable",
														data : JSON
																.stringify(params),
														success : function(
																response) {
															clearMainTable();
															$('#table2Div')
																	.css(
																			'display',
																			'none');
															$('#table3Div')
																	.css(
																			'display',
																			'none');
															$('#deleteTableDiv')
																	.css(
																			'display',
																			'none');
															$('#mainTableDiv')
																	.css(
																			'display',
																			'inline');
															$('#scriptGen')
																	.show();
															$('#scriptGen')
																	.text(
																			'Script Generated at :'
																					+ response.path);
															$('#table5Div')
																	.css(
																			'display',
																			'none');
														},
														error : function() {
															alert('Error occured');
														}
													});
										}
									});
				});
