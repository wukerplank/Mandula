$(document).ready(function(){
	var count = 1;

	function loadAnimation() {
	    if(count == 1) {
	        $('.converting span').html('Converting');
	         count = 2;

	    } else if(count == 2) {
	        $('.converting span').html('Converting.');
	         count = 3;

	    } else if(count == 3) {
	        $('.converting span').html('Converting..');
	        count = 4;
	    } else if(count == 4) {
	        $('.converting span').html('Converting...');
	        count = 1;
	    }
	}
	setInterval(loadAnimation, 500);
	
});