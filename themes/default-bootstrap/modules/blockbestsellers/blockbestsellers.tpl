{*
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
*}

<!-- выводит самые продаваемые товары (лидеры, хиты продаж)_tat_ меняла много, но модуль пришлось заменить на homefeatured (рекомендуемые товары на главной-->
	<div class="title_red">{l s='Top sellers' mod='blockbestsellers'}</div>
	<div class="tovar_cont">
	{if $best_sellers && $best_sellers|@count > 0}
		{foreach from=$best_sellers item=product name=myLoop}
			<div class="tovar" itemscope="" itemtype="https://schema.org/Product">
				<div class="tovar_img">
					<a itemprop="url" href="{$product.link|escape:'html'}" title="{$product.legend|escape:'html':'UTF-8'}" class="products-block-image content_img clearfix">
						<p itemprop="name">{$product.name|strip_tags:'UTF-8'|escape:'html':'UTF-8'}</p>
						<img itemprop="imag" src="{$link->getImageLink($product.link_rewrite, $product.id_image, 'medium_default')|escape:'html'}" alt="{$product.legend|escape:'html':'UTF-8'}" />
					</a>
				</div>
				<div class="tovar_info" itemprop="description">
					{if ($product.features)}
                    	{if ($product.features[1])}
                    		<p>{$product.features[1].name}</p>
                    		<span>{$product.features[1].value}</span>
                    	{else}
                    		<p>-</p>
                    	{/if}
                    	{if ($product.features[2])}
                    		<p>{$product.features[2].name}</p>
                    		<span>{$product.features[2].value}</span>
                    	{else}
                    		<p>-</p>
                    	{/if}
                    	{if ($product.features[0])}
                    		<p>{$product.features[0].name}</p>
                    		<span>{$product.features[0].value}</span>
                    	{else}
                    		<p>-</p>
                    	{/if}  
                    {/if}
                </div>
                {if !$PS_CATALOG_MODE}
                        <div class="tovar_cena">
                            Цена: 
                            {if ($product.specific_prices.reduction)!=0}                            
                            	<span class="oldprice">{$product.price_without_reduction|ceil}p</span>
                            {/if}
                            <span  itemprop="price" class="price">{$product.price|ceil}p</span>
                            <meta itemprop="priceCurrency" content="RUB" />
                        </div>
                    {/if}
			</div>
		{/foreach}
		
<!--		<div class="lnk">
        	<a href="{$link->getPageLink('best-sales')|escape:'html'}" title="{l s='All best sellers' mod='blockbestsellers'}"  class="btn btn-default button button-small"><span>{l s='All best sellers' mod='blockbestsellers'}<i class="icon-chevron-right right"></i></span></a>
        </div> -->
	{else}
		<p>{l s='No best sellers at this time' mod='blockbestsellers'}</p>
	{/if}
	</div><!-- tovar_cont -->

<!-- /MODULE Block best sellers -->