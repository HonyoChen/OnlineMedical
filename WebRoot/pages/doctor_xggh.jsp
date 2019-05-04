<%@ page import="com.cn.POJO.User"%>
<%@ page import="com.cn.POJO.Patient"%>
<%@ page import="com.opensymphony.xwork2.ActionContext"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<taglib prefix="s" uri="/struts-tags">
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	User user = (User) ActionContext.getContext().getSession().get("loginUser");
	
	Patient patient = user.getPatient();
	String name = patient.getName();
	int id = patient.getPid();
	int sex = patient.getSex();
	Date birthday = patient.getBirthday();
%>
<!DOCTYPE html>
<html>
<head>
<title>挂号</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<script type="text/javascript" src="gyscripts/jquery/jquery-1.7.1.js"></script>
<link href="../gystyle/authority/basic_layout.css" rel="stylesheet" type="text/css">
<link href="../gystyle/authority/common_style.css" rel="stylesheet" type="text/css">
<link rel="apple-touch-icon" sizes="76x76" 	href="../assets/img/apple-icon.png">
<link rel="icon" type="image/png" href="../assets/img/favicon.png">
<link href="../css/user.main.css" rel="stylesheet" />
<link href="..css/user.all.css" rel="stylesheet">
<link href="../css/bootstrapMM.min.css" rel="stylesheet" />
<link href="../css/now-ui-dashboard.css?v=1.0.1" rel="stylesheet" />
<link href="../css/demo.css" rel="stylesheet" />
<script type="text/javascript" src="../js/jquery.min.js"></script>
<script type="text/javascript" src="../js/layer.js"></script>
<link rel="stylesheet" type="text/css" href="../css/layer.css" />
<script type="text/javascript" src="../gyscripts/authority/commonAll.js"></script>
<script type="text/javascript"	src="../gyscripts/jquery/jquery-1.4.4.min.js"></script>
<script src="../gyscripts/My97DatePicker/WdatePicker.js" type="text/javascript" defer="defer"></script>
<script type="text/javascript" 	src="../gyscripts/artDialog/artDialog.js?skin=default"></script>
<script type="text/javascript">
	var ghid;//挂号记录ID，用于修改挂号信息
	$(document).ready(function() {
		var testt = decodeURI(window.location.href);
		var index = testt.indexOf('fyID=');
		var obj = JSON.parse(testt.substr(index + 5));		
		ghid = obj["dandps"][0].id;
		//alert(ghid);
		/* for(var key in obj){
			alert(key + ":" + obj[key]);
			if(key.toString() == "dandps"){
				var o = obj[key][0];
				for(var ke in o){
					alert(ke);
				}
			}
		} */

		var pn = ('<%=name%>');
		var ps = ('<%=sex%>');
		var pi = ('<%=id%>');
		var birthday = ('<%=birthday%>');
		birthday = birthday.replace("T", " ");
		birthday = birthday.replace(/-/g, "/");
		var start = new Date(birthday);
		var end = new Date();
		var pa = Math.ceil((end - start) / (1000 * 3600 * 24 * 365)); //向上取整

		document.getElementById('name').value = pn;
		document.getElementById('sex').value = (ps == 1 ? "男" : "女");
		document.getElementById('age').value = pa;

		document.getElementById('fbbw').value = obj.dandps[0].part;
		document.getElementById('desc').value = obj.dandps[0].description.toString();

		/* 提交 */
		/* $("#submitbutton").click(function() {
			if (validateForm()) {
				checkFyFhSubmit();
			}
		}); */

		/*
		 * 取消
		 */
		$("#cancelbutton").click(function() {
			/**  关闭弹出iframe  **/
			window.parent.$.fancybox.close();
		});

		var result = 'null';
		if (result == 'success') {
			/**  关闭弹出iframe  **/
			window.parent.$.fancybox.close();
		}
	});
	
	function changeDandp(){
	  layer.confirm('确认要修改挂号内容吗？',function(index){
			$.ajax({
				type: 'POST',
				url: 'updateDandp',
				data : {
					"id" : ghid,
					"part" : document.getElementById("fbbw").value,
					"desc" : document.getElementById("desc").value
				},
				dataType: 'text',
				success: function(data){
					layer.alert('修改成功!',{
						icon:1,
						yes:function(){
							window.parent.location.reload();
						}});
				},
				error:function(data) {
					//console.log(data);
					layer.alert('请求失败!请刷新重试',{
						icon:2,
						yes:function(){
							//window.location.reload();
						}
					});
				},
			});
		});
	}
</script>
</head>
<body>
	<div id="nav_links">
		当前位置：管理平台&nbsp;>&nbsp;<span style="color: #1A5CC6;">修改挂号信息</span>
		<div id="page_close">
			<a href="javascript:parent.$.fancybox.close();"> <img
				src="gyimages/common/page_close.png" width="20" height="20"
				style="vertical-align: text-top;" />
			</a>
		</div>
	</div>
	<div class="card">
		<div class="card-header">
			<h5 class="title">基本信息</h5>
		</div>
		<div class="card-body">
			<form>
				<div>
					<label style="font-size:16px;font-weight:bold;">姓名&nbsp;</label> <input
						type="text" id="name" class="form-control"
						style="width:80px;text-align:center;font-size:16px;" disabled=""
						placeholder="用户名" value=""> &nbsp;&nbsp;&nbsp;&nbsp; <label
						style="font-size:16px;font-weight:bold;">性别&nbsp;</label> <input
						type="text" id="sex" class="form-control"
						style="width:50px;text-align:center;font-size:16px;" disabled=""
						placeholder="性别" value=""> &nbsp;&nbsp;&nbsp;&nbsp; <label
						style="font-size:16px;font-weight:bold;">年龄&nbsp;</label> <input
						type="text" id="age" class="form-control"
						style="width:50px;text-align:center;font-size:16px;" disabled=""
						placeholder="年龄" value=""> &nbsp;&nbsp;&nbsp;&nbsp; <label
						style="font-size:16px;font-weight:bold;">选择发病部位&nbsp;</label>
					<select
						name="fangyuanEntity.fyDhCode" id="fbbw" class="ui_select01">
						<option value="">--请选择--</option>
						<option value="0">全身</option>
						<option value="1">头部</option>
						<option value="2">颈部</option>
						<option value="3">胸部</option>
						<option value="4">腹部</option>
						<option value="5">腰部</option>
						<option value="6">背部</option>
						<option value="7">皮肤</option>
						<option value="8">四肢</option>
						<option value="9">男科</option>
						<option value="10">妇科</option>
					</select>
				</div>
			</form>
		</div>
	</div>
	<div class="card">
		<div class="card-header">
			<h5 class="title">病情描述</h5>
		</div>
		<textarea id="desc"
			style="width:100%;height:200px;outline:none;border-style:dashed; border-radius:20px;resize:none; padding:10px 10px;overflow-y:auto;"></textarea>
		<button id="submitbutton" type="button" onclick="changeDandp()"
			class="ui_input_btn01" style="margin-left:300px;">提交修改</button>
	</div>



</body>
</html>