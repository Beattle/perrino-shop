jQuery(document).ready(function($) {
	$('#slider_news').width($('.list-wrap').width());
	$('#slider_stat').width($('.list-wrap').width());
	$('#slider_vid').width($('.list-wrap').width());

	if($(document).width() <= 760) {
		//$('.gp a img').prop('alt', 'gp');
		$('.sety_foot').insertBefore('.gp');
		$('.menu_foot').insertBefore('.copir');
		$('.logos').prepend($('.gp a'));
	};

	$(document).scroll(function() {
		if($(document).scrollTop() >= 200){
			$('.in_top').show();
		} else {
			$('.in_top').hide();
		}
	});

	$('.in_top').click(function() {
		$('body').animate({ scrollTop: 0 }, "slow");		
	});

 	$('a.menu_show').on('click', function() {
 		$('#show_menu').toggle();
 		$('.menu_over').toggle();
 		if($('.menu_show').css('z-index') === '2012'){
 			$('.menu_show').css('z-index', 3);
 		} else {
 			$('.menu_show').css('z-index', 2012);
 		}
 	});

 	$('.menu_over').on('click', function() {
 		$('.menu_show').click();	
 	});

	$(window).resize(function(){
		$('#slider_news').width($('.list-wrap').width());
		$('#slider_stat').width($('.list-wrap').width());
		$('#slider_vid').width($('.list-wrap').width());

		if($(document).width() <= 760) {
			$('.sety_foot').insertBefore('.gp');
			$('.menu_foot').insertBefore('.copir');
			$('.logos').prepend($('.gp a'));
		} else {
			$('.gp').insertBefore('.sety_foot');
			$('.logos a:has(img[rel=gp])').appendTo('.gp');
			$('.logos').insertBefore('.sety_foot');
		}	
	});
	
	$(document).scroll(function() {
		if($('body').scrollTop() >= 50){
			$('.header').addClass('header_top');
		} else {
			$('.header').removeClass('header_top');
		}
	});

	$('.map').on('click', function() {
		openMap();
	});

	$('.svernut').on('click', function(){
		if($('.map_cont').height() === 200){
			openMap();
		} else {
			closeMap();
		}
		return false;
	});	

	function openMap(){
		$('.map_cont').animate({height: 505}, 400);
		$('.svernut').empty().text('СВЕРНУТЬ КАРТУ');
		$('.map_bott').show(400, function(){
			$('.city_bl').css('top', $('.map_top').outerHeight());
			$('.city_bl').css('bottom', $('div.map_bott').outerHeight());
		});
	}

	function closeMap(){
		$('.map_cont').animate({height: 200}, 400);
		$('.svernut').empty().text('РАЗВЕРНУТЬ КАРТУ');
		$('.map_bott').hide(400);
	}

	if(!$('#wrapper').hasClass('jspScrollable') && $(window).width() >= 870){
		$('#wrapper').jScrollPane();			
	}

	$('.city_click').on('click', function(){
		$('.city_click input').val("");
		$('.city_bl').toggle(400);

		if(!$('#wrapper').hasClass('jspScrollable')){
			//$('#wrapper.jspScrollable').height($('.city_bl').height());			
			$('#wrapper').height($('.map_cont').height() - ($('.map_top').outerHeight() + $('.map_bott').outerHeight()));
			$('#wrapper').jScrollPane();
			$('.jspScrollable').height($('.map_cont').height() - ($('.map_top').outerHeight() + $('.map_bott').outerHeight()));
		}
	});

	$('.city_select').on('click', function() {
		$('.city_click input').val("");
		$('.city_click').click();
		$('.city_click input').val($(this).children('p').text());
	});

	$('#lang').ddslick({
	    onSelected: function(selectedData){
			$('#lang').removeClass('lang-write');
	    }   
	});

	$('.dd-selected').on('click', function() {
		$('#lang').toggleClass('lang-write');
	});

	$('#country').ddslick();		

	$('a.podarok').on('click', function() {
		$('.overlay').fadeIn('400');
		$('.gift').animate({top: "50px"}, 500);
		return false;
	});

	$('.oil').on('click', function() {
		$('.overlay').fadeIn('400');
		$('.iframe').animate({top: "50px"}, 500);
		return false;
	});

	$('div.close').click(function(){
		$('.overlay').fadeOut('400');
		$('.popup').animate({top: "-700px"}, 500);
	});

	$('.overlay').click(function(){
		$('.overlay').fadeOut('400');
		$('.popup').animate({top: "-700px"}, 500);
	});
	
	 //if($(document).width() <= 1024) {
		if($('div').is('.menu_produkt')){	
			$('div.left').appendTo('#append .center');			
		};
	// };
	
	$('.tehno_bl').click(function() { 
		if($(this).is('.tehno_bl2')){
			$(this).removeClass('tehno_bl2');
		} else {
			$ ('.tehno_bl').removeClass('tehno_bl2')
			$(this).addClass('tehno_bl2');			
		}
	});

	
	$('.item_cont').width($('#sync1 .owl-controls').width());
	
	 if($(document).width() <= 760) {
	 	$('#sync2').appendTo('#sync1');
		//console.log($('.slider_img').height());
		if($('div').is('.slider_img')){
			$('#sync2').css('top', $('.slider_img').height());
		}	
		//$('.slider_img').height($('#sync2').top());  // поправить
	 };
	 
	 $(window).resize(function(){  // доделать
		$('.city_bl').css('top', $('.map_top').height());
	    $('#wrapper').css('top', $('.map_top').height());
		$('.city_bl').css('bottom', $('.map_bott').height());
	    $('#wrapper').css('bottom', $('.map_bott').height());
		// $('#wrapper').height($('.city_bl').height());
	 })
	 

	// $('.produkt_show').on('click', function() {
	// 	$('#m_produkt')		
	// }); 
	//$('.menu_produkt').css('margin-top', -$('div.tovar_info').outerHeight());			 
	
	// $(window).resize(function() {
	//	$('.menu_produkt').css('margin-top', -$('div.tovar_info').outerHeight());		
	// }); 
	// console.log($('div.tovar_info').outerHeight());	
	if($('div').is('.galery')){
		$('.galery span a').fancybox();				
	}

	$('.menu_produkt li').on('click', function(){
		var li = $(this);
		li.find('ul').slideToggle();
	})
 
	 $(".act").hover(
	      function () {
	        $(this).find('.slider_popup').fadeIn();
	        $(this).find('.slider_popup').css('left', -$(this).find('.slider_popup').width()/2);
	      },
	      function () {
	        $(this).find('.slider_popup').fadeOut();
	      }
	 );

	 $('.acf_bl').on('click', function() {
	 	$(this).find('.acf_drop').slideToggle('slow');
	 });

	$('.kupit_form').find('.selectArea').width($('.kupit_form input[type="text"]').width())
	$('.kupit_form.metro').find('.selectArea').width($('.kupit_form.metro input[type="text"]').width())
	 
	 $(window).resize(function() {
	 	$('.kupit_form').find('.selectArea').width($('.kupit_form input[type="text"]').width())
		$('.kupit_form.metro').find('.selectArea').width($('.kupit_form.metro input[type="text"]').width()) 	
	 });

	$('.selectArea').click(function(){
		console.log($(this).width());
		$('.drop-undefined').width($(this).width());
	})

	 $('.center .menu ul li').hover(function() {
	 	$(this).find('ul').slideDown('400');
	 }, function() {
	 	$(this).find('ul').hide();
	 });

});