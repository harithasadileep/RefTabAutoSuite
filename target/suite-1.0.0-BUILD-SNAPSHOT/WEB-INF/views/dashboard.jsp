<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
  <!-- <!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
-->
  <!DOCTYPE html>
  <%@ include file="Header.jsp"%>
    <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
      <%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
        <html>
          <head>
            <!-- <link rel="stylesheet" type="text/css" href="resources/css/myStyle.css" /> -->
            <link rel="stylesheet" type="text/css"
                  href="resources/css/dashboardSample.css" />
            <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
            <title>
            </title>
            <script
                    src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js">
            </script>
            <script language="javascript">
              /* window.onbeforeunload = function() {
				    localStorage.setItem(mainTableDiv, $('#mainTableDiv'));
				    localStorage.setItem(table2Div, $('#table2Div'));
				    alert("dileep")
				}
				  window.onload = function() {
					  alert("Seee")
				        if (localStorage.getItem('mainTableDiv') !="") {
				        	alert("Undi")
				           $('#mainTableDiv').show()
				        }
				    } */
              function clearMainTable(){
                $('[name=environment] option').filter(function() {
                  return ($(this).val() == 'DEV');
                }
                                                     ).prop('selected', true);
                $('[name=selectedAction] option').filter(function() {
                  return ($(this).val() == 'Sample');
                }
                                                        ).prop('selected', true);
              }
              function table2Clear(){
                $('#table2 tr td input').val('');
                $('[name=operationName] option').filter(function() {
                  return ($(this).val() == 'Sample');
                }
                                                       ).prop('selected', true);
              }
              function table3Clear(){
                var size = $("#table3 tr").length;
                size=size-1;
                if(size>2){
                  deleterowsTable3();
                }
                $('#table3 tr td input').val('');
                $('[name=columnDataType_1] option').filter(function() {
                  return ($(this).text() == 'VARCHAR');
                }
                                                          ).prop('selected', true);
                $('[name=nullsAllowed_1] option').filter(function() {
                  return ($(this).val() == 'sampleAllowNulls');
                }
                                                        ).prop('selected', true);
              }
              function deleterowsTable3(){
                var size = $("#table3 tr").length;
                for(var i=2; i<size;i++){
                  alert($("#table3 tr:eq("+ i +")"))
                  $("#table3 tr:eq("+ i +")").remove();
                  if(size==2){
                    break;
                  }
                  else{
                    deleterowsTable3();
                  }
                }
              }
              function  clearTable4(){
                $('#table4 tr td input').val('');
                $('[name=columnDType_1] option').filter(function() {
                  return ($(this).text() == 'VARCHAR');
                }
                                                       ).prop('selected', true);
                $('[name=nullsAllowed_1] option').filter(function() {
                  return ($(this).val() == 'sampleAllowNulls');
                }
                                                        ).prop('selected', true);
                var size = $("#table4 tr").length;
                if(size>4){
                  deleterowsTable4();
                }
              }
              function deleterowsTable4(){
                var size = $("#table4 tr").length;
                for(var i=4; i<size;i++){
                  alert($("#table4 tr:eq("+ i +")"))
                  $("#table4 tr:eq("+ i +")").remove();
                  if(size==4){
                    break;
                  }
                  else{
                    deleterowsTable4();
                  }
                }
              }
              function table5Clear(){
                $('#table5 tr td input').val('');
                var size = $("#table5 tr").length;
                for(var i=2; i<size;i++){
                  $("#table5 tr:eq("+ i +")").remove();
                  if(size==2){
                    break;
                  }
                  else{
                    table5Clear();
                  }
                }
              }
              function validateForm() {
                var operation = document.getElementById('selectedAction').value;
                if ("action" == operation) {
                  alert('Please select an operation...');
                  return false;
                }
              }
              function validateFields_updateExistingTable() {
                $(".tableNameError").hide();
                if ($('#tableName').val() != '') {
                  if ($("#operationName option:selected").text() == '') {
                    $(".operationNameError").css("display",
                                                 null ? "none" : "inline");
                    return false;
                  }
                  else {
                    $(".operationNameError").hide();
                    return true;
                  }
                }
                else {
                  $(".tableNameError").css("display", null ? "none" : "inline");
                  return false;
                }
              }
              function toJavascript(javaArrayList) {
                var array = javaArrayList;
                array = array.replace("[", "");
                array = array.replace("]", "");
                array = array.replace(" ", "");
                return array.split(",");
              }
              function validateFieldsonInsertNewRecords(tableID){
                var table = document.getElementById(tableID);
                var length = $("#table5 > tbody > tr").length;
                length = length-1;
                for (var i=1;i<=length;i++){
                  var code =  $("#table5 > tbody > tr > td input")[i-1].id;
                  var description = $("#table5 > tbody > tr > td input")[i].id;
                  if ($("#"+code).val() != '') {
                    if ($("#"+description).val() == '') {
                      $(".codeValueError").hide();
                      $(".tableDescError").css("display",
                                               null ? "none" : "inline");
                      return false;
                    }
                    else{
                      $(".codeValueError").hide();
                      $(".tableDescError").hide();
                      
                    }
                  }
                  else{
                    $(".codeValueError").css("display",
                                             null ? "none" : "inline");
                    return false;
                  }
                }
              }
              function addRow(tableID, columnListArg) {
                var table = document.getElementById(tableID);
                var length = $("#table5 > tbody > tr").length;
                length = length-1;
              
                for (var i=0;i<=length;i++){
                  var code =  $("#table5 > tbody > tr > td input")[i-1].id;
                  var description = $("#table5 > tbody > tr > td input")[i].id;
                 var value =  $("#table5 > tbody > tr td").siblings().children()[i].value;
                  
                  if( value ==''){
                	 var id = $("#table5 > tbody > tr td").siblings().children()[i].id;
                	 $('#'+id).focus();
                	 $(".inputsEmptyError").css("display",
                             null ? "none" : "inline");
                	 return false;
                  }
               /*    if ($("#"+code).val() != '') {
                    if ($("#"+description).val() == '') {
                      $(".codeValueError").hide();
                      $(".tableDescError").css("display",
                                               null ? "none" : "inline");
                      return false;
                    }
                    else{
                      $(".codeValueError").hide();
                      $(".tableDescError").hide();
                    }
                  }
                  else{
                    $(".codeValueError").css("display",
                                             null ? "none" : "inline");
                    return false;
                  } */
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
              function validateFeilds(){
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
                    length=length-3;
                    for (var i=1;i<=length;i++){
                      var columnName = $('#columnNm_'+i).val();
                      if (columnName != '') {
                        var  selectValue = $("#columnDType_"+i+" option:selected").text();
                        if (selectValue != '') {
                          var maxLength = $('#columnMaxLen_'+i)
                          .val();
                          if (maxLength != '') {
                            i=i;
                            if(i==length){
                              return true;
                            }
                          }
                          else {
                            $(".error").css("display",
                                            null ? "none" : "inline");
                            return false;
                          }
                        }
                        else{
                          $(".errorSelect").css("display",
                                                null ? "none" : "inline");
                          return false;
                        }
                      }
                      else {
                        $(".errorColumnName").css("display",
                                                  null ? "none" : "inline");
                        return false;
                      }
                    }
                  }
                  else {
                    $(".tableDescError").css("display",
                                             null ? "none" : "inline");
                    return false;
                  }
                }
                else {
                  $(".tableNameError").css("display",
                                           null ? "none" : "inline");
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
                }
                      );
                element2.name = "columnDataType_" + rowCount;
                element2.id = "columnDataType_" + rowCount;
                cell2.appendChild(element2);
                $('select option[value=value2]').attr("selected",true);
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
                }
                      );
                element2.name = "columnDType_" + loop;
                element2.id = "columnDType_" + loop;
                cell2.appendChild(element2);
                $('select option[value=value2]').attr("selected",true);
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
            </script>
            <script>
              $(document).on('change','#table4 tbody tr:last td select',
                             function() {
                var length = $("#table4 > tbody > tr").length;
                length=length-3;
                for (var i=1;i<=length;i++){
                  $(".errorColumnName").hide();
                  $(".errorSelect").hide();
                  $(".error").hide();
                  $(".tableDescError").hide();
                  $(".tableNameError").hide();
                  var name = $("#columnDType_"+i+" option:selected")
                  .text();
                  if (name == '') {
                    $(".errorSelect").css("display",
                                          null ? "none" : "inline");
                    return false;
                  }
                  else {
                    $(".errorSelect").hide();
                  }
                }
              }
                            );
              $(document)
                .on(
                'keydown',
                '#table4 tbody tr:last td input',
                function(e) {
                  var length = $("#table4 > tbody > tr").length;
                  length = length - 3;
                  for (var i = 1; i <= length; i++) {
                    $(".errorColumnName").hide();
                    $(".errorSelect").hide();
                    $(".error").hide();
                    $(".tableDescError").hide();
                    $(".tableNameError").hide();
                    var specialKeys = new Array();
                    specialKeys.push(8);
                    //Backspace
                    $('#columnMaxLen_' + i)
                      .keypress(
                      function(e) {
                        var keyCode = e.which ? e.which
                        : e.keyCode
                        var ret = ((keyCode >= 48 && keyCode <= 57) || specialKeys
                                   .indexOf(keyCode) != -1);
                        $(".error")
                          .css(
                          "display",
                          ret ? "none"
                          : "inline");
                        return ret;
                      }
                    )
                  }
                }
              );
              $(document)
                .on(
                'keydown',
                '#table3 tbody tr:last td input',
                function(e) {
                  var length = $("#table3 > tbody > tr").length;
                  length = length - 1;
                  for (var i = 1; i <= length; i++) {
                    $(".errorColumnName").hide();
                    $(".errorSelect").hide();
                    $(".error").hide();
                    $(".tableDescError").hide();
                    $(".tableNameError").hide();
                    var specialKeys = new Array();
                    specialKeys.push(8);
                    //Backspace
                    $('#columnMaxLength_' + i)
                      .keypress(
                      function(e) {
                        var keyCode = e.which ? e.which
                        : e.keyCode
                        var ret = ((keyCode >= 48 && keyCode <= 57) || specialKeys
                                   .indexOf(keyCode) != -1);
                        $(".error")
                          .css(
                          "display",
                          ret ? "none"
                          : "inline");
                        return ret;
                      }
                    )
                  }
                }
              );
              $(document).on(
                'change','#table3 tbody tr:last td select',
                function() {
                  var length = $("#table3 > tbody > tr").length;
                  length=length-1;
                  for (var i=1;i<=length;i++){
                    $(".errorColumnName").hide();
                    $(".errorSelect").hide();
                    $(".error").hide();
                    $(".tableDescError").hide();
                    $(".tableNameError").hide();
                    var name = $("#columnDataType_"+i+" option:selected")
                    .text();
                    if (name == '') {
                      $(".errorSelect").css("display",
                                            null ? "none" : "inline");
                      return false;
                    }
                    else {
                      $(".errorSelect").hide();
                    }
                  }
                }
              );
              $(document).ready(function() {
                var myOptions_operation = {
                  Sample:'Select Operation',
                  Update:'Update an existing table',
                  Create:'Create a new table',
                };
                var _select = $('<select>');
                $.each(myOptions_operation, function(val, text) {
                  _select.append($('<option></option>').val(val).html(text));
                }
                      );
                $('#selectedAction').append(_select.html());
                var myOptions_envi = {
                  DEV:'DEV',
                  SIT:'SIT',
                  UAT:'UAT',
                };
                var _select = $('<select>');
                $.each(myOptions_envi, function(val, text) {
                  _select.append($('<option></option>').val(val).html(text));
                }
                      );
                $('#environmentSelect').append(_select.html());
                $('#operationName').on(
                  'change',
                  function() {
                    var operationNm = $("#operationName option:selected").text();
                    var tableName = $('#tableName').val();
                    var operationName =$("#operationName").val();
                    var params ={
                      tableName:tableName,operationName:operationName}
                    if(operationNm=='Add new column'){
                      if( validateFields_updateExistingTable()){
                        var tableName = $('#tableName').val();
                        var operationName =$("#operationName").val();
                        var params ={
                          tableName:tableName,operationName:operationName}
                        $.ajax({
                          type:"POST",
                          contentType: "application/json;",
                          accept: "application/json;",
                          url:"/suite/updateExistingTable",
                          data:JSON.stringify(params),
                          success : function(response) {
                            var error = response.errorMessageBean;
                            table3Clear();
                            $('#home1').hide();
                            $(".errorColumnName").hide();
                            $(".errorSelect").hide();
                            $(".error").hide();
                            $(".tableDescError").hide();
                            $(".tableNameError").hide();
                            $('#table4Div').css('display', 'none');
                            $('#dataTableDiv').css('display', 'none');
                            $('#deleteTableDiv').css('display', 'none');
                            $('#table5Div').css('display', 'none');
                            $('#btnDiv').css('display', 'none');
                            $('#table3Div').css('display', 'inline');
                          }
                          ,
                          error: function() {
                            alert('Error occured');
                          }
                        }
                              );
                      }
                      else{
                        return false;
                      }
                    }
                    else if(operationNm=='Delete a record'){
                      $('#deleteTableDiv').empty();
                      $('#deleteTableDiv').hide();
                      $.ajax({
                        type:"POST",
                        contentType: "application/json;",
                        accept: "application/json;",
                        url:"/suite/updateExistingTable",
                        data:JSON.stringify(params),
                        async : false,
                        success : function(response) {
                          //start of table
                          $('#deleteTableDiv').append('<table id="deleteTable"  cellpadding="0px" cellspacing="0px" >');
                          $('#deleteTable').append('<tr>');
                          var thContents = "";
                          var records =response["recordObjectList"][0]["columnObjectList"];
                          var recordsForSecondLoop =response.recordObjectList[0]['columnObjectList'];
                          $.each(records, function (index, value) {
                            thContents += "<th>"+value["columnName"]+"</th>";
                          }
                                );
                          $('#deleteTable tr').append(thContents)
                          $('#deleteTable').append('</tr>');
                          var rowsList =response["recordObjectList"];
                          $.each(rowsList, function (index, value) {
                            $('#deleteTable').append('<tr>');
                            var tdContenets="";
                            $.each(value["columnObjectList"], function (colIndex, colValue) {
                              tdContenets += 	"<td><input type='text' " +
                                " name= "+colValue['columnName']+"_"+index+"_"+colIndex+
                                " id= "+colValue['columnName']+"_"+index+"_"+colIndex+
                                " value= "+colValue["columnValue"]+" /></td>"
                            }
                                  );
                            var abc = tdContenets;
                            $('#deleteTable tr:last').append(tdContenets)
                            $('#deleteTable tr:last').append("<td><input type='checkbox' name='deleteCheck' class='deleteCheckClass' /></td>");
                          }
                                );
                          $('#deleteTableDiv').append(  '</table>' );
                          $('#deleteTableDiv').append( "<input type='button' value='Delete' id='deleteBtn' />");
                          $('#deleteTableDiv').append( "	<input type='button' value='Home' onclick='window.location.href=\"/suite/dashboard\"' /> ");
                          //end of table 
                          $('#deleteTableDiv').show();
                          var error = response.errorMessageBean;
                          $('#home1').hide();
                          $('#table3Div').css('display', 'none');
                          $('#table4Div').css('display', 'none');
                          $('#table5Div').css('display', 'none');
                          $('#btnDiv').css('display', 'none');
                          $('#dataTableDiv').css('display', 'none');
                          $('#scriptGen').hide();
                        }
                        ,
                        error: function() {
                          alert('Error occured');
                        }
                      }
                            );
                    }
                    else if(operationNm=='Update a record'){
                      $.ajax({
                        type:"POST",
                        contentType: "application/json;",
                        accept: "application/json;",
                        url:"/suite/updateExistingTable",
                        data:JSON.stringify(params),
                        success : function(response) {
                          $('#dataTableDiv').append('<table id="dataTable"  cellpadding="0px" cellspacing="0px" >');
                          $('#dataTable').append('<tr>');
                          var thContents = "";
                          var records =response["recordObjectList"][0]["columnObjectList"];
                          var recordsForSecondLoop =response.recordObjectList[0]['columnObjectList'];
                          $.each(records, function (index, value) {
                            thContents += "<th>"+value["columnName"]+"</th>";
                          }
                                );
                          $('#dataTable tr').append(thContents)
                          $('#dataTable').append('</tr>');
                          var rowsList =response["recordObjectList"];
                          $.each(rowsList, function (index, value) {
                            $('#dataTable').append('<tr>');
                            var tdContenets="";
                            $.each(value["columnObjectList"], function (colIndex, colValue) {
                              tdContenets += 	"<td><input type='text' " +
                                " name= "+colValue['columnName']+"_"+index+"_"+colIndex+
                                " id= "+colValue['columnName']+"_"+index+"_"+colIndex+
                                " value= "+colValue["columnValue"]+" /></td>"
                            }
                                  );
                            $('#dataTable tr:last').append(tdContenets)
                          }
                                );
                          $('#dataTableDiv').append(  '</table>' );
                          $('#dataTableDiv').append( "<input type='button' value='Update' id='updateSubmit'/>");
                          $('#dataTableDiv').append( "	<input type='button' value='Home' onclick='window.location.href=\"/suite/dashboard\"' /> ");
                          //end of table 
                          $('#dataTableDiv').show();
                          var error = response.errorMessageBean;
                          $('#home1').hide();
                          $('#table3Div').css('display', 'none');
                          $('#table4Div').css('display', 'none');
                          $('#table5Div').css('display', 'none');
                          $('#btnDiv').css('display', 'none');
                          $('#scriptGen').hide();
                        }
                        ,
                        error: function() {
                          alert('Error occured');
                        }
                      }
                            );
                      /*  $('form[name=environmentForm]').attr("action","/suite/updateExistingTable");
                      	 this.form.submit(); */
                    }
                    else if(operationNm=='Insert a record'){
                      $('#table5Div').empty();
                      $('#table5Div').hide();
                      $.ajax({
                        type:"POST",
                        contentType: "application/json;",
                        accept: "application/json;",
                        url:"/suite/updateExistingTable",
                        data:JSON.stringify(params),
                        success : function(response) {
                          var columnList =  response['columnList'];
                          var columnListNew = [];
                          columnListNew = response.columnList;
                          $('#table5Div').append('<table id="table5"  cellpadding="0px" cellspacing="0px" >');
                          $('#table5').append('<tr>');
                          var thContents="";
                          $.each(columnList, function (index, value) {
                            thContents += "<th>"+value+"</th>";
                          }
                                );
                          $('#table5 tr').append(thContents);
                          $('#table5').append('<tr>');
                          var tdContenets="";
                          $.each(columnList, function (index, value) {
                            tdContenets +=  "<td><input type='text' name=" +value+"_1_"+index+
                              " id="+value+"_1_"+index+" /></td>"
                          }
                                );
                          $('#table5 tr:last').append(tdContenets);
                          $('#table5Div').append(  '</table>' );
                          $('#table5Div').append( "<input type='button' value='Generate' id='isertSubmitBtn'/>");
                          $('#table5Div').append( '<input type="button" value="Add" id="addRowBtn"/>');
                          $("#addRowBtn").on("click", function(){
                            addRow('table5',columnListNew);
                          }
                                            );
                          //onclick="addRow(table5,'+columnListNew+') />');
                          /* $('#addRowBtn'). */
                          $('#table5Div').append( "<input type='button' value='Home' onclick='window.location.href=\"/suite/dashboard\"' /> ");
                          $('#table5Div').show();
                          var error = response.errorMessageBean;
                          table5Clear();
                          $('#table3Div').css('display', 'none');
                          $('#table4Div').css('display', 'none');
                          $('#deleteTableDiv').css('display', 'none');
                          $('#dataTableDiv').css('display', 'none');
                          $('#home1').hide();
                        }
                        ,
                        error: function() {
                          alert('Error occured');
                        }
                      }
                            );
                      /* $('form[name=environmentForm]').attr("action","/suite/updateExistingTable");
                    	 this.form.submit(); */
                    }
                    else if(operationNm=='select operation'){
                      table3Clear();
                      clearTable4();
                      $('#deleteTable').empty();
                      $('#dataTable').empty();
                      $('#table3BtnsDiv').hide();
                      $('#table4BtnDiv').hide();
                      $('#dataTableBtnDiv').hide();
                      $('#deleteTableBtnDiv').hide();
                      $('#table5BtnDiv').hide();
                      $('#deleteTableDiv').css('display', 'none');
                      $('#dataTableDiv').css('display', 'none');
                      $('#table3Div').css('display', 'none');
                      $('#table4Div').css('display', 'none');
                      $('#home1').show()();
                    }
                    else{
                      return false;
                    }
                  }
                );
                $('#selectedAction').on(
                  'change',
                  function(event) {
                    var name = $("#selectedAction option:selected").text();
                    var selecAction = $("#selectedAction option:selected").val();
                    var env = $("#environmentSelect").val();
                    var params ={
                      environment : env,
                      selectedAction : selecAction
                    };
                    if(name=='Update an existing table'){
                      $.ajax({
                        type:"POST",
                        contentType: "application/json;",
                        accept: "application/json;",
                        url:"/suite/collectDetails",
                        data:JSON.stringify(params),
                        success : function(response) {
                          var error = response.errorMessageBean;
                          table2Clear();
                          $('#table3Div').css('display', 'none');
                          $('#table4Div').css('display', 'none');
                          $('#scriptGen').hide();
                          $('#table2Div').css('display', 'inline');
                          $('#table2').css('margin-left', '147px');
                          $('#table2').css('position', 'left');
                        }
                        ,
                        error: function() {
                          alert('Error occured');
                        }
                      }
                            );
                    }
                    else if(name=='Create a new table'){
                      $.ajax({
                        type:"POST",
                        contentType: "application/json;",
                        accept: "application/json;",
                        url:"/suite/collectDetails",
                        data:JSON.stringify(params),
                        success : function(response) {
                          clearTable4();
                          var error = response.errorMessageBean;
                          $('#table2Div').css('display', 'none');
                          $('#table3Div').css('display', 'none');
                          $('#deleteTable').css('display', 'none');
                          $('#scriptGen').hide();
                          $('#table4Div').css('display', 'inline');
                          $('#deleteTableDiv').css('display', 'none');
                          $('#dataTableDiv').css('display', 'none');
                          $('#table5Div').css('display', 'none');
                        }
                        ,
                        error: function() {
                          alert('Error occured');
                        }
                      }
                            );
                    }
                  }
                );
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
                  _select.append($('<option></option>').val(val).html(text));
                }
                      );
                $('#columnDataType_1').append(_select.html());
                $('[name=columnDataType_1] option').filter(function() {
                  return ($(this).text() == 'VARCHAR');
                }
                                                          ).prop('selected', true);
                var _select1 = $('<select>');
                $.each(myOptions, function(val, text) {
                  _select1.append($('<option></option>').val(val).html(text));
                }
                      );
                $('#columnDType_1').append(_select.html());
                $('[name=columnDType_1] option').filter(function() {
                  return ($(this).text() == 'VARCHAR');
                }
                                                       ).prop('selected', true);
                $('#addColumnSubmitBtn').click(
                  function() {
                    $(".errorColumnName").hide();
                    $(".errorSelect").hide();
                    $(".error").hide();
                    var length = $("#table3 > tbody > tr").length;
                    length = length - 1;
                    for (var i = 1; i <= length; i++) {
                      var columnName = $("#columnName_" + i).val();
                      if (columnName == '') {
                        $(".errorColumnName").css("display",
                                                  null ? "none" : "inline");
                        return false;
                      }
                      else {
                        $(".errorColumnName").hide();
                      }
                      var name = $(
                        "#columnDataType_" + i
                        + " option:selected").text();
                      if (name == '') {
                        $(".errorSelect").css("display",
                                              null ? "none" : "inline");
                        return false;
                      }
                      else {
                        $(".errorSelect").hide();
                      }
                      if ($('#columnMaxLength_' + i).val() == '') {
                        $(".error").css("display",
                                        null ? "none" : "inline");
                        return false;
                      }
                      else {
                        $(".error").hide();
                        var tableName = $("#tableName").val();
                        var length = $("#table3 > tbody > tr").length;
                        length = length-1;
                        var params ={
                          numOfRows:length,"tableName":tableName}
                        for (var i = 1; i <= length; i++) {
                          var columnNameVal =  $('#columnName_' + i).val();
                          var maxlength = $('#columnMaxLength_' + i).val();
                          var dataType  =  $( "#columnDataType_" + i + " option:selected").text();
                          var nullnotallowed =  $( "#nullsAllowed_" + i + " option:selected").text();
                          var arr = {
                          }
                          var columnnameId =  $('#columnName_' + i).attr('id')
                          var maxlengthId = $('#columnMaxLength_' + i).attr('id')
                          params[columnnameId] =columnNameVal
                          params[maxlengthId] = maxlength;
                          params['columnDataType_'+i] = dataType;
                          params['nullsAllowed_'+i] = nullnotallowed;
                        }
                        $.ajax({
                          type:"POST",
                          contentType: "application/json;",
                          accept: "application/json;",
                          url:"/suite/addNewColumnIntoTable",
                          data:JSON.stringify(params),
                          success : function(response) {
                            clearMainTable();
                            $('#table2Div').css('display', 'none');
                            $('#table3Div').css('display', 'none');
                            $('#mainTableDiv').css('display', 'inline');
                            $('#scriptGen').show();
                            $('#scriptGen').text('Script Generated at :'+response.path);
                          }
                          ,
                          error: function() {
                            alert('Error occured');
                          }
                        }
                              );
                      }
                    }
                  }
                );
                $('#addNewColumn').click(
                  function() {
                    $(".errorColumnName").hide();
                    $(".errorSelect").hide();
                    $(".error").hide();
                    var length = $("#table3 > tbody > tr").length;
                    length = length - 1;
                    for (var i = 1; i <= length; i++) {
                      if ($('#columnName_' + i).val() != '') {
                        if ($(
                          "#columnDataType_" + i
                          + " option:selected")
                            .text() != '') {
                          var maxLength = $(
                            '#columnMaxLength_' + i).val();
                          if (maxLength != '') {
                            i = i;
                            if (i == length) {
                              addMoreColumn('table3');
                            }
                          }
                          else {
                            $(".error").css("display",
                                            null ? "none" : "inline");
                          }
                        }
                        else {
                          $(".errorSelect").css("display",
                                                null ? "none" : "inline");
                        }
                      }
                      else {
                        $(".errorColumnName").css("display",
                                                  null ? "none" : "inline");
                      }
                    }
                  }
                );
                $('#columnDataType_1').on(
                  'change',
                  function() {
                    $(".errorColumnName").hide();
                    $(".errorSelect").hide();
                    $(".error").hide();
                    var name = $("#columnDataType_1 option:selected")
                    .text();
                    if (name == '') {
                      $(".errorSelect").css("display",
                                            null ? "none" : "inline");
                      return false;
                    }
                  }
                );
                var myOptions = {
                  Sample:'select operation',
                  Add : 'Add new column',
                  Insert : 'Insert a record',
                  Update : 'Update a record',
                  Delete : 'Delete a record'
                };
                var _select = $('<select>');
                $.each(myOptions, function(val, text) {
                  _select.append($('<option></option>').val(val).html(text));
                }
                      );
                $('#operationName').append(_select.html());
                $('#operationName').on('change', function() {
                  validateFields_updateExistingTable();
                }
                                      );
                $('#nextBtn').click(function() {
                  if (!validateFields_updateExistingTable()) {
                    return false;
                  }
                }
                                   );
                $('#createBtn').click(
                  function() {
                    if(validateFeilds()){
                      var tableName = $('#tableName_newtable').val();
                      var tableDesc = $('#tableDesc_newtable').val();
                      var length = $("#table4 > tbody > tr").length;
                      length = length-3;
                      var params = {
                        "tableName":tableName,"tableDesc":tableDesc,"numOfRows":length};
                      for (var i=1;i<=length;i++){
                        var columnnameId =  $('#columnNm_' + i).attr('id')
                        var columnNameVal =  $('#columnNm_' + i).val();
                        var maxlengthId = $('#columnMaxLen_' + i).attr('id')
                        var maxlength = $('#columnMaxLen_' + i).val();
                        var dataType  =  $( "#columnDType_" + i + " option:selected").text();
                        var nullnotallowed =  $( "#nullsAllow_" + i + " option:selected").text();
                        params[columnnameId] =columnNameVal;
                        params[maxlengthId] = maxlength;
                        params['columnDType_'+i] = dataType;
                        params['nullsAllow_'+i] = nullnotallowed;
                      }
                      $.ajax({
                        type:"POST",
                        contentType: "application/json;",
                        accept: "application/json;",
                        url:"suite/createNewTable",
                        data:JSON.stringify(params),
                        async : false,
                        success : function(response) {
                          clearMainTable();
                          $('#table2Div').css('display', 'none');
                          $('#table3Div').css('display', 'none');
                          $('#table4Div').css('display', 'none');
                          $('#table5Div').css('display', 'none');
                          $('#mainTableDiv').css('display', 'inline');
                          $('#scriptGen').show();
                          $('#scriptGen').text('Script Generated at :'+response.path);
                        }
                        ,
                        error: function() {
                          alert('Error occured');
                        }
                      }
                            );
                    }
                    else{
                      return false;;
                    }
                  }
                );
                $('#addBtn').click(function() {
                  if(validateFeilds()){
                    addMoreColumn('dataTable');
                    return true;
                  }
                  else{
                    return false;;
                  }
                }
                                  );
                $('#newTableColumnDataType_1').append(_select.html());
                $('[name=newTableColumnDataType_1] option').filter(function() {
                  return ($(this).text() == 'VARCHAR');
                }
                                                                  ).prop('selected', true);
                $('#addColumnsBtnForNewTable').click(function() {
                  if(validateFeilds()){
                    addMoreColumnForNewTable('table4');
                    return true;
                  }
                  else{
                    return false;;
                  }
                }
                                                    );
                //$('#deleteBtn').click(function() {
                $(document).on("click", "#deleteBtn", function(){
                  $('.checkBocSelectError').hide();
                  var name = $('#codeValue').val();
                  if (name == '') {
                    $(".codeValueError").css("display",
                                             null ? "none" : "inline");
                    return false;
                  }
                  else {
                    var finalValue ="";
                    var checkedCheckboxes = $("#deleteTable :checkbox:checked");
                    var tableData = {
                      items: []};
                    for (var i = 0; i < checkedCheckboxes.length; i++) {
                      var checkbox = $(checkedCheckboxes[i]);
                      var checkboxValue = checkbox
                      .val();
                      var siblings = checkbox
                      .parent()
                      .siblings();
                      var val = $(siblings[0])
                      .children().val();
                      var arr = {
                      };
                      arr['CODE'] = val;
                      tableData.items.push(arr);
                      finalValue = tableData;
                    }
                    $.ajax({
                      type : "POST",
                      contentType : "application/json;",
                      accept : "application/json;",
                      async : false,
                      url : "/suite/deleteRecordFromTable",
                      data : JSON.stringify(finalValue),
                      success : function(
                      response) {
                        var error = response.errorMessageBean;
                        $('#table2Div').css('display','none');
                        $('#table3Div').css('display','none');
                        $('#deleteTableDiv').css('display','none');
                        clearMainTable();
                        $('#mainTableDiv').css('display','inline');
                        $('#scriptGen').show();
                        $('#scriptGen').text('Script Generated at :'+response.path);
                      }
                      ,	
                      error : function() {
                        $(".checkBocSelectError").css("display",
                                                      null ? "none" : "inline");
                        return false;
                      }
                    }
                          );
                  }
                }
                              );
                //$('#updateSubmit').click(function() {
                $(document).on("click", "#updateSubmit", function(){
                  var tableData = {
                  };
                  var size = $("#dataTable > tbody > tr").length
                  var siblings = $("#dataTable> tbody > tr").siblings()
                  for (var i=1; i<size ; i++){
                    var columnsLen = $(siblings[i]).children().children().length;
                    var updateRow = {
                    };
                    for (var j=0; j< columnsLen; j++){
                      var id =  $(siblings[i]).children().children()[j].id;
                      var value =  $(siblings[i]).children().children()[j].value;
                      tableData[id]=value;
                    }
                  }
                  $.ajax({
                    type : "POST",
                    contentType : "application/json;",
                    accept : "application/json;",
                    async : false,
                    url : "/suite/updateRecordInTable",
                    data : JSON.stringify(tableData),
                    success : function(
                    response) {
                      clearMainTable();
                      var error = response.errorMessageBean;
                      $('#table2Div').css('display','none');
                      $('#dataTableDic').css('display','none');
                      $('#dataTableDiv').css('display','none');
                      $('#deleteTableDiv').css('display','none');
                      $('#mainTableDiv').css('display','inline');
                      $('#scriptGen').show();
                      $('#scriptGen').text('Script Generated at :'+response.path);
                    }
                    ,	
                    error : function() {
                      alert('Error occured');
                    }
                  }
                        );
                }
                              );
                /* $(document).on("click", "#addRowBtn", function(){
								addRow('table5', columnListArg)
							}); */
                /* $('#isertSubmitBtn').click(
								function() { */
                $(document).on("click", "#isertSubmitBtn", function(){
                  if(validateFieldsonInsertNewRecords('table5')){
                    var length = $("#table5 > tbody > tr").length;
                    length = length-1;
                    var params ={
                      numOfRecords:length};
                    for (var i=1;i<=length;i++){
                      var codeId =  $("#table5 > tbody > tr > td input")[i-1].id;
                      var codeText =  $("#table5 > tbody > tr > td input")[i-1].value
                      var descriptionId = $("#table5 > tbody > tr > td input")[i].id;
                      var descriptionText = $("#table5 > tbody > tr > td input")[i].value;
                      params[codeId]=codeText;
                      params[descriptionId]=descriptionText;
                    }
                    $.ajax({
                      type : "POST",
                      contentType : "application/json;",
                      accept : "application/json;",
                      async : false,
                      url : "/suite/insertRecordIntoTable",
                      data : JSON.stringify(params),
                      success : function(
                      response) {
                        clearMainTable();
                        $('#table2Div').css('display','none');
                        $('#table3Div').css('display','none');
                        $('#deleteTableDiv').css('display','none');
                        $('#mainTableDiv').css('display','inline');
                        $('#scriptGen').show();
                        $('#scriptGen').text('Script Generated at :'+response.path);
                        $('#table5Div').css('display','none');
                      }
                      ,	
                      error : function() {
                        alert('Error occured');
                      }
                    }
                          );
                  }
                }
                              );
              }
                               );
            </script>
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
                        <select name="environment" id="environmentSelect">
                          <!-- <option value="DEV">DEV
<option value="SIT">SIT
<option value="UAT">UAT -->
                        </select> 
                        <input type="hidden" name="environment" id="environment">
                      </td>
                    </tr>
                    <tr>
                      <td>
                        <label>Operation    :
                        </label>
                      </td>
                      <td>
                        <select id="selectedAction" name="selectedAction">
                        </select> 
                        <input type="hidden" name="selectedAction" id="selectedAction"
                               value="0" />
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
                        <label>Operation : 
                        </label>
                      </td>
                      <td>
                        <select name="operationName" id="operationName">
                        </select> 
                        <!-- <option value=""><option value="Add">Add new column<option value="Insert">Insert a record<option value="Update">Update a record<option value="Delete">Delete a record</select> <input type="hidden" name="operationName" id="operationName" /> -->
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
                      <td>
                        <label for="table3Lbl"> Column Name 
                        </label>
                      </td>
                      <td>
                        <label for="table3Lbl"> Data Type 
                        </label>
                      </td>
                      <td>
                        <label for="table3Lbl"> Max Length 
                        </label>
                      </td>
                      <td>
                        <label for="table3Lbl" > Null Allowed 
                        </label>
                      </td>
                    </tr>
                    <tr>
                      <td>
                        <input type="text" name="columnName_1" id="columnName_1" />
                      </td>
                      <td>
                        <select name="columnDataType_1" id="columnDataType_1">
                        </select> 
                        <input type="hidden" name="columnDataType_1"
                               id="columnDataType_1" />
                      </td>
                      <td>
                        <input type="text" name="columnMaxLength_1"
                               id="columnMaxLength_1" class="numeric_1" />
                      </td>
                      <td>
                        <select name="nullsAllowed_1" id="nullsAllowed_1">
                          <option value="sampleAllowNulls">--Select--<option value="Y">Yes<option value="N">No</select> 
                        <input type="hidden" name="nullsAllowed_1" id="nullsAllowed_1" />
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
                <div id="table4Div" style="display:none">
                  <table id="table4" align="center">
                    <tr>
                      <td>
                        <label style="text-align:right">Table Name :
                        </label>
                      </td>
                      <td>
                        <input type="text" id="tableName_newtable" name="tableName_newtable" />
                      </td>
                    </tr>
                    <tr>
                      <td>
                        <label style="text-align:right">Table Description :
                        </label>
                      </td>
                      <td>
                        <input type="text" id="tableDesc_newtable" name="tableDesc_newtable" />
                      </td>
                    </tr>
                    <tr>
                      <td>
                        <label style="text-align:center"> Column Name 
                        </label>
                      </td>
                      <td>
                        <label style="text-align:center"> Data Type 
                        </label>
                      </td>
                      <td>
                        <label style="text-align:center"> Max Length 
                        </label>
                      </td>
                      <td>
                        <label style="text-align:center"> Null Allowed 
                        </label>
                      </td>
                    </tr>
                    <tr>
                      <td>
                        <input type="text" name="columnNm_1" id="columnNm_1" />
                      </td>
                      <td>
                        <select name="columnDType_1" id="columnDType_1">
                        </select> 
                        <input type="hidden" name="columnDType_1"
                               id="columnDType_1" />
                      </td>
                      <td>
                        <input type="text" name="columnMaxLen_1"
                               id="columnMaxLen_1" class="number_1" />
                      </td>
                      <td>
                        <select name="nullsAllow_1" id="nullsAllow_1">
                          <option value="sampleAllowNulls">--Select--<option value="Y">Yes<option value="N">No</select> 
                        <input type="hidden" name="nullsAllowed_1" id="nullsAllowed_1" />
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
                <div id="table5Div"   style="margin-left:100px; margin-right:100px;display:none">
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
                    <label class="errorMessagesBean" style="color: Red; display: none">${errorMessageBean.errorMessagesBean}
                  </label>
                </center>
              </form:form>
            </div>
          </body>
        </html>
        <%@ include file="Footer.jsp"%>
