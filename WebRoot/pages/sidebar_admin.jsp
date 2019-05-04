<%@page import="com.cn.POJO.User"%>
<%@page import="com.opensymphony.xwork2.ActionContext"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" import="java.util.*" pageEncoding="UTF-8"%>
<taglib prefix="s" uri="/struts-tags">
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
User user = (User) ActionContext.getContext().getSession().get("loginUser");
%>

<script type="text/javascript">
	function submitForm(id){
		document.getElementById(id).submit();
	}
	
	function quit(){
        parent.quit();
        //parent.window.document.getElementById("button").value="调用结束";
    }
    
    function returnIndex(){
    	parent.window.location.href = "<%=path%>/index.html";
    }
    
    function changeMaincontent(contentPath){
    	parent.window.document.getElementById("maincontent").src = contentPath;
    }
    
</script>

<% 
	String role = "";
	int num = user.getRole();
	if(num == 0){
		role = "患者";
	}else if(num == 1){
		role = "医生";
	}else{
		role = "管理员";
	}

%>

<!DOCTYPE html>
<html>
  <head>
    <title>Sidebar</title>    
	<meta charset="UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"> 
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="<%=path%>/css/bootstrap.min.css" rel="stylesheet">
	<link href="<%=path%>/css/font-awesome.min.css" rel="stylesheet">
	<link rel="stylesheet" type="text/css" href="<%=path%>/css/htmleaf-demo.css">
	<link rel="stylesheet" href="<%=path%>/assets/css/jquery.mCustomScrollbar.min.css" />
    <link rel="stylesheet" href="<%=path%>/assets/css/custom.css">
  </head>	
	<script src="<%=path%>/js/jquery-1.11.0.min.js" type="text/javascript"></script>
	<script>window.jQuery || document.write('<script src="js/jquery-1.11.0.min.js"><\/script>')</script>
	<script src="<%=path%>/js/bootstrap.min.js"></script>
	<script src="<%=path%>/assets/js//jquery.mCustomScrollbar.concat.min.js"></script>
    <script src="<%=path%>/assets/js/custom.js"></script>
  
 <body>
	<div class="page-wrapper toggled">
            <nav id="sidebar" class="sidebar-wrapper">
              <div class="sidebar-content">
                <!-- <a href="#" id="toggle-sidebar"><i class="fa fa-bars"></i></a> -->
                <div class="sidebar-brand">
                    <a href="javascript:;" onclick="returnIndex()">Star Health</a>
                </div>
                <div class="sidebar-header">
                    <div class="user-pic">
                        <img class="img-responsive img-rounded" src="<%=path%>/assets/img/user.jpg" alt="">
                    </div>
                    <div class="user-info">
                        <span class="user-name"><%= user.getUsername() %></strong></span>
                        <span class="user-role"><%= role %></span>
                        <%-- <span class="user-role"><strong>UUID：</strong><%= user.getUuid() %></span> --%>
                        <div class="user-status">                       
                        </div>
                    </div>
                </div>
            
                <div class="sidebar-menu">
                    <ul>    
                        <li class="header-menu"><span>功能列表</span></li>
                        <li><a href="javascript:;" onclick="changeMaincontent('member_list.jsp')"><i class="fa fa-tv"></i><span>用户管理</span></a></li>           
                        <li><a href="javascript:;" onclick="changeMaincontent('feedback_list.jsp')"><i class="fa fa-photo"></i><span>留言管理</span></a></li>
                        <li><a href="javascript:;" onclick="changeMaincontent('resetpwd.jsp')"><i class="fa fa-diamond"></i><span>修改密码</span></a></li>
                        <li><a href="javascript:;" onclick="quit()"><i class="fa fa-diamond"></i><span>退出系统</span></a></li>
                        
                    </ul>
                   </div>         
                </div>
     
            </nav>
			
        </div>
	</body>
</html>
