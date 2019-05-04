<%@ page import="com.cn.POJO.User"%>
<%@ page import="com.opensymphony.xwork2.ActionContext"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<taglib prefix="s" uri="/struts-tags"> <%
 	String path = request.getContextPath();
 	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
 			+ path + "/";
 	User user = (User) ActionContext.getContext().getSession().get("loginUser");
 %> <!DOCTYPE html>
<html>
<head>
<title>共享平台</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="../gystyle/buttons.css">
<script type="text/javascript" src="../js/jquery.min.js"></script>
<link type="text/css" rel="stylesheet" href="../css/bootstrap.css">
<link href="../css/font-awesome.min.css" rel="stylesheet">
</head>

<style>
a{ text-decoration:none} 
tr {
	height: 60px;
	font-size: 14px;
}

.table>thead>tr>th, .table>tbody>tr>th, .table>tfoot>tr>th, .table>thead>tr>td,
	.table>tbody>tr>td, .table>tfoot>tr>td {
	padding: 8px;
	line-height: 1.428571429;
	vertical-align: middle;
	border-top: 1px solid #dddddd;
}

.head {
	height: 80px;
	background: #eff4f8;
	position: relative;
}

.head-logo {
	float: left;
	padding: 20px 16px 0 20px;
}

.yp-content {
	border: 1px solid #cceff5;
	background: #fafcfd;
	height: 700px;
	position: relative;
}

.location {
	position: relative;
	height: 70px;
	width: 100%;
}

.yp-location {
	float: left;
	width: 600px;
	padding-top: 25px;
	padding-bottom: 15px;
	padding-left: 20px;
}

.upload-button {
	float: right;
	padding-top: 15px;
	padding-bottom: 5px;
	padding-right: 20px;
}

.list {
	height: 550px;
	/* 	background:#a7c2d0; */
	margin: 20px;
}

.table-hover>tbody>tr:hover>td, .table-hover>tbody>tr:hover>th {
	background-color: #f6faff;
	border-top: 2px solid #daebfe;
	border-bottom: 2px solid #daebfe;
}

.table>thead>tr>th {
	vertical-align: bottom;
	border-bottom: 1px solid #dddddd;
}

.table-hover>thead>tr:hover>th {
	background-color: #f6faff;
}

.fa-folder-open:before {
	content: "\f07c";
	color: #f7bd0d;
}

.fa-music:before {
	content: "\f001";
	color: #8183f1;
}

.fa-file-photo-o:before, .fa-file-picture-o:before, .fa-file-image-o:before
	{
	content: "\f1c5";
	color: #ff7743;
}

.fa-file-movie-o:before, .fa-file-video-o:before {
	content: "\f1c8";
	color: #8183f1;
}

.fa-file-pdf-o:before {
	content: "\f1c1";
	color: #ff5a5a;
}

.fa-database:before {
    content: "\f1c0";
    color: #9ca2b9c9;
}
.fa-file-text-o:before {
	content: "\f0f6";
	color: #4d97ff;
}

.checkbox {
	width: 1.8em;
	height: 1.8em;
	margin-top: 0px;
	margin-bottom: 0px;
}

.checkbox input[type=checkbox] {
	-webkit-appearance: none;
	background-color: transparent;
	outline: 0 !important;
	border: 0;
	font-size: 0.8em !important;
}

.checkbox input[type=checkbox]:before {
	display: inline-block;
	text-align: center;
	font: normal normal normal 14px/1 FontAwesome;
	font-size: 1.8em;
	font-weight: thin;
	text-rendering: auto;
	-webkit-font-smoothing: antialiased;
	-moz-osx-font-smoothing: grayscale;
	color: rgb(212, 212, 212);
}

.checkbox input[type=checkbox]:checked:before {
	color: rgb(61, 141, 255);
}

.checkbox input[type=checkbox]:before {
	content: "\f096";
}

.checkbox input[type=checkbox]:checked:before {
	content: "\f14a";
}

.aa {
	color: #333333;
	text-decoration: none;
}

.aa:hover, .aa:focus {
	color: #3b8cff;
	text-decoration: none;
}

.aa:focus {
	outline: thin dotted;
	outline: 5px auto -webkit-focus-ring-color;
	outline-offset: -2px;
}
</style>

<script type="text/javascript">
	//利用栈实现云盘的多级目录功能
	function ArrayStack(){
		var arr = [];
		//压栈操作
		this.push = function(element){
			arr.push(element);
		}		
		//退栈操作
		this.pop = function(){
			return arr.pop();
		}		
		//获取栈顶元素
		this.top = function(){
			return arr[arr.length-1];
		}		
		//获取栈底元素
		this.bottom = function(){
			return arr[0];
		}
		//获取栈长
		this.size = function(){
			return arr.length;
		}
		
		//清空栈
		this.clear = function(){
			arr = [];
			return true;
		}		
		this.toString = function(){
			return arr.toString();
		}		
		this.popMultiElement = function(element){
			for(var i = arr.length-1; i >= 0; i--){
				var num1 = arr[i].fid;//栈内元素的ID值
				var num2 = element.fid;//导航栏点击对象的ID值
				if(num1 == num2){
					break;
				}
				arr.pop();
			}
			return arr;
		}		
		this.get = function(index){
			return arr[index];
		}
	}
	var stack = new ArrayStack();//多级目录，栈实现
	
	$(function () {
            //除了表头（第一行）以外所有的行添加click事件.
            $("tr").first().nextAll().click(function () {
                //为点击的这一行切换样式bgRed里的代码：background-color:#FF0000;
                $(this).children().toggleClass("bgRed");
                //判断td标记的背景颜色和body的背景颜色是否相同;
                if ($(this).children().css("background-color") != $(document.body).css("background-color")) {
                    //如果相同，CheckBox.checked=true;
                    $(this).children().first().children().attr("checked", true);

                } else {
                    //如果不同,CheckBox.checked=false;
                    $(this).children().first().children().attr("checked", false);
                }
            });
       });
		
		
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
		
		//获取首层目录对象，并压栈
		var folder = searchFileById(this['fid']);//查找当前目录的Cfile信息并压栈
		pushStack(folder);
		uploadtype();
	});
	
	
	//通过ID值查找File对象
	function searchFileById(fid){
		var obj;
		$.ajax({
			url : "fileById",
			type : "POST",
			data : {
				"fid" : fid
			},
			async: false,
			dataType : "json",
			success : function(result) {
				obj = result[0];
			},
			error : function(result) {
				alert("查询目录Cfile信息失败，请重试");
			}
		});
		return obj;
	}
	
	//进入下一层目录，进行压栈处理，并刷新导航栏和文件显示区域
	function pushStack(element){
		stack.push(element);
		navbarView(stack);//显示导航栏
		updateView(stack.top());//显示文件内容
	}
	
	//返回之前层目录，进行出栈处理，并刷新导航栏和文件显示区域
	function popStack(element){
		stack.popMultiElement(element);
		navbarView(stack);
		updateView(stack.top());
	}
	
	//显示导航栏多级目录
	function navbarView(nav){
		document.getElementById("position").innerHTML = "当前位置：<a href=\"wp_home.jsp\">数据管理</a>";
		for(var i = 0; i < nav.size(); i++){
			var obj = nav.get(i);
			var navele = document.getElementById("position").innerHTML;
			document.getElementById("position").innerHTML = navele + " > <a href='javascript:;' onclick='popStack(" + JSON.stringify(obj) + ")'>" + obj.filename +"</a>";
		}
	}
	
	//显示当前目录下文件
	function updateView(){
		document.getElementById("contentView").innerHTML = "";
		$.ajax({
			url : "filesInCurrentFolder",
			type : "POST",
			data : {
				"fid" : stack.top().fid
			},
			async: false,
			dataType : "json",
			success : function(result) {
				for(var i = 0; i < result.length; i++){
					var obj = result[i];
					showFile(obj);
				}
			},
			error : function(result) {
				alert("返回数据失败，请刷新页面");
			}
		});
	}

	//显示返回数据
	function showFile(obj){
		var content = document.getElementById("contentView").innerHTML;
		var html = "";
		html += "<tr>";
		html += "<td width=\"30\" ><li  class=\"checkbox\"><input type=\"checkbox\" name=\"chose\" onclick=\"checkListen()\" value=\""+obj.fid+"\" /></li></td>";
		html += "<td>";
			if(obj.isDirectory == 1){
				html += "<span class=\"fa fa-folder-open fa-2x\" aria-hidden=\"true\" ></span>";
				html += "<span style=\"font-size:14px;\"> &nbsp;&nbsp;" + obj.filename +"</span>";	
			}else{
				html += "<span class=\"fa fa-file-text-o fa-2x\" aria-hidden=\"true\"></span>";
				html += "<span style=\"font-size:14px;\"> &nbsp;&nbsp;" + obj.filename +"</span>";
			}
		html += "<a href='javascript:;' onclick='deleteFileByFid(" + obj.fid +")' title=\"彻底删除\"><i style=\"float:right;padding:8px;\" class=\"fa fa-times\" aria-hidden=\"true\"></i></a>";
		html += "<a href='javascript:;' onclick='inOrOutRecycleBin(" + obj.fid +")' title=\"还原\"><i style=\"float:right;padding:8px;\" class=\"fa fa-random\" aria-hidden=\"true\"></i></a>";
		html += "</td>";
		
		/* html += "<td>"+ obj.doctor.name +"</td>"; */
		var filesize = obj.size;
		if(filesize == null){
			html += "<td></td>";
		}else{
			var fsize = Math.ceil(filesize/1024);
			if(fsize < 1024){
				html += "<td>"+ fsize +" KB</td>";
			}else{
				var ffsize = Math.ceil(fsize/1024);
				html += "<td>"+ ffsize +" MB</td>";
			}
		}
		var ftime = obj.time;
		var index = ftime.indexOf("T");
		var prefix = ftime.substring(0,index);
		var postfix = ftime.substring(index+1);
		var fftime = prefix + " " + postfix ;
		html += "<td>"+ fftime +"</td>";
		document.getElementById("contentView").innerHTML = content + html;
		/* html = content+html;
		$("#contentView").append(html); */
	}
	
	function btnClick() {
		document.getElementById("uploadfile").click();
	}
	
	//复选框样式
	function checkListen(){
		var allCheck = document.getElementsByName("chose");
		var num = 0;
		document.getElementById("res").style.display ="none";
		document.getElementById("del").style.display ="none"; 
		for (var i = 0; i < allCheck.length; i++) {
			if(allCheck[i].checked == true){
				document.getElementById("res").style.display ="";
				document.getElementById("del").style.display ="";
				num++;
				break;
			}else{
				document.getElementById("all").checked = false;
			}
		}
		if(num ==0){
			document.getElementById("res").style.display ="none";
			document.getElementById("del").style.display ="none"; 
		}
	}

	$(function() {
		$("#tthead tr").click(function() {
		    
			//console.log($(this).find(":checkbox").prop("checked"))
			if ($(this).find(":checkbox").prop("checked")) // 此处要用prop不能用attr，至于为什么你测试一下就知道了。
			{ 
				$(this).find(":checkbox").removeAttr("checked");
			 	checkOrCancelAll(); 
			 	document.getElementById("res").style.display ="none";
				document.getElementById("del").style.display ="none";
			} else {
				$(this).find(":checkbox").prop("checked", true);
				checkOrCancelAll(); 
				document.getElementById("res").style.display ="";
				document.getElementById("del").style.display ="";
			}
		});
	 	$("#contentView tr").click(function() {
			//console.log($(this).find(":checkbox").prop("checked"))
			if ($(this).find(":checkbox").prop("checked")) // 此处要用prop不能用attr，至于为什么你测试一下就知道了。
			{	alert(JSON.stringify(this));
				$(this).find(":checkbox").removeAttr("checked");
				 document.getElementById("all").checked = false;
				 checkListen();
			} else {
				$(this).find(":checkbox").prop("checked", true);
				document.getElementById("res").style.display ="";
				document.getElementById("del").style.display =""; 
			}
		}); 

		$("input[type='checkbox']").click(function(e) {
			e.stopPropagation();
		});
		$("a").click(function(e) {
			e.stopPropagation();
		});

	})

	//页面加载的时候,所有的复选框都是未选中的状态
	function checkOrCancelAll() {
		//1.获取checkbo的元素对象
		var chElt = document.getElementById("all");
		//2.获取选中状态
		var checkedElt = chElt.checked;
		//3.若checked=true,将所有的复选框选中,checked=false,将所有的复选框取消
		var allCheck = document.getElementsByName("chose");
		//4.循环遍历取出每一个复选框中的元素
		if (checkedElt) {
			//全选
			for (var i = 0; i < allCheck.length; i++) {
				//设置复选框的选中状态
				allCheck[i].checked = true;

			}
			document.getElementById("res").style.display ="";
			document.getElementById("del").style.display =""; 
			
		} else {
			//取消全选
			for (var i = 0; i < allCheck.length; i++) {
				allCheck[i].checked = false;
			}
			document.getElementById("res").style.display ="none";
			document.getElementById("del").style.display ="none"; 
		}

	}
	
	
	$("tr").click(function(e){
		var check = $(this).find("input[type='checkbox']");
		if(check){
			var flag = check[1].checked;
			if(flag){
				check[1].checked = false;
			}else{
				check[1].checked = true;
			}
		}
	}); 
	$("input[type='checkbox']").click(function(e){
		e.stopPropagation(); 
	});

	
	//图标放入回收站
	function inOrOutRecycleBin(fid){
		$.ajax({
			url : "inOrOutRecycleBin",
			type : "POST",
			data : {
				"parent" : stack.bottom().fid,
				"fid" : fid
			},
			async: false,
			dataType : "text",
			success : function(result) {
				updateView();
			},
			error : function(result) {
				alert("返回数据失败，请刷新页面");
			}
		});
	}
	
	//大标放入回收站
	function batchInOrOutRecycleBin(){
		var check = document.getElementsByName("chose");
		var ids = [];
		for(var k = 1; k < check.length; k++){
			if(check.item(k).checked){
				ids.push(check.item(k).value);
			}
		}
		$.ajax({
			url : "batchInOrOutRecycleBin",
			type : "POST",
			data : {
				"parent" : stack.bottom().fid,
				"fids" : ids.toString()
			},
			async: false,
			dataType : "text",
			success : function(result) {
				updateView();
			},
			error : function(result) {
				alert("失败，请刷新页面");
			}
		});
	}
	
	function deleteFileByFid(fid) {
		$.ajax({
			url : "deleteFileByFid",
			type : "POST",
			data : {
				"fid" : fid
			},
			async : false,
			dataType : "JSON",
			success : function(result) {
				updateView();
			},
			error : function(result) {
				alert("删除失败，请刷新页面");
			}
		});
	}
	
	//batchDeleteFileByFids
	function batchDeleteFileByFids(){
		var check = document.getElementsByName("chose");
		var ids = [];
		for(var k = 1; k < check.length; k++){
			if(check.item(k).checked){
				ids.push(check.item(k).value);
			}
		}
		$.ajax({
			url : "batchDeleteFileByFids",
			type : "POST",
			data : {
				"parent" : stack.bottom().fid,
				"fids" : ids.toString()
			},
			async: false,
			dataType : "text",
			success : function(result) {
				//alert("批量删除成功");
				updateView();
			},
			error : function(result) {
				alert("失败，请刷新页面");
			}
		});
	}
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
				当前位置：<a href="wp_home.jsp">数据管理</a>
			</div>
			<div class="upload-button" id="del" style="display:none">
				<a href="javascript:;" onclick="batchDeleteFileByFids()"
					class="button button-glow button-border button-rounded button-primary"
					style="padding-left:15px;padding-right:15px">删除</a>
			</div> 
			<div class="upload-button" id="res" style="display:none">
				<a href="javascript:;" onclick="batchInOrOutRecycleBin()"
					class="button button-glow button-border button-rounded button-primary"
					style="padding-left:15px;padding-right:15px">还原</a>
			</div>
		</div>
		<!-- 中间显示的文件 -->
		<div class="list">
			<table class="table table-hover">
				<thead id="tthead">
					<tr style="height:30px">
						<th>
							<li class="checkbox"><input type="checkbox" id="all" name="chose"
								onclick="checkOrCancelAll();" /></li>
						</th>
						<th>文件名</th>
						<!-- <th>上传人</th> -->
						<th>大小</th>
						<th>修改日期</th>
					</tr>
				</thead>
				<tbody id="contentView">

				</tbody>
			</table>
		</div>

	</div>

</body>
</html>