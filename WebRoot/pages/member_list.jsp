<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE HTML>
<html>
<head>
<meta charset="utf-8">
<meta name="renderer" content="webkit|ie-comp|ie-stand">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<meta name="viewport"
	content="width=device-width,initial-scale=1,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no" />
<meta http-equiv="Cache-Control" content="no-siteapp" />
<!--[if lt IE 9]>
<script type="text/javascript" src="lib/html5shiv.js"></script>
<script type="text/javascript" src="lib/respond.min.js"></script>
<![endif]-->
<link rel="stylesheet" type="text/css" href="../css/H-ui.min.css" />
<link rel="stylesheet" type="text/css" href="../css/H-ui.admin.css" />
<link rel="stylesheet" type="text/css"
	href="../js/lib/Hui-iconfont/1.0.8/iconfont.css" />
<link rel="stylesheet" type="text/css" href="../css/skin.css" id="skin" />
<link rel="stylesheet" type="text/css" href="../css/style2.css" />

<link href="<%=path%>/gystyle/authority/common_style.css"
	rel="stylesheet" type="text/css">
<!--[if IE 6]>
<script type="text/javascript" src="lib/DD_belatedPNG_0.0.8a-min.js" ></script>
<script>DD_belatedPNG.fix('*');</script>
<![endif]-->

<title>用户管理</title>
<link rel="stylesheet" type="text/css" href="../css/layer.css" />
  <script type="text/javascript" src="../js/jquery.min.js"></script>
<script type="text/javascript" src="../js/layer.js"></script>
<script type="text/javascript" src="../js/H-ui.min.js"></script>
<script type="text/javascript" src="../js/H-ui.admin.js"></script>
<script type="text/javascript" src="../js/laypage.js"></script>
<script type="text/javascript">

	var oobb;
	
	$(document).ready(function() {
		//alert("2");
		//返回医生列表
		$.ajax({
			url : "SysUsersNoAdmin",
			type : "POST",
			data : {
			},
			dataType : "JSON",
			//async : false,
			/*  	document.getElementById("did").value = data.length;  */
			success : function(data) {
				result = data;
				oobb = data;
				for (var i = 0; i < data.length; i++) {
					addRecord(data[i], i + 1);
				}
				$("#ui_txt_bold04").html(data.length);
			},
			error : function(data) {
				//alert("+++++" + JSON.stringify(data));
				alert("请求失败，请重试");
				//alert(data);
				alert(JSON.stringfy(data));
				/* layer.alert('请求失败，请刷新重试！',{
				icon:1,
				yes:function(){
					window.location.reload();
				}
				}); */
			}
		});
	});
	function cli() {
		//获取控制其它复选框的对象obj
		var collid = document.getElementByIdx_x("all")
		//获取需要全选，全不选功能的所有复选框
		var coll = document.getElementsByName(Obj)
		//如果obj被选中，则全选
		if (collid.checked) {
			//循环设置所有复选框为选中状态
			for (var i = 0; i < coll.length; i++)
				coll[i].checked = true;
		} else { //取消obj选中状态，则全不选
			//循环设置所有复选框为未选中状态
			for (var i = 0; i < coll.length; i++)
				coll[i].checked = false;
		}
	}

	function addRecord(obj, i) {
		var html = "";
		html += "<tr class=\"text-c\">";
		html += "<td><input type=\"checkbox\" value=\"" + obj.uid + "\" name=\"checkb\"></td>";
		html += "<td>" + i + "</td>";
		html += "<td><u style=\"cursor:pointer\" class=\"text-primary\" onclick=\"member_show(\'"+'用户名：'+ obj.username + "\',\'../pages/member-show.html?parameter="+encodeURI(JSON.stringify(obj))+"\',\'10001\',\'420\',\'500\')\">" + obj.username + "</u></td>";
		html += "<td>" + (obj.role == 0 ? "患者" : "医生") + "</td>";
		html += "<td>" + obj.phone + "</td>";
		html += "<td>" + obj.email + "</td>";
		html += "<td>" + obj.uuid + "</td>";
		html += "<td class=\"td-manage\"><a title=\"编辑\" href=\"javascript:;\" onclick=\"member_edit(\'编辑\',\'../pages/member-add2.html?parameter="+encodeURI(JSON.stringify(obj))+"\',\'4\',\'600\',\'580\')\" class=\"ml-5\" style=\"text-decoration:none\"><i class=\"Hui-iconfont\">&#xe6df;</i></a>";
		html += "<a title=\"修改密码\" style=\"text-decoration:none\" class=\"ml-5\" onClick=\"change_password(\'修改密码\',\'../pages/change-password.html?parameter="+encodeURI(JSON.stringify(obj))+"\',\'10001\',\'600\',\'300\')\" href=\"javascript:;\"><i class=\"Hui-iconfont\">&#xe63f;</i></a>";
		html += "<a title=\"删除\" href=\"javascript:;\" onclick=\"member_del(this,\'" + obj.username + "\')\" class=\"ml-5\" style=\"text-decoration:none\"><i class=\"Hui-iconfont\">&#xe6e2;</i></a></td>";
		html += "</tr>";
		$("#ptable").append(html);
	}



	function search() {
		//搜索医生列表
		var rol = document.getElementById("sear").value;
		var count = 0;
		if (rol.toString() == "" || rol.toString() == null) {
			$("#ptable  tr:not(:first)").html("");
			for (var i = 0; i < result.length; i++) {
				var obj = result[i];
				addRecord(obj, i);
			}
			$("#ui_txt_bold04").html(result.length);
		} else {
			if (rol.toString().indexOf("@163.com") != -1 || rol.toString().indexOf("@qq.com") != -1 || rol.toString().indexOf("@snnu.edu.cn") != -1 || rol.toString().indexOf("@") != -1 || (rol.toString().indexOf("18") != -1 && rol.toString().length == 2) || (rol.toString().indexOf("15") != -1 && rol.toString().length == 2) || (rol.toString().indexOf("13") != -1 && rol.toString().length == 2)) {
				alert("请不要输入通配字符：如@、@163.com、@qq.com、@snnu.edu.com,手机号前缀13/15/18");
			} else {
				$("#ptable  tr:not(:first)").html("");
				for (var i = 0; i < result.length; i++) {
					var obj = result[i];
					if (obj.username.toString().indexOf(rol) != -1 || obj.email.toString().indexOf(rol) != -1 || obj.phone.toString().indexOf(rol) != -1 || obj.uuid.toString().indexOf(rol) != -1) {
						addRecord(obj, count);
						count++;
					}
					$("#ui_txt_bold04").html(count);
				}

			}

		}
		$("a.edit").fancybox({
			'width' : 733,
			'height' : 530,
			'type' : 'iframe',
			'hideOnOverlayClick' : false,
			'showCloseButton' : false,
			'onClosed' : function() {}
		});
	}
	//筛选医生列表	
	function filter(){		
		var rol = document.getElementById("fyXq").value;//角色
		var count = 0;	
		$("#ptable  tr:not(:first)").html("");
		if(rol == ""){
			for(var i = 0; i < result.length; i++){
				var obj = result[i];
				addRecord(obj, i+1);
			}
			count = result.length;
		}	 		
		else if(rol.toString() == "0" )//在患者的条件下筛
		{					    
			//$("#ptable  tr:not(:first)").html("");
			for(var i = 0; i < result.length; i++)
			{ 
				var obj = result[i];
				if(obj.role.toString() == rol)
				{
					addRecord(obj, count+1);
					count++;
				}
			}
				// $("ui_txt_bold04").html(count);
		}
		else if( rol.toString() == "1") { //在医生的条件下筛		
			var dep = document.getElementById("fyXq2-1").value;//科室
			var tit = document.getElementById("fyXq2-2").value;//职称
			if(dep == ""){
				if(tit == ""){
					//$("#ptable  tr:not(:first)").html("");
					for(var i = 0; i < result.length; i++)
					{ 
						var obj = result[i];
						if(obj.role.toString() == rol)
						{
							addRecord(obj, count+1);
							count++;
						}
					}
				//$("#ui_txt_bold04").html(result.length);
				}else{
					//$("#ptable  tr:not(:first)").html("");
					for(var i = 0; i < result.length; i++){
						var obj = result[i];
						if( obj.role.toString() == rol && obj.doctor.title.toString() == tit){
							addRecord(obj, count+1);
							count++;
						}
					}
				//$("#ui_txt_bold04").html(count);
				}
			}else{
				if(tit == ""){
					//$("#ptable  tr:not(:first)").html("");
					for(var i = 0; i < result.length; i++){
						var obj = result[i];
						if(obj.role.toString() == rol && obj.doctor.department.toString() == dep){
							//var doctor = obj.doctor;
							addRecord(obj, count+1);
							count++;
						}
					}
				//$("#ui_txt_bold04").html(count);
				}else{
					//$("#ptable  tr:not(:first)").html("");
					for(var i = 0; i < result.length; i++){
						var obj = result[i];
						if(obj.role.toString() == rol && obj.doctor.department.toString() == dep && obj.doctor.title.toString() == tit){
							//var doctor = obj.doctor;
							addRecord(obj, count+1);
							count++;
						}
					}
				//$("#ui_txt_bold04").html(count);
				}
			}
		 
		}
		$("#ui_txt_bold04").html(count);
		$("a.edit").fancybox({
			'width' : 733,
			'height' : 530,
			'type' : 'iframe',
			'hideOnOverlayClick' : false,
			'showCloseButton' : false,
			'onClosed' : function() {
				/* alert("+++++++++3"); */
				// window.location.href = 'doctor_list.jsp'; 
			}
		});
	}

	 $(function() {
		$('.table-sort').dataTable({
			//"aaSorting": [[ 1, "desc" ]],//默认第几个排序
			"bStateSave" : true, //状态保存
			"aoColumnDefs" : [
				//{"bVisible": false, "aTargets": [ 3 ]} //控制列的隐藏显示
				{
					"orderable" : false,
					"aTargets" : []
				} // 制定列不参与排序
			]
		});

	}); 

	/*用户-添加*/
	function member_add(title, url, w, h) {
		layer_show(title, url, w, h);
	}
	/*用户-查看*/
	function member_show(title, url, id, w, h) {
		layer_show(title, url, w, h);
	}

	/*用户-编辑*/
	function member_edit(title, url, id, w, h) {
		layer_show(title, url, w, h);
	}
	/*密码-修改*/
	function change_password(title, url, id, w, h) {
		layer_show(title, url, w, h);
	}
	/*用户-删除*/
	function member_del(obj, username) {
		layer.confirm('确认要删除吗？', function(index) {
			$.ajax({
				url : 'deleteUser',
				type : 'POST',
				data : {
					"username" : username
				},
				dataType : 'text',
				success : function(data) {
					layer.alert('删除成功!',{
						icon:1,
						yes:function(){
							window.location.reload();
						}
					});
					//window.location.reload();
				},
				error : function(data) {
					//console.log(data.msg);
				layer.alert('删除失败!请刷新重试',{
						icon:2,
						yes:function(){
							window.location.reload();
						}
					});
				},
			});
		});
	}

	function query() {
		if (document.getElementById("fyXq").value == '1') {
			document.getElementById("fyXq2").style.display = '';
		} else {
			document.getElementById("fyXq2").style.display = 'none';
		}
	}
	
	function batch_delete(){
		var check = document.getElementsByName("checkb");
		var ids = "";
		for(var k = 1; k < check.length; k++){
			if(check.item(k).checked){
				ids = ids + check.item(k).value + " ";
			}
		}
		//alert(ids);		
		layer.confirm('确认要批量删除用户吗？',function(index){
			$.ajax({
				type: 'POST',
				url: 'batchDeleteUsers',
				data : {
					"ids" : ids
				},
				dataType: 'json',
				success: function(data){
					//$(obj).parents("tr").remove();
					layer.alert('批量删除成功!',{
						icon:1,
						yes:function(){
							window.location.reload();
						}});
				},
				error:function(data) {
					layer.alert('批量删除失败!请刷新重试',{
						icon:2,
						yes:function(){
							window.location.reload();
						}
				  });
				},
			});
		});
	}
</script>

</head>


<body>
	<nav class="breadcrumb">
		<i class="Hui-iconfont">&#xe67f;</i> 管理员系统 <span class="c-gray en">&gt;</span>
		用户管理 <a class="btn btn-success radius r"
			style="line-height:1.6em;margin-top:3px"
			href="javascript:location.replace(location.href);" title="刷新"><i
			class="Hui-iconfont">&#xe68f;</i></a>
	</nav>	
	<div class="page-container">
		<div class="text-c">
			<!-- 日期范围：
		<input type="text" onfocus="WdatePicker({ maxDate:'#F{$dp.$D(\'datemax\')||\'%y-%M-%d\'}' })" id="datemin" class="input-text Wdate" style="width:120px;">
		<input type="text" onfocus="WdatePicker({ minDate:'#F{$dp.$D(\'datemin\')}',maxDate:'%y-%M-%d' })" id="datemax" class="input-text Wdate" style="width:120px;"> -->
			<input type="text" class="input-text" style="width:250px"
				placeholder="输入用户名、电话、邮箱、UUID" id="sear" name="sear">
			<button type="submit" class="btn btn-success radius"
				onclick="search();" name="">
				<i class="Hui-iconfont">&#xe665;</i> 搜用户
			</button>
		</div>
		<div class="cl pd-5 bg-1 bk-gray mt-20">
			<span class="l"><a href="javascript:;" onclick="batch_delete()"
				class="btn btn-danger radius"><i class="Hui-iconfont">&#xe6e2;</i>
					批量删除</a> <a href="javascript:;"
				onclick="member_add('添加用户','../pages/member_add.html','','510')"
				class="btn btn-primary radius"><i class="Hui-iconfont">&#xe600;</i>
					添加医生</a> 角色 <select name="fangyuanEntity.fyXqCode" class="ui_select01"
				id="fyXq" onchange="query();">
					<option value="">--请选择--</option>
					<option value="0">患者</option>
					<option value="1">医生</option>
			</select> <span id="fyXq2" style="display:none;"> <select
					name="fangyuanEntity.fyXqCode2" class="ui_select01" id="fyXq2-1">
						<option value="">-- 科室 --</option>
						<option value="0">内科</option>
						<option value="1">外科</option>
						<option value="2">妇产科</option>
						<option value="3">男科</option>
						<option value="4">儿科</option>
						<option value="5">五官科</option>
						<option value="6">肿瘤科</option>
						<option value="7">皮肤性病科</option>
						<option value="8">中医科</option>
						<option value="9">传染科</option>
						<option value="10">精神心理科</option>
						<option value="11">整形美容科</option>
						<option value="12">营养科</option>
						<option value="13">生殖中心</option>
						<option value="14">麻醉医学科</option>
						<option value="15">医学影像科</option>
						<option value="16">其他科室</option>
				</select> <select name="fangyuanEntity.fyDhCode" class="ui_select01" id="fyXq2-2">
						<option value="">--职称--</option>
						<option value="0">医师</option>
						<option value="1">主治医师</option>
						<option value="2">副主任医师</option>
						<option value="3">主任医师</option>
				</select>
				</span> 
					<input type="button" value="筛选" class="ui_input_btn01" onclick="filter();" /> 
				</span> 
				<span class="r" style="margin-top:10px">共有数据
				<strong><span class="ui_txt_bold04" id="ui_txt_bold04"></span></strong>
				条
			</span>
		</div>

		<div class="ui_text_indent">
			<table	class="table table-border table-bordered table-hover table-bg table-sort" id="ptable" name="ptable">
				<thead>
					<tr class="text-c">
						<th><input type="checkbox" name="checkb" value=""></th>
						<th>序号</th>
						<th>用户名</th>
						<th>角色</th>
						<th>电话</th>
						<th>邮箱</th>
						<th>UUID</th>
						<th>操作</th>
					</tr>
				</thead>
			</table>
		</div>
	</div>
	<!--_footer 作为公共模版分离出去-->
	<script type="text/javascript" src="../js/laypage.js"></script>
	<script type="text/javascript" src="../js/jquery.min.js"></script>
	<script type="text/javascript" src="../js/layer.js"></script>
	<script type="text/javascript" src="../js/H-ui.min.js"></script>
	<script type="text/javascript" src="../js/H-ui.admin.js"></script>
	<!--/_footer 作为公共模版分离出去-->

	<!--请在下方写此页面业务相关的脚本-->
	<!-- <script type="text/javascript" src="../js/WdatePicker.js"></script> 
<script type="text/javascript" src="../js/jquery.dataTables.min.js"></script>  -->
	<script type="text/javascript" src="../js/laypage.js"></script>
</body>
</html>