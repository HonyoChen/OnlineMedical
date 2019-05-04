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


<!DOCTYPE HTML>
<html>
<head>
<base href="<%=basePath%>">
<title>医患社区</title>    
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<link rel="shortcut icon" href="<%=path%>/assets4/images/favicon.png" />
<%-- <link rel="stylesheet" href="<%=path%>/assets4/style.css" /> --%>
<link rel="stylesheet" id="bootstrap-css-css" href="<%=path%>/assets4/css/bootstrap5152.css?ver=1.0" type="text/css" media="all" /> 
<link rel="stylesheet" id="responsive-css-css" 	href="<%=path%>/assets4/css/responsive5152.css?ver=1.0" type="text/css" media="all" />
<link rel="stylesheet" id="pretty-photo-css-css" href="<%=path%>/assets4/js/prettyphoto/prettyPhotoaeb9.css?ver=3.1.4" type="text/css" media="all" />
<link rel="stylesheet" id="main-css-css"    href="<%=path%>/assets4/css/main5152.css?ver=1.0" type="text/css" media="all" />
<%-- <link rel="stylesheet" id="custom-css-css"   href="<%=path%>/assets4/css/custom5152.html?ver=1.0" type="text/css" media="all" /> --%>

</head>

<body>

	<div class="header-wrapper">
		<header>
		<div class="container">
			<div class="logo-container">
				 <a href="#" title="Star Health"> <img
					src="<%=path%>/assets4/images/star_logo.png" alt="Star Health" style="width:80px;height:25px;">
				</a>  <span class="tag-line" style="font-size:20px;" >医患社区</span>
			</div>
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
				</ul>
			</div>
			</nav>
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
				<input class="search-term required" style="margin-left:130px;height:45px;width:800px;" type="text"
					id="s" name="s" placeholder="请输入文章题目关键字"
					title="* 关键字不能为空!" /> <a id="ahref"
					href="javascript:void(0)"><input style="width:100px;height:50px;margin-top:-12px;margin-left:10px;" class="search-btn" value="查询" type="button"
						onclick="sear()"/></a>
				<div id="search-error-container"></div>
			</div>
		</div>
	</div>
	<div class="page-container">
		<div class="container">
			<div class="row">
				<div class="span8 page-content">
					<div class="row separator">
						<section class="span4 articles-list">
						<h3>最近更新文章</h3>
						<ul class="articles" id="newarticleTop">
				
						</ul>
						</section>


						<section class="span4 articles-list">
						<h3>最多评论文章</h3>
						<ul class="articles" id="newarticle">
						</ul>
						</section>
					</div>
				</div>
				<aside class="span4 page-sidebar"> <section class="widget">
				<div class="support-widget">
					<h3 class="title">支持帮助</h3>
					<p class="intro">需要更多支持？ 如果您没有找到答案，请联系我们获取进一步的帮助。</p>
				</div>
				</section> <section class="widget">
				<div class="quick-links-widget">
					<h3 class="title">文章类别</h3>
					<ul id="menu-quick-links" class="menu clearfix">
						<li><a href="pages/newCArticle_list.jsp?id=0">病情解答</a></li>
						<li><a href="pages/newCArticle_list.jsp?id=1">知识共享</a></li>
					</ul>
				</div>
				</section>
				 </aside>

			</div>
		</div>
	</div>
	<!-- End of Page Container -->

	<a href="#top" id="scroll-top"></a>

	<!-- script -->
<%--     <script type="text/javascript" src="<%=path%>/js/jquery.min.js"></script> --%>
<%-- <script type='text/javascript' src='<%=path%>/assets4/js/jquery-1.8.3.min.js'></script> --%>
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
	$(document).ready(function() {
		//alert('初始化');
		$.ajax({
			url : "findArticlesWithMaxComments",
			type : "POST",
			data : {},
			//async : false,
			dataType : "JSON",
			contentType:"application/json; charset=utf-8",
			success : function(result) {
				//alert(result);
				//alert(JSON.stringify(result));
				//var obj = result[0];
				//data = result;
				for (var i =0;i<result.length;i++) {
						addRecord(result[i], i + 1);
				}
			},
			error : function(result) {
				alert("返回数据失败，请刷新页面");
				alert('error:' + JSON.stringify(result));
			}
		});
		$.ajax({
			url : "topFiveNewestArticles",
			type : "POST",
			data : {},
			//async : false,
			dataType : "JSON",
			contentType:"application/json; charset=utf-8",
			success : function(result) {
				//alert(result);
				//alert(JSON.stringify(result));
				//var obj = result[0];
				//data = result;
				//alert(result.length);
				for (var i =0;i<result.length;i++) {
						addRecordTop(result[i], i + 1);
				}
			},
			error : function(result) {
				alert("返回数据失败，请刷新页面");
				alert('error:' + JSON.stringify(result));
			}
		});
	});

	function addRecord(obj, i) {
		var html = "";
		html += "<li class=\"article-entry standard\"><h4>";
		html += "<a href=\"pages/newArticles_content.jsp?id="+obj.aid+"\">" + obj.title + "</a>";
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
		if ((strYear == year) && (strMonth == month) && (strDay == date)) {			
			if (obj.category == 0) {
				html += "</h4> <span class=\"article-meta\">" + st + "&nbsp;&nbsp;" + obj.author + "&nbsp;&nbsp;</span><span class=\"category\">&nbsp;&nbsp; 病情解答 </span> <span class=\"comments\">&nbsp;&nbsp;" + obj.count + "条评论</span></li>";
			} else if (obj.category == 1) {
				html += "</h4> <span class=\"article-meta\">" + st + "&nbsp;&nbsp;" + obj.author + "&nbsp;&nbsp;</span><span class=\"category\">&nbsp;&nbsp;知识共享 </span> <span class=\"comments\">&nbsp;&nbsp;" + obj.count + "条评论</span></li>";
			}
		} else {
			if (obj.category == 0) {
				html += "</h4> <span class=\"article-meta\">" + ss + "&nbsp;&nbsp;" + obj.author + "&nbsp;&nbsp;<span class=\"category\">&nbsp;&nbsp;病情解答 </span> <span class=\"comments\">&nbsp;&nbsp;" + obj.count + "条评论</span></li>";
			} else if (obj.category == 1) {
				html += "</h4> <span class=\"article-meta\">" + ss + "&nbsp;&nbsp;" + obj.author + "&nbsp;&nbsp;<span class=\"category\">&nbsp;&nbsp;知识共享</span> <span class=\"comments\">&nbsp;&nbsp;" + obj.count + "条评论</span></li>";
			}

		}
		 $("#newarticle").append(html);

	}
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
		function addRecordTop(obj, i) {
		var html = "";
		html += "<li class=\"article-entry standard\"><h4>";
		html += "<a href=\"pages/newArticles_content.jsp?id="+obj.aid+"\">" + obj.title + "</a>";
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
		if ((strYear == year) && (strMonth == month) && (strDay == date)) {
			if (obj.category == 0) {
				html += "</h4> <span class=\"article-meta\">" + st + "&nbsp;&nbsp;"+ obj.author + "&nbsp;&nbsp</span><span class=\"category\"> 病情解答 </span></li>";
			} else if (obj.category == 1) {
				html += "</h4> <span class=\"article-meta\">" + st + "&nbsp;&nbsp;"+ obj.author + "&nbsp;&nbsp</span><span class=\"category\">知识共享 </span> </li>";
			}
		} else {
			if (obj.category == 0) {
				html += "</h4> <span class=\"article-meta\">" + ss + "&nbsp;&nbsp;" + obj.author + "&nbsp;&nbsp;<span class=\"category\">病情解答 </span> </li>";
			} else if (obj.category == 1) {
				html += "</h4> <span class=\"article-meta\">" + ss + "&nbsp;&nbsp;" + obj.author + "&nbsp;&nbsp;<span class=\"category\">知识共享</span> </li>";
			}

		}
		 $("#newarticleTop").append(html);

	}
		function sear(){
	//	alert("进入sear，并且获取参数为：" + document.getElementById("s").value);
	  //var url2 = document.getElementById("ahref");
	 <%--  alert(typeof(url2));
	   window.open("<%=path%>/pages/selectNewArticle_list.jsp?id="+document.getElementById("s").value);
       url2.href="<%=path%>/pages/selectNewArticle_list.jsp?id="+document.getElementById("s").value;
       url2.click(); --%>
       //a.href = "<%=path%>/pages/selectNewArticle_list.jsp?id="+document.getElementById("s").value;
		//取消<a>标签原先的onclick事件,使<a>标签点击后通过href跳转(因为无法用js跳转)
		//url2.setAttribute("href","<%=path%>/pages/selectNewArticle_list.jsp?id="+document.getElementById("s").value);
		//激发标签点击事件OVER
		//url2.click("return false");
		location.href="<%=path%>/pages/selectNewArticle_list.jsp?id="+document.getElementById("s").value;
	 }

</script>

</body>
</html>
