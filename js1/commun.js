jQuery(document).ready(function()
{

//Кнопка подробнее и др. ссылки
jQuery(".zakaz").click(function()
{
	jQuery('.overlay').fadeIn(500);	
	jQuery(".popup").fadeIn(500);
});
jQuery('.overlay, .popupClose').click(function()
{
	jQuery('.overlay, .popup').css('display', 'none');
		
});

//jQuery("#slider a").click(function()
//{
	//alert("a");
	//return false;
//});
//По картинке вида товара
jQuery("#views_block ul li a").click(function()
{
	return false;
});

});//ready-function