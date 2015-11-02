/*
* 2007-2015 PrestaShop _tat_ Щелчок по селекту фильтра _tat_ самый главный файл перезагрузки фильтра и ещё кое что
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
*  International Registred Trademark & Property of PrestaShop SA
*/

var ajaxQueries = new Array();
var ajaxLoaderOn = 0;
var sliderList = new Array();
var slidersInit = false;

$(document).ready(function()
{
	openpxpCloseFilter();
	if ($("#subcategories")==undefined || $("#subcategories").length==0)
	{
  		jQuery('.descriptionCategory').css('display', 'block');  		
  	}
	
	$(document).on('change', '.layered_pxp_form .select', function(e) {
		//alert('a');
		 var indexEl  = $('option:selected', this).index(); 
      //var valEl  = $('option:selected', this).val();
      $('.layered_pxp_form .select option').each( function () 
      {
		if($(this).index() == indexEl)
		{
			$(this).attr('selected', 'selected');
		}
		else
		{
			$(this).removeAttr("selected");
		}	
	  });
     
      reloadpxpContent(true);	
	});	

	//$(document).on('click', '.layered_pxp_form .select', function(e) {//Было заккоментировано
		//alert("f"); _tat_ Щелчок по селекту фильтра
		/*$('.layered_pxp_form .select option').each(function() 
		{
			if ($(this).attr('selected'))
			{
				if ($(this).attr('selected')!="undefined")
				{
					//$(this).attr('selected')='';
					setTimeout(function() {
						$(this).attr('selected', '');
						alert('а');
					}, 1000);
					//alert($(this).attr('selected'));
					//alert('a');
				}	
			}
			
		});*/
		//div:not(.lBox)
		//alert('b');
	//$('.layered_pxp_form .select option').attr('selected', '');
		//alert($(this).attr('selected'));		
	//reloadpxpContent(true);		
		//alert($(this).val());
		//alert($(this).text());
	//});
	
	
	
	
	
	/*var ColorSel2 = $('.layered_pxp_form select').change(function () {
		alert('b');
	});*/  
	
	
	
	
});

function initpxpFilters()
{
	//alert('2'); Без этого не обновляются размеры
	if (typeof filters !== 'undefined')
	{
		for (key in filters)
		{
			if (filters.hasOwnProperty(key))
				var filter = filters[key];

			if (typeof filter.slider !== 'undefined' && parseInt(filter.filter_type) == 0)
			{
				var filterRange = parseInt(filter.max)-parseInt(filter.min);
				var step = filterRange / 100;

				if (step > 1)
					step = parseInt(step);

				addpxpSlider(filter.type,
				{
					range: true,
					step: step,
					min: parseInt(filter.min),
					max: parseInt(filter.max),
					values: [filter.values[0], filter.values[1]],
					slide: function(event, ui) {
						
						if (parseInt($(event.target).data('format')) < 5)
						{
							from = formatCurrency(ui.values[0], parseInt($(event.target).data('format')),
								$(event.target).data('unit'));
							to = formatCurrency(ui.values[1], parseInt($(event.target).data('format')),
								$(event.target).data('unit'));
						}
						else
						{
							from = ui.values[0] + $(event.target).data('unit');
							to = ui.values[1] + $(event.target).data('unit');
						}

						$('#layered_' + $(event.target).data('type') + '_range').html(from + ' - ' + to);
					},
					stop: function () {
						reloadpxpContent(true);
					}
				}, filter.unit, parseInt(filter.format));
			}
			else if(typeof filter.slider !== 'undefined' && parseInt(filter.filter_type) == 1)
			{
				$('#layered_' + filter.type + '_range_min').attr('limitValue', filter.min);
				$('#layered_' + filter.type + '_range_max').attr('limitValue', filter.max);
			}
			
			$('.layered_' + filter.type).show();
		}
		initpxpUniform();
	}	
}

function initpxpUniform()
{
	//alert('3'); Без этого не обновляются размеры
	$(".layered_pxp_form input[type='checkbox'], .layered_pxp_form input[type='radio'], select.form-control").uniform();
}


function addpxpSlider(type, data, unit, format)//Нужен
{
	//alert('4');
	sliderList.push({
		type: type,
		data: data,
		unit: unit,
		format: format
	});
}

function openpxpCloseFilter()
{
	//alert('9');Без этого картинка меняется только у одного товара
	$(document).on('click', '.layered_pxp_form span.layered_close a', function(e)
	{
		if ($(this).html() == '&lt;')
		{
			$('#'+$(this).data('rel')).show();
			$(this).html('v');
			$(this).parent().removeClass('closed');
		}
		else
		{
			$('#'+$(this).data('rel')).hide();
			$(this).html('&lt;');
			$(this).parent().addClass('closed');
		}

		e.preventDefault();
	});
}








function reloadpxpContent(params_plus)//Перезагрузка контента
{
		if ($(".left .select :nth-child(1)") && $(".left .select :nth-child(1)").length>0)
	{
		$(".left .select :nth-child(1)").attr("selected", "selected");//Обнуляю значение левого фильтра	
	}
	

	if (!ajaxLoaderOn)
	{
		$('.product_list').prepend($('#layered_ajax_loader').html());//Весь ul продуктов
		$('.product_list').css('opacity', '0.7');
		ajaxLoaderOn = 1;
	}

	data = $('.layered_pxp_form').serialize();
	$('.layered_pxp_form .select option').each( function () {
		if($(this).attr('id') && $(this).parent().val() == $(this).val())
			data += '&'+$(this).attr('id') + '=' + $(this).val();
	});

	if ($('.selectProductSort').length && $('.selectProductSort').val())
	{
		if ($('.selectProductSort').val().search(/orderby=/) > 0)
		{
			// Old ordering working
			var splitData = [
				$('.selectProductSort').val().match(/orderby=(\w*)/)[1],
				$('.selectProductSort').val().match(/orderway=(\w*)/)[1]
			];
		}
		else
		{
			// New working for default theme 1.4 and theme 1.5
			var splitData = $('.selectProductSort').val().split(':');
		}
		data += '&orderby='+splitData[0]+'&orderway='+splitData[1];
	}
	if ($('select[name=n]:first').length)
	{
		if (params_plus)
			data += '&n=' + $('select[name=n]:first').val();
		else
			data += '&n=' + $('div.pagination form.showall').find('input[name=n]').val();
	}

	var slideUp = true;
	if (params_plus == undefined || !(typeof params_plus == 'string'))
	{
		params_plus = '';
		slideUp = false;
	}

	// Get nb items per page
	var n = '';
	if (params_plus)
	{
		$('div.pagination select[name=n]').children().each(function(it, option) {
			if (option.selected)
			{
				//alert('a')Странно, но нужно, зависает без этого
				n = '&n=' + option.value;				
			}
				
		});
	}
	ajaxQuery = $.ajax(
	{
		type: 'GET',
		url: baseDir + 'modules/blockpxplay/blockpxplay-ajax.php',
		data: data+params_plus+n,
		dataType: 'json',
		cache: false, // @todo see a way to use cache and to add a timestamps parameter to refresh cache each 10 minutes for example
		success: function(result)
		{
			if (result.meta_description != '')
				$('meta[name="description"]').attr('content', result.meta_description);

			if (result.meta_keywords != '')
				$('meta[name="keywords"]').attr('content', result.meta_keywords);

			if (result.meta_title != '')
				$('title').html(result.meta_title);

			if (result.heading != '')
				$('h1.page-heading .cat-name').html(result.heading);

			$('#layered_block_left1').replaceWith(utf8_decode(result.filtersBlock));//Меняет вид фильтра слева, на размеры. поэтому убрала
			$('.category-product-count, .heading-counter').html(result.categoryCount);

			if (result.nbRenderedProducts == result.nbAskedProducts)
				$('div.clearfix.selector1').hide();

			if (result.productList)
				$('.product_list').replaceWith(utf8_decode(result.productList));
			else
				$('.product_list').html('');

			$('.product_list').css('opacity', '1');
			if ($.browser.msie) // Fix bug with IE8 and aliasing
				$('.product_list').css('filter', '');

			if (result.pagination.search(/[^\s]/) >= 0)
			{
				var pagination = $('<div/>').html(result.pagination)
				var pagination_bottom = $('<div/>').html(result.pagination_bottom);

				if ($('<div/>').html(pagination).find('#pagination').length)
				{
					$('#pagination').show();
					$('#pagination').replaceWith(pagination.find('#pagination'));
				}
				else
					$('#pagination').hide();

				if ($('<div/>').html(pagination_bottom).find('#pagination_bottom').length)
				{
					$('#pagination_bottom').show();
					$('#pagination_bottom').replaceWith(pagination_bottom.find('#pagination_bottom'));
				}
				else
					$('#pagination_bottom').hide();
			}
			else
			{
				$('#pagination').hide();
				$('#pagination_bottom').hide();
			}

			ajaxLoaderOn = 0;

			// On submiting nb items form, relaod with the good nb of items
			$('div.pagination form').on('submit', function(e)
			{
				e.preventDefault();
				val = $('div.pagination select[name=n]').val();
			
				$('div.pagination select[name=n]').children().each(function(it, option) {
					//Кажется устанавливает select
					if (option.value == val)
					{
						//alert('d');
						$(option).attr('selected', true);
					}						
					else
						//alert('b');
						$(option).removeAttr('selected');
				});

				// Reload products and pagination
				
  	
				reloadpxpContent();//Все показывает значения при загрузке
			});
			if (typeof(ajaxCart) != "undefined")
				ajaxCart.overrideButtonsInThePage();

			if (typeof(reloadProductComparison) == 'function')
				reloadProductComparison();

			filters = result.filters;
			initpxpFilters();
			

			current_friendly_url = result.current_friendly_url;

			// Currente page url
			if (typeof(current_friendly_url) === 'undefined')
				current_friendly_url = '#';

			// Get all sliders value
			$(['price', 'weight']).each(function(it, sliderType)
			{
				if ($('#layered_'+sliderType+'_slider').length)
				{
					// Check if slider is enable & if slider is used
					if (typeof($('#layered_'+sliderType+'_slider').slider('values', 0)) != 'object')
					{
						if ($('#layered_'+sliderType+'_slider').slider('values', 0) != $('#layered_'+sliderType+'_slider').slider('option' , 'min')
						|| $('#layered_'+sliderType+'_slider').slider('values', 1) != $('#layered_'+sliderType+'_slider').slider('option' , 'max'))
							current_friendly_url += '/'+blockpxplaySliderName[sliderType]+'-'+$('#layered_'+sliderType+'_slider').slider('values', 0)+'-'+$('#layered_'+sliderType+'_slider').slider('values', 1)
					}
				}
				else if ($('#layered_'+sliderType+'_range_min').length)
					current_friendly_url += '/'+blockpxplaySliderName[sliderType]+'-'+$('#layered_'+sliderType+'_range_min').val()+'-'+$('#layered_'+sliderType+'_range_max').val();
			});

			window.location.href = current_friendly_url;

			if (current_friendly_url != '#/show-all')
				$('div.clearfix.selector1').show();
			
			lockLocationChecking = true;

			if (slideUp)
				$.scrollTo('.product_list', 400);
			
			$('.hide-action').each(function() {
				hideFilterValueAction(this);
			});

			if (display instanceof Function) {
				var view = $.totalStorage('display');

				if (view && view != 'grid')
					display(view);
			}
		}
	});
	ajaxQueries.push(ajaxQuery);
}



/**
 * Copy of the php function utf8_decode()
 */
function utf8_decode (utfstr)
{
	//alert('14');Загружает весь контент
	var res = '';
	for (var i = 0; i < utfstr.length;) {
		var c = utfstr.charCodeAt(i);

		if (c < 128)
		{
			res += String.fromCharCode(c);
			i++;
		}
		else if((c > 191) && (c < 224))
		{
			var c1 = utfstr.charCodeAt(i+1);
			res += String.fromCharCode(((c & 31) << 6) | (c1 & 63));
			i += 2;
		}
		else
		{
			var c1 = utfstr.charCodeAt(i+1);
			var c2 = utfstr.charCodeAt(i+2);
			res += String.fromCharCode(((c & 15) << 12) | ((c1 & 63) << 6) | (c2 & 63));
			i += 3;
		}
	}
	return res;
}