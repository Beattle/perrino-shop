<!DOCTYPE HTML>
<!--[if lt IE 7]> <html class="no-js lt-ie9 lt-ie8 lt-ie7" lang="{$language_code|escape:'html':'UTF-8'}"><![endif]-->
<!--[if IE 7]><html class="no-js lt-ie9 lt-ie8 ie7" lang="{$language_code|escape:'html':'UTF-8'}"><![endif]-->
<!--[if IE 8]><html class="no-js lt-ie9 ie8" lang="{$language_code|escape:'html':'UTF-8'}"><![endif]-->
<!--[if gt IE 8]> <html class="no-js ie9" lang="{$language_code|escape:'html':'UTF-8'}"><![endif]-->
<html lang="{$language_code|escape:'html':'UTF-8'}">
	<head>
        {assign var=shop_name_to_trim value=" - $shop_name"}
		<meta charset="utf-8" />
        {if isset($page_name) AND $page_name == 'index'}
        <title>Интернет-магазин официального дилера фабрики матрасов Perrino</title>
        {elseif isset($page_name) AND ($page_name == 'module-smartblog-category' OR $page_name == 'module-smartblog-details')}
            <title>{$meta_title|replace:$shop_name_to_trim:''|escape:'html':'UTF-8'}</title>
        {elseif isset($page_name) AND ($page_name == 'cms')}
            <title>{$meta_title|replace:$shop_name_to_trim:''|escape:'html':'UTF-8'}</title>
        {else}
         <title>{$meta_title|replace:$shop_name_to_trim:''|escape:'html':'UTF-8'} купить в интернет-магазине официального дилера фабрики Перрино</title>
        {/if}
{if isset($meta_description) AND $meta_description}
		<meta name="description" content="{$meta_description|escape:'html':'UTF-8'}" />
{/if}
{if isset($meta_keywords) AND $meta_keywords}
		<meta name="keywords" content="{$meta_keywords|escape:'html':'UTF-8'}" />
{/if}
		<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
		
		<meta name="generator" content="PrestaShop" />
		<meta name="robots" content="{if isset($nobots)}no{/if}index,{if isset($nofollow) && $nofollow}no{/if}follow" />

		<meta name="apple-mobile-web-app-capable" content="yes" />
		<link rel="icon" type="image/vnd.microsoft.icon" href="{$favicon_url}?{$img_update_time}" />
		<link rel="shortcut icon" type="image/x-icon" href="{$favicon_url}?{$img_update_time}" />
{if isset($css_files)}
	{foreach from=$css_files key=css_uri item=media}
		<link rel="stylesheet" href="{$css_uri|escape:'html':'UTF-8'}" type="text/css" media="{$media|escape:'html':'UTF-8'}" />
	{/foreach}
{/if}
{if isset($js_defer) && !$js_defer && isset($js_files) && isset($js_def)}
	{$js_def}
	
	{foreach from=$js_files item=js_uri}
	<script type="text/javascript" src="{$js_uri|escape:'html':'UTF-8'}"></script>
	{/foreach}
<!--    <script type="text/javascript" src="{$base_dir}/themes/default-bootstrap/js/autotat/commun.js"></script> -->
	{if $page_name =='index' && $page_name }						
		<script type="text/javascript" src="{$base_dir}themes/default-bootstrap/js/modules/blocklayered/blocklayered.js"></script>
        <link rel="stylesheet" href="{$base_dir}themes/default-bootstrap/css/modules/blocklayered/blocklayered.css">
	{/if}
{/if}
		{*$HOOK_HEADER*}
		<link rel="stylesheet" href="http{if Tools::usingSecureMode()}s{/if}://fonts.googleapis.com/css?family=Open+Sans:300,600&amp;subset=latin,latin-ext" type="text/css" media="all" />
		<!--[if IE 8]>
		<script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
		<script src="https://oss.maxcdn.com/libs/respond.js/1.3.0/respond.min.js"></script>
		
		<![endif]-->
		<script type="text/javascript" src="{$base_dir}/themes/default-bootstrap/js/js.js"></script>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />

{*<link rel="stylesheet" type="text/css" href="{$base_dir}/themes/default-bootstrap/css/global1.css" />*}
<meta name='yandex-verification' content='4a93e553d8a60342' />

{*<title>Title</title>*}

</head>
	<body{if isset($page_name)} id="{$page_name|escape:'html':'UTF-8'}"{/if} class="{if isset($page_name)}{$page_name|escape:'html':'UTF-8'}{/if}{if isset($body_classes) && $body_classes|@count} {implode value=$body_classes separator=' '}{/if}{if $hide_left_column} hide-left-column{/if}{if $hide_right_column} hide-right-column{/if}{if isset($content_only) && $content_only} content_only{/if} lang_{$lang_iso}">
	<div class="footer_padd">

<div class="header" itemscope itemtype="http://schema.org/WPHeader">
     <div class="center">
                
		 
		 <div class="logo" itemscope itemtype="http://schema.org/Organization">
			<a itemprop="url" href="{if $force_ssl}{$base_dir_ssl}{else}{$base_dir}{/if}" title="{$shop_name|escape:'html':'UTF-8'}">
				<img itemprop="logo" class="logo img-responsive" src="{$base_dir}/themes/default-bootstrap/img/template/logo.png" alt="{$shop_name|escape:'html':'UTF-8'}"{if isset($logo_image_width) && $logo_image_width} width="{$logo_image_width}"{/if}{if isset($logo_image_height) && $logo_image_height} height="{$logo_image_height}"{/if}/>
			</a>
		 </div>
		 {$HOOK_TOP}	
		
		 <div class="tel">
		 	
			 <p><img src="{$base_dir}/themes/default-bootstrap/img/template/tel.png" alt=""/><a href="tel:+79015437207" title="">+7 901 543 72 07</a> <br /><a href="tel:84959717207" title="">8 (495) 971 72 07</a></p> <!-- +7 (499) 501 21 12 -->
			 <p class="zakaz">Заказать звонок</p>
		 </div>
	 </div>	 
</div>
<div class="center">
	 <div class="content">	 
	 	<div class="left">
	{if $page_name =='index' && $page_name }						
		{include file="$tpl_dir./html-layered.tpl"}
	{/if}

			 
			 {if isset($HOOK_LEFT_COLUMN) && $HOOK_LEFT_COLUMN}
						{$HOOK_LEFT_COLUMN}<!-- Если с if, то входит только на домашнюю страницу, а если нет, то и на остальные СТРАНИЦЫ верхнего меню категории-->	
			 {/if}
		{if  isset($HOOK_EXTRA_LEFT) && $HOOK_EXTRA_LEFT}
			{$HOOK_EXTRA_LEFT}
		{/if}
		 
		 </div><!-- left -->
		 <div class="right_respons">
		 <div class="right">
             {if $page_name =='index' && $page_name }
                 <ul class="product_list" id="3"></ul>
             {/if}
		 {if $page_name !='index' && $page_name !='pagenotfound'}
						{include file="$tpl_dir./breadcrumb.tpl"}
					{/if}

<!-- Затемнение всплывающего окна -->
<div class="overlay" style="display: none;"></div>
<div class="popup" style="display: none;">
				<div class="popupClose">x</div>
					<form class="forma" method="post" title="Форма заказа">													<p>Форма заказа обратного звонка</p>
						<label>Имя: <input class="name" type="text" name="name" required></label><br/>
						<label>E-mail:<input name="mail" type="email" value=""></label><br/>	
						<label>Телефон:<input class="tel" type="text" name="tel" required></label><br/> 	 
						<label>Сообщение:
						<textarea class="message" name="message"></textarea>
						</label><br/>
						<input type="submit" value="Заказать звонок" title=""/>
						<input type="hidden" name="subject" value="Заявка на звонок с сайта perrino-shop.ru">
						<input type="hidden" name="namesymbol" value="Имя: ">						
						<input type="hidden" name="telsymbol" value="Телефон: ">
						<input type="hidden" name="messagesymbol" value="Сообщение: ">
					</form>						
			</div><!--popup -->	
	
