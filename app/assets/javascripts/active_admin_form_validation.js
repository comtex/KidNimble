jQuery(document).ready(function ($) {
	$.validator.addMethod("phone", function(phone_number, element) {
		var digits = "0123456789";
		var phoneNumberDelimiters = "()- ext.";
		var validWorldPhoneChars = phoneNumberDelimiters + "+";
		var minDigitsInIPhoneNumber = 10;
		s=stripCharsInBag(phone_number,validWorldPhoneChars);
		return this.optional(element) || isInteger(s) && s.length >= minDigitsInIPhoneNumber;
	}, "Please enter a valid phone number.");
	$.validator.addMethod("fax", function(phone_number, element) {
		var digits = "0123456789";
		var phoneNumberDelimiters = "()- ext.";
		var validWorldPhoneChars = phoneNumberDelimiters + "+";
		var minDigitsInIPhoneNumber = 10;
		s=stripCharsInBag(phone_number,validWorldPhoneChars);
		return this.optional(element) || isInteger(s) && s.length >= minDigitsInIPhoneNumber;
	}, "Please enter a valid fax number");
	
	$('input[type=tel]').live('keyup',function(evt){
	    var len = $(this).val().length;
	    if (len == 3 || len == 7) {
	       $(this).val($(this).val() + "-")
	    }
	    else if(len == 12) {
	      $(this).val($(this).val() + " ")  
	    }           
		else if(len >= 17) {
	      $(this).val($(this).val().substr(0,16))  
	    } 
	});

	$('form .has_many a.button').live('click', function(e){
		$("input.hasDateTimePicker").datetimepicker({dateFormat: 'yy-mm-dd', timeFormat: 'hh:mm:ss'});
	});
	$("input.hasDateTimePicker").datetimepicker({dateFormat: 'yy-mm-dd', timeFormat: 'hh:mm:ss'});
	$("#active_admin_content .mastercamp").validate();
});

function isInteger(s)
{ 
	var i;
	for (i = 0; i < s.length; i++)
	{
	// Check that current character is number.
		var c = s.charAt(i);
		if (((c < "0") || (c > "9"))) return false;
	}
	// All characters are numbers.
	return true;
}
function stripCharsInBag(s, bag)
{ 
	var i;
	var returnString = "";
	// Search through string's characters one by one.
	// If character is not in bag, append to returnString.
	for (i = 0; i < s.length; i++)
	{
	// Check that current character isn't whitespace.
		var c = s.charAt(i);
		if (bag.indexOf(c) == -1) returnString += c;
	}
	return returnString;
}