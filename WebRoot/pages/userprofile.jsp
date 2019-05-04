<%@page import="com.cn.POJO.Patient"%>
<%@page import="com.cn.POJO.User"%>
<%@ page import="java.util.regex.*"%>
<%@page import="java.util.*" %>
<%@page import="java.text.*"%>
<%@page import="com.opensymphony.xwork2.ActionContext"%>
<%@ page contentType="text/html;charset=UTF-8" language="java"
	import="java.util.*" pageEncoding="UTF-8"%>
<taglib prefix="s" uri="/struts-tags"> <%
 	String path = request.getContextPath();
 	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
 			+ path + "/";
 	User user = (User) ActionContext.getContext().getSession().get("loginUser");
 	Patient patient = user.getPatient();
 %>
 
   <%
 	String name = "";//姓名
 	String sex = "";//性别
 	Date birth= new Date(); 
 	String birthday="";
 	String profession = "";//职业
 	String address = "";//住址
 	String zipcode = "";//邮编
 	String signature = "";//个性签名
 	String contactName = "";//紧急联系人姓名
 	String contactRelation = "";//紧急联系人关系
 	String contactPhone = "";//紧急联系人联系方式
 	String logoName = "姓名";
 	String logoBday = "生日";
 	String logoSign = "个性签名";
 	if (patient.getName() != null) {
 		name = patient.getName();
 		logoName = patient.getName();
 	}
 	if (patient.getSex() != null) {
 		sex = (patient.getSex() == 0 ? "女" : "男");
 	}
 	if (patient.getBirthday() != null) {
 		//birthday = patient.getBirthday().toString();
 		//logoBday = patient.getBirthday().toString(); 		 
 		String year;
 		String month;
 		String day;	 
 		String  bir = DateFormat.getDateInstance().format(patient.getBirthday());
 		String[] str = bir.split("-");
 		if(str[1].length() == 1 && str[1].toString().compareTo("0")>= 0 &&str[1].toString().compareTo("9")<= 0)
 		 {
 		 	str[1] ="0"+str[1];
 		 } 
 		 if(str[2].length() == 1 && str[2].toString().compareTo("0")>=0 && str[2].toString().compareTo("9") <=0)
 		 {
 		 	str[2] ="0"+str[2];
 		 } 
 		 birthday = str[0]+"-"+str[1]+"-"+str[2];	 		
 	}
 	if (patient.getProfession() != null) {
 		profession = patient.getProfession();
 	}
 	if (patient.getAddress() != null) {
 		address = patient.getAddress();
 	}
 	if (patient.getZipcode() != null) {
 		zipcode = patient.getZipcode();
 	}
 	if (patient.getSignature() != null) {
 		signature = patient.getSignature();
 		logoSign = patient.getSignature();
 	}
 	if (patient.getCname() != null) {
 		contactName = patient.getCname();
 	}
 	if (patient.getCrelation() != null) {
 		contactRelation = patient.getCrelation();
 	}
 	if (patient.getCphone() != null) {
 		contactPhone = patient.getCphone();
 	}
 %> 
  
 <script type="text/javascript">
 	function formsSubmit() {
 		document.getElementById("userinfoForm").submit();
 	}
 	window.onload = function(){
        onChange();
        onBirthday();
    }
	function onChange(){	
		
	 	//var myselect = document.getElementById("");
	 	var all_options = document.getElementById("sex").options;
	 	if("<%=sex%>" == "")
	 	{
	 		all_options[0].selected = true;
	 	} 
	 	else if("<%=sex%>" == "女")
	 	{
	 		all_options[1].selected = true;
	 	}
	 	else if("<%=sex%>" == "男")
	 	{
	 		all_options[2].selected = true;
	 	}     
	}
	
	function onBirthday(){
		//var birth = document.getElementById("birthday");
		if("<%=birthday%>" != null)
	 	{	 	   
	 		document.getElementById("birthday").value= '<%=birthday%>';
	 	}
	}
 		
 </script>

<!DOCTYPE html>
<html lang="en">
<head>


<meta charset="utf-8" />
<link rel="apple-touch-icon" sizes="76x76"
	href="<%=path%>/assets/img/apple-icon.png">
<link rel="icon" type="image/png"
	href="<%=path%>/assets/img/favicon.png">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
<title>个人信息</title>
<meta
	content='width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0, shrink-to-fit=no'
	name='viewport' />
<!--     Fonts and icons     -->
<link href="<%=path%>/css/user.main.css" rel="stylesheet" />
<link href="<%=path%>/css/user.all.css" rel="stylesheet">
<!-- CSS Files -->
<link href="<%=path%>/css/bootstrapMM.min.css" rel="stylesheet" />
<link href="<%=path%>/css/now-ui-dashboard.css?v=1.0.1" rel="stylesheet" />
<!-- CSS Just for demo purpose, don't include it in your project -->
<link href="<%=path%>/css/demo.css" rel="stylesheet" />
</head>


<body>
	<div class="main-panel" style="width:100%;">

		<div class="panel-header panel-header-sm"
			style="width:100%; height:15%; background:url(<%=path%>/images/bg-02.jpg);">
		</div>
		<div class="content">
			<div class="row">
				<div class="col-md-8">
					<div class="card">
						<div class="card-header">
							<h5 class="title">个人信息</h5>
						</div>
						<div class="card-body">
							<form id="userinfoForm" action="update" method="post"
								namespace="/pages">
								<div class="row">
									<div class="col-md-3 pr-1">
										<div class="form-group">
											<label>用户名</label> <input type="text" name="username"
												class="form-control" disabled="" placeholder="用户名"
												value="<%=user.getUsername()%>">
										</div>
									</div>
									<div class="col-md-2 px-1">
										<div class="form-group">
											<label>联系方式</label> <input type="text" name="phone"
												class="form-control" placeholder="请输入手机号"
												value="<%=user.getPhone()%>">
										</div>
									</div>
									<div class="col-md-4 pl-1">
										<div class="form-group">
											<label for="exampleInputEmail1">邮箱</label> <input
												type="email" name="email" class="form-control"
												placeholder="请输入邮箱" value="<%=user.getEmail()%>">
										</div>
									</div>
									<div class="col-md-5 pr-1">
										<div class="form-group">
											<label>UUID</label> <input type="text" name="hashcode"
												class="form-control" disabled="" placeholder="UUID"
												value="<%=user.getUuid()%>">
										</div>
									</div>
								</div>
								<!-- </form>
                                <form id="patientForm" action="patient_update" method="post" namespace="/pages">  -->
								<div class="row">
									<div class="col-md-3 pr-1">
										<div class="form-group">
											<label>姓名</label> <input type="text" name="name"
												class="form-control" placeholder="请输入姓名" value="<%=name%>">
										</div>
									</div>
									<div class="col-md-2 pr-1">
										<div class="form-group">
											<label>性别</label>
											   <%--  <input type="text" id = "sex" name="sex"
												class="form-control" placeholder="请输入性别" value="<%=sex%>">  --%>
												<select class ="form-control" id = "sex" name ="sex" onChange="sex('parent',this,-1)" >
												<option value="-1"> 请选择</option>
											  	<option value="0">女</option>  
								                <option value="1">男</option>
								                </select>
										</div>
									</div>
									<div class="col-md-4 px-1">
										<div class="form-group">
											<label>生日</label> <input type="date" id="birthday"  name="birthday" class="form-control" >
										</div>
									</div>
									<div class="col-md-3 pl-1">
										<div class="form-group">
											<label for="exampleInputEmail1">职业</label> <input type="text"
												name="profession" class="form-control" placeholder="请输入职业"
												value="<%=profession%>">
										</div>
									</div>
								</div>
								<div class="row">
									<div class="col-md-6 pr-1">
										<div class="form-group">
											<label>住址</label> <input type="text" name="address"
												class="form-control" placeholder="请输入住址"
												value="<%=address%>">
										</div>
									</div>
									<div class="col-md-3 pr-1">
										<div class="form-group">
											<label>邮编</label> <input type="text" name="zipcode"
												class="form-control" placeholder="请输入邮编"
												value="<%=zipcode%>">
										</div>
									</div>
								</div>
								<div class="row">
									<div class="col-md-12">
										<div class="form-group">
											<label>个性签名</label>
											<textarea rows="4" name="signature" cols="80"
												class="form-control" placeholder="个性签名"
												value="<%=signature%>"><%=signature%></textarea>
										</div>
									</div>
								</div>
								<div class="card-header">
									<h5 class="title">紧急联系人</h5>
								</div>
								<div class="row">
									<div class="col-md-2 pr-1">
										<div class="form-group">
											<label>姓名</label> <input type="text" name="cname"
												class="form-control" placeholder="请输入姓名"
												value="<%=contactName%>">
										</div>
									</div>
									<div class="col-md-2 pr-1">
										<div class="form-group">
											<label>关系</label> <input type="text" name="crelation"
												class="form-control" placeholder="请输入关系"
												value="<%=contactRelation%>">
										</div>
									</div>
									<div class="col-md-4 px-1">
										<div class="form-group">
											<label>联系方式</label> <input type="text" name="cphone"
												class="form-control" placeholder="请输入联系方式"
												value="<%=contactPhone%>">
										</div>
									</div>
								</div>

							</form>
						</div>

						<!--  <div class="card-header">
                                <h5 class="title">紧急联系人</h5>
                            </div> 
                            <div class="card-body">
                                <form id="contactForm" action="contact_update" method="post" namespace="/pages">
                                    <div class="row">
                                        <div class="col-md-2 pr-1">
                                            <div class="form-group">
                                                <label>姓名</label>
                                                <input type="text" name="cname" class="form-control" placeholder="请输入姓名" value="<%=contactName%>">
                                            </div>
                                        </div>
                                        <div class="col-md-2 pr-1">
                                            <div class="form-group">
                                                <label>关系</label>
                                                <input type="text" name="crelation" class="form-control" placeholder="请输入关系" value="<%=contactRelation%>">
                                            </div>
                                        </div>
                                        <div class="col-md-4 px-1">
                                            <div class="form-group">
                                                <label>联系方式</label>
                                                <input type="text" name="cphone" class="form-control" placeholder="请输入联系方式" value="<%=contactPhone%>">
                                            </div>
                                        </div>
                                    </div>
                                </form>
                            </div>-->

					</div>
				</div>
				<div class="col-md-4">
					<div class="card card-user">
						<div class="image">
							<img src="<%=path%>/images/bg5.jpg" alt="...">
						</div>
						<div class="card-body">
							<div class="author">
								<a href="#"> <img class="avatar border-gray"
									src="<%=path%>/assets/img//user.jpg" alt="...">
									<h5 class="title"><%=logoName%></h5>
								</a>
								<p class="description">
									<%=birthday%>
								</p>
							</div>
							<p class="description text-center">
								<%=logoSign%>
							</p>
						</div>
						<hr>
						<div class="button-container">
							<button class="btn btn-neutral btn-icon btn-round btn-lg"
								style="width:100px;">
								<a href="javascript:;" onclick="formsSubmit()"><h8
										class="title">保存信息</h8></a>
							</button>

						</div>
					</div>
				</div>

			</div>

		</div>

	</div>
	</div>
</body>

<!--   Core JS Files   -->
<script src="<%=path%>/js/core/jquery.min.js"></script>
<script src="<%=path%>/js/core/popper.min.js"></script>
<script src="<%=path%>/js/core/bootstrap.min.js"></script>
<script src="<%=path%>/js/perfect-scrollbar.jquery.min.js"></script>
<!--  Google Maps Plugin    -->

<!-- Chart JS -->
<script src="<%=path%>/js/chartjs.min.js"></script>
<!--  Notifications Plugin    -->
<script src="<%=path%>/js/bootstrap-notify.js"></script>
<!-- Control Center for Now Ui Dashboard: parallax effects, scripts for the example pages etc -->
<script src="<%=path%>/js/now-ui-dashboard.js?v=1.0.1"></script>
<!-- Now Ui Dashboard DEMO methods, don't include it in your project! -->
<script src="<%=path%>/js/demo.js"></script>

</html>