<%@page import="com.cn.POJO.Doctor"%>
<%@page import="com.cn.POJO.User"%>
<%@page import="java.util.*"%>
<%@page import="java.text.*"%>
<%@page import="java.lang.*"%>
<%@page import="com.opensymphony.xwork2.ActionContext"%>
<%@ page contentType="text/html;charset=UTF-8" language="java"
	import="java.util.*" pageEncoding="UTF-8"%>
<taglib prefix="s" uri="/struts-tags"> <%
 	String path = request.getContextPath();
 	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
 			+ path + "/";
 	User user = (User) ActionContext.getContext().getSession().get("loginUser");
 	Doctor doctor = user.getDoctor();
 %> <%
 	String name = "";//姓名
 	String sex = "";//性别
 	Date dt = new Date();
 	String birthday = "";
 	String department = "";//科室
 	String title = "";//职称
 	String desc = "";//医生简介

 	String logoName = "姓名";
 	String logoBday = "生日";
 	String logoSign = "个性签名";
 	String description="";//医生简介
 	
 	if(doctor.getName() != null){
 		name = doctor.getName().toString();
 	}
 	if (doctor.getBirthday() != null) {
 		//birthday = patient.getBirthday().toString();
 		//logoBday = patient.getBirthday().toString(); 	
 		String year;
 		String month;
 		String day;	 
 		String  bir = DateFormat.getDateInstance().format(doctor.getBirthday());
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
 	if (doctor.getSex() != null) {
 		sex = (doctor.getSex() == 1 ? "男" : "女");
 	}
 	if(doctor.getDepartment() !=null){
 		department = doctor.getDepartment().toString();
 	}
 	
 	if(doctor.getTitle() != null){
 		title = doctor.getTitle().toString();
 	} 
 	if(doctor.getDescription() != null){
 		description = doctor.getDescription().toString();
 	}

/* 
 	if (patient.getName() != null) {
 		name = patient.getName();
 		logoName = patient.getName();
 	}
 	if (patient.getSex() != null) {
 		sex = (patient.getSex() == 0 ? "男" : "女");
 	}
 	if (patient.getBirthday() != null) {
 		birthday = patient.getBirthday().toString();
 		logoBday = patient.getBirthday().toString();
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
 	} */
 %> <script type="text/javascript">
 	function formsSubmit() {
 		//alert("开始提交表单");
 	document.getElementById("userinfoForm").submit();
 	//document.getElementById("patientForm").submit();
 	//document.getElementById("contactForm").submit();
 	}
 	 
 	 window.onload = function(){
        onChange();
        onBirthday();
         onCChange();
       
         if("<%=department%>" == "1") 
         {
         	 document.getElementById("dep").innerHTML="医师"; 
         }        
        else if("<%=department%>" == "2") 
        {
         	 document.getElementById("dep").innerHTML="主治医师"; 
        }
        else if("<%=department%>" == "3") 
        {
         	 document.getElementById("dep").innerHTML="副主任医师"; 
        } 
        else if("<%=department%>" == "4") 
        {
         	 document.getElementById("dep").innerHTML="主任医师"; 
        } 
        onCCChange();
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
		var birth = document.getElementById("birthday");
		if("<%=birthday%>" != null)
	 	{
	 		document.getElementById("birthday").value= "<%=birthday%>";	 		
	 	}
	}
	   function onCChange(){								           
	 	//var myselect = document.getElementById("");
	 	var all_options = document.getElementById("department").options;
	 	if("<%=department%>" == "")
	 	{
	 		all_options[0].selected = true;
	 	} 
	 	else if("<%=department%>" == "0")
	 	{
	 		all_options[1].selected = true;
	 	}
	 	else if("<%=department%>" == "1")
	 	{
	 		all_options[2].selected = true;
	 	}
	 	else if("<%=department%>" == "2")
	 	{
	 		all_options[3].selected = true;
	 	}
	 	else if("<%=department%>" == "3")
	 	{
	 		all_options[4].selected = true;
	 	}
	 	else if("<%=department%>" == "4")
	 	{
	 		all_options[5].selected = true;
	 	}
	 	else if("<%=department%>" == "5")
	 	{
	 		all_options[6].selected = true;
	 	}  
	 	else if("<%=department%>" == "6")
	 	{
	 		all_options[7].selected = true;
	 	}
	 	else if("<%=department%>" == "7")
	 	{
	 		all_options[8].selected = true;
	 	}
	 	else if("<%=department%>" == "8")
	 	{
	 		all_options[9].selected = true;
	 	}
	 	else if("<%=department%>" == "9")
	 	{
	 		all_options[10].selected = true;
	 	}
	 	else if("<%=department%>" == "10")
	 	{
	 		all_options[11].selected = true;
	 	}  
	 	else if("<%=department%>" == "11")
	 	{
	 		all_options[12].selected = true;
	 	}
	 	else if("<%=department%>" == "12")
	 	{
	 		all_options[13].selected = true;
	 	}
	 	else if("<%=department%>" == "13")
	 	{
	 		all_options[14].selected = true;
	 	}
	 	else if("<%=department%>" == "14")
	 	{
	 		all_options[15].selected = true;
	 	} 
	 	else if("<%=department%>" == "15")
	 	{
	 		all_options[16].selected = true;
	 	}  
	}
		function onCCChange(){	
		
	 	//var myselect = document.getElementById("");
	 	var all_options = document.getElementById("title").options;
	 //	alert("++");
	 	if("<%=title%>" == "")
	 	{
	 		all_options[0].selected = true;
	 	     
	 	} 
	 	else if("<%=title%>" == "0")
	 	{
	 		all_options[1].selected = true;
	 		//alert("++");
	 		document.getElementById("dep").value="医师"; 
	 		//alert("--");
	 	}
	 	else if("<%=title%>" == "1")
	 	{
	 		all_options[2].selected = true;
	 		 document.getElementById("dep").innerHTML="主治医师"; 
	 	}   
	 	else if("<%=title%>" == "2")
	 	{
	 		all_options[3].selected = true;
	 		 document.getElementById("dep").innerHTML="副主任医师"; 
	 	}
	 	else if("<%=title%>" == "3")
	 	{
	 		all_options[4].selected = true;
	 		document.getElementById("dep").innerHTML="主任医师"; 
	 	}   
	}
	
 </script> <!DOCTYPE html>
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
<link href="<%=path%>/css/user.main.css" rel="stylesheet" />
<link href="<%=path%>/css/user.all.css" rel="stylesheet">
<link href="<%=path%>/css/bootstrapMM.min.css" rel="stylesheet" />
<link href="<%=path%>/css/now-ui-dashboard.css?v=1.0.1" rel="stylesheet" />
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
							<form id="userinfoForm" action="updateDoctor" method="post"
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

								</div>

								<div class="row">
									<div class="col-md-5 pr-1">
										<div class="form-group">
											<label>UUID</label> <input type="text" name="hashcode"
												class="form-control" disabled="" placeholder="UUID"
												value="<%=user.getUuid()%>">
										</div>
									</div>
								</div>

								<div class="row">
									<div class="col-md-3 pr-1">
										<div class="form-group">
											<label>姓名</label> <input type="text" name="name"
												class="form-control" placeholder="请输入姓名" value="<%=name%>">
										</div>
									</div>
									<div class="col-md-2 pr-1">
										<div class="form-group">
											<label>性别</label> <select class="form-control" id="sex"
												name="sex" onChange="sex('parent',this,-1)">
												<option value="-1">请选择</option>
												<option value="0">女</option>
												<option value="1">男</option>
											</select>
										</div>
									</div>
									<div class="col-md-4 px-1">
										<div class="form-group">
											<label>生日</label> <input type="date"
												style="line-height: inherit" id="birthday" name="birthday"
												class="form-control">
										</div>
									</div>

								</div>
								<div class="row">
									<div class="col-md-4 pl-1">
										<div class="form-group">
											<label for="exampleInputEmail1">科室</label> <select
												class="form-control" id="department" name="department"
												onCChange="department('parent',this,-1)">
												<option value="-1">请选择</option>
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
											</select>
										</div>
									</div>
									<div class="col-md-3 pl-1">
										<div class="form-group">
											<label for="exampleInputEmail1">职称</label> <select
												class="form-control" id="title" name="title"
												onCCChange="title('parent',this,-1)">
												<option value="-1">请选择</option>
												<option value="0">医师</option>
												<option value="1">主治医师</option>
												<option value="2">副主任医师</option>
												<option value="3">主任医师</option>
											</select>
										</div>
									</div>
								</div>

								<div class="row">
									<div class="col-md-12">
										<div class="form-group">
											<label>医师简介</label>
											<textarea rows="4" name="desc" cols="80" class="form-control"
												placeholder="医师简介" value="<%=description%>"><%=description%></textarea>
										</div>
									</div>
								</div>
							</form>
						</div>

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
									<h5 class="title"><%=name%></h5>
								</a>
								<p class="description">
									<%=birthday%>
								</p>
							</div>
							<p class="description text-center" id="dep"></p>
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
<script src="<%=path%>/js/core/jquery.min.js"></script>
<script src="<%=path%>/js/core/popper.min.js"></script>
<script src="<%=path%>/js/core/bootstrap.min.js"></script>
<script src="<%=path%>/js/perfect-scrollbar.jquery.min.js"></script>
<script src="<%=path%>/js/chartjs.min.js"></script>
<script src="<%=path%>/js/bootstrap-notify.js"></script>
<script src="<%=path%>/js/now-ui-dashboard.js?v=1.0.1"></script>
<script src="<%=path%>/js/demo.js"></script>

</html>