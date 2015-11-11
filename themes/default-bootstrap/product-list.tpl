{*
* 2007-2015 PrestaShop _tat_ вывод продуктов категории
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
*}

{include file="$tpl_dir./errors.tpl"}

{if isset($products) && $products}
    {*define number of products per line in other page for desktop*}
    {if $page_name !='index' && $page_name !='product'}
        {assign var='nbItemsPerLine' value=3}
        {assign var='nbItemsPerLineTablet' value=2}
        {assign var='nbItemsPerLineMobile' value=3}
    {else}
        {assign var='nbItemsPerLine' value=4}
        {assign var='nbItemsPerLineTablet' value=3}
        {assign var='nbItemsPerLineMobile' value=2}
    {/if}
    {*define numbers of product per line in other page for tablet*}
    {assign var='nbLi' value=$products|@count}
    {math equation="nbLi/nbItemsPerLine" nbLi=$nbLi nbItemsPerLine=$nbItemsPerLine assign=nbLines}
    {math equation="nbLi/nbItemsPerLineTablet" nbLi=$nbLi nbItemsPerLineTablet=$nbItemsPerLineTablet assign=nbLinesTablet}


    <!--*********************************************************************************-->


    <!--/*********************************************************************************-->




    <ul {if isset($id_category) && $id_category} id="{$id_category}"{/if} class="product_list">
    {foreach from=$products item=product name=products}

        {if  !empty($product.attachments) && count($product.attachments) === 1}
            {assign var="attach" value=$product.attachments[0]}
        {else}
            {assign var="attach" value=""}
        {/if}

        {math equation="(total%perLine)" total=$smarty.foreach.products.total perLine=$nbItemsPerLine assign=totModulo}
        {math equation="(total%perLineT)" total=$smarty.foreach.products.total perLineT=$nbItemsPerLineTablet assign=totModuloTablet}
        {math equation="(total%perLineT)" total=$smarty.foreach.products.total perLineT=$nbItemsPerLineMobile assign=totModuloMobile}
        {if $totModulo == 0}{assign var='totModulo' value=$nbItemsPerLine}{/if}
        {if $totModuloTablet == 0}{assign var='totModuloTablet' value=$nbItemsPerLineTablet}{/if}
        {if $totModuloMobile == 0}{assign var='totModuloMobile' value=$nbItemsPerLineMobile}{/if}
        <li itemtype="http://schema.org/Product" itemscope="" class="ajax_block_product{if $page_name == 'index' || $page_name == 'product'} col-xs-12 col-sm-4 col-md-3{else} col-xs-12 col-sm-6 col-md-4{/if}{if $smarty.foreach.products.iteration%$nbItemsPerLine == 0} last-in-line{elseif $smarty.foreach.products.iteration%$nbItemsPerLine == 1} first-in-line{/if}{if $smarty.foreach.products.iteration > ($smarty.foreach.products.total - $totModulo)} last-line{/if}{if $smarty.foreach.products.iteration%$nbItemsPerLineTablet == 0} last-item-of-tablet-line{elseif $smarty.foreach.products.iteration%$nbItemsPerLineTablet == 1} first-item-of-tablet-line{/if}{if $smarty.foreach.products.iteration%$nbItemsPerLineMobile == 0} last-item-of-mobile-line{elseif $smarty.foreach.products.iteration%$nbItemsPerLineMobile == 1} first-item-of-mobile-line{/if}{if $smarty.foreach.products.iteration > ($smarty.foreach.products.total - $totModuloMobile)} last-mobile-line{/if}">

        <div class="cat_img"><!-- был left-block  -->
            <a class="product_img_link"	href="{$product.link|escape:'html':'UTF-8'}" title="{$product.name|escape:'html':'UTF-8'}" itemprop="url">
                <img itemprop="image"  class="main replace-2x img-responsive" src="{$link->getImageLink($product.link_rewrite, $product.id_image, 'home_default')|escape:'html':'UTF-8'}" alt="{if !empty($product.legend)}{$product.legend|escape:'html':'UTF-8'}{else}{$product.name|escape:'html':'UTF-8'}{/if}" title="{if !empty($product.legend)}{$product.legend|escape:'html':'UTF-8'}{else}{$product.name|escape:'html':'UTF-8'}{/if}" {if isset($homeSize)} width="{$homeSize.width}" height="{$homeSize.height}"{/if} />
                {if !empty($attach)}
                    <img title="{$attach.description}" itemprop="image" src="{$link->getPageLink('attachment', true, NULL, "id_attachment={$attach.id_attachment}")|escape:'html':'UTF-8'}" class="icon-a replace-2x img-responsive" />
                {/if}
            </a>
        </div><!-- cat_img -->
        <div class="cat_title">
            {if isset($product.pack_quantity) && $product.pack_quantity}{$product.pack_quantity|intval|cat:' x '}{/if}
            <a itemprop="url" class="product-name" href="{$product.link|escape:'html':'UTF-8'}" title="{$product.name|escape:'html':'UTF-8'}" >
                <h3 itemprop="name">
                    {$product.name|truncate:150:'...'|escape:'html':'UTF-8'}
                </h3>
            </a>
        </div>

        <a class="product-otziv" href="{$product.link|escape:'html':'UTF-8'}" title="{$product.name|escape:'html':'UTF-8'}" itemprop="url" >
        </a>
        {if isset($product.features) && $product.features}
            {section name=featuresitem loop=$product.features}
                {if $product.features[featuresitem].name == "Жёсткость"}<!-- Если это матрас-->					{assign var=NoStandart value="+"}
                {/if}
                {if $product.features[featuresitem].name == "Тип наматрасника"}<!-- Если это наматрасник-->					{assign var=NoStandart value="+"}
                {/if}
            {/section}
            {if isset($NoStandart) && $NoStandart}<!-- Если это матрас или наматрасник-->
                <div class="NoStandartWrapper">
                    {hook h='displayProductListReviews' product=$product}<!-- Комментарии и размер-->
                    <div class="NoStandart">
                        <a href="http://perrino-shop.ru/content/5-NoStandart">Нужен нестандарт?</a>
                    </div>
                </div>
                {$NoStandart = null}
            {else}<!-- Если не матрас и не наматрасник-->
                {hook h='displayProductListReviews' product=$product}<!-- Комментарии и размер-->
            {/if}
        {else}<!-- Если нет характеристик-->
            {hook h='displayProductListReviews' product=$product}<!-- Комментарии и размер-->
        {/if}

        <div class="cat_cont">
        {if $product.groups}
            <div class="cat_size">
                {foreach from=$product.groups key=id_attribute_group item=group}
                    {if $group.attributes|@count}
                        <div class="select-box">
                            <span {if $group.group_type != 'color' && $group.group_type != 'radio'}{/if}>{$group.name|escape:'html':'UTF-8'}&nbsp;</span>
                            {assign var="groupName" value="group_$id_attribute_group"}
                            {if ($group.group_type == 'select')}
                                <div class="selectWrapper">
                                    <div class="selector">
                                        <select data-token="{if isset($static_token)}{$static_token}{/if}" name="{$groupName}"  data-product_id="{$product.id_product|intval}" class="group_{$id_attribute_group|intval} attribute_select">
                                            {foreach from=$group.attributes key=id_attribute item=group_attribute}
                                                <option value="{$id_attribute|intval}"{if (isset($smarty.get.$groupName) && $smarty.get.$groupName|intval == $id_attribute) || $group.default == $id_attribute} selected="selected"{/if} title="{$group_attribute|escape:'html':'UTF-8'}">{$group_attribute|escape:'html':'UTF-8'}</option>
                                            {/foreach}
                                        </select>
                                    </div>
                                </div><!-- selectWrapper -->
                            {/if}
                        </div>
                    {/if}
                {/foreach}
            </div>
        {/if}



        <!-- Сюда выводила размер -- idTab5>


		{if isset($product.features) && $product.features}
			{section name=featuresitem loop=$product.features}
			<!-- Присваиваю значение массиву, если это подушка-->
            {if $product.features[featuresitem].name == "Размер подушки"}
                {assign var=pxpPodushkiTitle value="Размер"}

                {if isset($product.features[featuresitem].value) && $product.features[featuresitem].value}
                    {assign var=pxpPodushki value=$product.features[featuresitem].value}
                {else}
                    {assign var=pxpPodushki value="-"}

                {/if}
            {/if}
            {/section}
        {*Вывожу характеристику размера подушки*}
            {if isset($pxpPodushkiTitle) && $pxpPodushkiTitle && empty($product.groups)}
                <div class="cat_size_podushka">
                    <span class="span1_podushka">{$pxpPodushkiTitle}</span>
                    <div class="floatLeft">
                        <span>{$pxpPodushki}</span>
                    </div>
                </div>
                {$pxpPodushkiTitle = null}
                {$pxpPodushki = null}
            {/if}








        {/if}	<!-- isset product.features для подушки и ссылки на нестандарт-->


        {if (!$PS_CATALOG_MODE AND ((isset($product.show_price) && $product.show_price) || (isset($product.available_for_order) && $product.available_for_order)))}
            <div class="cat_cena" data-ecotaxrate="{$product.ecotaxTax_rate}" data-unit_price_ratio="{$product.unit_price_ratio|floatval}" data-taxrate="{$product.tax_rate|floatval}" data-customer_group_without_tax="{$product.customer_group_without_tax|boolval}" data-notax="{$product.no_tax|boolval}" data-reduction="{$product.reduction}" data-group-reduction="{$product.group_reduction}" data-ecotax="{$product.ecotax|floatval}" data-productbpexcl="{$product.price_without_reduction|floatval}"><!-- content_price был -->
                {if isset($product.show_price) && $product.show_price && !isset($restricted_country_mode)}
                    {if isset($product.specific_prices) && $product.specific_prices && isset($product.specific_prices.reduction) && $product.specific_prices.reduction > 0}
                        <!-- Цена старая -->
                        <div><span class="oldprice old_price_display">{$product.price_without_reduction|ceil}</span>руб.
                            <!-- Скидка -->
                            {if $product.specific_prices.reduction_type == 'percentage'}
                                -{$product.specific_prices.reduction * 100}%
                            {/if}</div>
                    {/if}
                    <p itemprop="offers" itemscope itemtype="http://schema.org/AggregateOffer"><span itemprop="lowPrice" class="our_price_display">

                                    <!-- Цена со скидкой -->
                            {if !$priceDisplay}{$product.price|ceil}{else}{convertPrice price=$product.price_tax_exc}{/if}</span>руб.</p>
                {/if}
                <input type="hidden" class="idCombination" value=""/>

            </div>
        {/if}



        <div class="cat_add"><!-- Вывод в корзину -->
            {if ($product.id_product_attribute == 0 || (isset($add_prod_display) && ($add_prod_display == 1))) && $product.available_for_order && !isset($restricted_country_mode) && $product.customizable != 2 && !$PS_CATALOG_MODE}
                {if (!isset($product.customization_required) || !$product.customization_required) && ($product.allow_oosp || $product.quantity > 0)}
                    {capture}add=1&amp;id_product={$product.id_product|intval}{if isset($static_token)}&amp;token={$static_token}{/if}{/capture}
                    <a class="button ajax_add_to_cart_button btn btn-default" href="{$link->getPageLink('cart', true, NULL, $smarty.capture.default, false)|escape:'html':'UTF-8'}" rel="nofollow" title="{l s='Add to cart'}" data-id-product="{$product.id_product|intval}" data-minimal_quantity="{if isset($product.product_attribute_minimal_quantity) && $product.product_attribute_minimal_quantity > 1}{$product.product_attribute_minimal_quantity|intval}{else}{$product.minimal_quantity|intval}{/if}">
                        <span>{l s='Add to cart'}</span>
                    </a>
                {else}
                    <span class="button ajax_add_to_cart_button btn btn-default disabled">
									<span>{l s='Add to cart'}</span>
								</span>
                {/if}
            {/if}
        </div><!-- cat_add -->
        {if isset($product.color_list)}
            <div class="color-list-container">{$product.color_list}</div>
        {/if}



        {if isset($product.features) && $product.features}
            <!-- Data sheet Вывод характеристик features - особенности рабочий вариант-->
            {*Присваиваю значения массиву выводимых в категории характеристик*}
            {assign var="id_feature" value=""}
            {assign var="value_feature" value=""}
            {section name=featuresitem loop=$product.features}
                {if $product.features[featuresitem].name === "Тип пружин"}
                    {assign var="typeSpring" value=$product.features[featuresitem].value}
                {/if}
                {if $product.features[featuresitem].name == "Жёсткость" || $product.features[featuresitem].name == "Жёсткость наматрасника" || $product.features[featuresitem].name == "Жёсткость подушки"}
                    {assign var=hardnessTitle value="Жёсткость"}
                    {*$id_feature=$product.features[featuresitem].id_feature*}
                    {*$value_feature=$product.features[featuresitem].value*}

                    {if isset($product.features[featuresitem].value) && $product.features[featuresitem].value}
                        {assign var=hardness value=$product.features[featuresitem].value}
                        {if $hardness == "Низкая"}
                            {assign var=hardnessSoft value=3}
                        {else}
                            {if $hardness == "Средняя"}
                                {assign var=hardnessSoft value=2}
                            {else}
                                {if $hardness == "Высокая"}
                                    {assign var=hardnessSoft value=1}
                                {/if}
                            {/if}
                        {/if}
                    {else}
                        {assign var=hardness value="-"}
                    {/if}
                {else}
                    {if $product.features[featuresitem].name == "Высота матраса" || $product.features[featuresitem].name == "Высота подушки" || $product.features[featuresitem].name == "Высота наматрасника" || $product.features[featuresitem].name == "Высота кровати"}
                        {assign var=heightTitle value="Высота"}
                        {assign var=$id_feature value=$product.features[featuresitem].id_feature}
                        {assign var=$value_feature value=$product.features[featuresitem].value}

                        {if isset($product.features[featuresitem].value) && $product.features[featuresitem].value}
                            {assign var=height value=$product.features[featuresitem].value|replace:',':'.'|floatval}
                            {assign var=heightFlag value=1}
                        {else}
                            {assign var=height value="-"}
                            {assign var=heightFlag value=2}
                        {/if}
                    {else}
                        {if $product.features[featuresitem].name == "Макс. вес на место"}
                            {assign var=vesTitle value="Вес"}
                            {$id_feature=$product.features[featuresitem].id_feature}
                            {$value_feature=$product.features[featuresitem].value}

                            {if isset($product.features[featuresitem].value) && $product.features[featuresitem].value}
                                {assign var=ves value=$product.features[featuresitem].value|ceil}
                                {assign var=vesFlag value=1}
                            {else}
                                {assign var=ves value="-"}
                                {assign var=vesFlag value=2}
                            {/if}
                        {else}
                            {if $product.features[featuresitem].name == "Жёсткость второй стороны"}
                                {assign var=hardnessDopTitle value=$product.features[featuresitem].name}
                                {$id_feature=$product.features[featuresitem].id_feature}
                                {$value_feature=$product.features[featuresitem].value}

                                {if isset($product.features[featuresitem].value) && $product.features[featuresitem].value}
                                    {assign var=hardnessDop value=$product.features[featuresitem].value}
                                    {if $hardnessDop === "Низкая"}
                                        {assign var=hardnessDopSoft value=3}
                                    {else}
                                        {if $hardnessDop === "Средняя"}
                                            {assign var=hardnessDopSoft value=2}
                                        {else}
                                            {if $hardnessDop === "Высокая"}
                                                {assign var=hardnessDopSoft value=1}
                                            {/if}
                                        {/if}
                                    {/if}
                                {else}
                                    {assign var=hardnessDop value="-"}
                                {/if}
                            {else}
                                {if $product.features[featuresitem].name == "Размер подушки"}
                                    {$id_feature=$product.features[featuresitem].id_feature}
                                    {$value_feature=$product.features[featuresitem].value}


                                    {assign var=pxpPodushkiTitle value="Размер"}

                                    {if isset($product.features[featuresitem].value) && $product.features[featuresitem].value}

                                        {assign var=pxpPodushki value=$product.features[featuresitem].value}
                                    {else}
                                        {assign var=pxpPodushki value="-"}

                                    {/if}

                                {else}
                                    {if $product.features[featuresitem].name == "Материал"}
                                        {assign var=materialTitle value=$product.features[featuresitem].name}
                                        {$id_feature=$product.features[featuresitem].id_feature}
                                        {$value_feature=$product.features[featuresitem].value}

                                        {if isset($product.features[featuresitem].value) && $product.features[featuresitem].value}
                                            {assign var=material value=$product.features[featuresitem].value}
                                        {else}
                                            {assign var=material value="-"}

                                        {/if}
                                        <div class="product_infocat">
                                            <div>
                                                <p>{$materialTitle}</p>
                                                <span>{$material}</span>
                                            </div>
                                        </div>

                                    {/if}
                                {/if}
                            {/if}
                        {/if}
                    {/if}
                {/if}
            {/section}







            <div itemprop="description" class="cat_info">
                {*Вывожу характеристику всех товаров кроме подушки*}
                {if isset($hardnessTitle) && $hardnessTitle}
                    <div class="catFeater">
                        <span>{$hardnessTitle}</span>
                        <div class="hardness" data-hard_value="{if $hardnessSoft == 1}19_7{elseif $hardnessSoft == 2}18_7{else}17_7{/if}">
                            {if $hardnessSoft == 1}<!-- Жёсткий -->
                            <span class="hardnessRed"></span>
                            <span class="hardnessRed"></span>
                            <span class="hardnessRed"></span>
                            {else}
                            {if $hardnessSoft == 2}
                                <span class="hardnessRed"></span>
                                <span class="hardnessRed"></span>
                                <span class="hardnessWhile"></span>
                            {else}
                                <span class="hardnessRed"></span><!-- Мягкий -->
                                <span class="hardnessWhile"></span>
                                <span class="hardnessWhile"></span>
                            {/if}
                            {/if}
                        </div><br />
                        <div class="hardnessDop">
                            {if isset($hardnessDopTitle) && $hardnessDopTitle}
                                {if $hardnessDopSoft == 1}<!-- Жёсткий -->
                                    <span class="hardnessRed"></span>
                                    <span class="hardnessRed"></span>
                                    <span class="hardnessRed"></span>
                                {else}
                                    {if $hardnessDopSoft == 2}
                                        <span class="hardnessRed"></span>
                                        <span class="hardnessRed"></span>
                                        <span class="hardnessWhile"></span>
                                    {else}
                                        <span class="hardnessRed"></span><!-- Мягкий -->
                                        <span class="hardnessWhile"></span>
                                        <span class="hardnessWhile"></span>
                                    {/if}
                                {/if}
                                {$hardnessDopTitle = null}
                                {$hardnessDop = null}
                                {$hardnessDopSoft = null}
                            {/if}
                        </div>
                    </div>
                    {$hardnessTitle = null}
                    {$hardness = null}
                    {$hardnessSoft = null}
                {/if}

                {if isset($heightTitle) && $heightTitle}
                    <div  class="catFeater">
                        <span>{$heightTitle}</span>
                        <div class="height">
                            {if $heightFlag == 1}
                                <span>{$height}</span>{l s='см'}
                            {else}
                                <span>{$height}</span>
                            {/if}
                        </div>
                    </div>
                    {$heightTitle = null}
                    {$height = null}
                    {$heightFlag = null}
                {/if}
                {if isset($vesTitle) && $vesTitle}
                    <div class="catFeater1">
                        <span>{$vesTitle}</span>
                        <div class="ves">
                            {if $vesFlag == 1}
                                <span>{$ves}</span>{l s='кг'}
                            {else}
                                <span>{$ves}</span>
                            {/if}
                        </div>
                    </div>
                    {$vesTitle = null}
                    {$ves = null}
                    {$vesFlag = null}
                {/if}
                {if isset($typeSpring) && $typeSpring}
                <input class="typeSping" type="hidden" value="{$typeSpring}" />
                {/if}
            </div><!-- cat_info -->
        {/if}


        <!-- Подробнее -->
        <div class="cat_dalee">
            <a itemprop="url" class="button lnk_view btn btn-default" href="{$product.link|escape:'html':'UTF-8'}" title="{l s='View'}">
                <span>{if (isset($product.customization_required) && $product.customization_required)}{l s='Customize'}{else}{l s='More'}{/if}</span>
            </a>
        </div>
        </div>
        </li>
    {/foreach}
    </ul>



    {addJsDefL name=min_item}{l s='Please select at least one product' js=1}{/addJsDefL}
    {addJsDefL name=max_item}{l s='You cannot add more than %d product(s) to the product comparison' sprintf=$comparator_max_item js=1}{/addJsDefL}
    {addJsDef comparator_max_item=$comparator_max_item}
    {if isset($combinations) && $combinations}
        {addJsDef allcombinations=$combinations}
    {/if}
    {addJsDef currencyRate=$currencyRate|floatval}
    {addJsDef currencyFormat=$currencyFormat|intval}
    {addJsDef comparedProductsIds=$compared_products}
    {addJsDef currencySign=$currencySign|html_entity_decode:2:"UTF-8"}
    {addJsDef currencyBlank=$currencyBlank|intval}
{/if}

