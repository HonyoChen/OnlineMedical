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
%>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type
" content="text/html; charset=utf-8" />
<link rel="stylesheet" type="text/css" href="../css/H-ui.min.css" />
<link rel="stylesheet" type="text/css" href="../css/H-ui.admin.css" />
<link rel="stylesheet" type="text/css" href="../js/lib/Hui-iconfont/1.0.8/iconfont.css" />
<link rel="stylesheet" type="text/css" href="../css/skin.css" id="skin" />
<link rel="stylesheet" type="text/css" href="../css/style2.css" />
<link rel="stylesheet" type="text/css" href="../css/layer.css" />

<link href="<%=path%>/gystyle/authority/common_style.css"/>
<script type="text/javascript" src="<%=path %>/gyscripts/jquery/jquery-1.7.1.js"></script>
<link href="<%=path %>/gystyle/authority/basic_layout.css" rel="stylesheet" type="text/css">
<link href="<%=path %>/gystyle/authority/common_style.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="<%=path %>/gyscripts/authority/commonAll.js"></script>
<script type="text/javascript" src="<%=path %>/gyscripts/fancybox/jquery.fancybox-1.3.4.js"></script>
<script type="text/javascript" src="<%=path %>/gyscripts/fancybox/jquery.fancybox-1.3.4.pack.js"></script>
<link rel="stylesheet" type="text/css" href="<%=path %>/gystyle/authority/jquery.fancybox-1.3.4.css" media="screen"></link>
<script type="text/javascript" src="<%=path %>/gyscripts/artDialog/artDialog.js?skin=default"></script>

<title>医生列表</title>

<style type="text/css">
a:link {color: #0000FF} /* 未访问的链接 */
a:visited {color: #1E90FF} /* 已访问的链接 */
a:hover {color: #FF00FF} /* 鼠标移动到链接上 */
a:active {color: #0000FF} /* 选定的链接 */
</style>

<script type="text/javascript">

	var result;
	var p = ('<%=id%>');
	var status;	
	$(document).ready(function() {	
		$.ajax({
			url : "isReg",
			type : "POST",
			data : {
				"pid" : <%= user.getUid() %>,
			},
			async: false,
			dataType : "text",
			success : function(result) {
				status = result;
				if(status == "1"){
					document.getElementById("box_center").style.display="none";
				}else{
					document.getElementById("ghxs").style.display="none";
				}
			},
			error : function(result) {
				alert("返回数据失败，请刷新页面");
				alert('error:' + result);
			}
		});
		
		$.ajax({
			url : "findDoctors",
			type : "POST",
			data : {
				"pid" : <%= user.getUid() %>,
			},
			dataType : "JSON",		
			success : function(data) {
				result = data;
				for(var i = 0; i < data.length; i++){
					addRecord(data[i], i);
				}
				$("#ui_txt_bold04").html(data.length);
			},
			error : function(data) {
			  alert("+++++" + JSON.stringify(data));
				alert("请求失败，请重试");
				alert(data);
			}
		});
		
		//alert("status的值为：" + status);
		
		/**编辑   **/
		$("a.edit").fancybox({
			'width' : 733,
			'height' : 530,
			'type' : 'iframe',
			'hideOnOverlayClick' : false,
			'showCloseButton' : false,
			'onClosed' : function() {}
		});
		
	});

	function addRecord(obj, i){
		var html = "";
		html += "<tr>";
		html += "<td> <input type=\"checkbox\" style=\"display:none\" name=\"IDCheck\"  value=\"1445857964201"+i+"\" class=\"acb\" />" + (i+1) + "</td>";
		html += "<td>" + obj.name + "</td>";
		html += "<td>" + (obj.sex == 1 ? "男":"女") + "</td>";
		var Depart= obj.department.toString();
		var dep= "";
		switch(Depart)
		{
			case '0':
				dep = "内科";
				break;
			case '1':
				dep = "外科";
				break;
			case '2':
				dep = "妇产科";
				break;
			case '3':
				dep = "男科";
				break;
			case '4':
				dep = "儿科";
				break;
			case '5':
				dep = "五官科";
				break;
			case '6':
				dep = "肿瘤科";
				break;
			case '7':
				dep = "皮肤性病科";
				break;
			case '8':
				dep = "中医科";
				break;
			case '9':
				dep = "传染";
				break;
			case '10':
				dep = "精神心理科";
				break;
			case '11':
				dep = "整形美容科";
				break;
			case '12':
				dep = "营养科";
				break;
			case '13':
				dep = "生殖中心";
				break;
			case '14':
				dep = "麻醉医学科";
				break;
			case '15':
				dep = "医学影像科";
				break;
			case '16':
				dep = "其他科室";
				break;
			default:
				dep = "未知";
		}
					
		html += "<td>" + dep +"</td>";
		var tt = obj.title.toString();
		var tit;
		switch(tt){
			case '0':
				tit = "医师";
				break;
			case '1':
				tit = "主治医师";
				break;
			case '2':
				tit = "副主任医师";
				break;
			case '3':
				tit = "主任医师";
				break;
			default:
				tit = "未知";
		}
		html += "<td>" + tit + "</td>";
		html += "<td>";
		html += "<a href=\"doctor_edit.html?fyID="+encodeURI(JSON.stringify(obj))+"\"   class=\"edit\" style=\"margin-right:5px\">查看医生信息</a>";
		if(status == 1){
			html += "<a href=\"doctor_xggh.jsp?fyID="+encodeURI(JSON.stringify(obj))+"\" class=\"edit\" style=\"margin-right:5px\">修改挂号信息</a>";
			html += "<a href=\"javascript:void(0)\"  onclick=\"cancelReg()\" class=\"ml-5\" style=\"margin-right:5px\">取消挂号</a>";
			//html += "<a title=\"删除\" href=\"javascript:;\" onclick=\"member_del(this,\'1\')\" class=\"ml-5\" style=\"text-decoration:none\"><i class=\"Hui-iconfont\">&#xe6e2;</i></a></td>";
		}else{
			html += "<a href=\"doctor_gh.jsp?fyID="+obj.did.toString()+"\" class=\"edit\" style=\"margin-right:5px\">挂号</a>";
		}
		
		html += "</td>";
		html +=	"</tr>";
		$("#ptable").append(html);
		
		$("a.edit").fancybox({
			'width' : 733,
			'height' : 530,
			'type' : 'iframe',
			'hideOnOverlayClick' : false,
			'showCloseButton' : false,
			'onClosed' : function() {}
		});
	}
	
	
	function cancelReg() {
		layer.confirm('确认要取消挂号吗？', function(index) {
		 	$.ajax({
			url : "deleteDandp",
			type : "POST",
			data : {
				"pid" : <%= user.getUid() %>
			},
			dataType : "text",
			success : function(result) {
				 window.location.reload();
			},
			error : function(result) {
				alert("操作失败，请刷新页面重试");
				window.location.reload();
			}
		});
		}); 
	}
	
	function filter(){
		//筛选医生列表
		var dep = document.getElementById("fyXq").value;
		var tit = document.getElementById("fyDh").value;
		
		var count = 0;
		if(dep == ""){
			if(tit == ""){
				$("#ptable  tr:not(:first)").html("");
				for(var i = 0; i < result.length; i++){
					var obj = result[i];
					addRecord(obj, i);
				}
				$("#ui_txt_bold04").html(result.length);
			}else{
				$("#ptable  tr:not(:first)").html("");
				for(var i = 0; i < result.length; i++){
					var obj = result[i];
					if(obj.title.toString() == tit){
						addRecord(obj, count);
						count++;
					}
				}
				$("#ui_txt_bold04").html(count);
			}
		}else{
			if(tit == ""){
				$("#ptable  tr:not(:first)").html("");
				for(var i = 0; i < result.length; i++){
					var obj = result[i];
					if(obj.department.toString() == dep){
						addRecord(obj, count);
						count++;
					}
				}
				$("#ui_txt_bold04").html(count);
			}else{
				$("#ptable  tr:not(:first)").html("");
				for(var i = 0; i < result.length; i++){
					var obj = result[i];
					if(obj.department.toString() == dep && obj.title.toString() == tit){
						addRecord(obj, count);
						count++;
					}
				}
				$("#ui_txt_bold04").html(count);
			}
		}
		//$("#ui_txt_bold04").html(count);
		$("a.edit").fancybox({
			'width' : 740,
			'height' : 530,
			'type' : 'iframe',
			'hideOnOverlayClick' : false,
			'showCloseButton' : false,
			'onClosed' : function() {
				/* alert("+++++++++3"); */
				/* window.location.href = 'doctor_list.jsp'; */
			}
		});
	}
	
	
	function search(){
		//筛选医生列表
		var dep = document.getElementById("fyZldz").value;
		var count = 0;
		if(dep.toString() == "" || dep.toString() == null){
			$("#ptable  tr:not(:first)").html("");
				for(var i = 0; i < result.length; i++){
					var obj = result[i];
					addRecord(obj, i);
				}
			$("#ui_txt_bold04").html(result.length);
		}else{
			$("#ptable  tr:not(:first)").html("");
			for(var i = 0; i < result.length; i++){
				var obj = result[i];
				if(obj.name.toString().indexOf(dep) != -1){
					addRecord(obj, count);
					count++;
				}
				$("#ui_txt_bold04").html(count);
			}
		}
		//$("#ui_txt_bold04").html(count);
		$("a.edit").fancybox({
			'width' : 740,
			'height' : 530,
			'type' : 'iframe',
			'hideOnOverlayClick' : false,
			'showCloseButton' : false,
			'onClosed' : function() {
				/* alert("+++++++++3"); */
				/* window.location.href = 'doctor_list.jsp'; */
			}
		});
	}

	function keypp()
	{
		if(event.keyCode==13)
		{
			search();
		}
	}
	
	
	
</script>
<style>
.alt td {
	background: black !important;
}
</style>
</head>
<body>
	<!-- <form id="submitForm" name="submitForm" action="" method="post"> -->
		<input type="hidden" name="allIDCheck" value="" id="allIDCheck" /> <input
			type="hidden" name="fangyuanEntity.fyXqName" value="" id="fyXqName" />
		<div id="container">
			<div class="ui_content">
				<div class="ui_text_indent">
					<div id="box_border">
						<div>
							<br>
							<h1 style="text-align: center;">医生列表</h1>
							<br>
						</div>
						<div id="box_top">搜索</div>
					</div>
				</div>
			</div>
			<div id="ghxs">
				<div>
					<br>
					<h3 style="text-align: center;">您已挂号，当前只显示挂号医生信息</h3>
					<br>
				</div>
			</div>
			<div id="box_center" >
				&nbsp;科室 <select name="fangyuanEntity.fyXqCode" id="fyXq"
					class="ui_select01" >
					<option value="">--请选择--</option>
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
				</select> 职称 <select name="fangyuanEntity.fyDhCode" id="fyDh"
					class="ui_select01">
					<option value="">--请选择--</option>
					<option value="0">医师</option>
					<option value="1">主治医师</option>
					<option value="2">副主任医师</option>
					<option value="3">主任医师</option>
				</select>
											
				<input type="button" value="筛选"
					class="ui_input_btn01" onclick="filter();" /> 
						
					
				<input	type="text" id="fyZldz" style="float:right;margin-right:95px;margin-top:10px;" name="fangyuanEntity.fyZldz"
					class="ui_input_txt02" placeholder="请输入姓名查找" onKeyDown="keypp()" />
					
				<input type="button" value="查询" style="float:right;margin-right:-240px;margin-top:10px;" class="ui_input_btn01" onclick="search();" />

		  </div>

					
				
			
			
			<div class="ui_content">
				<div class="ui_tb">
					<table id="ptable" class="table" cellspacing="0" cellpadding="0" width="100%" align="center" border="0">
						<tr>
							<th>序号</th>
							<th>姓名</th>
							<th>性别</th>
							<th>所属科室</th>
							<th>职称</th>
							<th>操作</th>
						</tr>
				

					</table>
				</div>
				<div class="ui_tb_h30" id="xianshi">
					<div class="ui_flt" style="height: 30px; line-height: 30px;">
					
						 共有<span class="ui_txt_bold04" id="ui_txt_bold04"></span>条记录
					</div>

				</div>
			
			</div>
		</div>
	<!-- </form> -->
	<!--_footer 作为公共模版分离出去--> 
<!-- 	<script type="text/javascript" src="../js/jquery.min.js"></script> -->
	<script type="text/javascript" src="../js/layer.js"></script>
	<script type="text/javascript" src="../js/H-ui.min.js"></script>
	<script type="text/javascript" src="../js/H-ui.admin.js"></script>
	<!--/_footer 作为公共模版分离出去-->

	<!--请在下方写此页面业务相关的脚本-->
	<script type="text/javascript" src="../js/WdatePicker.js"></script> 
<script type="text/javascript" src="../js/jquery.dataTables.min.js"></script>
<script type="text/javascript" src="../js/laypage.js"></script>
</body>
</html>
