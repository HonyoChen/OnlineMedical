<%@ page import="com.cn.POJO.User"%>
<%@ page import="com.opensymphony.xwork2.ActionContext"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<taglib prefix="s" uri="/struts-tags"> 
<%
 	String path = request.getContextPath();
 	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
 			+ path + "/";
 	User user = (User) ActionContext.getContext().getSession().get("loginUser");
 %>
 
<!DOCTYPE html>
<html class="no-js">
<head>
<!-- Mobile Specific Meta -->
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<!-- Favicon-->
<link rel="shortcut icon" href="img/fav.png">
<!-- Author Meta -->
<meta name="author" content="CodePixar">
<!-- Meta Description -->
<meta name="description" content="">
<!-- Meta Keyword -->
<meta name="keywords" content="">
<!-- meta character set -->
<meta charset="UTF-8">
<!-- Site Title -->
<title>留言</title>
<link rel="stylesheet" type="text/css" href="../css/layer.css" />
<script type="text/javascript" src="../js/jquery.min.js"></script>
<script type="text/javascript" src="../js/layer.js"></script>
<!-- <script type="text/javascript">
	function changeBgColor() {
		button.style.backgroundColor = "#556";
	}
</script> -->
<link href="https://fonts.googleapis.com/css?family=Poppins:300,500,600" rel="stylesheet">
<!--
		CSS
		============================================= -->
<link rel="stylesheet" href="../css/linearicons.css">
<link rel="stylesheet" type="text/css" href="../css/message.css" />
<script type="text/javascript" src="<%=path %>/gyscripts/jquery/jquery-1.7.1.js"></script>

</head>
<body>
<div class="bg_top">
  <div class="header_bg">
  <div class="header" style="padding:10px;">
  <a href="#" title="star health"><img src="../images/logo.png"></a>
  </div>
  </div>
</div>
<div class="page_box page_box_bg" >
	<div class="t_box">
     <iframe width="570" height="516" class="share_self"  style="margin:60px auto auto 130px;" frameborder="0" scrolling="no" src="../pages/t.jsp">
     	
     </iframe>
    
    </div> 
  
</div>
<div class="page_bot"></div>
<div class="footer" style="margin-top:10px;">
	<div class="footer_left" style="margin-left:80px;"><p><h6 class="text-uppercase mb-15">投诉中心邮箱：service@trioo.com<br>投诉电话:021-54249001</br></h6></p>
	</div>
	<div class="footer_right">
		 <p><h5 class="text-uppercase mb-15">如果您对OnlineMedical有更好的建议和意见,或者对我们的服务有不满意的地方,欢迎您的批评指正.
相信有您的支持,我们一定会做的更好,让用户更加满意!</h5></p>
	</div>
</div>

</body>
</html>