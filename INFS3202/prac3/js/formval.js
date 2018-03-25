

$(document).ready(function() {
$("#submitG").attr('disabled','disabled');
$("#submitH").attr('disabled','disabled');
//if element with id containing 'input' changes run formval
$("[id$=input]").keyup(function(){
		console.log($(this).val());
		validateForm();
	});

})

function validateForm(){
	//check that each necessary input field has a value
	if(document.getElementById("nameGinput").value.length>4) {
				
		//enable submit button
		$("#submitG").removeAttr('disabled');
		
	}else{
		//disbale submit button if not already disabled
		$("#submitG").attr('disabled','disabled');
		
	}
	if(document.getElementById("nameHinput").value.length>4) {
				
		//enable submit button
		$("#submitH").removeAttr('disabled');
		
	}else{
		//disbale submit button if not already disabled
		$("#submitH").attr('disabled','disabled');
		
	}
}

