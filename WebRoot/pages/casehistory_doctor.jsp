<%@ page import="com.cn.POJO.User"%>
<%@ page import="com.opensymphony.xwork2.ActionContext"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<taglib prefix="s" uri="/struts-tags">
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
User user = (User) ActionContext.getContext().getSession().get("loginUser");
%>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<script type="text/javascript" src="../gyscripts/jquery/jquery-1.7.1.js"></script>
<link href="../gystyle/authority/basic_layout.css" rel="stylesheet" type="text/css">
<link href="../gystyle/authority/common_style.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="../gyscripts/authority/commonAll.js"></script>
<script type="text/javascript" src="../gyscripts/fancybox/jquery.fancybox-1.3.4.js"></script>
<script type="text/javascript" src="../gyscripts/fancybox/jquery.fancybox-1.3.4.pack.js"></script>
<link rel="stylesheet" type="text/css" href="../gystyle/authority/jquery.fancybox-1.3.4.css" media="screen"></link>
<script type="text/javascript" src="../gyscripts/artDialog/artDialog.js?skin=default"></script>
<title>病历列表</title>
<script type="text/javascript">

	var result;
	
	$(document).ready(function(){

		$.ajax(
			{
				url : "findHistoryRecordByDid",
				type : "POST",
				data : {"did" : <%= user.getUid() %>,},
				dataType : "JSON",
			
				success : function(data)
				{
					result = data;
					//alert(JSON.stringify(data));
					var xh=1;
					for(var i = data.length-1; i>=0; i--)
						{
							
							addRecord(data[i], i, xh);
							xh++;
						}
					$("#ui_txt_bold04").html(data.length);
				},
			
				error : function(data)
				{
			  		alert("+++++" + JSON.stringify(data));
					alert("请求失败，请重试");
					alert(data);
				}
			});
		 $("a.edit").fancybox({
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
	
	function addRecord(obj, i, xh)
	{
		
		var html = "";
		html += "<tr>";
		html += "<td>" + xh + "</td>";
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
		html += "<a href=\"casehistory_content.html?fyID="+encodeURI(JSON.stringify(obj))+"\"  class=\"edit\" style=\"margin-right:5px\">查看病历内容</a>";
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
	
	//按姓名查找患者
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
				if(obj.patient.name.toString().indexOf(dep) != -1)
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
	
	
	function filter2(){
		//筛选医生列表
		var xsex = document.getElementById("fyXq").value;
		var xage = document.getElementById("fyDh").value;
		var startTime = document.getElementById("startTime").value;
		var endTime = document.getElementById("endTime").value;	
		var xh=1;
	//开始时间小于结束时间
		if(startTime > endTime)
		{
			alert("查找开始日期必须小于结束日期！");
			$("#ptable  tr:not(:first)").html("");
			for(var i = result.length-1; i >=0; i--)
			{
						var obj = result[i];
						addRecord(obj, i,xh);
						xh++;
			}
			$("#ui_txt_bold04").html(result.length);
		}
		var count = 0;
		
	//性别和年龄和日期为空
		if(xage == "")
		{
			if(xsex == "")
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
				} //三个空
				
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
						$("#ui_txt_bold04").html(count);						
					}
				}//时间
			}//年龄 性别空结束
			else
			{
				if((startTime.toString() =="" || startTime.toString() == null) && (endTime.toString() =="" || endTime.toString() == null))	
				{
					$("#ptable  tr:not(:first)").html("");
					var xh=1;
					for(var i = result.length-1; i >=0; i--)
					{
						var obj = result[i];
						if(obj.patient.sex.toString() == xsex)
						{addRecord(obj, i,xh);xh++;count++;}
					}
					$("#ui_txt_bold04").html(count);
				}//性别
				else
				{
					$("#ptable  tr:not(:first)").html("");
					var xh=1;
					for(var i = result.length-1; i >=0; i--)
					{
						var obj = result[i];
						startTime += "T00:00:00";
		                endTime += "T23:59:59";						
						if(obj.time>=startTime && obj.time <=endTime && obj.patient.sex.toString()== xsex.toString())
						{addRecord(obj, i,xh);xh++;count++;}
						$("#ui_txt_bold04").html(count);						
					}
				}//性别 时间
			}
		}
		else //年龄非空
		{
			if(xsex == "")
			{
				if((startTime.toString() =="" || startTime.toString() == null) && (endTime.toString() =="" || endTime.toString() == null))
				{ //只有年龄
					$("#ptable  tr:not(:first)").html("");
					var xh=1;
					switch(xage)
					{
						case '0':
						{
							for(var i = result.length-1; i >=0; i--)
							{
								var obj = result[i];
								var agei = cage(obj,i).toString();//第i患者的年龄
								if(agei >= 0 && agei <= 10 )
								{addRecord(obj, i,xh);xh++;count++;}
							}
							break;
					 	}
						case '1':
						{
							for(var i = result.length-1; i >=0; i--)
							{
								var obj = result[i];
								var agei = cage(obj,i).toString();//第i患者的年龄
								if(agei >= "11" && agei <= "20" )
								{addRecord(obj, i,xh);xh++;count++;}
							}
							break;
						 }
						case '2':
						{
							for(var i = result.length-1; i >=0; i--)
							{
								var obj = result[i];
								var agei = cage(obj,i).toString();//第i患者的年龄
								if(agei >= "21" && agei <= "30" )
								{addRecord(obj, i,xh);xh++;count++;}
							}
							break;
				     	}
				    	case '3':
						{
							for(var i = result.length-1; i >=0; i--)
							{
								var obj = result[i];
								var agei = cage(obj,i).toString();//第i患者的年龄
								if(agei >= "31" && agei <= "40" )
								{addRecord(obj, i,xh);xh++;count++;}
							
							}
							break;
				     	}
				    	case '4':
						{
							for(var i = result.length-1; i >=0; i--)
							{
								var obj = result[i];
								var agei = cage(obj,i).toString();//第i患者的年龄
								if(agei >= "41" && agei <= "50" )
								{addRecord(obj, i,xh);xh++;count++;}
							}
							break;
				     	}
				    	case '5':
						{
							for(var i = result.length-1; i >=0; i--)
							{
								var obj = result[i];
								var agei = cage(obj,i).toString();//第i患者的年龄
								if(agei >= "51" && agei <= "60" )
								{addRecord(obj, i,xh);xh++;count++;}
							}
							break;
				     	}
				    	case '6':
						{
							for(var i = result.length-1; i >=0; i--)
							{
								var obj = result[i];
								var agei = cage(obj,i).toString();//第i患者的年龄
								if(agei >= "61" && agei <= "70" )
								{addRecord(obj, i,xh);xh++;count++;}
							}
							break;
				     	}
				   		case '7':
						{
							for(var i = result.length-1; i >=0; i--)
							{
								var obj = result[i];
								var agei = cage(obj,i).toString();//第i患者的年龄
								if(agei > "70")
								{addRecord(obj, i,xh);xh++;count++;}
							}
							break;
				     	}
                 	}//switch结束
                	$("#ui_txt_bold04").html(count);
				}
				else //年龄和时间
				{
					$("#ptable  tr:not(:first)").html("");
					var xh=1;
					switch(xage)
					{
						case '0':
						{
							for(var i = result.length-1; i >=0; i--)
							{
								var obj = result[i];
								startTime += "T00:00:00";
		                		endTime += "T23:59:59";
								var agei = cage(obj,i).toString();//第i患者的年龄
								if(agei >= 0 && agei <= 10 && obj.time>=startTime && obj.time <=endTime)
								{addRecord(obj, i,xh);xh++;count++;}
							}
							break;
					 	}
						case '1':
						{
							for(var i = result.length-1; i >=0; i--)
							{
								var obj = result[i];
								startTime += "T00:00:00";
		                		endTime += "T23:59:59";
								var agei = cage(obj,i).toString();//第i患者的年龄
								if(agei >= "11" && agei <= "20" && obj.time>=startTime && obj.time <=endTime)
								{addRecord(obj, i,xh);xh++;count++;}
							}
							break;
						 }
						case '2':
						{
							for(var i = result.length-1; i >=0; i--)
							{
								var obj = result[i];
								startTime += "T00:00:00";
		                		endTime += "T23:59:59";
								var agei = cage(obj,i).toString();//第i患者的年龄
								if(agei >= "21" && agei <= "30" && obj.time>=startTime && obj.time <=endTime)
								{addRecord(obj, i,xh);xh++;count++;}
							}
							break;
				     	}
				    	case '3':
						{
							for(var i = result.length-1; i >=0; i--)
							{
								var obj = result[i];
								startTime += "T00:00:00";
		                		endTime += "T23:59:59";
								var agei = cage(obj,i).toString();//第i患者的年龄
								if(agei >= "31" && agei <= "40" && obj.time>=startTime && obj.time <=endTime)
								{addRecord(obj, i,xh);xh++;count++;}
							
							}
							break;
				     	}
				    	case '4':
						{
							for(var i = result.length-1; i >=0; i--)
							{
								var obj = result[i];
								startTime += "T00:00:00";
		                		endTime += "T23:59:59";
								var agei = cage(obj,i).toString();//第i患者的年龄
								if(agei >= "41" && agei <= "50" && obj.time>=startTime && obj.time <=endTime)
								{addRecord(obj, i,xh);xh++;count++;}
							}
							break;
				     	}
				    	case '5':
						{
							for(var i = result.length-1; i >=0; i--)
							{
								var obj = result[i];
								startTime += "T00:00:00";
		                		endTime += "T23:59:59";
								var agei = cage(obj,i).toString();//第i患者的年龄
								if(agei >= "51" && agei <= "60" && obj.time>=startTime && obj.time <=endTime)
								{addRecord(obj, i,xh);xh++;count++;}
							}
							break;
				     	}
				    	case '6':
						{
							for(var i = result.length-1; i >=0; i--)
							{
								var obj = result[i];
								startTime += "T00:00:00";
		                		endTime += "T23:59:59";
								var agei = cage(obj,i).toString();//第i患者的年龄
								if(agei >= "61" && agei <= "70" && obj.time>=startTime && obj.time <=endTime)
								{addRecord(obj, i,xh);xh++;count++;}
							}
							break;
				     	}
				   		case '7':
						{
							for(var i = result.length-1; i >=0; i--)
							{
								var obj = result[i];
								startTime += "T00:00:00";
		                		endTime += "T23:59:59";
								var agei = cage(obj,i).toString();//第i患者的年龄
								if(agei > "70" && obj.time>=startTime && obj.time <=endTime)
								{addRecord(obj, i,xh);xh++;count++;}
							}
							break;
				     	}
                 	}//switch结束
                	$("#ui_txt_bold04").html(count);
				}	
			}
			else//性别非空
			{
				if((startTime.toString() =="" || startTime.toString() == null) && (endTime.toString() =="" || endTime.toString() == null))
				{
					$("#ptable  tr:not(:first)").html("");
					var xh=1;
					switch(xage)
					{
						case '0':
						{
							for(var i = result.length-1; i >=0; i--)
							{
								var obj = result[i];
								var agei = cage(obj,i).toString();//第i患者的年龄
								if(agei >= 0 && agei <= 10 && obj.patient.sex.toString()== xsex.toString())
								{addRecord(obj, i,xh);xh++;count++;}
							}
							break;
						 }
						case '1':
						{
							for(var i = result.length-1; i >=0; i--)
							{
								var obj = result[i];
								var agei = cage(obj,i).toString();//第i患者的年龄
								if(agei >= "11" && agei <= "20" && obj.patient.sex.toString()== xsex.toString())
								{addRecord(obj, i,xh);xh++;count++;}
							}
							break;
						 }
						case '2':
						{
							for(var i = result.length-1; i >=0; i--)
							{
								var obj = result[i];
								var agei = cage(obj,i).toString();//第i患者的年龄
								if(agei >= "21" && agei <= "30" && obj.patient.sex.toString()== xsex.toString())
								{addRecord(obj, i,xh);xh++;count++;}
							}
							break;
					     }
					    case '3':
						{
							for(var i = result.length-1; i >=0; i--)
							{
								var obj = result[i];
								var agei = cage(obj,i).toString();//第i患者的年龄
								if(agei >= "31" && agei <= "40" && obj.patient.sex.toString()== xsex.toString())
								{addRecord(obj, i,xh);xh++;count++;}
								
							}
							break;
					     }
					    case '4':
						{
							for(var i = result.length-1; i >=0; i--)
							{
								var obj = result[i];
								var agei = cage(obj,i).toString();//第i患者的年龄
								if(agei >= "41" && agei <= "50" && obj.patient.sex.toString()== xsex.toString())
								{addRecord(obj, i,xh);xh++;count++;}
							}
							break;
					     }
					    case '5':
						{
							for(var i = result.length-1; i >=0; i--)
							{
								var obj = result[i];
								var agei = cage(obj,i).toString();//第i患者的年龄
								if(agei >= "51" && agei <= "60" && obj.patient.sex.toString()== xsex.toString())
								{addRecord(obj, i,xh);xh++;count++;}
							}
							break;
					     }
					    case '6':
						{
							for(var i = result.length-1; i >=0; i--)
							{
								var obj = result[i];
								var agei = cage(obj,i).toString();//第i患者的年龄
								if(agei >= "61" && agei <= "70" && obj.patient.sex.toString()== xsex.toString())
								{addRecord(obj, i,xh);xh++;count++;}
							}
							break;
					     }
					    case '7':
						{
							for(var i = result.length-1; i >=0; i--)
							{
								var obj = result[i];
								var agei = cage(obj,i).toString();//第i患者的年龄
								if(agei > "70" && obj.patient.sex.toString()== xsex.toString())
								{addRecord(obj, i,xh);xh++;count++;}
							}
							break;
					     }
	                 }//switch结束
	                 $("#ui_txt_bold04").html(count);
				  }
				  else //都非空
				  {
				  	$("#ptable  tr:not(:first)").html("");
				  	var xh=1;
					switch(xage)
					{
						case '0':
						{
							for(var i = result.length-1; i >=0; i--)
							{
								var obj = result[i];
								startTime += "T00:00:00";
		                		endTime += "T23:59:59";
								var agei = cage(obj,i).toString();//第i患者的年龄
								if(agei >= 0 && agei <= 10 && obj.patient.sex.toString()== xsex.toString() && obj.time>=startTime && obj.time <=endTime)
								{addRecord(obj, i,xh);xh++;count++;}
							}
							break;
						 }
						case '1':
						{
							for(var i = result.length-1; i >=0; i--)
							{
								var obj = result[i];
								startTime += "T00:00:00";
		                		endTime += "T23:59:59";
								var agei = cage(obj,i).toString();//第i患者的年龄
								if(agei >= "11" && agei <= "20" && obj.patient.sex.toString()== xsex.toString()&& obj.time>=startTime && obj.time <=endTime)
								{addRecord(obj, i,xh);xh++;count++;}
							}
							break;
						 }
						case '2':
						{
							for(var i = result.length-1; i >=0; i--)
							{
								var obj = result[i];
								startTime += "T00:00:00";
		                		endTime += "T23:59:59";
								var agei = cage(obj,i).toString();//第i患者的年龄
								if(agei >= "21" && agei <= "30" && obj.patient.sex.toString()== xsex.toString()&& obj.time>=startTime && obj.time <=endTime)
								{addRecord(obj, i,xh);xh++;count++;}
							}
							break;
					     }
					    case '3':
						{
							for(var i = result.length-1; i >=0; i--)
							{
								var obj = result[i];
								startTime += "T00:00:00";
		                		endTime += "T23:59:59";
								var agei = cage(obj,i).toString();//第i患者的年龄
								if(agei >= "31" && agei <= "40" && obj.patient.sex.toString()== xsex.toString()&& obj.time>=startTime && obj.time <=endTime)
								{addRecord(obj, i,xh);xh++;count++;}
								
							}
							break;
					     }
					    case '4':
						{
							for(var i = result.length-1; i >=0; i--)
							{
								var obj = result[i];
								startTime += "T00:00:00";
		                		endTime += "T23:59:59";
								var agei = cage(obj,i).toString();//第i患者的年龄
								if(agei >= "41" && agei <= "50" && obj.patient.sex.toString()== xsex.toString()&& obj.time>=startTime && obj.time <=endTime)
								{addRecord(obj, i,xh);xh++;count++;}
							}
							break;
					     }
					    case '5':
						{
							for(var i = result.length-1; i >=0; i--)
							{
								var obj = result[i];
								startTime += "T00:00:00";
		                		endTime += "T23:59:59";
								var agei = cage(obj,i).toString();//第i患者的年龄
								if(agei >= "51" && agei <= "60" && obj.patient.sex.toString()== xsex.toString()&& obj.time>=startTime && obj.time <=endTime)
								{addRecord(obj, i,xh);xh++;count++;}
							}
							break;
					     }
					    case '6':
						{
							for(var i = result.length-1; i >=0; i--)
							{
								var obj = result[i];
								startTime += "T00:00:00";
		                		endTime += "T23:59:59";
								var agei = cage(obj,i).toString();//第i患者的年龄
								if(agei >= "61" && agei <= "70" && obj.patient.sex.toString()== xsex.toString()&& obj.time>=startTime && obj.time <=endTime)
								{addRecord(obj, i,xh);xh++;count++;}
							}
							break;
					     }
					    case '7':
						{
							for(var i = result.length-1; i >=0; i--)
							{
								var obj = result[i];
								startTime += "T00:00:00";
		                		endTime += "T23:59:59";
								var agei = cage(obj,i).toString();//第i患者的年龄
								if(agei > "70" && obj.patient.sex.toString()== xsex.toString()&& obj.time>=startTime && obj.time <=endTime)
								{addRecord(obj, i,xh);xh++;count++;}
							}
							break;
					     }
	                 }//switch结束
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
					  <div><br><h1 style="text-align: center;">病历列表</h1><br></div>
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
                            
                                                 开始日期 <input type="date" id="startTime" style="height:25px;font-size:14px;">
					 &nbsp; — &nbsp;结束日期 <input type="date" id="endTime" style="height:25px;font-size:14px;">
							<input type="button" value="筛选" class="ui_input_btn01" onclick="filter2();" /> 
							

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
							<th>序号</th>
							<th>就诊日期</th>
							<th>患者姓名</th>
							<th>性别</th>
							<th>年龄</th>
							<th>发病部位</th>
							<th>操作</th>
						</tr>
							
						
					</table>
				</div>
				<div class="ui_tb_h30">
					<div class="ui_flt" style="height: 30px; line-height: 30px;">
						&nbsp;&nbsp;
						共有
						<span class="ui_txt_bold04" id="ui_txt_bold04"></span>
						条记录
				 </div> 
					
				</div>

			</div>
		</div>
	<!-- </form> -->

</body>
</html>
