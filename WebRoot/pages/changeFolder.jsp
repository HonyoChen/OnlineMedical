<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

<!DOCTYPE HTML>
<html>
<head>
<base href="<%=basePath%>">

<title>移动文件夹</title>

<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<link rel="stylesheet" href="<%=path %>/zTree_v3/css/zTreeStyle/zTreeStyle.css" type="text/css">
<script src="<%=path %>/js/jquery-1.10.2.js" type="text/javascript"></script>
<script src="<%=path %>/zTree_v3/js/jquery.ztree.core.js" type="text/javascript"></script>
<script tyep="text/javascript">
	var file_id;
	var root_id;
	var doct_id;
	
	$(document).ready(function() {
		//解析传参
		var name, value;//参数名和值
		var url = decodeURI(window.location.href);
		var index = url.indexOf('?');
		var params = url.substr(index+1);
		params = window.atob(params);
		var parr = params.split('&');
		for(var i=0; i < parr.length; i++){//解析所有参数
			index = parr[i].indexOf('=');
			if(index > 0){
				name = parr[i].substr(0, index);
				value = parr[i].substr(index+1);
				this[name] = value;
			}
		}
		file_id = this['fid'];
		root_id = this['rid'];
		doct_id = this['did'];
		
		var zNodes;
		$.ajax({
			url : "findTreeMenu",
			type : "POST",
			data : {
				"rid" : root_id,
				"did" : doct_id
			},
			async : false,
			dataType : "JSON",
			success : function(result) {
				zNodes = result;
			},
			error : function(result) {
				alert("返回数据失败，请刷新页面");
			}
		});
		
		//页面加载完成后，执行这段代码----动态创建ztree
		var zTree;
		var setting = {
			view : {
				dblClickExpand : false, //双击节点时，是否自动展开父节点的标识
				showLine : true, //是否显示节点之间的连线
				showIcon : true,
				fontCss : {
					'color' : 'black',
					'font-weight' : 'bold'
				}, //字体样式函数
				selectedMulti : false //设置是否允许同时选中多个节点
			},
			check : {
				//chkboxType: { "Y": "ps", "N": "ps" },
				chkStyle : "checkbox", //复选框类型
				enable : true //每个节点上是否显示 CheckBox 
			},
			data : {
				simpleData : { //简单数据模式
					enable : true,
					idKey : "id",
					pIdKey : "pId",
					rootPId : "0"
				}
			},
			callback : {
				beforeClick : function(treeId, treeNode) {
					zTree = $.fn.zTree.getZTreeObj("ztree2");
					if (treeNode.isParent) {
						zTree.expandNode(treeNode); //如果是父节点，则展开该节点
					} else {
						zTree.checkNode(treeNode, !treeNode.checked, true, true); //单击勾选，再次单击取消勾选
					}
				}
			}
		};
		//调用API初始化ztree
		$.fn.zTree.init($("#ztree2"), setting, zNodes);
	});
	
	function alertSelected(){
		var zTreeObj = $.fn.zTree.getZTreeObj("ztree2");
		var selectedNodes = zTreeObj.getSelectedNodes();
		//alert("nodes:" + selectedNodes[0].id);
		
		$.ajax({
			url : "changeParent",
			type : "POST",
			data : {
				"fid" : file_id,
				"parent" : selectedNodes[0].id
			},
			async : false,
			dataType : "JSON",
			success : function(result) {
				//alert("成功，关闭窗口");
				window.opener.location.reload();//刷新父窗口
				window.close();
			},
			error : function(result) {
				alert("移动文件夹失败");
			}
		});
	}
	
	function alertCancle(){
		window.close();
	}
	
</script>
<style>
/* .allsize{
	height:200px;
} */
.head {
	border:1px solid #e4d8d8;
    height: 30px;
    background: #efefef;
    position: relative;
    font-family: "Helvetica Neue", Helvetica, Arial, sans-serif;
    font-size:14px;
    font-weight:bold;
    padding-top: 15px;
    padding-left: 10px;
}

.tree{
/* 	border-top:1px solid #e4d8d8; */
	padding: 10px;
	overflow:scroll;
	height:120px;
}

.buttom{
	padding:10px;
	padding-left: 90px;
	padding-top: 20px;
}

.buttomm:visited {
    color: #666;
}
.buttomm{
	font-size: 9.6px;
    height: 24px;
    line-height: 24px;
    padding: 0 24px;
    border-radius: 200px;
    background-color: #EEE;
    border-color: #EEE;
    font-weight: 300;
    font-family: "Helvetica Neue Light", "Helvetica Neue", Helvetica, Arial, "Lucida Grande", sans-serif;
    text-decoration: none;
    text-align: center;
    display: inline-block;
    cursor: pointer;
    border: none;
    box-sizing: border-box;
    transition-property: all;
    transition-duration: .3s;
}

</style>
</head>

<body style="overflow:hidden">
<!-- <div class="allsize"> -->
	<div class="head">
		移动到 : 
	</div>
	
	<div class="tree">
		<ul id="ztree2" class="ztree"></ul>
	</div>
	
	<div class="buttom">
		<button  style="margin-right: 20px;margin-left:5px;" onclick="alertSelected()" class="buttomm">确定</button>
		<button onclick="alertCancle()" class="buttomm">取消</button>
	</div>
<!-- </div> -->
	

	
</body>
</html>