<%@ page import="com.cn.POJO.User"%>
<%@ page import="com.opensymphony.xwork2.ActionContext"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<taglib prefix="s" uri="/struts-tags"> <%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
User user = (User) ActionContext.getContext().getSession().get("loginUser");
%> <!DOCTYPE html>
<html>
<head>
<title>训练模型</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
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
<link href="<%=path%>/gystyle/authority/common_style.css">
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
<link rel="stylesheet" type="text/css" href="../css/layer.css" />
<script type="text/javascript" src="../js/jquery-1.8.3.min.js"></script>
<script type="text/javascript" src="../js/layer.js"></script>
<script type="text/javascript" src="../js/laypage.js"></script>

</head>
<body>
	<div class="row page-titles"
		style="width: 1280px;height:60px;border-color: #ddd;background-color: #f5f5f5; text-align:center;">
		<div class="col-md-5 col-8 align-self-center">
			<!-- <strong style="margin-left:370px;position:relative;text-align:center;">实时数据体征图</strong> -->
			<img src="../images/logo.png" alt="Logo" style="margin-left:-300px;">
		</div>

	</div>
	<div class="row page-titles"
		style="width: 1280px;height:60px;font-size:18px; margin-top:-25px;text-align:center;">
		<div style="margin-left:280px;">
			隐私预算: &ensp;&ensp;<input type="text" style="width:60px;" id="epsilon"
				value="0.1"> 迭代次数：&ensp;&ensp;<input type="text"
				style="width:60px;" id="iternum" value="200">
			学习率：&ensp;&ensp;<input type="text" style="width:60px;"
				id="learningrate" value="0.0001"> 批量大小：&ensp;&ensp;<input
				type="text" style="width:60px;" id="batchsize" value="20">
			&ensp;&ensp;<a href="javascript:;" onclick="train()"
				class="btn btn-primary radius"><i class="Hui-iconfont">&#xe600;</i>
				点击训练模型</a>
		</div>
	</div>
	<div class="row">
		<div class="col-lg-12">
			<div class="card">
				<div class="card-body">
					&emsp;&emsp;
					<div id="accuu">准确率变化图</div>
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
	<div class="row">
		<div class="col-lg-12">
			<div class="card">
				<div class="card-body">
					&emsp;&emsp;
					<div id="losss">损失值变化图</div>
				</div>
				<div class="row">
					<div class="col-lg-8">
						<div class="card-body">
							<!--  <canvas id="TrafficChart"></canvas> -->
							<div id="main2" class="traffic-chart" style="width:1200px;"></div>
						</div>
					</div>

				</div>
				<!-- /.row -->

			</div>
		</div>
		<!-- /# column -->
	</div>


	<script src="echarts.min.js" charset="utf-8" type="text/javascript"></script>
	<script type="text/javascript">
	
		var myChart = echarts.init(document.getElementById('main')); //准确率变化图
		var myChart2 = echarts.init(document.getElementById('main2')); //损失值变化图
	
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
	
		var queue = new Queue(); //全局存放准确率accu所有数据
		var qiter = []; //全局存放迭代次数
		var qloss = new Queue(); //全局存放损失值loss所有数据
	
	
		var websocket = null;
		//判断当前浏览器是否支持WebSocket
		if ('WebSocket' in window) {
			//利用username判断websocket连接对象
			//websocket = new WebSocket("ws://[]:8080/OnlineMedical/ws/train?uid=<%= user.getUid() %>");
			websocket = new WebSocket("ws://localhost:8080/OnlineMedical/ws/train?uid=<%= user.getUid() %>");
			//websocket = new WebSocket("ws://10.150.170.228:8080/OnlineMedical/ws/train?uid=<%= user.getUid() %>");
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
			var iter_num = [];
			var loss_num = [];
			var accu_num = [];
	
			$.ajax({
				url : 'returnModelResult',
				type : 'POST',
				data : {},
				async : false,
				dataType : 'json',
				success : function(data) {
					/* alert(data[0]['iter'] + "," + data[0]['loss'] + "," + data[0]['accu']);
					alert(data.length);
					var json = eval("("+data+")"); */
					for (var i = 0; i < data.length; i++) {
						iter_num.push(data[i].iter);
						loss_num.push(data[i].loss);
						accu_num.push(data[i].accu);
					}
				},
				error : function(data) {
					layer.alert('获取数据失败!请刷新重试', {
						icon : 2,
						yes : function() {
							window.location.reload();
						}
					});
				},
			});
	
			myChart.hideLoading();
			document.getElementById("accuu").style.display = "none";
	
			var option = {
				title : {
					text : '当前模型的准确率变化图'
				},
				tooltip : {},
				legend : {
					data : [ '准确率' ]
				},
				xAxis : {
					name : '迭代次数',
					data : iter_num
				},
				yAxis : {},
				series : [ {
					name : '准确率',
					type : 'line',
					data : accu_num
				} ]
			};
			myChart.setOption(option);
			//损失值echart
			myChart2.hideLoading();
			document.getElementById("losss").style.display = "none";
			var option2 = {
				title : {
					text : '当前模型的损失值变化图'
				},
				tooltip : {},
				legend : {
					data : [ '损失值' ]
				},
				xAxis : {
					name : '迭代次数',
					data : iter_num
				},
				yAxis : {},
				series : [ {
					name : '损失值',
					type : 'line',
					data : loss_num
				} ]
			};
			myChart2.setOption(option2);
		}
	
		//接收到消息的回调方法
		websocket.onmessage = function(event) {
	
			//setMessageInnerHTML(event.data);
			var result = JSON.parse(event.data);
			var data = []; //echarts显示accu数据
			var edata; //存放当前accu数据
			var diter = []; //echarts显示迭代次数
			diter = qiter;
			var dloss = []; //echarts显示loss数据
			var eloss; //存放当前loss数据
	
			/* for(var i=0;i<result.length;i++)
			{ */
			edata = result.accu;
			eloss = result.loss;
			queue.push(edata);
			qloss.push(eloss);
			for (var j = queue.size() - 1; j >= 0; j--) {
				data.push(queue.get(j));
			}
			for (var k = qloss.size() - 1; k >= 0; k--) {
				dloss.push(qloss.get(k));
			}
			/* } */
	
			//准确率echarts
			myChart.hideLoading();
			document.getElementById("accuu").style.display = "none";
	
			var option = {
				title : {
					text : '训练模型准确率变化图'
				},
				tooltip : {},
				legend : {
					data : [ '准确率' ]
				},
				xAxis : {
					name : '迭代次数',
					data : diter
				},
				yAxis : {},
				series : [ {
					name : '准确率',
					type : 'line',
					data : data
				} ]
			};
			myChart.setOption(option);
			//损失值echart
			myChart2.hideLoading();
			document.getElementById("losss").style.display = "none";
			var option2 = {
				title : {
					text : '训练模型损失值变化图'
				},
				tooltip : {},
				legend : {
					data : [ '损失值' ]
				},
				xAxis : {
					name : '迭代次数',
					data : diter
				},
				yAxis : {},
				series : [ {
					name : '损失值',
					type : 'line',
					data : dloss
				} ]
			};
			myChart2.setOption(option2);
	
			if (data.length == qiter.length) {
				myChart2.on('finished', function() {
					layer.confirm('训练完毕，是否替换当前系统判断模型？', function(index) {
						$.ajax({
							url : 'replaceModelAndResult',
							type : 'POST',
							data : {
								'epsilon' : document.getElementById("epsilon").value,
								'iters' : document.getElementById("iternum").value,
								'rate' : document.getElementById("learningrate").value,
								'size' : document.getElementById("batchsize").value
							},
							dataType : 'text',
							success : function(data) {
								if (data == 1) {
									layer.alert('成功替换模型!', {
										icon : 1,
										yes : function() {
											window.location.reload();
										}
									});
								} else {
									layer.alert('替换模型失败!请刷新重试', {
										icon : 2,
										yes : function() {
											window.location.reload();
										}
									});
								}
							},
							error : function(data) {
								layer.alert('替换模型失败!请刷新重试', {
									icon : 2,
									yes : function() {
										window.location.reload();
									}
								});
							},
						});
					});
	
					//alert("训练完毕，是否替换当前系统判断模型？");
	
				});
			}
	
		}
	
		//连接关闭的回调方法
		/* websocket.onclose = function () {
		    setMessageInnerHTML("训练结束");
		} */
	
		//监听窗口关闭事件，当窗口关闭时，主动去关闭websocket连接，防止连接还没断开就关闭窗口，server端会抛异常。
		window.onbeforeunload = function() {
			closeWebSocket();
		}
	
		//将消息显示在网页上
		/*   function setMessageInnerHTML(innerHTML) {
		      document.getElementById('message').innerHTML += innerHTML + '<br/>';
		  } */
	
		//关闭WebSocket连接
		function closeWebSocket() {
			websocket.close();
		}
	
		//发送消息
		/* function send() {
		    var message = document.getElementById('text').value;
		    websocket.send(message);
		} */
	
		function train() {
			myChart.showLoading({
				text : '正在训练'
			});
			myChart2.showLoading({
				text : '正在训练'
			});
			/* 		document.getElementById("accuu").style.display="none";
					document.getElementById("losss").style.display="none"; */
			var epsilon = document.getElementById("epsilon").value;
			var iternum = document.getElementById("iternum").value;
			var learnrt = document.getElementById("learningrate").value;
			var batchsz = document.getElementById("batchsize").value;
			qiter = transf(iternum);
			websocket.send('TRA:epsilon=' + epsilon + ' iternum=' + iternum + ' learnrt=' + learnrt + ' batchsz=' + batchsz);
		}
		;
		function transf(size) {
			var num = [];
			for (i = 0; i < size; i++) {
				num[i] = i + 1;
			}
			return num;
		}
		;
	</script>

</body>
</html>
