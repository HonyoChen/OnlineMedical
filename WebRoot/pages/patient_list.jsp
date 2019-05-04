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
<meta http-equiv="Content-Type
" content="text/html; charset=utf-8" />
<script type="text/javascript" src="<%=path %>/gyscripts/jquery/jquery-1.7.1.js"></script>
<link rel="stylesheet" type="text/css" href="../css/layer.css" />
<link href="<%=path %>/gystyle/authority/basic_layout.css" rel="stylesheet" type="text/css">
<link href="<%=path %>/gystyle/authority/common_style.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="<%=path %>/gyscripts/authority/commonAll.js"></script>
<script type="text/javascript" src="<%=path %>/gyscripts/fancybox/jquery.fancybox-1.3.4.js"></script>
<script type="text/javascript" src="<%=path %>/gyscripts/fancybox/jquery.fancybox-1.3.4.pack.js"></script>
<link rel="stylesheet" type="text/css" href="<%=path %>/gystyle/authority/jquery.fancybox-1.3.4.css" media="screen"></link>
<script type="text/javascript" src="<%=path %>/gyscripts/artDialog/artDialog.js?skin=default"></script>
<link rel="stylesheet" type="text/css" href="../css/H-ui.min.css" />
<link rel="stylesheet" type="text/css" href="../css/H-ui.admin.css" />
<link rel="stylesheet" type="text/css"
	href="../js/lib/Hui-iconfont/1.0.8/iconfont.css" />
<link rel="stylesheet" type="text/css" href="../css/skin.css" id="skin" />
<link rel="stylesheet" type="text/css" href="../css/style2.css" />
<link rel="stylesheet" type="text/css" href="../css/layer.css" />
<link href="<%=path%>/gystyle/authority/common_style.css"
	rel="stylesheet" type="text/css">
<title>患者列表</title>
<script type="text/javascript" src="../js/layer.js"></script>

<script type="text/javascript">
	var result;
	
	
	$(document).ready(function()
	{
		$.ajax(
			{
				url : "findAllPatients",
				type : "POST",
				data : {"did" : <%= user.getUid() %>,},
				dataType : "JSON",
			
				success : function(data)
				{
					 /*  for(var i=0; i < data.length; i++){
						var obj = data[i];
						for(var key in obj){
							alert(key + "," + obj[key]);
						} */
					//}
					result = data;
					for(var i = 0; i < data.length; i++)
						{
							//rr = data[i];
							addRecord(data[i], i);
						}
					$("#ui_txt_bold04").html(data.length);
				},
			
				error : function(data)
				{
			  		layer.alert('请求失败!请刷新重试',{
						icon:2,
						yes:function(){
							window.location.reload();
						}
					});
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
	});//(document).ready(function())结束
	
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
	
	function addRecord(obj, i)
	{
		var html = "";
		html += "<tr>";
		html += "<td><input type=\"checkbox\" name=\"IDCheck\"  value=\"" +obj.id+ "\" class=\"acb\" /></td>";
		var datestr = obj.time;
		html += "<td>" + datestr.substring(0, 10) + "</td>";
	    html += "<td>" + obj.patient.name + "</td>";
		html += "<td>" + (obj.patient.sex==1?"男":"女") + "</td>";
		var age = cage(obj,i);
		html += "<td>" + age + "</td>";
		var part= obj.part.toString();
		var pa= "";
		switch(part)
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
		html += "<a href=\"house_edit.html?fyID="+encodeURI(JSON.stringify(obj))+"\"  class=\"edit\" style=\"margin-right:5px\">查看信息</a>";
		html += "<a href=\"house_edit1.html?fyID="+encodeURI(JSON.stringify(obj))+"\" class=\"edit\" style=\"margin-right:5px\">填写病历</a>";
		/* html += "<a href=\"javascript:del('1445857964201"+i+"\');\">删除</a>"; */
		html += "<a href=\"javascript:;\" onclick=\"patient_del(this,\'" + obj.id + "\')\" class=\"ml-5\" style=\"text-decoration:none\">删除</a></td>";
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
	
	function filter()
	{
		var xsex = document.getElementById("fyXq").value;
		var xage = document.getElementById("fyDh").value;
		
		var count = 0;
		
		if(xsex == "")
		{
			if(xage == "")
			{
				$("#ptable  tr:not(:first)").html("");
				for(var i = 0; i < result.length; i++)
					{
						var obj = result[i];
						addRecord(obj, i);
					}
				$("#ui_txt_bold04").html(result.length);
			}
			else
			{
				$("#ptable  tr:not(:first)").html("");
				switch(xage)
				{
					case '0':
					{
						for(var i = 0; i < result.length; i++)
						{
							var obj = result[i];
							var agei = cage(obj,i).toString();//第i患者的年龄
							if(agei >= 0 && agei <= 10 )
							{addRecord(obj,i);count++;}
						}
						break;
					 }
					case '1':
					{
						for(var i = 0; i < result.length; i++)
						{
							var obj = result[i];
							var agei = cage(obj,i).toString();//第i患者的年龄
							if(agei >= "11" && agei <= "20" )
							{addRecord(obj,i);count++;}
						}
						break;
					 }
					case '2':
					{
						for(var i = 0; i < result.length; i++)
						{
							var obj = result[i];
							var agei = cage(obj,i).toString();//第i患者的年龄
							if(agei >= "21" && agei <= "30" )
							{addRecord(obj,i);count++;}
						}
						break;
				     }
				    case '3':
					{
						for(var i = 0; i < result.length; i++)
						{
							var obj = result[i];
							var agei = cage(obj,i).toString();//第i患者的年龄
							if(agei >= "31" && agei <= "40" )
							{addRecord(obj,i);count++;}
							
						}
						break;
				     }
				    case '4':
					{
						for(var i = 0; i < result.length; i++)
						{
							var obj = result[i];
							var agei = cage(obj,i).toString();//第i患者的年龄
							if(agei >= "41" && agei <= "50" )
							{addRecord(obj,i);count++;}
						}
						break;
				     }
				    case '5':
					{
						for(var i = 0; i < result.length; i++)
						{
							var obj = result[i];
							var agei = cage(obj,i).toString();//第i患者的年龄
							if(agei >= "51" && agei <= "60" )
							{addRecord(obj,i);count++;}
						}
						break;
				     }
				    case '6':
					{
						for(var i = 0; i < result.length; i++)
						{
							var obj = result[i];
							var agei = cage(obj,i).toString();//第i患者的年龄
							if(agei >= "61" && agei <= "70" )
							{addRecord(obj,i);count++;}
						}
						break;
				     }
				    case '7':
					{
						for(var i = 0; i < result.length; i++)
						{
							var obj = result[i];
							var agei = cage(obj,i).toString();//第i患者的年龄
							if(agei > "70")
							{addRecord(obj,i);count++;}
						}
						break;
				     }
                 }//switch结束
                 $("#ui_txt_bold04").html(count);
			}//else结束
		}//性别为空结束
		else//性别不空
		{
			if(xage == "")
			{
				$("#ptable  tr:not(:first)").html("");
				for(var i = 0; i < result.length; i++)
				{
					var obj = result[i];
					if(obj.patient.sex.toString() == xsex)
					{addRecord(obj,i);count++;}
				}
				$("#ui_txt_bold04").html(count);
			}//性别不空，年龄空
			else//都非空
			{
				$("#ptable  tr:not(:first)").html("");
				switch(xage)
				{
					case '0':
					{
						for(var i = 0; i < result.length; i++)
						{
							var obj = result[i];
							var agei = cage(obj,i).toString();//第i患者的年龄
							if(agei >= "0" && agei <= "10" && obj.patient.sex.toString()== xsex.toString())
							{addRecord(obj,i);count++;}
						}
						break;
					 }
					case '1':
					{
						for(var i = 0; i < result.length; i++)
						{
							var obj = result[i];
							var agei = cage(obj,i).toString();//第i患者的年龄
							if(agei >= "11" && agei <= "20" && obj.patient.sex.toString()== xsex.toString())
							{addRecord(obj,i);count++;}
						}
						break;
					 }
					case '2':
					{
						for(var i = 0; i < result.length; i++)
						{
							var obj = result[i];
							var agei = cage(obj,i).toString();//第i患者的年龄
							if(agei >= "21" && agei <= "30" && obj.patient.sex.toString()== xsex.toString())
							{addRecord(obj,i);count++;}
						}
						break;
				     }
				    case '3':
					{
						for(var i = 0; i < result.length; i++)
						{
							var obj = result[i];
							var agei = cage(obj,i).toString();//第i患者的年龄
							if(agei >= "31" && agei <= "40" && obj.patient.sex.toString()== xsex.toString())
							{addRecord(obj,i);count++;}
							
						}
						break;
				     }
				    case '4':
					{
						for(var i = 0; i < result.length; i++)
						{
							var obj = result[i];
							var agei = cage(obj,i).toString();//第i患者的年龄
							if(agei >= "41" && agei <= "50" && obj.patient.sex.toString()== xsex.toString())
							{addRecord(obj,i);count++;}
						}
						break;
				     }
				    case '5':
					{
						for(var i = 0; i < result.length; i++)
						{
							var obj = result[i];
							var agei = cage(obj,i).toString();//第i患者的年龄
							if(agei >= "51" && agei <= "60" && obj.patient.sex.toString()== xsex.toString())
							{addRecord(obj,i);count++;}
						}
						break;
				     }
				    case '6':
					{
						for(var i = 0; i < result.length; i++)
						{
							var obj = result[i];
							var agei = cage(obj,i).toString();//第i患者的年龄
							if(agei >= "61" && agei <= "70" && obj.patient.sex.toString()== xsex.toString())
							{addRecord(obj,i);count++;}
						}
						break;
				     }
				    case '7':
					{
						for(var i = 0; i < result.length; i++)
						{
							var obj = result[i];
							var agei = cage(obj,i).toString();//第i患者的年龄
							if(agei > "70" && obj.patient.sex.toString()== xsex.toString())
							{addRecord(obj,i);count++;}
						}
						break;
				     }
                 }//switch结束
                 $("#ui_txt_bold04").html(count);
			}//都非空结束	
		}//性别不空结束
	}//函数结束
	/*病人-删除*/
	function patient_del(obj, id) {
		layer.confirm('确认要删除吗？', function(index) {
			$.ajax({
				url : 'deleteDandpById',
				type : 'POST',
				data : {
					"id" : id
				},
				dataType : 'text',
				success : function(data) {
					layer.alert('删除成功!',{
						icon:1,
						yes:function(){
							window.location.reload();
						}
					})
				},
				error : function(data) {
				    layer.alert('删除失败!请刷新重试',{
						icon:2,
						yes:function(){
							//window.location.reload();
						}
					});
				},
			});
		});
	}
	
	function batch_del(){
		var check = document.getElementsByName("IDCheck");
		var ids = "";
		for(var k = 0; k < check.length; k++){
			if(check.item(k).checked){
				ids = ids + check.item(k).value + " ";
			}
		}
		//alert(ids);
		
		layer.confirm('确认要批量删除吗？',function(index){
			$.ajax({
				type: 'POST',
				url: 'batchDeleteDandps',
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
	
	//按姓名查找患者
	function search()
	{
		var dep = document.getElementById("fyZldz").value;
		var count = 0;
		if(dep.toString() == "" || dep.toString() == null)
		{
			$("#ptable  tr:not(:first)").html("");
			for(var i = 0; i < result.length; i++)
			{	
				var obj = result[i];
				addRecord(obj,i);
			}
			$("#ui_txt_bold04").html(result.length);
		}
		else
		{
			$("#ptable  tr:not(:first)").html("");
			for(var i = 0; i < result.length; i++)
			{
				var obj = result[i];
				if(obj.patient.name.toString().indexOf(dep) != -1)
				{
					addRecord(obj,i);
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
	.alt td{ background:black !important;}
</style>

</head>
<body>
	<!-- <form id="submitForm" name="submitForm" action="" method="post"> -->
		<input type="hidden" name="allIDCheck" value="" id="allIDCheck"/>
		<input type="hidden" name="fangyuanEntity.fyXqName" value="" id="fyXqName"/>
		<div id="container">
			<div class="ui_content">
				<div class="ui_text_indent">
					<div id="box_border">
					  <div><br><h1 style="text-align: center;">患者列表</h1><br></div>
						<div id="box_top">搜索</div>
						<div id="box_center">
							性别
							<select name="fangyuanEntity.fyXqCode" id="fyXq" class="ui_select01" >
                                <option value="">--请选择--</option>
                                <option value="0">女</option>
                                <option value="1">男</option>
                            </select>

							年龄
							<select name="fangyuanEntity.fyDhCode" id="fyDh" class="ui_select01">
                                <option value="">--请选择--</option>
                                <option value="0">1-10岁</option>
                                <option value="1">11-20岁</option>
                                <option value="2">21-30岁</option>
                                <option value="3">31-40岁</option>
                                <option value="4">41-50岁</option>
                                <option value="5">51-60岁</option>
                                <option value="6">61-70岁</option>
                                <option value="7">70岁以上</option>
                            </select>
						   
							<input type="button" value="筛选" class="ui_input_btn01" onclick="filter();" /> 
							

							<input	type="text" id="fyZldz" style="float:right;margin-right:95px;margin-top:10px;" name="fangyuanEntity.fyZldz"
								class="ui_input_txt02" placeholder="请输入姓名查找" onKeyDown="keypp()" />
								
							<input type="button" id="Tosearch" value="查询" style="float:right;margin-right:-240px;margin-top:10px;" class="ui_input_btn01" onclick="search();" />
							
						</div>
					</div>
				</div>
			</div>
			<div class="ui_content">
				<div class="ui_tb">
					<table id="ptable" class="table" cellspacing="0" cellpadding="0" width="100%" align="center" border="0">
						<tr>
							<th width="30"><input type="checkbox" id="all" onclick="selectOrClearAllCheckbox(this);" />
							</th>
							<th>挂号日期</th>
							<th>姓名</th>
							<th>性别</th>
							<th>年龄</th>
							<th>发病部位</th>
							<th>操作</th>
						</tr>
					</table>
				</div>
				<div class="ui_tb_h30">
					<div class="ui_flt" style="height: 30px; line-height: 30px;">
						<input type="button" value="批量删除" class="ui_input_btn01" onclick="batch_del();" /> 
						共有
						<span class="ui_txt_bold04" id="ui_txt_bold04"></span>
						条记录
					</div>
				</div>
			</div>
		</div>
<!-- 	</form> -->

</body>
</html>