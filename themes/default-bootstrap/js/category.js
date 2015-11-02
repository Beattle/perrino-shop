/*
* 2007-2015 PrestaShop
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
$(document).ready(function(){
	resizeCatimg();
    getcomb();
    getcurrentcombs();
});




$(window).resize(function(){
	resizeCatimg();
});

$(document).on('click', '.lnk_more', function(e){
	e.preventDefault();
	$('#category_description_short').hide(); 
	$('#category_description_full').show(); 
	$(this).hide();
});

function resizeCatimg()
{
	var div = $('.cat_desc').parent('div');
	
	if (div.css('background-image') == 'none')
		return;

	var image = new Image;
	$(image).load(function(){
	    var width  = image.width;
	    var height = image.height;
		var ratio = parseFloat(height / width);
		var calc = Math.round(ratio * parseInt(div.outerWidth(false)));
		div.css('min-height', calc);
	});
	if (div.length)
		image.src = div.css('background-image').replace(/url\("?|"?\)$/ig, '');
}

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
            console.log(priceWithDiscountsDisplay);

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

/*
$(document).ready(function(){
    var $prods = $('.ajax_block_product');
    var $l = $prods.length;
    for($i=0;$i<$l;$i++){
        var link = $($prods[$i]).find('.cat_img .product_img_link').attr('href');
        var $q_comms = $($prods[$i]).find('.quantity_comms');
        var $quantity = $q_comms.text();
        $q_comms.html('<a href="'+link+'##idTab5" itemprop="url" title="Перейти к отзывам">'+$quantity+'</a>');
    }
});*/
