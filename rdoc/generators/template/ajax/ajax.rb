module RDoc
module Page

def self.title 
  # Get full path of running rdoc dir
  pwd = File.expand_path($LOAD_PATH.last)

  # Name of the running rdoc dir
  str = pwd.split("/").last

  # " -_ aa _- bb _- cc -_" => "Aa Bb Cc"
  str.gsub!(/[-_]/," ")
  str.strip!
  str.split(/ +/).map { |e| e.capitalize }.join(" ")
end

STYLE = <<CSS

html, body{
	background-color: #f0f0f0;
	padding:10px 0px 0px 5px;
	margin: 0px;
	font-family: helvetica;
	/*font-family: "Bitstream Vera Sans", Verdana, Arial, Helvetica, sans-serif; */
	font-size: 14px;
}

td, p {
  font-family: "Bitstream Vera Sans", Verdana, Arial, Helvetica, sans-serif;
  background: #FFF;
  color: #000;
  margin: 0px;
  font-size: small;
}

#floater{
    position: absolute;
    top: 5px;
    right: 5px;
}

/*holds the whole searching/drill down stuff */
#listFrame{
	float:left;
	padding: 2px;
	width: 350px;
	background-color: #bbf;
	border: 1px solid #999;
	
}

#browserBar{
	height: 25px;
	padding:11px 0px 0px 0px;
	margin:0px;
	background-color: #d0d0d0;	
	border-top: 1px solid #999;
	color: #005;
}

#browserBar a{
	text-decoration: none;
}

.button{
	text-decoration: none;
	padding:3px 8px 3px 8px;
	border: 1px solid #66a;
	background-color: #ccf;
	color: #66a;
}

.buttonInactive{
	text-decoration: none;
	padding:3px 8px 3px 8px;
	border: 1px solid #999;
	background-color: #ccc;
	color: #999;
}

.miniButton{
	text-decoration: none;
	padding:3px 2px 3px 2px;
	border: 1px solid #66a;
	background-color: #ccf;
	color: #66a;
}

.miniButtonInactive{
	text-decoration: none;
	padding:3px 2px 3px 2px;
	border: 1px solid #999;
	background-color: #ccc;
	color: #999;
}

#blowOutListBox{
	position: absolute;
	top: 63px;
	left: 399px;
	border: 1px solid #999;
	padding: 0px;
	margin: 0px;
	z-index: 1000;
	background-color: #ccf;
	color: #66a;
}

#blowOutListBox ul{
	list-style-type:none;
	padding: 0px;
	margin: 0px;
}

#blowOutListBox ul li{
	padding: 3px;
	margin: 0px;
	line-height: 1em;
	
}

#blowOutListBox ul li a{
	text-decoration: none;
	padding: 3px;
}
#blowOutListBox ul li a:hover{
	background-color: #ddf;
}

/*holds the content for browsing etc... also is the target of method/class/file name clicks */
#rdocContent{
	height: 600px;
	background-color: #fff;
	border: 1px solid #999;
	border-left: 0px;
	padding:5px;
	overflow: auto;
}

/*the grouping for methods,files,class,all... i.e. the tabs */
ul#groupType{
	list-style-type: none;
	padding: 0px;
	padding-left: 5px;
	margin: 0px;
}

ul#groupType li{
	display:inline;
	padding: 5px 5px 0px 5px;
	border: 1px solid #999;
	border-bottom: 0px;
	cursor: pointer;
}

ul#groupType li#loadingStatus{
	margin: 3px;
	border: 0px;
	padding: 3px 3px 6px 3px;
	color: #666;
}

ul#groupType li.activeLi{
	background-color: #bbf;
	padding-bottom: 1px;
}

#listSearch{
	height: 25px;
	padding: 3px;
}

#listSearch input[type=text]{
	width: 340px;
	font-size: 1.2em;
}

#listScroller{
	width: 342px;
	height: 700px;
	margin: 3px;
	background-color: #fcfcfc;
	border: 1px solid #999;
	overflow: auto;
}

#listScroller ul{
	width: 600px;
	padding:0px;
	margin:0px;
	list-style: none;
}

#listScroller li{
	padding: 0px;
	margin: 0px;
	display: block;
	line-height: 1.1em;
}

#listScroller a{
    text-decoration: none;
	padding: 0px 1px 1px 1px;
	margin: 3px;
	font-weight: bold;
}

#listScroller a:hover{
	background-color: #ccf;
}

.activeA {
	background-color: #ffa;
	border: 1px solid #ccc;
	padding: 0px 1px 1px 1px; 
}

#listScroller small{
	color: #999;
}

.activeTitle{
  font-family: monospace;
  font-size: large;
  border-bottom: 1px dashed black;
  margin-bottom: 0.3em;
  padding-bottom: 0.1em;
  background-color: #ffc;
}

.activeMethod{
  margin-left: 1em;
  margin-right: 1em;
  margin-bottom: 1em;
}


.activeMethod .title {
  font-family: monospace;
  font-size: large;
  border-bottom: 1px dashed black;
  margin-bottom: 0.3em;
  padding-bottom: 0.1em;
  background-color: #ffa;
}

.activeMethod .description, .activeMethod .sourcecode {
  margin-left: 1em;
}

.activeMethod .sourcecode p.source-link {
  text-indent: 0em;
  margin-top: 0.5em;
}

.activeMethod .aka {
  margin-top: 0.3em;
  margin-left: 1em;
  font-style: italic;
  text-indent: 2em;
}

#content {
  margin: 0.5em;
}

#description p {
  margin-bottom: 0.5em;
}

.sectiontitle {
  margin-top: 1em;
  margin-bottom: 1em;
  padding: 0.5em;
  padding-left: 2em;
  background: #005;
  color: #FFF;
  font-weight: bold;
  border: 1px dotted black;
}

.attr-rw {
  padding-left: 1em;
  padding-right: 1em;
  text-align: center;
  color: #055;
}

.attr-name {
  font-weight: bold;
}

.attr-desc {
}

.attr-value {
  font-family: monospace;
}

.file-title-prefix {
  font-size: large;
}

.file-title {
  font-size: large;
  font-weight: bold;
  background: #005;
  color: #FFF;
}

.banner {
  background: #005;
  color: #FFF;
  border: 1px solid black;
  padding: 1em;
}

.banner td {
  background: transparent;
  color: #FFF;
}

h1 a, h2 a, .sectiontitle a, .banner a {
  color: #FF0;
}

h1 a:hover, h2 a:hover, .sectiontitle a:hover, .banner a:hover {
  color: #FF7;
}

.dyn-source {
  display: none;
  color: #000;
  border: 0px;
  border-left: 1px dotted black;
  border-top: 1px dotted black;
  margin: 0em;
  padding: 0em;
}

.dyn-source .cmt {
  color: #00F;
  font-style: italic;
}

.dyn-source .kw {
  color: #070;
  font-weight: bold;
}

.method {
  margin-left: 1em;
  margin-right: 1em;
  margin-bottom: 1em;
}

.description pre {
  padding: 0.5em;
  border: 1px dotted black;
  background: #FFE;
}

.method .title {
  font-family: monospace;
  font-size: large;
  border-bottom: 1px dashed black;
  margin: 0.3em;
  padding: 0.2em;
}

.method .description, .method .sourcecode {
  margin-left: 1em;
}

.description p, .sourcecode p {
  margin-bottom: 0.5em;
}

.method .sourcecode p.source-link {
  text-indent: 0em;
  margin-top: 0.5em;
}

.method .aka {
  margin-top: 0.3em;
  margin-left: 1em;
  font-style: italic;
  text-indent: 2em;
}

h1 {
  padding: 1em;
  border: 1px solid black;
  font-size: x-large;
  font-weight: bold;
  color: #FFF;
  background: #007;
}

h2 {
  padding: 0.5em 1em 0.5em 1em;
  border: 1px solid black;
  font-size: large;
  font-weight: bold;
  color: #FFF;
  background: #009;
}

h3, h4, h5, h6 {
  padding: 0.2em 1em 0.2em 1em;
  border: 1px dashed black;
  color: #000;
  background: #AAF;
}

.sourcecode > pre {
  padding: 0px;
  margin: 0px;
  border: 1px dotted black;
  background: #FFE;
}
CSS


###################################################################

CLASS_PAGE = <<HTML
<div id="%class_seq%">
<div class='banner'>
  <span class="file-title-prefix">%classmod%</span><br />%full_name%<br/>
  In:
START:infiles
<a href="#" onclick="jsHref('%full_path_url%');">%full_path%</a>
END:infiles

IF:parent
Parent:&nbsp;
IF:par_url
        <a href="#" onclick="jsHref('%par_url%');">
ENDIF:par_url
%parent%
IF:par_url
         </a>
ENDIF:par_url
ENDIF:parent
</div>
HTML

###################################################################

METHOD_LIST = <<HTML
  <div id="content">
IF:diagram
  <table cellpadding='0' cellspacing='0' border='0' width="100%"><tr><td align="center">
    %diagram%
  </td></tr></table>
ENDIF:diagram

IF:description
  <div class="description">%description%</div>
ENDIF:description

IF:requires
  <div class="sectiontitle">Required Files</div>
  <ul>
START:requires
  <li><a href="#" onclick="jsHref('%href%');">%name%</a></li>
END:requires
  </ul>
ENDIF:requires

IF:toc
  <div class="sectiontitle">Contents</div>
  <ul>
START:toc
  <li><a href="#" onclick="jsHref('%href%');">%secname%</a></li>
END:toc
  </ul>
ENDIF:toc

IF:methods
  <div class="sectiontitle">Methods</div>
  <ul>
START:methods
  <li><a href="index.html?a=%aref%&name=%name%" >%name%</a></li>
END:methods
  </ul>
ENDIF:methods

IF:includes
<div class="sectiontitle">Included Modules</div>
<ul>
START:includes
  <li><a href="#" onclick="jsHref('%href%');">%name%</a></li>
END:includes
</ul>
ENDIF:includes

START:sections
IF:sectitle
<div class="sectiontitle"><a href="%secsequence%">%sectitle%</a></div>
IF:seccomment
<div class="description">
%seccomment%
</div>
ENDIF:seccomment
ENDIF:sectitle

IF:classlist
  <div class="sectiontitle">Classes and Modules</div>
  %classlist%
ENDIF:classlist

IF:constants
  <div class="sectiontitle">Constants</div>
  <table border='0' cellpadding='5'>
START:constants
  <tr valign='top'>
    <td class="attr-name">%name%</td>
    <td>=</td>
    <td class="attr-value">%value%</td>
  </tr>
IF:desc
  <tr valign='top'>
    <td>&nbsp;</td>
    <td colspan="2" class="attr-desc">%desc%</td>
  </tr>
ENDIF:desc
END:constants
  </table>
ENDIF:constants

IF:attributes
  <div class="sectiontitle">Attributes</div>
  <table border='0' cellpadding='5'>
START:attributes
  <tr valign='top'>
    <td class='attr-rw'>
IF:rw
[%rw%]
ENDIF:rw
    </td>
    <td class='attr-name'>%name%</td>
    <td class='attr-desc'>%a_desc%</td>
  </tr>
END:attributes
  </table>
ENDIF:attributes

IF:method_list
START:method_list
IF:methods
<div class="sectiontitle">%type% %category% methods</div>
START:methods
<div id="%m_seq%" class="method">
  <div id="%m_seq%_title" class="title">
IF:callseq
    <b>%callseq%</b>
ENDIF:callseq
IFNOT:callseq
    <b>%name%</b>%params%
ENDIF:callseq
IF:codeurl
[ <a href="javascript:openCode('%codeurl%')">source</a> ]
ENDIF:codeurl
  </div>
IF:m_desc
  <div class="description">
  %m_desc%
  </div>
ENDIF:m_desc
IF:aka
<div class="aka">
  This method is also aliased as
START:aka
  <a href="index.html?a=%aref%&name=%name%">%name%</a>
END:aka
</div>
ENDIF:aka
IF:sourcecode
<div class="sourcecode">
  <p class="source-link">[ <a href="javascript:toggleSource('%aref%_source')" id="l_%aref%_source">show source</a> ]</p>
  <div id="%aref%_source" class="dyn-source">
<pre>
%sourcecode%
</pre>
  </div>
</div>
ENDIF:sourcecode
</div>
END:methods
ENDIF:methods
END:method_list
ENDIF:method_list
END:sections
</div>
HTML


BODY = <<ENDBODY
  !INCLUDE! <!-- banner header -->

  <div id="bodyContent" >
    #{METHOD_LIST}
  </div>

ENDBODY



SRC_BODY = <<ENDSRCBODY
  !INCLUDE! <!-- banner header -->

  <div id="bodyContent" >
    <h2>Source Code</h2>
    <pre>%file_source_code%</pre>
    </div>
ENDSRCBODY


###################### File Page ##########################
FILE_PAGE = <<HTML
<div id="fileHeader">
    <h1>%short_name%</h1>
    <table class="header-table">
    <tr class="top-aligned-row">
      <td><strong>Path:</strong></td>
      <td>%full_path%</td>
    </tr>
    <tr class="top-aligned-row">
      <td><strong>Last Update:</strong></td>
      <td>%dtm_modified%</td>
    </tr>
    </table>
  </div>
HTML


#### This is not used but kept for historical purposes
########################## Source code ########################## 
# Separate page only

SRC_PAGE = <<HTML
<html>
<head><title>%title%</title>
<meta http-equiv="Content-Type" content="text/html; charset=%charset%">
<style>
.ruby-comment    { color: green; font-style: italic }
.ruby-constant   { color: #4433aa; font-weight: bold; }
.ruby-identifier { color: #222222;  }
.ruby-ivar       { color: #2233dd; }
.ruby-keyword    { color: #3333FF; font-weight: bold }
.ruby-node       { color: #777777; }
.ruby-operator   { color: #111111;  }
.ruby-regexp     { color: #662222; }
.ruby-value      { color: #662222; font-style: italic }
  .kw { color: #3333FF; font-weight: bold }
  .cmt { color: green; font-style: italic }
  .str { color: #662222; font-style: italic }
  .re  { color: #662222; }
</style>
</head>
<body bgcolor="white">
<pre>%code%</pre>
</body>
</html>
HTML

########################### source page body ###################

SCR_CODE_BODY = <<HTML
    <div id="source">
    %source_code%
    </div>

HTML

########################## Index ################################

FR_INDEX_BODY = <<HTML
!INCLUDE!
HTML

FILE_INDEX = <<HTML
<ul>
START:entries
<li><a id="%seq_id%_link" href="index.html?a=%seq_id%&name=%name%" onclick="loadIndexContent('%href%','%seq_id%','%name%', '%scope%');">%name%</a><small>%scope%</small></li>
END:entries
</ul>
HTML

CLASS_INDEX = FILE_INDEX
METHOD_INDEX = FILE_INDEX

INDEX = <<HTML
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
	"http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <meta name="description" content="A nifty way to interact with the Ruby API" />
 	<meta name="author" content="created by Brian Chamberlain. You can contact me using 'blchamberlain' on the gmail." />
	<meta name="keywords" content="ruby, doc" />
	<title>#{title} API</title>
	<link rel="stylesheet" href="rdoc-style.css" type="text/css" media="screen" />    
	<script type="text/javascript" src="prototype.js" ></script>
	<script type="text/javascript" src="api_grease.js" ></script>
</head>
<body onload="setupPage();">
<ul id="groupType">
	<li>methods</li>
	<li>classes</li>
	<li>files</li>
	<li id="loadingStatus" style="display:none;">	loading...</li>
</ul>	
<div id="listFrame">
	<div id="listSearch">
		<form id="searchForm" method="get" action="#" onsubmit="return false">
			<input type="text" name="searchText" id="searchTextField" size="30" autocomplete="off" />
	 	</form>
	</div>
	<div id="listScroller">
	    Loading via ajax... this could take a sec.
	</div>	
</div>
<div id="browserBar">
	&nbsp;&nbsp;&nbsp;<span id="browserBarInfo">README</span>
</div>
<div id="rdocContent">
&nbsp;
</div>
<div id="floater">
<strong>#{title} </strong><a href="#" onmouseover="$('tips').show();" onmouseout="$('tips').hide();">usage tips</a>
<div id="tips" style="position:absolute;width:350px;top:15px;right:20px;padding:5px;border:1px solid #333;background-color:#fafafa;display:none;">
	<p><strong>Some tips</strong> 
		<ul>
			<li> Up/Down keys move through the search list</li>
			<li> Return/enter key loads selected item</li>
		</ul>
	</p>
</div>
<div id="blowOutListBox" style="display:none;">&nbsp;</div>
</body>
</html>
HTML

API_GREASE_JS = <<API_GREASE_START

function setupPage(){
	hookUpActiveSearch();
	hookUpTabs();
	suppressPostbacks();
	var url_params = getUrlParams();
	if (url_params != null){
		loadUrlParams(url_params);
	}else{
		loadDefaults();
	}
	resizeDivs();
	window.onresize = function(){  resizeDivs(); };
}

function getUrlParams(){
	var window_location = window.location.href
	var param_pos = window_location.search(/\\?/)
	if (param_pos > 0){
		return(window_location.slice(param_pos, window_location.length));
	}else{
		return(null);
	}
}

function loadUrlParams(url_param){
	//get the tabs
	var t = getTabs();
	// now find our variables
	var s_params = /(\\?)(a=.+?)(&)(name=.*)/;
	var results = url_param.match(s_params);
	url_anchor = results[2].replace(/a=/,'');

	if (url_anchor.match(/M.+/)){//load the methods tab and scroller content
		setActiveTabAndLoadContent(t[0]);
	}else{
		if(url_anchor.match(/C.+/)){ //load the classes tab and scroller content
			setActiveTabAndLoadContent(t[1]);
		}else{
			if (url_anchor.match(/F.+/)){//load the files tab
				setActiveTabAndLoadContent(t[2]);
			}else{
				// default to loading the methods
				setActiveTabAndLoadContent(t[0]);
			}
		}
	}
	paramLoadOfContentAnchor(url_anchor + "_link");
}

function updateUrlParams(anchor_id, name){
	//Also setting the page title
	//window.document.title = name + " method - RailsBrain.com ";
	
	//updating the window location
	var current_href = window.location.href;
	//var m_name = name.replace("?","?");
	var rep_str = ".html?a=" + anchor_id + "&name=" + name;
	var new_href = current_href.replace(/\\.html.*/, rep_str);
	if (new_href != current_href){
		window.location.href = new_href;
	}
}

//does as it says...
function hookUpActiveSearch(){
	
	var s_field = $('searchForm').getInputs('text')[0];
	//var s_field = document.forms[0].searchText;
	Event.observe(s_field, 'keydown', function(event) {
		var el = Event.element(event);
		var key = event.which || event.keyCode;
		
		switch (key) {
			case Event.KEY_RETURN:
				forceLoadOfContentAnchor(getCurrentAnchor());
				Event.stop(event);
			break;
			
			case Event.KEY_UP:
				scrollListToElementOffset(getCurrentAnchor(),-1);
			break;
			
			case Event.KEY_DOWN:
				scrollListToElementOffset(getCurrentAnchor(),1);
			break;
			
			default:
			break;
		}

	});
	
	Event.observe(s_field, 'keyup', function(event) {
		var el = Event.element(event);
		var key = event.which || event.keyCode;
		switch (key) {
			case Event.KEY_RETURN:
				Event.stop(event);
			break;
			
			case Event.KEY_UP:
			break;
			
			case Event.KEY_DOWN:
			break;
			
			default:
				scrollToName(el.value);
				setSavedSearch(getCurrentTab(), el.value);
			break;
		}
		
	});
	
	Event.observe(s_field, 'keypress', function(event){
		var el = Event.element(event);
		var key = event.which || event.keyCode;
		switch (key) {
			case Event.KEY_RETURN:
				Event.stop(event);
			break;
			
			default:
			break;
		}
		
	});
	
	//Event.observe(document, 'keypress', function(event){
	//	var key = event.which || event.keyCode;
	//	if (key == Event.KEY_TAB){
	//		cycleNextTab();
	//		Event.stop(event);
	//	}
	//});
}

function hookUpTabs(){
	
	var tabs = getTabs();
	for(x=0; x < tabs.length; x++)
	{
		Event.observe(tabs[x], 'click', function(event){
			    var el = Event.element(event);
         		setActiveTabAndLoadContent(el);
			});
		//tabs[x].onclick = function (){ return setActiveTabAndLoadContent(this);};	 //the prototype guys say this is bad..
	}

}

function suppressPostbacks(){
	Event.observe('searchForm', 'submit', function(event){
		Event.stop(event);
	});
}

function loadDefaults(){
	var t = getTabs();
	setActiveTabAndLoadContent(t[0]); //default loading of the first tab
	loadContent('files/README_rb.html', "");	
}

function resizeDivs(){
	var inner_height = 700; 
	if (window.innerHeight){
		inner_height = window.innerHeight; //all browsers except IE use this to determine the space available inside a window. Thank you Microsoft!!
	}else{
		if(document.documentElement.clientHeight > 0){ //IE uses this in 'strict' mode
		inner_height = document.documentElement.clientHeight;
		}else{
			inner_height = document.body.clientHeight; //IE uses this in 'quirks' mode 
		}
	}
	$('rdocContent').style.height = (inner_height - 92) + "px";//Thankfully all browsers can agree on how to set the height of a div
	$('listScroller').style.height = (inner_height - 88) + "px";
}

//The main function for handling clicks on the tabs
function setActiveTabAndLoadContent(current_tab){
	changeLoadingStatus("on");
	var tab_string = String(current_tab.innerHTML).strip(); //thank you ProtoType!
	switch (tab_string){
		case "classes":
			setCurrentTab("classes");
		    loadScrollerContent('fr_class_index.html');
			setSearchFieldValue(getSavedSearch("classes"));
			scrollToName(getSavedSearch("classes"));
			setSearchFocus();
			break;
		
		case "files":
			setCurrentTab("files");
		    loadScrollerContent('fr_file_index.html');
			setSearchFieldValue(getSavedSearch("files"));
			scrollToName(getSavedSearch("files"));
			setSearchFocus();
			break;
			
		case "methods":
			setCurrentTab("methods");
			loadScrollerContent('fr_method_index.html');
			setSearchFieldValue(getSavedSearch("methods"));
			scrollToName(getSavedSearch("methods"));
			setSearchFocus();
			break;
		
		default:
			break;
	}
	changeLoadingStatus("off");
}

function cycleNextTab(){
	var currentT = getCurrentTab();
	var tabs = getTabs();
	if (currentT == "methods"){
		setActiveTabAndLoadContent(tabs[1]);
		setSearchFocus();
	}else{
		if (currentT == "classes"){
			setActiveTabAndLoadContent(tabs[2]);
			setSearchFocus();
		}else{
			if (currentT == "files"){
				setActiveTabAndLoadContent(tabs[0]);
				setSearchFocus();
			}
		}
	}
}

function getTabs(){
	return($('groupType').getElementsByTagName('li'));
}

var Active_Tab = "";
function getCurrentTab(){
	return Active_Tab;
}

function setCurrentTab(tab_name){
	var tabs = getTabs();
	for(x=0; x < tabs.length; x++)
	{
		if(tabs[x].innerHTML.strip() == tab_name) //W00t!!! String.prototype.strip!
		{
			tabs[x].className = "activeLi";
			Active_Tab = tab_name;
		}
		else
		{
			tabs[x].className = "";
		}
	}
}

//These globals should not be used globally (hence the getters and setters)
var File_Search = "";
var Method_Search = "";
var Class_Search = "";
function setSavedSearch(tab_name, s_val){
	switch(tab_name){
		case "methods":
			Method_Search = s_val;
			break;
		case "files":
			File_Search = s_val;
			break;
		case "classes":
			Class_Search = s_val;
			break;
	}
}

function getSavedSearch(tab_name){
	switch(tab_name){
		case "methods":
			return (Method_Search);
			break;
		case "files":
			return (File_Search);
			break;
		case "classes":
			return (Class_Search);
			break;
	}
}

//These globals handle the history stack


function setListScrollerContent(s){
	
	$('listScroller').innerHTML = s;
	QSAddition.buildCache();
}

function setMainContent(s){
	
	$('rdocContent').innerHTML = s;
}

function setSearchFieldValue(s){
	
	document.forms[0].searchText.value = s;
}

function getSearchFieldValue(){
	
	return Form.Element.getValue('searchText');
}

function setSearchFocus(){
	
	document.forms[0].searchText.focus();
}

var Anchor_ID_Of_Current = null; // holds the last highlighted anchor tag in the scroll lsit
function getCurrentAnchor(){
	return(Anchor_ID_Of_Current);
}

function setCurrentAnchor(a_id){
	Anchor_ID_Of_Current = a_id;
}

//var Index_Of_Current = 0; //holds the last highlighted index
//function getCurrentIndex(){
//	return (Index_Of_Current);
//}

//function setCurrentIndex(new_i){
//	Index_Of_Current = new_i;
//}

function loadScrollerContent(url){

	var scrollerHtml = new Ajax.Request(url, {
	  asynchronous: false,
	  method: 'get',
	  onComplete: function(method_data) {
	   	setListScrollerContent(method_data.responseText);
	  }
	});

}

//called primarily from the links inside the scroller list
//loads the main page div then jumps to the anchor/element with id
function loadContent(url, anchor_id){
	
	var mainHtml = new Ajax.Request(url, {
	 method: 'get',
	  onLoading: changeLoadingStatus("on"),
	  onSuccess: function(method_data) {
	   	setMainContent(method_data.responseText);},
	  onComplete: function(request) {
			changeLoadingStatus("off");
			new jumpToAnchor(anchor_id);
		}
	});
}

//An alternative function that also will stuff the index history for methods, files, classes
function loadIndexContent(url, anchor_id, name, scope)
{
	if (From_URL_Param == true){
		var mainHtml = new Ajax.Request(url, {
			method: 'get',
			onLoading: changeLoadingStatus("on"),
			onSuccess: function(method_data) {
				setMainContent(method_data.responseText);},
				onComplete: function(request) {
					changeLoadingStatus("off");
					updateBrowserBar(name, anchor_id, scope);
					new jumpToAnchor(anchor_id);}
			});
		From_URL_Param = false;
	}else{
		updateUrlParams(anchor_id, name);
	}

}

function updateBrowserBar(name, anchor_id, scope){
	if (getCurrentTab() == "methods"){
		$('browserBarInfo').update("<small>class/module:</small>&nbsp;<a href=\\"#\\" onclick=\\"jumpToTop();\\">" + scope + "</a>&nbsp;&nbsp;<small>method:</small>&nbsp;<strong><a href=\\"#\\" onclick=\\"jumpToAnchor('"+ anchor_id +"')\\">" + name + "</a></strong> ");
	}else{ if(getCurrentTab() == "classes"){
			$('browserBarInfo').update("<small>class/module:</small>&nbsp;<a href=\\"#\\" onclick=\\"jumpToTop();\\">" + scope + "::" + name + "</strong> ");
		}else{
			$('browserBarInfo').update("<small>file:</small>&nbsp;<a href=\\"#\\" onclick=\\"jumpToTop();\\">" + scope + "/" + name + "</strong> ");
		}
	}
}


// Force loads the contents of the index of the current scroller list. It does this by
// pulling the onclick method out and executing it manually.
function forceLoadOfContent(index_to_load){
	var scroller = $('listScroller');
	var a_array = scroller.getElementsByTagName('a');
	if ((index_to_load >= 0) && (index_to_load < a_array.length)){
		var load_element = a_array[index_to_load];
		var el_text = load_element.innerHTML.strip();
		setSearchFieldValue(el_text);
		setSavedSearch(getCurrentTab(), el_text);
		eval("new " + load_element.onclick);
	}
}

function forceLoadOfContentAnchor(anchor_id){
	
	var load_element = $(anchor_id);
	if (load_element != null){
		var el_text = load_element.innerHTML.strip();
		setSearchFieldValue(el_text);
		scrollToAnchor(anchor_id);
		setSavedSearch(getCurrentTab(), el_text);
		eval("new " + load_element.onclick);
	}
}

var From_URL_Param = false;
function paramLoadOfContentAnchor(anchor_id){
	From_URL_Param = true;
	forceLoadOfContentAnchor(anchor_id);
}

//this handles the up/down keystrokes to move the selection of items in the list
function scrollListToElementOffset(anchor_id, offset){
	var scroller = $('listScroller');
	var a_array = scroller.getElementsByTagName('a');
	var current_index = findIndexOfAnchor(a_array, anchor_id);
	if ((current_index >= 0) && (current_index < a_array.length)){
		scrollListToAnchor(a_array[current_index + offset].id);
		setListActiveAnchor(a_array[current_index + offset].id);
	}
}

function findIndexOfAnchor(a_array, anchor_id){
	var found=false;
	var counter = 0;
	while(!found && counter < a_array.length){
		if (a_array[counter].id == anchor_id){
			found = true;
		}else{
			counter +=1;
		}
	}
	return(counter);
}

// This function was written by Rick DeNatale http://talklikeaduck.denhaven2.com/
// THANKS RICK! This is a great suggestion
RegExp.escape = function(text) {
  if (!arguments.callee.sRE) {
    var specials = ['/', '.', '*', '+', '?', '|','(', ')', '[', ']', '{', '}', '\\'' ];
    arguments.callee.sRE = new RegExp('(\\'' + specials.join('|\\'') + ')', 'g');
  }
  return text.replace(arguments.callee.sRE, '\\$1');
}

function scrollToName(searcher_name){

	var scroller = $('listScroller');
	var a_array = scroller.getElementsByTagName('a');
	
	if (!searcher_name.match(new RegExp(/\s+/))){ //if searcher name is blank
		
		//var searcher_pattern = new RegExp("^"+searcher_name, "i"); //the "i" is for case INsensitive
		var searcher_pattern = new RegExp("^"+RegExp.escape(searcher_name.escapeHTML()), "i"); //the "i" is for case INsensitive
    
		var found_index = -1;

		var found = false;
		var x = 0;
		while(!found && x < a_array.length){
			if(a_array[x].innerHTML.match(searcher_pattern)){
				found = true;
				found_index = x;
			}
			else{
				x++;
			}
		}

		// // an attempt at binary searching... have not given up on this yet...
		//found_index = binSearcher(searcher_pattern, a_array, 0, a_array.length);

		if ((found_index >= 0) && (found_index < a_array.length)) {
			scrollListToAnchor(a_array[found_index].id);//scroll to the item
			setListActiveAnchor(a_array[found_index].id);//highlight the item
		} else {
			var result = QSAddition.searchCache(searcher_name);
			if (result) {
			  if (window.console && window.console.log) { console.log('searching with qs'); }
				scrollListToAnchor(result);
				setListActiveAnchor(result);
			}
		}
	}else{ //since searcher name is blank 
		//scrollListToIndex(a_array, 0);//scroll to the item
		//setListActiveItem(a_array, 0);//highlight the item
	}
}

function scrollToAnchor(anchor_id){
	var scroller = $('listScroller');
	if ($(anchor_id) != null){
		scrollListToAnchor(anchor_id);
		setListActiveAnchor(anchor_id);
	}
}

function getY(element){
	
	var y = 0;
	for( var e = element; e; e = e.offsetParent)//iterate the offset Parents
	{
		y += e.offsetTop; //add up the offsetTop values
	}
	//for( e = element.parentNode; e && e != document.body; e = e.parentNode)
	//	if (e.scrollTop) y -= e.scrollTop; //subtract scrollbar values
	return y;
}

//function setListActiveItem(item_array, active_index){
//	
//	item_array[getCurrentIndex()].className = "";
//	setCurrentIndex(active_index);
//	item_array[getCurrentIndex()].className = "activeA"; //setting the active class name
//}

function setListActiveAnchor(active_anchor){
	if ((getCurrentAnchor() != null) && ($(getCurrentAnchor()) != null)){
		$(getCurrentAnchor()).className = "";
	}
	setCurrentAnchor(active_anchor);
	$(getCurrentAnchor()).className = "activeA";
	
}

//handles the scrolling of the list and setting of the current index
//function scrollListToIndex(a_array, scroll_index){
//	if (scroll_index > 0){
//	    var scroller = $('listScroller');
//		scroller.scrollTop = getY(a_array[scroll_index]) - 120; //the -120 is what keeps it from going to the top...
//	}
//}

function scrollListToAnchor(scroll2_anchor){
	var scroller = $('listScroller');
	scroller.scrollTop = getY($(scroll2_anchor)) - 120;
}

function jumpToAnchor(anchor_id){

	var contentScroller = $('rdocContent');
	var a_div = $(anchor_id);
	contentScroller.scrollTop = getY(a_div) - 80; //80 is the offset to adjust scroll point
	var a_title = $(anchor_id + "_title");
	a_title.style.backgroundColor = "#ffc";
	a_title.style.border = "1px solid #ccc";

	//other attempts
	//a_div.className = "activeMethod"; //setting the active class name
	//a_div.style.backgroundColor = "#ffc";
	//var titles = a_div.getElementsByClassName("title");
	//titles[0].className = "activeTitle";

}

function jumpToTop(){
	$('rdocContent').scrollTop = 0;
}

function changeLoadingStatus(status){
	if (status == "on"){
		$('loadingStatus').show();
	}
	else{
		$('loadingStatus').hide();
	}
}

//************* Misc functions (mostly from the old rdocs) ***********************
//snagged code from the old templating system
function toggleSource( id ){
	
         var elem
         var link

         if( document.getElementById )
         {
           elem = document.getElementById( id )
           link = document.getElementById( "l_" + id )
         }
         else if ( document.all )
         {
           elem = eval( "document.all." + id )
           link = eval( "document.all.l_" + id )
         }
         else
           return false;

         if( elem.style.display == "block" )
         {
           elem.style.display = "none"
           link.innerHTML = "show source"
         }
         else
         {
           elem.style.display = "block"
           link.innerHTML = "hide source"
         }
}

function openCode( url ){
     window.open( url, "SOURCE_CODE", "width=400,height=400,scrollbars=yes" )
}	

//this function handles the ajax calling and afterits loaded the jumping to the anchor...
function jsHref(url){
	//alert(url);
    var mainHtml = new Ajax.Request(url, {
	  method: 'get',
	  onSuccess: function(method_data) {
	   	setMainContent(method_data.responseText);}
		});
}

//function comparePatterns(string, regexp){
//	var direction = 0;
//	
//	
//	return (direction)
//}

////returns the index of the element 
//function binSearcher(regexp_pattern, list, start_index, stop_index){
//	//divide the list in half
//	var split_point = 0;
//	split_point = parseInt((stop_index - start_index)/2);
//	direction = comparePatterns(list[split_point].innerHTML, regexp_pattern);
//	if(direction < 0)
//		return (binSearcher(regexp_pattern, list, start_index, split_point));
//	else
//		if(direction > 0)
//			return (binSearcher(regexp_pattern, list, split_point, stop_index));
//		else
//			return(split_point);
//	
//}

var QSAddition = {	
	buildCache: function() {
	  if (window.console && window.console.log) { console.log('building cache'); }
	  QSAddition.rows = $A([]);
	  QSAddition.cache = $A([]);
		$$('#listScroller li a').each(function(element) {
			QSAddition.rows.push(element);
			QSAddition.cache.push(element.innerHTML.toLowerCase());
		});
	},
	
	searchCache: function(term) {
		var term = term.toLowerCase();
		var len = QSAddition.cache.length;
		var scores = $A([]);
		
		for(var i=0; i < len; i++) {
			var score = QSAddition.cache[i].score(term);
			if (score > 0) { scores.push([score, i]); }
		}
		
		sorted = scores.sort(function(a,b) { return b[0] - a[0]; })
		return sorted.length > 0 ? QSAddition.rows[sorted[0][1]] : null;
	}
}

// qs_score - Quicksilver Score
// 
// A port of the Quicksilver string ranking algorithm
// 
// "hello world".score("axl") //=> 0.0
// "hello world".score("ow") //=> 0.6
// "hello world".score("hello world") //=> 1.0
//
// Tested in Firefox 2 and Safari 3
//
// The Quicksilver code is available here
// http://code.google.com/p/blacktree-alchemy/
// http://blacktree-alchemy.googlecode.com/svn/trunk/Crucible/Code/NSString+BLTRRanking.m
//
// The MIT License
// 
// Copyright (c) 2008 Lachie Cox
// 
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
// 
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
// 
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.


String.prototype.score = function(abbreviation,offset) {
  offset = offset || 0 // TODO: I think this is unused... remove
 
  if(abbreviation.length == 0) return 0.9
  if(abbreviation.length > this.length) return 0.0

  for (var i = abbreviation.length; i > 0; i--) {
    var sub_abbreviation = abbreviation.substring(0,i)
    var index = this.indexOf(sub_abbreviation)


    if(index < 0) continue;
    if(index + abbreviation.length > this.length + offset) continue;

    var next_string       = this.substring(index+sub_abbreviation.length)
    var next_abbreviation = null

    if(i >= abbreviation.length)
      next_abbreviation = ''
    else
      next_abbreviation = abbreviation.substring(i)
 
    var remaining_score   = next_string.score(next_abbreviation,offset+index)
 
    if (remaining_score > 0) {
      var score = this.length-next_string.length;

      if(index != 0) {
        var j = 0;

        var c = this.charCodeAt(index-1)
        if(c==32 || c == 9) {
          for(var j=(index-2); j >= 0; j--) {
            c = this.charCodeAt(j)
            score -= ((c == 32 || c == 9) ? 1 : 0.15)
          }

          // XXX maybe not port this heuristic
          // 
          //          } else if ([[NSCharacterSet uppercaseLetterCharacterSet] characterIsMember:[self characterAtIndex:matchedRange.location]]) {
          //            for (j = matchedRange.location-1; j >= (int) searchRange.location; j--) {
          //              if ([[NSCharacterSet uppercaseLetterCharacterSet] characterIsMember:[self characterAtIndex:j]])
          //                score--;
          //              else
          //                score -= 0.15;
          //            }
        } else {
          score -= index
        }
      }
   
      score += remaining_score * next_string.length
      score /= this.length;
      return score
    }
  }
  return 0.0
}
API_GREASE_START

PROTOTYPE_JS = <<PROTOTYPE_JS_START
/*  Prototype JavaScript framework, version 1.5.0
 *  (c) 2005-2007 Sam Stephenson
 *
 *  Prototype is freely distributable under the terms of an MIT-style license.
 *  For details, see the Prototype web site: http://prototype.conio.net/
 *
/*--------------------------------------------------------------------------*/

var Prototype = {
  Version: '1.5.0',
  BrowserFeatures: {
    XPath: !!document.evaluate
  },

  ScriptFragment: '(?:<script.*?>)((\\n|\\r|.)*?)(?:<\\/script>)',
  emptyFunction: function() {},
  K: function(x) { return x }
}

var Class = {
  create: function() {
    return function() {
      this.initialize.apply(this, arguments);
    }
  }
}

var Abstract = new Object();

Object.extend = function(destination, source) {
  for (var property in source) {
    destination[property] = source[property];
  }
  return destination;
}

Object.extend(Object, {
  inspect: function(object) {
    try {
      if (object === undefined) return 'undefined';
      if (object === null) return 'null';
      return object.inspect ? object.inspect() : object.toString();
    } catch (e) {
      if (e instanceof RangeError) return '...';
      throw e;
    }
  },

  keys: function(object) {
    var keys = [];
    for (var property in object)
      keys.push(property);
    return keys;
  },

  values: function(object) {
    var values = [];
    for (var property in object)
      values.push(object[property]);
    return values;
  },

  clone: function(object) {
    return Object.extend({}, object);
  }
});

Function.prototype.bind = function() {
  var __method = this, args = $A(arguments), object = args.shift();
  return function() {
    return __method.apply(object, args.concat($A(arguments)));
  }
}

Function.prototype.bindAsEventListener = function(object) {
  var __method = this, args = $A(arguments), object = args.shift();
  return function(event) {
    return __method.apply(object, [( event || window.event)].concat(args).concat($A(arguments)));
  }
}

Object.extend(Number.prototype, {
  toColorPart: function() {
    var digits = this.toString(16);
    if (this < 16) return '0' + digits;
    return digits;
  },

  succ: function() {
    return this + 1;
  },

  times: function(iterator) {
    $R(0, this, true).each(iterator);
    return this;
  }
});

var Try = {
  these: function() {
    var returnValue;

    for (var i = 0, length = arguments.length; i < length; i++) {
      var lambda = arguments[i];
      try {
        returnValue = lambda();
        break;
      } catch (e) {}
    }

    return returnValue;
  }
}

/*--------------------------------------------------------------------------*/

var PeriodicalExecuter = Class.create();
PeriodicalExecuter.prototype = {
  initialize: function(callback, frequency) {
    this.callback = callback;
    this.frequency = frequency;
    this.currentlyExecuting = false;

    this.registerCallback();
  },

  registerCallback: function() {
    this.timer = setInterval(this.onTimerEvent.bind(this), this.frequency * 1000);
  },

  stop: function() {
    if (!this.timer) return;
    clearInterval(this.timer);
    this.timer = null;
  },

  onTimerEvent: function() {
    if (!this.currentlyExecuting) {
      try {
        this.currentlyExecuting = true;
        this.callback(this);
      } finally {
        this.currentlyExecuting = false;
      }
    }
  }
}
String.interpret = function(value){
  return value == null ? '' : String(value);
}

Object.extend(String.prototype, {
  gsub: function(pattern, replacement) {
    var result = '', source = this, match;
    replacement = arguments.callee.prepareReplacement(replacement);

    while (source.length > 0) {
      if (match = source.match(pattern)) {
        result += source.slice(0, match.index);
        result += String.interpret(replacement(match));
        source  = source.slice(match.index + match[0].length);
      } else {
        result += source, source = '';
      }
    }
    return result;
  },

  sub: function(pattern, replacement, count) {
    replacement = this.gsub.prepareReplacement(replacement);
    count = count === undefined ? 1 : count;

    return this.gsub(pattern, function(match) {
      if (--count < 0) return match[0];
      return replacement(match);
    });
  },

  scan: function(pattern, iterator) {
    this.gsub(pattern, iterator);
    return this;
  },

  truncate: function(length, truncation) {
    length = length || 30;
    truncation = truncation === undefined ? '...' : truncation;
    return this.length > length ?
      this.slice(0, length - truncation.length) + truncation : this;
  },

  strip: function() {
    return this.replace(/^\\s+/, '').replace(/\\s+$/, '');
  },

  stripTags: function() {
    return this.replace(/<\\/?[^>]+>/gi, '');
  },

  stripScripts: function() {
    return this.replace(new RegExp(Prototype.ScriptFragment, 'img'), '');
  },

  extractScripts: function() {
    var matchAll = new RegExp(Prototype.ScriptFragment, 'img');
    var matchOne = new RegExp(Prototype.ScriptFragment, 'im');
    return (this.match(matchAll) || []).map(function(scriptTag) {
      return (scriptTag.match(matchOne) || ['', ''])[1];
    });
  },

  evalScripts: function() {
    return this.extractScripts().map(function(script) { return eval(script) });
  },

  escapeHTML: function() {
    var div = document.createElement('div');
    var text = document.createTextNode(this);
    div.appendChild(text);
    return div.innerHTML;
  },

  unescapeHTML: function() {
    var div = document.createElement('div');
    div.innerHTML = this.stripTags();
    return div.childNodes[0] ? (div.childNodes.length > 1 ?
      $A(div.childNodes).inject('',function(memo,node){ return memo+node.nodeValue }) :
      div.childNodes[0].nodeValue) : '';
  },

  toQueryParams: function(separator) {
    var match = this.strip().match(/([^?#]*)(#.*)?$/);
    if (!match) return {};

    return match[1].split(separator || '&').inject({}, function(hash, pair) {
      if ((pair = pair.split('='))[0]) {
        var name = decodeURIComponent(pair[0]);
        var value = pair[1] ? decodeURIComponent(pair[1]) : undefined;

        if (hash[name] !== undefined) {
          if (hash[name].constructor != Array)
            hash[name] = [hash[name]];
          if (value) hash[name].push(value);
        }
        else hash[name] = value;
      }
      return hash;
    });
  },

  toArray: function() {
    return this.split('');
  },

  succ: function() {
    return this.slice(0, this.length - 1) +
      String.fromCharCode(this.charCodeAt(this.length - 1) + 1);
  },

  camelize: function() {
    var parts = this.split('-'), len = parts.length;
    if (len == 1) return parts[0];

    var camelized = this.charAt(0) == '-'
      ? parts[0].charAt(0).toUpperCase() + parts[0].substring(1)
      : parts[0];

    for (var i = 1; i < len; i++)
      camelized += parts[i].charAt(0).toUpperCase() + parts[i].substring(1);

    return camelized;
  },

  capitalize: function(){
    return this.charAt(0).toUpperCase() + this.substring(1).toLowerCase();
  },

  underscore: function() {
    return this.gsub(/::/, '/').gsub(/([A-Z]+)([A-Z][a-z])/,'#{1}_#{2}').gsub(/([a-z\\d])([A-Z])/,'#{1}_#{2}').gsub(/-/,'_').toLowerCase();
  },

  dasherize: function() {
    return this.gsub(/_/,'-');
  },

  inspect: function(useDoubleQuotes) {
    var escapedString = this.replace(/\\\\/g, '\\\\\\\\');
    if (useDoubleQuotes)
      return '"' + escapedString.replace(/"/g, '\\\\"') + '"';
    else
      return "'" + escapedString.replace(/'/g, '\\\\\\'') + "'";
  }
});

String.prototype.gsub.prepareReplacement = function(replacement) {
  if (typeof replacement == 'function') return replacement;
  var template = new Template(replacement);
  return function(match) { return template.evaluate(match) };
}

String.prototype.parseQuery = String.prototype.toQueryParams;

var Template = Class.create();
Template.Pattern = /(^|.|\\r|\\n)(#\\{(.*?)\\})/;
Template.prototype = {
  initialize: function(template, pattern) {
    this.template = template.toString();
    this.pattern  = pattern || Template.Pattern;
  },

  evaluate: function(object) {
    return this.template.gsub(this.pattern, function(match) {
      var before = match[1];
      if (before == '\\\\') return match[2];
      return before + String.interpret(object[match[3]]);
    });
  }
}

var $break    = new Object();
var $continue = new Object();

var Enumerable = {
  each: function(iterator) {
    var index = 0;
    try {
      this._each(function(value) {
        try {
          iterator(value, index++);
        } catch (e) {
          if (e != $continue) throw e;
        }
      });
    } catch (e) {
      if (e != $break) throw e;
    }
    return this;
  },

  eachSlice: function(number, iterator) {
    var index = -number, slices = [], array = this.toArray();
    while ((index += number) < array.length)
      slices.push(array.slice(index, index+number));
    return slices.map(iterator);
  },

  all: function(iterator) {
    var result = true;
    this.each(function(value, index) {
      result = result && !!(iterator || Prototype.K)(value, index);
      if (!result) throw $break;
    });
    return result;
  },

  any: function(iterator) {
    var result = false;
    this.each(function(value, index) {
      if (result = !!(iterator || Prototype.K)(value, index))
        throw $break;
    });
    return result;
  },

  collect: function(iterator) {
    var results = [];
    this.each(function(value, index) {
      results.push((iterator || Prototype.K)(value, index));
    });
    return results;
  },

  detect: function(iterator) {
    var result;
    this.each(function(value, index) {
      if (iterator(value, index)) {
        result = value;
        throw $break;
      }
    });
    return result;
  },

  findAll: function(iterator) {
    var results = [];
    this.each(function(value, index) {
      if (iterator(value, index))
        results.push(value);
    });
    return results;
  },

  grep: function(pattern, iterator) {
    var results = [];
    this.each(function(value, index) {
      var stringValue = value.toString();
      if (stringValue.match(pattern))
        results.push((iterator || Prototype.K)(value, index));
    })
    return results;
  },

  include: function(object) {
    var found = false;
    this.each(function(value) {
      if (value == object) {
        found = true;
        throw $break;
      }
    });
    return found;
  },

  inGroupsOf: function(number, fillWith) {
    fillWith = fillWith === undefined ? null : fillWith;
    return this.eachSlice(number, function(slice) {
      while(slice.length < number) slice.push(fillWith);
      return slice;
    });
  },

  inject: function(memo, iterator) {
    this.each(function(value, index) {
      memo = iterator(memo, value, index);
    });
    return memo;
  },

  invoke: function(method) {
    var args = $A(arguments).slice(1);
    return this.map(function(value) {
      return value[method].apply(value, args);
    });
  },

  max: function(iterator) {
    var result;
    this.each(function(value, index) {
      value = (iterator || Prototype.K)(value, index);
      if (result == undefined || value >= result)
        result = value;
    });
    return result;
  },

  min: function(iterator) {
    var result;
    this.each(function(value, index) {
      value = (iterator || Prototype.K)(value, index);
      if (result == undefined || value < result)
        result = value;
    });
    return result;
  },

  partition: function(iterator) {
    var trues = [], falses = [];
    this.each(function(value, index) {
      ((iterator || Prototype.K)(value, index) ?
        trues : falses).push(value);
    });
    return [trues, falses];
  },

  pluck: function(property) {
    var results = [];
    this.each(function(value, index) {
      results.push(value[property]);
    });
    return results;
  },

  reject: function(iterator) {
    var results = [];
    this.each(function(value, index) {
      if (!iterator(value, index))
        results.push(value);
    });
    return results;
  },

  sortBy: function(iterator) {
    return this.map(function(value, index) {
      return {value: value, criteria: iterator(value, index)};
    }).sort(function(left, right) {
      var a = left.criteria, b = right.criteria;
      return a < b ? -1 : a > b ? 1 : 0;
    }).pluck('value');
  },

  toArray: function() {
    return this.map();
  },

  zip: function() {
    var iterator = Prototype.K, args = $A(arguments);
    if (typeof args.last() == 'function')
      iterator = args.pop();

    var collections = [this].concat(args).map($A);
    return this.map(function(value, index) {
      return iterator(collections.pluck(index));
    });
  },

  size: function() {
    return this.toArray().length;
  },

  inspect: function() {
    return '#<Enumerable:' + this.toArray().inspect() + '>';
  }
}

Object.extend(Enumerable, {
  map:     Enumerable.collect,
  find:    Enumerable.detect,
  select:  Enumerable.findAll,
  member:  Enumerable.include,
  entries: Enumerable.toArray
});
var $A = Array.from = function(iterable) {
  if (!iterable) return [];
  if (iterable.toArray) {
    return iterable.toArray();
  } else {
    var results = [];
    for (var i = 0, length = iterable.length; i < length; i++)
      results.push(iterable[i]);
    return results;
  }
}

Object.extend(Array.prototype, Enumerable);

if (!Array.prototype._reverse)
  Array.prototype._reverse = Array.prototype.reverse;

Object.extend(Array.prototype, {
  _each: function(iterator) {
    for (var i = 0, length = this.length; i < length; i++)
      iterator(this[i]);
  },

  clear: function() {
    this.length = 0;
    return this;
  },

  first: function() {
    return this[0];
  },

  last: function() {
    return this[this.length - 1];
  },

  compact: function() {
    return this.select(function(value) {
      return value != null;
    });
  },

  flatten: function() {
    return this.inject([], function(array, value) {
      return array.concat(value && value.constructor == Array ?
        value.flatten() : [value]);
    });
  },

  without: function() {
    var values = $A(arguments);
    return this.select(function(value) {
      return !values.include(value);
    });
  },

  indexOf: function(object) {
    for (var i = 0, length = this.length; i < length; i++)
      if (this[i] == object) return i;
    return -1;
  },

  reverse: function(inline) {
    return (inline !== false ? this : this.toArray())._reverse();
  },

  reduce: function() {
    return this.length > 1 ? this : this[0];
  },

  uniq: function() {
    return this.inject([], function(array, value) {
      return array.include(value) ? array : array.concat([value]);
    });
  },

  clone: function() {
    return [].concat(this);
  },

  size: function() {
    return this.length;
  },

  inspect: function() {
    return '[' + this.map(Object.inspect).join(', ') + ']';
  }
});

Array.prototype.toArray = Array.prototype.clone;

function $w(string){
  string = string.strip();
  return string ? string.split(/\\s+/) : [];
}

if(window.opera){
  Array.prototype.concat = function(){
    var array = [];
    for(var i = 0, length = this.length; i < length; i++) array.push(this[i]);
    for(var i = 0, length = arguments.length; i < length; i++) {
      if(arguments[i].constructor == Array) {
        for(var j = 0, arrayLength = arguments[i].length; j < arrayLength; j++)
          array.push(arguments[i][j]);
      } else {
        array.push(arguments[i]);
      }
    }
    return array;
  }
}
var Hash = function(obj) {
  Object.extend(this, obj || {});
};

Object.extend(Hash, {
  toQueryString: function(obj) {
    var parts = [];

	  this.prototype._each.call(obj, function(pair) {
      if (!pair.key) return;

      if (pair.value && pair.value.constructor == Array) {
        var values = pair.value.compact();
        if (values.length < 2) pair.value = values.reduce();
        else {
        	key = encodeURIComponent(pair.key);
          values.each(function(value) {
            value = value != undefined ? encodeURIComponent(value) : '';
            parts.push(key + '=' + encodeURIComponent(value));
          });
          return;
        }
      }
      if (pair.value == undefined) pair[1] = '';
      parts.push(pair.map(encodeURIComponent).join('='));
	  });

    return parts.join('&');
  }
});

Object.extend(Hash.prototype, Enumerable);
Object.extend(Hash.prototype, {
  _each: function(iterator) {
    for (var key in this) {
      var value = this[key];
      if (value && value == Hash.prototype[key]) continue;

      var pair = [key, value];
      pair.key = key;
      pair.value = value;
      iterator(pair);
    }
  },

  keys: function() {
    return this.pluck('key');
  },

  values: function() {
    return this.pluck('value');
  },

  merge: function(hash) {
    return $H(hash).inject(this, function(mergedHash, pair) {
      mergedHash[pair.key] = pair.value;
      return mergedHash;
    });
  },

  remove: function() {
    var result;
    for(var i = 0, length = arguments.length; i < length; i++) {
      var value = this[arguments[i]];
      if (value !== undefined){
        if (result === undefined) result = value;
        else {
          if (result.constructor != Array) result = [result];
          result.push(value)
        }
      }
      delete this[arguments[i]];
    }
    return result;
  },

  toQueryString: function() {
    return Hash.toQueryString(this);
  },

  inspect: function() {
    return '#<Hash:{' + this.map(function(pair) {
      return pair.map(Object.inspect).join(': ');
    }).join(', ') + '}>';
  }
});

function $H(object) {
  if (object && object.constructor == Hash) return object;
  return new Hash(object);
};
ObjectRange = Class.create();
Object.extend(ObjectRange.prototype, Enumerable);
Object.extend(ObjectRange.prototype, {
  initialize: function(start, end, exclusive) {
    this.start = start;
    this.end = end;
    this.exclusive = exclusive;
  },

  _each: function(iterator) {
    var value = this.start;
    while (this.include(value)) {
      iterator(value);
      value = value.succ();
    }
  },

  include: function(value) {
    if (value < this.start)
      return false;
    if (this.exclusive)
      return value < this.end;
    return value <= this.end;
  }
});

var $R = function(start, end, exclusive) {
  return new ObjectRange(start, end, exclusive);
}

var Ajax = {
  getTransport: function() {
    return Try.these(
      function() {return new XMLHttpRequest()},
      function() {return new ActiveXObject('Msxml2.XMLHTTP')},
      function() {return new ActiveXObject('Microsoft.XMLHTTP')}
    ) || false;
  },

  activeRequestCount: 0
}

Ajax.Responders = {
  responders: [],

  _each: function(iterator) {
    this.responders._each(iterator);
  },

  register: function(responder) {
    if (!this.include(responder))
      this.responders.push(responder);
  },

  unregister: function(responder) {
    this.responders = this.responders.without(responder);
  },

  dispatch: function(callback, request, transport, json) {
    this.each(function(responder) {
      if (typeof responder[callback] == 'function') {
        try {
          responder[callback].apply(responder, [request, transport, json]);
        } catch (e) {}
      }
    });
  }
};

Object.extend(Ajax.Responders, Enumerable);

Ajax.Responders.register({
  onCreate: function() {
    Ajax.activeRequestCount++;
  },
  onComplete: function() {
    Ajax.activeRequestCount--;
  }
});

Ajax.Base = function() {};
Ajax.Base.prototype = {
  setOptions: function(options) {
    this.options = {
      method:       'post',
      asynchronous: true,
      contentType:  'application/x-www-form-urlencoded',
      encoding:     'UTF-8',
      parameters:   ''
    }
    Object.extend(this.options, options || {});

    this.options.method = this.options.method.toLowerCase();
    if (typeof this.options.parameters == 'string')
      this.options.parameters = this.options.parameters.toQueryParams();
  }
}

Ajax.Request = Class.create();
Ajax.Request.Events =
  ['Uninitialized', 'Loading', 'Loaded', 'Interactive', 'Complete'];

Ajax.Request.prototype = Object.extend(new Ajax.Base(), {
  _complete: false,

  initialize: function(url, options) {
    this.transport = Ajax.getTransport();
    this.setOptions(options);
    this.request(url);
  },

  request: function(url) {
    this.url = url;
    this.method = this.options.method;
    var params = this.options.parameters;

    if (!['get', 'post'].include(this.method)) {
      // simulate other verbs over post
      params['_method'] = this.method;
      this.method = 'post';
    }

    params = Hash.toQueryString(params);
    if (params && /Konqueror|Safari|KHTML/.test(navigator.userAgent)) params += '&_='

    // when GET, append parameters to URL
    if (this.method == 'get' && params)
      this.url += (this.url.indexOf('?') > -1 ? '&' : '?') + params;

    try {
      Ajax.Responders.dispatch('onCreate', this, this.transport);

      this.transport.open(this.method.toUpperCase(), this.url,
        this.options.asynchronous);

      if (this.options.asynchronous)
        setTimeout(function() { this.respondToReadyState(1) }.bind(this), 10);

      this.transport.onreadystatechange = this.onStateChange.bind(this);
      this.setRequestHeaders();

      var body = this.method == 'post' ? (this.options.postBody || params) : null;

      this.transport.send(body);

      /* Force Firefox to handle ready state 4 for synchronous requests */
      if (!this.options.asynchronous && this.transport.overrideMimeType)
        this.onStateChange();

    }
    catch (e) {
      this.dispatchException(e);
    }
  },

  onStateChange: function() {
    var readyState = this.transport.readyState;
    if (readyState > 1 && !((readyState == 4) && this._complete))
      this.respondToReadyState(this.transport.readyState);
  },

  setRequestHeaders: function() {
    var headers = {
      'X-Requested-With': 'XMLHttpRequest',
      'X-Prototype-Version': Prototype.Version,
      'Accept': 'text/javascript, text/html, application/xml, text/xml, */*'
    };

    if (this.method == 'post') {
      headers['Content-type'] = this.options.contentType +
        (this.options.encoding ? '; charset=' + this.options.encoding : '');

      /* Force "Connection: close" for older Mozilla browsers to work
       * around a bug where XMLHttpRequest sends an incorrect
       * Content-length header. See Mozilla Bugzilla #246651.
       */
      if (this.transport.overrideMimeType &&
          (navigator.userAgent.match(/Gecko\\/(\\d{4})/) || [0,2005])[1] < 2005)
            headers['Connection'] = 'close';
    }

    // user-defined headers
    if (typeof this.options.requestHeaders == 'object') {
      var extras = this.options.requestHeaders;

      if (typeof extras.push == 'function')
        for (var i = 0, length = extras.length; i < length; i += 2)
          headers[extras[i]] = extras[i+1];
      else
        $H(extras).each(function(pair) { headers[pair.key] = pair.value });
    }

    for (var name in headers)
      this.transport.setRequestHeader(name, headers[name]);
  },

  success: function() {
    return !this.transport.status
        || (this.transport.status >= 200 && this.transport.status < 300);
  },

  respondToReadyState: function(readyState) {
    var state = Ajax.Request.Events[readyState];
    var transport = this.transport, json = this.evalJSON();

    if (state == 'Complete') {
      try {
        this._complete = true;
        (this.options['on' + this.transport.status]
         || this.options['on' + (this.success() ? 'Success' : 'Failure')]
         || Prototype.emptyFunction)(transport, json);
      } catch (e) {
        this.dispatchException(e);
      }

      if ((this.getHeader('Content-type') || 'text/javascript').strip().
        match(/^(text|application)\\/(x-)?(java|ecma)script(;.*)?$/i))
          this.evalResponse();
    }

    try {
      (this.options['on' + state] || Prototype.emptyFunction)(transport, json);
      Ajax.Responders.dispatch('on' + state, this, transport, json);
    } catch (e) {
      this.dispatchException(e);
    }

    if (state == 'Complete') {
      // avoid memory leak in MSIE: clean up
      this.transport.onreadystatechange = Prototype.emptyFunction;
    }
  },

  getHeader: function(name) {
    try {
      return this.transport.getResponseHeader(name);
    } catch (e) { return null }
  },

  evalJSON: function() {
    try {
      var json = this.getHeader('X-JSON');
      return json ? eval('(' + json + ')') : null;
    } catch (e) { return null }
  },

  evalResponse: function() {
    try {
      return eval(this.transport.responseText);
    } catch (e) {
      this.dispatchException(e);
    }
  },

  dispatchException: function(exception) {
    (this.options.onException || Prototype.emptyFunction)(this, exception);
    Ajax.Responders.dispatch('onException', this, exception);
  }
});

Ajax.Updater = Class.create();

Object.extend(Object.extend(Ajax.Updater.prototype, Ajax.Request.prototype), {
  initialize: function(container, url, options) {
    this.container = {
      success: (container.success || container),
      failure: (container.failure || (container.success ? null : container))
    }

    this.transport = Ajax.getTransport();
    this.setOptions(options);

    var onComplete = this.options.onComplete || Prototype.emptyFunction;
    this.options.onComplete = (function(transport, param) {
      this.updateContent();
      onComplete(transport, param);
    }).bind(this);

    this.request(url);
  },

  updateContent: function() {
    var receiver = this.container[this.success() ? 'success' : 'failure'];
    var response = this.transport.responseText;

    if (!this.options.evalScripts) response = response.stripScripts();

    if (receiver = $(receiver)) {
      if (this.options.insertion)
        new this.options.insertion(receiver, response);
      else
        receiver.update(response);
    }

    if (this.success()) {
      if (this.onComplete)
        setTimeout(this.onComplete.bind(this), 10);
    }
  }
});

Ajax.PeriodicalUpdater = Class.create();
Ajax.PeriodicalUpdater.prototype = Object.extend(new Ajax.Base(), {
  initialize: function(container, url, options) {
    this.setOptions(options);
    this.onComplete = this.options.onComplete;

    this.frequency = (this.options.frequency || 2);
    this.decay = (this.options.decay || 1);

    this.updater = {};
    this.container = container;
    this.url = url;

    this.start();
  },

  start: function() {
    this.options.onComplete = this.updateComplete.bind(this);
    this.onTimerEvent();
  },

  stop: function() {
    this.updater.options.onComplete = undefined;
    clearTimeout(this.timer);
    (this.onComplete || Prototype.emptyFunction).apply(this, arguments);
  },

  updateComplete: function(request) {
    if (this.options.decay) {
      this.decay = (request.responseText == this.lastText ?
        this.decay * this.options.decay : 1);

      this.lastText = request.responseText;
    }
    this.timer = setTimeout(this.onTimerEvent.bind(this),
      this.decay * this.frequency * 1000);
  },

  onTimerEvent: function() {
    this.updater = new Ajax.Updater(this.container, this.url, this.options);
  }
});
function $(element) {
  if (arguments.length > 1) {
    for (var i = 0, elements = [], length = arguments.length; i < length; i++)
      elements.push($(arguments[i]));
    return elements;
  }
  if (typeof element == 'string')
    element = document.getElementById(element);
  return Element.extend(element);
}

if (Prototype.BrowserFeatures.XPath) {
  document._getElementsByXPath = function(expression, parentElement) {
    var results = [];
    var query = document.evaluate(expression, $(parentElement) || document,
      null, XPathResult.ORDERED_NODE_SNAPSHOT_TYPE, null);
    for (var i = 0, length = query.snapshotLength; i < length; i++)
      results.push(query.snapshotItem(i));
    return results;
  };
}

document.getElementsByClassName = function(className, parentElement) {
  if (Prototype.BrowserFeatures.XPath) {
    var q = ".//*[contains(concat(' ', @class, ' '), ' " + className + " ')]";
    return document._getElementsByXPath(q, parentElement);
  } else {
    var children = ($(parentElement) || document.body).getElementsByTagName('*');
    var elements = [], child;
    for (var i = 0, length = children.length; i < length; i++) {
      child = children[i];
      if (Element.hasClassName(child, className))
        elements.push(Element.extend(child));
    }
    return elements;
  }
};

/*--------------------------------------------------------------------------*/

if (!window.Element)
  var Element = new Object();

Element.extend = function(element) {
  if (!element || _nativeExtensions || element.nodeType == 3) return element;

  if (!element._extended && element.tagName && element != window) {
    var methods = Object.clone(Element.Methods), cache = Element.extend.cache;

    if (element.tagName == 'FORM')
      Object.extend(methods, Form.Methods);
    if (['INPUT', 'TEXTAREA', 'SELECT'].include(element.tagName))
      Object.extend(methods, Form.Element.Methods);

    Object.extend(methods, Element.Methods.Simulated);

    for (var property in methods) {
      var value = methods[property];
      if (typeof value == 'function' && !(property in element))
        element[property] = cache.findOrStore(value);
    }
  }

  element._extended = true;
  return element;
};

Element.extend.cache = {
  findOrStore: function(value) {
    return this[value] = this[value] || function() {
      return value.apply(null, [this].concat($A(arguments)));
    }
  }
};

Element.Methods = {
  visible: function(element) {
    return $(element).style.display != 'none';
  },

  toggle: function(element) {
    element = $(element);
    Element[Element.visible(element) ? 'hide' : 'show'](element);
    return element;
  },

  hide: function(element) {
    $(element).style.display = 'none';
    return element;
  },

  show: function(element) {
    $(element).style.display = '';
    return element;
  },

  remove: function(element) {
    element = $(element);
    element.parentNode.removeChild(element);
    return element;
  },

  update: function(element, html) {
    html = typeof html == 'undefined' ? '' : html.toString();
    $(element).innerHTML = html.stripScripts();
    setTimeout(function() {html.evalScripts()}, 10);
    return element;
  },

  replace: function(element, html) {
    element = $(element);
    html = typeof html == 'undefined' ? '' : html.toString();
    if (element.outerHTML) {
      element.outerHTML = html.stripScripts();
    } else {
      var range = element.ownerDocument.createRange();
      range.selectNodeContents(element);
      element.parentNode.replaceChild(
        range.createContextualFragment(html.stripScripts()), element);
    }
    setTimeout(function() {html.evalScripts()}, 10);
    return element;
  },

  inspect: function(element) {
    element = $(element);
    var result = '<' + element.tagName.toLowerCase();
    $H({'id': 'id', 'className': 'class'}).each(function(pair) {
      var property = pair.first(), attribute = pair.last();
      var value = (element[property] || '').toString();
      if (value) result += ' ' + attribute + '=' + value.inspect(true);
    });
    return result + '>';
  },

  recursivelyCollect: function(element, property) {
    element = $(element);
    var elements = [];
    while (element = element[property])
      if (element.nodeType == 1)
        elements.push(Element.extend(element));
    return elements;
  },

  ancestors: function(element) {
    return $(element).recursivelyCollect('parentNode');
  },

  descendants: function(element) {
    return $A($(element).getElementsByTagName('*'));
  },

  immediateDescendants: function(element) {
    if (!(element = $(element).firstChild)) return [];
    while (element && element.nodeType != 1) element = element.nextSibling;
    if (element) return [element].concat($(element).nextSiblings());
    return [];
  },

  previousSiblings: function(element) {
    return $(element).recursivelyCollect('previousSibling');
  },

  nextSiblings: function(element) {
    return $(element).recursivelyCollect('nextSibling');
  },

  siblings: function(element) {
    element = $(element);
    return element.previousSiblings().reverse().concat(element.nextSiblings());
  },

  match: function(element, selector) {
    if (typeof selector == 'string')
      selector = new Selector(selector);
    return selector.match($(element));
  },

  up: function(element, expression, index) {
    return Selector.findElement($(element).ancestors(), expression, index);
  },

  down: function(element, expression, index) {
    return Selector.findElement($(element).descendants(), expression, index);
  },

  previous: function(element, expression, index) {
    return Selector.findElement($(element).previousSiblings(), expression, index);
  },

  next: function(element, expression, index) {
    return Selector.findElement($(element).nextSiblings(), expression, index);
  },

  getElementsBySelector: function() {
    var args = $A(arguments), element = $(args.shift());
    return Selector.findChildElements(element, args);
  },

  getElementsByClassName: function(element, className) {
    return document.getElementsByClassName(className, element);
  },

  readAttribute: function(element, name) {
    element = $(element);
    if (document.all && !window.opera) {
      var t = Element._attributeTranslations;
      if (t.values[name]) return t.values[name](element, name);
      if (t.names[name])  name = t.names[name];
      var attribute = element.attributes[name];
      if(attribute) return attribute.nodeValue;
    }
    return element.getAttribute(name);
  },

  getHeight: function(element) {
    return $(element).getDimensions().height;
  },

  getWidth: function(element) {
    return $(element).getDimensions().width;
  },

  classNames: function(element) {
    return new Element.ClassNames(element);
  },

  hasClassName: function(element, className) {
    if (!(element = $(element))) return;
    var elementClassName = element.className;
    if (elementClassName.length == 0) return false;
    if (elementClassName == className ||
        elementClassName.match(new RegExp("(^|\\\\s)" + className + "(\\\\s|$)")))
      return true;
    return false;
  },

  addClassName: function(element, className) {
    if (!(element = $(element))) return;
    Element.classNames(element).add(className);
    return element;
  },

  removeClassName: function(element, className) {
    if (!(element = $(element))) return;
    Element.classNames(element).remove(className);
    return element;
  },

  toggleClassName: function(element, className) {
    if (!(element = $(element))) return;
    Element.classNames(element)[element.hasClassName(className) ? 'remove' : 'add'](className);
    return element;
  },

  observe: function() {
    Event.observe.apply(Event, arguments);
    return $A(arguments).first();
  },

  stopObserving: function() {
    Event.stopObserving.apply(Event, arguments);
    return $A(arguments).first();
  },

  // removes whitespace-only text node children
  cleanWhitespace: function(element) {
    element = $(element);
    var node = element.firstChild;
    while (node) {
      var nextNode = node.nextSibling;
      if (node.nodeType == 3 && !/\\S/.test(node.nodeValue))
        element.removeChild(node);
      node = nextNode;
    }
    return element;
  },

  empty: function(element) {
    return $(element).innerHTML.match(/^\\s*$/);
  },

  descendantOf: function(element, ancestor) {
    element = $(element), ancestor = $(ancestor);
    while (element = element.parentNode)
      if (element == ancestor) return true;
    return false;
  },

  scrollTo: function(element) {
    element = $(element);
    var pos = Position.cumulativeOffset(element);
    window.scrollTo(pos[0], pos[1]);
    return element;
  },

  getStyle: function(element, style) {
    element = $(element);
    if (['float','cssFloat'].include(style))
      style = (typeof element.style.styleFloat != 'undefined' ? 'styleFloat' : 'cssFloat');
    style = style.camelize();
    var value = element.style[style];
    if (!value) {
      if (document.defaultView && document.defaultView.getComputedStyle) {
        var css = document.defaultView.getComputedStyle(element, null);
        value = css ? css[style] : null;
      } else if (element.currentStyle) {
        value = element.currentStyle[style];
      }
    }

    if((value == 'auto') && ['width','height'].include(style) && (element.getStyle('display') != 'none'))
      value = element['offset'+style.capitalize()] + 'px';

    if (window.opera && ['left', 'top', 'right', 'bottom'].include(style))
      if (Element.getStyle(element, 'position') == 'static') value = 'auto';
    if(style == 'opacity') {
      if(value) return parseFloat(value);
      if(value = (element.getStyle('filter') || '').match(/alpha\\(opacity=(.*)\\)/))
        if(value[1]) return parseFloat(value[1]) / 100;
      return 1.0;
    }
    return value == 'auto' ? null : value;
  },

  setStyle: function(element, style) {
    element = $(element);
    for (var name in style) {
      var value = style[name];
      if(name == 'opacity') {
        if (value == 1) {
          value = (/Gecko/.test(navigator.userAgent) &&
            !/Konqueror|Safari|KHTML/.test(navigator.userAgent)) ? 0.999999 : 1.0;
          if(/MSIE/.test(navigator.userAgent) && !window.opera)
            element.style.filter = element.getStyle('filter').replace(/alpha\\([^\\)]*\\)/gi,'');
        } else if(value == '') {
          if(/MSIE/.test(navigator.userAgent) && !window.opera)
            element.style.filter = element.getStyle('filter').replace(/alpha\\([^\\)]*\\)/gi,'');
        } else {
          if(value < 0.00001) value = 0;
          if(/MSIE/.test(navigator.userAgent) && !window.opera)
            element.style.filter = element.getStyle('filter').replace(/alpha\\([^\\)]*\\)/gi,'') +
              'alpha(opacity='+value*100+')';
        }
      } else if(['float','cssFloat'].include(name)) name = (typeof element.style.styleFloat != 'undefined') ? 'styleFloat' : 'cssFloat';
      element.style[name.camelize()] = value;
    }
    return element;
  },

  getDimensions: function(element) {
    element = $(element);
    var display = $(element).getStyle('display');
    if (display != 'none' && display != null) // Safari bug
      return {width: element.offsetWidth, height: element.offsetHeight};

    // All *Width and *Height properties give 0 on elements with display none,
    // so enable the element temporarily
    var els = element.style;
    var originalVisibility = els.visibility;
    var originalPosition = els.position;
    var originalDisplay = els.display;
    els.visibility = 'hidden';
    els.position = 'absolute';
    els.display = 'block';
    var originalWidth = element.clientWidth;
    var originalHeight = element.clientHeight;
    els.display = originalDisplay;
    els.position = originalPosition;
    els.visibility = originalVisibility;
    return {width: originalWidth, height: originalHeight};
  },

  makePositioned: function(element) {
    element = $(element);
    var pos = Element.getStyle(element, 'position');
    if (pos == 'static' || !pos) {
      element._madePositioned = true;
      element.style.position = 'relative';
      // Opera returns the offset relative to the positioning context, when an
      // element is position relative but top and left have not been defined
      if (window.opera) {
        element.style.top = 0;
        element.style.left = 0;
      }
    }
    return element;
  },

  undoPositioned: function(element) {
    element = $(element);
    if (element._madePositioned) {
      element._madePositioned = undefined;
      element.style.position =
        element.style.top =
        element.style.left =
        element.style.bottom =
        element.style.right = '';
    }
    return element;
  },

  makeClipping: function(element) {
    element = $(element);
    if (element._overflow) return element;
    element._overflow = element.style.overflow || 'auto';
    if ((Element.getStyle(element, 'overflow') || 'visible') != 'hidden')
      element.style.overflow = 'hidden';
    return element;
  },

  undoClipping: function(element) {
    element = $(element);
    if (!element._overflow) return element;
    element.style.overflow = element._overflow == 'auto' ? '' : element._overflow;
    element._overflow = null;
    return element;
  }
};

Object.extend(Element.Methods, {childOf: Element.Methods.descendantOf});

Element._attributeTranslations = {};

Element._attributeTranslations.names = {
  colspan:   "colSpan",
  rowspan:   "rowSpan",
  valign:    "vAlign",
  datetime:  "dateTime",
  accesskey: "accessKey",
  tabindex:  "tabIndex",
  enctype:   "encType",
  maxlength: "maxLength",
  readonly:  "readOnly",
  longdesc:  "longDesc"
};

Element._attributeTranslations.values = {
  _getAttr: function(element, attribute) {
    return element.getAttribute(attribute, 2);
  },

  _flag: function(element, attribute) {
    return $(element).hasAttribute(attribute) ? attribute : null;
  },

  style: function(element) {
    return element.style.cssText.toLowerCase();
  },

  title: function(element) {
    var node = element.getAttributeNode('title');
    return node.specified ? node.nodeValue : null;
  }
};

Object.extend(Element._attributeTranslations.values, {
  href: Element._attributeTranslations.values._getAttr,
  src:  Element._attributeTranslations.values._getAttr,
  disabled: Element._attributeTranslations.values._flag,
  checked:  Element._attributeTranslations.values._flag,
  readonly: Element._attributeTranslations.values._flag,
  multiple: Element._attributeTranslations.values._flag
});

Element.Methods.Simulated = {
  hasAttribute: function(element, attribute) {
    var t = Element._attributeTranslations;
    attribute = t.names[attribute] || attribute;
    return $(element).getAttributeNode(attribute).specified;
  }
};

// IE is missing .innerHTML support for TABLE-related elements
if (document.all && !window.opera){
  Element.Methods.update = function(element, html) {
    element = $(element);
    html = typeof html == 'undefined' ? '' : html.toString();
    var tagName = element.tagName.toUpperCase();
    if (['THEAD','TBODY','TR','TD'].include(tagName)) {
      var div = document.createElement('div');
      switch (tagName) {
        case 'THEAD':
        case 'TBODY':
          div.innerHTML = '<table><tbody>' +  html.stripScripts() + '</tbody></table>';
          depth = 2;
          break;
        case 'TR':
          div.innerHTML = '<table><tbody><tr>' +  html.stripScripts() + '</tr></tbody></table>';
          depth = 3;
          break;
        case 'TD':
          div.innerHTML = '<table><tbody><tr><td>' +  html.stripScripts() + '</td></tr></tbody></table>';
          depth = 4;
      }
      $A(element.childNodes).each(function(node){
        element.removeChild(node)
      });
      depth.times(function(){ div = div.firstChild });

      $A(div.childNodes).each(
        function(node){ element.appendChild(node) });
    } else {
      element.innerHTML = html.stripScripts();
    }
    setTimeout(function() {html.evalScripts()}, 10);
    return element;
  }
};

Object.extend(Element, Element.Methods);

var _nativeExtensions = false;

if(/Konqueror|Safari|KHTML/.test(navigator.userAgent))
  ['', 'Form', 'Input', 'TextArea', 'Select'].each(function(tag) {
    var className = 'HTML' + tag + 'Element';
    if(window[className]) return;
    var klass = window[className] = {};
    klass.prototype = document.createElement(tag ? tag.toLowerCase() : 'div').__proto__;
  });

Element.addMethods = function(methods) {
  Object.extend(Element.Methods, methods || {});

  function copy(methods, destination, onlyIfAbsent) {
    onlyIfAbsent = onlyIfAbsent || false;
    var cache = Element.extend.cache;
    for (var property in methods) {
      var value = methods[property];
      if (!onlyIfAbsent || !(property in destination))
        destination[property] = cache.findOrStore(value);
    }
  }

  if (typeof HTMLElement != 'undefined') {
    copy(Element.Methods, HTMLElement.prototype);
    copy(Element.Methods.Simulated, HTMLElement.prototype, true);
    copy(Form.Methods, HTMLFormElement.prototype);
    [HTMLInputElement, HTMLTextAreaElement, HTMLSelectElement].each(function(klass) {
      copy(Form.Element.Methods, klass.prototype);
    });
    _nativeExtensions = true;
  }
}

var Toggle = new Object();
Toggle.display = Element.toggle;

/*--------------------------------------------------------------------------*/

Abstract.Insertion = function(adjacency) {
  this.adjacency = adjacency;
}

Abstract.Insertion.prototype = {
  initialize: function(element, content) {
    this.element = $(element);
    this.content = content.stripScripts();

    if (this.adjacency && this.element.insertAdjacentHTML) {
      try {
        this.element.insertAdjacentHTML(this.adjacency, this.content);
      } catch (e) {
        var tagName = this.element.tagName.toUpperCase();
        if (['TBODY', 'TR'].include(tagName)) {
          this.insertContent(this.contentFromAnonymousTable());
        } else {
          throw e;
        }
      }
    } else {
      this.range = this.element.ownerDocument.createRange();
      if (this.initializeRange) this.initializeRange();
      this.insertContent([this.range.createContextualFragment(this.content)]);
    }

    setTimeout(function() {content.evalScripts()}, 10);
  },

  contentFromAnonymousTable: function() {
    var div = document.createElement('div');
    div.innerHTML = '<table><tbody>' + this.content + '</tbody></table>';
    return $A(div.childNodes[0].childNodes[0].childNodes);
  }
}

var Insertion = new Object();

Insertion.Before = Class.create();
Insertion.Before.prototype = Object.extend(new Abstract.Insertion('beforeBegin'), {
  initializeRange: function() {
    this.range.setStartBefore(this.element);
  },

  insertContent: function(fragments) {
    fragments.each((function(fragment) {
      this.element.parentNode.insertBefore(fragment, this.element);
    }).bind(this));
  }
});

Insertion.Top = Class.create();
Insertion.Top.prototype = Object.extend(new Abstract.Insertion('afterBegin'), {
  initializeRange: function() {
    this.range.selectNodeContents(this.element);
    this.range.collapse(true);
  },

  insertContent: function(fragments) {
    fragments.reverse(false).each((function(fragment) {
      this.element.insertBefore(fragment, this.element.firstChild);
    }).bind(this));
  }
});

Insertion.Bottom = Class.create();
Insertion.Bottom.prototype = Object.extend(new Abstract.Insertion('beforeEnd'), {
  initializeRange: function() {
    this.range.selectNodeContents(this.element);
    this.range.collapse(this.element);
  },

  insertContent: function(fragments) {
    fragments.each((function(fragment) {
      this.element.appendChild(fragment);
    }).bind(this));
  }
});

Insertion.After = Class.create();
Insertion.After.prototype = Object.extend(new Abstract.Insertion('afterEnd'), {
  initializeRange: function() {
    this.range.setStartAfter(this.element);
  },

  insertContent: function(fragments) {
    fragments.each((function(fragment) {
      this.element.parentNode.insertBefore(fragment,
        this.element.nextSibling);
    }).bind(this));
  }
});

/*--------------------------------------------------------------------------*/

Element.ClassNames = Class.create();
Element.ClassNames.prototype = {
  initialize: function(element) {
    this.element = $(element);
  },

  _each: function(iterator) {
    this.element.className.split(/\\s+/).select(function(name) {
      return name.length > 0;
    })._each(iterator);
  },

  set: function(className) {
    this.element.className = className;
  },

  add: function(classNameToAdd) {
    if (this.include(classNameToAdd)) return;
    this.set($A(this).concat(classNameToAdd).join(' '));
  },

  remove: function(classNameToRemove) {
    if (!this.include(classNameToRemove)) return;
    this.set($A(this).without(classNameToRemove).join(' '));
  },

  toString: function() {
    return $A(this).join(' ');
  }
};

Object.extend(Element.ClassNames.prototype, Enumerable);
var Selector = Class.create();
Selector.prototype = {
  initialize: function(expression) {
    this.params = {classNames: []};
    this.expression = expression.toString().strip();
    this.parseExpression();
    this.compileMatcher();
  },

  parseExpression: function() {
    function abort(message) { throw 'Parse error in selector: ' + message; }

    if (this.expression == '')  abort('empty expression');

    var params = this.params, expr = this.expression, match, modifier, clause, rest;
    while (match = expr.match(/^(.*)\\[([a-z0-9_:-]+?)(?:([~\\|!]?=)(?:"([^"]*)"|([^\\]\\s]*)))?\\]$/i)) {
      params.attributes = params.attributes || [];
      params.attributes.push({name: match[2], operator: match[3], value: match[4] || match[5] || ''});
      expr = match[1];
    }

    if (expr == '*') return this.params.wildcard = true;

    while (match = expr.match(/^([^a-z0-9_-])?([a-z0-9_-]+)(.*)/i)) {
      modifier = match[1], clause = match[2], rest = match[3];
      switch (modifier) {
        case '#':       params.id = clause; break;
        case '.':       params.classNames.push(clause); break;
        case '':
        case undefined: params.tagName = clause.toUpperCase(); break;
        default:        abort(expr.inspect());
      }
      expr = rest;
    }

    if (expr.length > 0) abort(expr.inspect());
  },

  buildMatchExpression: function() {
    var params = this.params, conditions = [], clause;

    if (params.wildcard)
      conditions.push('true');
    if (clause = params.id)
      conditions.push('element.readAttribute("id") == ' + clause.inspect());
    if (clause = params.tagName)
      conditions.push('element.tagName.toUpperCase() == ' + clause.inspect());
    if ((clause = params.classNames).length > 0)
      for (var i = 0, length = clause.length; i < length; i++)
        conditions.push('element.hasClassName(' + clause[i].inspect() + ')');
    if (clause = params.attributes) {
      clause.each(function(attribute) {
        var value = 'element.readAttribute(' + attribute.name.inspect() + ')';
        var splitValueBy = function(delimiter) {
          return value + ' && ' + value + '.split(' + delimiter.inspect() + ')';
        }

        switch (attribute.operator) {
          case '=':       conditions.push(value + ' == ' + attribute.value.inspect()); break;
          case '~=':      conditions.push(splitValueBy(' ') + '.include(' + attribute.value.inspect() + ')'); break;
          case '|=':      conditions.push(
                            splitValueBy('-') + '.first().toUpperCase() == ' + attribute.value.toUpperCase().inspect()
                          ); break;
          case '!=':      conditions.push(value + ' != ' + attribute.value.inspect()); break;
          case '':
          case undefined: conditions.push('element.hasAttribute(' + attribute.name.inspect() + ')'); break;
          default:        throw 'Unknown operator ' + attribute.operator + ' in selector';
        }
      });
    }

    return conditions.join(' && ');
  },

  compileMatcher: function() {
    this.match = new Function('element', 'if (!element.tagName) return false; \\
      element = $(element); \\
      return ' + this.buildMatchExpression());
  },

  findElements: function(scope) {
    var element;

    if (element = $(this.params.id))
      if (this.match(element))
        if (!scope || Element.childOf(element, scope))
          return [element];

    scope = (scope || document).getElementsByTagName(this.params.tagName || '*');

    var results = [];
    for (var i = 0, length = scope.length; i < length; i++)
      if (this.match(element = scope[i]))
        results.push(Element.extend(element));

    return results;
  },

  toString: function() {
    return this.expression;
  }
}

Object.extend(Selector, {
  matchElements: function(elements, expression) {
    var selector = new Selector(expression);
    return elements.select(selector.match.bind(selector)).map(Element.extend);
  },

  findElement: function(elements, expression, index) {
    if (typeof expression == 'number') index = expression, expression = false;
    return Selector.matchElements(elements, expression || '*')[index || 0];
  },

  findChildElements: function(element, expressions) {
    return expressions.map(function(expression) {
      return expression.match(/[^\\s"]+(?:"[^"]*"[^\\s"]+)*/g).inject([null], function(results, expr) {
        var selector = new Selector(expr);
        return results.inject([], function(elements, result) {
          return elements.concat(selector.findElements(result || element));
        });
      });
    }).flatten();
  }
});

function $$() {
  return Selector.findChildElements(document, $A(arguments));
}
var Form = {
  reset: function(form) {
    $(form).reset();
    return form;
  },

  serializeElements: function(elements, getHash) {
    var data = elements.inject({}, function(result, element) {
      if (!element.disabled && element.name) {
        var key = element.name, value = $(element).getValue();
        if (value != undefined) {
          if (result[key]) {
            if (result[key].constructor != Array) result[key] = [result[key]];
            result[key].push(value);
          }
          else result[key] = value;
        }
      }
      return result;
    });

    return getHash ? data : Hash.toQueryString(data);
  }
};

Form.Methods = {
  serialize: function(form, getHash) {
    return Form.serializeElements(Form.getElements(form), getHash);
  },

  getElements: function(form) {
    return $A($(form).getElementsByTagName('*')).inject([],
      function(elements, child) {
        if (Form.Element.Serializers[child.tagName.toLowerCase()])
          elements.push(Element.extend(child));
        return elements;
      }
    );
  },

  getInputs: function(form, typeName, name) {
    form = $(form);
    var inputs = form.getElementsByTagName('input');

    if (!typeName && !name) return $A(inputs).map(Element.extend);

    for (var i = 0, matchingInputs = [], length = inputs.length; i < length; i++) {
      var input = inputs[i];
      if ((typeName && input.type != typeName) || (name && input.name != name))
        continue;
      matchingInputs.push(Element.extend(input));
    }

    return matchingInputs;
  },

  disable: function(form) {
    form = $(form);
    form.getElements().each(function(element) {
      element.blur();
      element.disabled = 'true';
    });
    return form;
  },

  enable: function(form) {
    form = $(form);
    form.getElements().each(function(element) {
      element.disabled = '';
    });
    return form;
  },

  findFirstElement: function(form) {
    return $(form).getElements().find(function(element) {
      return element.type != 'hidden' && !element.disabled &&
        ['input', 'select', 'textarea'].include(element.tagName.toLowerCase());
    });
  },

  focusFirstElement: function(form) {
    form = $(form);
    form.findFirstElement().activate();
    return form;
  }
}

Object.extend(Form, Form.Methods);

/*--------------------------------------------------------------------------*/

Form.Element = {
  focus: function(element) {
    $(element).focus();
    return element;
  },

  select: function(element) {
    $(element).select();
    return element;
  }
}

Form.Element.Methods = {
  serialize: function(element) {
    element = $(element);
    if (!element.disabled && element.name) {
      var value = element.getValue();
      if (value != undefined) {
        var pair = {};
        pair[element.name] = value;
        return Hash.toQueryString(pair);
      }
    }
    return '';
  },

  getValue: function(element) {
    element = $(element);
    var method = element.tagName.toLowerCase();
    return Form.Element.Serializers[method](element);
  },

  clear: function(element) {
    $(element).value = '';
    return element;
  },

  present: function(element) {
    return $(element).value != '';
  },

  activate: function(element) {
    element = $(element);
    element.focus();
    if (element.select && ( element.tagName.toLowerCase() != 'input' ||
      !['button', 'reset', 'submit'].include(element.type) ) )
      element.select();
    return element;
  },

  disable: function(element) {
    element = $(element);
    element.disabled = true;
    return element;
  },

  enable: function(element) {
    element = $(element);
    element.blur();
    element.disabled = false;
    return element;
  }
}

Object.extend(Form.Element, Form.Element.Methods);
var Field = Form.Element;
var $F = Form.Element.getValue;

/*--------------------------------------------------------------------------*/

Form.Element.Serializers = {
  input: function(element) {
    switch (element.type.toLowerCase()) {
      case 'checkbox':
      case 'radio':
        return Form.Element.Serializers.inputSelector(element);
      default:
        return Form.Element.Serializers.textarea(element);
    }
  },

  inputSelector: function(element) {
    return element.checked ? element.value : null;
  },

  textarea: function(element) {
    return element.value;
  },

  select: function(element) {
    return this[element.type == 'select-one' ?
      'selectOne' : 'selectMany'](element);
  },

  selectOne: function(element) {
    var index = element.selectedIndex;
    return index >= 0 ? this.optionValue(element.options[index]) : null;
  },

  selectMany: function(element) {
    var values, length = element.length;
    if (!length) return null;

    for (var i = 0, values = []; i < length; i++) {
      var opt = element.options[i];
      if (opt.selected) values.push(this.optionValue(opt));
    }
    return values;
  },

  optionValue: function(opt) {
    // extend element because hasAttribute may not be native
    return Element.extend(opt).hasAttribute('value') ? opt.value : opt.text;
  }
}

/*--------------------------------------------------------------------------*/

Abstract.TimedObserver = function() {}
Abstract.TimedObserver.prototype = {
  initialize: function(element, frequency, callback) {
    this.frequency = frequency;
    this.element   = $(element);
    this.callback  = callback;

    this.lastValue = this.getValue();
    this.registerCallback();
  },

  registerCallback: function() {
    setInterval(this.onTimerEvent.bind(this), this.frequency * 1000);
  },

  onTimerEvent: function() {
    var value = this.getValue();
    var changed = ('string' == typeof this.lastValue && 'string' == typeof value
      ? this.lastValue != value : String(this.lastValue) != String(value));
    if (changed) {
      this.callback(this.element, value);
      this.lastValue = value;
    }
  }
}

Form.Element.Observer = Class.create();
Form.Element.Observer.prototype = Object.extend(new Abstract.TimedObserver(), {
  getValue: function() {
    return Form.Element.getValue(this.element);
  }
});

Form.Observer = Class.create();
Form.Observer.prototype = Object.extend(new Abstract.TimedObserver(), {
  getValue: function() {
    return Form.serialize(this.element);
  }
});

/*--------------------------------------------------------------------------*/

Abstract.EventObserver = function() {}
Abstract.EventObserver.prototype = {
  initialize: function(element, callback) {
    this.element  = $(element);
    this.callback = callback;

    this.lastValue = this.getValue();
    if (this.element.tagName.toLowerCase() == 'form')
      this.registerFormCallbacks();
    else
      this.registerCallback(this.element);
  },

  onElementEvent: function() {
    var value = this.getValue();
    if (this.lastValue != value) {
      this.callback(this.element, value);
      this.lastValue = value;
    }
  },

  registerFormCallbacks: function() {
    Form.getElements(this.element).each(this.registerCallback.bind(this));
  },

  registerCallback: function(element) {
    if (element.type) {
      switch (element.type.toLowerCase()) {
        case 'checkbox':
        case 'radio':
          Event.observe(element, 'click', this.onElementEvent.bind(this));
          break;
        default:
          Event.observe(element, 'change', this.onElementEvent.bind(this));
          break;
      }
    }
  }
}

Form.Element.EventObserver = Class.create();
Form.Element.EventObserver.prototype = Object.extend(new Abstract.EventObserver(), {
  getValue: function() {
    return Form.Element.getValue(this.element);
  }
});

Form.EventObserver = Class.create();
Form.EventObserver.prototype = Object.extend(new Abstract.EventObserver(), {
  getValue: function() {
    return Form.serialize(this.element);
  }
});
if (!window.Event) {
  var Event = new Object();
}

Object.extend(Event, {
  KEY_BACKSPACE: 8,
  KEY_TAB:       9,
  KEY_RETURN:   13,
  KEY_ESC:      27,
  KEY_LEFT:     37,
  KEY_UP:       38,
  KEY_RIGHT:    39,
  KEY_DOWN:     40,
  KEY_DELETE:   46,
  KEY_HOME:     36,
  KEY_END:      35,
  KEY_PAGEUP:   33,
  KEY_PAGEDOWN: 34,

  element: function(event) {
    return event.target || event.srcElement;
  },

  isLeftClick: function(event) {
    return (((event.which) && (event.which == 1)) ||
            ((event.button) && (event.button == 1)));
  },

  pointerX: function(event) {
    return event.pageX || (event.clientX +
      (document.documentElement.scrollLeft || document.body.scrollLeft));
  },

  pointerY: function(event) {
    return event.pageY || (event.clientY +
      (document.documentElement.scrollTop || document.body.scrollTop));
  },

  stop: function(event) {
    if (event.preventDefault) {
      event.preventDefault();
      event.stopPropagation();
    } else {
      event.returnValue = false;
      event.cancelBubble = true;
    }
  },

  // find the first node with the given tagName, starting from the
  // node the event was triggered on; traverses the DOM upwards
  findElement: function(event, tagName) {
    var element = Event.element(event);
    while (element.parentNode && (!element.tagName ||
        (element.tagName.toUpperCase() != tagName.toUpperCase())))
      element = element.parentNode;
    return element;
  },

  observers: false,

  _observeAndCache: function(element, name, observer, useCapture) {
    if (!this.observers) this.observers = [];
    if (element.addEventListener) {
      this.observers.push([element, name, observer, useCapture]);
      element.addEventListener(name, observer, useCapture);
    } else if (element.attachEvent) {
      this.observers.push([element, name, observer, useCapture]);
      element.attachEvent('on' + name, observer);
    }
  },

  unloadCache: function() {
    if (!Event.observers) return;
    for (var i = 0, length = Event.observers.length; i < length; i++) {
      Event.stopObserving.apply(this, Event.observers[i]);
      Event.observers[i][0] = null;
    }
    Event.observers = false;
  },

  observe: function(element, name, observer, useCapture) {
    element = $(element);
    useCapture = useCapture || false;

    if (name == 'keypress' &&
        (navigator.appVersion.match(/Konqueror|Safari|KHTML/)
        || element.attachEvent))
      name = 'keydown';

    Event._observeAndCache(element, name, observer, useCapture);
  },

  stopObserving: function(element, name, observer, useCapture) {
    element = $(element);
    useCapture = useCapture || false;

    if (name == 'keypress' &&
        (navigator.appVersion.match(/Konqueror|Safari|KHTML/)
        || element.detachEvent))
      name = 'keydown';

    if (element.removeEventListener) {
      element.removeEventListener(name, observer, useCapture);
    } else if (element.detachEvent) {
      try {
        element.detachEvent('on' + name, observer);
      } catch (e) {}
    }
  }
});

/* prevent memory leaks in IE */
if (navigator.appVersion.match(/\\bMSIE\\b/))
  Event.observe(window, 'unload', Event.unloadCache, false);
var Position = {
  // set to true if needed, warning: firefox performance problems
  // NOT neeeded for page scrolling, only if draggable contained in
  // scrollable elements
  includeScrollOffsets: false,

  // must be called before calling withinIncludingScrolloffset, every time the
  // page is scrolled
  prepare: function() {
    this.deltaX =  window.pageXOffset
                || document.documentElement.scrollLeft
                || document.body.scrollLeft
                || 0;
    this.deltaY =  window.pageYOffset
                || document.documentElement.scrollTop
                || document.body.scrollTop
                || 0;
  },

  realOffset: function(element) {
    var valueT = 0, valueL = 0;
    do {
      valueT += element.scrollTop  || 0;
      valueL += element.scrollLeft || 0;
      element = element.parentNode;
    } while (element);
    return [valueL, valueT];
  },

  cumulativeOffset: function(element) {
    var valueT = 0, valueL = 0;
    do {
      valueT += element.offsetTop  || 0;
      valueL += element.offsetLeft || 0;
      element = element.offsetParent;
    } while (element);
    return [valueL, valueT];
  },

  positionedOffset: function(element) {
    var valueT = 0, valueL = 0;
    do {
      valueT += element.offsetTop  || 0;
      valueL += element.offsetLeft || 0;
      element = element.offsetParent;
      if (element) {
        if(element.tagName=='BODY') break;
        var p = Element.getStyle(element, 'position');
        if (p == 'relative' || p == 'absolute') break;
      }
    } while (element);
    return [valueL, valueT];
  },

  offsetParent: function(element) {
    if (element.offsetParent) return element.offsetParent;
    if (element == document.body) return element;

    while ((element = element.parentNode) && element != document.body)
      if (Element.getStyle(element, 'position') != 'static')
        return element;

    return document.body;
  },

  // caches x/y coordinate pair to use with overlap
  within: function(element, x, y) {
    if (this.includeScrollOffsets)
      return this.withinIncludingScrolloffsets(element, x, y);
    this.xcomp = x;
    this.ycomp = y;
    this.offset = this.cumulativeOffset(element);

    return (y >= this.offset[1] &&
            y <  this.offset[1] + element.offsetHeight &&
            x >= this.offset[0] &&
            x <  this.offset[0] + element.offsetWidth);
  },

  withinIncludingScrolloffsets: function(element, x, y) {
    var offsetcache = this.realOffset(element);

    this.xcomp = x + offsetcache[0] - this.deltaX;
    this.ycomp = y + offsetcache[1] - this.deltaY;
    this.offset = this.cumulativeOffset(element);

    return (this.ycomp >= this.offset[1] &&
            this.ycomp <  this.offset[1] + element.offsetHeight &&
            this.xcomp >= this.offset[0] &&
            this.xcomp <  this.offset[0] + element.offsetWidth);
  },

  // within must be called directly before
  overlap: function(mode, element) {
    if (!mode) return 0;
    if (mode == 'vertical')
      return ((this.offset[1] + element.offsetHeight) - this.ycomp) /
        element.offsetHeight;
    if (mode == 'horizontal')
      return ((this.offset[0] + element.offsetWidth) - this.xcomp) /
        element.offsetWidth;
  },

  page: function(forElement) {
    var valueT = 0, valueL = 0;

    var element = forElement;
    do {
      valueT += element.offsetTop  || 0;
      valueL += element.offsetLeft || 0;

      // Safari fix
      if (element.offsetParent==document.body)
        if (Element.getStyle(element,'position')=='absolute') break;

    } while (element = element.offsetParent);

    element = forElement;
    do {
      if (!window.opera || element.tagName=='BODY') {
        valueT -= element.scrollTop  || 0;
        valueL -= element.scrollLeft || 0;
      }
    } while (element = element.parentNode);

    return [valueL, valueT];
  },

  clone: function(source, target) {
    var options = Object.extend({
      setLeft:    true,
      setTop:     true,
      setWidth:   true,
      setHeight:  true,
      offsetTop:  0,
      offsetLeft: 0
    }, arguments[2] || {})

    // find page position of source
    source = $(source);
    var p = Position.page(source);

    // find coordinate system to use
    target = $(target);
    var delta = [0, 0];
    var parent = null;
    // delta [0,0] will do fine with position: fixed elements,
    // position:absolute needs offsetParent deltas
    if (Element.getStyle(target,'position') == 'absolute') {
      parent = Position.offsetParent(target);
      delta = Position.page(parent);
    }

    // correct by body offsets (fixes Safari)
    if (parent == document.body) {
      delta[0] -= document.body.offsetLeft;
      delta[1] -= document.body.offsetTop;
    }

    // set position
    if(options.setLeft)   target.style.left  = (p[0] - delta[0] + options.offsetLeft) + 'px';
    if(options.setTop)    target.style.top   = (p[1] - delta[1] + options.offsetTop) + 'px';
    if(options.setWidth)  target.style.width = source.offsetWidth + 'px';
    if(options.setHeight) target.style.height = source.offsetHeight + 'px';
  },

  absolutize: function(element) {
    element = $(element);
    if (element.style.position == 'absolute') return;
    Position.prepare();

    var offsets = Position.positionedOffset(element);
    var top     = offsets[1];
    var left    = offsets[0];
    var width   = element.clientWidth;
    var height  = element.clientHeight;

    element._originalLeft   = left - parseFloat(element.style.left  || 0);
    element._originalTop    = top  - parseFloat(element.style.top || 0);
    element._originalWidth  = element.style.width;
    element._originalHeight = element.style.height;

    element.style.position = 'absolute';
    element.style.top    = top + 'px';
    element.style.left   = left + 'px';
    element.style.width  = width + 'px';
    element.style.height = height + 'px';
  },

  relativize: function(element) {
    element = $(element);
    if (element.style.position == 'relative') return;
    Position.prepare();

    element.style.position = 'relative';
    var top  = parseFloat(element.style.top  || 0) - (element._originalTop || 0);
    var left = parseFloat(element.style.left || 0) - (element._originalLeft || 0);

    element.style.top    = top + 'px';
    element.style.left   = left + 'px';
    element.style.height = element._originalHeight;
    element.style.width  = element._originalWidth;
  }
}

// Safari returns margins on body which is incorrect if the child is absolutely
// positioned.  For performance reasons, redefine Position.cumulativeOffset for
// KHTML/WebKit only.
if (/Konqueror|Safari|KHTML/.test(navigator.userAgent)) {
  Position.cumulativeOffset = function(element) {
    var valueT = 0, valueL = 0;
    do {
      valueT += element.offsetTop  || 0;
      valueL += element.offsetLeft || 0;
      if (element.offsetParent == document.body)
        if (Element.getStyle(element, 'position') == 'absolute') break;

      element = element.offsetParent;
    } while (element);

    return [valueL, valueT];
  }
}

Element.addMethods();
PROTOTYPE_JS_START

end
end

