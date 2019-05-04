<%@page import="com.cn.POJO.User"%>
<%@page import="com.opensymphony.xwork2.ActionContext"%>
<%@ page contentType="text/html;charset=UTF-8" language="java"
	import="java.util.*" pageEncoding="UTF-8"%>
<taglib prefix="s" uri="/struts-tags">
<%
 	String path = request.getContextPath();
 	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
 			+ path + "/";
 	User user = (User) ActionContext.getContext().getSession().get("loginUser");
%>
<!DOCTYPE html>
<html lang="en">
<head>
<!-- base href -->

<title>重置密码</title>

<!-- <meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<link rel="stylesheet" type="text/css" href="styles.css">
-->

<meta name="viewport" content="width=device-width, initial-scale=1">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="keywords"
	content="User Profile Form A Responsive Widget,Login form widgets, Sign up Web forms , Login signup Responsive web form,Flat Pricing table,Flat Drop downs,Registration Forms,News letter Forms,Elements" />

<!-- Meta tag Keywords -->
<!-- css files -->
<link href="<%=path%>/css/style.css" rel="stylesheet" type="text/css"
	media="all">
<link rel="stylesheet" href="<%=path%>/css/font-awesome.css">
<!-- Font-Awesome-Icons-CSS -->
<!-- //css files -->
<!-- online-fonts -->
<link href="//fonts.googleapis.com/css?family=Raleway" rel="stylesheet">
<link href="//fonts.googleapis.com/css?family=Lato" rel="stylesheet">
<link rel="stylesheet" type="text/css" href="<%=path%>/css/bootstrapM.min.css">
<link rel="stylesheet" type="text/css" href="<%=path%>/css/main.css">
<!--//online-fonts -->

<script type="text/javascript" src="<%=path%>/js/jquery-3.2.1.min.js"></script>
<Script>
	var statusOriginPassword = true;
	var statusPassword = true;
	var statusResetPassword = true;

	//校验当前密码是否相同
	function checkOriPwd(){
		var passWord = "<%=user.getPassword() %>";
		
		var password2 = document.getElementById("originpassword");
		if(passWord != password2.value)
		{
			document.getElementById('erroriginpassword').innerHTML = '<font style="color:red;font-size:5px;" >密码错误</font>';
			statusOriginPassword = true;
		}
		else if(passWord == password2.value)
		{
			document.getElementById('erroriginpassword').innerHTML = '<font style="font-size:16px;"><i class="fa fa-check" aria-hidden="true"></i></font>';
			statusOriginPassword = false;
			document.getElementById('bt1').disabled = statusOriginPassword || statusPassword || statusResetPassword;
		}
		
	}
	
	//校验密码
	function checkPassword() {
		document.getElementById('bt1').disabled = true;
		var password = document.getElementById("password");
		var password2 = document.getElementById("originpassword");
		var reg = /^(?![^a-zA-Z]+$)(?!D+$).{6,}$/; //正则

		if (password.value == null || password.value == '') {
			document.getElementById('errpassword').innerHTML = '<font style="color:red;font-size:5px;" >新密码不能为空</font>';
			statusPassword = true;
		} else {
			document.getElementById('errpassword').innerHTML = '<font ></font>';

			if (!(reg.test(password.value.toString()))) {
				document.getElementById('errpassword').innerHTML = '<font style="color:red;font-size:5px;">6位以上必须含有字母</font>';
				statusPassword = true;
			} else {
				statusPassword = false;
				document.getElementById('errpassword').innerHTML = '<font style="font-size:16px;"><i class="fa fa-check" aria-hidden="true"></i></font>';
				document.getElementById('bt1').disabled = statusOriginPassword || statusPassword || statusResetPassword;
			}
		}
	}
	//校验密码
	function checkResetPassword() {
		var pwd1 = document.getElementById("password").value;
		var pwd2 = document.getElementById("resetpassword").value;
		<!-- 对比两次输入的密码 -->
		if (pwd2 == null || pwd2 == '') {
			document.getElementById('errresetpassword').innerHTML = '<font style="color:red;font-size:5px;">确认密码不能为空</font>';
			statusResetPassword = true;
		}
		else{
		
			if(pwd1 != pwd2)
			{
				document.getElementById('errresetpassword').innerHTML = '<font color="red" style="font-size:5px;" >密码不同，请重新輸入</font>';
				statusResetPassword = true;			
			}
			else if(pwd1 == pwd2){
			
				document.getElementById('errresetpassword').innerHTML = '<font style="font-size:16px;"><i class="fa fa-check" aria-hidden="true"></i></font>';
				statusResetPassword = false;
				document.getElementById('bt1').disabled = statusOriginPassword || statusPassword || statusResetPassword;
			}
		} 		
	}
	
	function func(){
		
		alert("statusOriginPassword " + statusOriginPassword);
		alert("statusPassword " + statusPassword);
		alert("statusResetPassword " + statusResetPassword);
	}
</Script>
</head>

<body>
	<div class="w3-main" style="color:#000;width:500px;margin-top:130px;">
		<div class="form-w3l" style="background:#fff; border-radius:10px">
			<form action="resetPwd" id="form" name="form" method="post"
				namespace="/pages">
				<div
					style="font-size:32px;color:#333;text-align:center;padding-bottom:39px;">
					重置密码</div>
					
			   <div class="w3l-password">
					<span><i class="fa fa-lock w3l-2" aria-hidden="true"></i></span> <input
						type="password" id="originpassword" name="originpassword"
						placeholder="请输入当前密码" required="" style="display:inline;width:50%;" onblur = "checkOriPwd();" /> 
						<span id="erroriginpassword"style="display:inline;width:40%;"></span>
					<div class="clear"></div>
				</div>

				<div class="w3l-password">
					<span><i class="fa fa-lock w3l-2" aria-hidden="true"></i></span> <input
						type="password" id="password" name="password"
						placeholder="请输入6位以上的新密码" required="" onblur="checkPassword();"
						style="display:inline;width:50%;" /> <span id="errpassword"
						style="display:inline;width:40%;"></span>
					<div class="clear"></div>
				</div>

				<div class="w3l-password">
					<span><i class="fa fa-lock w3l-2" aria-hidden="true"></i></span> <input
						type="password" id="resetpassword" name="resetpassword"
						placeholder="请再次输入新密码" required="" onblur="checkResetPassword();"
						style="display:inline;width:50%;" /> <span id="errresetpassword"
						style="display:inline;width:40%;"></span>
					<div class="clear"></div>
				</div>

				<div class="container-login100-form-btn" style="margin-top:20px;">
					<div class="wrap-login100-form-btn">
						<div class="login100-form-bgbtn"></div>
						<button class="login100-form-btn" disabled="disabled" id="bt1">重置</button>
					</div>
				</div>
			</form>
		</div>
	</div>
</body>
</html>