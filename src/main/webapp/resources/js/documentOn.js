$(document).on('change', '#table4 tbody tr:last td select', function() {
	var length = $("#table4 > tbody > tr").length;
	length = length - 3;
	for (var i = 1; i <= length; i++) {
		$(".errorColumnName").hide();
		$(".errorSelect").hide();
		$(".error").hide();
		$(".tableDescError").hide();
		$(".tableNameError").hide();
		var name = $("#columnDType_" + i + " option:selected").text();
		if (name == '') {
			$(".errorSelect").css("display", null ? "none" : "inline");
			return false;
		} else {
			$(".errorSelect").hide();
		}
	}
});
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
						$('#columnMaxLen_' + i)
								.keypress(
										function(e) {
											var keyCode = e.which ? e.which
													: e.keyCode
											var ret = ((keyCode >= 48 && keyCode <= 57) || specialKeys
													.indexOf(keyCode) != -1);
											$(".error").css("display",
													ret ? "none" : "inline");
											return ret;
										})
					}
				});
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
						$(".userInputsError").hide();
						$(".checkBocSelectError").hide();
						var specialKeys = new Array();
						specialKeys.push(8);
						$('#columnMaxLength_' + i)
								.keypress(
										function(e) {
											var keyCode = e.which ? e.which
													: e.keyCode
											var ret = ((keyCode >= 48 && keyCode <= 57) || specialKeys
													.indexOf(keyCode) != -1);
											$(".error").css("display",
													ret ? "none" : "inline");
											return ret;
										})
					}
				});
$(document).on('change', '#table3 tbody tr:last td select', function() {
	var length = $("#table3 > tbody > tr").length;
	length = length - 1;
	for (var i = 1; i <= length; i++) {
		$(".errorColumnName").hide();
		$(".errorSelect").hide();
		$(".error").hide();
		$(".tableDescError").hide();
		$(".tableNameError").hide();
		var name = $("#columnDataType_" + i + " option:selected").text();
		if (name == '') {
			$(".errorSelect").css("display", null ? "none" : "inline");
			return false;
		} else {
			$(".errorSelect").hide();
		}
	}
});
