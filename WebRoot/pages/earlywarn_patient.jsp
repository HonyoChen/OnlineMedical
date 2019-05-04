<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="com.cn.POJO.User"%>
<%@ page import="com.opensymphony.xwork2.ActionContext"%>

<taglib prefix="s" uri="/struts-tags"> <%
 	String path = request.getContextPath();
 	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
 			+ path + "/";
 	User user = (User) ActionContext.getContext().getSession().get("loginUser");
 	
 	String name = "";
 	if(user.getRole() == 0){
 		name = "您";
 	}else{
 		name = "患者";
 	}
 %> <!DOCTYPE html>
<html>
<head>
<title>训练模型</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="renderer" content="webkit|ie-comp|ie-stand">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<meta name="viewport"
	content="width=device-width,initial-scale=1,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no" />
<meta http-equiv="Cache-Control" content="no-siteapp" />
<link rel="icon" type="image/png" sizes="16x16"
	href="../assets2/images/favicon.png">
<title>Material Pro Admin Template - The Most Complete & Trusted
	Bootstrap 4 Admin Template</title>
<!-- Bootstrap Core CSS -->
<link href="../assets2/plugins/bootstrap/css/bootstrap.min.css"
	rel="stylesheet">
<!-- chartist CSS -->
<link href="../assets2/plugins/chartist-js/dist/chartist.min.css"
	rel="stylesheet">
<link href="../assets2/plugins/chartist-js/dist/chartist-init.css"
	rel="stylesheet">
<link
	href="../assets2/plugins/chartist-plugin-tooltip-master/dist/chartist-plugin-tooltip.css"
	rel="stylesheet">
<!--This page css - Morris CSS -->
<link href="../assets2/plugins/c3-master/c3.min.css" rel="stylesheet">
<!-- Custom CSS -->
<link href="../css/style3.css" rel="stylesheet">
<!-- You can change the theme colors from here -->
<link href="../css/blue.css" id="theme" rel="stylesheet">
<link rel="icon" type="image/png" href="../dist/i/favicon.png">
<link rel="apple-touch-icon-precomposed"
	href="../dist/i/app-icon72x72@2x.png">
<meta name="apple-mobile-web-app-title" content="demo" />
<link rel="stylesheet" href="../dist/amazeui.min.css" />
<link rel="stylesheet" href="../css/demo2.css" />
<link rel="stylesheet" type="text/css"
	href="../js/lib/Hui-iconfont/1.0.8/iconfont.css" />
<link rel="stylesheet" type="text/css" href="../css/H-ui.min.css" />
<link href="<%=path%>/gystyle/authority/common_style.css" />
</head>


<!--<h1>实时数据显示页面</h1><br> -->
<body class="fix-header fix-sidebar card-no-border">
	<div id="main-wrapper">

		<!-- <div class="page-wrapper">  -->
		<div class="container-fluid">
			<div class="row page-titles"
				style="width: 1280px;height:60px;border-color: #ddd;background-color: #f5f5f5; text-align:center;">
				<div class="col-md-5 col-8 align-self-center">
					<!-- <strong style="margin-left:370px;position:relative;text-align:center;">实时数据体征图</strong> -->
					<img src="../images/logo.png" alt="Logo"
						style="margin-left:-320px;"> 
				</div>

			</div>
			<div class="row">
				<!-- Column -->
				<div class="col-lg-8 col-md-7">
					<div class="card">
						<div class="card-block">
							<div class="row">
								<div class="col-12">
									<div class="d-flex flex-wrap" id="main" style="height:400px; ">
										<!-- <p>
                                                <h3 class="card-title" style="margin-left:40px;margin-top:-2px;">实时图</h3>
                                            </p> 
                                             -->
									</div>
								</div>

							</div>
						</div>
					</div>
				</div>

				<div class="col-lg-4 col-md-5">
					<div class="card">
						<div class="card-block" style="height:185px;">
							<h3 class="card-title" style="padding-top:2px;"><%=name %>当前的发病状态为:
							</h3>
							<!-- <h6 class="card-subtitle"></h6> -->
							<div id="visitor" style="height:290px; width:100%;"></div>
						</div>
						<!-- <div>
                                <hr class="m-t-0 m-b-0">
                            </div> -->
						<div class="card-block text-center " id="message"
							style="height:245px;text-align:center;">
							<ul class="list-inline m-b-0">

								<li>
									<h1 class="  text-primary">
										<i class="fa fa-circle font-10 m-r-10"></i>离线
									</h1>
								</li>
								<!-- <li>
                                        <h1 class="  text-success" ><i class="fa fa-circle font-10 m-r-10"></i>不发病</h1> </li> -->
							</ul>
						</div>
					</div>
				</div>
			</div>

			<% 
       		if(user.getRole() == 0){
       %>
			


				<center>
					<a href="demo.html">查看统计报告</a>
				</center>
				<% 
       		}
       %>
			</div>

			<script src="http://echarts.baidu.com/build/dist/echarts.js"></script>
			<script type="text/javascript" src="../js/jquery.min.js"></script>

			<!-- Bootstrap tether Core JavaScript -->
			<script src="../assets2/plugins/bootstrap/js/tether.min.js"></script>
			<script src="../js/bootstrap.min.js"></script>
			<!-- slimscrollbar scrollbar JavaScript -->
			<script src="../js/jquery.slimscroll.js"></script>
			<!--Wave Effects -->
			<script src="../js/waves.js"></script>
			<!--Menu sidebar -->
			<script src="../js/sidebarmenu.js"></script>
			<!--stickey kit -->
			<script
				src="../assets2/plugins/sticky-kit-master/dist/sticky-kit.min.js"></script>
			<!--Custom JavaScript -->
			<script src="../js/custom.min.js"></script>
			<!-- ============================================================== -->
			<!-- This page plugins -->
			<!-- ============================================================== -->
			<!-- chartist chart -->
			<script src="../assets2/plugins/chartist-js/dist/chartist.min.js"></script>
			<script
				src="../assets2/plugins/chartist-plugin-tooltip-master/dist/chartist-plugin-tooltip.min.js"></script>
			<!--c3 JavaScript -->
			<script src="../assets2/plugins/d3/d3.min.js"></script>
			<script src="../assets2/plugins/c3-master/c3.min.js"></script>
			<!-- Chart JS -->
			<script src="../js/dashboard1.js"></script>
			<iframe src="../pages/demo.html" width="100%" height="800px" >
				<a href="../pages/demo.html">你的浏览器不支持iframe页面嵌套，请点击这里访问页面内容。</a>
			</iframe>
			<script type="text/javascript">
			
		/* 实现队列数据结构 */
		function Queue(size) {
			var list = [];
	
			//向队列中添加数据
			this.push = function(data) {
				if (data == null) {
					return false;
				}
				//如果传递了size参数就设置了队列的大小
				if (size != null && !isNaN(size)) {
					if (list.length == size) {
						this.pop();
					}
				}
				list.unshift(data);
				return true;
			}
	
			//从队列中取出数据
			this.pop = function() {
				return list.pop();
			}
	
			//返回队列的大小
			this.size = function() {
				return list.length;
			}
	
			//返回队列的内容
			this.queue = function() {
				return list;
			}
	
			//返回指定下标内容
			this.get = function(index) {
				return list[index];
			}
		}
		
		var websocket = null;
		var queue = new Queue(178 * 2); //用于存放两秒的ECG数据
	
		//判断当前浏览器是否支持WebSocket
		if ('WebSocket' in window) {
			//websocket = new WebSocket("ws://[2001:da8:4001:3:4592:c81b:556:c27c]:8080/OnlineMedical/ws/listen?uid=<%= user.getUid() %>");
			websocket = new WebSocket("ws://localhost:8080/OnlineMedical/ws/listen?uid=<%= user.getUid() %>");
			//websocket = new WebSocket("ws://10.150.170.228:8080/OnlineMedical/ws/listen?uid=<%= user.getUid() %>");
		} else {
			alert('浏览器不支持WebSocket');
		}
	
		//连接发生错误的回调方法
		websocket.onerror = function() {
			alert("WebSocket连接失败，请刷新页面重试");
		};
	
		//连接成功建立的回调方法
		websocket.onopen = function() {
			getRecord(<%= user.getUid() %>);
		}
	
		//接收到消息的回调方法
		websocket.onmessage = function(event) {
			var jsonData = JSON.parse(event.data);
			if(jsonData.flush == true){
				getRecord(<%= user.getUid() %>);
			}
			var data = []; //echarts显示数据内容存放数组
			var oneSecondECGData;
			/* for(var i=0;i<jsonData.length;i++)
			{ */
			oneSecondECGData = jsonData.ecgs;
			var status = jsonData.status;//获取当前发病状态。0-不发病；1-发病
			if(status == 0){
				document.getElementById('message').innerHTML = "<h1 style='color:#00E3E3;font-size:54px;padding-bottom:100px;'>间歇</h1>";
			}else{
				document.getElementById('message').innerHTML = "<h1 style='color:red;font-size:54px;padding-bottom:100px;'>发病</h1>";
			} 
			for (var i = 0; i < oneSecondECGData.length; i++) {
				queue.push(oneSecondECGData[i]);
			}
			
			//data = queue;
			if(queue.size() < 179){
				for(var i = 0; i <= 178; i++){
					data.push(0);
				}
			}
			//倒序取，保证ECG数据能够从右向左显示
			for (var i = queue.size()-1; i >= 0; i--) {
				data.push(queue.get(i));
			}
			//}
	
			require.config({
				paths : {
					echarts : 'http://echarts.baidu.com/build/dist'
				}
			});
			// 使用
			require(
				[
					'echarts',
					'echarts/chart/line' ,
				/* 'echarts/chart/bar' // 使用柱状图就加载bar模块，按需加载 */
				],
				function(ec) {
					// 基于准备好的dom，初始化echarts图表
					var myChart = ec.init(document.getElementById('main'));
					var option = {
						title : {
							text : '',
						/*  subtext: '纯属测试' */
						},
						tooltip : {
							trigger : 'axis'
						},
						legend : {
							data : [ 'ECG' ]
						},
						toolbox : { //工具栏
							show : true,
							feature : {
								 /* mark : {
									show : true
								}, */
								dataView : {
									show : true,
									readOnly : false
								},
								/* magicType : {
									show : true,
									type : [ 'line' ]
								},
 							restore : {
									show : true
								}, */
								saveAsImage : {
									show : true
								}
							}
						},	
						dataZoom : {
							show : false,
							start : 0,
							end : 100
						},
						xAxis : [
							{
								axisLine: {onZero: false},
								type : 'category',
								inverse : true, //此属性控制方向,默认为false,改为true就从右往左显示
								boundaryGap : true,
								data : (function() {
									var now = new Date();
									var res = [];
									var len = 2;
									while (len--) {
										res.unshift(now.toLocaleTimeString().replace(/^\D*/, ''));
										now = new Date(now - 3000);
									}
									return res;
								})()
							},
							{
								axisLine: {onZero: false},
								type : 'category',
								inverse : true,
								boundaryGap : true,
								data : (function() {
									var res = [];
									var len = 356;
									while (len--) {
										res.push(len + 10);
									}
									return res.reverse();
								})()
							}
						],
						yAxis : [
							{
								position:"right",
								type : 'value',
							},
							{
								type : 'value',
							}
						],
						series : [
							{
								name : 'ECG',
								type : 'line',
								xAxisIndex : 1,
								yAxisIndex : 1,
								data : data
							},
						]
					};
					//getChartData();
					myChart.setOption(option);
					var timeTicket;
					clearInterval(timeTicket);
					timeTicket = setInterval(function() {
						// 动态数据接口 addData
						 /*myChart.addData([
							[
								0, // 系列索引
								{
									value : (Math.round(Math.random() * (1800 - (-1800))) + (-1800)), // 新增数据
								},
								true, // 新增数据是否从队列头部插入
								false // 是否增加队列长度，false则自定删除原有数据，队头插入删队尾，队尾插入删队头
							],
						]); */
					}, 2100);
	
				}
			);
	
		}
	
		//连接关闭的回调方法
		websocket.onclose = function() {
			//setMessageInnerHTML("训练结束");
		}
	
		//监听窗口关闭事件，当窗口关闭时，主动去关闭websocket连接，防止连接还没断开就关闭窗口，server端会抛异常。
		window.onbeforeunload = function() {
			closeWebSocket();
		}
	
		//将消息显示在网页上
		function setMessageInnerHTML(innerHTML) {
			document.getElementById('message').innerHTML += innerHTML + '<br/>';
		}
	
		//关闭WebSocket连接
		function closeWebSocket() {
			websocket.close();
		}

		

	</script>
</body>
</html>