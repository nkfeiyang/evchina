// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
function removeParamFromURL(URL,param)
{
	URL=String(URL);
	var regex=new RegExp("\\?"+param+"=[^&]*&?","gi");
	URL=URL.replace(regex,'?');
	regex=new RegExp("\\&"+param+"=[^&]*&?","gi");
	URL=URL.replace(regex,'&');
	URL=URL.replace(/(\?|&)$/,'');
	regex=null;
	return URL;
}

function addParamToURL(URL,param,value)
{
	URL=removeParamFromURL(URL,param);
	URL=URL+'&'+param+'='+value
	if(!(/\?/.test(URL)))
		URL=URL.replace(/&/,'?');
	return URL;
} 