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
<meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no" />
<meta http-equiv="Cache-Control" content="no-siteapp" />
<link rel="stylesheet" type="text/css" href="../css/H-ui.min.css" />
<link rel="stylesheet" type="text/css" href="../css/H-ui.admin.css" />
<link rel="stylesheet" type="text/css"	href="../js/lib/Hui-iconfont/1.0.8/iconfont.css" />
<link rel="stylesheet" type="text/css" href="../css/skin.css" id="skin" />
<link rel="stylesheet" type="text/css" href="../css/style2.css" />
<link rel="stylesheet" type="text/css" href="../css/layer.css" />
<link href="<%=path%>/gystyle/authority/common_style.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="../js/jquery.min.js"></script>
<script type="text/javascript" src="../js/layer.js"></script>
<script type="text/javascript" src="../js/H-ui.min.js"></script>
<script type="text/javascript" src="../js/H-ui.admin.js"></script>
<script type="text/javascript" src="../js/laypage.js"></script>



<title>意见反馈</title>
</head>

<script type="text/javascript">
	var result;
	$(document).ready(function() {
		//返回医生列表
		$.ajax({
			url : "allMessages",
			type : "POST",
			//async : false ,
			data : {
				<%-- "pid" : <%= user.getUid() %>, --%>
			},
			dataType : "JSON",
		
			success : function(data) {
				//alert("返回数据成功");
				result = data;
				for(var i=0; i < data.length; i++){
					//var obj = data[i];
					addhtml(data[i],i+1);	 
				} 	
			},
			error : function(data) {
				alert("请求失败，请重试");
				alert(data);
			}
		});
	});

	function addhtml(obj,i){
		var html="";
		html +="<tr class=\"text-c\">";
		html +="<td><input type=\"checkbox\" value=\"" + obj.mid + "\" id=\"checkb\" name=\"checkb\"></td>";
		html +="<td>"+i+"</td>";
		html +="<td>"+(obj.category.toString() == 0 ? "<h5 style=\"color:green\">意见建议</h5>":"<h5 style=\"color:red\">投诉举报</h5>")+"</td>";								
		html +="<td class=\"text-l\">";
		html +="<div class=\"c-999 f-12\">";				
		if(obj.user == ""|| obj.user == null)
		{
			html +="<span class=\"ml-20\" style=\"margin-left:-4px; width:125px; \">"+obj.username+"</span>";
			html +="<span class=\"ml-20\" style=\"float:right;margin-right:150px; \">"+obj.phone+"</span>";
			html +="<span class=\"ml-20\" style=\"float:right;margin-right:250px;\">"+obj.email+"</span>";
			var tt = obj.time;
			var time=new Array(" ",tt.substr(0,10),"  ",tt.substr(11));
			var timeList=time.join("");					
			html +="<time title=\"2014年8月31日 下午3:20\"  style=\"float:right;margin-right:10px;\" datetime=\"2014-08-31T03:54:20\">"+timeList+"</time>";
		
		}
		else {
			html +="<u style=\"cursor:pointer;margin-left:-4px; width:125px;\"  class=\"text-primary\" onclick=\"member_show(\'"+obj.user.username+"\',\'../pages/member-show.html\',\'10001\',\'360\',\'400\')\">"+obj.user.username+"</u>";
			html +="<span class=\"ml-20\" style=\"float:right;margin-right:50px;\">"+obj.user.phone+"</span>";
			html +="<span class=\"ml-20\" style=\"float:right;margin-right:50px;\">"+obj.user.email+"</span>";
			var tt = obj.time;
			var time=new Array(" ",tt.substr(0,10),"  ",tt.substr(11));
			var timeList=time.join("");					
			html +="<time title=\"2014年8月31日 下午3:20\"  style=\"float:right;margin-right:10px;\" datetime=\"2014-08-31T03:54:20\">"+timeList+"</time>";
		
		}				
		html +="</div>";
		html +="<div class=\"f-12 c-999\">"+obj.title+"</div>";
		html +="<div>"+obj.content+"</div>";
		html +="</td>";
		html +="<td>"+(obj.status.toString() == 0 ? "<h5 style=\"color:red\">待处理</h5>":"<h5 style=\"color:green\">已处理</h5>")+"</td>";	
		if(obj.status.toString() == 0){
			html +="<td class=\"td-manage\"><a title=\"处理完成\" href=\"javascript:;\" onclick=\"message_change(this,\'" + obj.mid + "\')\" style=\"text-decoration:none\"><i class=\"Hui-iconfont\">&#xe6df;</i></a> <a title=\"删除\" href=\"javascript:;\" onclick=\"member_del(this,\'" + obj.mid + "\')\" class=\"ml-5\" style=\"text-decoration:none\"><i class=\"Hui-iconfont\">&#xe6e2;</i></a></td>";
		}
		else{
			html +="<td class=\"td-manage\"><a title=\"取消处理完成\" href=\"javascript:;\" onclick=\"message_change(this,\'" + obj.mid + "\')\" style=\"text-decoration:none\"><i class=\"Hui-iconfont\">&#xe6df;</i></a> <a title=\"删除\" href=\"javascript:;\" onclick=\"member_del(this,\'" + obj.mid + "\')\" class=\"ml-5\" style=\"text-decoration:none\"><i class=\"Hui-iconfont\">&#xe6e2;</i></a></td>";
		}		  		
		
		html +="</tr>";			
		$("#tbody").append(html);
	}

	function filter2(){
		//筛选医生列表
		var cat = document.getElementById("fyXq").value;
		var sta = document.getElementById("fyDh").value;
		var startTime = document.getElementById("startTime").value;
		var endTime = document.getElementById("endTime").value;	
		if(startTime>endTime)
		{
			alert("查找开始日期必须小于结束日期！");
			$("#tbody  tr:not(:first)").html("");
			for(var i = 0; i < result.length; i++)
			{			
				var obj = result[i];					
				addhtml(obj, i+1);
			}
		}
		var count = 0;
		if(cat.toString() == ""|| cat.toString() == null)
		{
			if(sta.toString() == ""|| sta.toString() == null)
			{
				if((startTime.toString() =="" || startTime.toString() == null) && (endTime.toString() =="" || endTime.toString() == null))	
				{
					$("#tbody  tr:not(:first)").html("");
					for(var i = 0; i < result.length; i++)
					{
						var obj = result[i];					
						addhtml(obj, i+1);
					}
				}
			    else
			    {
					$("#tbody  tr:not(:first)").html("");
					for(var i = 0; i < result.length; i++)
					{
						var obj = result[i];
						startTime += "T00:00:00";
		                endTime += "T23:59:59";						
						if(obj.time>=startTime && obj.time <=endTime)
						{				
							addhtml(obj, count+1);
							count++;
						}						
					}					
				}
			}
			else
			{
				if((startTime.toString() =="" || startTime.toString() == null) && (endTime.toString() =="" || endTime.toString() == null) )	
				{
					$("#tbody  tr:not(:first)").html("");
					for(var i = 0; i < result.length; i++)
					{
						var obj = result[i];
						if(obj.status.toString() == sta)
						{
							addhtml(obj, count+1);
							count++;
						}
					}
		
				}
				else
				{			
					$("#tbody  tr:not(:first)").html("");
					for(var i = 0; i < result.length; i++)
					{
						var obj = result[i];
						startTime += "T00:00:00";
		                endTime += "T23:59:59";	
						if(obj.status.toString() == sta && (obj.time >= startTime && obj.time <= endTime))
						{
							addhtml(obj, count+1);
							count++;
						}
					}
		
				}
			}
		}
		else
		{
			if(sta.toString() == ""|| sta.toString() == null)
			{
				if((startTime.toString() =="" || startTime.toString() == null) && (endTime.toString() =="" || endTime.toString() == null) )	
				{
					$("#tbody  tr:not(:first)").html("");			
					for(var i = 0; i < result.length; i++)
				    {
					 	var obj = result[i];
						if(obj.category.toString() == cat)
						{
							addhtml(obj, count+1);
							count++;
						}
					}
				}
				else
				{
					$("#tbody  tr:not(:first)").html("");			
					for(var i = 0; i < result.length; i++)
				    {
					 	var obj = result[i];
					 	startTime += "T00:00:00";
		                endTime += "T23:59:59";	
						if(obj.category.toString() == cat && (obj.time >= startTime && obj.time <= endTime))
						{
							addhtml(obj, count+1);
							count++;
						}
					}
				}			
			}
			else{
		
				if((startTime.toString() =="" || startTime.toString() == null) && (endTime.toString() =="" || endTime.toString() == null) )	
				{
					$("#tbody  tr:not(:first)").html("");
					for(var i = 0; i < result.length; i++)
					{
						var obj = result[i];		
					    if(obj.category.toString() == cat && obj.status.toString() == sta)
					    {
							addhtml(obj, count+1);
							count++;
						}
					}
				}
				else
				{
					$("#tbody  tr:not(:first)").html("");
					for(var i = 0; i < result.length; i++)
					{
						var obj = result[i];
						startTime += "T00:00:00";
		                endTime += "T23:59:59";			
					    if(obj.category.toString() == cat && obj.status.toString() == sta&& (obj.time >= startTime && obj.time <= endTime))
					    {
							addhtml(obj, count+1);
							count++;
						}
					}
				}
			}
		}
		$("a.edit").fancybox({
			'width' : 733,
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
	
$(function(){
	$('.table-sort').dataTable({
		//"aaSorting": [[ 1, "desc" ]],//默认第几个排序
		"bStateSave": true,//状态保存
		"aoColumnDefs": [
		  //{"bVisible": false, "aTargets": [ 3 ]} //控制列的隐藏显示
		  {"orderable":false,"aTargets":[]}// 制定列不参与排序
		]
	});

});

/*用户-查看*/
function member_show(title,url,id,w,h){
	layer_show(title,url,w,h);
}

/*用户-编辑*/
function member_edit(title,url,id,w,h){
	layer_show(title,url,w,h);
}
/*密码-修改*/
function change_password(title,url,id,w,h){
	layer_show(title,url,w,h);	
}

/*留言-更改状态*/
function message_change(obj,id){
	layer.confirm('确认要更改状态吗？',function(index){
		$.ajax({
			type: 'POST',
			url: 'changeStatus',
			data : {
				"mid" : id
			},
			dataType: 'json',
			success: function(data){
				//$(obj).parents("tr").remove();
				layer.alert('状态已更改!',{
					icon:1,
					yes:function(){
						window.location.reload();
					}});
			},
			error:function(data) {
				console.log(data);
			},
		});	
	});
}

/*留言-删除*/
function member_del(obj,id){
	layer.confirm('确认要删除留言吗？',function(index){
		$.ajax({
			type: 'POST',
			url: 'deleteMessage',
			data : {
				"mid" : id
			},
			dataType: 'json',
			success: function(data){
				layer.alert('已删除!',{
					icon:1,
					yes:function(){
						window.location.reload();
					}});
			},
			error:function(data) {
				console.log(data);
			},
		});
	});
}

function batch_change(){
	var check = document.getElementsByName("checkb");
	var ids = "";
	for(var k = 1; k < check.length; k++){
		if(check.item(k).checked){
			ids = ids + check.item(k).value + " ";
		}
	}
	
	layer.confirm('确认要批量更改状态吗？',function(index){
		$.ajax({
			type: 'POST',
			url: 'batchChangeStatus',
			data : {
				"ids" : ids
			},
			dataType: 'json',
			success: function(data){
				//$(obj).parents("tr").remove();
				layer.alert('批量状态更改!',{
					icon:1,
					yes:function(){
						window.location.reload();
					}});
			},
			error:function(data) {
				console.log(data);
			},
		});	
	});
}

function batch_delete(){
	var check = document.getElementsByName("checkb");
	var ids = "";
	for(var k = 1; k < check.length; k++){
		if(check.item(k).checked){
			ids = ids + check.item(k).value + " ";
		}
	}
	
	layer.confirm('确认要批量删除留言吗？',function(index){
		$.ajax({
			type: 'POST',
			url: 'batchDeleteMessage',
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
				console.log(data);
			},
		});	
	});
}
</script>


<body>
	<nav class="breadcrumb">
		<i class="Hui-iconfont">&#xe67f;</i> 管理员系统 <span class="c-gray en">&gt;</span>
		留言管理 <a class="btn btn-success radius r"
			style="line-height:1.6em;margin-top:3px"
			href="javascript:location.replace(location.href);" title="刷新"><i
			class="Hui-iconfont">&#xe68f;</i></a>
	</nav>
	<div class="page-container">
		<div class="cl pd-5 bg-1 bk-gray mt-20">
			<span class="r"><a href="javascript:;" onclick="batch_change()"
				class="btn btn-primary radius"><i class="Hui-iconfont">&#xe6df;</i>批量处理/取消处理</a>
			</span> <span class="r"></span> <span class="r"><a
				href="javascript:;" onclick="batch_delete()"
				class="btn btn-danger radius"><i class="Hui-iconfont">&#xe6e2;</i>批量删除</a>
			</span> <span class="r"></span>
			<div class="dataTables_length" id="DataTables_Table_0_length"
				style="margin-top:6px;font-size:14px;">
				类别 <select name="fangyuanEntity.fyXqCode" id="fyXq"
					class="ui_select02" onchange="getFyDhListByFyXqCode();">
					<option value="">--请选择--</option>
					<option value="0">意见建议</option>
					<option value="1">投诉举报</option>
				</select> 状态 <select name="fangyuanEntity.fyDhCode" id="fyDh"
					class="ui_select02">
					<option value="">--请选择--</option>
					<option value="0">待处理</option>
					<option value="1">已处理</option>

				</select> 
				开始日期 <input type="date" id="startTime" style="height:25px;font-size:14px;">
				&nbsp; — &nbsp;结束日期 <input type="date" id="endTime"
					style="height:25px;font-size:14px;"> <input type="button"
					value="筛选" class="ui_input_btn01" onclick="filter2();" />
			</div>
		</div>

		<div class="ui_text_indent">

			<table
				class="table table-border table-bordered table-hover table-bg table-sort"
				style="margin-top:10px;" id="tbody">
				<thead>
					<tr class="text-c">
						<th><input type="checkbox" id="checkb" name="checkb" value=""></th>
						<th>序号</th>
						<th>类别</th>
						<th>留言内容</th>
						<th>状态</th>
						<th>操作</th>
				</thead>
			</table>
		</div>
	</div>

</body>
</html>