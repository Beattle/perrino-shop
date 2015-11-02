{*
* 2007-2015 PrestaShop MODULE Block specials _tat_ Вывод товаров со скидкой, меняла оч много _tat_ Выводит уценённые товары. Изменяла функцию в одноимённом php-файле hookRightColumn, которая выводила слева один случайный товар, сейчас кол-во указанное в конфигурации, а здесь добавила {if $specials}{foreach from=$specials item=special} вместо {if $special} и {/foreach}{else}, вместо {else} Добавила условие Если скидка 30% и более И вывод товаров начиная со случайного числа
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


	<div class="left_title cpec">
       <!-- <a href="{$link->getPageLink('prices-drop')|escape:'html':'UTF-8'}" title="{l s='Specials' mod='blockspecials'}">-->
            {l s='Specials' mod='blockspecials'}<!--Спецпредложения-->
           
        <!--</a>-->
    </div>
     <div class="cpec_cont">	
	    {if $specials}
	    {if $specials|@count > 10}<!--Если товаров со скидкой больше 10-ти, то имеет смысл вводить случайное число от которого вывод товаров-->
	    	{$random_max = $specials|@count - 10}<!--Кончая этим числом я гарантированно имею 10 товаров для вывода-->
	    	{math assign="random_var" equation=rand(0,$random_max)}<!--Начиная с этого числа вывод-->
	    {else}
	    	
	    	$smarty->assign("random_var", 0);
	    {/if}	   
	    {foreach key=key from=$specials item=special}
{*            {if  !empty($special.attachments) && count($special.attachments) === 1}
                {assign var="attach" value=$special.attachments[0]}
            {else}
                {assign var="attach" value=""}
            {/if}*}

	    
	    	{if $key > $random_var && $key <= $random_var+10}<!--Начиная с этого числа вывод-->    
	    	{if $special.specific_prices.reduction*100|floatval > 29} <!--Если скидка 30% и более-->
	    	
	    	<div itemscope="" itemtype="https://schema.org/Product" class="cpec_bl">
				<div class="cpec_img">        	
            	<a itemprop="url" href="{$special.link|escape:'html':'UTF-8'}">
                    <img itemprop="image"
                    src="{$link->getImageLink($special.link_rewrite, $special.id_image, 'small_default')|escape:'html':'UTF-8'}" 
                    alt="{$special.legend|escape:'html':'UTF-8'}" 
                    title="{$special.name|escape:'html':'UTF-8'}" />
                    <p itemprop="name">
                            {$special.name|escape:'html':'UTF-8'}
                    </p>
{*                    {if !empty($attach)}
                        <img title="{$attach.description}" itemprop="image" src="{$link->getPageLink('attachment', true, NULL, "id_attachment={$attach.id_attachment}")|escape:'html':'UTF-8'}" class="icon-a replace-2x img-responsive" />
                    {/if}*}
                </a>
                </div>
                	
                   <!-- {if isset($special.description_short) && $special.description_short}
                    	<p class="product-description">
                            {$special.description_short|strip_tags:'UTF-8'|truncate:40}
                        </p>
                    {/if}-->
                    
                    	{if !$PS_CATALOG_MODE}
                        	<div class="oldprice">
                                    {$special.price_without_reduction|ceil}p
                            </div>
                             {if $special.specific_prices}
                                {assign var='specific_prices' value=$special.specific_prices}
                                {if $specific_prices.reduction_type == 'percentage' && ($specific_prices.from == $specific_prices.to OR ($smarty.now|date_format:'%Y-%m-%d %H:%M:%S' <= $specific_prices.to && $smarty.now|date_format:'%Y-%m-%d %H:%M:%S' >= $specific_prices.from))}
                                    <div itemprop="description" class="cpec_skidka">cкидка {$specific_prices.reduction*100|floatval}%</div>
                                {/if}
                            {/if}
                             <div   class="cpec_cena2">
                                   <p itemprop="price">{$special.price|ceil}</p>рублей
                                   <meta itemprop="priceCurrency" content="RUB" />
                            </div>
                        {/if}
                    
                
            
		
		<!--<div>
			<a 
            class="btn btn-default button button-small" 
            href="{$link->getPageLink('prices-drop')|escape:'html':'UTF-8'}" 
            title="{l s='All specials' mod='blockspecials'}">
                <span>{l s='All specials' mod='blockspecials'}<i class="icon-chevron-right right"></i></span>
            </a>
		</div>-->
		</div><!--cpec_cont-->
		{/if}<!--Если скидка 30% и более-->
		{/if}<!-- key -->
		{/foreach}		
    {else}
		<div>{l s='No specials at this time.' mod='blockspecials'}</div>
    {/if}
	
	</div>

<!-- /MODULE Block specials -->