<%@page import="com.cn.POJO.User"%>
<%@page import="com.opensymphony.xwork2.ActionContext"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" import="java.util.*" pageEncoding="UTF-8"%>
<taglib prefix="s" uri="/struts-tags">
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
User user = (User) ActionContext.getContext().getSession().get("loginUser");
%>

<script type="text/javascript" src="<%=path %>/js/jquery-3.2.1.min.js"></script>
<script type="text/javascript">
	function quit(){
    	document.getElementById("quit").submit();
    }
    
    window.onload = function(){
    	var role = "<%=user.getRole()%>";
    	if(role == "0"){
    	   $("#sidebar").attr("src","sidebar_patient.jsp");
    	   $("#maincontent").attr("src","patient_zym.html");
    	}else if(role == "1"){
    		$("#sidebar").attr("src","sidebar.jsp");
    		$("#maincontent").attr("src","doctor_zym.html");
    	}else{
    		$("#sidebar").attr("src","sidebar_admin.jsp");
    		$("#maincontent").attr("src","admin_zym.html");
    	}
    }
</script>

<!DOCTYPE html>
<html>
  <head>
    <!-- <base href="< %=basePath%>"> -->
    
    <title>平台页面 </title>
	<meta charset="UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"> 
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<style type="text/css">
		html,body {
		height: 100%;
		margin: 0;
		overflow: hidden;
		}
		#sidebar{
			width:18.5%;
			float:left;
		}
		#maincontent{
			width:81%;
		} 
	</style>
</head>
  
<body style = "height:100%">
<!-- < %=basePath%>/pages/ -->
	<form id="quit" action="user_quit" method="post" display="no" namespace="/pages"></form>
	<iframe id="sidebar" name = "sidebar" frameborder="no" border="0" width="18.5%" height="100%" marginwidth="0" marginheight="0"></iframe>
	<iframe id="maincontent"  name = "maincontent"  width="81%"; frameborder="no" border="0" height="100%" marginwidth="0" marginheight="0"></iframe>
</boy>
</html>
