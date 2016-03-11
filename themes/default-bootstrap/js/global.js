/*
* 2007-2015 PrestaShop _tat_ помимо прочего оборачивало content_price в divы. Заменила на cat_cena убрала функцию (меняло комментарии, вид товаров), скрыла формы регистрации при оплате, подключила слайдер
*
* NOTICE OF LICENSE
*
* This source file is subject to the Academic Free License (AFL 3.0)
* that is bundled with this package in the file LICENSE.txt.
* It is also available through the world-wide-web at this URL:
* http://opensource.org/licenses/afl-3.0.php
* If you did not receive a copy of the license and are unable to
* obtain it through the world-wide-web, please send an email
* to license@prestashop.com so we can send you a copy immediately.
*
* DISCLAIMER
*
* Do not edit or add to this file if you wish to upgrade PrestaShop to newer
* versions in the future. If you wish to customize PrestaShop for your
* needs please refer to http://www.prestashop.com for more information.
*
*  @author PrestaShop SA <contact@prestashop.com>
*  @copyright  2007-2015 PrestaShop SA
*  @license    http://opensource.org/licenses/afl-3.0.php  Academic Free License (AFL 3.0)
*  International Registered Trademark & Property of PrestaShop SA
*/
//global variables
var responsiveflag = false;

$(document).ready(function(){
	
	var PAYMENT = document.getElementById("payment_module_tat");
	var registering = document.getElementById("new_account_form");
	var registering1 = document.getElementById("login_form1");
if (PAYMENT!=undefined)//скрыла формы регистрации при оплате
{
	if (registering!=undefined)
	{
		jQuery('#new_account_form').css('display', 'none');
	}
	if (registering1!=undefined)
	{
		jQuery('#login_form1').css('display', 'none');
	}	
}


if (jQuery("#slider")!=undefined)//Слайдер homeslider.js
{
	if (jQuery("#slider").length>0)//Если главная страница
	{		
	  jQuery("#slider").owlCarousel({  
		autoPlay: 6000,
		singleItem : true
	 	});
 	}
}



//Кнопка подробнее и др. ссылки
jQuery(".zakaz").click(function()
{
	jQuery('.overlay').fadeIn(500);	
	jQuery(".popup").fadeIn(500);
});
jQuery('.overlay, .popupClose').click(function()
{
	jQuery('.overlay, .popup').css('display', 'none');
		
});

/*jQuery("#views_block ul li a").click(function()
{
	return false;
});*/


var pelement = document.getElementById("subcategory-heading");//Параграф
if (pelement)
{
	var URLKategorii = document.location.toString();//Адрес для определения какое название категории выводить	
	var i0=URLKategorii.indexOf("mebel");	
	if ( i0>-1)//Если страница категории мебели
	{
		pelement.firstChild.nodeValue = "Коллекции мебели для спальни"
		jQuery('.clearfix').addClass('mebel');	
	}
}


jQuery(".forma").submit(function()
{ // перехватываем все при событии отправки
var mail="zakaz@perrino-shop.ru";//Сюда следует ввести ящик админа
var newmail = mail.replace("@", "%40");//заменили в е-mail сайта знак @
	newmail="&email="+newmail;
		//var $message = '<?php echo $_POST["message"];?>';
		//alert ($message);	
		var form = jQuery(this); // запишем форму, чтобы потом не было проблем с this
		var error = false; // предварительно ошибок нет
		//alert("Pl");			
		if (!error) 
		{ // если ошибки нет
			var data = form.serialize(); // подготавливаем данные
			data = data + newmail;//Добавляем mail-адрес
			//alert(data);
			jQuery.ajax({ // инициализируем ajax запрос
			   type: 'POST', // отправляем в POST формате, можно GET
			   url: location.protocol + '//' + location.hostname + '/sendmail.php', // путь до обработчика, у нас он лежит в той же папке
			   dataType: 'json', // ответ ждем в json формате
			   data: data, // данные для отправки			   
		       beforeSend: function(data) { // событие до отправки
		            form.find('input[type="submit"]').attr('disabled', 'disabled'); // отключим кнопку, чтобы не жали по 100 раз
		          },
		       success: function(data){ // событие после удачного обращения к серверу и получения ответа
		       		if (data['error']) { // если обработчик вернул ошибку		       		
		       			alert(data['error']); // покажем её текст
		       		} else { // если все прошло ок
		       			alert('Спасибо за заявку! Мы свяжемся с Вами в ближайшее время'); // пишем что все ок
		       		}
		         },
		       error: function (xhr, ajaxOptions, thrownError) { // в случае неудачного завершения запроса к серверу		           
		            alert(xhr.status); // покажем ответ сервера
		            alert("Текст ошибки"+thrownError); // и текст ошибки
		         },
		       complete: function(data) { //событие после любого исхода
		       
		        form.find('input[type="submit"]').prop('disabled', false); // в любом случае включим кнопку обратно
		            form.find('input[type="email"]').val('');
		            form.find('input[type="text"]').val('');
		            form.find('textarea').val('');
		            form.find('input[type="submit"]').val('Отправлено');
		         }
		                  
			     });
			    
		}// если ошибки нет			 
				 return false; //вырубаем стандартную отправку формы				
	});


	
	highdpiInit();
	responsiveResize();
	$(window).resize(responsiveResize);
	if (navigator.userAgent.match(/Android/i))
	{
		var viewport = document.querySelector('meta[name="viewport"]');
		viewport.setAttribute('content', 'initial-scale=1.0,maximum-scale=1.0,user-scalable=0,width=device-width,height=device-height');
		window.scrollTo(0, 1);
	}
	if (typeof quickView !== 'undefined' && quickView)
		quick_view();
	dropDown();

	if (typeof page_name != 'undefined' && !in_array(page_name, ['index', 'product']))
	{
		bindGrid();

 		$(document).on('change', '.selectProductSort', function(e){
			if (typeof request != 'undefined' && request)
				var requestSortProducts = request;
 			var splitData = $(this).val().split(':');
			if (typeof requestSortProducts != 'undefined' && requestSortProducts)
				document.location.href = requestSortProducts + ((requestSortProducts.indexOf('?') < 0) ? '?' : '&') + 'orderby=' + splitData[0] + '&orderway=' + splitData[1];
    	});

		$(document).on('change', 'select[name="n"]', function(){
			$(this.form).submit();
		});

		$(document).on('change', 'select[name="currency_payement"]', function(){
			setCurrency($(this).val());
		});

        if($('.left #layered_block_left').length === 0){
            $('.sortPagiBar .select label').click(function(){

                var $for =  $(this).attr('for');
                var $i = $(this).children('i');
                var $class = $i.attr('class');
                $(this).siblings('label').children('i').removeClass();
                    switch ($class){
                        case 'asc':
                            sort_search_prod($for,true);
                            $i.removeClass().addClass('desc');
                            break;
                        case 'desc':
                            sort_search_prod($for,false);
                            $i.removeClass().addClass('asc');
                            break;
                        default :
                            sort_search_prod($for,false);
                            $i.addClass('asc');
                            break;
                    }
                if (typeof getcurrentcombs == 'function') {
                    getcurrentcombs()
                }else {
                }
                if(typeof getcomb == 'function'){getcomb()}
            });


	    }
    }

	$(document).on('change', 'select[name="manufacturer_list"], select[name="supplier_list"]', function(){
		if (this.value != '')
			location.href = this.value;
	});

	$(document).on('click', '.back', function(e){
		e.preventDefault();
		history.back();
	});

	jQuery.curCSS = jQuery.css;
	if (!!$.prototype.cluetip)
		$('a.cluetip').cluetip({
			local:true,
			cursor: 'pointer',
			dropShadow: false,
			dropShadowSteps: 0,
			showTitle: false,
			tracking: true,
			sticky: false,
			mouseOutClose: true,
			fx: {
		    	open:       'fadeIn',
		    	openSpeed:  'fast'
			}
		}).css('opacity', 0.8);

	if (!!$.prototype.fancybox)
		$.extend($.fancybox.defaults.tpl, {
			closeBtn : '<a title="' + FancyboxI18nClose + '" class="fancybox-item fancybox-close" href="javascript:;"></a>',
			next     : '<a title="' + FancyboxI18nNext + '" class="fancybox-nav fancybox-next" href="javascript:;"><span></span></a>',
			prev     : '<a title="' + FancyboxI18nPrev + '" class="fancybox-nav fancybox-prev" href="javascript:;"><span></span></a>'
		});

	// Close Alert messages
	$(".alert.alert-danger").on('click', this, function(e){
		$(this).fadeOut();
	});

    var offset = 100;
    var duration = 500;
    jQuery(window).scroll(function() {
        if (jQuery(this).scrollTop() > offset) {
            jQuery('.back-to-top').fadeIn(duration);
        } else {
            jQuery('.back-to-top').fadeOut(duration);
        }
    });

    jQuery('.back-to-top').click(function(event) {
        event.preventDefault();
        jQuery('html, body').animate({scrollTop: 0}, duration);
        return false;
    });

	var customBImg = $('.custom-block img');
	customBImg.wrap(function(){
		return '<a href="'+this.src+'" class="wrapper"></a>';
	});

	var  certImg = $('.cms-8 .rte img');
	certImg.wrap(function(){
		return '<a href="'+this.src+'" class="wrapper"></a>';
	});

	$(' .wrapper').fancybox();
	


    var $allVideos = $(".custom-block iframe"),
    $fluidEl = $(".custom-block");
	console.log($allVideos);

	$allVideos.each(function() {

	  $(this)
	    // jQuery .data does not work on object/embed elements
	    .attr('data-aspectRatio', this.height / this.width)
	    .removeAttr('height')
	    .removeAttr('width');

	});

	$(window).resize(function() {

	  var newWidth = $fluidEl.width();
	  $allVideos.each(function() {

	    var $el = $(this);
	    $el
	        .width(newWidth)
	        .height(newWidth * $el.attr('data-aspectRatio'));

	  });

	}).resize();
	
});




function highdpiInit()
{
	if($('.replace-2x').css('font-size') == "1px")
	{
		var els = $("img.replace-2x").get();
		for(var i = 0; i < els.length; i++)
		{
			src = els[i].src;
			extension = src.substr( (src.lastIndexOf('.') +1) );
			src = src.replace("." + extension, "2x." + extension);

			var img = new Image();
			img.src = src;
			img.height != 0 ? els[i].src = src : els[i].src = els[i].src;
		}
	}
}


// Used to compensante Chrome/Safari bug (they don't care about scroll bar for width)
function scrollCompensate()
{
    var inner = document.createElement('p');
    inner.style.width = "100%";
    inner.style.height = "200px";

    var outer = document.createElement('div');
    outer.style.position = "absolute";
    outer.style.top = "0px";
    outer.style.left = "0px";
    outer.style.visibility = "hidden";
    outer.style.width = "200px";
    outer.style.height = "150px";
    outer.style.overflow = "hidden";
    outer.appendChild(inner);

    document.body.appendChild(outer);
    var w1 = inner.offsetWidth;
    outer.style.overflow = 'scroll';
    var w2 = inner.offsetWidth;
    if (w1 == w2) w2 = outer.clientWidth;

    document.body.removeChild(outer);

    return (w1 - w2);
}

function responsiveResize()
{
	compensante = scrollCompensate();
	if (($(window).width()+scrollCompensate()) <= 767 && responsiveflag == false)
	{
		accordion('enable');
	    accordionFooter('enable');
		responsiveflag = true;
	}
	else if (($(window).width()+scrollCompensate()) >= 768)
	{
		accordion('disable');
		accordionFooter('disable');
	    responsiveflag = false;
	}
	blockHover();
}

function blockHover(status)
{
	var screenLg = $('body').find('.container').width() == 1170;

	if (screenLg)
		$('.product_list .button-container').hide();
	else
		$('.product_list .button-container').show();

	$(document).off('mouseenter').on('mouseenter', '.product_list.grid li.ajax_block_product .product-container', function(e){
		if (screenLg)
		{
			var pcHeight = $(this).parent().outerHeight();
			var pcPHeight = $(this).parent().find('.button-container').outerHeight() + $(this).parent().find('.comments_note').outerHeight() + $(this).parent().find('.functional-buttons').outerHeight();
			$(this).parent().addClass('hovered').css({'height':pcHeight + pcPHeight, 'margin-bottom':pcPHeight * (-1)});
			$(this).find('.button-container').show();
		}
	});

	$(document).off('mouseleave').on('mouseleave', '.product_list.grid li.ajax_block_product .product-container', function(e){
		if (screenLg)
		{
			$(this).parent().removeClass('hovered').css({'height':'auto', 'margin-bottom':'0'});
			$(this).find('.button-container').hide();
		}
	});
}

function quick_view()
{
	$(document).on('click', '.quick-view:visible, .quick-view-mobile:visible', function(e){
		e.preventDefault();
		var url = this.rel;
		if (url.indexOf('?') != -1)
			url += '&';
		else
			url += '?';

		if (!!$.prototype.fancybox)
			$.fancybox({
				'padding':  0,
				'width':    1087,
				'height':   610,
				'type':     'iframe',
				'href':     url + 'content_only=1'
			});
	});
}

function bindGrid()
{
	var view = $.totalStorage('display');

	if (!view && (typeof displayList != 'undefined') && displayList)
		view = 'list';

	if (view && view != 'grid')
		display(view);
	else
		$('.display').find('li#grid').addClass('selected');

	$(document).on('click', '#grid', function(e){
		e.preventDefault();
		display('grid');
	});

	$(document).on('click', '#list', function(e){
		e.preventDefault();
		display('list');
	});
}

function display(view)
{
	if (view == 'list')//Если вид выводимой категории - лист. Много поменяла и отключила вообще
	{
		/*$('ul.product_list').removeClass('grid').addClass('list row');
		$('.product_list > li').removeClass('col-xs-12 col-sm-6 col-md-4');
		$('.product_list > li').each(function(index, element) {
			html = '';			
				html += $(element).find('.cat_img').html() + '</div>';
					var rating = $(element).find('.comments_note').html(); // check : rating
					if (rating != null) {
						html += '<div itemprop="aggregateRating" itemscope itemtype="http://schema.org/AggregateRating" class="comments_note">'+ rating + '</div>';
					}
					var colorList = $(element).find('.color-list-container').html();
					if (colorList != null) {
						html += '<div class="color-list-container">'+ colorList +'</div>';
					}
					var availability = $(element).find('.availability').html();	// check : catalog mode is enabled
					if (availability != null) {
						html += '<span class="availability">'+ availability +'</span>';
					}
				html += '<h5 itemprop="name">'+ $(element).find('h5').html() + '</h5>';
				html += '<div class="right-block col-xs-4 col-xs-12 col-md-4"><div class="right-block-content row">';
					var price = $(element).find('.cat_cena').html();       // check : catalog mode is enabled
					if (price != null) {
						html += '<div class="cat_cena">'+ price + '</div>';
					}
					html += '<div class="button-container col-xs-7 col-md-12">'+ $(element).find('.button-container').html() +'</div>';
					html += '<div class="functional-buttons clearfix col-sm-12">' + $(element).find('.functional-buttons').html() + '</div>';
			html += '</div>';
		$(element).html(html);
		});
		$('.display').find('li#list').addClass('selected');
		$('.display').find('li#grid').removeAttr('class');
		$.totalStorage('display', 'list');*/
	}
	else//Если вид выводимой категории - сетка. Не наш случай
	{
		$('ul.product_list').removeClass('list').addClass('grid row');
		$('.product_list > li').removeClass('col-xs-12').addClass('col-xs-12 col-sm-6 col-md-4');
		$('.product_list > li').each(function(index, element) {
		html = '';
		html += '<div class="product-container">';
			html += '<div class="left-block">' + $(element).find('.left-block').html() + '</div>';
			html += '<div class="right-block">';
				html += '<div class="product-flags">'+ $(element).find('.product-flags').html() + '</div>';
				html += '<h5 itemprop="name">'+ $(element).find('h5').html() + '</h5>';
				var rating = $(element).find('.comments_note').html(); // check : rating
					if (rating != null) {
						html += '<div itemprop="aggregateRating" itemscope itemtype="http://schema.org/AggregateRating" class="comments_note">'+ rating + '</div>';
					}
				html += '<p itemprop="description" class="product-desc">'+ $(element).find('.product-desc').html() + '</p>';
				var price = $(element).find('.cat_cena').html(); // check : catalog mode is enabled
					if (price != null) {
						html += '<div class="cat_cena">'+ price + '</div>';
					}
				html += '<div itemprop="offers" itemscope itemtype="http://schema.org/Offer" class="button-container">'+ $(element).find('.button-container').html() +'</div>';
				var colorList = $(element).find('.color-list-container').html();
				if (colorList != null) {
					html += '<div class="color-list-container">'+ colorList +'</div>';
				}
				var availability = $(element).find('.availability').html(); // check : catalog mode is enabled
				if (availability != null) {
					html += '<span class="availability">'+ availability +'</span>';
				}
			html += '</div>';
			html += '<div class="functional-buttons clearfix">' + $(element).find('.functional-buttons').html() + '</div>';
		html += '</div>';
		$(element).html(html);
		});
		$('.display').find('li#grid').addClass('selected');
		$('.display').find('li#list').removeAttr('class');
		$.totalStorage('display', 'grid');
	}
}

function dropDown()
{
	elementClick = '#header .current';
	elementSlide =  'ul.toogle_content';
	activeClass = 'active';

	$(elementClick).on('click', function(e){
		e.stopPropagation();
		var subUl = $(this).next(elementSlide);
		if(subUl.is(':hidden'))
		{
			subUl.slideDown();
			$(this).addClass(activeClass);
		}
		else
		{
			subUl.slideUp();
			$(this).removeClass(activeClass);
		}
		$(elementClick).not(this).next(elementSlide).slideUp();
		$(elementClick).not(this).removeClass(activeClass);
		e.preventDefault();
	});

	$(elementSlide).on('click', function(e){
		e.stopPropagation();
	});

	$(document).on('click', function(e){
		e.stopPropagation();
		var elementHide = $(elementClick).next(elementSlide);
		$(elementHide).slideUp();
		$(elementClick).removeClass('active');
	});
}

function accordionFooter(status)
{
	if(status == 'enable')
	{
		$('#footer .footer-block h4').on('click', function(){
			$(this).toggleClass('active').parent().find('.toggle-footer').stop().slideToggle('medium');
		})
		$('#footer').addClass('accordion').find('.toggle-footer').slideUp('fast');
	}
	else
	{
		$('.footer-block h4').removeClass('active').off().parent().find('.toggle-footer').removeAttr('style').slideDown('fast');
		$('#footer').removeClass('accordion');
	}
}

function accordion(status)
{
	leftColumnBlocks = $('#left_column');
	if(status == 'enable')
	{
		var accordion_selector = '#right_column .block .title_block, #left_column .block .title_block, #left_column #newsletter_block_left h4,' +
								'#left_column .shopping_cart > a:first-child, #right_column .shopping_cart > a:first-child';

		$(accordion_selector).on('click', function(e){
			$(this).toggleClass('active').parent().find('.block_content').stop().slideToggle('medium');
		});
		$('#right_column, #left_column').addClass('accordion').find('.block .block_content').slideUp('fast');
	}
	else
	{
		$('#right_column .block .title_block, #left_column .block .title_block, #left_column #newsletter_block_left h4').removeClass('active').off().parent().find('.block_content').removeAttr('style').slideDown('fast');
		$('#left_column, #right_column').removeClass('accordion');
	}
}

var sort_by = function (path, reverse, primer, then) {
    var get = function (obj, path) {
            if (path) {
                path = path.split('.');
                for (var i = 0, len = path.length - 1; i < len; i++) {
                    obj = obj[path[i]];
                }
                return obj[path[len]];
            }
            return obj;
        },
        prime = function (obj) {
            return primer ? primer(get(obj, path)) : get(obj, path);
        };

    return function (a, b) {
        var A = prime(a),
            B = prime(b);

        return (
            (A < B) ? -1 :
                (A > B) ?  1 :
                    (typeof then === 'function') ? then(a, b) : 0
            ) * [1,-1][+!!reverse];
    };
};
// Working with search

function sort_search_prod(field,order){
    var it = 0;
    var co = 0;
    var block_prods = $('.ajax_block_product');
    var fil_arr = [];

    for(it=0,co = block_prods.length;it<co;it++ ){
        var new_price = $(block_prods[it]).find('.our_price_display').text();
        var old_price = $(block_prods[it]).find('.old_price_display').text();
        var name = $(block_prods[it]).find('.cat_title h3').text();
        fil_arr[it] = {'prod':block_prods[it],'price':new_price?new_price:old_price,'name':name};
    }

    var jqsotr = [];
    if(field==='price') fil_arr.sort(sort_by(field, order, parseFloat));
    if(field==='name')  fil_arr.sort(sort_by(field, order, function(a){return a.toUpperCase()}));
    for(it=0,co = fil_arr.length;it<co;it++){
        jqsotr[it] = fil_arr[it].prod;
    }

    $('.product_list').html($(jqsotr));
    
}


if(typeof page_name !== 'undefined' && !in_array(page_name,['index','product'])){

    var combs = '';
    var globalQuantity = 0;
    var curSelect = '';
    var combinationsFromController='';
    var default_eco_tax = '';
    var selectedCombination = [];
    var productBasePriceTaxExcl = '';
    var changed = false;
    var otherGroups = '';
    var i = 0;
    var GroupClass = '.group_6, .group_11, .group_9, .group_13';

    jQuery(document).ready(function($){
        getcomb();
        getcurrentcombs();
    });

    function getcomb(){
        $('.attribute_select').change(function(){
            curSelect = $(this);



            if(curSelect.is(GroupClass) ){
                var valueSelected = this.value;
                var  allGroups = $(GroupClass);

                var otherGroups = allGroups.not(this);
                /*                        if(i>allGroups.length && otherGroups.length !==0){
                 i=0;
                 changed = false;
                 return;
                 }*/

                otherGroups.each(function(){
                    $(this).find('option').each(function(){
                        if(valueSelected == $(this).val()){
                            $(this).prop('selected','selected');
                        }
                    });
                });

                for(g=0;g<allGroups.length;g++){
                    curSelect = $(allGroups[g]);
                    setPrice();
                }
            } else{
                setPrice();
            }



            function setPrice(){
                default_eco_tax = curSelect.closest('li').find('.cat_cena').data('ecotax');
                productBasePriceTaxExcl = curSelect.closest('li').find('.cat_cena').data('productbpexcl');

                combs = allcombinations[parseFloat(curSelect.data('product_id'))];

                if (typeof combs !== 'undefined' && combs){
                    combs =  foreachcombs(combs);
                }
                if(typeof combs!=='undefined' && combs){
                    findCombination(combs);
                }
            }

        });


    }
    function foreachcombs(combs){
        combinationsFromController = combs;
        combsJS = [];
        var k = 0;
        for (var i in combs)
        {
            globalQuantity += combs[i]['quantity'];
            combsJS[k] = [];
            combsJS[k]['idCombination'] = parseInt(i);
            combsJS[k]['idsAttributes'] = combs[i]['attributes'];
            combsJS[k]['quantity'] = combs[i]['quantity'];
            combsJS[k]['price'] = combs[i]['price'];
            combsJS[k]['ecotax'] = combs[i]['ecotax'];
            combsJS[k]['image'] = parseInt(combs[i]['id_image']);
            combsJS[k]['reference'] = combs[i]['reference'];
            combsJS[k]['unit_price'] = combs[i]['unit_impact'];
            combsJS[k]['minimal_quantity'] = parseInt(combs[i]['minimal_quantity']);

            combsJS[k]['available_date'] = [];
            combsJS[k]['available_date']['date'] = combs[i]['available_date'];
            combsJS[k]['available_date']['date_formatted'] = combs[i]['date_formatted'];

            combsJS[k]['specific_price'] = [];
            combsJS[k]['specific_price']['reduction_percent'] = (combs[i]['specific_price'] && combs[i]['specific_price']['reduction'] && combs[i]['specific_price']['reduction_type'] == 'percentage') ? combs[i]['specific_price']['reduction'] * 100 : 0;
            combsJS[k]['specific_price']['reduction_price'] = (combs[i]['specific_price'] && combs[i]['specific_price']['reduction'] && combs[i]['specific_price']['reduction_type'] == 'amount') ? combs[i]['specific_price']['reduction'] : 0;
            combsJS[k]['price'] = (combs[i]['specific_price'] && combs[i]['specific_price']['price'] && parseInt(combs[i]['specific_price']['price']) != -1) ? combs[i]['specific_price']['price'] :  combs[i]['price'];

            combsJS[k]['reduction_type'] = (combs[i]['specific_price'] && combs[i]['specific_price']['reduction_type']) ? combs[i]['specific_price']['reduction_type'] : '';
            combsJS[k]['id_product_attribute'] = (combs[i]['specific_price'] && combs[i]['specific_price']['id_product_attribute']) ? combs[i]['specific_price']['id_product_attribute'] : 0;
            k++;
        }
        return combsJS;


    }
    function findCombination(combs){





        $('#minimal_quantity_wanted_p').fadeOut();
        if (typeof $('#minimal_quantity_label').text() === 'undefined' || $('#minimal_quantity_label').html() > 1)
            $('#quantity_wanted').val(1);

        //create a temporary 'choice' array containing the choices of the customer
        var choice = [];


        curSelect.closest('li').find('select').each(function(){
            choice.push(parseInt($(this).val()));
        }); // todo Remove all unused field




        if (typeof combs == 'undefined' || !combs)
            combs = [];

        //testing every combs to find the conbination's attributes' case of the user
        for (var comb = 0; comb < combs.length; ++comb)
        {
            //verify if this combinaison is the same that the user's choice



            var combsMatchForm = true;
            $.each(combs[comb]['idsAttributes'], function(key, value)
            {
                if (!in_array(parseInt(value), choice))
                    combsMatchForm = false;
            });

            if (combsMatchForm)
            {

                if (combs[comb]['minimal_quantity'] > 1)
                {
                    $('#minimal_quantity_label').html(combs[comb]['minimal_quantity']);
                    $('#minimal_quantity_wanted_p').fadeIn();
                    $('#quantity_wanted').val(combs[comb]['minimal_quantity']);
                    $('#quantity_wanted').bind('keyup', function() {checkMinimalQuantity(combs[comb]['minimal_quantity']);});
                }
                //combination of the user has been found in our specifications of combinations (created in back office)
                selectedCombination['unavailable'] = false;
                selectedCombination['reference'] = combs[comb]['reference'];

                curSelect.closest('li').find('.cat_cena').find('.idCombination').val(combs[comb]['idCombination']);



                //get the data of product with these attributes
                quantityAvailable = combs[comb]['quantity'];
                selectedCombination['price'] = combs[comb]['price'];
                selectedCombination['unit_price'] = combs[comb]['unit_price'];
                selectedCombination['specific_price'] = combs[comb]['specific_price'];
                if (combs[comb]['ecotax'])
                    selectedCombination['ecotax'] = combs[comb]['ecotax'];
                else
                    selectedCombination['ecotax'] = default_eco_tax;

                //show the large image in relation to the selected combination


                //show discounts values according to the selected combination
                if (combs[comb]['idCombination'] && combs[comb]['idCombination'] > 0)
                //    displayDiscounts(combs[comb]['idCombination']);

                //get available_date for combination product
                    selectedCombination['available_date'] = combs[comb]['available_date'];

                //update the display
                updatePrice();


                //leave the function because combination has been found
                return;
            }
        }

        //this combs doesn't exist (not created in back office)

        selectedCombination['unavailable'] = true;
        if (typeof(selectedCombination['available_date']) != 'undefined')
            delete selectedCombination['available_date'];

        updatePrice();
    }
    function updatePrice() {
        // Get combination prices




        var combID = curSelect.closest('li').find('.cat_cena').find('.idCombination').val();
        var combination = combinationsFromController[combID];







        if (typeof combination == 'undefined')
            return;



        // Set product (not the combination) base price

        var basePriceWithoutTax = productBasePriceTaxExcl;
        var priceWithGroupReductionWithoutTax = 0;


        // Apply combination price impact
        // 0 by default, +x if price is inscreased, -x if price is decreased


        basePriceWithoutTax = basePriceWithoutTax + +combination.price;

        // If a specific price redefine the combination base price
        if (combination.specific_price && combination.specific_price.price > 0)
        {
            if (combination.specific_price.id_product_attribute === 0)
                basePriceWithoutTax = +combination.specific_price.price;
            else
                basePriceWithoutTax = +combination.specific_price.price + +combination.price;
        }

        // Apply group reduction

        priceWithGroupReductionWithoutTax = basePriceWithoutTax * (1 - parseInt(curSelect.closest('li').find('.cat_cena').data('group-reduction')));
        var priceWithDiscountsWithoutTax = priceWithGroupReductionWithoutTax;



        // Apply specific price (discount)
        // We only apply percentage discount and discount amount given before tax
        // Specific price give after tax will be handled after taxes are added
        if (combination.specific_price && combination.specific_price.reduction > 0)
        {
            if (combination.specific_price.reduction_type == 'amount')
            {
                if (typeof combination.specific_price.reduction_tax !== 'undefined' && combination.specific_price.reduction_tax === "0")
                {
                    var reduction = +combination.specific_price.reduction / currencyRate;
                    priceWithDiscountsWithoutTax -= reduction;
                }
            }
            else if (combination.specific_price.reduction_type == 'percentage')
            {
                priceWithDiscountsWithoutTax = priceWithDiscountsWithoutTax * (1 - +combination.specific_price.reduction);

            }
        }




        // Apply Tax if necessary

        var noTaxForThisProduct = curSelect.closest('li').find('.cat_cena').data('no_tax');
        var customerGroupWithoutTax = curSelect.closest('li').find('.cat_cena').data('customer_group_without_tax');
        var taxRate = curSelect.closest('li').find('.cat_cena').data('taxrate');
        var ecotaxTax_rate = curSelect.closest('li').find('.cat_cena').data('ecotaxrate');

        if (noTaxForThisProduct || customerGroupWithoutTax)
        {
            basePriceDisplay = basePriceWithoutTax;
            priceWithDiscountsDisplay = priceWithDiscountsWithoutTax;
        }
        else
        {
            basePriceDisplay = basePriceWithoutTax * (taxRate/100 + 1);
            priceWithDiscountsDisplay = priceWithDiscountsWithoutTax * (taxRate/100 + 1);

        }



        if (default_eco_tax)
        {
            // combination.ecotax doesn't modify the price but only the display
            basePriceDisplay = basePriceDisplay + default_eco_tax * (1 + ecotaxTax_rate / 100);
            priceWithDiscountsDisplay = priceWithDiscountsDisplay + default_eco_tax * (1 + ecotaxTax_rate / 100);
        }

        // If the specific price was given after tax, we apply it now
        if (combination.specific_price && combination.specific_price.reduction > 0)
        {
            if (combination.specific_price.reduction_type == 'amount')
            {
                if (typeof combination.specific_price.reduction_tax === 'undefined'
                    || (typeof combination.specific_price.reduction_tax !== 'undefined' && combination.specific_price.reduction_tax === '1'))
                {
                    var reduction = +combination.specific_price.reduction / currencyRate;
                    priceWithDiscountsDisplay -= reduction;
                    // We recalculate the price without tax in order to keep the data consistency
                    priceWithDiscountsWithoutTax = priceWithDiscountsDisplay - reduction * ( 1/(1+taxRate/100) );
                }
            }
        }

        // Compute discount value and percentage
        // Done just before display update so we have final prices




        if (basePriceDisplay != priceWithDiscountsDisplay)
        {
            var discountValue = basePriceDisplay - priceWithDiscountsDisplay;
            var discountPercentage = (1-(priceWithDiscountsDisplay/basePriceDisplay))*100;
        }




        var unit_impact = +combination.unit_impact;
        var productUnitPriceRatio = curSelect.closest('li').find('.cat_cena').data('unit_price_ratio');
        if (productUnitPriceRatio > 0 || unit_impact)
        {
            if (unit_impact)
            {
                baseUnitPrice = productBasePriceTaxExcl / productUnitPriceRatio;
                unit_price = baseUnitPrice + unit_impact;

                if (!noTaxForThisProduct || !customerGroupWithoutTax)
                    unit_price = unit_price * (taxRate/100 + 1);
            }
            else
                unit_price = priceWithDiscountsDisplay / productUnitPriceRatio;
        }

        /*  Update the page content, no price calculation happens after */

        // Hide everything then show what needs to be shown
        $('#reduction_percent').hide();
        $('#reduction_amount').hide();



        var old_price = curSelect.closest('li').find('.cat_cena').find('.old_price_display');
        old_price.hide();

        // $('#old_price,,#old_price_display_taxes').hide();
        $('.price-ecotax').hide();
        $('.unit-price').hide();

        curSelect.closest('li').find('.cat_cena').find('.our_price_display').text(Math.round(priceWithDiscountsDisplay)).trigger('change');



        // If the calculated price (after all discounts) is different than the base price
        // we show the old price striked through





        if (priceWithDiscountsDisplay.toFixed(2) != basePriceDisplay.toFixed(2))
        {

            old_price.text(basePriceDisplay);

            old_price.show();

            // Then if it's not only a group reduction we display the discount in red box
            if (priceWithDiscountsWithoutTax != priceWithGroupReductionWithoutTax)
            {
                if (combination.specific_price.reduction_type == 'amount')
                {
                    $('#reduction_amount_display').html('-' + formatCurrency(+discountValue * currencyRate, currencyFormat, currencySign, currencyBlank));
                    $('#reduction_amount').show();
                }
                else
                {
                    $('#reduction_percent_display').html('-' + parseFloat(discountPercentage).toFixed(0) + '%');
                    $('#reduction_percent').show();
                }
            }
        }

        // Green Tax (Eco tax)
        // Update display of Green Tax
        if (default_eco_tax)
        {
            ecotax = default_eco_tax;

            // If the default product ecotax is overridden by the combination
            if (combination.ecotax)
                ecotax = +combination.ecotax;

            if (!noTaxForThisProduct)
                ecotax = ecotax * (1 + ecotaxTax_rate/100);

            $('#ecotax_price_display').text(formatCurrency(ecotax * currencyRate, currencyFormat, currencySign, currencyBlank));
            $('.price-ecotax').show();
        }

        // Unit price are the price per piece, per Kg, per m²
        // It doesn't modify the price, it's only for display
        if (productUnitPriceRatio > 0)
        {
            $('#unit_price_display').text(formatCurrency(unit_price * currencyRate, currencyFormat, currencySign, currencyBlank));
            $('.unit-price').show();
        }

        // If there is a quantity discount table,
        // we update it according to the new price
        // updateDiscountTable(priceWithDiscountsDisplay);

    }
    function getcurrentcombs(){
        $('.product_list li').each(function(){
            var choice = [];
            $(this).find('.attribute_select').each(function(){
                choice.push(parseInt($(this).val()));
            }); // todo Remove all unused field

            var id_product = $(this).find('.ajax_add_to_cart_button').data('id-product');
            if(typeof  allcombinations === 'undefined'){
                return console.log('combinations not found');
            }
            combs = foreachcombs(allcombinations[id_product]);
            if (typeof combs == 'undefined' || !combs)
                combs = [];
            //testing every combs to find the conbination's attributes' case of the user
            for (var comb = 0; comb < combs.length; ++comb)
            {




                var combsMatchForm = true;
                $.each(combs[comb]['idsAttributes'], function(key, value)
                {
                    if (!in_array(parseInt(value), choice))
                        combsMatchForm = false;
                });

                if (combsMatchForm)
                {
                    // Todo decide remove it or not
                    if (combs[comb]['minimal_quantity'] > 1)
                    {
                        $('#minimal_quantity_label').html(combs[comb]['minimal_quantity']);
                        $('#minimal_quantity_wanted_p').fadeIn();
                        $('#quantity_wanted').val(combs[comb]['minimal_quantity']);
                        $('#quantity_wanted').bind('keyup', function() {checkMinimalQuantity(combs[comb]['minimal_quantity']);});
                    }
                    $(this).find('.idCombination').val(combs[comb]['idCombination']);

                }
            }


        });

    }
}


