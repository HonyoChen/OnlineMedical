<%@ page import="com.cn.POJO.User"%>
<%@ page import="com.cn.POJO.Patient"%>
<%@page import="java.text.*"%>
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
	String birthday = DateFormat.getDateInstance().format(patient.getBirthday());
%>
<!DOCTYPE html>
<html>
<head>
<title>挂号</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<script type="text/javascript" src="../gyscripts/jquery/jquery-1.7.1.js"></script>
<link href="../gystyle/authority/basic_layout.css" rel="stylesheet"
	type="text/css">
<link href="../gystyle/authority/common_style.css" rel="stylesheet"
	type="text/css">

<link rel="apple-touch-icon" sizes="76x76"
	href="../assets/img/apple-icon.png">
<link rel="icon" type="image/png" href="../assets/img/favicon.png">
<link href="../css/user.main.css" rel="stylesheet" />
<link href="..css/user.all.css" rel="stylesheet">
<link href="../css/bootstrapMM.min.css" rel="stylesheet" />
<link href="../css/now-ui-dashboard.css?v=1.0.1" rel="stylesheet" />
<link href="../css/demo.css" rel="stylesheet" />
<script type="text/javascript" src="../js/jquery.min.js"></script>
<script type="text/javascript" src="../js/layer.js"></script>
<link rel="stylesheet" type="text/css" href="../css/layer.css" />

<script type="text/javascript" src="gyscripts/authority/commonAll.js"></script>
<script type="text/javascript"	src="../gyscripts/jquery/jquery-1.4.4.min.js"></script>
<script src="../gyscripts/My97DatePicker/WdatePicker.js"type="text/javascript" defer="defer"></script>
<script type="text/javascript"	src="../gyscripts/artDialog/artDialog.js?skin=default"></script>

<!-- 上传照片 -->
<link rel="stylesheet" type="text/css" href="../imgstyle/webuploader.css" />
<link rel="stylesheet" type="text/css" href="../imgstyle/style.css" />
<script src="../imgstyle/jquery-1.9.min.js"></script>
<script src="../imgstyle/webuploader.js"></script>
<script src="../imgstyle/jquery.sortable.js"></script>
<script src="../imgstyle/upload.js"></script>
<style>
	.width_auto{
		width: 100%;
		height:400px;
		margin: 100px auto; 
	}
</style>


<script type="text/javascript">
	var did;//医生id

	$(document).ready(function() {
		
		var url = decodeURI(window.location.href);
		var index = url.indexOf('fyID=');
		did = url.substr(index+5);
		//alert(did);	
		var pn = ('<%=name%>');
		var ps = ('<%=sex%>');
		var pi = ('<%=id%>');
		var birthday = ('<%=birthday%>');
		//alert("birthday : "+ JSON.stringify(birthday));
		birthday = birthday.replace("T", " ");
		birthday = birthday.replace(/-/g, "/");
		var start = new Date(birthday);
		var end = new Date();
		//alert("start "+JSON.stringify(start));
		//alert("end " +JSON.stringify(end));
		
		var pa = Math.ceil((end - start) / (1000 * 3600 * 24 * 365)); //向上取整

		document.getElementById('name').value = pn;
		document.getElementById('sex').value = (ps == 1 ? "男" : "女");
		//alert("age :" + JSON.stringify(pa));
		document.getElementById('age').value = pa;
		//提交
		//$(document).on('click', '#submitbutton', function() {
	$("#submitbutton").click(function() {
	//$(document).click('#submitbutton', function() {
		layer.confirm('您确认挂号吗？',function(index){		
			$.ajax({
				url : "addDandp",
				type : "POST",
				data : {
					"pid" : ('<%=id%>'),
					"did" : did,
					"part" : document.getElementById('fyDh').value,
					"content" : document.getElementById('content').value
				},
				dataType : "JSON",
				success : function(result) {
					//$(obj).parents("tr").remove();
				layer.alert('挂号成功!',{
					icon:1,
					yes:function(){
						window.parent.location.reload();
					}});				
					
				},
				error : function(result) {
					//layer.alert("挂号失败，请刷新页面重试");
					//window.location.reload();
					layer.alert('请求失败!请刷新重试',{
						icon:2,
						yes:function(){
							window.location.reload();
						}
					});
				}
			});
		});
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
	});
	//挂号
	function registration(){
		$.ajax({
			url : "addDandp",
			type : "POST",
			data : {
				"pid" : ('<%=id%>'),
				"did" : did,
				"part" : document.getElementById('fyDh').value,
				"content" : document.getElementById('content').value
			},
			dataType : "text",
			success : function(result) {
				alert(result);
			},
			error : function(result) {
				//alert("返回数据失败，请刷新页面");
				//alert('error:' + result);
				layer.alert('请求失败!请刷新重试',{
						icon:2,
						yes:function(){
							//window.location.reload();
						}
				});
			}
		});
	}

	/* 	document.getElementById('name').value = obj.patient.name.toString();
		document.getElementById('sex').value = (obj.patient.sex==1?"男":"女"); */
</script>
</head>
<body>
	<div id="nav_links">
		当前位置：管理平台&nbsp;>&nbsp;<span style="color: #1A5CC6;">挂号</span>
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
						style="width:120px;text-align:center;font-size:16px;" disabled=""
						placeholder="用户名" value=""> &nbsp;&nbsp;&nbsp;&nbsp; <label
						style="font-size:16px;font-weight:bold;">性别&nbsp;</label> <input
						type="text" id="sex" class="form-control"
						style="width:50px;text-align:center;font-size:16px;" disabled=""
						placeholder="性别" value=""> &nbsp;&nbsp;&nbsp;&nbsp; <label
						style="font-size:16px;font-weight:bold;">年龄&nbsp;</label> <input
						type="text" id="age" class="form-control"
						style="width:50px;text-align:center;font-size:16px;" disabled=""
						placeholder="年龄" value=""> &nbsp;&nbsp;&nbsp;&nbsp; <label
						style="font-size:16px;font-weight:bold;">选择发病部位&nbsp;</label> <select
						name="fangyuanEntity.fyDhCode" id="fyDh" class="ui_select01">
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
			<div class="card">
					<div class="card-header">
						<h5 class="title">病情描述</h5>
					</div>
					<textarea id="content"	style="width:100%;height:200px;outline:none;border-style:dashed; border-radius:20px;resize:none; padding:10px 10px;overflow-y:auto;"></textarea>
			</div> 
		<div class="card"> 
		    <div id="container" > 
		        <!--头部，相册选择和格式选择-->
		        <div id="uploader"   >
		            <div class="item_container">
		                <div id="" class="queueList" style="height:250px;"  >
		                    <div id="dndArea" class="placeholder" >
		                      <div id="filePicker" style="margin-top:160px;"></div>
		                    </div>
		                    
		                </div>
		            </div>
		            <div class="statusBar" style="display:none;">
		                <div class="progress" >
		                    <span class="text">0%</span>
		                    <span class="percentage"></span>
		                </div><div class="info"></div>
		              <div class="btns">
		                    <div id="filePicker2"></div><div class="uploadBtn">开始上传</div> 
		                </div> 
		            </div>
		        </div>
		  </div>
		</div>  
			
				
			</form>
		</div>
	</div>
	<input id="submitbutton" type="button" value="提交" 	class="ui_input_btn01" style="margin-left:300px;" />



</body>
</html>