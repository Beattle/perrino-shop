<?php

/*
*  @author Ilia Ilin <admin@blogun.biz>
*  @copyright  2013
*  @version  1.0 _tat_ блок вывода категории хитов на страницах родительских категорий. Переделала скачанную BlockHomecategorys. добавила функцию getSubCategoriesHit
*/

if (!defined('_PS_VERSION_'))
	exit;


class blockHitscategorys extends Module
{
	public function __construct()
	{
		$this->name = 'blockHitscategorys';
		$this->tab = 'front_office_features';
		$this->version = '1.0';
		$this->author = 'ILIL';

		parent::__construct();

		$this->displayName = $this->l('Category-Hit block');
		$this->description = $this->l('Adds a block category-Hit to other parents categories.');
	}

	function install()
	{
	    if (!parent::install() || !$this->registerHook('displayHeader') )
		return false;
	    return true;
	}

        public function hookDisplayHeader()
        {
            $this->context->controller->addCSS(_THEME_CSS_DIR_.'category.css', 'all');
        }
        
	public function hookDisplayHit($params)
	{
            $categoryRoot = new Category(Configuration::get('PS_HOME_CATEGORY'),$this->context->language->id,$this->context->shop->id);
            $categoriesHome = $categoryRoot->getSubCategoriesHit($this->context->language->id);//функция описана в classes Category.php
            
            $this->smarty->assign(array(
                'subcategories' => $categoriesHome,
                'homeSize' => Image::getSize('medium_default')
            ));
            //print_r($categoriesHome);Получаю массив с ключами определёнными в classes Category.php
            
            return $this->display(__FILE__, 'blockHitscategorys.tpl');
	}

}
