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
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>留言</title>

<!-- <script type="text/javascript" src="../js/jquery.min.js"></script>
<script type="text/javascript" src="../js/layer.js"></script> -->
<!-- <script type="text/javascript">
	function changeBgColor() {
		button.style.backgroundColor = "#556";
	}
</script> -->
<link href="https://fonts.googleapis.com/css?family=Poppins:300,500,600"
	rel="stylesheet">
	<link rel="stylesheet" type="text/css" href="../css/message.css" />
	<link rel="stylesheet" type="text/css" href="../css/layer.css" />
	<link rel="stylesheet" href="../css/linearicons.css">
		<script type="text/javascript"
			src="../gyscripts/jquery/jquery-1.7.1.js"></script>
		<script type="text/javascript" src="../js/jquery.min.js"></script>
		<script type="text/javascript" src="../js/layer.js"></script>
		<script type="text/javascript">
			var uid = ('<%=user.getUid()%>');
			function submitMessage() {
				//alert("提交留言信息:" );
				layer.confirm('确定提交留言内容？', '确定', function() {
					$.ajax({
						url : "saveMessage",
						type : "POST",
						data : {
							"method" : 1,
							"uid" : uid,
							"type" : document.getElementById("messageType").value,
							"title" : document.getElementById("mtitle").value,
							"content" : document.getElementById("mcontent").value
						},
						dataType : "text",
						//async : false,
		
						success : function(data) {
							//alert("提交成功");
							layer.alert('提交成功!', {
								icon : 1,
								yes : function() {
									document.getElementById("messageType").value = "";
									document.getElementById("mtitle").value = "";
									document.getElementById("mcontent").value = "";
									window.location.reload();
								}
							});
						},
						error : function(data) {
							layer.alert('请求失败，请刷新重试!', {
								icon : 2,
								yes : function() {
									window.location.reload();
								}
							});
						}
					});
				});
			}
		</script>
</head>
<body>
	<div class="container">

		<div class="top"
			style="margin-bottom:10px;margin-top:10px;height:50px;background-color:transparent">
			<h1 class="h1" style="margin-left:-100px;">留言</h1>
		</div>

		<div class="main">
			<!-- <form id="myForm" action="mail.php" method="post" class="contact-form"> -->
			<div class="main-top"
				style="width:300px;margin-left:10px;display:inline;">
				<br>
					<p style="margin-left:-20px;">
						类别&nbsp;&nbsp; <select id="messageType"
							style="width:100px;height:30px; background-image:url( '../images/img/main_bg.gif');text-align:center;text-align-last: center;">

							<option value="">--请选择--</option>
							<option value="0">--意见建议--</option>
							<option value="1">--投诉举报--</option>
						</select> 标题&nbsp;&nbsp;<input type="title" class="标题" name="title" id="mtitle"
							style="width:200px;height:30px;  background-image:url( '../images/img/main_bg.gif');margin-bootom:10px;"
							placeholder="请输入您的留言标题"
							pattern="[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{1,63}$"
							onfocus="this.placeholder = ''"
							onblur="this.placeholder = '请输入您的留言标题'" required>
					</p> </br>
			</div>

			<div class="main-content" style="width:400px;height:200px;">
				<!-- <p style="margin:10px auto;">留言内容</p> -->
				<div class="input"
					style=" text-align:center; vertical-align:middel;">
					<input name="content" id="mcontent"
						style="width:400px;height:250px;margin-top:10px;margin-left:-70px;text-align:center; vertical-align:middel; background-image:url( '../images/img/game_03.jpg'); font-size:20px;resize:none;"
						placeholder="请输入您的留言内容" onfocus="this.placeholder = ''"
						onblur="this.placeholder = '请输入您的留言内容'" required> <!-- </textarea> -->
				</div>

			</div>

			<div class="submit"
				style="margin-top:100px;margin-left:-90px;text-align:center;">
				<button
					class="mt-10 primary-btn d-inline-flex text-uppercase align-items-center"
					style="background-image:url( '../images/img/02.png');outline:none;"
					onclick="submitMessage()">
					提交<span class="lnr lnr-arrow-right"></span>
				</button>
			</div>
		</div>
	</div>

	</div>
</body>
</html>