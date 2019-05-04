<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.cn.POJO.User"%>
<%@ page import="com.opensymphony.xwork2.ActionContext"%>
<%@page import="com.cn.POJO.Patient"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	User user = (User) ActionContext.getContext().getSession().get("loginUser");
%>
<!DOCTYPE HTML>
<html>

<title>新文章</title>
<meta charset="utf-8">
<meta name="description" content="website description" />
<meta name="keywords" content="website keywords, website keywords" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link rel="stylesheet" type="text/css"
	href="http://fonts.googleapis.com/css?family=Tangerine&amp;v1" />
<link rel="stylesheet" type="text/css"
	href="http://fonts.googleapis.com/css?family=Yanone+Kaffeesatz" />
<link rel="stylesheet" type="text/css" href="../gystyle/style/style.css" />
<link rel="stylesheet" href="../gystyle/buttons.css">
<link rel="stylesheet" type="text/css" href="../css/layer.css" />
<!-- <script type="text/javascript"
	src="https://cdn.bootcss.com/jquery/3.3.1/jquery.min.js"></script> -->
<script type="text/javascript"
	src="<%= path %>/gyscripts/jquery/jquery-1.7.1.js"></script>
<script type="text/javascript" src="../js/layer.js"></script>
<script type="text/javascript">
	$(document).ready(function() {
		//var userName="sss";
		//document.getElementById('div2').innerHTML=" 本文很长，记录了我博客建站初到现在的过程，还有我从毕业到现在的一个状态，感谢您的阅读，如果你还是学生，也许你能从此文中，找到我们曾经相似的地方。如果你已经工作，有自己的博客，我想，你并没有忘记当初建立个人博客的初衷吧！我的个人博客已经建站有8年的时间了，对它的热爱，一直都是只增未减。回想大学读书的那几年，那会儿非常流行QQ空间，我们寝室的室友还经常邀约去学校的网吧做自己的空间。系里有个男生，空间做得非常漂亮，什么悬浮，开场动画，音乐播放器，我们女生羡慕得不得了。还邀约他跟我们一起去通宵弄空间，网上可以找到很多免费的flash资源，还有音乐，那也是第一次接触js，知道在浏览器输入一个地址，修改一下数据，就能调用一些背景出来。然后把自己QQ空间弄得漂漂亮亮的，经常邀约室友来互踩。我记得08年地震，第二天晚上，我们寝室的几个人还淡定的在寝室装扮空间呢！";
	});

</script>
<style type="text/css">
.toolbar {
	border: 1px solid #ccc;
	height: 30px;
}

.text {
	border: 1px solid #ccc;
	height: 400px;
}
</style>
</head>

<body>
	<div id="main">
		<div id="header">
			<div id="logo">
				<h1>
					写文章</a>
				</h1>
				<div class="slogan">Share with others!</div>
			</div>
		</div>
		<div id="site_content">
			<div style="margin:20px">
				类别：<select id="lb"
					style="height:32px;width:100px;border: 1px #eee solid; border-radius:5px;text-align:center;text-align-last: center;">
					<option value="">--请选择--</option>
					<option value="0">病情解答</option>
					<option value="1">知识共享</option>
				</select> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;标题：<input id="biaoti" type="text"
					placeholder="请输入标题：" maxlength="100"
					style="width:360px;height:30px; border:1px solid #eee;border-radius:4px;font: 100% 'trebuchet ms', arial;padding-left:5px;">
			</div>

			<div style="margin:20px">正文：</div>

		   <script src="<%=path%>/assets/js/wangEditor.min.js"></script>
			<!-- <script src="https://cdn.bootcss.com/jquery/3.2.1/jquery.min.js"></script> -->
			<div style="margin:20px">
				<div id="div1" class="toolbar"></div>
				<div id="div2" class="text"><p>请输入内容</p></div>
			</div>
			<div style="text-align: center;">
				<button type="button" onclick="subm()"
					class="button button-glow button-border button-rounded button-primary">提交</button>
			</div>
			<textarea id="content" style="width:100%; height:200px;display:none"></textarea>


			<script type="text/javascript">
				var E = window.wangEditor;
				var editor = new E('#div1', '#div2');
				editor.customConfig.menus = [
					'head', // 标题
					'bold', // 粗体
					'fontSize', // 字号
					'fontName', // 字体
					'italic', // 斜体
					'underline', // 下划线
					'strikeThrough', // 删除线
					'foreColor', // 文字颜色
					'backColor', // 背景颜色
					'list', // 列表
					'justify', // 对齐方式
					'quote', // 引用
					'emoticon', // 表情
					'image', // 插入图片
					'table', // 表格
					'code', // 插入代码
					'undo', // 撤销
					'redo' // 重复
				];
			
				// 隐藏“网络图片”tab
				editor.customConfig.showLinkImg = false;
				//editor.customConfig.uploadImgShowBase64 = true;   // 使用 base64 保存图片
				editor.customConfig.uploadImgServer = 'uploadImage'; // 上传图片到服务器
				editor.customConfig.uploadFileName = 'upImg';
				editor.customConfig.uploadImgHooks = {
					customInsert : function(insertImg, result, editor) {
						var url = result.data;
						//alert(url);
						insertImg(url);
					}
				};
				editor.customConfig.onchange = function(html) {
					//监控变化，同步更新到textarea
					document.getElementById("content").value = html;
				}
				//editor.$textElem.attr('contenteditable', false);//禁用编辑器可以显示内容
				editor.create();
				//初始化textarea的值
				document.getElementById("content").value = editor.txt.html();
				//alert(editor.txt.html());
			</script>

			<script type="text/javascript">
				function subm() {
					document.getElementById("content").value = editor.txt.html();
					/* alert(document.getElementById("content").value);
					alert(document.getElementById("biaoti").value);
					alert(document.getElementById("lb").value); */
					$.ajax({
						url : "saveArticle",
						type : "POST",
						data : {
							"uid" : '<%=user.getUid()%>',
							"title" : document.getElementById("biaoti").value,
							"categ" : document.getElementById("lb").value,
							"content" : document.getElementById("content").value
						},
						dataType : "text",
						//async : false,
						success : function(data) {
							layer.alert('文章提交成功！', {
								icon : 1,
								yes : function() {
									window.location.href = "NewDPCommunity.jsp";
								}
							});
							//alert("文章提交成功");
			
						},
						error : function(data) {
							alert("请求失败，请重试");
							window.location.reload();
						}
					});
				}
			</script>

		</div>
	</div>
</body>
</html>
