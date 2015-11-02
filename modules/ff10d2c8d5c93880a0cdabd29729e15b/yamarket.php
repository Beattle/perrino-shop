<?php
/**
* yamarket_с module main file.
*
* @author    0RS <admin@prestalab.ru>
* @link http://prestalab.ru/
* @copyright Copyright &copy; 2009-2012 PrestaLab.Ru
* @license   http://www.opensource.org/licenses/osl-3.0.php  Open Software License (OSL 3.0)
* @version 2.0
*/

if (!defined('_PS_VERSION_'))
	exit;

class yamarket_сС extends Module
{
	private $html = '';
	private $post_errors = array();

	public function __construct()
	{
		$this->name = 'yamarket_с';
		$this->tab = 'export';
		$this->version = '2.2';
		$this->author = 'PrestaLab.Ru';
		$this->need_instance = 0;
		//Ключик из addons.prestashop.com
		$this->module_key = '';
		$this->bootstrap = true;

		parent::__construct();

		$this->displayName = $this->l('Yandex Market export');
		$this->description = $this->l('Yandex Market export file generator');
	}

	public function install()
	{
		return (parent::install()
			&& Configuration::updateValue('yamarket_с_categories', serialize(array()))
			&& Configuration::updateValue('yamarket_с_shipping', serialize(array(1)))
			&& Configuration::updateValue('yamarket_с_shop', Configuration::get('PS_SHOP_NAME'))
			&& Configuration::updateValue('yamarket_с_company', Configuration::get('PS_SHOP_NAME'))
		);
	}

	public function uninstall()
	{
		return (parent::uninstall()
			&& Configuration::deleteByName('yamarket_с_shop')
			&& Configuration::deleteByName('yamarket_с_company')
			&& Configuration::deleteByName('yamarket_с_shippingcost')
			&& Configuration::deleteByName('yamarket_с_info')
			&& Configuration::deleteByName('yamarket_с_gzip')
			&& Configuration::deleteByName('yamarket_с_combinations')
			&& Configuration::deleteByName('yamarket_с_shipping')
			&& Configuration::deleteByName('yamarket_с_currencies')
			&& Configuration::deleteByName('yamarket_с_availability')
			&& Configuration::deleteByName('yamarket_с_categories')
			//&& Configuration::deleteByName('yamarket_с_supplier')
		);
	}

	public function getContent()
	{
		if (Tools::isSubmit('submityamarket_с'))
		{
			$this->_postValidation();
			if (!count($this->post_errors))
				$this->_postProcess();
			else
				foreach ($this->post_errors as $err)
					$this->html .= $this->displayError($err);
		}
		$this->html .= $this->renderForm();
		return $this->html;
	}

	public function renderForm()
	{
		$root_category = Category::getRootCategory();
		$root_category = array('id_category' => $root_category->id, 'name' => $root_category->name);
		$cats = array();
		if ($c = Configuration::get('yamarket_с_categories'))
		{
			$uc = unserialize($c);
			if (is_array($uc))
				$cats = $uc;
		}
		$this->fields_form[0]['form'] = array(
				'legend' => array(
				'title' => $this->l('Settings'),
				'image' => _PS_ADMIN_IMG_.'information.png'
			),
			'input' => array(
				array(
					'type' => 'text',
					'label' => $this->l('Shop Name'),
					'desc' => $this->l('Shop name in yandex market'),
					'name' => 'yamarket_с_shop',
				),
				array(
					'type' => 'text',
					'label' => $this->l('Сompany name'),
					'desc' => $this->l('Your company name'),
					'name' => 'yamarket_с_company',
				),
				array(
					'type' => 'text',
					'label' => $this->l('Shipping cost'),
					'desc' => $this->l('Shipping cost in shop region'),
					'name' => 'yamarket_с_shippingcost',
				),
				array(
					'type' => 'text',
					'label' => $this->l('Information'),
					'desc' => $this->l('Information about minimal order cost, minimal product quantity or prepayment'),
					'name' => 'yamarket_с_info',
				),
				array(
					'type' => 'switch',
					'label' => $this->l('Gzip compression'),
					'desc' => $this->l('Compress export file'),
					'name' => 'yamarket_с_gzip',
					'values' => array(
						array(
							'id' => 'yamarket_с_gzip_on',
							'value' => 1,
							'label' => $this->l('Enabled')
						),
						array(
							'id' => 'yamarket_с_gzip_off',
							'value' => 0,
							'label' => $this->l('Disabled')
						)
					)
				),
				array(
					'type' => 'switch',
					'label' => $this->l('Combinations'),
					'desc' => $this->l('Export combinations'),
					'name' => 'yamarket_с_combinations',
					'values' => array(
						array(
							'id' => 'yamarket_с_combinations_on',
							'value' => 1,
							'label' => $this->l('Enabled')
						),
						array(
							'id' => 'yamarket_с_combinations_off',
							'value' => 0,
							'label' => $this->l('Disabled')
						)
					)
				),
				array(
					'type' => 'checkbox',
					'label' => $this->l('Shipping'),
					'desc' => $this->l('Delivery, pickup and store'),
					'name' => 'yamarket_с_shipping',
					'is_bool' => false,
					'values' => array(
						'id'=>'id',
						'name'=>'label',
						'query'=>array(
							array(
								'id' => '[1]',
								'val' => 1,
								'label' => $this->l('Delivery availability')
							),
							array(
								'id' => '[2]',
								'val' => 1,
								'label' => $this->l('Pickup in store availability')
							),
							array(
								'id' => '[3]',
								'val' => 1,
								'label' => $this->l('Can buy in Store')
							)
						)
					)
				),
				array(
					'type' => 'switch',
					'label' => $this->l('Currencies'),
					'desc' => $this->l('If not checked will be used default currency'),
					'name' => 'yamarket_с_currencies',
					'values' => array(
						array(
							'id' => 'yamarket_с_currencies_on',
							'value' => 1,
							'label' => $this->l('Enabled')
						),
						array(
							'id' => 'yamarket_с_currencies_off',
							'value' => 0,
							'label' => $this->l('Disabled')
						)
					)
				),
				array(
					'type' => 'radio',
					'label' => $this->l('Availability'),
					'desc' => $this->l('Product availability'),
					'name' => 'yamarket_с_availability',
					'is_bool' => false,
					'values' => array(
						array(
							'id' => 'yamarket_с_availability_0',
							'value' => 0,
							'label' => $this->l('All avaible')
						),
						array(
							'id' => 'yamarket_с_availability_1',
							'value' => 1,
							'label' => $this->l('If quantity >0, then avaible, else on request')
						),
						array(
							'id' => 'yamarket_с_availability_2',
							'value' => 2,
							'label' => $this->l('If quantity = 0, product not exported')
						),
						array(
							'id' => 'yamarket_с_availability_3',
							'value' => 3,
							'label' => $this->l('All on request')
						)
					)
				),
				array(
					'type' => 'categories',
					'label' => $this->l('Categories'),
					'desc' => $this->l('Categories to export. If necessary, subcategories must be checked too.'),
					'name' => 'yamarket_с_categories',
					'tree' => array(
						'use_search' => false,
						'id' => 'categoryBox',
						'use_checkbox' => true,
						'selected_categories' => $cats,
					),
				),
/*				array(
					'type' => 'checkbox',
					'label' => $this->l('Suppliers'),
					'desc' => $this->l('Select suppliers'),
					'name' => 'yamarket_с_supplier',
					'values' => array(
						'query' => Supplier::getSuppliers(),
						'id' => 'id_supplier',
						'name' => 'name'
					)
				),
*/
			),
			'submit' => array(
				'name' => 'submityamarket_с',
				'title' => $this->l('Save')
			)
		);

		$this->fields_form[1]['form'] = array(
			'legend' => array(
				'title' => $this->l('Yandex Market configuration information') ,
				'image' => _PS_ADMIN_IMG_.'information.png'
			),
			'input' => array(
				array(
					'type' => 'text',
					'label' => $this->l('Static url'),
					'desc' => $this->l('URL to download file generated by cron or Export button.'),
					'name' => 'url1',
				),
				array(
					'type' => 'text',
					'label' => $this->l('Dinamic url'),
					'desc' => $this->l('URL to download dinamicaly generated export file.'),
					'name' => 'url2',
				),
				array(
					'type' => 'text',
					'label' => $this->l('Cron url'),
					'desc' => $this->l('URL to regenerate export file by cron.'),
					'name' => 'url3',
				)
			)
		);

		$helper = new HelperForm();
		$helper->module = $this;
		$helper->show_toolbar = false;
		$helper->table = $this->table;
		$lang = new Language((int)Configuration::get('PS_LANG_DEFAULT'));
		$helper->default_form_language = $lang->id;
		$helper->allow_employee_form_lang = Configuration::get('PS_BO_ALLOW_EMPLOYEE_FORM_LANG') ? Configuration::get('PS_BO_ALLOW_EMPLOYEE_FORM_LANG') : 0;
		$helper->identifier = $this->identifier;
		$helper->submit_action = 'submityamarket_с';
		$helper->currentIndex = $this->context->link->getAdminLink('AdminModules', false).'&configure='.$this->name.'&tab_module='.$this->tab.'&module_name='.$this->name;
		$helper->token = Tools::getAdminTokenLite('AdminModules');
		$helper->tpl_vars = array(
			'fields_value' => $this->getConfigFieldsValues(),
			'languages' => $this->context->controller->getLanguages(),
			'id_language' => $this->context->language->id
		);
		return $helper->generateForm($this->fields_form);
	}

	public function getConfigFieldsValues()
	{
		$fields_values = array();

		$yamarket_с_shipping = unserialize(Configuration::get('yamarket_с_shipping'));
		if ($yamarket_с_shipping)
			foreach ($yamarket_с_shipping as $key => $val)
				$fields_values['yamarket_с_shipping_['.$key.']'] = $val;

/*		$yamarket_с_supplier=unserialize(Configuration::get('yamarket_с_supplier'));
		if ($yamarket_с_supplier)
			foreach ($yamarket_с_supplier as $val)
				$fields_values['yamarket_с_supplier_'.$val.''] = 1;
*/

		$fields_values['yamarket_с_shop'] = Configuration::get('yamarket_с_shop');
		$fields_values['yamarket_с_company'] = Configuration::get('yamarket_с_company');
		$fields_values['yamarket_с_shippingcost'] = Configuration::get('yamarket_с_shippingcost');
		$fields_values['yamarket_с_info'] = Configuration::get('yamarket_с_info');
		$fields_values['yamarket_с_gzip'] = Configuration::get('yamarket_с_gzip');
		$fields_values['yamarket_с_combinations'] = Configuration::get('yamarket_с_combinations');
		$fields_values['yamarket_с_currencies'] = Configuration::get('yamarket_с_currencies');
		$fields_values['yamarket_с_availability'] = Configuration::get('yamarket_с_availability');

		$fields_values['url1'] = _PS_BASE_URL_._THEME_PROD_PIC_DIR_.'yml.'.$this->context->shop->id.'.xml'.(Configuration::get('yamarket_с_gzip') ? '.gz' : '');
		$fields_values['url2'] = $this->context->link->getModuleLink('yamarket_с', 'generate', array(), true);
		$fields_values['url3'] = $this->context->link->getModuleLink('yamarket_с', 'generate', array('cron'=>'1'), true);

		return $fields_values;
	}

	private function _postValidation()
	{
		if (Tools::getValue('yamarket_с_shop') && (!Validate::isString(Tools::getValue('yamarket_с_shop'))))
			$this->post_errors[] = $this->l('Invalid').' '.$this->l('Shop Name');
		if (Tools::getValue('yamarket_с_company') && (!Validate::isString(Tools::getValue('yamarket_с_company'))))
			$this->post_errors[] = $this->l('Invalid').' '.$this->l('Сompany name');
		if (Tools::getValue('yamarket_с_shippingcost') && (!Validate::isString(Tools::getValue('yamarket_с_shippingcost'))))
			$this->post_errors[] = $this->l('Invalid').' '.$this->l('Shipping cost');
		if (Tools::getValue('yamarket_с_info') && (!Validate::isString(Tools::getValue('yamarket_с_info'))))
			$this->post_errors[] = $this->l('Invalid').' '.$this->l('Information');
		if (Tools::getValue('yamarket_с_gzip') && (!Validate::isBool(Tools::getValue('yamarket_с_gzip'))))
			$this->post_errors[] = $this->l('Invalid').' '.$this->l('Gzip compression');
		if (Tools::getValue('yamarket_с_combinations') && (!Validate::isBool(Tools::getValue('yamarket_с_combinations'))))
			$this->post_errors[] = $this->l('Invalid').' '.$this->l('Combinations');
		if (Tools::getValue('yamarket_с_currencies') && (!Validate::isBool(Tools::getValue('yamarket_с_currencies'))))
			$this->post_errors[] = $this->l('Invalid').' '.$this->l('Currencies');
		if (Tools::getValue('yamarket_с_availability') && (!Validate::isInt(Tools::getValue('yamarket_с_availability'))))
			$this->post_errors[] = $this->l('Invalid').' '.$this->l('Availability');
	}

	private function _postProcess()
	{
		Configuration::updateValue('yamarket_с_categories', serialize(array_map('intval', Tools::getValue('yamarket_с_categories'))));
		Configuration::updateValue('yamarket_с_shop', Tools::getValue('yamarket_с_shop'));
		Configuration::updateValue('yamarket_с_company', Tools::getValue('yamarket_с_company'));
		Configuration::updateValue('yamarket_с_shippingcost', (float)Tools::getValue('yamarket_с_shippingcost'));
		Configuration::updateValue('yamarket_с_info', Tools::getValue('yamarket_с_info'));
		Configuration::updateValue('yamarket_с_gzip', (int)Tools::getValue('yamarket_с_gzip'));
		Configuration::updateValue('yamarket_с_combinations', (int)Tools::getValue('yamarket_с_combinations'));
		Configuration::updateValue('yamarket_с_shipping', serialize(Tools::getValue('yamarket_с_shipping_')));
		Configuration::updateValue('yamarket_с_currencies', (int)Tools::getValue('yamarket_с_currencies'));
		Configuration::updateValue('yamarket_с_availability', (int)Tools::getValue('yamarket_с_availability'));
/*		$mans = Supplier::getSuppliers();
		$selected = array();
		foreach ($mans as $man)
		{
			if (Tools::getValue('yamarket_с_supplier_'.$man['id_supplier']))
				$selected[] = $man['id_supplier'];
		}
		Configuration::updateValue('yamarket_с_supplier', serialize($selected));
*/
		$this->html .= $this->displayConfirmation($this->l('Settings updated.'));
	}

	private function combinationUrlPrepare($val)
	{
		return str_replace(Configuration::get('PS_ATTRIBUTE_ANCHOR_SEPARATOR'), '_', Tools::link_rewrite(str_replace(array(',', '.'), '-', $val)));
	}

	public function generate($cron = false)
	{
		self::setCurrency();
		include 'classes/ymlCatalog.php';
		//Язык по умолчанию
		$id_lang = (int)Configuration::get('PS_LANG_DEFAULT');
		//Валюта по умолчанию
		$currency_default = new Currency($this->context->cookie->id_currency);
		$this->currency_iso = $currency_default->iso_code;
		//Адрес магазина
		$shop_url = 'http://'.Tools::getHttpHost(false, true).__PS_BASE_URI__;
		//Категории для экспорта
		$yamarket_с_categories = unserialize(Configuration::get('yamarket_с_categories'));
		//$yamarket_с_suppliers = unserialize(Configuration::get('yamarket_с_supplier'));

		$yamarket_с_combinations = Configuration::get('yamarket_с_combinations');

		$this->yamarket_с_availability = Configuration::get('yamarket_с_availability');
		$this->yamarket_с_shipping = unserialize(Configuration::get('yamarket_с_shipping'));

		//создаем новый магазин
		$catalog = new ymlCatalog();
		$catalog->gzip = Configuration::get('yamarket_с_gzip');
		$shop = new ymlShop();
		$shop->name = Configuration::get('yamarket_с_shop');
		$shop->company = Configuration::get('yamarket_с_company');
		$shop->url = $shop_url;
		$shop->platform = 'PrestaShop';
		$shop->version = _PS_VERSION_;
		$shop->agency = 'PrestaLab';
		$shop->email = 'admin@prestalab.ru';

		//Валюты
		$shop->startTag(ymlCurrency::$collectionName);
		if (Configuration::get('yamarket_с_currencies'))
		{
			$currencies = Currency::getCurrencies();
			foreach ($currencies as $currency)
				$shop->add(new ymlCurrency(($currency['iso_code']), (float)$currency['conversion_rate']));
			unset($currencies);
		}
		else
			$shop->add(new ymlCurrency($currency_default->iso_code, (float)$currency_default->conversion_rate));
		$shop->endTag(ymlCurrency::$collectionName);

		//Категории
		$categories = Category::getCategories($id_lang, false, false);
		$shop->startTag(ymlCategory::$collectionName);
		foreach ($categories as $category)
		{
			if ($category['active'] && in_array($category['id_category'], $yamarket_с_categories))
				$shop->add(new ymlCategory($category['id_category'], $category['name'], $category['id_parent']));
		}
		$shop->endTag(ymlCategory::$collectionName);

		//Стоимость доставки
		$shop->addString('<local_delivery_cost>'.Configuration::get('yamarket_с_shippingcost').'</local_delivery_cost>');
		//Товары
		$shop->startTag(ymlOffer::$collectionName);
		foreach ($categories as $category)
		{
			if ($category['active'] && in_array($category['id_category'], $yamarket_с_categories))
			{
				$category_object = new Category ($category['id_category']);
				$products = $category_object->getProducts($id_lang, 1, 10000);

				if ($products)
					foreach ($products as $product)
					{
						if ($product['id_category_default'] != $category['id_category'])
							continue;

//						if (count($yamarket_с_suppliers)&&(!in_array($product['id_supplier'], $yamarket_с_suppliers)))
//							continue;
						//Для комбинаций
						if ($yamarket_с_combinations)
						{
							$product_object = new Product($product['id_product'], false, $id_lang);
							$combinations = $product_object->getAttributeCombinations($id_lang);
						}
						else
							$combinations = false;

						if (is_array($combinations) && count($combinations) > 0)
						{
							$comb_array = array();
							foreach ($combinations as $combination)
							{
								$comb_array[$combination['id_product_attribute']]['id_product_attribute'] = $combination['id_product_attribute'];
								$comb_array[$combination['id_product_attribute']]['price'] = Product::getPriceStatic($product['id_product'], true, $combination['id_product_attribute']);
								$comb_array[$combination['id_product_attribute']]['reference'] = $combination['reference'];
								$comb_array[$combination['id_product_attribute']]['ean13'] = $combination['ean13'];
								$comb_array[$combination['id_product_attribute']]['quantity'] = $combination['quantity'];
								$comb_array[$combination['id_product_attribute']]['attributes'][$combination['group_name']] = $combination['attribute_name'];
                                $comb_array[$combination['id_product_attribute']]['oldprice'] = $product['orderprice']+$combination['price'];
								if (!isset($comb_array[$combination['id_product_attribute']]['comb_url']))
									$comb_array[$combination['id_product_attribute']]['comb_url'] = '';
								$comb_array[$combination['id_product_attribute']]['comb_url'] .= '/'.(self::combinationUrlPrepare($combination['group_name']).'-'.self::combinationUrlPrepare($combination['attribute_name']));
							}
							foreach ($comb_array as $combination)
								self::_addProduct($shop, $product, $combination);
						}
						else
							self::_addProduct($shop, $product);
					}
				unset($product);
			}
		}
		unset($categories);
		$shop->endTag(ymlOffer::$collectionName);
		$catalog->add($shop);

		if ($cron)
		{
			if ($fp = fopen(_PS_UPLOAD_DIR_.'yml.'.$this->context->shop->id.'.xml'.($catalog->gzip ? '.gz' : ''), 'w'))
			{
				fwrite($fp, $catalog->generate());
				fclose($fp);
			}
		}
		else
		{
			if ($catalog->gzip)
			{
				header('Content-type:application/x-gzip');
				header('Content-Disposition: attachment; filename=yml.'.$this->context->shop->id.'.xml.gz');
			}
			else
				header('Content-type:application/xml;  charset=utf-8');
			echo $catalog->generate();
		}
	}


	private function _addProduct($shop, $product, $combination = false)
	{
		$quantity = (int)($combination?$combination['quantity']:$product['quantity']);

		//В наличии или под заказ
		$available = 'false';
		if ($this->yamarket_с_availability == 0)
			$available = 'true';
		elseif ($this->yamarket_с_availability == 1)
		{
			if ($quantity > 0)
				$available = 'true';
		}
		elseif ($this->yamarket_с_availability == 2)
		{
			$available = 'true';
			if ($quantity == 0)
				return;
		}

		$offer = new ymlOffer($product['id_product'].($combination?'c'.$combination['id_product_attribute']:''),
			'',
			$available
		);
		$offer->url = $product['link'].($combination?'#'.$combination['comb_url']:'');
        $offer->oldprice = $combination['oldprice'];
		$offer->price = Tools::ps_round(($combination?$combination['price']:$product['price']), 2);
		$offer->currencyId = $this->currency_iso;
		$offer->categoryId = $product['id_category_default'];
		$offer->picture = $this->context->link->getImageLink($product['link_rewrite'], $product['id_image']);
		$offer->name = $product['name'];
		$offer->vendor = $product['manufacturer_name'];
		$offer->vendorCode = ($combination?$combination['reference']:$combination['reference']);
		$offer->description = $product['description'];
		$offer->sales_notes = Configuration::get('yamarket_с_info');
		$offer->barcode = ($combination?$combination['ean13']:$combination['ean13']);
		if (isset($this->yamarket_с_shipping[1]) && $this->yamarket_с_shipping[1])
			$offer->delivery = 'true';
		if (isset($this->yamarket_с_shipping[2]) && $this->yamarket_с_shipping[2])
			$offer->pickup = 'true';
		if (isset($this->yamarket_с_shipping[3]) && $this->yamarket_с_shipping[3])
			$offer->store = 'true';
		$params = array();
		if ($product['features'])
			foreach ($product['features'] as $feature)
				$params[$feature['name']] = $feature['value'];
		if ($combination)
			$params = array_merge($params, $combination['attributes']);
		$offer->param = $params;

		$shop->add($offer);
	}

	public function setCurrency()
	{
		$cookie = $this->context->cookie;
		if (Tools::getValue('id_currency') && is_numeric(Tools::getValue('id_currency')))
		{
			$currency = Currency::getCurrencyInstance(Tools::getValue('id_currency'));
			if (is_object($currency) && $currency->id && !$currency->deleted && $currency->isAssociatedToShop())
				$cookie->id_currency = (int)$currency->id;
		}
		$currency = null;
		if ((int)$cookie->id_currency)
			$currency = Currency::getCurrencyInstance((int)$cookie->id_currency);
		if (!Validate::isLoadedObject($currency) || (bool)$currency->deleted || !(bool)$currency->active)
			$currency = Currency::getCurrencyInstance(Configuration::get('PS_CURRENCY_DEFAULT'));

		$cookie->id_currency = (int)$currency->id;
		$this->context->currency->id = $cookie->id_currency;
		if ($currency->isAssociatedToShop())
			return $currency;
		else
		{
			// get currency from context
			$currency = Shop::getEntityIds('currency', Context::getContext()->shop->id, true, true);
			if (isset($currency[0]) && $currency[0]['id_currency'])
			{
				$cookie->id_currency = $currency[0]['id_currency'];
				return Currency::getCurrencyInstance((int)$cookie->id_currency);
			}
		}

		$this->context->currency->id = $cookie->id_currency;
		return $currency;
	}
}