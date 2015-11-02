{if isset($subcategories)}{* Массив подкатегорий, который я получила в файле php-модуля. _tat_*}
 {* <h2>{l s='Список категорий' mod='blockHitscategorys'}</h2>*}

  <div class="mainkat_cont">
  <div class="hook_hit">
        {$HOOK_HIT}
    </div>    
      {foreach from=$subcategories item=subcategory}{* Вывожу массив имён категорий. *}
	  <div class="mainkat">	  	
	    <a href="{$link->getCategoryLink($subcategory.id_category, $subcategory.link_rewrite)|escape:'htmlall':'UTF-8'}" title="{$subcategory.name|escape:'htmlall':'UTF-8'}">
	    {if $subcategory.id_image}{* В конструкторе класса category.php определяется *}
		<img src="{$link->getCatImageLink($subcategory.link_rewrite, $subcategory.id_image, 'medium_default')}" alt="" width="{$mediumSize.width}" height="{$mediumSize.height}" />
	    {else}
		<img src="{$img_cat_dir}default-medium_default.jpg" alt="" width="{$mediumSize.width}" height="{$mediumSize.height}" />
	    {/if}
	    <p>{$subcategory.name|escape:'htmlall':'UTF-8'}</p>
	    </a>	    
	  </div>
      {/foreach}    
    <br class="clear"/>
  </div>
{/if}
