$(document).ready(function(){
	var count = 1;
	var jeopardy = $('#converting-music').get(0);
	var page = 1;

	//$('#list-videos li:gt(8)').hide();

	/*if($('#list-videos li span').hasClass('converting')) {
		$('#converting-music').trigger('play');
	}*/

	/*$(window).scroll(function () {
		$('#more').hide();
		$('#no-more').hide();

		if ($(window).scrollTop() + $(window).height() > $(document).height() - 200) {
            $('#more').css("top","400");
            $('#more').show();
        }

        if ($(window).scrollTop() + $(window).height() == $(document).height()) {
            $('#more').hide();
            $('#no-more').hide();

            page++;

            var data = {
                page_num: page
            };

            var actual_count = "<?php echo $actual_row_count; ?>";

            if ((page - 1) * 12 > actual_count) {
                $('#no-more').css("top","400");
                $('#no-more').show();
            } else {
            	$('#list-videos li').nextAll(':lt(3)').each(function() {
			        $(this).fadeIn();
			    });
            }
        }
    });*/
	
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

	// function loadAudio() {
	// 	jeopardy.play();
	// }

	//$('#converting-music').on('converting', function() {
		setInterval(loadAnimation, 500);
		// TODO: set "converting"-class on list-elements
		// TODO: play music
		// loadAudio();
	//});
});