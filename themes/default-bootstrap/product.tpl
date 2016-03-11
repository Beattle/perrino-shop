{*
* 2007-2014 PrestaShop
*
* NOTICE OF LICENSE _tat_ Вывод продукта. Меняла, переставляла и удаляла оч. много
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
*  @copyright  2007-2014 PrestaShop SA
*  @license    http://opensource.org/licenses/afl-3.0.php  Academic Free License (AFL 3.0)
*  International Registered Trademark & Property of PrestaShop SA
*}
{include file="$tpl_dir./errors.tpl"}
{if $errors|@count == 0}
	{if !isset($priceDisplayPrecision)}
		{assign var='priceDisplayPrecision' value=2}
	{/if}
	{if !$priceDisplay || $priceDisplay == 2}
		{assign var='productPrice' value=$product->getPrice(true, $smarty.const.NULL, $priceDisplayPrecision)}
		{assign var='productPriceWithoutReduction' value=$product->getPriceWithoutReduct(false, $smarty.const.NULL)}
	{elseif $priceDisplay == 1}
		{assign var='productPrice' value=$product->getPrice(false, $smarty.const.NULL, $priceDisplayPrecision)}
		{assign var='productPriceWithoutReduction' value=$product->getPriceWithoutReduct(true, $smarty.const.NULL)}
	{/if}
 <div itemtype="http://schema.org/Product" itemscope="" class="product_block">

 {assign var=last value=$combinations|@end}





		<!-- серпантин1-->
 		{if !$content_only}
			<div class="container">
				<div class="top-hr"></div>
			</div>
		{/if}
		{if isset($adminActionDisplay) && $adminActionDisplay}
			<div id="admin-action">
				<p>{l s='This product is not visible to your customers.'}
					<input type="hidden" id="admin-action-product-id" value="{$product->id}" />
					<input type="submit" value="{l s='Publish'}" name="publish_button" class="exclusive" />
					<input type="submit" value="{l s='Back'}" name="lnk_view" class="exclusive" />
				</p>
				<p id="admin-action-result"></p>
			</div>
		{/if}
		{if isset($confirmation) && $confirmation}
			<p class="confirmation">
				{$confirmation}
			</p>
		{/if}
 		<!--конец серпантин1-->
 		
 		
 		<!-- Data sheet Вывод характеристик в нужном порядке-->
				{*Присваиваю значения массиву выводимых в категории характеристик*}
			{foreach from=$features item=feature}				
				{if $feature.name == "Жёсткость"}
					{assign var=hardnessTitle value=$feature.name}
						{if isset($feature.value) && $feature.value}
							{assign var=hardness value=$feature.value}
						{else}
							{assign var=hardness value="-"}
						{/if}
				{else}
					{if $feature.name == "Жёсткость наматрасника" || $feature.name == "Жёсткость подушки"}
					{assign var=hardnessNamatrassTitle value="Жёсткость"}
						{if isset($feature.value) && $feature.value}
							{assign var=hardnessNamatrass value=$feature.value}
						{else}
							{assign var=hardnessNamatrass value="-"}
						{/if}
					{else}
					{if $feature.name == "Высота матраса"}
						{assign var=heightTitle value="Высота"}
						{if isset($feature.value) && $feature.value}
							{assign var=height value=$feature.value}								
						{else}
							{assign var=height value="-"}								
						{/if}
					{else}
					{if $feature.name == "Высота подушки" || $feature.name == "Высота наматрасника" || $feature.name == "Высота кровати"}
						{assign var=heightNamatrassTitle value="Высота"}
						{if isset($feature.value) && $feature.value}
							{assign var=heightNamatrass value=$feature.value}								
						{else}
							{assign var=heightNamatrass value="-"}								
						{/if}
					{else}
						{if $feature.name == "Макс. вес на место"}
							{assign var=vesTitle value="Макс. вес на спальное место"}
								{if isset($feature.value) && $feature.value}
									{assign var=ves value=$feature.value}
								{else}
									{assign var=ves value="-"}
								{/if}
						{else}
							{if $feature.name == "Тип матраса"}
								{assign var=typeMatressTitle value=$feature.name}
								{if isset($feature.value) && $feature.value}
									{assign var=typeMatress value=$feature.value}
								{else}
									{assign var=typeMatress value="-"}
								{/if}
							{else}
								{if $feature.name == "Наполнение"}{*Матрас*}
											{assign var=naFullMatrasTitle value=$feature.name}
											{if isset($feature.value) && $feature.value}
												{assign var=naFullMatras value=$feature.value}
											{else}
												{assign var=naFullMatras value="-"}
											{/if}
								{else}							
								{if $feature.name == "Тип пружин"}
									{assign var=typePruzinTitle value=$feature.name}
									{if isset($feature.value) && $feature.value}
										{assign var=typePruzin value=$feature.value}
									{else}
										{assign var=typePruzin value="-"}
									{/if}
									{else}
										{if $feature.name == "Наполнитель"}{*Не матрас*}
											{assign var=naFullTitle value=$feature.name}
											{if isset($feature.value) && $feature.value}
												{assign var=naFull value=$feature.value}
											{else}
												{assign var=naFull value="-"}
											{/if}
										{else}
											{if $feature.name == "Гарантия"}
												{assign var=garantiaTitle value=$feature.name}
												{if isset($feature.value) && $feature.value}
													{assign var=garantia value=$feature.value}
												{else}
													{assign var=garantia value="-"}
												{/if}
											{else}
												{if $feature.name == "Жёсткость второй стороны"}
													{assign var=hardnessDopTitle value=$feature.name}
														{if isset($feature.value) && $feature.value}
															{assign var=hardnessDop value=$feature.value}
														{else}
															{assign var=hardnessDop value="-"}
														{/if}
														
														{else}
															{if $feature.name == "Размер подушки"}
																{assign var=pxpPodushkiTitle value="Размер"}
																{if isset($feature.value) && $feature.value}
																	{assign var=pxpPodushki value=$feature.value}
																{else}
																	{assign var=pxpPodushki value="-"}
																{/if}
																{else}
																
																
																
																	{if $feature.name == "Тип наматрасника"}
									{assign var=typeNamatress value="+"}
									{assign var=typeNamatressIzmTitle value="Тип"}
									{if isset($feature.value) && $feature.value}
										{assign var=typeNamatressIzm value=$feature.value}
									{else}
										{assign var=typeNamatressIzm value="-"}
									{/if}
									{else}
										{if $feature.name == "Состав"}
													{assign var=sostavTitle value=$feature.name}
													{if isset($feature.value) && $feature.value}
														{assign var=sostav value=$feature.value}
													{else}
														{assign var=sostav value="-"}
													{/if}
									
									
									{else}
										{if $feature.name == "Размер (ШxГxВ)"}
													{assign var=pxphgvTitle value=$feature.name}
													{if isset($feature.value) && $feature.value}
														{assign var=pxphgv value=$feature.value}
													{else}
														{assign var=pxphgv value="-"}
													{/if}
									
									{else}
										{if $feature.name == "Спинка"}
													{assign var=spinkaTitle value=$feature.name}
													{if isset($feature.value) && $feature.value}
														{assign var=spinka value=$feature.value}
													{else}
														{assign var=spinka value="-"}
													{/if}
								{else}
										{if $feature.name == "Обивка"}
													{assign var=obivkaTitle value=$feature.name}
													{if isset($feature.value) && $feature.value}
														{assign var=obivka value=$feature.value}
													{else}
														{assign var=obivka value="-"}
													{/if}
								{else}
										{if $feature.name == "Корпус"}
													{assign var=korpusTitle value=$feature.name}
													{if isset($feature.value) && $feature.value}
														{assign var=korpus value=$feature.value}
													{else}
														{assign var=korpus value="-"}
													{/if}
								{else}
										{if $feature.name == "Фасад"}
													{assign var=fasadTitle value=$feature.name}
													{if isset($feature.value) && $feature.value}
														{assign var=fasad value=$feature.value}
													{else}
														{assign var=fasad value="-"}
													{/if}
								
							{else}
										{if $feature.name == "Ножки"}
													{assign var=nozkiTitle value=$feature.name}
													{if isset($feature.value) && $feature.value}
														{assign var=nozki value=$feature.value}
													{else}
														{assign var=nozki value="-"}
													{/if}
						{else}
										{if $feature.name == "Фурнитура"}
													{assign var=furnituraTitle value=$feature.name}
													{if isset($feature.value) && $feature.value}
														{assign var=furnitura value=$feature.value}
													{else}
														{assign var=furnitura value="-"}
													{/if}
									
									
									
									
									
									
									
									{/if}
									{/if}
									{/if}
									{/if}
									{/if}
									{/if}
									{/if}
									{/if}
									
									
									
									
									
									
									
									
								{/if}						
														{/if}
														{/if}			
														{/if}
													{/if}	
												{/if}
											{/if}
										{/if}
									{/if}								
								{/if}	
							{/if}
					{/if}
				{/if}	
			{/foreach}	
			
		
			
			
			
			<!-- left infos-->
			
			<div class="cat_title">
				<h1 itemprop="name">{$product->name|escape:'html':'UTF-8'}</h1>
			</div>
			
			<div class="product_img">
			<!-- product img-->
			<div id="image-block" class="product_img {$cover.id_image}">
				
				{if $have_image}
					<span id="view_full_size"><!-- Картинка большая-->	
						{if $jqZoomEnabled && $have_image && !$content_only}
							<a class="jqzoom" title="{if !empty($cover.legend)}{$cover.legend|escape:'html':'UTF-8'}{else}{$product->name|escape:'html':'UTF-8'}{/if}" rel="gal1" href="{$link->getImageLink($product->link_rewrite, $cover.id_image, 'thickbox_default')|escape:'html':'UTF-8'}" itemprop="url">
								<img itemprop="image" src="{$link->getImageLink($product->link_rewrite, $cover.id_image, 'large_default')|escape:'html':'UTF-8'}" title="{if !empty($cover.legend)}{$cover.legend|escape:'html':'UTF-8'}{else}{$product->name|escape:'html':'UTF-8'}{/if}" alt="{if !empty($cover.legend)}{$cover.legend|escape:'html':'UTF-8'}{else}{$product->name|escape:'html':'UTF-8'}{/if}"/>
							</a>
						{else}<!-- Картинка большая-->	
							<img id="bigpic" itemprop="image" src="{$link->getImageLink($product->link_rewrite, $cover.id_image, 'large_default')|escape:'html':'UTF-8'}" title="{if !empty($cover.legend)}{$cover.legend|escape:'html':'UTF-8'}{else}{$product->name|escape:'html':'UTF-8'}{/if}" alt="{if !empty($cover.legend)}{$cover.legend|escape:'html':'UTF-8'}{else}{$product->name|escape:'html':'UTF-8'}{/if}" width="{$largeSize.width}" height="{$largeSize.height}"/>
                            {if !empty($attachments) && count ($attachments === 1)}{assign var="attach" value=$attachments[0]}
                                <img itemprop="image" class="icon-a 2-replace img-responsive" src="{$link->getPageLink('attachment', true, NULL, "id_attachment={$attach.id_attachment}")|escape:'html':'UTF-8'}" title="{$attach.description}" />
                            {/if}
							
						{/if}
					</span>
				{else}
					<span id="view_full_size"><!-- Если картинок нет? -->
						<img itemprop="image" src="{$img_prod_dir}{$lang_iso}-default-large_default.jpg" id="bigpic" alt="" title="{$product->name|escape:'html':'UTF-8'}" width="{$largeSize.width}" height="{$largeSize.height}"/>
						{if !$content_only}
							<span class="span_link">
								{l s='View larger'}
							</span>
						{/if}
					</span>
				{/if}
			</div> <!-- end image-block При перенесении в конец img-блока А-ть не будет-->
			<div class="product_img">
			{if isset($images) && count($images) > 0}
				<!-- thumbnails Картинки малые-->
				<div id="views_block" class="{if isset($images) && count($images) < 2}hidden{/if}">
					
					<div id="thumbs_list">
						<ul id="thumbs_list_frame">
						{if isset($images)}
							{foreach from=$images item=image name=thumbnails}
								{assign var=imageIds value="`$product->id`-`$image.id_image`"}
								{if !empty($image.legend)}
									{assign var=imageTitle value=$image.legend|escape:'html':'UTF-8'}
								{else}
									{assign var=imageTitle value=$product->name|escape:'html':'UTF-8'}
								{/if}
								<li id="thumbnail_{$image.id_image}"{if $smarty.foreach.thumbnails.last} class="last"{/if}>
									<a{if $jqZoomEnabled && $have_image && !$content_only} href="javascript:void(0);" rel="{literal}{{/literal}gallery: 'gal1', smallimage: '{$link->getImageLink($product->link_rewrite, $imageIds, 'large_default')|escape:'html':'UTF-8'}',largeimage: '{$link->getImageLink($product->link_rewrite, $imageIds, 'thickbox_default')|escape:'html':'UTF-8'}'{literal}}{/literal}"{else} href="{$link->getImageLink($product->link_rewrite, $imageIds, 'thickbox_default')|escape:'html':'UTF-8'}"	data-fancybox-group="other-views" class="fancybox{if $image.id_image == $cover.id_image} shown{/if}"{/if} title="{$imageTitle}">
										<img class="img-responsive" id="thumb_{$image.id_image}" src="{$link->getImageLink($product->link_rewrite, $imageIds, 'cart_default')|escape:'html':'UTF-8'}" alt="{$imageTitle}" title="{$imageTitle}" height="{$cartSize.height}" width="{$cartSize.width}" itemprop="image" />
									</a>
								</li>
							{/foreach}
						{/if}
						</ul>
					</div> <!-- end thumbs_list (до end views-block было убрано до linghtBox-->

				</div> <!-- end views-block -->
				<!-- end thumbnails картинки малые-->
			{/if}
			{if isset($images) && count($images) > 1}
				<p class="resetimg clear no-print">
					<span id="wrapResetImages" style="display: none;">
						<a href="{$link->getProductLink($product)|escape:'html':'UTF-8'}" id="resetImages">
							<i class="icon-repeat"></i>
							{l s='Display all pictures'}
						</a>
					</span>
				</p>
			{/if}			
		<!-- end left infos-->
		</div> <!-- end image-block 1-->	
		</div> <!-- end image-block wrapper-->		
			
			
			
				
				
				
			<div class="pb-center-column"><!-- описание товара -->
			 
			
			
				<div class="product_attributes clearfix">
					{foreach from=$features item=feature}
						{if isset($pxpPodushkiTitle) && $pxpPodushkiTitle}
							<div class="zaplatka"></div><!-- Если подушка, чтобы не смещалась цена -->
						{/if}
					{/foreach}						
					{if isset($groups)}
					<!-- attributes, в этом магазине - размер -->
						
						<div id="attributes">
							<div class="cat_size">
								<div class="clearfix"></div>
								{foreach from=$groups key=id_attribute_group item=group}
									{if $group.attributes|@count}
										<fieldset class="attribute_fieldset">
											<span {if $group.group_type != 'color' && $group.group_type != 'radio'} {/if}>{$group.name|escape:'html':'UTF-8'}&nbsp;</span>
											{assign var="groupName" value="group_$id_attribute_group"}
											
												{if ($group.group_type == 'select')}
												<div class="selectWrapper">

												<div class="selector">
													<select name="{$groupName}" id="group_{$id_attribute_group|intval}" class="attribute_select">
														{foreach from=$group.attributes key=id_attribute item=group_attribute}
															<option value="{$id_attribute|intval}"{if (isset($smarty.get.$groupName) && $smarty.get.$groupName|intval == $id_attribute) || $group.default == $id_attribute} selected="selected"{/if} title="{$group_attribute|escape:'html':'UTF-8'}">{$group_attribute|escape:'html':'UTF-8'}</option>
														{/foreach}
													</select>
												</div>
												</div><!-- selectWrapper -->
												{elseif ($group.group_type == 'color')}
													<ul id="color_to_pick_list" class="clearfix">
														{assign var="default_colorpicker" value=""}
														{foreach from=$group.attributes key=id_attribute item=group_attribute}
															{assign var='img_color_exists' value=file_exists($col_img_dir|cat:$id_attribute|cat:'.jpg')}
															<li{if $group.default == $id_attribute} class="selected"{/if}>
																<a href="{$link->getProductLink($product)|escape:'html':'UTF-8'}" id="color_{$id_attribute|intval}" name="{$colors.$id_attribute.name|escape:'html':'UTF-8'}" class="color_pick{if ($group.default == $id_attribute)} selected{/if}"{if !$img_color_exists && isset($colors.$id_attribute.value) && $colors.$id_attribute.value} style="background:{$colors.$id_attribute.value|escape:'html':'UTF-8'};"{/if} title="{$colors.$id_attribute.name|escape:'html':'UTF-8'}">
																	{if $img_color_exists}
																		<img src="{$img_col_dir}{$id_attribute|intval}.jpg" alt="{$colors.$id_attribute.name|escape:'html':'UTF-8'}" title="{$colors.$id_attribute.name|escape:'html':'UTF-8'}" width="20" height="20" />
																	{/if}
																</a>
															</li>
															{if ($group.default == $id_attribute)}
																{$default_colorpicker = $id_attribute}
															{/if}
														{/foreach}
													</ul>
													<input type="hidden" class="color_pick_hidden" name="{$groupName|escape:'html':'UTF-8'}" value="{$default_colorpicker|intval}" />
												{elseif ($group.group_type == 'radio')}
													<ul>
														{foreach from=$group.attributes key=id_attribute item=group_attribute}
															<li>
																<input type="radio" class="attribute_radio" name="{$groupName|escape:'html':'UTF-8'}" value="{$id_attribute}" {if ($group.default == $id_attribute)} checked="checked"{/if} />
																<span>{$group_attribute|escape:'html':'UTF-8'}</span>
															</li>
														{/foreach}
													</ul>
												{/if}
											
										</fieldset>
									{/if}
								{/foreach}
							</div> <!-- cat_size-->
						</div> <!-- end attributes -->
					{/if}
				</div> <!-- end product_attributes -->
				<div class="clear"></div>
				<div class="clearBotch"></div>
				{if (isset($typeMatressTitle) && $typeMatressTitle) || (isset($typeNamatress) && $typeNamatress)}<!-- Если это матрас или наматрасник-->
						<div class="NoStandart_product">
							<a href="http://perrino-shop.ru/content/NoStandart.html">Нужен нестандарт?</a>
						</div>
					{/if}
					
			
			<!-- прайс and add to cart form-->
		<div class="pb-right-column col-xs-12 col-sm-4 col-md-3">
			{if ($product->show_price && !isset($restricted_country_mode)) || isset($groups) || $product->reference || (isset($HOOK_PRODUCT_ACTIONS) && $HOOK_PRODUCT_ACTIONS)}
			<!-- add to cart form-->
			<form id="buy_block"{if $PS_CATALOG_MODE && !isset($groups) && $product->quantity > 0} class="hidden"{/if} action="{$link->getPageLink('cart')|escape:'html':'UTF-8'}" method="post">
				<!-- hidden datas -->
				<p class="hidden">
					<input type="hidden" name="token" value="{$static_token}" />
					<input type="hidden" name="id_product" value="{$product->id|intval}" id="product_page_product_id" />
					<input type="hidden" name="add" value="1" />
					<input type="hidden" name="id_product_attribute" id="idCombination" value="" />
				</p>				
				<div class="cat_cena">
						{if $product->show_price && !isset($restricted_country_mode) && !$PS_CATALOG_MODE}
							<!-- prices -->
								<!-- старая цена -->
								<div{if (!$product->specificPrice || !$product->specificPrice.reduction) && $group_reduction == 0} class="hidden"{/if}>
									<!-- не попадаю -->
									{if $priceDisplay >= 0 && $priceDisplay <= 2}
										<span>{hook h="displayProductPriceBlock" product=$product type="old_price"}</span><!-- конец не попадаю -->

                                            <span id="old_price_display" class="oldprice">
                                                {if $productPriceWithoutReduction > $productPrice}{convertPrice price=$productPriceWithoutReduction}
                                                {/if}
                                            </span>

										<!-- процент скидки -->
										{if !$product->specificPrice || $product->specificPrice.reduction_type != 'percentage'} {/if} <!-- было style="display:none;" -->									
										{if $product->specificPrice && $product->specificPrice.reduction_type == 'percentage'}-{$product->specificPrice.reduction*100}%{/if}
									<!-- конец процент скидки -->
									{/if}
								</div>
								<!-- конец старая цена -->
								<!-- Результирующая цена -->
								<p itemprop="offers" itemscope itemtype="http://schema.org/AggregateOffer">
									
									{if $priceDisplay >= 0 && $priceDisplay <= 2}
										<span itemprop="lowPrice" id="our_price_display">{convertPrice price=$productPrice}</span>
                                        <meta content="{$combinations|@count}" itemprop="offerCount" />
                                        <meta itemprop="priceCurrency" content="RUB" />
										{hook h="displayProductPriceBlock" product=$product type="price"}
									{/if}
								</p>
								<!-- конец Результирующая цена -->
							
						{/if} {*close if for show price*}
						
					
				</div> <!-- end cat_cena -->
					<div class="cat_add"{if (!$allow_oosp && $product->quantity <= 0) || !$product->available_for_order || (isset($restricted_country_mode) && $restricted_country_mode) || $PS_CATALOG_MODE} class="unvisible"{/if}>
							<p id="add_to_cart">
								<button type="submit" name="Submit">
									<span>{if $content_only && (isset($product->customization_required) && $product->customization_required)}{l s='Customize'}{else}{l s='Add to cart'}{/if}</span>
								</button>
							</p>
					</div> <!-- cat_add -->
				
			</form>
			<div class="clearBotch"></div>
			{/if}
		</div> <!-- end pb-right-column прайс and add to cart form-->
			
			
			
			
			
	{if !$content_only}
		{if isset($features) && $features}			
			<div class="product_info">
				<!-- Data sheet Простой вывод характеристик-->
				{*foreach from=$features item=feature}
					{if isset($feature.value)}						
					<div>
						{if $feature.name == "Макс. вес на место"}
							<p>{l s='Макс. вес на спальное место'}</p>
						{else}							
							<p>{$feature.name|escape:'html':'UTF-8'}</p>
						{/if}
						<span>{$feature.value|escape:'html':'UTF-8'}</span>
					</div>
					{/if}
				{/foreach*}
				
			
			{*Вывожу характеристики в нужном порядке*}
			
				{if isset($pxpPodushkiTitle) && $pxpPodushkiTitle}					
					<div>
						<p>{$pxpPodushkiTitle}</p>
						<span>{$pxpPodushki}</span>
					</div>
				{/if}
					{if isset($typeMatressTitle) && $typeMatressTitle}
						<div>
							<a href="http://perrino-shop.ru/articles/4_choose-ur--mattress#typeMatrass"><p>{$typeMatressTitle}</p>
							<span>{$typeMatress}</span></a>
						</div>
					{/if}
				{if isset($typeNamatressIzmTitle) && $typeNamatressIzmTitle}
						<div>
							<p>{$typeNamatressIzmTitle}</p>
							<span>{$typeNamatressIzm}</span>
						</div>
				{/if}
				
				
				
				
				
				
				
				{if isset($pxphgvTitle) && $pxphgvTitle}
						<div>
							<p>{$pxphgvTitle}</p>
							<span>{$pxphgv}</span>
						</div>
				{/if}
				{if isset($spinkaTitle) && $spinkaTitle}
						<div>
							<p>{$spinkaTitle}</p>
							<span>{$spinka}</span>
						</div>
				{/if}
				{if isset($korpusTitle) && $korpusTitle}
						<div>
							<p>{$korpusTitle}</p>
							<span>{$korpus}</span>
						</div>
				{/if}
				{if isset($fasadTitle) && $fasadTitle}
						<div>
							<p>{$fasadTitle}</p>
							<span>{$fasad}</span>
						</div>
				{/if}
				{if isset($obivkaTitle) && $obivkaTitle}
						<div>
							<p>{$obivkaTitle}</p>
							<span>{$obivka}</span>
						</div>
				{/if}
				{if isset($nozkiTitle) && $nozkiTitle}
						<div>
							<p>{$nozkiTitle}</p>
							<span>{$nozki}</span>
						</div>
				{/if}
				{if isset($furnituraTitle) && $furnituraTitle}
						<div>
							<p>{$furnituraTitle}</p>
							<span>{$furnitura}</span>
						</div>
				{/if}
				
				         
				
				
				
				
				
				
				
				
				
				{if isset($sostavTitle) && $sostavTitle}
						<div>
							<p>{$sostavTitle}</p>
							<span>{$sostav}</span>
						</div>
				{/if}				
					{if isset($naFullMatrasTitle) && $naFullMatrasTitle}
							<div>
								<a href="http://perrino-shop.ru/articles/4_choose-ur--mattress#typeMatrass"><p>{$naFullMatrasTitle}</p>
								<span>{$naFullMatras}</span></a>
							</div>						
						{/if}					
						{if isset($naFullTitle) && $naFullTitle}
							<div>
								<p>{$naFullTitle}</p>
								<span>{$naFull}</span>
							</div>						
						{/if}
							{if isset($typePruzinTitle) && $typePruzinTitle}
								<div>
									<a href="http://perrino-shop.ru/articles/4_choose-ur--mattress#typePruzjin"><p>{$typePruzinTitle}</p>
									<span>{$typePruzin}</span></a>
								</div>						
							{/if}
								{if isset($hardnessTitle) && $hardnessTitle}
									<div>
										<a href="http://perrino-shop.ru/articles/4_choose-ur--mattress#zjestcost"><p>{$hardnessTitle}</p>
										<span>{$hardness}</span></a>
									</div>						
								{/if}
								{*Наматрасник и подушка*}
								{if isset($hardnessNamatrassTitle) && $hardnessNamatrassTitle}
									<div>
										<p>{$hardnessNamatrassTitle}</p>
										<span>{$hardnessNamatrass}</span>
									</div>						
								{/if}								
									{if isset($hardnessDopTitle) && $hardnessDopTitle}
										<div>
											<a href="http://perrino-shop.ru/articles/4_choose-ur--mattress#typeMatrass"><p>{$hardnessDopTitle}</p>
											<span>{$hardnessDop}</span></a>
										</div>						
									{/if}	
										{if isset($heightTitle) && $heightTitle}{*Матрас*}
											<div>
												<a href="http://perrino-shop.ru/articles/4_choose-ur--mattress#h"><p>{$heightTitle}</p>
												<span>{$height}</span></a>
											</div>
										{/if}
										{if isset($heightNamatrassTitle) && $heightNamatrassTitle}{*Высота наматрасника, подушки, кровати - всего, для чего не надо ссылки*}
											<div>
												<p>{$heightNamatrassTitle}</p>
												<span>{$heightNamatrass}</span>
											</div>
										{/if}
											{if isset($vesTitle) && $vesTitle}
												<div>
													<a href="http://perrino-shop.ru/articles/4_choose-ur--mattress#vesMesto"><p>{$vesTitle}</p>
													<span>{$ves}</span></a>
												</div>
											{/if}
												{if isset($garantiaTitle) && $garantiaTitle}
													<div>
														<p>{$garantiaTitle}</p>
														<span>{$garantia}</span>
													</div>				
												
				{/if}
				
				
				{*Вывожу новые характеристики В КОНЦЕ (в противном случае второй foreach не нужен*}
				{foreach from=$features item=feature}				
					{if $feature.name != "Высота матраса" && $feature.name != "Высота подушки" && $feature.name != "Высота наматрасника" && $feature.name != "Высота кровати" && $feature.name != "Макс. вес на место" && $feature.name != "Тип матраса" && $feature.name != "Тип пружин" && $feature.name != "Наполнитель" && $feature.name != "Наполнение" && $feature.name != "Гарантия" && $feature.name != "Жёсткость второй стороны" && $feature.name != "Размер подушки" && $feature.name != "Жёсткость" && $feature.name != "Жёсткость наматрасника" && $feature.name != "Жёсткость подушки" && $feature.name != "Тип наматрасника" && $feature.name != "Состав" && $feature.name != "Размер (ШxГxВ)" && $feature.name != "Спинка" && $feature.name != "Корпус" && $feature.name != "Фасад" && $feature.name != "Обивка" && $feature.name != "Ножки" && $feature.name != "Фурнитура"}
																<div>
																	<p>{$feature.name}</p>
																	{if isset($feature.value) && $feature.value}
																		<span>{$feature.value}</span>
																	{else}
																		<span>{l s='-'}</span>
																	{/if}
																</div>
														
														
																
														
				{/if}	
			{/foreach}



			</div><!--product_info -->
			<!--end Data sheet -->
		{/if}
        {if isset($bed_colors) && $bed_colors}

            <div class="sel-cont">
                <button  class="prev">&laquo;</button>
                <button  class="next">&raquo;</button>

                <div class="j-sel">
                    <ul>
                        {foreach from=$bed_colors key=id item=color}
                            <li>
                                <a data-id="{$id}" id="{$color.slug}" class="link-to-img" href="{$smarty.const._PS_IMG_}bed_pics/{$color.slug}.jpg">
                                    <img height="40" width="40" title="{$color.name}" src="{$smarty.const._PS_IMG_}bed_pics/{$color.slug}.jpg" />
                                    <span class="color-name">{$color.name}</span>
                                </a>
                            </li>
                        {/foreach}
                    </ul>
                </div>
            </div>
        {/if}

        {if isset($foundations) && $foundations}
            <div id="foundations">
                <h3>Выбор основания</h3>
                <ul>
                    {foreach from=$foundations key=id item=foundation}
                        <li>
                            <a data-price="{$foundation.price}" data-fid="{$id}" data-combid="" id="foundation-link" href='{$foundation.href}' title='{$foundation.name}'>
                                <img alt='{$foundation.name}' src="{$foundation.img_src}" />
                                <span class="name">{$foundation.name|truncate:50}</span>
                            </a>
                        </li>
                    {/foreach}
                </ul>
            </div>
        {/if}



	{/if}	
</div> <!-- Описание товара -->
			
			
			
			
			
			

	<div class="clearBotch"></div>
	{if isset($product) && $product->description}
					<!-- full description -->
					<div  itemprop="description" class="descriptorTovar">{$product->description}</div>
		{/if}


	{if !$content_only}
		
		{if isset($HOOK_PRODUCT_FOOTER) && $HOOK_PRODUCT_FOOTER}{$HOOK_PRODUCT_FOOTER}{/if}<!-- В этом хуке пользовательская информация и сопутствующие товары-->
		
		<!--HOOK_PRODUCT_TAB В этом хуке отзывы-->
		<section class="page-product-box">
			{$HOOK_PRODUCT_TAB}
			{if isset($HOOK_PRODUCT_TAB_CONTENT) && $HOOK_PRODUCT_TAB_CONTENT}{$HOOK_PRODUCT_TAB_CONTENT}{/if}
		</section>
		<!--end HOOK_PRODUCT_TAB -->
		
		
		
	{/if}
 </div> <!-- product_block-->
 <!-- </div> itemscope product wrapper -->
{strip}
{if isset($smarty.get.ad) && $smarty.get.ad}
	{addJsDefL name=ad}{$base_dir|cat:$smarty.get.ad|escape:'html':'UTF-8'}{/addJsDefL}
{/if}
{if isset($smarty.get.adtoken) && $smarty.get.adtoken}
	{addJsDefL name=adtoken}{$smarty.get.adtoken|escape:'html':'UTF-8'}{/addJsDefL}
{/if}
{addJsDef allowBuyWhenOutOfStock=$allow_oosp|boolval}
{addJsDef availableNowValue=$product->available_now|escape:'quotes':'UTF-8'}
{addJsDef availableLaterValue=$product->available_later|escape:'quotes':'UTF-8'}
{addJsDef attribute_anchor_separator=$attribute_anchor_separator|escape:'quotes':'UTF-8'}
{addJsDef attributesCombinations=$attributesCombinations}
{addJsDef currencySign=$currencySign|html_entity_decode:2:"UTF-8"}
{addJsDef currencyRate=$currencyRate|floatval}
{addJsDef currencyFormat=$currencyFormat|intval}
{addJsDef currencyBlank=$currencyBlank|intval}
{addJsDef currentDate=$smarty.now|date_format:'%Y-%m-%d %H:%M:%S'}
{if isset($combinations) && $combinations}
	{addJsDef combinations=$combinations}
	{addJsDef combinationsFromController=$combinations}
	{addJsDef displayDiscountPrice=$display_discount_price}
	{addJsDefL name='upToTxt'}{l s='Up to' js=1}{/addJsDefL}
{/if}
{if isset($combinationImages) && $combinationImages}
	{addJsDef combinationImages=$combinationImages}
{/if}
{addJsDef customizationFields=$customizationFields}
{addJsDef default_eco_tax=$product->ecotax|floatval}
{addJsDef displayPrice=$priceDisplay|intval}
{addJsDef ecotaxTax_rate=$ecotaxTax_rate|floatval}
{addJsDef group_reduction=$group_reduction}
{if isset($cover.id_image_only)}
	{addJsDef idDefaultImage=$cover.id_image_only|intval}
{else}
	{addJsDef idDefaultImage=0}
{/if}
{addJsDef img_ps_dir=$img_ps_dir}
{addJsDef img_prod_dir=$img_prod_dir}
{addJsDef id_product=$product->id|intval}
{addJsDef jqZoomEnabled=$jqZoomEnabled|boolval}
{addJsDef maxQuantityToAllowDisplayOfLastQuantityMessage=$last_qties|intval}
{addJsDef minimalQuantity=$product->minimal_quantity|intval}
{addJsDef noTaxForThisProduct=$no_tax|boolval}
{addJsDef customerGroupWithoutTax=$customer_group_without_tax|boolval}
{addJsDef oosHookJsCodeFunctions=Array()}
{addJsDef productHasAttributes=isset($groups)|boolval}
{addJsDef productPriceTaxExcluded=($product->getPriceWithoutReduct(true)|default:'null' - $product->ecotax)|floatval}
{addJsDef productBasePriceTaxExcluded=($product->base_price - $product->ecotax)|floatval}
{addJsDef productBasePriceTaxExcl=($product->base_price|floatval)}
{addJsDef productReference=$product->reference|escape:'html':'UTF-8'}
{addJsDef productAvailableForOrder=$product->available_for_order|boolval}
{addJsDef productPriceWithoutReduction=$productPriceWithoutReduction|floatval}
{addJsDef productPrice=$productPrice|floatval}
{addJsDef productUnitPriceRatio=$product->unit_price_ratio|floatval}
{addJsDef productShowPrice=(!$PS_CATALOG_MODE && $product->show_price)|boolval}
{addJsDef PS_CATALOG_MODE=$PS_CATALOG_MODE}
{if $product->specificPrice && $product->specificPrice|@count}
	{addJsDef product_specific_price=$product->specificPrice}
{else}
	{addJsDef product_specific_price=array()}
{/if}
{if $display_qties == 1 && $product->quantity}
	{addJsDef quantityAvailable=$product->quantity}
{else}
	{addJsDef quantityAvailable=0}
{/if}
{addJsDef quantitiesDisplayAllowed=$display_qties|boolval}
{if $product->specificPrice && $product->specificPrice.reduction && $product->specificPrice.reduction_type == 'percentage'}
	{addJsDef reduction_percent=$product->specificPrice.reduction*100|floatval}
{else}
	{addJsDef reduction_percent=0}
{/if}
{if $product->specificPrice && $product->specificPrice.reduction && $product->specificPrice.reduction_type == 'amount'}
	{addJsDef reduction_price=$product->specificPrice.reduction|floatval}
{else}
	{addJsDef reduction_price=0}
{/if}
{if $product->specificPrice && $product->specificPrice.price}
	{addJsDef specific_price=$product->specificPrice.price|floatval}
{else}
	{addJsDef specific_price=0}
{/if}
{addJsDef specific_currency=($product->specificPrice && $product->specificPrice.id_currency)|boolval} {* TODO: remove if always false *}
{addJsDef stock_management=$stock_management|intval}
{addJsDef taxRate=$tax_rate|floatval}
{addJsDefL name=doesntExist}{l s='This combination does not exist for this product. Please select another combination.' js=1}{/addJsDefL}
{addJsDefL name=doesntExistNoMore}{l s='This product is no longer in stock' js=1}{/addJsDefL}
{addJsDefL name=doesntExistNoMoreBut}{l s='with those attributes but is available with others.' js=1}{/addJsDefL}
{addJsDefL name=fieldRequired}{l s='Please fill in all the required fields before saving your customization.' js=1}{/addJsDefL}
{addJsDefL name=uploading_in_progress}{l s='Uploading in progress, please be patient.' js=1}{/addJsDefL}
{addJsDefL name='product_fileDefaultHtml'}{l s='No file selected' js=1}{/addJsDefL}
{addJsDefL name='product_fileButtonHtml'}{l s='Choose File' js=1}{/addJsDefL}
{addJsDef foundations=$foundations}
{/strip}
{/if}
