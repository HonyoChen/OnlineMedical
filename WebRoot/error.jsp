<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">

<title>登录失败</title>
<meta name="keywords" content="" />
<meta name="description" content="" />

<link rel="stylesheet" type="text/css" href="../css/bootstrapM.min.css">
<link rel="stylesheet" type="text/css"
	href="../css/font-awesome.min.css">
<link rel="stylesheet" type="text/css"
	href="../fonts/iconic/css/material-design-iconic-font.min.css">
<link rel="stylesheet" type="text/css" href="../css/util.css">
<link rel="stylesheet" type="text/css" href="../css/main.css">
<script type="text/javascript"
	src="<%=path%>/assets4/js/jquery-1.8.3.min.js"></script>
<script type="text/javascript"
	src="<%=path%>/assets4/js/jquery.qrcode.js"></script>
<script type="text/javascript" src="<%=path%>/assets4/js/qrcode.js"></script>
<script type="text/javascript" src="<%=path%>/assets4/js/utf.js"></script>
<script type="text/javascript" src="<%=path%>/assets4/js/pako.min.js"></script>
<script type="text/javascript" src="<%=path%>/assets4/js/angular.min.js"></script>
<link rel="stylesheet" href="<%=path%>/bjstyle/css/bootstrap.min.css">
<script src="<%=path%>/bjstyle/js/bootstrap.min.js"></script>
<script type="text/javascript" src="<%=path%>/assets4/js/newJs.js"></script>
<link rel="stylesheet" href="<%=path%>/assets4/js/jquery-ui.css">
<script type="text/javascript">		
		function count()
		{    
			var myspan=document.getElementById('myspan');
			var number=myspan.innerHTML;
			number--;
			document.getElementById('myspan').innerHTML=number;
			if(number==0)
			{
			   window.location.href="<%=path%>/pages/login.html"; 
			}
		 }		
		//设置定时器，调用函数
		 setInterval("count()",1000);
	</script>


</head>

<body>

	<div class="limiter">
		<div class="container-login100"
			style="background-image: url('../images/bg-01.jpg');">
			<div class="main"
				style="padding-left:40px;margin-top:-60px;float:center;">

				<h2 class="kern-this">登录失败！</h2>
				<br />

				<button type="button" value="返回首页" id="prev">
					<span id="myspan">5</span>秒后返回登录界面
				</button>
				<div style="clear:both"></div>
			</div>

		</div>
	</div>


	<script>
		url = window.location.href; //获取当前页面的url
		len = url.length; //获取url的长度
		offset = url.indexOf("="); //设置字符串开始的位置
		direct = url.substr(offset + 1, len); //获取参数
		document.getElementById("direct").value = direct;
	</script>
	<script src="../js/jquery-3.2.1.min.js"></script>
	<script src="../js/main.js"></script>
</body>

</html>
