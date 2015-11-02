{*
* 2007-2015 PrestaShop _tat_ в частности Заменила form-group на formAdress. Форма, которая выходит на первом шаге регистрации
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
{capture name=path}
	{if !isset($email_create)}{l s='Authentication'}{else}
		<a href="{$link->getPageLink('authentication', true)|escape:'html':'UTF-8'}" rel="nofollow" title="{l s='Authentication'}">{l s='Authentication'}</a>
		<span class="navigation-pipe">{$navigationPipe}</span>{l s='Create your account'}
	{/if}
{/capture}
<h1 class="page-heading">{if !isset($email_create)}{l s='Authentication'}{else}{l s='Create an account'}{/if}</h1>
{if isset($back) && preg_match("/^http/", $back)}{assign var='current_step' value='login'}{include file="$tpl_dir./order-steps.tpl"}{/if}
{include file="$tpl_dir./errors.tpl"}
{assign var='stateExist' value=false}
{assign var="postCodeExist" value=false}
{assign var="dniExist" value=false}
{if !isset($email_create)}
	<!--{if isset($authentification_error)}
	<div class="alert alert-danger">
		{if {$authentification_error|@count} == 1}
			<p>{l s='There\'s at least one error'} :</p>
			{else}
			<p>{l s='There are %s errors' sprintf=[$account_error|@count]} :</p>
		{/if}
		<ol>
			{foreach from=$authentification_error item=v}
				<li>{$v}</li>
			{/foreach}
		</ol>
	</div>
	{/if}-->
	<div class="row_create-account1"><!-- Создать уч. запись или уже зарегистрированы?-->
		<div class="col-xs-12 col-sm-6 createAccount1">
			<form action="{$link->getPageLink('authentication', true)|escape:'html':'UTF-8'}" method="post" id="create-account_form" class="box">
				<h3 class="page-subheading">{l s='Create an account'}</h3>
				<div class="form_content clearfix">
					<p>{l s='Please enter your email address to create an account.'}</p>
					<div class="alert alert-danger" id="create_account_error" style="display:none"></div>
					<div class="formAdress">
						<label for="email_create">{l s='Email address'}</label>
						<input type="text" class="is_required validate account_input form-control" data-validate="isEmail" id="email_create" name="email_create" value="{if isset($smarty.post.email_create)}{$smarty.post.email_create|stripslashes}{/if}" />						
					</div>
					<div class="clearBotch"></div>
					<div class="submit">
						{if isset($back)}<input type="hidden" class="hidden" name="back" value="{$back|escape:'html':'UTF-8'}" />{/if}
						<button class="btn btn-default button button-medium exclusive" type="submit" id="SubmitCreate" name="SubmitCreate">
							<span>
								<i class="icon-user left"></i>
								{l s='Create an account'}
							</span>
						</button>
						<input type="hidden" class="hidden" name="SubmitCreate" value="{l s='Create an account'}" />
					</div>					
				</div>
			</form>
		</div>
		<div class="col-xs-12 col-sm-6 passwordAccount">
			<form action="{$link->getPageLink('authentication', true)|escape:'html':'UTF-8'}" method="post" id="login_form" class="box">
				<h3 class="page-subheading">{l s='Already registered?'}</h3>
				<div class="form_content clearfix">
					<div class="formAdress">
						<label for="email">{l s='Email address'}</label>
						<input class="is_required validate account_input form-control" data-validate="isEmail" type="text" id="email" name="email" value="{if isset($smarty.post.email)}{$smarty.post.email|stripslashes}{/if}" />
						<div class="clearBotch"></div>
					</div>
					<div class="clearBotch"></div>
					<div class="formAdress">
						{*<label for="passwd">{l s='Password'}</label>*}
						<span><input class="is_required validate account_input form-control" type="password" data-validate="isPasswd" id="passwd" name="passwd" value="{if isset($smarty.post.passwd)}{$smarty.post.passwd|stripslashes}{/if}" value="12345678" /></span>
						<div class="clearBotch"></div>
					</div>
					<div class="clearBotch"></div>
					<p class="lost_password formAdress"><a href="{$link->getPageLink('password')|escape:'html':'UTF-8'}" title="{l s='Recover your forgotten password'}" rel="nofollow">{l s='Forgot your password?'}</a></p>
					<div class="clearBotch"></div>
					<p class="submit">
						{if isset($back)}<input type="hidden" class="hidden" name="back" value="{$back|escape:'html':'UTF-8'}" />{/if}
						<button type="submit" id="SubmitLogin" name="SubmitLogin" class="button btn btn-default button-medium">
							<span>
								<i class="icon-lock left"></i>
								{l s='Sign in'}
							</span>
						</button>
					</p>
				</div>
			</form>
		</div>
	</div><!-- Конец Создать уч. запись или уже зарегистрированы?-->
	{if isset($inOrderProcess) && $inOrderProcess && $PS_GUEST_CHECKOUT_ENABLED}
		<form action="{$link->getPageLink('authentication', true, NULL, "back=$back")|escape:'html':'UTF-8'}" method="post" id="new_account_form" class="std clearfix"><!-- Создание аккаунта быстро -->
			<div class="box">
				<div id="opc_account_form" style="display: block; ">
					<h3 class="page-heading bottom-indent">{l s='Instant checkout'}</h3>
					<!-- Account -->
					<div class="required formAdress">
						<label for="guest_email">{l s='Email address'} <sup>*</sup></label>
						<input type="text" class="is_required validate form-control" data-validate="isEmail" id="guest_email" name="guest_email" value="{if isset($smarty.post.guest_email)}{$smarty.post.guest_email}{/if}" />
					</div>
					<div class="clearBotch"></div>
					<div class="cleafix gender-line" hidden>
						<label>{l s='Title'}</label>
						{foreach from=$genders key=k item=gender}
							<div class="radio-inline">
								<label for="id_gender{$gender->id}" class="top">
									<input type="radio" name="id_gender" id="id_gender{$gender->id}" value="{$gender->id}"{if isset($smarty.post.id_gender) && $smarty.post.id_gender == $gender->id} checked="checked"{/if} />
									{$gender->name}
								</label>
							</div>
						{/foreach}
					</div>
					<div class="required formAdress">
						<label for="firstname">{l s='First name'} <sup>*</sup></label>
						<input type="text" class="is_required validate form-control" data-validate="isName" id="firstname" name="firstname" value="{if isset($smarty.post.firstname)}{$smarty.post.firstname}{/if}" />
					</div>
					<div class="clearBotch"></div>
					<div class="required formAdress">
						<label for="lastname">{l s='Last name'} <sup>*</sup></label>
						<input type="text" class="is_required validate form-control" data-validate="isName" id="lastname" name="lastname" value="{if isset($smarty.post.lastname)}{$smarty.post.lastname}{/if}" />
					</div>
					<div class="clearBotch"></div>
					<div class="formAdress date-select">					
						<div class="row">
							<div class="col-xs-4">
								<select id="days" name="days" class="form-control">
									<option value="">-</option>
									{foreach from=$days item=day}
										<option value="{$day}" {if ($sl_day == $day)} selected="selected"{/if}>{$day}&nbsp;&nbsp;</option>
									{/foreach}
								</select>
								{*
									{l s='January'}
									{l s='February'}
									{l s='March'}
									{l s='April'}
									{l s='May'}
									{l s='June'}
									{l s='July'}
									{l s='August'}
									{l s='September'}
									{l s='October'}
									{l s='November'}
									{l s='December'}
								*}
							</div>
							<div class="col-xs-4">
								<select id="months" name="months" class="form-control">
									<option value="">-</option>
									{foreach from=$months key=k item=month}
										<option value="{$k}" {if ($sl_month == $k)} selected="selected"{/if}>{l s=$month}&nbsp;</option>
									{/foreach}
								</select>
							</div>
							<div class="col-xs-4">
								<select id="years" name="years" class="form-control">
									<option value="">-</option>
									{foreach from=$years item=year}
										<option value="{$year}" {if ($sl_year == $year)} selected="selected"{/if}>{$year}&nbsp;&nbsp;</option>
									{/foreach}
								</select>
							</div>
						</div>
					</div>
					<div class="clearBotch"></div>
					{if isset($newsletter) && $newsletter}
						<div class="checkbox" hidden>
							<label for="newsletter">
							<input type="checkbox" name="newsletter" id="newsletter" value="1" {if isset($smarty.post.newsletter) && $smarty.post.newsletter == '1'}checked="checked"{/if} />
							{l s='Sign up for our newsletter!'}</label>
						</div>
						<div class="checkbox" hidden>
							<label for="optin">
							<input type="checkbox" name="optin" id="optin" value="1" {if isset($smarty.post.optin) && $smarty.post.optin == '1'}checked="checked"{/if} />
							{l s='Receive special offers from our partners!'}</label>
						</div>
					{/if}
					<!-- Адрес доставки -->
					{foreach from=$dlv_all_fields item=field_name}
						{if $field_name eq "company"}
							<div class="formAdress" hidden>
								<label for="company">{l s='Company'}{if in_array($field_name, $required_fields)} <sup>*</sup>{/if}</label>
								<input type="text" class="form-control" id="company" name="company" value="{if isset($smarty.post.company)}{$smarty.post.company}{/if}" />
							</div>
							<div class="clearBotch"></div>					
						{elseif $field_name eq "vat_number"}
							<div id="vat_number" style="display:none;">
								<div class="formAdress">
									<label for="vat-number">{l s='VAT number'}{if in_array($field_name, $required_fields)} <sup>*</sup>{/if}</label>
									<input id="vat-number" type="text" class="form-control" name="vat_number" value="{if isset($smarty.post.vat_number)}{$smarty.post.vat_number}{/if}" />
								</div>
								<div class="clearBotch"></div>
							</div>
							{elseif $field_name eq "dni"}
							{assign var='dniExist' value=true}
							<div class="required dni formAdress">
								<label for="dni">{l s='Identification number'} <sup>*</sup></label>
								<input type="text" name="dni" id="dni" value="{if isset($smarty.post.dni)}{$smarty.post.dni}{/if}" />
								<span class="form_info">{l s='DNI / NIF / NIE'}</span>
							</div>
							<div class="clearBotch"></div>
						{elseif $field_name eq "address1"}<!-- поле Адрес доставки -->
							<div class="required formAdress">
								<label for="address1">{l s='Address'} <sup>*</sup></label>
								<input type="text" class="form-control" name="address1" id="address1" value="{if isset($smarty.post.address1)}{$smarty.post.address1}{/if}" />
							</div>
							<div class="clearBotch"></div>
						{elseif $field_name eq "address2"}
							<div class="formAdress is_customer_param" hidden>
								<label for="address2">{l s='Address (Line 2)'}{if in_array($field_name, $required_fields)} <sup>*</sup>{/if}</label>
								<input type="text" class="form-control" name="address2" id="address2" value="{if isset($smarty.post.address2)}{$smarty.post.address2}{/if}" />
							</div>
							<div class="clearBotch"></div>
						{elseif $field_name eq "postcode"}
							{assign var='postCodeExist' value=true}
							<div class="required postcode formAdress">
								<label for="postcode">{l s='Zip/Postal Code'} <sup>*</sup></label>
								<input type="text" class="form-control" name="postcode" id="postcode" value="{if isset($smarty.post.postcode)}{$smarty.post.postcode}{/if}" onkeyup="$('#postcode').val($('#postcode').val().toUpperCase());" />
							</div>
							<div class="clearBotch"></div>
						{elseif $field_name eq "city"}
							<div class="required formAdress">
								<label for="city">{l s='City'} <sup>*</sup></label>
								<input type="text" class="form-control" name="city" id="city" value="{if isset($smarty.post.city)}{$smarty.post.city}{/if}" />
							</div>
							<div class="clearBotch"></div>
							<!-- if customer hasn't update his layout address, country has to be verified but it's deprecated -->
						{elseif $field_name eq "Country:name" || $field_name eq "country"}
							<div class="required select formAdress">
								<label for="id_country">{l s='Country'} <sup>*</sup></label>
								<select name="id_country" id="id_country" class="form-control">
									{foreach from=$countries item=v}
										<option value="{$v.id_country}"{if (isset($smarty.post.id_country) AND  $smarty.post.id_country == $v.id_country) OR (!isset($smarty.post.id_country) && $sl_country == $v.id_country)} selected="selected"{/if}>{$v.name}</option>
									{/foreach}
								</select>
							</div>
							<div class="clearBotch"></div>
						{elseif $field_name eq "State:name"}
							{assign var='stateExist' value=true}
							<div class="required id_state select formAdress">
								<label for="id_state">{l s='State'} <sup>*</sup></label>
								<select name="id_state" id="id_state" class="form-control">
									<option value="">-</option>
								</select>
							</div>
							<div class="clearBotch"></div>
						{/if}
					{/foreach}
					{if $stateExist eq false}
						<div class="required id_state select unvisible formAdress">
							<label for="id_state">{l s='State'} <sup>*</sup></label>
							<select name="id_state" id="id_state" class="form-control">
								<option value="">-</option>
							</select>
						</div>
						<div class="clearBotch"></div>
					{/if}
					{if $postCodeExist eq false}
						<div class="required postcode unvisible formAdress">
							<label for="postcode">{l s='Zip/Postal Code'} <sup>*</sup></label>
							<input type="text" class="form-control" name="postcode" id="postcode" value="{if isset($smarty.post.postcode)}{$smarty.post.postcode}{/if}" onkeyup="$('#postcode').val($('#postcode').val().toUpperCase());" />
						</div>
						<div class="clearBotch"></div>
					{/if}
					{if $dniExist eq false}
						<div class="required formAdress dni">
							<label for="dni">{l s='Identification number'} <sup>*</sup></label>
							<input type="text" class="text form-control" name="dni" id="dni" value="{if isset($smarty.post.dni) && $smarty.post.dni}{$smarty.post.dni}{/if}" />
							<span class="form_info">{l s='DNI / NIF / NIE'}</span>
						</div>
						<div class="clearBotch"></div>
					{/if}
					<div class="{if isset($one_phone_at_least) && $one_phone_at_least}required {/if}formAdress">
						<label for="phone_mobile">{l s='Mobile phone'}{if isset($one_phone_at_least) && $one_phone_at_least} <sup>*</sup>{/if}</label>
						<input type="text" class="form-control" name="phone_mobile" id="phone_mobile" value="{if isset($smarty.post.phone_mobile)}{$smarty.post.phone_mobile}{/if}" />
					</div>
					<div class="clearBotch"></div>
					<input type="hidden" name="alias" id="alias" value="{l s='My address'}" />
					<input type="hidden" name="is_new_customer" id="is_new_customer" value="0" />
					<div class="checkbox" hidden>
	                	<label for="invoice_address">
						<input type="checkbox" name="invoice_address" id="invoice_address"{if (isset($smarty.post.invoice_address) && $smarty.post.invoice_address) || (isset($smarty.post.invoice_address) && $smarty.post.invoice_address)} checked="checked"{/if} autocomplete="off"/>
						{l s='Please use another address for invoice'}</label>
					</div>
					<div id="opc_invoice_address"  class="unvisible">
						{assign var=stateExist value=false}
						{assign var=postCodeExist value=false}
						{assign var=dniExist value=false}
						<!-- Почтовый или юридический адрес -->
						{foreach from=$inv_all_fields item=field_name}
						{if $field_name eq "company"}
						<div class="formAdress" hidden><!-- Организация достав -->
							<label for="company_invoice">{l s='Company'}{if in_array($field_name, $required_fields)} <sup>*</sup>{/if}</label>
							<input type="text" class="text form-control" id="company_invoice" name="company_invoice" value="{if isset($smarty.post.company_invoice) && $smarty.post.company_invoice}{$smarty.post.company_invoice}{/if}" />
						</div>
						<div class="clearBotch"></div>
						{elseif $field_name eq "vat_number"}
						<div id="vat_number_block_invoice" style="display:none;">
							<div class="formAdress">
								<label for="vat_number_invoice">{l s='VAT number'}{if in_array($field_name, $required_fields)} <sup>*</sup>{/if}</label>
								<input type="text" class="form-control" id="vat_number_invoice" name="vat_number_invoice" value="{if isset($smarty.post.vat_number_invoice) && $smarty.post.vat_number_invoice}{$smarty.post.vat_number_invoice}{/if}" />
							</div>
							<div class="clearBotch"></div>
						</div>
						{elseif $field_name eq "dni"}
						{assign var=dniExist value=true}
						<div class="required formAdress dni_invoice">
							<label for="dni">{l s='Identification number'} <sup>*</sup></label>
							<input type="text" class="text form-control" name="dni_invoice" id="dni_invoice" value="{if isset($smarty.post.dni_invoice) && $smarty.post.dni_invoice}{$smarty.post.dni_invoice}{/if}" />
							<span class="form_info">{l s='DNI / NIF / NIE'}</span>
						</div>
						<div class="clearBotch"></div>
						{elseif $field_name eq "firstname"}
						<div class="required formAdress">
							<label for="firstname_invoice">{l s='First name'} <sup>*</sup></label>
							<input type="text" class="form-control" id="firstname_invoice" name="firstname_invoice" value="{if isset($smarty.post.firstname_invoice) && $smarty.post.firstname_invoice}{$smarty.post.firstname_invoice}{/if}" />
						</div>
						<div class="clearBotch"></div>
						{elseif $field_name eq "lastname"}
						<div class="required formAdress">
							<label for="lastname_invoice">{l s='Last name'} <sup>*</sup></label>
							<input type="text" class="form-control" id="lastname_invoice" name="lastname_invoice" value="{if isset($smarty.post.lastname_invoice) && $smarty.post.lastname_invoice}{$smarty.post.lastname_invoice}{/if}" />
						</div>
						<div class="clearBotch"></div>
						{elseif $field_name eq "address1"}
						<div class="required formAdress">
							<label for="address1_invoice">{l s='Address'} <sup>*</sup></label>
							<input type="text" class="form-control" name="address1_invoice" id="address1_invoice" value="{if isset($smarty.post.address1_invoice) && $smarty.post.address1_invoice}{$smarty.post.address1_invoice}{/if}" />
						</div>
						<div class="clearBotch"></div>
						{elseif $field_name eq "address2"}
						<div class="formAdress is_customer_param" hidden>
							<label for="address2_invoice">{l s='Address (Line 2)'}{if in_array($field_name, $required_fields)} <sup>*</sup>{/if}</label>
							<input type="text" class="form-control" name="address2_invoice" id="address2_invoice" value="{if isset($smarty.post.address2_invoice) && $smarty.post.address2_invoice}{$smarty.post.address2_invoice}{/if}" />
						</div>
						<div class="clearBotch"></div>
						{elseif $field_name eq "postcode"}
						{$postCodeExist = true}
						<div class="required postcode_invoice formAdress">
							<label for="postcode_invoice">{l s='Zip/Postal Code'} <sup>*</sup></label>
							<input type="text" class="form-control" name="postcode_invoice" id="postcode_invoice" value="{if isset($smarty.post.postcode_invoice) && $smarty.post.postcode_invoice}{$smarty.post.postcode_invoice}{/if}" onkeyup="$('#postcode_invoice').val($('#postcode_invoice').val().toUpperCase());" />
						</div>
						<div class="clearBotch"></div>
						{elseif $field_name eq "city"}
						<div class="required formAdress">
							<label for="city_invoice">{l s='City'} <sup>*</sup></label>
							<input type="text" class="form-control" name="city_invoice" id="city_invoice" value="{if isset($smarty.post.city_invoice) && $smarty.post.city_invoice}{$smarty.post.city_invoice}{/if}" />
						</div>
						<div class="clearBotch"></div>
						{elseif $field_name eq "country" || $field_name eq "Country:name"}
						<div class="required formAdress">
							<label for="id_country_invoice">{l s='Country'} <sup>*</sup></label>
							<select name="id_country_invoice" id="id_country_invoice" class="form-control">
								<option value="">-</option>
								{foreach from=$countries item=v}
								<option value="{$v.id_country}"{if (isset($smarty.post.id_country_invoice) && $smarty.post.id_country_invoice == $v.id_country) OR (!isset($smarty.post.id_country_invoice) && $sl_country == $v.id_country)} selected="selected"{/if}>{$v.name|escape:'html':'UTF-8'}</option>
								{/foreach}
							</select>
						</div>
						<div class="clearBotch"></div>
						{elseif $field_name eq "state" || $field_name eq 'State:name'}
						{$stateExist = true}
						<div class="required id_state_invoice formAdress" style="display:none;">
							<label for="id_state_invoice">{l s='State'} <sup>*</sup></label>
							<select name="id_state_invoice" id="id_state_invoice" class="form-control">
								<option value="">-</option>
							</select>
						</div>
						<div class="clearBotch"></div>
						{/if}
						{/foreach}
						{if !$postCodeExist}
						<div class="required postcode_invoice formAdress unvisible">
							<label for="postcode_invoice">{l s='Zip/Postal Code'} <sup>*</sup></label>
							<input type="text" class="form-control" name="postcode_invoice" id="postcode_invoice" value="{if isset($smarty.post.postcode_invoice) && $smarty.post.postcode_invoice}{$smarty.post.postcode_invoice}{/if}" onkeyup="$('#postcode').val($('#postcode').val().toUpperCase());" />
						</div>
						<div class="clearBotch"></div>
						{/if}
						{if !$stateExist}
						<div class="required id_state_invoice formAdress unvisible">
							<label for="id_state_invoice">{l s='State'} <sup>*</sup></label>
							<select name="id_state_invoice" id="id_state_invoice" class="form-control">
								<option value="">-</option>
							</select>
						</div>
						<div class="clearBotch"></div>
						{/if}
						{if $dniExist eq false}
							<div class="required formAdress dni_invoice">
								<label for="dni">{l s='Identification number'} <sup>*</sup></label>
								<input type="text" class="text form-control" name="dni_invoice" id="dni_invoice" value="{if isset($smarty.post.dni_invoice) && $smarty.post.dni_invoice}{$smarty.post.dni_invoice}{/if}" />
								<span class="form_info">{l s='DNI / NIF / NIE'}</span>
							</div>
							<div class="clearBotch"></div>
						{/if}
						<div class="formAdress is_customer_param">
							<label for="other_invoice">{l s='Additional information'}</label>
							<textarea class="form-control" name="other_invoice" id="other_invoice" cols="26" rows="3"></textarea>
						</div>
						<div class="clearBotch"></div>
						{if isset($one_phone_at_least) && $one_phone_at_least}
							<p class="inline-infos required is_customer_param">{l s='You must register at least one phone number.'}</p>
						{/if}
						<div class="formAdress is_customer_param">
							<label for="phone_invoice">{l s='Home phone'}</label>
							<input type="text" class="form-control" name="phone_invoice" id="phone_invoice" value="{if isset($smarty.post.phone_invoice) && $smarty.post.phone_invoice}{$smarty.post.phone_invoice}{/if}" />
						</div>
						<div class="clearBotch"></div>
						<div class="{if isset($one_phone_at_least) && $one_phone_at_least}required {/if}formAdress">
							<label for="phone_mobile_invoice">{l s='Mobile phone'}{if isset($one_phone_at_least) && $one_phone_at_least} <sup>*</sup>{/if}</label>
							<input type="text" class="form-control" name="phone_mobile_invoice" id="phone_mobile_invoice" value="{if isset($smarty.post.phone_mobile_invoice) && $smarty.post.phone_mobile_invoice}{$smarty.post.phone_mobile_invoice}{/if}" />
						</div>
						<div class="clearBotch"></div>
						<input type="hidden" name="alias_invoice" id="alias_invoice" value="{l s='My Invoice address'}" />
					</div>
					<!-- END Account -->
				</div>
				{$HOOK_CREATE_ACCOUNT_FORM}
			</div>
			<p class="cart_navigation required submit clearfix">
				<span><sup>*</sup>{l s='Required field'}</span>
				<input type="hidden" name="display_guest_checkout" value="1" />
				<button type="submit" class="button btn btn-default button-medium" name="submitGuestAccount" id="submitGuestAccount">
					<span>
						{l s='Proceed to checkout'}
						<i class="icon-chevron-right right"></i>
					</span>
				</button>
			</p>
		</form><!--Конец "создания аккаунта?"-->
	{/if}
{else}
	<!--{if isset($account_error)}
	<div class="error">
		{if {$account_error|@count} == 1}
			<p>{l s='There\'s at least one error'} :</p>
			{else}
			<p>{l s='There are %s errors' sprintf=[$account_error|@count]} :</p>
		{/if}
		<ol>
			{foreach from=$account_error item=v}
				<li>{$v}</li>
			{/foreach}
		</ol>
	</div>
	{/if}-->
	<form action="{$link->getPageLink('authentication', true)|escape:'html':'UTF-8'}" method="post" id="account-creation_form" class="std box"><!-- Создание аккаунта при регистрации -->
		{$HOOK_CREATE_ACCOUNT_TOP}
		<div class="account_creation">			
			<div class="clearfix">
				
				<br />
				{foreach from=$genders key=k item=gender}
					<div class="radio-inline" hidden>
						<label for="id_gender{$gender->id}" class="top">
							<input type="radio" name="id_gender" id="id_gender{$gender->id}" value="{$gender->id}" {if isset($smarty.post.id_gender) && $smarty.post.id_gender == $gender->id}checked="checked"{/if} />
						{$gender->name}
						</label>
					</div>
				{/foreach}
			</div>
			<div class="required formAdress">
				<label for="customer_firstname">{l s='First name'} <sup>*</sup></label>
				<input onkeyup="$('#firstname').val(this.value);" type="text" class="is_required validate form-control" data-validate="isName" id="customer_firstname" name="customer_firstname" value="{if isset($smarty.post.customer_firstname)}{$smarty.post.customer_firstname}{/if}" />
			</div>
			<div class="clearBotch"></div>
			<div class="required formAdress">
				<label for="customer_lastname">{l s='Last name'} <sup>*</sup></label>
				<input onkeyup="$('#lastname').val(this.value);" type="text" class="is_required validate form-control" data-validate="isName" id="customer_lastname" name="customer_lastname" value="{if isset($smarty.post.customer_lastname)}{$smarty.post.customer_lastname}{/if}" />
			</div>
			<div class="clearBotch"></div>
			<p class="formAdress">
					<label for="phone">{l s='Home phone'}<sup>*</sup></label>
					<input type="text" class="form-control" name="phone" id="phone" value="{if isset($smarty.post.phone)}{$smarty.post.phone}{/if}" />
				</p>
				<div class="clearBotch"></div>
			
			<div class="required formAdress">
				<label for="email">{l s='Email'} <sup>*</sup></label>
				<input type="text" class="is_required validate form-control" data-validate="isEmail" id="email" name="email" value="{if isset($smarty.post.email)}{$smarty.post.email}{/if}" />
			</div>
			<div class="clearBotch"></div>
			<div class="required password formAdress">
				{*<label for="passwd">{l s='Password'} <sup>*</sup></label>*}
				<input type="password" class="is_required validate form-control" data-validate="isPasswd" name="passwd" id="passwd" value="12345678" />
				{*<span class="form_info">{l s='(Five characters minimum)'}</span>*}
			</div>
			<div class="clearBotch"></div>
			<div class="formAdress" hidden>
				<label>{l s='Date of Birth'}</label>
				<div class="row">
					<div class="col-xs-4">
						<select id="days" name="days" class="form-control">
							<option value="">-</option>
							{foreach from=$days item=day}
								<option value="{$day}" {if ($sl_day == $day)} selected="selected"{/if}>{$day}&nbsp;&nbsp;</option>
							{/foreach}
						</select>
						{*
							{l s='January'}
							{l s='February'}
							{l s='March'}
							{l s='April'}
							{l s='May'}
							{l s='June'}
							{l s='July'}
							{l s='August'}
							{l s='September'}
							{l s='October'}
							{l s='November'}
							{l s='December'}
						*}
					</div>
					<div class="col-xs-4">
						<select id="months" name="months" class="form-control">
							<option value="">-</option>
							{foreach from=$months key=k item=month}
								<option value="{$k}" {if ($sl_month == $k)} selected="selected"{/if}>{l s=$month}&nbsp;</option>
							{/foreach}
						</select>
					</div>
					<div class="col-xs-4">
						<select id="years" name="years" class="form-control">
							<option value="">-</option>
							{foreach from=$years item=year}
								<option value="{$year}" {if ($sl_year == $year)} selected="selected"{/if}>{$year}&nbsp;&nbsp;</option>
							{/foreach}
						</select>
					</div>
				</div>
			</div>
			<div class="clearBotch"></div>
			{if $newsletter}
				<div class="checkbox" hidden>
					<input type="checkbox" name="newsletter" id="newsletter" value="1" {if isset($smarty.post.newsletter) AND $smarty.post.newsletter == 1} checked="checked"{/if} />
					<label for="newsletter">{l s='Sign up for our newsletter!'}</label>
					{if array_key_exists('newsletter', $field_required)}
						<sup> *</sup>
					{/if}
				</div>
				<div class="checkbox" hidden>
					<input type="checkbox" name="optin" id="optin" value="1" {if isset($smarty.post.optin) AND $smarty.post.optin == 1} checked="checked"{/if} />
					<label for="optin">{l s='Receive special offers from our partners!'}</label>
					{if array_key_exists('optin', $field_required)}
						<sup> *</sup>
					{/if}
				</div>
			{/if}
		</div>
		{if $b2b_enable}
			<div class="account_creation">
				<h3 class="page-subheading">{l s='Your company information'}</h3>
				<p class="formAdress">
					<label for="">{l s='Company'}</label>
					<input type="text" class="form-control" id="company" name="company" value="{if isset($smarty.post.company)}{$smarty.post.company}{/if}" />
				</p>
				<div class="clearBotch"></div>
				<p class="formAdress">
					<label for="siret">{l s='SIRET'}</label>
					<input type="text" class="form-control" id="siret" name="siret" value="{if isset($smarty.post.siret)}{$smarty.post.siret}{/if}" />
				</p>
				<div class="clearBotch"></div>
				<p class="formAdress">
					<label for="ape">{l s='APE'}</label>
					<input type="text" class="form-control" id="ape" name="ape" value="{if isset($smarty.post.ape)}{$smarty.post.ape}{/if}" />
				</p>
				<div class="clearBotch"></div>
				<p class="formAdress">
					<label for="website">{l s='Website'}</label>
					<input type="text" class="form-control" id="website" name="website" value="{if isset($smarty.post.website)}{$smarty.post.website}{/if}" />
				</p>
				<div class="clearBotch"></div>
			</div>
		{/if}
		{if isset($PS_REGISTRATION_PROCESS_TYPE) && $PS_REGISTRATION_PROCESS_TYPE}
			<div class="account_creation">
				
				{foreach from=$dlv_all_fields item=field_name}
					{if $field_name eq "company"}
						{if !$b2b_enable}
							<p class="formAdress">
								<label for="company">{l s='Company'}{if in_array($field_name, $required_fields)} <sup>*</sup>{/if}</label>
								<input type="text" class="form-control" id="company" name="company" value="{if isset($smarty.post.company)}{$smarty.post.company}{/if}" />
							</p>
							<div class="clearBotch"></div>
						{/if}
					{elseif $field_name eq "vat_number"}
						<div id="vat_number" style="display:none;">
							<p class="formAdress">
								<label for="vat_number">{l s='VAT number'}{if in_array($field_name, $required_fields)} <sup>*</sup>{/if}</label>
								<input type="text" class="form-control" name="vat_number" value="{if isset($smarty.post.vat_number)}{$smarty.post.vat_number}{/if}" />
							</p>
							<div class="clearBotch"></div>
						</div>
					{elseif $field_name eq "firstname"}
						<p class="required1 formAdress"><!-- поле-дубль имени -->
							
							<input type="text" class="form-control" id="firstname" name="firstname" value="{if isset($smarty.post.firstname)}{$smarty.post.firstname}{/if}" />
						</p>
						<div class="clearBotch"></div>
					{elseif $field_name eq "lastname"}
						<p class="required1 formAdress"><!-- поле-дубль фамилии -->
							
							<input type="text" class="form-control" id="lastname" name="lastname" value="{if isset($smarty.post.lastname)}{$smarty.post.lastname}{/if}" />
						</p>
						<div class="clearBotch"></div>
					{elseif $field_name eq "address1"}
						<p class="required1 formAdress">
							<label for="address1">{l s='Address'} <sup>*</sup></label>
							<input type="text" class="form-control" name="address1" id="address1" value="{if isset($smarty.post.address1)}{$smarty.post.address1}{/if}" />
							
						</p>
						<div class="clearBotch"></div>
						
						<div class="account_creation dni"><!-- Этаж -->
				<h3 class="page-subheading">{l s='Tax identification'}</h3>
				<p class="required1 formAdress">
					<label for="dni">{l s='Identification number'} <sup>*</sup></label>
					<input type="text" class="form-control" name="dni" id="dni" value="{if isset($smarty.post.dni)}{$smarty.post.dni}{/if}" />
					<span class="form_info">{l s='DNI / NIF / NIE'}</span>
				</p>
				<div class="clearBotch"></div>
			</div>
			
				<!-- Добавленный лифт -->				
				<div class="formAdress">
					<label for="lift">{l s='Лифт'} <sup>*</sup></label>
					{*<input type="text" class="text form-control" name="lift" id="lift" data-validate="{$address_validation.lift.validate}" value="{if isset($smarty.post.lift)}{$smarty.post.lift}{else}{if isset($address->lift)}{$address->lift|escape:'html':'UTF-8'}{/if}{/if}" />*}
					<select name="lift" id="lift" class="form-control">
						<option value="" selected></option>
						<option value="Грузовой">Грузовой</option>
						<option value="Пассажирский">Пассажирский</option>
						<option value="Отсутствует">Отсутствует</option>
					</select>				
				</div>
				<div class="clearBotch"></div>
				
						
						
					{elseif $field_name eq "address2"}
						<p class="formAdress is_customer_param">
							<label for="address2">{l s='Address (Line 2)'}{if in_array($field_name, $required_fields)} <sup>*</sup>{/if}</label>
							<input type="text" class="form-control" name="address2" id="address2" value="{if isset($smarty.post.address2)}{$smarty.post.address2}{/if}" />
							<span class="inline-infos">{l s='Apartment, suite, unit, building, floor, etc...'}</span>
						</p>
						<div class="clearBotch"></div>
					{elseif $field_name eq "postcode"}
						{assign var='postCodeExist' value=true}
						<p class="required postcode formAdress">
							<label for="postcode">{l s='Zip/Postal Code'} <sup>*</sup></label>
							<input type="text" class="form-control" name="postcode" id="postcode" value="{if isset($smarty.post.postcode)}{$smarty.post.postcode}{/if}" onkeyup="$('#postcode').val($('#postcode').val().toUpperCase());" />
						</p>
						<div class="clearBotch"></div>
					{elseif $field_name eq "city"}
						<p class="required1 formAdress">
							<label for="city">{l s='City'} <sup>*</sup></label>
							<input type="text" class="form-control" name="city" id="city" value="{if isset($smarty.post.city)}{$smarty.post.city}{/if}" />
						</p>
						<div class="clearBotch"></div>
						<!-- if customer hasn't update his layout address, country has to be verified but it's deprecated -->
					{elseif $field_name eq "Country:name" || $field_name eq "country"}
						<p class="required select formAdress" hidden>
							<label for="id_country">{l s='Country'} <sup>*</sup></label>
							<select name="id_country" id="id_country" class="form-control">
								<option value="">-</option>
								{foreach from=$countries item=v}
								<option value="{$v.id_country}"{if (isset($smarty.post.id_country) AND $smarty.post.id_country == $v.id_country) OR (!isset($smarty.post.id_country) && $sl_country == $v.id_country)} selected="selected"{/if}>{$v.name}</option>
								{/foreach}
							</select>
						</p>
						<div class="clearBotch"></div>
					{elseif $field_name eq "State:name" || $field_name eq 'state'}
						{assign var='stateExist' value=true}
						<p class="required1 id_state select formAdress">
							<label for="id_state">{l s='State'} <sup>*</sup></label>
							<select name="id_state" id="id_state" class="form-control">
								<option value="">-</option>
							</select>
						</p>
						<div class="clearBotch"></div>
					{/if}
				{/foreach}
				{if $postCodeExist eq false}
					<p class="required postcode formAdress unvisible">
						<label for="postcode">{l s='Zip/Postal Code'} <sup>*</sup></label>
						<input type="text" class="form-control" name="postcode" id="postcode" value="{if isset($smarty.post.postcode)}{$smarty.post.postcode}{/if}" onkeyup="$('#postcode').val($('#postcode').val().toUpperCase());" />
					</p>
					<div class="clearBotch"></div>
				{/if}
				{if $stateExist eq false}
					<p class="required1 id_state select unvisible formAdress">
						<label for="id_state">{l s='State'} <sup>*</sup></label>
						<select name="id_state" id="id_state" class="form-control">
							<option value="">-</option>
						</select>
					</p>
					<div class="clearBotch"></div>
				{/if}
				
				<p class="{if isset($one_phone_at_least) && $one_phone_at_least}required {/if}formAdress"><!-- Второй телефон -->
					<label for="phone_mobile">{l s='Mobile phone'}{if isset($one_phone_at_least) && $one_phone_at_least} <sup>*</sup>{/if}</label>
					<input type="text" class="form-control" name="phone_mobile" id="phone_mobile" value="{if isset($smarty.post.phone_mobile)}{$smarty.post.phone_mobile}{/if}" />
				</p>
				<div class="clearBotch"></div>
				
				
				
				<p class="textarea formAdress"><!-- Коммент к заказу -->
					<label for="other">{l s='Additional information'}</label>
					<textarea class="form-control" name="other" id="other" cols="26" rows="3">{if isset($smarty.post.other)}{$smarty.post.other}{/if}</textarea>
				</p>
				<div class="clearBotch"></div>
				{if isset($one_phone_at_least) && $one_phone_at_least}
					<p class="inline-infos">{l s='You must register at least one phone number.'}</p>
				{/if}
				
				
				<p class="required formAdress" id="address_alias" hidden>
					<label for="alias">{l s='Assign an address alias for future reference.'} <sup>*</sup></label>
					<input type="text" class="form-control" name="alias" id="alias" value="{if isset($smarty.post.alias)}{$smarty.post.alias}{else}{l s='My address'}{/if}" />
				</p>
				<div class="clearBotch"></div>
			</div>
			
		{/if}
		{$HOOK_CREATE_ACCOUNT_FORM}
		<div class="submit clearfix">
			<input type="hidden" name="email_create" value="1" />
			<input type="hidden" name="is_new_customer" value="1" />
			{if isset($back)}<input type="hidden" class="hidden" name="back" value="{$back|escape:'html':'UTF-8'}" />{/if}
			<button type="submit" name="submitAccount" id="submitAccount" class="btn btn-default button button-medium">
				<span>{l s='Register'}<i class="icon-chevron-right right"></i></span>
			</button>
			<p class="pull-right required"><span><sup>*</sup>{l s='Required field'}</span></p>
		</div>
	</form><!-- Конец "Ещё создание аккаунта?" -->
{/if}
{strip}
{if isset($smarty.post.id_state) && $smarty.post.id_state}
	{addJsDef idSelectedState=$smarty.post.id_state|intval}
{else if isset($address->id_state) && $address->id_state}
	{addJsDef idSelectedState=$address->id_state|intval}
{else}
	{addJsDef idSelectedState=false}
{/if}
{if isset($smarty.post.id_state_invoice) && isset($smarty.post.id_state_invoice) && $smarty.post.id_state_invoice}
	{addJsDef idSelectedStateInvoice=$smarty.post.id_state_invoice|intval}
{else}
	{addJsDef idSelectedStateInvoice=false}
{/if}
{if isset($smarty.post.id_country) && $smarty.post.id_country}
	{addJsDef idSelectedCountry=$smarty.post.id_country|intval}
{else if isset($address->id_country) && $address->id_country}
	{addJsDef idSelectedCountry=$address->id_country|intval}
{else}
	{addJsDef idSelectedCountry=false}
{/if}
{if isset($smarty.post.id_country_invoice) && isset($smarty.post.id_country_invoice) && $smarty.post.id_country_invoice}
	{addJsDef idSelectedCountryInvoice=$smarty.post.id_country_invoice|intval}
{else}
	{addJsDef idSelectedCountryInvoice=false}
{/if}
{if isset($countries)}
	{addJsDef countries=$countries}
{/if}
{if isset($vatnumber_ajax_call) && $vatnumber_ajax_call}
	{addJsDef vatnumber_ajax_call=$vatnumber_ajax_call}
{/if}
{if isset($email_create) && $email_create}
	{addJsDef email_create=$email_create|boolval}
{else}
	{addJsDef email_create=false}
{/if}
{/strip}
