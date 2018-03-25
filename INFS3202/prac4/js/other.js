function invalidEntry() {


}
function toggle_visibility(more, button) {
       var e = document.getElementById(more);
       if(e.style.display == 'block'){
          e.style.display = 'none';
		  document.getElementById(button).value= "Show More";
		  }
       else{
          e.style.display = 'block';
		  document.getElementById(button).value= "Hide";
		  }
}
function toggle_visibility2(id) {
       var e = document.getElementById(id);
       if(e.style.display == 'block'){
          e.style.display = 'none';
		  }
       else{
          e.style.display = 'block';
		  }
}
