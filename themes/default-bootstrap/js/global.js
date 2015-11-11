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
                    console.log('function defined');
                    getcurrentcombs()
                }else {
                    console.log('function undefined')
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
jQuery(document).ready(function($){

});