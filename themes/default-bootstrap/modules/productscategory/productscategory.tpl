{*
* 2007-2015 PrestaShop
*
* NOTICE OF LICENSE _tat_ вывод таких же товаров категории в карточке товара
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
{if count($categoryProducts) > 0 && $categoryProducts !== false}
<div class="title_red">
				 Похожие товары
			 </div>
	
	<div class="tovar_cont_similar">
	
		{foreach from=$categoryProducts item='categoryProduct' name=categoryProduct}
            {if  !empty($categoryProduct.attachments) && count($categoryProduct.attachments) === 1}
                {assign var="attach" value=$categoryProduct.attachments[0]}
            {else}
                {assign var="attach" value=""}
            {/if}
            {*<pre>{$categoryProduct|print_r}</pre>*}
			<div class="tovar" itemprop="isSimilarTo" itemscope itemtype="http://schema.org/Product">
				<div class="tovar_img">
				<a itemprop="url" href="{$link->getProductLink($categoryProduct.id_product, $categoryProduct.link_rewrite, $categoryProduct.category, $categoryProduct.ean13)|escape:'html':'UTF-8'}" class="lnk_img product-image" title="{$categoryProduct.name|htmlspecialchars}">
				<p itemprop="name">	{$categoryProduct.name|truncate:100:'...'|escape:'html':'UTF-8'}	</p>
				<img itemprop="image" src="{$link->getImageLink($categoryProduct.link_rewrite, $categoryProduct.id_image, 'home_default')|escape:'html':'UTF-8'}" alt="{$categoryProduct.name|htmlspecialchars}" />
                    {if !empty($attach)}
                        <img title="{$attach.description}" itemprop="image" src="{$link->getPageLink('attachment', true, NULL, "id_attachment={$attach.id_attachment}")|escape:'html':'UTF-8'}" class="icon-a replace-2x img-responsive" />
                    {/if}
				</a>
				</div>
				
				
				
				{foreach from=$categoryProduct.features item=feature}				
				{if $feature.name == "Жёсткость" || $feature.name == "Жёсткость наматрасника"}
					{assign var=hardnessTitle value="Жёсткость"}
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
								{assign var=typeMatressTitle value="Тип"}
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
				
				
				<div itemprop="description" class="tovar_info">
					{*Если будет нужно, смогу вывести характеристики в нужном порядке*}			
				{if isset($pxpPodushkiTitle) && $pxpPodushkiTitle}
					<div>
						<p>{$pxpPodushkiTitle}</p>
						<span>{$pxpPodushki}</span>
					</div>
				{/if}
					{if isset($typeMatressTitle) && $typeMatressTitle}
						<div>
							<p>{$typeMatressTitle}</p>
							<span>{$typeMatress}</span>
						</div>
					{/if}
						{if isset($naFullTitle) && $naFullTitle}
							<div>
								<p>{$naFullTitle}</p>
								<span>{$naFull}</span>
							</div>						
						{/if}
							{if isset($typePruzinTitle) && $typePruzinTitle}
								<div>
									<p>{$typePruzinTitle}</p>
									<span>{$typePruzin}</span>
								</div>						
							{/if}
								{if isset($hardnessTitle) && $hardnessTitle}
									<div>
										<p>{$hardnessTitle}</p>
										<span>{$hardness}</span>
									</div>						
								{/if}									
										{if isset($heightTitle) && $heightTitle}
											<div>
												<p>{$heightTitle}</p>
												<span>{$height}</span>
											</div>
										{/if}				
											{if isset($vesTitle) && $vesTitle}
												<div>
													<p>{$vesTitle}</p>
													<span>{$ves}</span>
												</div>
											{/if}
												{if isset($garantiaTitle) && $garantiaTitle}
													<div>
														<p>{$garantiaTitle}</p>
														<span>{$garantia}</span>
													</div>				
												
				{/if}
				</div>				
				{if $ProdDisplayPrice && $categoryProduct.show_price == 1 && !isset($restricted_country_mode) && !$PS_CATALOG_MODE}
					<div itemprop="offers" itemscope itemtype="http://schema.org/Offer" class="tovar_cena">
					{if isset($categoryProduct.specific_prices) && $categoryProduct.specific_prices
					&& ($categoryProduct.displayed_price|number_format:2 !== $categoryProduct.price_without_reduction|number_format:2)}
						Цена: <span class="oldprice">{displayWtPrice p=$categoryProduct.price_without_reduction}</span>
						<span itemprop="price">{convertPrice price=$categoryProduct.displayed_price}</span>
					{else}{*Если без скидки*}
						Цена: <span itemprop="price" class="price">{convertPrice price=$categoryProduct.displayed_price}</span>

					{/if}
                        <meta itemprop="priceCurrency" content="RUB" />
					</div>
				{else}
				<br />
				{/if}
			</div>
		{/foreach}		
	</div>

{/if}