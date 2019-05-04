<%@ page import="com.cn.POJO.User"%>
<%@ page import="com.opensymphony.xwork2.ActionContext"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<taglib prefix="s" uri="/struts-tags"> <%
 	String path = request.getContextPath();
 	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
 			+ path + "/";
 	User user = (User) ActionContext.getContext().getSession().get("loginUser");
 %> <!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<script type="text/javascript" src="../gyscripts/jquery/jquery-1.7.1.js"></script>
<link href="../gystyle/authority/basic_layout.css" rel="stylesheet"
	type="text/css">
<link href="../gystyle/authority/common_style.css" rel="stylesheet"
	type="text/css">
<script type="text/javascript" src="../gyscripts/authority/commonAll.js"></script>
<script type="text/javascript"
	src="../gyscripts/fancybox/jquery.fancybox-1.3.4.js"></script>
<script type="text/javascript"
	src="../gyscripts/fancybox/jquery.fancybox-1.3.4.pack.js"></script>
<link rel="stylesheet" type="text/css"
	href="../gystyle/authority/jquery.fancybox-1.3.4.css" media="screen"></link>
<script type="text/javascript"
	src="../gyscripts/artDialog/artDialog.js?skin=default"></script>
<title>既往病史</title>
<script type="text/javascript">
	var result;	
	$(document).ready(function(){
		
		$.ajax(
			{
				url : "findHistoryRecordByPid",
				type : "POST",
				data : {"pid" : <%=user.getUid()%>,},
				dataType : "JSON",
			   
				success : function(data)
				{
					result = data;				
					if(data == null)
					{
						$("#ui_txt_bold04").html(0);
					}
					else{
						var xh=1;
						for(var i = data.length-1; i>=0; i--)
						{
								addRecord(data[i], i, xh);
								xh++;
								
						}
						$("#ui_txt_bold04").html(result.length);
					}
				},
				
				error : function(data)
				{
			  		alert("+++++" + JSON.stringify(data));
					alert("请求失败，请重试");
					alert(data);
				}
			});
			$("a.edit").fancybox(
			{
				'width' : 733,
				'height' : 530,
				'type' : 'iframe',
				'hideOnOverlayClick' : false,
				'showCloseButton' : false,
				'onClosed' : function() {}
			}); 
		});

function cage(obj, i)
	{
		var birthday = obj.patient.birthday;
		birthday = birthday.replace("T"," ");
		birthday = birthday.replace(/-/g,"/");
		var start = new Date(birthday);
		var end = new Date();
		var age = Math.ceil((end-start)/(1000*3600*24*365));//向上取整
	    //alert(JSON.stringify(age));
		return age;
		
	}

	function addRecord(obj, i,xh)
	{
		
		var html = "";
		html += "<tr>";
		html += "<td>" + xh + "</td>";
		var datestr = obj.time;
		html += "<td>" + datestr.substring(0, 10) + "</td>";
	    html += "<td>" + obj.doctor.name + "</td>";
	    var Depart= obj.doctor.department.toString();
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
		var tt = obj.doctor.title.toString();
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
		var par = obj.part.toString();
		var pa;
		switch(par)
		{
			case '0':
				pa = "全身";
				break;
			case '1':
				pa = "头部";
				break;
			case '2':
				pa = "颈部";
				break;
			case '3':
				pa = "胸部";
				break;
			case '4':
				pa = "腹部";
				break;
			case '5':
				pa = "腰部";
				break;
			case '6':
				pa = "背部";
				break;
			case '7':
				pa = "皮肤";
				break;
			case '8':
				pa = "四肢";
				break;
			case '9':
				pa = "男科";
				break;
			case '10':
				pa = "妇科";
				break;
		}
		html += "<td>" + pa +"</td>";
		html += "<td>";
		html += "<a href=\"house_edit2.html?fyID="+encodeURI(JSON.stringify(obj))+"\" class=\"edit\" style=\"margin-right:5px\">查看就诊记录</a>";
		html += "</td>";
		html +=	"</tr>";
		$("#ptable").append(html);
		
		$("a.edit").fancybox
		({
			'width' : 733,
			'height' : 530,
			'type' : 'iframe',
			'hideOnOverlayClick' : false,
			'showCloseButton' : false,
			'onClosed' : function() {}
		});  

	}
	function filter2(){
		
		var xh=1;
		var fbbw = document.getElementById("fyXq").value;
		var ysks = document.getElementById("fyDh").value;
		var startTime = document.getElementById("startTime").value;
		var endTime = document.getElementById("endTime").value;	
		if(startTime>endTime)
		{
			alert("查找开始日期必须小于结束日期！");
			$("#ptable  tr:not(:first)").html("");
			for(var i = 0; i < result.length; i++)
			{			
				var obj = result[i];					
				addRecord(obj, i,xh);
				xh++;
			}
		}
		var count = 0;	
		if(fbbw.toString() == ""|| fbbw.toString() == null)
		{
			if(ysks.toString() == ""|| ysks.toString() == null)
			{
				if((startTime.toString() =="" || startTime.toString() == null) && (endTime.toString() =="" || endTime.toString() == null))	
				{
					$("#ptable  tr:not(:first)").html("");
					var xh=1;
					for(var i = result.length-1; i >=0; i--)
					{
						var obj = result[i];					
						addRecord(obj, i,xh);
						xh++;
					}
					$("#ui_txt_bold04").html(result.length);
				}
				
			    else
			    {
					$("#ptable  tr:not(:first)").html("");
					var xh=1;
					for(var i = result.length-1; i >=0; i--)
					{
						var obj = result[i];
						startTime += "T00:00:00";
		                endTime += "T23:59:59";						
						if(obj.time>=startTime && obj.time <=endTime)
						{				
							addRecord(obj, i,xh);
							xh++;
							count++;
						}						
					}
					$("#ui_txt_bold04").html(count);					
				}
			}
			else
			{
				if((startTime.toString() =="" || startTime.toString() == null) && (endTime.toString() =="" || endTime.toString() == null) )	
				{
					$("#ptable  tr:not(:first)").html("");
					var xh=1;
					for(var i = result.length-1; i >=0; i--)
					{
						var obj = result[i];
						if(obj.doctor.department.toString() == ysks)
						{
							addRecord(obj, i,xh);
							xh++;
							count++;
						}
					}
					$("#ui_txt_bold04").html(count);
				}
				else
				{			
					$("#ptable  tr:not(:first)").html("");
					var xh=1;
					for(var i = result.length-1; i >=0; i--)
					{
						var obj = result[i];
						startTime += "T00:00:00";
		                endTime += "T23:59:59";	
						if(obj.doctor.department.toString() == ysks && (obj.time >= startTime && obj.time <= endTime))
						{
							addRecord(obj, i,xh);
							xh++;
							count++;
						}
					}
					$("#ui_txt_bold04").html(count);
				}
			}
		}
		else
		{
			if(ysks.toString() == ""|| ysks.toString() == null)
			{
				if((startTime.toString() =="" || startTime.toString() == null) && (endTime.toString() =="" || endTime.toString() == null) )	
				{
					$("#ptable  tr:not(:first)").html("");	
					var xh=1;		
					for(var i = result.length-1; i >=0; i--)
				    {
					 	var obj = result[i];
						if(obj.part.toString() == fbbw)
						{
							addRecord(obj, i,xh);
							xh++;
							count++;
						}
					}
					$("#ui_txt_bold04").html(count);
				}
				else
				{
					$("#ptable  tr:not(:first)").html("");
					var xh=1;			
					for(var i = result.length-1; i >=0; i--)
				    {
					 	var obj = result[i];
					 	startTime += "T00:00:00";
		                endTime += "T23:59:59";	
						if(obj.part.toString() == fbbw && (obj.time >= startTime && obj.time <= endTime))
						{
							addRecord(obj, i,xh);
							xh++;
							count++;
						}
					}
					$("#ui_txt_bold04").html(count);
				}			
			}
			else{
		
				if((startTime.toString() =="" || startTime.toString() == null) && (endTime.toString() =="" || endTime.toString() == null) )	
				{
					$("#ptable  tr:not(:first)").html("");
					var xh=1;
					for(var i = result.length-1; i >=0; i--)
					{
						var obj = result[i];		
					    if(obj.part.toString() == fbbw && obj.doctor.department.toString() == ysks)
					    {
							addRecord(obj, i,xh);
							xh++;
							count++;
						}
					}
					$("#ui_txt_bold04").html(count);
				}
				else
				{
					$("#ptable  tr:not(:first)").html("");
					var xh=1;
					for(var i = result.length-1; i >=0; i--)
					{
						var obj = result[i];
						startTime += "T00:00:00";
		                endTime += "T23:59:59";			
					    if(obj.part.toString() == fbbw && obj.doctor.department.toString() == ysks&& (obj.time >= startTime && obj.time <= endTime))
					    {
							addRecord(obj, i,xh);
							xh++;
							count++;
						}
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
			'onClosed' : function() {
				/* alert("+++++++++3"); */
				/* window.lofbbwion.href = 'doctor_list.jsp'; */
			}
		});
	}
	function search()
	{
		var xh=1;
		var dep = document.getElementById("fyZldz").value;
		var count = 0;
		if(dep.toString() == "" || dep.toString() == null)
		{
			$("#ptable  tr:not(:first)").html("");
			for(var i = 0; i < result.length; i++)
			{	
				var obj = result[i];
				addRecord(obj,i,xh);
				xh++;
			}
			$("#ui_txt_bold04").html(result.length);
		}
		else
		{
			$("#ptable  tr:not(:first)").html("");
			for(var i = 0; i < result.length; i++)
			{
				var obj = result[i];
				if(obj.doctor.name.toString().indexOf(dep) != -1)
				{
					addRecord(obj,i,xh);
					xh++;
					count++;
				}
				$("#ui_txt_bold04").html(count);
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
	}//按姓名查找结束

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
	<form id="submitForm" name="submitForm" action="" method="post">
		<input type="hidden" name="allIDCheck" value="" id="allIDCheck" /> <input
			type="hidden" name="fangyuanEntity.fyXqName" value="" id="fyXqName" />
		<div id="container">
			<div class="ui_content">
				<div class="ui_text_indent">
					<div id="box_border">
						<div>
							<br>
							<h1 style="text-align: center;">既往病史</h1>
							<br>
						</div>
						<div id="box_top">搜索</div>
						<div id="box_center">
							发病部位 <select name="fangyuanEntity.fyXqCode" id="fyXq"
								class="ui_select01">
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
							</select> 医生科室 <select name="fangyuanEntity.fyDhCode" id="fyDh"
								class="ui_select01">
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
							</select> 开始日期 <input type="date" id="startTime"> &nbsp; —
							&nbsp;结束日期 <input type="date" id="endTime"> <input
								type="button" value="筛选" class="ui_input_btn01"
								onclick="filter2();" /> <input type="text" id="fyZldz"
								style="float:right;margin-right:95px;margin-top:10px;"
								name="fangyuanEntity.fyZldz" class="ui_input_txt02"
								placeholder="请输入姓名查找" onKeyDown="keypp()" /> <input
								type="button" id="Tosearch" value="查询"
								style="float:right;margin-right:-240px;margin-top:10px;"
								class="ui_input_btn01" onclick="search();" />
						</div>

					</div>
				</div>
			</div>
			<div class="ui_content">
				<div class="ui_tb">
					<table id="ptable" class="table" cellspacing="0" cellpadding="0"
						width="100%" align="center" border="0">
						<tr>
							<th>序号</th>
							<th>就诊日期</th>
							<th>医生姓名</th>
							<th>科室</th>
							<th>职称</th>
							<th>发病部位</th>
							<th>操作</th>
						</tr>
					</table>
				</div>
				<div class="ui_tb_h30">
					<div class="ui_flt" style="height: 30px; line-height: 30px;">
						&nbsp;&nbsp; <span>共有数据 <strong><span
								class="ui_txt_bold04" id="ui_txt_bold04"></span></strong> 条
						</span>
					</div>

				</div>
				<!-- <div id="box_bottom">
					<input type="button" value="批量删除" class="ui_input_btn01" onclick="batchDel();" /> 
				</div> -->
			</div>
		</div>
	</form>

</body>
</html>