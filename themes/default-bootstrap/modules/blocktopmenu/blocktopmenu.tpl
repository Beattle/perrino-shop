{if $MENU != ''}
	<!-- Menu _tat_-->
	<div class="menu">
		<div class="cat-title">{l s="Categories" mod="blocktopmenu"}</div>
		<span class="menu_show">Меню</span>
		<ul>
			{$MENU}
			{if $MENU_SEARCH}
				<li class="sf-search noBack" style="float:right">
					<form id="searchbox" action="{$link->getPageLink('search')|escape:'html':'UTF-8'}" method="get">
						<p>
							<input type="hidden" name="controller" value="search" />
							<input type="hidden" value="position" name="orderby"/>
							<input type="hidden" value="desc" name="orderway"/>
							<input type="text" name="search_query" value="{if isset($smarty.get.search_query)}{$smarty.get.search_query|escape:'html':'UTF-8'}{/if}" />
						</p>
					</form>
				</li>
			{/if}
		</ul>

		<div class="search">
            <form method="get" action="{$link->getPageLink('search', true)|escape:'html'}" id="searchbox">
                <input type="hidden" name="controller" value="search" />
                <input type="hidden" name="orderby" value="position" />
                <input type="hidden" name="orderway" value="desc" />
                <input id="search_query_block" value="{$search_query|escape:'html':'UTF-8'|stripslashes}" type="text" name="search_query"  placeholder="Поиск" onfocus="$(this).attr('placeholder', '')" onblur="$(this).attr('placeholder', 'Поиск')" />
			    <input  id="search_button" class="submit button_mini" type="submit" value="" title=""/>
            </form>
		 </div>
	</div>
	<!--/ Menu -->
{/if}