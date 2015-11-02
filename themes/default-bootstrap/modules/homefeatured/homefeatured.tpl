{*
* 2007-2015 PrestaShop _tat_ рекомендуемые товары на главной. Убрала подключение product-list.tpl, стала выводить в этот как в productscategory.tpl
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
{if isset($products) && $products}
<div class="title_red">Хиты продаж</div>
	{*include file="$tpl_dir./product-list.tpl" class='homefeatured tab-pane' id='homefeatured1'*}
<div class="tovar_cont">
		{foreach from=$products item=product name=products}
            {if  !empty($product.attachments) && count($product.attachments) === 1}
                {assign var="attach" value=$product.attachments[0]}
            {else}
                {assign var="attach" value=""}
            {/if}
		<!-- Формирую массив возможно выводимых названий характеристик-->
{if ($product.features)}
{foreach from=$product.features item=feature}				
				{if $feature.name == "Жёсткость" || $feature.name == "Жёсткость наматрасника"}
					{assign var=hardnessTitle value=$feature.name}
						{if isset($feature.value) && $feature.value}
							{assign var=hardness value=$feature.value}
						{else}
							{assign var=hardness value="-"}
						{/if}
				{else}
					{if $feature.name == "Высота матраса" || $feature.name == "Высота подушки" || $feature.name == "Высота наматрасника"}
						{assign var=heightTitle value="Высота"}
						{if isset($feature.value) && $feature.value}
							{assign var=height value=$feature.value}								
						{else}
							{assign var=height value="-"}								
						{/if}
					{else}
						{if $feature.name == "Макс. вес на место"}
							{assign var=vesTitle value="Допустимый вес"}
								{if isset($feature.value) && $feature.value}
									{assign var=ves value=$feature.value}
								{else}
									{assign var=ves value="-"}
								{/if}
						{else}
							{if $feature.name == "Тип наматрасника"}
								{assign var=typeMatressTitle value=$feature.name}
								{if isset($feature.value) && $feature.value}
									{assign var=typeMatress value=$feature.value}
								{else}
									{assign var=typeMatress value="-"}
								{/if}
							{else}
								{if $feature.name == "Материал ламелей"}
									{assign var=typePruzinTitle value=$feature.name}
									{if isset($feature.value) && $feature.value}
										{assign var=typePruzin value=$feature.value}
									{else}
										{assign var=typePruzin value="-"}
									{/if}
									{else}
										{if $feature.name == "Наполнитель"}
											{assign var=naFullTitle value=$feature.name}
											{if isset($feature.value) && $feature.value}
												{assign var=naFull value=$feature.value}
											{else}
												{assign var=naFull value="-"}
											{/if}
										{else}
											{if $feature.name == "Ширина ламелей"}
												{assign var=garantiaTitle value=$feature.name}
												{if isset($feature.value) && $feature.value}
													{assign var=garantia value=$feature.value}
												{else}
													{assign var=garantia value="-"}
												{/if}
											{else}	
												{if $feature.name == "Размер подушки"}
													{assign var=pxpPodushkiTitle value="Размер"}
													{if isset($feature.value) && $feature.value}
													{assign var=pxpPodushki value=$feature.value}
												{else}
													{assign var=pxpPodushki value="-"}
												{/if}
												{/if}
											{/if}
										{/if}
									{/if}								
								{/if}	
							{/if}
					{/if}
				{/if}	
			{/foreach}
{/if}
		
		
		
		
		
		
			<div itemscope="" itemtype="https://schema.org/Product" class="tovar">
				<div class="tovar_img">
					<a itemprop="url" href="{$product.link|escape:'html'}" title="{$product.legend|escape:'html':'UTF-8'}" class="products-block-image content_img clearfix">
						<p itemprop="name">{$product.name|strip_tags:'UTF-8'|escape:'html':'UTF-8'}</p>
						<img itemprop="image" src="{$link->getImageLink($product.link_rewrite, $product.id_image, 'medium_default')|escape:'html'}" alt="{$product.legend|escape:'html':'UTF-8'}" />
                        {if !empty($attach)}
                            <img title="{$attach.description}" itemprop="image" src="{$link->getPageLink('attachment', true, NULL, "id_attachment={$attach.id_attachment}")|escape:'html':'UTF-8'}" class="icon-a replace-2x img-responsive" />
                        {/if}
					</a>
				</div>
				<div class="tovar_info" itemprop="description">
					{if ($product.features)}
                    	{*Если будет нужно, смогу вывести характеристики в нужном порядке*}			
				{if isset($pxpPodushkiTitle) && $pxpPodushkiTitle}
					<div>
						<p>{$pxpPodushkiTitle}</p>
						<span>{$pxpPodushki}</span>
					</div>
					{$pxpPodushkiTitle = null}
					{$pxpPodushki = null}
				{/if}
					{if isset($typeMatressTitle) && $typeMatressTitle}
						<div>
							<p>{$typeMatressTitle}</p>
							<span>{$typeMatress}</span>
						</div>
						{$typeMatressTitle = null}
						{$typeMatress = null}
					{/if}
						{if isset($naFullTitle) && $naFullTitle}
							<div>
								<p>{$naFullTitle}</p>
								<span>{$naFull}</span>
							</div>
							{$naFullTitle = null}
							{$naFull = null}						
						{/if}
							{if isset($typePruzinTitle) && $typePruzinTitle}
								<div>
									<p>{$typePruzinTitle}</p>
									<span>{$typePruzin}</span>
								</div>
								{$typePruzinTitle = null}
								{$typePruzin = null}						
							{/if}
								{if isset($hardnessTitle) && $hardnessTitle}
									<div>
										<p>{$hardnessTitle}</p>
										<span>{$hardness}</span>
									</div>
									{$hardnessTitle = null}
									{$hardness = null}						
								{/if}									
										{if isset($heightTitle) && $heightTitle}
											<div>
												<p>{$heightTitle}</p>
												<span>{$height}</span>
											</div>
											{$heightTitle = null}
											{$height = null}
										{/if}				
											{if isset($vesTitle) && $vesTitle}
												<div>
													<p>{$vesTitle}</p>
													<span>{$ves}</span>
												</div>
												{$vesTitle = null}
												{$ves = null}
											{/if}
												{if isset($garantiaTitle) && $garantiaTitle}
													<div>
														<p>{$garantiaTitle}</p>
														<span>{$garantia}</span>
													</div>
													{$garantiaTitle = null}
													{$garantia = null}				
												
				{/if}
                    {/if}
                    
                   
                    
                    
                    
                    
                    
                    
                    
                    
                    
                </div>
                {if !$PS_CATALOG_MODE}
                        <div class="tovar_cena">
                            Цена: 
                            {if ($product.specific_prices.reduction)!=0}                            
                            	<span class="oldprice">{$product.price_without_reduction|ceil}p</span>
                            {/if}
                            <span itemprop="price" class="price">{$product.price|ceil}p</span>
                            <meta itemprop="priceCurrency" content="RUB" />
                        </div>
                    {/if}
			</div>
		{/foreach}
		
	
	
	
	
	
{else}

<ul id="homefeatured" class="homefeatured tab-pane">
	<li class="alert alert-info">{l s='No featured products at this time.' mod='homefeatured'}</li>
</ul>
{/if}