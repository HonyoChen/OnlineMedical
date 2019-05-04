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

<!doctype html>
<!--[if lt IE 7]> <html class="lt-ie9 lt-ie8 lt-ie7" lang="en-US"> <![endif]-->
<!--[if IE 7]>    <html class="lt-ie9 lt-ie8" lang="en-US"> <![endif]-->
<!--[if IE 8]>    <html class="lt-ie9" lang="en-US"> <![endif]-->
<!--[if gt IE 8]><!-->
<html lang="en-US">
<!--<![endif]-->
<head>
<!-- META TAGS -->
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<title>联系我们</title>

<link rel="shortcut icon" href="<%=path%>/assets4/images/favicon.png" />
<%-- <link rel="stylesheet" href="<%=path%>/assets4/style.css" /> --%>
<link rel="stylesheet" id="bootstrap-css-css" href="<%=path%>/assets4/css/bootstrap5152.css?ver=1.0" type="text/css" media="all" /> 
<link rel="stylesheet" id="responsive-css-css" 	href="<%=path%>/assets4/css/responsive5152.css?ver=1.0" type="text/css" media="all" />
<link rel="stylesheet" id="pretty-photo-css-css" href="<%=path%>/assets4/js/prettyphoto/prettyPhotoaeb9.css?ver=3.1.4" type="text/css" media="all" />
<link rel="stylesheet" id="main-css-css"    href="<%=path%>/assets4/css/main5152.css?ver=1.0" type="text/css" media="all" />
<link rel="stylesheet" href="../css/font-awesome.min.css">
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
					<li><a href="<%=path%>/pages/NewDPCommunity.jsp">首页</a></li>
					 <li ><a href="<%=path%>/pages/newArticle_list.jsp">文章列表</a></li>					 
					  <li  class="current-menu-item"><a href="<%=path%>/pages/FAQS.jsp">FAQS</a></li>
                     
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
				<div class="span8 page-content">

					<article class=" page type-page hentry clearfix">
						<h1 class="post-title">
							<a href="#">关于我们</a>
						</h1>
						<hr>
						<p>Star Health立足于帕金森病和心脏病聚类分析、癫痫发作识别等医疗大数据的智能识别算法，在其上设计实时监测功能，通过实时采集患者体征数据，进行实时的发病预测识别。平台设计实现管理员、医生、患者等三类用户角色，并通过构建管理平台、数据平台、预警平台、医患社区四个子平台构建完整应用体系。如有其他问题，请至平台首页给我们留言，我们将安排专业人员为您解答。</p>
					</article>

					<div class="faqs clearfix">

						<article class="faq-item active">
							<span class="faq-icon"></span>
							<h3 class="faq-question">
								<a href="#">训练模型是否存在隐私泄露风险？</a>
							</h3>
							<div class="faq-answer">
								<p>
									当前平台采用公开数据集进行模型训练，并提供差分隐私保证。后期改善模型性能时，将采用真实数据集，利用差分隐私提供数据隐私保护。
								</p>
								<!-- <p>For more information:</p>
								<ul>
									<li><a title="WordPress"
										href="http://codex.wordpress.org/WordPress">WordPress</a></li>
									<li><a title="WordPress Semantics"
										href="http://codex.wordpress.org/WordPress_Semantics">WordPress
											Semantics</a></li>
									<li><a title="About WordPress"
										href="http://codex.wordpress.org/About_WordPress">About
											WordPress</a></li>
								</ul> -->
							</div>
						</article>

						<article class="faq-item">
							<span class="faq-icon"></span>
							<h3 class="faq-question">
								<a href="#">各角色对应功能有哪些？</a>
							</h3>
							<div class="faq-answer">
								<p>Star Health平台共提供管理平台、数据平台、预警平台、医患社区四类子平台，其中医生角色用户可在管理平台查看患者挂号内容，查看历史诊断记录，使用数据平台存储私密文件及共享文件，利用预警平台查看挂号患者的实时状态及统计指标，在医患社区分享内容；患者角色可在管理平台进行挂号，查看个人就诊记录，利用预警平台查看实时病情诊断信息及历史统计指标，在医患社区分享内容。其中医患社区文章查看对游客开放，评论功能需登录实现。</p>
							<!-- 	<p>Here at WordPress.org, you can download WordPress, the
									web software that WordPress.com runs on. Once you’ve downloaded
									it, you can upload it to a web server and run your own
									WordPress website.</p>
								<p>
									There is useful information about this distinction on the&nbsp;<a
										title="http://en.support.wordpress.com/com-vs-org/"
										href="http://en.support.wordpress.com/com-vs-org/">WordPress.com
										website</a>.
								</p> -->
							</div>
						</article>

						<article class="faq-item">
							<span class="faq-icon"></span>
							<h3 class="faq-question">
								<a href="#">如何注册医生账号？</a>
							</h3>
							<div class="faq-answer" style="display: none;">
								<p>
								系统开放患者注册接口，医生账号注册需首页留言联系管理员进行添加。注册时请提供本人身份证件、医师资格证、医师执业证、专业技术资格等医院需提供营业执照原件照片。
								</p>
							<!-- 	<p>
									The GPL is an open source license. This means you are free to
									modify and redistribute the source code under certain
									conditions. You can read more about why we chose the GPL
									on&nbsp;<a title="http://codex.wordpress.org/License"
										href="http://codex.wordpress.org/License">the License
										Page.</a>
								</p> -->
							</div>
						</article>

						<article class="faq-item">
							<span class="faq-icon"></span>
							<h3 class="faq-question">
								<a href="#">忘记密码怎么办？</a>
							</h3>
							<div class="faq-answer">
								<p>
									在登录界面点击忘记密码，系统会跳转到重置密码页面，在页面输入账号（注册邮箱），点击“确认并跳转到邮箱”，登录邮箱点击重置密码链接进行密码修改；修改完成，下次登录即可以使用新密码登录。
								</p>
							</div>
						</article>

						<article class="faq-item">
							<span class="faq-icon"></span>
							<h3 class="faq-question">
								<a href="#">不能正常登陆系统的可能情况</a>
							</h3>
							<div class="faq-answer">
								<p>
								*网络连接问题，请查看电脑是否连接网络</p>
								<p>*浏览器未升级或兼容性问题，（推荐使用Chrome浏览器）</p>
								<p>*杀毒软件设置问题，请将杀毒软件退出重新登录
								</p>
							</div>
						</article>

					<%-- 	<article class="faq-item">
							<span class="faq-icon"></span>
							<h3 class="faq-question">
								<a href="#">Why Choose WordPress?</a>
							</h3>
							<div class="faq-answer">
								<p>
									One of the principle advantages of WordPress is that you are in
									control. Unlike remote-hosted scripts such as&nbsp;<a
										title="http://www.blogger.com" href="http://www.blogger.com/">Blogger</a>&nbsp;and&nbsp;<a
										title="http://www.livejournal.com"
										href="http://www.livejournal.com/">LiveJournal</a>, you host
									WordPress on your own server. Installation is very simple, as
									is the configuration. Unlike other software programs, there are
									not a million files to&nbsp;<a
										title="Changing File Permissions"
										href="http://codex.wordpress.org/Changing_File_Permissions">chmod</a>&nbsp;nor
									are there dozens of&nbsp;<a title="Templates"
										href="http://codex.wordpress.org/Templates">templates</a>&nbsp;to
									edit just to get your site set up and looking the way you want.
								</p>
								<p>
									Also,&nbsp;<a title="Glossary"
										href="http://codex.wordpress.org/Glossary#Blogging">Blog</a>&nbsp;pages
									in WordPress are generated on the fly whenever a page is
									requested, so you do not have multiple archive pages clogging
									up your web space. Waiting for pages to rebuild is a thing of
									the past because template changes are made in scant seconds.
								</p>
								<p>
									WordPress is built following&nbsp;<a title="http://www.w3.org/"
										href="http://www.w3.org/">W3C</a>&nbsp;standards for&nbsp;<a
										title="Glossary"
										href="http://codex.wordpress.org/Glossary#XHTML">XHTML</a>&nbsp;and&nbsp;<a
										title="Glossary"
										href="http://codex.wordpress.org/Glossary#CSS">CSS</a>,
									ensuring that your site is more easily rendered across
									standards-compliant browsers. Other browsers are supported with
									a few hacks; it’s a reality of the web that hacks are
									necessary.
								</p>
								<p>
									<a title="Glossary"
										href="http://codex.wordpress.org/Glossary#News_reader">Aggregator</a>&nbsp;support
									is built-in with a number of standard&nbsp;<a title="Glossary"
										href="http://codex.wordpress.org/Glossary#RSS">RSS</a>&nbsp;configurations
									already done for you, as well as&nbsp;<a title="Glossary"
										href="http://codex.wordpress.org/Glossary#Atom">Atom</a>.
									Following standards makes your WordPress site easier to manage,
									increases its longevity for future Internet technology
									adoption, and helps give your site the widest audience
									possible.
								</p>
							</div>
						</article> --%>
					</div>

				</div>
				<!-- end of page content -->


				<!-- start of sidebar -->
				<aside class="span4 page-sidebar">

					<section class="widget">
						<div class="support-widget">
							<h3 class="title">支持帮助</h3>
					        <p class="intro">需要更多支持？ 如果您没有找到答案，请联系我们获取进一步的帮助。</p>
						</div>
					</section>

<!-- 
					<section class="widget">
						<h3 class="title">Latest Articles</h3>
						<ul class="articles">
							<li class="article-entry standard">
								<h4>
									<a href="single.html">Integrating WordPress with Your
										Website</a>
								</h4> <span class="article-meta">25 Feb, 2013 in <a href="#"
									title="View all posts in Server &amp; Database">Server
										&amp; Database</a></span> <span class="like-count">66</span>
							</li>
							<li class="article-entry standard">
								<h4>
									<a href="single.html">WordPress Site Maintenance</a>
								</h4> <span class="article-meta">24 Feb, 2013 in <a href="#"
									title="View all posts in Website Dev">Website Dev</a></span> <span
								class="like-count">15</span>
							</li>
							<li class="article-entry video">
								<h4>
									<a href="single.html">Meta Tags in WordPress</a>
								</h4> <span class="article-meta">23 Feb, 2013 in <a href="#"
									title="View all posts in Website Dev">Website Dev</a></span> <span
								class="like-count">8</span>
							</li>
							<li class="article-entry image">
								<h4>
									<a href="single.html">WordPress in Your Language</a>
								</h4> <span class="article-meta">22 Feb, 2013 in <a href="#"
									title="View all posts in Advanced Techniques">Advanced
										Techniques</a></span> <span class="like-count">6</span>
							</li>
						</ul>
					</section> -->

			
				 </aside>
				<!-- end of sidebar -->
			</div>
		</div>
	</div>
	
	<a href="#top" id="scroll-top"></a>

	  <!-- script -->
       <script type='text/javascript' src='<%=path%>/assets4/js/jquery-1.8.3.min.js'></script>
        <script type='text/javascript' src='<%=path%>/assets4/js/jquery.easing.1.3.js'></script>
              <script type='text/javascript' src='<%=path%>/assets4/js/prettyphoto/jquery.prettyPhoto.js'></script>
                <script type='text/javascript' src='<%=path%>/assets4/js/jflickrfeed.js'></script>
                <script type='text/javascript' src='<%=path%>/assets4/js/jquery.liveSearch.js'></script>
                <script type='text/javascript' src='<%=path%>/assets4/js/jquery.form.js'></script>
                <script type='text/javascript' src='<%=path%>/assets4/js/jquery.validate.min.js'></script>
                <script type='text/javascript' src='<%=path%>/assets4/js/custom.js'></script>
    <script type="text/javascript">
         function sear(){ 
		location.href="selectNewArticle_list.jsp?id="+document.getElementById("s").value;
	 }
                </script>


</body>
</html>


