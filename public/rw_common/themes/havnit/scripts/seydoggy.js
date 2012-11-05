/*/////////////////////////////////////////////////////////////////////////////////////////////////////*/
/* seydoggy.js.min */
/* @group phpjs.include */function include(script_filename) { document.write('<' + 'script'); document.write(' src="' + script_filename + '">'); document.write('</' + 'script' + '>'); }/* @end */
/* @group RwGet */RwGet = { pathto: function(path, file) { var rtrim = function(str, list) { var charlist = !list ? 's\xA0': (list + '').replace(/([\[\]\(\)\.\?\/\*\{\}\+\$\^\:])/g, '$1'); var re = new RegExp('[' + charlist + ']+$', 'g'); return (str + '').replace(re, ''); }; var jspathto = rtrim(RwSet.pathto, "javascript.js"); if ((path !== undefined) && (file !== undefined)) { jspathto = jspathto + path + file; } else if (path !== undefined) { jspathto = jspathto + path; } return jspathto; }, baseurl: function(path, file) { var jsbaseurl = RwSet.baseurl; if ((path !== undefined) && (file !== undefined)) { jsbaseurl = jsbaseurl + path + file; } else if (path !== undefined) { jsbaseurl = jsbaseurl + path; } return jsbaseurl; } };/* @end */
/* @group seydoggySetHeight plugin v1.0.1 06-28-10 13:29 */(function($) { $.fn.seydoggySetHeight = function(value) { var tallest = 0; $(this).each(function(){ if ($(this).outerHeight(true) > tallest) tallest = $(this).outerHeight(true); }); $(this).height(tallest + value); }; })(jQuery);/* @end */
/* @group rwPageOn plugin v1.0.0 05-13-10 14:25 */(function($){ $.fn.rwPageOn = function(){ var i = 0; var rwPage = $(this)[0]; for (i = 0; i <= 10; i++ ) { if ($($(this)[i]).length > 0) { rwPage = $(this)[i]; break; } } return rwPage; }; })(jQuery);/* @end */
/*////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////*/

jQuery.noConflict();
jQuery(document).ready(function($){
	/* @group Havnit theme functions */
	// generate #toolbar_sub on the fly
	if ($('#toolbar_horizontal ul ul').length)
	{
		$('.mainContainer .preContent').addClass('radius0');/* removes rounded corners when bumped down by the toolbar_sub */
		$('#toolbar_sub').prepend($('#toolbar_horizontal > .toolbarList > .currentListItem > .toolbarList, #toolbar_horizontal > .toolbarList > .currentAncestorListItem > .toolbarList').clone()).show();
	}
	// generate #toolbar_vertical on the fly
	if ($('#toolbar_horizontal ul ul ul').length)
	{
		$('#toolbar_vertical').prepend($('#toolbar_horizontal > .toolbarList > .currentAncestorListItem > .toolbarList > .currentListItem > .toolbarList, #toolbar_horizontal > .toolbarList > .currentAncestorListItem > .toolbarList > .currentAncestorListItem > .toolbarList')).show();
	}
	//  hide empty top nav
	$('#toolbar_horizontal').children().parent().show();
	//  hide empty footer
	$('.breadcrumbContainer').parent().show();
	if ($('.footerContent').html() != "")
	{
		$('.footerContainer').show();
	}
	// set width of .preContainer .preContent to .pageHeader
	$('.preContainer .preContent').width($('.pageHeader').outerWidth(true) - 74);
	// additional breadcrumb seprator styling
	$('.breadcrumbList').append('/');
	$('.breadcrumbList li:last').css('margin','0 5px');
	$('.breadcrumbList li a:last').css('margin','0 5px');
	// no margin/padding on last blog entry
	$('.blog-entry:last').css({'margin':'0','padding':'0'});
	// set height of File Sharing blocks to be the same
	$('.filesharing-item').seydoggySetHeight(0);
	// set width of File Sharing blocks according to available space
	$('.filesharing-item').width($('.mainContent').outerWidth(true) / 3 - 45);
	// set height .mainContent to that of .sidebarContent if shorter
	if ($('.sidebarContent').css('display') != 'none')
	{
		$('.mainContent').css('min-height',$('.sidebarContent').outerHeight(true));
	}
	// set top margin for #toolbar_horizontal
	$('#toolbar_horizontal').css('margin-top',($('.siteHeader').outerHeight(true) - $('#toolbar_horizontal').outerHeight(true)) / 2);
	// set top margin for .siteHeader .title
	$('.siteHeader .title').css('margin-top',($('.siteHeader').outerHeight(true) - $('.siteHeader .title').outerHeight(true)) / 2);
	// set top margin for .logo img
	$('.logo img').css('margin-top',($('.siteHeader').outerHeight(true) - $('.logo img').outerHeight(true)) / 2)
	/* ExtraContent (jQuery) VERSION: r1.4.2 */
	var extraContent =  (function() {
		// change ecValue to suit your theme
		var ecValue = 4;
		for (i=1;i<=ecValue;i++)
		{
			$('#myExtraContent'+i+' script').remove();
			$('#myExtraContent'+i).appendTo('#extraContainer'+i).show();
		}
	})();
	
	// hide empty ExtraContent areas
	$('#myExtraContent1').each(function(){
		$('.preContainer .preContent').show();
	});
	$('#myExtraContent2').each(function(){
		$('.mainContainer .preContent').show();
	});
	$('#myExtraContent3').each(function(){
		$('.mainContainer .postContent').show();
	});
	$('#myExtraContent4').each(function(){
		$('.postContainer').show();
	});
		
	// if header height variable set .pageHeader/.seydoggySlideshow height to content height
	// test if varaible header is selected
	if (typeof headerHeightVariable != "undefined") {
		ecTallest = 0;
		$('#extraContainer1 div').each(function() {
			if ($(this).outerHeight(true) > ecTallest) ecTallest = $(this).outerHeight(true);
		});
		$('.seydoggySlideshow,.pageHeader').height(ecTallest + 60);
	}
	/* @end */
});
// test to see if user has selected a slideshow option
if(typeof slideshowEnabled != "undefined") {
	include(RwGet.pathto('scripts/slideshow/seydoggy.slideshow.js'));
}