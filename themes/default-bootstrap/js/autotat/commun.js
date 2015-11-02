jQuery(document).ready(function()
{
	
/*var PAYMENT = document.getElementById("HOOK_PAYMENT");
var registering = document.getElementById("new_account_form");
if (PAYMENT!=undefined)
{
	if (registering!=undefined)
	{
		jQuery('#new_account_form').css('display', 'none');
	}	
}*/


if (jQuery("#slider").owlCarousel!=undefined)
{
  jQuery("#slider").owlCarousel({  
	autoPlay: 6000,
	singleItem : true
 	});
 	
 	

 	
}




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
// jQuery("#views_block ul li a").click(function()
// {
	// return false;
// });

/*if (jQuery("#subcategories")!=undefined && jQuery("#subcategories").length>0)
	{
  		jQuery('.descriptionCategory').css('display', 'none');
  		//alert("LL");
  	}*/
  	
  	if ($("#subcategories")==undefined)
	{
  		jQuery('.descriptionCategory').css('display', 'block');
  		//alert("LL");
  	}
  	
  	//alert("KK");

});//ready-function