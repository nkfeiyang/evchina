/**
 * @author robin 配置tiny_mce
 */

tinyMCE.init({
	language : "zh",
	mode : "textareas",
	theme : "simple",
	theme_toolbar_location : "top", 
	skin : "default",
	editor_selector : "mceSimple"	
});

tinyMCE.init({
	language : "zh",
	mode : "textareas",
	theme : "advanced",
	theme_advanced_toolbar_location : "top", 
	theme_advanced_toolbar_align : "left",
	theme_advanced_buttons1 : "bold, italic, underline, strikethrough, |, justifyleft, justifycenter, justifyright, justifyfull, fontselect, fontsizeselect, forecolorpicker, backcolorpicker, |, bullist, numlist, |, outdent ,indent, |, preview, |, code  ", 
	theme_advanced_buttons2 : "cut, copy, paste,  emotions, |, undo, redo, |, link, unlink, |, image, media, hr, |, table, |, row_props, cell_props, |, row_before, row_after, delete_row, |, col_before, col_after, delete_col, |, split_cells, merge_cells",
	theme_advanced_buttons3 : "",
	plugins: "preview, advimage, media, table, emotions",
	skin : "default",
	editor_selector : "mceAdvanced"	
});

/*
# Here you can specify default options for TinyMCE across all controllers
#
# plugins:
#  - table
#  - fullscreen
theme: advanced
language: zh
theme_advanced_toolbar_location: top
theme_advanced_toolbar_align: left
theme_advanced_buttons1:
  - formatselect 
  - fontselect 
  - fontsizeselect 
  - forecolor 
  - backcolor 
  - bold 
  - italic 
  - underline 
  - strikethrough 
  - sub 
  - sup 
  - removeformat
theme_advanced_buttons2:
  - undo 
  - redo 
  - cut 
  - copy 
  - paste 
  - separator 
  - justifyleft 
  - justifycenter 
  - justifyright 
  - separator 
  - indent 
  - outdent 
  - separator 
  - bullist 
  - numlist 
  - separator 
  - link 
  - unlink 
  - image 
  - media 
  - emotions 
  - separator 
  - table 
  - separator 
  - fullscreen
theme_advanced_fonts: 
  - 宋体=宋体
  - 黑体=黑体
  - 仿宋=仿宋
  - 楷体=楷体
  - 隶书=隶书
  - 幼圆=幼圆
  - Andale Mono=andale mono
  - Arial=arial
  - Arial Black=arial black
  - Book Antiqua=book antiqua
  - Comic Sans MS=comic sans ms
  - Courier New=courier new
  - Georgia=georgia
  - Helvetica=helvetica
  - Impact=impact
  - Symbol=symbol
  - Tahoma=tahoma
  - Terminal=terminal
  - Times New Roman=times new roman
  - Trebuchet MS=trebuchet ms
  - Verdana=verdana
  - Webdings=webdings
  - Wingdings=wingdings
plugins: 
  - contextmenu 
  - paste 
  - media 
  - emotions 
  - table 
  - fullscreen 
 */