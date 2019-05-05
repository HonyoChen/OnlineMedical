<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="com.cn.POJO.User"%>
<%@ page import="com.opensymphony.xwork2.ActionContext"%>
<taglib prefix="s" uri="/struts-tags"> <%
 	String path = request.getContextPath();
 	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
 			+ path + "/";
 	User user = (User) ActionContext.getContext().getSession().get("loginUser");

 	String name = "";
 	String UUID = "";
 	if (user.getRole() == 0) {
 		name = "您";
 		UUID = user.getUid().toString();
 	} else {
 		name = "患者";
 		UUID = request.getParameter("pid");
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
<title>预警平台</title>
<!-- Bootstrap Core CSS -->
<link href="../assets2/plugins/bootstrap/css/bootstrap.min.css"
	rel="stylesheet">
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
<link href="<%=path%>/gystyle/authority/common_style.css">
<link rel="stylesheet" type="text/css" href="../css/layer.css" />
<script type="text/javascript" src="../js/jquery.min.js"></script>
<script type="text/javascript" src="../js/jquery-1.8.3.min.js"></script> 
<script type="text/javascript" src="../js/layer.js"></script>
<script type="text/javascript" src="../js/laypage.js"></script>	
<script src="http://echarts.baidu.com/build/dist/echarts.js"></script>
<script src="../assets2/plugins/bootstrap/js/tether.min.js"></script>
<script src="../js/bootstrap.min.js"></script>
<script src="../js/jquery.slimscroll.js"></script>
<script src="../js/waves.js"></script>
<script src="../js/sidebarmenu.js"></script>
<script src="../assets2/plugins/sticky-kit-master/dist/sticky-kit.min.js"></script>
<script src="../assets2/plugins/chartist-js/dist/chartist.min.js"></script>
<script	src="../assets2/plugins/chartist-plugin-tooltip-master/dist/chartist-plugin-tooltip.min.js"></script>
<script src="../assets2/plugins/d3/d3.min.js"></script>
<script src="../assets2/plugins/c3-master/c3.min.js"></script>
</head>
<!--<h1>实时数据显示页面</h1><br> -->
<body class="fix-header fix-sidebar card-no-border">
	<div id="main-wrapper">
		<div class="container-fluid">
			<div class="row page-titles"
				style="width: 1280px;height:60px;border-color: #ddd;background-color: #f5f5f5; text-align:center;">
				<div class="col-md-5 col-8 align-self-center">
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
											</div>
								</div>

							</div>
						</div>
					</div>
				</div>

				<div class="col-lg-4 col-md-5">
					<div class="card">
						<div class="card-block" style="height:185px;">
							<h3 class="card-title" style="padding-top:2px;"><%=name%>当前的发病状态为:
							</h3>
							<div id="visitor" style="height:290px; width:100%;"></div>
						</div>
						<div class="card-block text-center " id="message"
							style="height:245px;text-align:center;">
							<ul class="list-inline m-b-0">

								<li>
									<h1 class="  text-primary">
										<i class="fa fa-circle font-10 m-r-10"></i>离线
									</h1>
								</li>
							</ul>
						</div>
					</div>
				</div>
			</div>

			<%
				if (user.getRole() == 0) {
			%>
			<div class="am-g" style="margin-left:-15px;width:1300px;">
				<div class="am-u-md-12">
					<div class="am-panel am-panel-default">
						<div class="am-panel-hd">
							<h4 class="am-panel-title" data-am-collapse="{ target: '#combo'}">
								异常记录</h4>
						</div>
						<div id="combo" class="ui_text_indent"
							style="overflow-y:auto;width:100%;height:300px">
							<table width="auto"
								class="table table-border table-bordered table-hover table-bg table-sort"
								id="table">
								<tr class="text-c">
									<th style="text-align:center;">序号</th>
									<th style="text-align:center;">时间</th>
									<th style="text-align:center;">操作</th>
								</tr>
							</table>
						</div>
					</div>
				</div>


				<%
					}
				%>
				<center>
					<a href="demo.html?pid=<%=UUID%>">查看统计报告</a>
				</center>
			</div>
		</div>
	</div>



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
			//websocket = new WebSocket("ws://[]:8080/OnlineMedical/ws/listen?uid=<%=UUID%>");
			websocket = new WebSocket("ws://localhost:8080/OnlineMedical/ws/listen?uid=<%=UUID%>");
			//websocket = new WebSocket("ws://10.150.170.228:8080/OnlineMedical/ws/listen?uid=<%=UUID%>");
		} else {
			alert('浏览器不支持WebSocket');
		}
	
		//连接发生错误的回调方法
		websocket.onerror = function() {
			alert("WebSocket连接失败，请刷新页面重试");
		};
	
		//连接成功建立的回调方法
		websocket.onopen = function() {
			getRecord(<%=user.getUid()%>);
		}
	
		//接收到消息的回调方法
		websocket.onmessage = function(event) {
			var jsonData = JSON.parse(event.data);
			if(jsonData.flush == true){
				getRecord(<%=user.getUid()%>);
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
	
		//发送消息
		/* function send() {
		    var message = document.getElementById('text').value;
		    websocket.send(message);
		} */
		
		function getRecord(uid){
			$.ajax({
				url : "exrecordsByPid",
				type : "POST",
				data : {
					"pid" : uid
				},
				async: false,
				dataType : "json",
				success : function(result) {
					$("#table").html("<tr class=\"text-c\"><th style=\"text-align:center;\">序号</th><th style=\"text-align:center;\">时间</th><th style=\"text-align:center;\">操作</th></tr>");
					if(result == null){
						var html = "<tr class=\"text-c\"><td colspan='3'>当前尚无异常记录</td><tr>";
						$("#table").append(html);
					}else{
						for(var i = 0; i < result.length; i++){
							var obj = result[i];
							showExrecord(i, obj);
						}
					}
				},
				error : function(result) {
					alert("返回数据失败，请刷新页面");
				}
			});
		}
	 
		function showExrecord(i, obj){
			var time = getDateStr(obj["time"].time);
			var html = "";
			html += "<tr class=\"text-c\">";
			html += "<td >" + (i+1) + "</td>";
			html += "<td >" + time+ "</td>";
			html += "<td class=\"td-manage\" ><a title=\"补充记录\" href=\"addinf.html?obj="+ encodeURI(JSON.stringify(obj)) +"\"><i class=\"Hui-iconfont\">&#xe6df;<span>补充记录</span></i></a>";
			html += "<a title=\"误诊\" href=\"javascript:;\" onclick=\"exrecord_del(this,\'" + obj.id + "\')\" class=\"ml-5\" style=\"text-decoration:none\"><i class=\"Hui-iconfont\">&#xe6e2;<span>误诊</span></i></a></td>";
			html += "</tr>";
			$("#table").append(html);
		}

		function exrecord_del(obj, eid) {	
		layer.confirm('确认要删除吗？', function(index) {
			$.ajax({
				url : 'deleteExrecord',
				type : 'POST',
				data : {
					"eid" : eid
				},
				dataType : 'text',
				success : function(data) {
					layer.alert('删除成功!',{
						icon:1,
						yes:function(){
							window.location.reload();
						}
					});
					//window.location.reload();
				},
				error : function(data) {
					//console.log(data.msg);
				layer.alert('删除失败!请刷新重试',{
						icon:2,
						yes:function(){
							window.location.reload();
						}
					});
				},
			});
		});
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
	 
	</script>


</body>
</html>
