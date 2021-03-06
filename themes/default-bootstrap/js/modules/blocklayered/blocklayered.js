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
	cancelFilter();
	openCloseFilter();


	// Click on color
/*	$(document).on('click', '#layered_form input[type=button], #layered_form label.layered_color', function(e) {
		if (!$('input[name='+$(this).attr('name')+'][type=hidden]').length)
			$('<input />').attr('type', 'hidden').attr('name', $(this).attr('name')).val($(this).data('rel')).appendTo('#layered_form');
		else
			$('input[name='+$(this).attr('name')+'][type=hidden]').remove();
		reloadContent(true);
	});*/

    $('.select.form-control').off('click').change(function(){
        reloadContent(true);
    });

    $('#reset-all').off('click').on('click',function(e){
        e.preventDefault();
        var reset = false;
        var selects = $(this).parent().find('.layered_filter select');
        for(var i = 0,l = selects.length;i<l;i++){
            var select = $(selects[i]);
            if($(selects[i]).val() !== "" ){
                reset=true;
            }
            select.off('click');
            if(select.hasClass('selected')){
                select.removeClass('selected');
            }
            var options = select.children('option');
            for(var ii = 0,ll=options.length;ii<ll;ii++){
                if(options[ii].value ===""){
                    options[ii].selected = true;
                }
                options[ii].disabled = false;
            }
        }

        if(document.body.id==='index' && reset){
            $('.content_sortPagiBar.index').hide();
            $('.product_list').html('');
            $('#slider').show();
            $('.mainkat_cont').show();
            reset = false;
        }

       if(reset){
           reloadContent(true);
       }
    });

/*	$(document).on('click', '#layered_form .select, #layered_form input[type=checkbox], #layered_form input[type=radio], .selectButton', function(e) {
		//alert("f"); _tat_ Щелчок по селекту фильтра
		reloadContent(true);//Добавлено, чтобы не перезагружал страницу при первом пуске фильтра

	});*/

/*    $('.select.form-control').change(function(){
       reloadContent(true);
    });*/
	

	// Changing content of an input text
	$(document).on('keyup', '#layered_form input.layered_input_range', function(e){
		if ($(this).attr('timeout_id'))
			window.clearTimeout($(this).attr('timeout_id'));

		// IE Hack, setTimeout do not acept the third parameter
		var reference = this;

		$(this).attr('timeout_id', window.setTimeout(function(it){
			if (!$(it).attr('id'))
				it = reference;

			var filter = $(it).attr('id').replace(/^layered_(.+)_range_.*$/, '$1');

			var value_min = parseInt($('#layered_'+filter+'_range_min').val());
			if (isNaN(value_min))
				value_min = 0;
			$('#layered_'+filter+'_range_min').val(value_min);

			var value_max = parseInt($('#layered_'+filter+'_range_max').val());
			if (isNaN(value_max))
				value_max = 0;
			$('#layered_'+filter+'_range_max').val(value_max);

			if (value_max < value_min) {
				$('#layered_'+filter+'_range_max').val($(it).val());
				$('#layered_'+filter+'_range_min').val($(it).val());
			}
			reloadContent();
		}, 500, this));
	});

	$(document).on('click', '#layered_block_left .radio', function(e){
		var name = $(this).attr('name');
		$.each($(this).parent().parent().find('input[type=button]'), function (it, item) {
			if ($(item).hasClass('on') && $(item).attr('name') != name)
				$(item).click();
		});
		return true;
	});

	// Click on label
	$('#layered_block_left label a').on({
		click: function(e) {
			e.preventDefault();
			var disable = $(this).parent().parent().find('input').attr('disabled');
			if (disable == ''
			|| typeof(disable) == 'undefined'
			|| disable == false)
			{
				$(this).parent().parent().find('input').click();
				reloadContent();
			}
		}
	});

	layered_hidden_list = {};
	$('.hide-action').on('click', function(e){
		if (typeof(layered_hidden_list[$(this).parent().find('ul').attr('id')]) == 'undefined' || layered_hidden_list[$(this).parent().find('ul').attr('id')] == false)
			layered_hidden_list[$(this).parent().find('ul').attr('id')] = true;
		else
			layered_hidden_list[$(this).parent().find('ul').attr('id')] = false;
		hideFilterValueAction(this);
	});
	$('.hide-action').each(function() {
		hideFilterValueAction(this);
	});

	$('.selectProductSort').unbind('change').bind('change', function(event) {
		$('.selectProductSort').val($(this).val());

		if($('#layered_form').length > 0)
			reloadContent(true);
	});

    $('.sortPagiBar .select label').bind('click',function(e){

        var $for =  $(this).attr('for');
        var $i = $(this).children('i');
        var $class = $i.attr('class');

        $(this).siblings().removeClass();
        $(this).addClass('active');
        $(this).siblings('label').children('i').removeClass();

        switch ($class){
            case 'asc':
                $i.removeClass().addClass('desc');
                break;
            case 'desc':
                $i.removeClass().addClass('asc');
                break;
            default :
                $i.addClass('asc');
                break;
        }
        if($('#layered_form').length > 0)
            reloadContent(true);
    });

/*	$(document).off('change').on('change', 'select[name=n]', function(e)
	{
		$('select[name=n]').val($(this).val());
	//	reloadContent(true);
	});*/

	paginationButton(false);
	initLayered();
//	reloadContent(true);
});

function initFilters()
{
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

				addSlider(filter.type,
				{
					range: true,
					step: step,
					min: parseInt(filter.min),
					max: parseInt(filter.max),
					values: [filter.values[0], filter.values[1]],
					slide: function(event, ui) {
						stopAjaxQuery();

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
						reloadContent(true);
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
		/*initUniform();*/
	}
}

function initUniform()
{
	$("#layered_form input[type='checkbox'], #layered_form input[type='radio'], select.form-control").uniform();
}

function hideFilterValueAction(it)
{
	if (typeof(layered_hidden_list[$(it).parent().find('ul').attr('id')]) == 'undefined'
		|| layered_hidden_list[$(it).parent().find('ul').attr('id')] == false)
	{
		$(it).parent().find('.hiddable').hide();
		$(it).parent().find('.hide-action.less').hide();
		$(it).parent().find('.hide-action.more').show();
	}
	else
	{
		$(it).parent().find('.hiddable').show();
		$(it).parent().find('.hide-action.less').show();
		$(it).parent().find('.hide-action.more').hide();
	}
}

function addSlider(type, data, unit, format)
{
	sliderList.push({
		type: type,
		data: data,
		unit: unit,
		format: format
	});
}

function initSliders()
{
	$(sliderList).each(function(i, slider){
		$('#layered_'+slider['type']+'_slider').slider(slider['data']);

		var from = '';
		var to = '';
		switch (slider['format'])
		{
			case 1:
			case 2:
			case 3:
			case 4:
				from = formatCurrency($('#layered_'+slider['type']+'_slider').slider('values', 0), slider['format'], slider['unit']);
				to = formatCurrency($('#layered_'+slider['type']+'_slider').slider('values', 1), slider['format'], slider['unit']);
				break;
			case 5:
				from =  $('#layered_'+slider['type']+'_slider').slider('values', 0)+slider['unit']
				to = $('#layered_'+slider['type']+'_slider').slider('values', 1)+slider['unit'];
				break;
		}
		$('#layered_'+slider['type']+'_range').html(from+' - '+to);
	});
}

function initLayered()
{
	initFilters();
	initSliders();
	initLocationChange();
	updateProductUrl();
	if (window.location.href.split('#').length == 2 && window.location.href.split('#')[1] != '')
	{
		var params = window.location.href.split('#')[1];
		reloadContent('&selected_filters='+params);
	}
}

function paginationButton(nbProductsIn, nbProductOut)
{
	if (typeof(current_friendly_url) === 'undefined')
		current_friendly_url = '#';

	$('div.pagination a').not(':hidden').each(function () {

		if ($(this).attr('href').search(/(\?|&)p=/) == -1)
			var page = 1;
		else
			var page = parseInt($(this).attr('href').replace(/^.*(\?|&)p=(\d+).*$/, '$2'));
		
		var location = window.location.href.replace(/#.*$/, '');
		$(this).attr('href', location + current_friendly_url.replace(/\/page-(\d+)/, '') + '/page-' + page);
	});

	$('div.pagination li').not('.current, .disabled').each(function () {
		var nbPage = 0;
		if ($(this).hasClass('pagination_next'))
			nbPage = parseInt($('div.pagination li.current').children().children().html())+ 1;
		else if ($(this).hasClass('pagination_previous'))
			nbPage = parseInt($('div.pagination li.current').children().children().html())- 1;

		$(this).children().children().on('click', function(e)
		{
			e.preventDefault();
			if (nbPage == 0)
				p = parseInt($(this).html()) + parseInt(nbPage);
			else
				p = nbPage;
			p = '&p='+ p;
			reloadContent(p);
			nbPage = 0;
		});
	});

	//product count refresh
	if(nbProductsIn!=false)
	{
		if(isNaN(nbProductsIn) == 0)
		{
			// add variables
			var productCountRow = $('.product-count').html();
			var nbPage = parseInt($('div.pagination li.current').children().children().html());
			var nb_products = nbProductsIn;

			if ($('#nb_item option:selected').length == 0)
				var nbPerPage = nb_products;
			else
				var nbPerPage = parseInt($('#nb_item option:selected').val());

			isNaN(nbPage) ? nbPage = 1 : nbPage = nbPage;
			nbPerPage*nbPage < nb_products ? productShowing = nbPerPage*nbPage :productShowing = (nbPerPage*nbPage-nb_products-nbPerPage*nbPage)*-1;
			nbPage==1 ? productShowingStart=1 : productShowingStart=nbPerPage*nbPage-nbPerPage+1;


			//insert values into a .product-count
			productCountRow = $.trim(productCountRow);
			productCountRow = productCountRow.split(' ');

			var backStart = new Array;
			for (row in productCountRow)
				if (parseInt(productCountRow[row]) + 0 == parseInt(productCountRow[row]))
					backStart.push(row);

			if (typeof backStart[0] !== 'undefined')
				productCountRow[backStart[0]] = productShowingStart;
			if (typeof backStart[1] !== 'undefined')
				productCountRow[backStart[1]] = (nbProductOut != 'undefined') && (nbProductOut > productShowing) ? nbProductOut : productShowing;
			if (typeof backStart[2] !== 'undefined')
				productCountRow[backStart[2]] = nb_products;

			if (typeof backStart[1] !== 'undefined' && typeof backStart[2] !== 'undefined' && productCountRow[backStart[1]] > productCountRow[backStart[2]])
				productCountRow[backStart[1]] = productCountRow[backStart[2]];

			productCountRow = productCountRow.join(' ');
			$('.product-count').html(productCountRow);
			$('.product-count').show();
		}
		else
			$('.product-count').hide();
	}
}

function cancelFilter()
{
	$(document).on('click', '#enabled_filters a', function(e){
		if ($(this).data('rel').search(/_slider$/) > 0)
		{
			if ($('#'+$(this).data('rel')).length)
			{
				$('#'+$(this).data('rel')).slider('values' , 0, $('#'+$(this).data('rel')).slider('option' , 'min' ));
				$('#'+$(this).data('rel')).slider('values' , 1, $('#'+$(this).data('rel')).slider('option' , 'max' ));
				$('#'+$(this).data('rel')).slider('option', 'slide')(0,{values:[$('#'+$(this).data('rel')).slider( 'option' , 'min' ), $('#'+$(this).data('rel')).slider( 'option' , 'max' )]});
			}
			else if($('#'+$(this).data('rel').replace(/_slider$/, '_range_min')).length)
			{
				$('#'+$(this).data('rel').replace(/_slider$/, '_range_min')).val($('#'+$(this).data('rel').replace(/_slider$/, '_range_min')).attr('limitValue'));
				$('#'+$(this).data('rel').replace(/_slider$/, '_range_max')).val($('#'+$(this).data('rel').replace(/_slider$/, '_range_max')).attr('limitValue'));
			}
		}
		else
		{
			if ($('option#'+$(this).data('rel')).length)
				$('#'+$(this).data('rel')).parent().val('');
			else
			{
				$('#'+$(this).data('rel')).attr('checked', false);
				$('.'+$(this).data('rel')).attr('checked', false);
				$('#layered_form input[type=hidden][name='+$(this).data('rel')+']').remove();
			}
		}
		reloadContent(true);
		e.preventDefault();
	});
}

function openCloseFilter()
{
	$(document).on('click', '#layered_form span.layered_close a', function(e)
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

function stopAjaxQuery() {
	if (typeof(ajaxQueries) == 'undefined')
		ajaxQueries = new Array();
	for(i = 0; i < ajaxQueries.length; i++)
		ajaxQueries[i].abort();
	ajaxQueries = new Array();
}

function reloadContent(params_plus)
{
	stopAjaxQuery();

	if (!ajaxLoaderOn)
	{
		$('.product_list').prepend($('#layered_ajax_loader').html());
		$('.product_list').css('opacity', '0.7');
		ajaxLoaderOn = 1;
	}

	data = $('#layered_form').serialize();
	$('.layered_slider').each( function () {
		var sliderStart = $(this).slider('values', 0);
		var sliderStop = $(this).slider('values', 1);
		if (typeof(sliderStart) == 'number' && typeof(sliderStop) == 'number')
			data += '&'+$(this).attr('id')+'='+sliderStart+'_'+sliderStop;
	});

	$(['price', 'weight']).each(function(it, sliderType)
	{
		if ($('#layered_'+sliderType+'_range_min').length)
			data += '&layered_'+sliderType+'_slider='+$('#layered_'+sliderType+'_range_min').val()+'_'+$('#layered_'+sliderType+'_range_max').val();
	});

	$('#layered_form .select option').each( function () {
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

        if($('.sortPagiBar .select label').length){
            var $label = $('.sortPagiBar .select label.active');
            $orderby = $label.attr('for');
            $orderway = $label.children('i').attr('class');
            data += '&orderby='+$orderby+'&orderway='+$orderway;
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
				n = '&n=' + option.value;
		});
	}
	ajaxQuery = $.ajax(
	{
		type: 'GET',
		url: baseDir + 'modules/blocklayered/blocklayered-ajax.php',
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

			//$('#layered_block_left').replaceWith(utf8_decode(result.filtersBlock));
			$('.category-product-count, .heading-counter').html(result.categoryCount);

			if (result.nbRenderedProducts == result.nbAskedProducts)
				$('div.clearfix.selector1').hide();

            if ($('body#index').length){
                $('.mainkat_cont, #slider').hide();
            }
            if(result.filters){
                assignFilters(result.filters)
            }
            if(result.combinations){
                if(typeof allcombinations === 'undefined'){
                    allcombinations = result.combinations;
                }
            }


			if (result.productList){

             $('.product_list').replaceWith(utf8_decode(result.productList));
                if (typeof getcurrentcombs == 'function') getcurrentcombs();
                if(typeof getcomb == 'function'){getcomb()}
            }

			else{
                $('.product_list').html('');
            }


			$('.product_list').css('opacity', '1');
            var $sort = $('.content_sortPagiBar');
            if($sort.css("visibility") == "hidden" || $sort.is(':hidden')){
                $sort.css('visibility','visible');
                $sort.show();
            }
			if ($.browser.msie) // Fix bug with IE8 and aliasing
				$('.product_list').css('filter', '');

			if (result.pagination.search(/[^\s]/) >= 0)
			{
				var pagination = $('<div/>').html(result.pagination);
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

			paginationButton(result.nbRenderedProducts, result.nbAskedProducts);
			ajaxLoaderOn = 0;

			// On submiting nb items form, relaod with the good nb of items
			$('div.pagination form').on('submit', function(e)
			{
				e.preventDefault();
				val = $('div.pagination select[name=n]').val();
			
				$('div.pagination select[name=n]').children().each(function(it, option) {
					if (option.value == val)
						$(option).attr('selected', true);
					else
						$(option).removeAttr('selected');
				});

				// Reload products and pagination
				reloadContent();
			});
			if (typeof(ajaxCart) != "undefined")
				ajaxCart.overrideButtonsInThePage();

			if (typeof(reloadProductComparison) == 'function')
				reloadProductComparison();

			filters = result.filters;
			initFilters();
			initSliders();

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
							current_friendly_url += '/'+blocklayeredSliderName[sliderType]+'-'+$('#layered_'+sliderType+'_slider').slider('values', 0)+'-'+$('#layered_'+sliderType+'_slider').slider('values', 1)
					}
				}
				else if ($('#layered_'+sliderType+'_range_min').length)
					current_friendly_url += '/'+blocklayeredSliderName[sliderType]+'-'+$('#layered_'+sliderType+'_range_min').val()+'-'+$('#layered_'+sliderType+'_range_max').val();
			});

			window.location.href = current_friendly_url;

			if (current_friendly_url != '#/show-all')
				$('div.clearfix.selector1').show();
			
			lockLocationChecking = true;

			if (slideUp)
				$.scrollTo('.product_list', 400);
			updateProductUrl();

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

function initLocationChange(func, time)
{
	if (!time)
		time = 500;
	var current_friendly_url = getUrlParams();
	setInterval(function()
	{
		if(getUrlParams() != current_friendly_url && !lockLocationChecking)
		{
			// Don't reload page if current_friendly_url and real url match
			if (current_friendly_url.replace(/^#(\/)?/, '') == getUrlParams().replace(/^#(\/)?/, ''))
				return;

			lockLocationChecking = true;
			//reloadContent('&selected_filters='+getUrlParams().replace(/^#/, ''));заканчивается бесконечная перезагрузка как только это заккоментируешь!
		}
		else
		{
			lockLocationChecking = false;
			current_friendly_url = getUrlParams();
		}
	}, time);
}

function getUrlParams()
{
	if (typeof(current_friendly_url) === 'undefined')
		current_friendly_url = '#';

	var params = current_friendly_url;
	if(window.location.href.split('#').length == 2 && window.location.href.split('#')[1] != '')
		params = '#'+window.location.href.split('#')[1];
	return params;
}

function updateProductUrl()
{
	// Adding the filters to URL product
	if (typeof(param_product_url) != 'undefined' && param_product_url != '' && param_product_url !='#') {
		$.each($('ul.product_list li.ajax_block_product .product_img_link,'+
				'ul.product_list li.ajax_block_product h5 a,'+
				'ul.product_list li.ajax_block_product .product_desc a,'+
				'ul.product_list li.ajax_block_product .lnk_view'), function() {
			$(this).attr('href', $(this).attr('href') + param_product_url);
		});
	}
}

/**
 * Copy of the php function utf8_decode()
 */
function utf8_decode (utfstr)
{
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

function assignFilters(filters){
    for (var key in filters) {
        if (filters.hasOwnProperty(key)) {
            var id_key = filters[key].id_key;
            var spec_droplist = $('#ul_layered_id_feature_'+ id_key + ' select');
            var values = filters[key].values;
            var options = spec_droplist.find('option');
            if(spec_droplist.val() !== "" && !spec_droplist.hasClass('selected')){ // only select with  chosen value
                spec_droplist.addClass('selected');
                for (var val_key in  values  ){
                    if(values.hasOwnProperty(val_key)){
                       var fOption = values[val_key];
                       var fValue = val_key+'_'+id_key;
                       if(fOption.checked === true){
                           for (var i = 0, l = options.length; i < l; i++) {
                               var selOption = $(options[i]);
                               if(selOption.val()!==""){
                                   selOption.prop('disabled',selOption.val() !== fValue);
                               }
                           }
                       }
                    }
                }
            } else if(spec_droplist.hasClass('selected') && spec_droplist.val() ===""){
                for(i=0,l=options.length;i<l;i++){
                    for (i = 0, l = options.length; i < l; i++) {
                        var disabled = true;
                        if(options[i].value !==""){
                            for(val_key in values){
                                fValue = val_key+'_'+id_key;
                                if(options[i].value == fValue){
                                    disabled = false;
                                    break;
                                }
                            }
                            options[i].disabled = disabled;
                        }
                    }
                }
                spec_droplist.removeClass('selected');
            } else if (spec_droplist.val() === "" && !spec_droplist.hasClass('selected')) {

                for (i = 0, l = options.length; i < l; i++) {
                      disabled = true;
                      if(options[i].value !==""){
                          for(val_key in values){
                              fValue = val_key+'_'+id_key;
                              if(options[i].value == fValue){
                                  disabled = false;
                                  break;
                              }
                          }
                          options[i].disabled = disabled;
                      }
                }

            }
        }
    }
}

Array.prototype.in_array = function(p_val) {
    for(var i = 0, l = this.length; i < l; i++)	{
        if(this[i] == p_val) {
            return true;
        }
    }
    return false;
};

/*function find_attributes(list){
    var els = list.children('li');
    var k = els.length;
    var prod_attr_array = {hardness:[],height:[],weight:[],typeSpring:[]};
    var filter = { hardness:[],height:[],weight:[],typeSpring:[]};
//     var diff = {hardness:[],height:[],weight:[]};
    var weightArr = $('#ul_layered_id_feature_5').find('select option');
    var heightArr = $('#ul_layered_id_feature_12').find('select option');
    var hardnessArr = $('#ul_layered_id_feature_7').find('select option');
    var typeSpring = $('#ul_layered_id_feature_9').find('select option');
    for(var i=0;i<k;i++){
        var attrs = $(els[i]).find('.cat_info');
        if(prod_attr_array.hardness.indexOf(attrs.find('.hardness').data('hard_value')) == -1)
            prod_attr_array['hardness'].push(attrs.find('.hardness').data('hard_value'));
        if(prod_attr_array.height.indexOf(parseFloat(attrs.find('.height span').text())) == -1)
            prod_attr_array['height'].push(parseFloat(attrs.find('.height span').text()));
        if(prod_attr_array.weight.indexOf(parseFloat(attrs.find('.ves span').text())) == -1)
            prod_attr_array['weight'].push(parseFloat(attrs.find('.ves span').text()));
        if(prod_attr_array.typeSpring.indexOf(attrs.find('.typeSpring').val()) == -1)
            prod_attr_array['typeSpring'].push(attrs.find('.typeSpring').val().toString());
    }

    cycleArr(weightArr,filter,'weight');
    cycleArr(heightArr,filter,'height');
    cycleArr(hardnessArr,filter,'hardness');
    cycleArr(typeSpring,filter,'typeSpring');


    filter.height = $(filter.height).not(prod_attr_array.height).get();
    filter.weight = $(filter.weight).not(prod_attr_array.weight).get();
    filter.hardness = $(filter.hardness).not(prod_attr_array.hardness).get();
    filter.typeSpring = $(filter.typeSpring).not(prod_attr_array.typeSpring).get();



    cycleArr(weightArr,filter,'weight',true);
    cycleArr(heightArr,filter,'height',true);
    cycleArr(hardnessArr,filter,'hardness',true);
    cycleArr(typeSpring,filter,'typeSpring',true);

}*/

/*function cycleArr(arr,filter,property,check_disable){
    if(typeof check_disable === "undefined"){
        switch (property){
            case 'height':
            case 'weight':
                $.map(arr, function(option) {
                    if(option.value.length > 0){
                        filter[property].push(parseFloat(option.text.replace(',', '.')))
                    }
                });
                break;
            case 'hardness':
                $.map(arr,function(option){
                    if(option.value.length > 0 ){
                        filter[property].push(option.value);
                    }
                });
                break;
            case 'typeSpring':
                $.map(arr,function(option){
                    if(option.value.length > 0 ){
                        filter[property].push(option.text.toString());
                    }
                });
                break;
    }
    }else{
        switch (property){
            case 'height':
            case 'weight':
                $.map(arr,function(option){
                    if(filter[property].in_array(parseFloat(option.text.replace(',', '.')))){
                        $(option).prop('disabled',true);
                    }else{
                        $(option).prop('disabled',false);
                    }
                });
                break;
            case 'hardness':
                $.map(arr,function(option){
                    if(filter[property].in_array(option.value)){
                        $(option).prop('disabled',true);
                    }else{
                        $(option).prop('disabled',false);
                    }
                });
                break;
            case 'typeSpring':
                $.map(arr,function(option,i){
                    if(filter[property].in_array(option.text.toString())){
                        console.log(var_dump(option.text));
                        console.log(var_dump(filter[property]));
                        $(option).prop('disabled',true);
                    }else{
                        $(option).prop('disabled',false);
                    }
                });
                break;
        }

    }



}

var indexOf = function(needle) {
    if(typeof Array.prototype.indexOf === 'function') {
        indexOf = Array.prototype.indexOf;
    } else {
        indexOf = function(needle) {
            var i = -1, index = -1;

            for(i = 0; i < this.length; i++) {
                if(this[i] === needle) {
                    index = i;
                    break;
                }
            }

            return index;
        };
    }

    return indexOf.call(this, needle);
};





function var_dump () {
    var output = '', pad_char = ' ', pad_val = 4, lgth = 0, i = 0, d = this.window.document;
    var getFuncName = function (fn) {
        var name = (/\W*function\s+([\w\$]+)\s*\(/).exec(fn);
        if (!name) {
            return '(Anonymous)';
        }
        return name[1];
    };
    var repeat_char = function (len, pad_char) {
        var str = '';
        for (var i=0; i < len; i++) {
            str += pad_char;
        }
        return str;
    };
    var getScalarVal = function (val) {
        var ret = '';
        if (val === null) {
            ret = 'NULL';
        } else if (typeof val === 'boolean') {
            ret = 'bool(' + val + ')';
        } else if (typeof val === 'string') {
            ret = 'string(' + val.length + ') "' + val + '"';
        } else if (typeof val === 'number') {
            if (parseFloat(val) == parseInt(val, 10)) {
                ret = 'int(' + val + ')';
            } else {
                ret = 'float(' + val + ')';
            }
        } else if (val === undefined) {
            ret = 'UNDEFINED'; // Not PHP behavior, but neither is undefined as value
        }  else if (typeof val === 'function') {
            ret = 'FUNCTION'; // Not PHP behavior, but neither is function as value
            ret = val.toString().split("\n");
            txt = '';
            for(var j in ret) {
                txt += (j !=0 ? thick_pad : '') + ret[j] + "\n";
            }
            ret = txt;
        } else if (val instanceof Date) {
            val = val.toString();
            ret = 'string('+val.length+') "' + val + '"'
        }
        else if(val.nodeName) {
            ret = 'HTMLElement("' + val.nodeName.toLowerCase() + '")';
        }
        return ret;
    };
    var formatArray = function (obj, cur_depth, pad_val, pad_char) {
        var someProp = '';
        if (cur_depth > 0) {
            cur_depth++;
        }
        base_pad = repeat_char(pad_val * (cur_depth - 1), pad_char);
        thick_pad = repeat_char(pad_val * (cur_depth + 1), pad_char);
        var str = '';
        var val = '';
        if (typeof obj === 'object' && obj !== null) {
            if (obj.constructor && getFuncName(obj.constructor) === 'PHPJS_Resource') {
                return obj.var_dump();
            }
            lgth = 0;
            for (someProp in obj) {
                lgth++;
            }
            str += "array(" + lgth + ") {\n";
            for (var key in obj) {
                if (typeof obj[key] === 'object' && obj[key] !== null && !(obj[key] instanceof Date) && !obj[key].nodeName) {
                    str += thick_pad + "["+key+"] =>\n" + thick_pad+formatArray(obj[key], cur_depth+1, pad_val, pad_char);
                } else {
                    val = getScalarVal(obj[key]);
                    str += thick_pad + "["+key+"] =>\n" + thick_pad + val + "\n";
                }
            }
            str += base_pad + "}\n";
        } else {
            str = getScalarVal(obj);
        }
        return str;
    };
    output = formatArray(arguments[0], 0, pad_val, pad_char);
    for ( i=1; i < arguments.length; i++ ) {
        output += '\n' + formatArray(arguments[i], 0, pad_val, pad_char);
    }
    return output;
}*/


