<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="com.cn.POJO.User"%>
<%@ page import="com.opensymphony.xwork2.ActionContext"%>
<taglib prefix="s" uri="/struts-tags">
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
User user = (User) ActionContext.getContext().getSession().get("loginUser");
%>

<!DOCTYPE HTML>
<html>

<head>
  <title>新文章</title>
  <meta name="description" content="website description" />
  <meta name="keywords" content="website keywords, website keywords" />
  <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
  <link rel="stylesheet" type="text/css" href="http://fonts.googleapis.com/css?family=Tangerine&amp;v1" />
  <link rel="stylesheet" type="text/css" href="http://fonts.googleapis.com/css?family=Yanone+Kaffeesatz" />
  <link rel="stylesheet" type="text/css" href="../gystyle/style/style.css" />
  <link rel="stylesheet" href="../gystyle/buttons.css">
  <link rel="stylesheet" type="text/css" href="../css/layer.css" />
  <script type="text/javascript" src="../js/jquery.min.js"></script>
<script type="text/javascript" src="../js/layer.js"></script>
  <script type="text/javascript" src="<%= path %>/gyscripts/jquery/jquery-1.7.1.js"></script>
	<script type="text/javascript">
		function submit(){
			alert("提交:" + document.getElementById("text1").value);
		}
	</script>
<style type="text/css">
        .toolbar {
            border: 1px solid #ccc;
            height:30px;
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
        <h1>写文章</a></h1>
        <div class="slogan">Share with others!</div>
      </div>
	</div>
    <div id="site_content">
     	<div style="margin:20px">
			类别：<select  id="lb" style="height:32px;width:100px;border: 1px #eee solid; border-radius:5px;text-align:center;text-align-last: center;" >
				<option value="">--请选择--</option>
				<option value="0">病情解答</option>
				<option value="1">知识共享</option>
				</select>
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;标题：<input  id="biaoti" type="text"  placeholder="请输入标题：" maxlength="100" style="width:360px;height:30px; border:1px solid #eee;border-radius:4px;font: 100% 'trebuchet ms', arial;padding-left:5px;">
		</div>

		<div style="margin:20px">正文：</div>
		
		<script src="http://unpkg.com/wangeditor/release/wangEditor.min.js"></script>
    	<script src="https://cdn.bootcss.com/jquery/3.2.1/jquery.min.js"></script>
    	<div style="margin:20px">
    		<div id="div1" class="toolbar"></div>
    		<div id="div2" class="text"> </div>
			<!-- <div id="editor" style="margin:20px;height: 400px;" ></div> -->
    	</div>
    	<div style="text-align: center;"><button type="button" onclick="subm()" class="button button-glow button-border button-rounded button-primary">提交</button></div>
		<textarea id="content" style="width:100%; height:200px;display:none"></textarea>
    	

    <script type="text/javascript">
        var E = window.wangEditor;
        var editor = new E('#div1', '#div2');
        editor.customConfig.menus = [
        	'head',  // 标题
		    'bold',  // 粗体
		    'fontSize',  // 字号
		    'fontName',  // 字体
		    'italic',  // 斜体
		    'underline',  // 下划线
		    'strikeThrough',  // 删除线
		    'foreColor',  // 文字颜色
		    'backColor',  // 背景颜色
		    'list',  // 列表
		    'justify',  // 对齐方式
		    'quote',  // 引用
		    'emoticon',  // 表情
		    'image',  // 插入图片
		    'table',  // 表格
		    'code',  // 插入代码
		    'undo',  // 撤销
		    'redo'  // 重复
        ];
        
        // 隐藏“网络图片”tab
    	editor.customConfig.showLinkImg = false;
        //editor.customConfig.uploadImgShowBase64 = true;   // 使用 base64 保存图片
        editor.customConfig.uploadImgServer = 'uploadImage';  // 上传图片到服务器
        editor.customConfig.uploadFileName = 'upImg';
        editor.customConfig.uploadImgHooks = {
        	customInsert : function (insertImg, result, editor){
        		var url = result.data;
        		alert(url);
        		insertImg(url);
        	}
        };
        editor.customConfig.onchange = function (html){
        	//监控变化，同步更新到textarea
        	document.getElementById("content").value = html;
        }
        //editor.$textElem.attr('contenteditable', false);//禁用编辑器可以显示内容
        editor.create();
        //初始化textarea的值
        //document.getElementById("text1").value = editor.txt.html();
        //alert(editor.txt.html());
    </script>
    
    <script type="text/javascript">
		function subm(){
			document.getElementById("content").value = editor.txt.html();
			/* alert(document.getElementById("content").value);
			alert(document.getElementById("biaoti").value);
			alert(document.getElementById("lb").value); */
			$.ajax({
				url : "saveArticle",
				type : "POST",
				data : {
					"uid" : '<%= user.getUid() %>',
					"title" : document.getElementById("biaoti").value,
					"categ" : document.getElementById("lb").value,
					"content" : document.getElementById("content").value
				},
				dataType : "text",
				//async : false,
				success : function(data) {	
					layer.alert('文章提交成功！',{
					icon:1,
					yes:function(){
					   window.location.href = "dpcommunity.jsp"; 
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
