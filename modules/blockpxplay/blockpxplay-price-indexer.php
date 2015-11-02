<?php

include(dirname(__FILE__).'/../../config/config.inc.php');
include(dirname(__FILE__).'/blockpxplay.php');

if (substr(Tools::encrypt('blockpxplay/index'),0,10) != Tools::getValue('token') || !Module::isInstalled('blockpxplay'))
	die('Bad token');

if (!Tools::getValue('ajax'))
{
	// Case of nothing to do but showing a message (1)
	if (Tools::getValue('return_message') !== false)
	{
		echo '1';
		die();
	}
	
	if (Tools::usingSecureMode())
		$domain = Tools::getShopDomainSsl(true);
	else
		$domain = Tools::getShopDomain(true);
	// Return a content without waiting the end of index execution
	header('Location: '.$domain.__PS_BASE_URI__.'modules/blockpxplay/blockpxplay-price-indexer.php?token='.Tools::getValue('token') .'&return_message='.(int)Tools::getValue('cursor'));
	flush();
}

if(Tools::getValue('full'))
{
	echo blockpxplay::fullPricesIndexProcess((int)Tools::getValue('cursor'), (int)Tools::getValue('ajax'), true);
}
else
	echo blockpxplay::pricesIndexProcess((int)Tools::getValue('cursor'), (int)Tools::getValue('ajax'));