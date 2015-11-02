<?php

include(dirname(__FILE__).'/../../config/config.inc.php');
include(dirname(__FILE__).'/blockpxplay.php');

if (substr(Tools::encrypt('blockpxplay/index'),0,10) != Tools::getValue('token') || !Module::isInstalled('blockpxplay'))
	die('Bad token');

$blockpxplay = new blockpxplay();
echo $blockpxplay->indexAttribute();