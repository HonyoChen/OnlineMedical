<%@ page import="com.cn.POJO.User"%>
<%@ page import="com.opensymphony.xwork2.ActionContext"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<taglib prefix="s" uri="/struts-tags"> <%
 	String path = request.getContextPath();
 	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
 			+ path + "/";
 	User user = (User) ActionContext.getContext().getSession().get("loginUser");
 %>
 <%--  <%
 	String name = "";//姓名
 	String sex = "";//性别
 	Date birth= new Date(); 
 	String birthday="";
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
 	 %>  --%>
 <!doctype html> <!--[if lt IE 7]>      <html class="no-js lt-ie9 lt-ie8 lt-ie7" lang=""> <![endif]-->
<!--[if IE 7]>         <html class="no-js lt-ie9 lt-ie8" lang=""> <![endif]-->
<!--[if IE 8]>         <html class="no-js lt-ie9" lang=""> <![endif]-->
<!--[if gt IE 8]><!-->
<html class="no-js" lang="">
<!--<![endif]-->
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<title>预警平台</title>
<meta name="description" content="Ela Admin - HTML5 Admin Template">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="../assets3/css/normalize.css">
<link rel="stylesheet" href="../assets3/css/bootstrap.min.css">
<link rel="stylesheet" href="../assets3/css/font-awesome.min.css">
<link rel="stylesheet" href="../assets3/css/themify-icons.css">
<link rel="stylesheet" href="../assets3/css/pe-icon-7-filled.css">
<link rel="stylesheet" href="../assets3/css/flag-icon.min.css">
<link rel="stylesheet" href="../assets3/css/cs-skin-elastic.css">
<link rel="stylesheet" href="../assets3/css/style.css">
<!-- <script type="text/javascript" src="https://cdn.jsdelivr.net/html5shiv/3.7.3/html5shiv.min.js"></script> -->
<link href="../assets3/weather/css/weather-icons.css" rel="stylesheet" />
<link href="../assets3/calendar/fullcalendar.css" rel="stylesheet" />

<link href="../assets3/css/charts/chartist.min.css" rel="stylesheet">
<link href="../assets3/css/lib/vector-map/jqvmap.min.css"
	rel="stylesheet">

<style>
#weatherWidget .currentDesc {
	color: #ffffff !important;
}

.traffic-chart {
	min-height: 335px;
}

#flotPie1 {
	height: 150px;
}

#flotPie1 td {
	padding: 3px;
}

#flotPie1 table {
	top: 20px !important;
	right: -10px !important;
}

.chart-container {
	display: table;
	min-width: 270px;
	text-align: left;
	padding-top: 10px;
	padding-bottom: 10px;
}

#flotLine5 {
	height: 105px;
}

#flotBarChart {
	height: 150px;
}

#cellPaiChart {
	height: 160px;
}
</style>
</head>

<body>
	<!-- Right Panel -->
	<div id="right-panel" class="right-panel">
		<!-- Header-->
		<header id="header" class="header">
			<div class="top-left">
				<div class="navbar-header">
					<img src="../images/logo.png" alt="Logo">
				</div>
			</div>
	</div>
	</div>
	</header>
	<!-- /#header -->

	<div id="test"></div>
	<!-- Content -->
	<div class="content">
		<!-- Animated -->
		<div class="animated fadeIn">
			<!-- Widgets  -->
			<div class="row">
				<div class="col-lg-3 col-md-6">
					<div class="card">
						<div class="card-body">
							<div class="stat-widget-five">
								<div class="stat-icon dib flat-color-1">
									<i class="pe-7s-users"></i>
								</div>
								<div class="stat-content">
									<div class="text-left dib">
										<div class="stat-text">
											<span class="count" id="patientNumber">5</span>
										</div>
										<div class="stat-heading">患者数量</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>

				<div class="col-lg-3 col-md-6">
					<div class="card">
						<div class="card-body">
							<div class="stat-widget-five">
								<div class="stat-icon dib flat-color-2">
									<i class="pe-7s-users"></i>
								</div>
								<div class="stat-content">
									<div class="text-left dib">
										<div class="stat-text">
											<span class="count" id="sszx"></span>
										</div>
										<div class="stat-heading">实时在线</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>

				<div class="col-lg-3 col-md-6">
					<div class="card">
						<div class="card-body">
							<div class="stat-widget-five">
								<div class="stat-icon dib flat-color-3">
									<i class="pe-7s-users"></i>
								</div>
								<div class="stat-content">
									<div class="text-left dib">
										<div class="stat-text">
											<span id="highRisk"></span>
										</div>
										<div class="stat-heading">高危患者</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>

				<!-- <div class="col-lg-3 col-md-6">
                        <div class="card">
                            <div class="card-body">
                                <div class="stat-widget-five">
                                    <div class="stat-icon dib flat-color-4">
                                        <i class="pe-7s-users"></i>
                                    </div>
                                    <div class="stat-content">
                                        <div class="text-left dib">
                                            <div class="stat-text"><span class="count">6</span></div>
                                            <div class="stat-heading">Clients</div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div> -->
			</div>
			<!-- /Widgets -->
			<!--  Traffic  -->
			<div class="row">
				<div class="col-lg-12">
					<div class="card">
						<div class="card-body">
							<h4 class="box-title">七日内发病次数对比</h4>
						</div>
						<div class="row">
							<div class="col-lg-8">
								<div class="card-body">
									<!--  <canvas id="TrafficChart"></canvas> -->
									<div id="main" class="traffic-chart" style="width:1200px;"></div>
								</div>
							</div>

						</div>
						<!-- /.row -->

					</div>
				</div>
				<!-- /# column -->
			</div>
			<!--  /Traffic -->
			<div class="clearfix"></div>
			<!-- Orders -->
			<div class="orders">
				<div class="row">
					<div class="col-xl-8">
						<div class="card" style="width:1250px;">
							<div class="card-body">
								<h4 class="box-title">患者信息</h4>
							</div>
							<div class="card-body--">
								<div class="table-stats order-table ov-h">
									<table class="table " id="tbody">
										<!-- <thead> -->
										<tr>
											<th class="serial">#</th>
											<th class="avatar">姓名</th>
											<th>年龄</th>
											<th id="last">上次发病时间</th>
											<th >当前状态</th>
											<th style="padding-right:70px;">操作</th>
										</tr>
										<!-- </thead>
										<tbody >
											

										</tbody> -->
									</table>
								</div>
								<!-- /.table-stats -->
							</div>
						</div>
						<!-- /.card -->
					</div>
					<!-- /.col-lg-8 -->

					<!-- /.col-md-4 -->
				</div>
			</div>
			<!-- /.orders -->

		</div>
		<!-- /#right-panel -->

		<script src="../assets3/js/vendor/jquery-2.1.4.min.js"></script>
		<!-- <script src="../assets3/js/popper.min.js"></script>
		<script src="../assets3/js/plugins.js"></script>
		<script src="../assets3/js/main.js"></script>
		<script src="../assets3/js/lib/chart-js/Chart.bundle.js"></script>
		<script src="../assets3/js/Chart.bundle.js"></script>

		<script src="../assets3/js/lib/chartist/chartist.min.js"></script>
		<script src="../assets3/js/lib/chartist/chartist-plugin-legend.js"></script>
		<script src="../assets3/js/lib/flot-chart/jquery.flot.js"></script>
		<script src="../assets3/js/lib/flot-chart/jquery.flot.pie.js"></script>
		<script src="../assets3/js/lib/flot-chart/jquery.flot.spline.js"></script>
		<script src="../assets3/weather/js/jquery.simpleWeather.min.js"></script>
		<script src="../assets3/weather/js/weather-init.js"></script>
		<script src="../assets3/js/lib/moment/moment.js"></script>
		<script src="../assets3/js/moment/moment.js"></script>
		<script src="../assets3/calendar/fullcalendar.min.js"></script>
		<script src="../assets3/calendar/fullcalendar-init.js"></script>
		<script src="../assets3/js/init/weather-init.js"></script> -->

		<!-- <script src="https://cdn.jsdelivr.net/npm/moment@2.22.2/moment.min.js"></script>
		<script
			src="https://cdn.jsdelivr.net/npm/fullcalendar@3.9.0/dist/fullcalendar.min.js"></script>
		<script src="../assets3/js/init/fullcalendar-init.js"></script> -->
		<script src="echarts.min.js"></script>
		<!--Local Stuff-->
		<script type="text/javascript">
			//获取七日时间内容
			function getDate(aa){
				var currentDate = new Date();
				var date = new Date(currentDate);
				date.setDate(currentDate.getDate() + aa);
				var time = (date.getMonth()+1) +"/"+ date.getDate();
				return time;
			}
		
			var uid = [];//存放所有患者编号，用于操作实时动态变化
			
			//页面初始化
			$(document).ready(function() {
				var myChart;
				myChart = echarts.init(document.getElementById('main'));
				
				
				var ldata = [];//用于存放样例名
				var xdata = [];//用于存放X轴内容
				var ydata = [];//用于存放Y轴内容
				
				for(var index = -7; index < 0; index++){
					xdata.push(getDate(index));
				}
				
				$.ajax({
					url : "findLastSevenDaysExNumsByDid",
					type : "POST",
					data : {
						'did' : <%=user.getUid()%>
					},
					dataType : "JSON",
					success : function(data) {
						//显示患者数量
						document.getElementById('patientNumber').innerHTML = "";
						document.getElementById('patientNumber').innerHTML = document.getElementById('patientNumber').innerHTML + data.length + "<br>";
						var count = -1;//统计七日内发病次数最多
						var highRisk = "";//高危患者名字
						for(var i = 0; i < data.length; i++){
							var obj = data[i];
							//显示患者信息
							addRecord(obj, i);
							uid.push(obj.id);
							ldata.push(obj.name);
							var d = [];//用于存放series中的data
							var sum = 0;
							for(var j = 0; j < obj.cycle.length; j++){
								d.push(obj.cycle[j]);
								sum += obj.cycle[j];
							}
							if(sum > count){
								count = sum;
								highRisk = obj.name;
							}else if(sum == count){
								highRisk = highRisk + " " + obj.name;
							}
							
							ydata.push({name : obj.name,
										type : 'bar',
										data : d,});
						}
						//显示高危患者名字
						document.getElementById('highRisk').innerHTML = "";
						document.getElementById('highRisk').innerHTML = document.getElementById('highRisk').innerHTML + highRisk + "<br>";
						//定义图标options
						var option = {
							tooltip : {
								trigger : 'axis',
								axisPointer : { // 坐标轴指示器，坐标轴触发有效
									type : 'shadow' // 默认为直线，可选为：'line' | 'shadow'
								}
							},
							legend : {
								data : ldata
							},
							grid : {
								left : '3%',
								right : '4%',
								bottom : '3%',
								containLabel : true
							},
							xAxis : [
								{
									type : 'category',
									data : xdata
								}
							],
							yAxis : [
								{
									type : 'value'
								}
							],
							series : ydata
						};
						myChart.setOption(option);//先把可选项注入myChart中 
					},
					error : function(data) {
						alert("请求失败，请重试");
						//alert(JSON.stringfy(data));
						layer.alert('请求失败，请刷新重试！',{
						icon:1,
						yes:function(){
							window.location.reload();
						}
						});
					}
				});
			});
		
			function show(data) {
				document.getElementById('sszx').innerHTML = "";
				document.getElementById('sszx').innerHTML = document.getElementById('sszx').innerHTML + data.number + "<br>";
				for(var index in uid){
					document.getElementById("patient_" + uid[index]).innerHTML = "";
					document.getElementById("patient_" + uid[index]).innerHTML = document.getElementById("patient_" + uid[index]).innerHTML + "离线";
				}
				
				var patients = data.patients;
				for(var p_no in patients){
					document.getElementById("patient_" + p_no).innerHTML = "";
					//document.getElementById("patient_" + p_no).innerHTML = document.getElementById("patient_" + p_no).innerHTML + patients[p_no].status;
					if(patients[p_no].status==0){
						document.getElementById('patient_'+ p_no).innerHTML = "<h6 style='color:#00E3E3;'>间歇</h6>";
					}else {
						document.getElementById('patient_'+ p_no).innerHTML = "<h6 style='color:red;'>发病</h6>";
					}
				} 
				
			}
			
			function addRecord(obj, i){
				var html = "";
				html += "<tr>";
				html += "<td class=\"serial\">" + (i+1) + "</td>";
				html += "<td class=\"avatar\">" + obj.name + "</td>";
				html += "<td>" + obj.age + "</td>";
				var last = obj.last;
				if(last == undefined){
					html += "<td>" + "暂无记录" + "</td>";
				}else {
					html += "<td>" + last + "</td>";
				} 
				html += "<td id=\"patient_" + obj.id + "\" ><h6 style=\"color:	#C0C0C0;\">离线<h6></td>";
				html += "<td style=\"padding-right:40px;\"><a href=\"data_listen.jsp?pid="+obj.id+"\">查看患者详情</a>";
				html += "</td>";
				html +=	"</tr>";
				$("#tbody").append(html);
			}
			 function getDateStr(seconds) {
				var date = new Date(seconds)
				var year = date.getFullYear();
				var month = date.getMonth() + 1;
				var day = date.getDate();
				var hour = date.getHours() < 10 ? "0" + date.getHours() : date.getHours();
				var minute = date.getMinutes() < 10 ? "0" + date.getMinutes() : date.getMinutes();
				var second = date.getSeconds() < 10 ? "0" + date.getSeconds() : date.getSeconds();
				var currentTime = year + "-" + month + "-" + day + "  " + hour + ":" + minute + ":" + second;
				return currentTime
			} 
			var websocket = null;
			//判断当前浏览器是否支持WebSocket
			if ('WebSocket' in window) {
				//利用username判断websocket连接对象
				websocket = new WebSocket("ws://[2001:da8:270:2019::e8]:8080/OnlineMedical/ws/dreal?uid=<%=user.getUid()%>");
				//websocket = new WebSocket("ws://localhost:8080/OnlineMedical/ws/dreal?uid=<%=user.getUid()%>");
				//websocket = new WebSocket("ws://10.150.170.228:8080/OnlineMedical/ws/dreal?uid=<%=user.getUid()%>");
			} else {
				alert('浏览器不支持WebSocket');
			}
		
			//连接发生错误的回调方法
			websocket.onerror = function() {
				alert("WebSocket连接失败，请刷新页面重试");
			};
		
			//连接成功建立的回调方法
			websocket.onopen = function() {
				//setMessageInnerHTML("WebSocket连接成功");
				send();
			}
		
			//接收到消息的回调方法
			websocket.onmessage = function(event) {
				var JSONData = JSON.parse(event.data);
				show(JSONData);
				//alert(JSONData);
			}
		
			//连接关闭的回调方法
			websocket.onclose = function() {
				//setMessageInnerHTML("训练结束");
			}
		
			//监听窗口关闭事件，当窗口关闭时，主动去关闭websocket连接，防止连接还没断开就关闭窗口，server端会抛异常。
			window.onbeforeunload = function() {
				closeWebSocket();
			}
		
			//关闭WebSocket连接
			function closeWebSocket() {
				websocket.close();
			}
		
			//发送消息
			function send() {
				var message = "start";
				websocket.send(message);
			}
			
		</script>
</body>
</html>