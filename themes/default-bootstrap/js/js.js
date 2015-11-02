jQuery(document).ready(function($) {
	
	
	
	$('#menu_show').on('click', function() { // бутер меню с оверлеем //
 		$('.menu ul').fadeToggle('slow');
  	});
	
	
	$('#title_1').click(function() {
		if($('.cpec_cont').css('display') !== 'none'){
			$('.cpec_cont').hide()
		}
		$('.menu_left').slideToggle(400)
	});
	$('.left_title.cpec').click(function() {
		if($('.menu_left').css('display') !== 'none'){
			$('.menu_left').hide()
		}
		$('.cpec_cont').slideToggle(400)
	});
	
	if($('div').is('.rte')){
		$('.rte img').addClass($('.rte img').attr('alt'))
	};

	if($('div').is('.text')){
		$('.text img').addClass($('.text img').attr('alt'))
	};
	
	if($(document).width() <= 630) {  
		$('.logo').insertBefore('.menu');
	};
	
});