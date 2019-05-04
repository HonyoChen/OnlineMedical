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
<head>
<!-- META TAGS -->
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>文章内容</title>
<link rel="shortcut icon" href="images/favicon.png" />
<!-- Style Sheet-->
<%-- <link rel="stylesheet" href="<%=path%>/assets4/style.css" /> --%>
<link rel='stylesheet' id='bootstrap-css-css'
	href='<%=path%>/assets4/css/bootstrap5152.css?ver=1.0' type='text/css'
	media='all' />
<link rel='stylesheet' id='responsive-css-css'
	href='<%=path%>/assets4/css/responsive5152.css?ver=1.0' type='text/css'
	media='all' />
<link rel='stylesheet' id='pretty-photo-css-css'
	href='<%=path%>/assets4/js/prettyphoto/prettyPhotoaeb9.css?ver=3.1.4'
	type='text/css' media='all' />
<link rel='stylesheet' id='main-css-css'
	href='<%=path%>/assets4/css/main5152.css?ver=1.0' type='text/css'
	media='all' />
<link rel="stylesheet" href="../css/font-awesome.min.css">
<%-- <link rel='stylesheet' id='custom-css-css'
	href='<%=path%>/assets4/css/custom5152.html?ver=1.0' type='text/css' media='all' />
</head> --%>
<body>

	<div class="header-wrapper">
		<header>
		<div class="container">
			<div class="logo-container">
				<!-- Website Logo -->
				<a href="#" title="Star Health"> <img
					src="<%=path%>/assets4/images/star_logo.png" alt="Star Health"
					style="width:80px;height:25px;">
				</a> <span class="tag-line" style="font-size:20px;">医患社区</span>
			</div>
			<nav class="main-nav">
			<div class="menu-top-menu-container">
				<ul id="menu-top-menu" class="clearfix">
					<li class="current-menu-item"><a
						href="<%=path%>/pages/NewDPCommunity.jsp">首页</a></li>
					<li><a href="<%=path%>/pages/newArticle_list.jsp">文章列表</a></li>
					<li><a href="<%=path%>/pages/FAQS.jsp">FAQS</a></li>

					<%
					if (user != null) {
				   %>
					<li><a
						href="<%=path%>/pages/newMArticle_list.jsp?id=<%= user.getUid()%>">我的文章</a></li>
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
				<input class="search-term required"
					style="margin-left:130px;height:50px;width:800px;" type="text"
					id="s" name="s" placeholder="请输入文章题目关键字" title="*关键字不能为空!" /> <a
					href="javascript:void(0)"><input
					style="width:100px;height:50px;margin-top:-12px;margin-left:10px;"
					class="search-btn" value="查询" type="button" onclick="sear()" /></a>
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
				<div class="span8 page-content">

					<ul class="breadcrumb">
						<li><a href="<%=path%>/pages/newArticle_list.jsp">文章列表</a><span
							class="divider"> / </span></li>
						<li><a id="ahref" href="javascript:void(0)"><span id="lb"></span></a><span
							class="divider">/</span></li>
						<li class="active"><span id="title"></span></li>
					</ul>
					<article class=" type-post format-standard hentry clearfix"
						id="ArticleContent"> </article>

					<section id="comments">
					<h3 id="comments-title">评论</h3>

					<ol class="commentlist">
						<li class="comment even thread-even depth-1" id="li-comment-2">

						</li>

					</ol>

					<div id="respond">

						<h3>请留下您的感想！</h3>

						<div class="cancel-comment-reply">
							<a rel="nofollow" id="cancel-comment-reply-link" href="#"
								style="display:none;">点此留言...</a>
						</div>


						<form action="#" method="post" id="commentform">
							<div>
								<label for="comment">评论</label>
								<textarea class="span8" name="comment" id="comment" cols="58"
									rows="10"></textarea>
							</div>

							<div>
								<input class="btn" name="submit" type="submit" id="submit"
									value="提交评论" onclick="addcomment()">
							</div>

						</form>

					</div>

					</section>
					<!-- end of comments -->

				</div>
				<aside class="span4 page-sidebar"> <section class="widget">
				<div class="support-widget">
					<h3 class="title">支持帮助</h3>
					<p class="intro">需要更多支持？ 如果您没有找到答案，请联系我们获取进一步的帮助。</p>
				</div>
				</section> </aside>
			</div>
		</div>
	</div>
	<!-- End of Page Container -->
	<a href="#top" id="scroll-top"></a>

	<!-- script -->
	<script type='text/javascript'
		src='<%=path%>/assets4/js/jquery-1.8.3.min.js'></script>
	<script type='text/javascript'
		src='<%=path%>/assets4/js/jquery.easing.1.3.js'></script>
	<script type='text/javascript'
		src='<%=path%>/assets4/js/prettyphoto/jquery.prettyPhoto.js'></script>
	<script type='text/javascript'
		src='<%=path%>/assets4/js/jflickrfeed.js'></script>
	<script type='text/javascript'
		src='<%=path%>/assets4/js/jquery.liveSearch.js'></script>
	<script type='text/javascript'
		src='<%=path%>/assets4/js/jquery.form.js'></script>
	<script type='text/javascript'
		src='<%=path%>/assets4/js/jquery.validate.min.js'></script>
	<script type='text/javascript' src='<%=path%>/assets4/js/custom.js'></script>
	<script type="text/javascript">
		var zhi;
		var uid;
		$(document).ready(function() {
			<%
				if(user != null){
			%>
					uid = <%= user.getUid()%>;
			<%	
				}
			%>
			var name,
				value; //参数名和值
			var url = decodeURI(window.location.href);
			var index = url.indexOf('?');
			var params = url.substr(index + 1);
			var parr = params.split('&');
			for (var i = 0; i < parr.length; i++) {
				index = parr[i].indexOf('=');
				if (index > 0) {
					name = parr[i].substr(0, index);
					value = parr[i].substr(index + 1);
					value = value.replace("#", "");
					this[name] = value;
				}
				zhi = this['id'];
			}
	
			$.ajax({
				url : "findArticleById",
				type : "POST",
				data : {
					"aid" : zhi,
				},
				async : true,
				dataType : "JSON",
				//contentType:"application/json; charset=utf-8",
				success : function(result) {
					addRecord(result);
				},
				error : function(result) {
					//alert("返回数据失败，请刷新页面");
					//alert('error:' + JSON.stringify(result));
				}
			});
	
			$.ajax({
				url : "findCommentsByAid",
				type : "POST",
				data : {
					"aid" : zhi,
				},
				async : true,
				dataType : "JSON",
				//contentType:"application/json; charset=utf-8",
				success : function(result) {
					for (var i = 0; i < result.length; i++) {
						addRecordComment(result[i]);
					}
				},
				error : function(result) {
					//alert("返回数据失败，请刷新页面");
					//alert('error:' + JSON.stringify(result));
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
			if (obj.category == 0) {
				document.getElementById('lb').innerText = "病情解答";
				var url2 = document.getElementById("ahref");
				url2.href = "<%=path%>/pages/newCArticle_list.jsp?id=0";
			} else if (obj.category == 1) {
				document.getElementById('lb').innerText = "知识共享";
				var url2 = document.getElementById("ahref");
				url2.href = "<%=path%>/pages/newCArticle_list.jsp?id=1";
			}
			document.getElementById('title').innerText = obj.title;
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
			html += "<h1 class=\"post-title\">" + obj.title + "</h1>";
			html += "<div class=\"post-meta clearfix\">";
			if ((strYear == year) && (strMonth == month) && (strDay == date)) {
				if (obj.category == 0) {
					html += "<span class=\"date\">" + st + "</span><i class=\"fa fa-user fa-1x \" aria-hidden=\"true\">&nbsp;&nbsp;<span>" + obj.author + "</span> </i>&nbsp;&nbsp;&nbsp;&nbsp;<span class=\"category\"><a href=\"#\" title=\"View all posts in Server &amp; Database\">病情解答</a></span><span class=\"comments\"><a href=\"#\" title=\"Comment on Integrating WordPress with Your Website\">" + obj.count + "条评论</a></span>";
				} else if (obj.category == 1) {
					html += "<span class=\"date\">" + st + "</span><i class=\"fa fa-user fa-1x \" aria-hidden=\"true\">&nbsp;&nbsp;<span>" + obj.author + "</span> </i>&nbsp;&nbsp;&nbsp;&nbsp;<span class=\"category\"><a href=\"#\" title=\"View all posts in Server &amp; Database\">知识共享</a></span><span class=\"comments\"><a href=\"#\" title=\"Comment on Integrating WordPress with Your Website\">" + obj.count + "条评论</a></span>";
				}
			} else {
				if (obj.category == 0) {
					html += "<span class=\"date\">" + ss + "</span><i class=\"fa fa-user fa-1x \" aria-hidden=\"true\">&nbsp;&nbsp;<span>" + obj.author + "</span> </i>&nbsp;&nbsp;&nbsp;&nbsp;<span class=\"category\"><a href=\"#\" title=\"View all posts in Server &amp; Database\">病情解答</a></span><span class=\"comments\"><a href=\"#\" title=\"Comment on Integrating WordPress with Your Website\">" + obj.count + "条评论</a></span>";
				} else if (obj.category == 1) {
					html += "<span class=\"date\">" + ss + "</span><i class=\"fa fa-user fa-1x \" aria-hidden=\"true\">&nbsp;&nbsp;<span>" + obj.author + "</span> </i>&nbsp;&nbsp;&nbsp;&nbsp;<span class=\"category\"><a href=\"#\" title=\"View all posts in Server &amp; Database\">知识共享</a></span><span class=\"comments\"><a href=\"#\" title=\"Comment on Integrating WordPress with Your Website\">" + obj.count + "条评论</a></span>";
				}
			} /* html +="<span class=\"date\">25 Feb, 2013</span> <span class=\"category\"><a href=\"#\" title=\"View all posts in Server &amp; Database\">Server&amp; Database</a></span> <span class=\"comments\"><a href=\"#\" title=\"Comment on Integrating WordPress with Your Website\">3Comments</a></span> <span class=\"like-count\">66</span></div>";				
						 */
			html += "<p>" + obj.content + "</p>";
	
			$("#ArticleContent").append(html);
		}
		function addRecordComment(obj) {
			var html = "";
			var str = getDateStr(obj["time"].time);
			html += "<article id=\"comment-2\"> <a href=\"#\"> <img alt=\"\" src=\"../assets/img/user.jpg\" class=\"avatar avatar-60 photo\" height=\"60\" width=\"60\">";
			html += "</a><div class=\"comment-meta\" >	<h5 class=\"author\">";
			html += "<cite class=\"fn\"> <a href=\"#\" rel=\"external nofollow\" class=\"url\">" + obj.author + "</a>";
			html += "</cite><a class=\"comment-reply-link\" href=\"#\"></a>";
			html += "</h5><p class=\"date\">";
			html += "<a href=\"#\"> <time datetime=\"2013-02-26T13:18:47+00:00\">" + str + "</time>";
			html += "</a></p></div><div class=\"comment-body\"><p>" + obj.content + "</p> </div></article>";
			$("#li-comment-2").append(html);
		}
		function addcomment() {
			//var obj = <%= user %>;
			if(uid != null){
				$.ajax({
					url : "addComment",
					type : "POST",
					data : {
						<%-- 'uid' : "<%= user.getUid()%>", --%>
						'uid' : uid,
						'aid' : zhi,
						'content' : document.getElementById("comment").value,
					},
					async : false,
					dataType : "JSON",
					success : function(result) {
						//window.location.href = window.location.href;
						window.location.reload();
					}
				});
			}else{
				alert("登录后评论");
			}
		}
		function sear() {
			window.location.href = "<%=path%>/pages/selectNewArticle_list.jsp?id=" + document.getElementById("s").value;
		}
	</script>
</body>
</html>

