{*
* 2007-2015 PrestaShop _tat_ подробная история заказов. Убрала дубляж
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
{if isset($order)}


{if count($order_history)}
<h1 class="page-heading">{l s='Follow your order\'s status step-by-step'}</h1>

{if $return_allowed}
	<div id="returnOrderMessage">
		<h3 class="page-heading bottom-indent">{l s='Merchandise return'}</h3>
		<p>{l s='If you wish to return one or more products, please mark the corresponding boxes and provide an explanation for the return. When complete, click the button below.'}</p>
		<p class="form-group">
			<textarea class="form-control" cols="67" rows="3" name="returnText"></textarea>
		</p>
		<p class="form-group">
			<button type="submit" name="submitReturnMerchandise" class="btn btn-default button button-small"><span>{l s='Make an RMA slip'}<i class="icon-chevron-right right"></i></span></button>
			<input type="hidden" class="hidden" value="{$order->id|intval}" name="id_order" />
		</p>
	</div>
{/if}
</form>
{if $order->getShipping()|count > 0}
	<table class="table table-bordered footab">
		<thead>
			<tr>
				<th class="first_item">{l s='Date'}</th>
				<th class="item" data-sort-ignore="true">{l s='Carrier'}</th>
				<th data-hide="phone" class="item">{l s='Weight'}</th>
				<th data-hide="phone" class="item">{l s='Shipping cost'}</th>
				<th data-hide="phone" class="last_item" data-sort-ignore="true">{l s='Tracking number'}</th>
			</tr>
		</thead>
		<tbody>
			{foreach from=$order->getShipping() item=line}
			<tr class="item">
				<td data-value="{$line.date_add|regex_replace:"/[\-\:\ ]/":""}">{dateFormat date=$line.date_add full=0}</td>
				<td>{$line.carrier_name}</td>
				<td data-value="{if $line.weight > 0}{$line.weight|string_format:"%.3f"}{else}0{/if}">{if $line.weight > 0}{$line.weight|string_format:"%.3f"} {Configuration::get('PS_WEIGHT_UNIT')}{else}-{/if}</td>
				<td data-value="{if $order->getTaxCalculationMethod() == $smarty.const.PS_TAX_INC}{$line.shipping_cost_tax_incl}{else}{$line.shipping_cost_tax_excl}{/if}">{if $order->getTaxCalculationMethod() == $smarty.const.PS_TAX_INC}{displayPrice price=$line.shipping_cost_tax_incl currency=$currency->id}{else}{displayPrice price=$line.shipping_cost_tax_excl currency=$currency->id}{/if}</td>
				<td>
					<span class="shipping_number_show">{if $line.tracking_number}{if $line.url && $line.tracking_number}<a href="{$line.url|replace:'@':$line.tracking_number}">{$line.tracking_number}</a>{else}{$line.tracking_number}{/if}{else}-{/if}</span>
				</td>
			</tr>
			{/foreach}
		</tbody>
	</table>
{/if}
{if !$is_guest}
	{if count($messages)}
	<h3 class="page-heading">{l s='Messages'}</h3>
	 <div class="table_block">
		<table class="detail_step_by_step table table-bordered">
			<thead>
				<tr>
					<th class="first_item" style="width:150px;">{l s='From'}</th>
					<th class="last_item">{l s='Message'}</th>
				</tr>
			</thead>
			<tbody>
			{foreach from=$messages item=message name="messageList"}
				<tr class="{if $smarty.foreach.messageList.first}first_item{elseif $smarty.foreach.messageList.last}last_item{/if} {if $smarty.foreach.messageList.index % 2}alternate_item{else}item{/if}">
					<td>
						<strong class="dark">
							{if isset($message.elastname) && $message.elastname}
								{$message.efirstname|escape:'html':'UTF-8'} {$message.elastname|escape:'html':'UTF-8'}
							{elseif $message.clastname}
								{$message.cfirstname|escape:'html':'UTF-8'} {$message.clastname|escape:'html':'UTF-8'}
							{else}
								{$shop_name|escape:'html':'UTF-8'}
							{/if}
						</strong>
						<br />
						{dateFormat date=$message.date_add full=1}
					</td>
					<td>{$message.message|escape:'html':'UTF-8'|nl2br}</td>
				</tr>
			{/foreach}
			</tbody>
		</table>
	</div>
	{/if}
	{if isset($errors) && $errors}
		<div class="alert alert-danger">
			<p>{if $errors|@count > 1}{l s='There are %d errors' sprintf=$errors|@count}{else}{l s='There is %d error' sprintf=$errors|@count}{/if}</p>
			<ol>
			{foreach from=$errors key=k item=error}
				<li>{$error}</li>
			{/foreach}
			</ol>
		</div>
	{/if}
	{if isset($message_confirmation) && $message_confirmation}
	<p class="alert alert-success">
		{l s='Message successfully sent'}
	</p>
	{/if}
	<form action="{$link->getPageLink('order-detail', true)|escape:'html':'UTF-8'}" method="post" class="std" id="sendOrderMessage">
		<h3 class="page-heading bottom-indent">{l s='Add a message'}</h3>
		<p>{l s='If you would like to add a comment about your order, please write it in the field below.'}</p>
		<p class="form-group">
		<label for="id_product">{l s='Product'}</label>
			<select name="id_product" class="form-control">
				<option value="0">{l s='-- Choose --'}</option>
				{foreach from=$products item=product name=products}
					<option value="{$product.product_id}">{$product.product_name}</option>
				{/foreach}
			</select>
		</p>
		<p class="form-group">
			<textarea class="form-control" cols="67" rows="3" name="msgText"></textarea>
		</p>
		<div class="submit">
			<input type="hidden" name="id_order" value="{$order->id|intval}" />
			<input type="submit" class="unvisible" name="submitMessage" value="{l s='Send'}"/>
			<button type="submit" name="submitMessage" class="button btn btn-default button-medium"><span>{l s='Send'}<i class="icon-chevron-right right"></i></span></button>
		</div>
	</form>
{else}
<p class="alert alert-info"><i class="icon-info-sign"></i>{l s='You cannot return merchandise with a guest account'}</p>
{/if}
{/if}
