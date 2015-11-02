{*
* 2007-2014 PrestaShop
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
*  @copyright  2007-2014 PrestaShop SA
*  @license    http://opensource.org/licenses/afl-3.0.php  Academic Free License (AFL 3.0)
*  International Registered Trademark & Property of PrestaShop SA
*}

<p>{l s='Your order on %s is complete.' sprintf=$shop_name mod='cashondelivery'}
	<br /><br />
	{l s='You have chosen the cash on delivery method.' mod='cashondelivery'}
	<br /><br /><span class="bold">{l s='Your order will be sent very soon.' mod='cashondelivery'}</span>
	<br /><br />{l s='For any questions or for further information, please contact our' mod='cashondelivery'} <a href="{$link->getPageLink('contact-form', true)|escape:'html'}">{l s='customer support' mod='cashondelivery'}</a>.
</p>

<!-- Conversion tracking code: purchases. Step 3: Order complete -->
<script type="text/javascript">
    (function(w, p) {
        var a, s;
        (w[p] = w[p] || []).push({
            counter_id: 418805192,
            tag: '17f54b2727acfd30644245f1d8b44cd3'
        });
        a = document.createElement('script'); a.type = 'text/javascript'; a.async = true;
        a.src = ('https:' == document.location.protocol ? 'https://' : 'http://') + 'autocontext.begun.ru/analytics.js';
        s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(a, s);
    })(window, 'begun_analytics_params');
</script>
