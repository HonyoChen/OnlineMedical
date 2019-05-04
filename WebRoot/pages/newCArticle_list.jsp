<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@page import="com.cn.POJO.User"%>
<%@page import="com.cn.POJO.Patient"%>
<%@page import="com.opensymphony.xwork2.ActionContext"%>
<%@page import="java.text.*"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	User user = (User) ActionContext.getContext().getSession().get("loginUser");
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html lang="en-US">
<!--<![endif]-->
<head>
<!-- META TAGS -->
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<title>文章内容</title>

<link rel="shortcut icon" href="<%=path%>/assets4/images/favicon.png" />

<!-- Style Sheet-->
<!-- <link rel="stylesheet" href="../assets4/style.css" /> -->
<link rel="shortcut icon" href="<%=path%>/assets4/images/favicon.png" />
<%-- <link rel="stylesheet" href="<%=path%>/assets4/style.css" /> --%>
<link rel="stylesheet" id="bootstrap-css-css" href="<%=path%>/assets4/css/bootstrap5152.css?ver=1.0" type="text/css" media="all" /> 
<link rel="stylesheet" id="responsive-css-css" 	href="<%=path%>/assets4/css/responsive5152.css?ver=1.0" type="text/css" media="all" />
<link rel="stylesheet" id="pretty-photo-css-css" href="<%=path%>/assets4/js/prettyphoto/prettyPhotoaeb9.css?ver=3.1.4" type="text/css" media="all" />
<link rel="stylesheet" id="main-css-css"    href="<%=path%>/assets4/css/main5152.css?ver=1.0" type="text/css" media="all" />
<link rel="stylesheet" href="../css/font-awesome.min.css">
<%-- <link rel="stylesheet" id="custom-css-css"   href="<%=path%>/assets4/css/custom5152.html?ver=1.0" type="text/css" media="all" /> --%>


<!-- HTML5 shim, for IE6-8 support of HTML5 elements -->
<!--[if lt IE 9]>
                <script src="js/html5.js"></script></script>
                <![endif]-->


</head>

<body>

	<div class="header-wrapper">
		<header>
		<div class="container">
			<div class="logo-container">
				<!-- Website Logo -->
				 <a href="#" title="Star Health"> <img
					src="<%=path%>/assets4/images/star_logo.png" alt="Star Health" style="width:80px;height:25px;">
				</a>  <span class="tag-line" style="font-size:20px;" >医患社区</span>
			</div>

			<!-- Start of Main Navigation -->
			<nav class="main-nav">
			<div class="menu-top-menu-container">
				<ul id="menu-top-menu" class="clearfix">
					<li class="current-menu-item"><a href="<%=path%>/pages/NewDPCommunity.jsp">首页</a></li>
					 <li><a href="<%=path%>/pages/newArticle_list.jsp">文章列表</a></li>
                     <li><a href="<%=path%>/pages/FAQS.jsp">FAQS</a></li>
                     
                   <%
					if (user != null) {
				   %>                    
                     <li><a href="<%=path%>/pages/newMArticle_list.jsp?id=<%= user.getUid()%>">我的文章</a></li>
                     <%
					} else {
				%>
                       <li><a href="<%=path%>/pages/login.html">登录</a></li>
                     <%
					}
				%>
                     
                     <!--  <li><a href="faq.html">FAQs</a></li>
                      <li><a href="#">Skins</a>
                       <ul class="sub-menu">
                         <li><a href="blue-skin.html">Blue Skin</a></li>
                         <li><a href="green-skin.html">Green Skin</a></li>
                             <li><a href="red-skin.html">Red Skin</a></li>
                         <li><a href="index-2.html">Default Skin</a></li>
                             </ul>
                              </li>
                              <li><a href="#">More</a>
                               <ul class="sub-menu">
                                  <li><a href="full-width.html">Full Width</a></li>
                                  <li><a href="elements.html">Elements</a></li>
                                  <li><a href="page.html">Sample Page</a></li>
                                  </ul>
                           </li>
               <li><a href="contact.html">Contact</a></li> -->
				</ul>
			</div>
			</nav>
			<!-- End of Main Navigation -->

		</div>
		</header>
	</div>
	<!-- End of Header -->

	<!-- Start of Search Wrapper -->
   <div class="search-area-wrapper">
		<div class="search-area container">
			<h3 class="search-header">查询文章</h3>
			<p class="search-tag-line">通过文章标题关键字搜索社区文章</p>
	     	  <div class="search-form clearfix">
				<input class="search-term required" style="margin-left:130px;height:50px;width:800px;" type="text"
					id="s" name="s" placeholder="请输入文章题目关键字"
					title="* 关键字不能为空!" /> <a id="ahref"
					href="javascript:void(0)"><input style="width:100px;height:50px;margin-top:-12px;margin-left:10px;" class="search-btn" value="查询" type="button"
						onclick="sear()"/></a>
				<div id="search-error-container"></div>
			</div>
		</div>
	</div>
	<!-- End of Search Wrapper -->

	<!-- Start of Page Container -->
	<div class="page-container">
		<div class="container">
			<div class="row">

				<!-- start of page content -->
				<div class="span8 main-listing" id="newArticlesList">


				</div>
				<!-- end of page content -->
				<!-- start of sidebar -->
				<aside class="span4 page-sidebar"> <section class="widget">
				<div class="support-widget">
					<h3 class="title">支持帮助</h3>
					<p class="intro">需要更多支持？ 如果您没有找到答案，请联系我们获取进一步的帮助。</p>
				</div>
				</section>
				</aside>
			</div>
		</div>
	</div>

   <script type='text/javascript' src='<%=path%>/js/jquery-1.10.2.js'></script>
   <script type='text/javascript' src='<%=path%>/assets4/js/jquery.easing.1.3.js'></script>
   <%-- <script type='text/javascript' src='<%=path%>/assets4/js/prettyphoto/jquery.prettyPhoto.js'></script> --%>
<script type='text/javascript' src='<%=path%>/assets4/js/jflickrfeed.js'></script>
<script type='text/javascript' src='<%=path%>/assets4/js/jquery.liveSearch.js'></script>
<script type='text/javascript' src='<%=path%>/assets4/js/jquery.form.js'></script>
<script type='text/javascript' src='<%=path%>/assets4/js/jquery.validate.min.js'></script>
<script type='text/javascript' src='<%=path%>/assets4/js/custom.js'></script>
	<script type="text/javascript">
	
	var data;
	var name,value; //参数名和值
	var url = decodeURI(window.location.href);
	var index = url.indexOf('?');
	var params = url.substr(index + 1);
	var parr = params.split('&');
	for (var i = 0; i < parr.length; i++) {
		index = parr[i].indexOf('=');
		if (index > 0) {
			name = parr[i].substr(0, index);
			value = parr[i].substr(index + 1);
			this[name] = value;
		}
	}	
	$(document).ready(function() {
		$.ajax({
			url : "allArticles",
			type : "POST",
			data : {},
			async : false,
			dataType : "JSON",
			success : function(result) {
				//alert(result);
				//alert(JSON.stringify(result));
				//var obj = result[0];	
		//		data = result;
				for (var i = 0;i < result.length ;  i++) {
				
					if(result[i].category == value)
					{						
						addRecord(result[i], i + 1);
					}
						
				}
			},
			error : function(result) {
				alert("返回数据失败，请刷新页面");
				alert('error:' + result);
			}
		});
	});
	function getDateStr(seconds) {
				var date = new Date(seconds)
				var year = date.getFullYear();
				var month = date.getMonth() + 1;
				var day = date.getDate();
				var hour = date.getHours() < 10 ? "0" + date.getHours() : date.getHours();
				var minute = date.getMinutes() < 10 ? "0" + date.getMinutes() : date.getMinutes();
				var second = date.getSeconds() < 10 ? "0" + date.getSeconds() : date.getSeconds();
				var currentTime = year + "-" + month + "-" + day + "  " + hour + ":" + minute + ":" + second;
				return currentTime
			}

	function addRecord(obj, i) {
		var html = "";
		var str = getDateStr(obj["time"].time);
		var st = str.substr(11, 5);
		var ss = str.substr(0, 10);
		var strYear = str.substr(0, 4).toString();
		var strMonth = str.substr(5, 2).toString();
		var strDay = str.substr(8, 2).toString();
		var end = new Date();
		var year = end.getFullYear();
		var month = end.getMonth() + 1;
		var date = end.getDate();
		html +="<article class=\"format-standard type-post hentry clearfix\">";
		html +="<header class=\"clearfix\">";
		html +="<h3 class=\"post-title\">";
		html +="<a href=\"newArticles_content.jsp?id="+obj.aid +"\">"+obj.title+"</a>";
		html +="</h3>";
		html +="<div class=\"post-meta clearfix\">";
		if ((strYear == year) && (strMonth == month) && (strDay == date)) {
			if(obj.category == 0)
			{
				html +="<span class=\"date\">"+st+"</span><i class=\"fa fa-user fa-1x \" aria-hidden=\"true\">&nbsp;&nbsp;<span>"+obj.author+"</span> </i>&nbsp;&nbsp;&nbsp;&nbsp;<span class=\"category\"><a href=\"#\" title=\"View all posts in Server &amp; Database\">病情解答</a></span><span class=\"comments\"><a href=\"#\" title=\"Comment on Integrating WordPress with Your Website\">"+obj.count+"条评论</a></span>";
	  		}
			else if (obj.category == 1)
			{
				html +="<span class=\"date\">"+st+"</span><i class=\"fa fa-user fa-1x \" aria-hidden=\"true\">&nbsp;&nbsp;<span>"+obj.author+"</span> </i>&nbsp;&nbsp;&nbsp;&nbsp;<span class=\"category\"><a href=\"#\" title=\"View all posts in Server &amp; Database\">知识共享</a></span><span class=\"comments\"><a href=\"#\" title=\"Comment on Integrating WordPress with Your Website\">"+obj.count+"条评论</a></span>";
	  		}		
		} 
		else {
			if(obj.category == 0 )
			{
				html +="<span class=\"date\">"+ss+"</span><i class=\"fa fa-user fa-1x \" aria-hidden=\"true\">&nbsp;&nbsp;<span>"+obj.author+"</span> </i>&nbsp;&nbsp;&nbsp;&nbsp;<span class=\"category\"><a href=\"#\" title=\"View all posts in Server &amp; Database\">病情解答</a></span><span class=\"comments\"><a href=\"#\" title=\"Comment on Integrating WordPress with Your Website\">"+obj.count+"条评论</a></span>";
	  		 }
			else if (obj.category == 1)
			{
				html +="<span class=\"date\">"+ss+"</span><i class=\"fa fa-user fa-1x \" aria-hidden=\"true\">&nbsp;&nbsp;<span>"+obj.author+"</span> </i>&nbsp;&nbsp;&nbsp;&nbsp;<span class=\"category\"><a href=\"#\" title=\"View all posts in Server &amp; Database\">知识共享</a></span><span class=\"comments\"><a href=\"#\" title=\"Comment on Integrating WordPress with Your Website\">"+obj.count+"条评论</a></span>";
	  		}	
	  	}		
		html +="</div>";
		html +="</header>";
		html +="</article>";		
		$("#newArticlesList").append(html);
	}
		function sear(){
	//	alert("进入sear，并且获取参数为：" + document.getElementById("s").value);
	  //var url2 = document.getElementById("ahref");
	 <%--  alert(typeof(url2));
	   window.open("<%=path%>/pages/selectNewArticle_list.jsp?id="+document.getElementById("s").value);
       url2.href="<%=path%>/pages/selectNewArticle_list.jsp?id="+document.getElementById("s").value;
       url2.click(); 
       //a.href = "<%=path%>/pages/selectNewArticle_list.jsp?id="+document.getElementById("s").value;
		//取消<a>标签原先的onclick事件,使<a>标签点击后通过href跳转(因为无法用js跳转)
		//url2.setAttribute("href","<%=path%>/pages/selectNewArticle_list.jsp?id="+document.getElementById("s").value);
		//激发标签点击事件OVER
		//url2.click("return false");--%>
		location.href="<%=path%>/pages/selectNewArticle_list.jsp?id="+document.getElementById("s").value;
	 }
</script>
</body>
</html>


