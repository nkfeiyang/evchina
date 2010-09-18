// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
function removeParamFromURL(URL, param){
    URL = String(URL);
    var regex = new RegExp("\\?" + param + "=[^&]*&?", "gi");
    URL = URL.replace(regex, '?');
    regex = new RegExp("\\&" + param + "=[^&]*&?", "gi");
    URL = URL.replace(regex, '&');
    URL = URL.replace(/(\?|&)$/, '');
    regex = null;
    return URL;
}

function addParamToURL(URL, param, value){
    URL = removeParamFromURL(URL, param);
    URL = URL + '&' + param + '=' + value
    if (!(/\?/.test(URL))) 
        URL = URL.replace(/&/, '?');
    return URL;
}

/**
 *
 * @param {} sURL 收藏链接地址
 * @param {} sTitle 收藏标题
 */
function AddFavorite(sURL, sTitle){
    try {
        window.external.addFavorite(sURL, sTitle);
    } 
    catch (e) {
        try {
            window.sidebar.addPanel(sTitle, sURL, "");
        } 
        catch (e) {
            alert("加入收藏失败，请使用Ctrl+D进行添加");
        }
    }
}

/**
 *
 * @param {} obj 当前对象，一般是使用this引用。
 * @param {} vrl 主页URL
 */
function SetHome(obj, vrl){
    try {
        obj.style.behavior = 'url(#default#homepage)';
        obj.setHomePage(vrl);
    } 
    catch (e) {
        if (window.netscape) {
            try {
                netscape.security.PrivilegeManager.enablePrivilege("UniversalXPConnect");
            } 
            catch (e) {
                alert("此操作被浏览器拒绝！\n请在浏览器地址栏输入“about:config”并回车\n然后将 [signed.applets.codebase_principal_support]的值设置为'true',双击即可。");
            }
            var prefs = Components.classes['@mozilla.org/preferences-service;1'].getService(Components.interfaces.nsIPrefBranch);
            prefs.setCharPref('browser.startup.homepage', vrl);
        }
    }
}


 function copyToClipboard(txt){
 	if (window.clipboardData) {
 		window.clipboardData.clearData();
 		window.clipboardData.setData("Text", txt);
 	}
 	else 
 		if (navigator.userAgent.indexOf("Opera") != -1) {
 			window.location = txt;
 		}
 		else 
 			if (window.netscape) {
 				try {
 					netscape.security.PrivilegeManager.enablePrivilege("UniversalXPConnect");
 				} 
 				catch (e) {
 					alert("被浏览器拒绝！\n请在浏览器地址栏输入'about:config'并回车\n然后将'signed.applets.codebase_principal_support'设置为'true'");
 				}
 				var clip = Components.classes['@mozilla.org/widget/clipboard;1'].createInstance(Components.interfaces.nsIClipboard);
 				if (!clip) 
 					return;
 				var trans = Components.classes['@mozilla.org/widget/transferable;1'].createInstance(Components.interfaces.nsITransferable);
 				if (!trans) 
 					return;
 				trans.addDataFlavor('text/unicode');
 				var str = new Object();
 				var len = new Object();
 				var str = Components.classes["@mozilla.org/supports-string;1"].createInstance(Components.interfaces.nsISupportsString);
 				var copytext = txt;
 				str.data = copytext;
 				trans.setTransferData("text/unicode", str, copytext.length * 2);
 				var clipid = Components.interfaces.nsIClipboard;
 				if (!clip) 
 					return false;
 				clip.setData(trans, null, clipid.kGlobalClipboard);
 				alert("复制成功！")
 			}
 }     
    

