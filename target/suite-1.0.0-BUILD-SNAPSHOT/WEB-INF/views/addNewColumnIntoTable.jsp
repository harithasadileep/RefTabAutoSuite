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
              <title>
              </title>
              <script
                      src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js">
              </script>
              <script>
                $(document).on(
                  'change','#dataTable tbody tr:last td select',
                  function() {
                    var length = $("#dataTable > tbody > tr").length;
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
                $(document)
                  .on(
                  'keydown',
                  '#dataTable tbody tr:last td input',
                  function(e) {
                    var length = $("#dataTable > tbody > tr").length;
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
                
                $(document).ready(
                  function() {
                    
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
                    }).prop('selected', true);
                    
             			//on click of add function
                    $('form').submit(
                      function() {
                        $(".errorColumnName").hide();
                        $(".errorSelect").hide();
                        $(".error").hide();
                        var length = $("#dataTable > tbody > tr").length;
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
                            //alert("MaxLength ---> "+$('#columnMaxLength_1').val())
                            $(".error").css("display",
                                            null ? "none" : "inline");
                            return false;
                          }
                          else {
                            $(".error").hide();
                          }
                        }
                      }
                    );
                    $('#addNewColumn').click(
                      function() {
                        $(".errorColumnName").hide();
                        $(".errorSelect").hide();
                        $(".error").hide();
                        var length = $("#dataTable > tbody > tr").length;
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
                                  addMoreColumn('dataTable');
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
                    /*   $('#columnDataType_1').on(
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
                    ); */
                  }
                );
              </script>
              <script type="text/javascript">
                function validateForm() {
                  var columnName = document.getElementById('columnName').value;
                  var columnDataType = document.getElementById('columnDataType').value;
                  var columnMaxLength = document.getElementById('columnMaxLength').value;
                  var nullsAllowed = document.getElementById('nullsAllowed').value;
                  if ('' == columnName || '' == columnDataType || '' == columnMaxLength
                      || '' == nullsAllowed) {
                    alert('Please select form values...');
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
              </script>
            </head>
            <body>
              <div id="main">
                <form:form name="addNewColumnIntoTableForm" method="POST"
                           action="/suite/addNewColumnIntoTable"
                           onsubmit="return validateForm()">
                  <div id="table-scroll" style="overflow-x: auto;">
                    <table id="dataTable">
                      <tr>
                        <td>
                          <label> Column Name 
                          </label>
                        </td>
                        <td>
                          <label> Data Type 
                          </label>
                        </td>
                        <td>
                          <label> Max Length 
                          </label>
                        </td>
                        <td>
                          <label> Null Allowed 
                          </label>
                        </td>
                        <td>
                          <input type="button" value="Add" id="addNewColumn" />
                        </td>
                      </tr>
                      <tr>
                        <td>
                          <input type="text" name="columnName_1" id="columnName_1" />
                        </td>
                        <td>
                          <!-- <select name="columnDataType_1" id="columnDataType_1">
<option value="VARCHAR">VARCHAR
<option value="NUMBER">NUMBER
</select> --> 
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
                            <option value="Y">Yes
                            <option value="N">No
                          </select> 
                          <input type="hidden" name="nullsAllowed_1" id="nullsAllowed_1" />
                        </td>
                      </tr>
                    </table>
                  </div>
                  <input type="hidden" name="numOfRows" id="numOfRows" value="1" />
                  <input type="submit" value="Add" />
                  <input type="button" value="Home"
                         onclick="window.location.href='/suite/dashboard'" />
                  <span class="errorSelect" style="color: Red; display: none">${errorMessageBean.dataTypeDropDownErrMsg}
                  </span>
                  <span class="errorColumnName" style="color: Red; display: none">${errorMessageBean.columnNameErrMsg}
                  </span>
                  <span class="error" style="color: Red; display: none">
                    ${errorMessageBean.numericErrMsg}
                  </span>
                </form:form>
              </div>
              <c:choose>
                <c:when test="${not empty path}">
                  <p style="color: green;">Script Generated at : ${path}
                  </p>
                </c:when>
              </c:choose>
            </body>
          </html>
          <%@ include file="Footer.jsp"%>
