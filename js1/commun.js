jQuery(document).ready(function()
{

//������ ��������� � ��. ������
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
//�� �������� ���� ������
jQuery("#views_block ul li a").click(function()
{
	return false;
});

});//ready-function