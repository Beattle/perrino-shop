{*
* 2007-2015 PrestaShop
*
* NOTICE OF LICENSE _tat_ выводит шапку категории а потом подключает product_list.tpl и pagination.tpl. Убрала вывод картинки категории
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


{if isset($category)}
	{if $category->id AND $category->active}
		{if isset($subcategories)}
        {if (isset($display_subcategories) && $display_subcategories eq 1) || !isset($display_subcategories) }
		<!-- Subcategories -->
		<div id="subcategories">
			{*<p class="subcategory-heading" id="subcategory-heading">{l s='Subcategories'}</p>*}
			<ul class="clearfix">
			{foreach from=$subcategories item=subcategory}
				<li>
                	<div class="subcategory-image">
						<a href="{$link->getCategoryLink($subcategory.id_category, $subcategory.link_rewrite)|escape:'html':'UTF-8'}" title="{$subcategory.name|escape:'html':'UTF-8'}" class="img">
						{if $subcategory.id_image}
							<img class="replace-2x" src="{$link->getCatImageLink($subcategory.link_rewrite, $subcategory.id_image, 'medium_default')|escape:'html':'UTF-8'}" alt="" width="{$mediumSize.width}" height="{$mediumSize.height}" />
						{else}
							<img class="replace-2x" src="{$img_cat_dir}{$lang_iso}-default-medium_default.jpg" alt="" width="{$mediumSize.width}" height="{$mediumSize.height}" />
						{/if}
						<h5>{$subcategory.name|truncate:25:'...'|escape:'html':'UTF-8'|truncate:350}</h5>
					</a>
                   	</div>
					
				</li>
			{/foreach}
			</ul>
		</div>
        {/if}
            <ul {if isset($id_category) && $id_category} id="{$id_category}"{/if} class="product_list"></ul>
		{/if}
		{if $products}
            <div  class="content_sortPagiBar clearfix">
                <div class="sortPagiBar clearfix">
                    {include file="./product-sort.tpl"}
                </div>
            </div>
			{include file="./product-list.tpl" products=$products}
			
			<div class="pagination">
                    {include file="./pagination.tpl" paginationId='bottom'}
			</div>
		{/if}
		
		    
		
		
		{if $category->description}
 <div class="descriptionCategory">
   	{$category->description}
  </div>
  {/if}
  
	{elseif $category->id}
		<p class="alert alert-warning">{l s='This category is currently unavailable.'}</p>
	{/if}
{/if}
