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

{if isset($no_follow) AND $no_follow}
	{assign var='no_follow_text' value='rel="nofollow"'}
{else}
	{assign var='no_follow_text' value=''}
{/if}

{if isset($p) AND $p}
	{if isset($smarty.get.id_category) && $smarty.get.id_category && isset($category)}
		{if !isset($current_url)}
			{assign var='requestPage' value=$link->getPaginationLink('category', $category, false, false, true, false)}
		{else}
			{assign var='requestPage' value=$current_url}
		{/if}
		{assign var='requestNb' value=$link->getPaginationLink('category', $category, true, false, false, true)}
	{elseif isset($smarty.get.id_manufacturer) && $smarty.get.id_manufacturer && isset($manufacturer)}
		{assign var='requestPage' value=$link->getPaginationLink('manufacturer', $manufacturer, false, false, true, false)}
		{assign var='requestNb' value=$link->getPaginationLink('manufacturer', $manufacturer, true, false, false, true)}
	{elseif isset($smarty.get.id_supplier) && $smarty.get.id_supplier && isset($supplier)}
		{assign var='requestPage' value=$link->getPaginationLink('supplier', $supplier, false, false, true, false)}
		{assign var='requestNb' value=$link->getPaginationLink('supplier', $supplier, true, false, false, true)}
	{else}
		{if !isset($current_url)}
			{assign var='requestPage' value=$link->getPaginationLink(false, false, false, false, true, false)}
		{else}
			{assign var='requestPage' value=$current_url}
		{/if}
		{assign var='requestNb' value=$link->getPaginationLink(false, false, true, false, false, true)}
	{/if}
	<!-- Pagination -->
	<div id="pagination{if isset($paginationId)}_{$paginationId}{/if}" class="pagination clearfix">
	    
		{if $start!=$stop}
			<ul class="pagination">
				
				{if $start==3}
					<li>
						<a {$no_follow_text}  href="{$link->goPage($requestPage, 1)}">
							<span>1</span>
						</a>
					</li>
					<li>
						<a {$no_follow_text}  href="{$link->goPage($requestPage, 2)}">
							<span>2</span>
						</a>
					</li>
				{/if}
				{if $start==2}
					<li>
						<a {$no_follow_text}  href="{$link->goPage($requestPage, 1)}">
							<span>1</span>
						</a>
					</li>
				{/if}
				{if $start>3}
					<li>
						<a {$no_follow_text}  href="{$link->goPage($requestPage, 1)}">
							<span>1</span>
						</a>
					</li>
					<li class="truncate">
						<span>
							<span>...</span>
						</span>
					</li>
				{/if}
				{section name=pagination start=$start loop=$stop+1 step=1}
					{if $p == $smarty.section.pagination.index}
						<li class="active current">
							<span>
								<span>{$p|escape:'html':'UTF-8'}</span>
							</span>
						</li>
					{else}
						<li>
							<a {$no_follow_text} href="{$link->goPage($requestPage, $smarty.section.pagination.index)}">
								<span>{$smarty.section.pagination.index|escape:'html':'UTF-8'}</span>
							</a>
						</li>
					{/if}
				{/section}
				{if $pages_nb>$stop+2}
					<li class="truncate">
						<span>
							<span>...</span>
						</span>
					</li>
					<li>
						<a href="{$link->goPage($requestPage, $pages_nb)}">
							<span>{$pages_nb|intval}</span>
						</a>
					</li>
				{/if}
				{if $pages_nb==$stop+1}
					<li>
						<a href="{$link->goPage($requestPage, $pages_nb)}">
							<span>{$pages_nb|intval}</span>
						</a>
					</li>
				{/if}
				{if $pages_nb==$stop+2}
					<li>
						<a href="{$link->goPage($requestPage, $pages_nb-1)}">
							<span>{$pages_nb-1|intval}</span>
						</a>
					</li>
					<li>
						<a href="{$link->goPage($requestPage, $pages_nb)}">
							<span>{$pages_nb|intval}</span>
						</a>
					</li>
				{/if}
				
			</ul>
		{/if}
	</div>
    
	<!-- /Pagination -->
{/if}
