<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html>
  <head>
  	<title>网盘主页</title>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="stylesheet" href="../gystyle/buttons.css">
	<link type="text/css" rel="stylesheet" href="../css/bootstrap.css">
 	<script src="../js/jquery.min.js"></script>
  </head>
 <style>
 a{ text-decoration:none} 
 .head{
	height: 80px;
    background: #eff4f8;
    position: relative;
 }
 .head-logo{
    float: left;
    padding: 20px 16px 0 20px;
 }
.yp-content{
	 border:1px solid #cceff5;
	 background:#fafcfd;
	 height:670px;
	 position: relative; 
} 
.location{
	position: relative; 
    height: 70px;
    width:100%;
}
.yp-location{
	float: left;
	width:300px;
	padding-top:25px;
	padding-bottom:15px;
	padding-left:20px;
	
}
.upload-button{
	float: right;
	padding-top:15px;
	padding-bottom:5px;
	padding-right:20px;
}

hr{
	margin-top: 20px;
    margin-bottom: 20px;
    border: 0;
    border-top: 1px solid #a09393;
    width:95%;
}

.foot{
	height: 65px;
}
.alldom{
	height:235px;
}
.alldom ul li {
    overflow: hidden;
    width: 100px;
    height: 115px;
    float: left;
    margin-left: 55px;
    border: 1px solid #fff;
    position: relative;
    transition: all 0.2s ease-in 0.1s;
    white-space: nowrap;
    text-overflow: ellipsis;
}
.alldom ul li:hover {
    background-color: #eff4f8;
    border: 1px solid #cceff5;
}
.folder {
    background: url(gyimages/wjj.png) center top no-repeat;
}
.folderdata {
    background: url(gyimages/data.png) center top no-repeat;
}
.foldervideo {
    background: url(gyimages/video.png) center top no-repeat;
}
.folderphoto {
    background: url(gyimages/photo.png) center top no-repeat;
}
.folderpriv {
    background: url(gyimages/wjj2.png) center top no-repeat;
}
.folderpub {
    background: url(gyimages/wjj1.png) center top no-repeat;
}
.folderreb {
    background: url(gyimages/reb.png) center top no-repeat;
}
.changename {
    position: absolute;
    border-radius: 0px;
    left: -25px;
    bottom: 10px;
    overflow: hidden;
    width: 98px;
    height: 20px;
    color: #595c5f;
    line-height: 20px;
    text-align: center;
    font-size: 12px;
    z-index: 0;
    border: 0;
    border-radius: 8px;
    transition: all 0.2s ease-in 0.1s;
    margin-left: 25px;
    background: none;
}
</style>

<script>
	$(document).ready(function() {
		//解析传参
		var name, value;//参数名和值
		var url = decodeURI(window.location.href);
		var index = url.indexOf('?');
		var params = url.substr(index+1);
		var parr = params.split('&');
		for(var i=0; i < parr.length; i++){//解析所有参数
			index = parr[i].indexOf('=');
			if(index > 0){
				name = parr[i].substr(0, index);
				value = parr[i].substr(index+1);
				this[name] = value;
			}
		}
		
		if(this['type']==1){
			document.getElementById("position").innerHTML = "当前位置：<a href=\"wp_home.jsp\">数据管理</a> > <a href=\"wp_personal.jsp?type=1\">私密文件</a>";
			document.getElementById("picture").href = "wp_personal_private.jsp?fid=9";
			document.getElementById("video").href = "wp_personal_private.jsp?fid=10";
			document.getElementById("document").href = "wp_personal_private.jsp?fid=11";
			document.getElementById("data").href = "wp_personal_private.jsp?fid=12";
		}else{
			document.getElementById("position").innerHTML = "当前位置：<a href=\"wp_home.jsp\">数据管理</a> > <a href=\"wp_personal.jsp?type=2\">共享文件</a>";
			document.getElementById("picture").href = "wp_personal_public.jsp?fid=2";
			document.getElementById("picture_text").value = "共享图片";
			document.getElementById("video").href = "wp_personal_public.jsp?fid=3";
			document.getElementById("video_text").value = "共享影音";
			document.getElementById("document").href = "wp_personal_public.jsp?fid=4";
			document.getElementById("docu_text").value = "共享文档";
			document.getElementById("data").href = "wp_personal_public.jsp?fid=5";
			document.getElementById("data_text").value = "共享数据";
		}
	});
</script>

<body>
<!--  头部 -->
 	<div class="head">
 		<div class="head-logo">
 			<a href="#" title="star health"><img src="../images/logo.png"></a>
 		</div>
 	</div>

<!-- 显示的部分 -->	
 	<div class="yp-content">
<!-- 当前位置和上传 -->
 		<div class="location">
 			<div class="yp-location" id="position">
 				当前位置：数据管理
 			</div>
 		</div>
<!--  中间显示文件 -->
		<div class="alldom">
			<ul id="divall">
				<a id="picture" href=""><li class="folderphoto" title="图片" index="0">
					<input id="picture_text" type="text" class="changename" value="图片" data-id="1" disabled="disabled" data-last-value="图片">
				</li></a>
				<a id="video" href=""><li class="foldervideo" title="影音" index="0">
					<input id="video_text" type="text" class="changename" value="影音" data-id="3" disabled="disabled" data-last-value="影音">
				</li></a>
				<a id="document" href=""><li class="folder" title="文档" index="0">
					<input id="docu_text" type="text" class="changename" value="文档" data-id="4" disabled="disabled" data-last-value="文档">
				</li></a>
				<a id="data" href=""><li class="folderdata" title="数据" index="0">
					<input id="data_text" type="text" class="changename" value="数据" data-id="5" disabled="disabled" data-last-value="数据">
				</li></a>
			</ul>
		</div>
	</div>
 </body>
</html>
