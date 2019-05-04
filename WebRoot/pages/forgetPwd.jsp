<%@ page contentType="text/html;charset=UTF-8" language="java"
	import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.opensymphony.xwork2.ActionContext"%>
<taglib prefix="s" uri="/struts-tags"> <%
 	String path = request.getContextPath();
 	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
 			+ path + "/";
 %> <!DOCTYPE html>
<html lang="zh-CN">

<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">

<title>忘记密码</title>
<meta name="keywords" content="" />
<meta name="description" content="" />

<link rel="stylesheet" type="text/css"
	href="<%=path%>/css/bootstrapM.min.css">
<link rel="stylesheet" type="text/css"
	href="<%=path%>/css/font-awesome.min.css">
<link rel="stylesheet" type="text/css"
	href="<%=path%>/fonts/iconic/css/material-design-iconic-font.min.css">
<link rel="stylesheet" type="text/css" href="<%=path%>/css/util.css">
<link rel="stylesheet" type="text/css" href="<%=path%>/css/main.css">

<script src="<%=path%>/js/jquery-3.2.1.min.js"></script>
<script src="<%=path%>/js/main.js"></script>
<Script>
	var status;
	//校验邮箱是否注册
	function checkEmail() {
		document.getElementById('skip').disabled = true;
		var email = document.getElementById("email");
		var reg = /^[a-zA-Z0-9_.-]+@[a-zA-Z0-9-]+(\.[a-zA-Z0-9-]+)*\.[a-zA-Z0-9]{2,6}$/;
		if (email.value == null || email.value == '') {
			//alert("123");
			document.getElementById('erremail').innerHTML = '<font style="color:red;font-size:5px;">邮箱不能为空</font>';
		} else {
			document.getElementById('erremail').innerHTML = '<font style="color:red"></font>';
			if (!(reg.test(email.value.toString()))) {
			//	alert("郵箱輸入錯誤");
				document.getElementById('erremail').innerHTML = '<font style="color:red;font-size:5px;">请输入正确的邮箱</font>';
			} else {
				verify('email', $("#email").val());
				if (status == "0") {
					//alert("查詢不到郵箱");
					document.getElementById('erremail').innerHTML = '<font style="color:red;font-size:5px;">该邮箱未注册</font>';
				}
				else {
					//alert("status " + status);
					document.getElementById('erremail').innerHTML = '<font style="font-size:16px;"><i class="fa fa-check" aria-hidden="true"></i></font>';
					document.getElementById('skip').disabled = false;

				}
			}
		}
	}

	function verify(method, value) {
		$.ajax({
			url : "isRegister",
			type : "POST",
			data : {
				"method" : method,
				"parameter" : value
			},
			dataType : "text",
			async : false,
			success : function(data) {
				status = data;
			},
			error : function(data) {
				alert("失败");
				alert('error:' + data);
			}
		})
	}
</Script>

</head>

<body>
	<div class="limiter">
		<div class="container-login100"
			style="background-image: url('<%=path%>/images/bg-01.jpg');">
			<div class="wrap-login100 p-l-55 p-r-55 p-t-65 p-b-54">
				<form class="login100-form validate-form" action="resetPwdByEmail" method="post">
					<h3>
						<span class="login100-form-title p-b-49">邮箱找回密码</span>
					</h3>

					<div class="w3l-email">
						<span><i class="fa fa-envelope-o w3l-3" aria-hidden="true"></i></span>
						<input type="email" id="email" name="email" placeholder="请输入注册邮箱"
							required="" style="display:inline;width:60%;"
							onblur="checkEmail()" /> <span id="erremail"
							style="display:inline;width:30%;"></span>
						<div class="clear"></div>
					</div>
					<div class="container-login100-form-btn" style="margin-top:40px;">
						<div class="wrap-login100-form-btn">
							<div class="login100-form-bgbtn"></div>
							<button class="login100-form-btn" disabled="disabled" id="skip">确认并跳转到邮箱</button>
						</div>
					</div>
				</form>
			</div>
		</div>
	</div>
</body>
</html>