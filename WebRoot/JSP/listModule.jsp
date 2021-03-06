<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="/struts-tags" prefix="s"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<%@include file="debugFile.inc"%>
<!-- PAGE TITLE & BREADCRUMB-->
<div class="row-fluid">
	<h3 class="page-title">模块管理</h3>
	<ul class="breadcrumb">
		<li><i class="icon-home"></i> <a class="ajaxify" href="index.jsp">主页</a> <i class="icon-angle-right"></i></li>
		<li><a class="ajaxify" href="#">模块管理</a> <i class="icon-angle-right"></i></li>
		<li><a class="ajaxify" href="#">角色管理</a><i class="icon-angle-right"></i></li>
		<li><a class="ajaxify" href="#">用户管理</a></li>
	</ul>
</div>
<div class='portlet-body form'>
	<form name="formSelect" id="form_Select" method="post" action="FindAction!findByCondition">
		<div class="row-fluid">
			<div class="span6">
				<div class="control-group">
					<div class="controls">
						<select id="findCondition" name="findCondition">
							<option value="id">按模块编号</option>
							<option value="name">按模块名称</option>
						</select>
						 <input id="className"  name="className" type="hidden" value="Module" />
						 <input id="textfield" name="textfield" type="text" />
					</div>
				</div>
			</div>
			<div class="span6">
				<div class="control-group">
					<div class="controls">
						<button id="select" type="button" class="btn btn-primary">查 询</button>
						<button id="Submit" class="btn btn-primary" type="button">高级搜索</button>
					</div>
				</div>
			</div>
		</div>
	</form>
</div>
<div class="row-fluid">
	<form name="fom" id="fom" method="post" action="">
		<table class="table table-bordered">
			<div class="row-fluid">
				<span>选择： <a href="#" id="selectAll">全选</a>-<a href="#" id="unselect">反选</a>
				</span>
				<s:if test="#request.pid">
					<input class="btn" name="Submit" type="button" value="删除所选模块信息" id="deleteChose" data-action="ModuleAction!deletemodule|${url }" />
				</s:if>
				<a href="JSP/module.jsp?pid=${pid}" class="btn ajaxify">添加模块信息</a>
			</div>
			<div class="row-fluid">
				<div class="row-fluid" style="text-align: center; font-size: 20px; background-color: #EEEEEE">模块详细列表</div>
				<table class="table table-striped table-bordered table-condensed">
					<thead>
						<tr>
							<th>选择</th>
							<th>模块编号</th>
							<th>模块名称</th>
							<th>模块路径</th>
							<th>唯一标示</th>
							<th>主模块</th>
							<th>操作</th>
						</tr>
					</thead>
					<tbody>
						<s:iterator var="MOUDLE" value="#request.listObject">
							<tr>
								<td><input type="checkbox" name="delid" value="${MOUDLE.id }" /></td>
								<td>${MOUDLE.id }</td>
								<td><a class="ajaxify" href="ModuleAction!moduleList?module.id=${requestScope.MOUDLE.id }">${requestScope.MOUDLE.name }</a></td>
								<td>${MOUDLE.url }</td>
								<td>${MOUDLE.sn }</td>
								<td>${MOUDLE.pid.id }</td>
								<td><a class="btn ajaxify" href="ModuleAction!edit?module.id=${requestScope.MOUDLE.id }&method=4">编辑</a>&nbsp;|&nbsp; <!-- 		<a class="btn ajaxify" href="yuangongsalary.html">发工资</a>&nbsp;|&nbsp;
								<a class="btn ajaxify" href="yuangongxiangmu.html">项目</a>&nbsp;&nbsp; --> <!-- 								<input class="btn"  type="button" 	value="删除" id="deleteChose" data-action="ModuleAction!deletemodule?delid=${requestScope.MOUDLE.id }|${url }" /> -->
									<a class="deleteOne" href="javascript:void(0)" data-action="ModuleAction!deletemodule?delid=${requestScope.MOUDLE.id }&method=8|${url }">删除</a></td>
							</tr>
						</s:iterator>
					</tbody>
				</table>
			</div>
			<div class="row-fluid">
				<s:set var="pageCount" value="(#request.totalSize-1)/10+1" />
				<s:set var="url" value="#request.url" />
				<div class="span4" style="margin: 20px 0px 20px 0px;">
					共 <span>${requestScope.pageCount}</span> 页 | 第 <span>${requestScope.currentIndex}</span> 页
				</div>
				<div class="pagination pull-right">
					<ul>
						<li class="active"><a class="ajaxify" href="${url }&index=1">首页</a></li>
						<s:if test='(#request.currentIndex) > 1'>
							<li class="active"><a class="ajaxify" href="${url }&index=${requestScope.currentIndex-1}">上页</a></li>
						</s:if>
						<s:else>
							<li class="disabled"><a href="javascript:;">上页</a></li>
						</s:else>
						<s:if test='(#request.currentIndex) < #pageCount'>
							<li class="active"><a class="ajaxify" href="${url }&index=${requestScope.currentIndex+1}">下页</a></li>
						</s:if>
						<s:else>
							<li class="disabled"><a href="javascript:;">下页</a></li>
						</s:else>
						<li class="active"><a class="ajaxify" href="${url }&index=${pageCount }">末页</a></li>
					</ul>
				</div>
			</div>
		</table>
	</form>
</div>
<script src="js/myAjaxify.js" type="text/javascript"></script>
<SCRIPT>
	$("#select").click(function(e) {
		e.preventDefault();
		var pageContent = $('.page-content .page-content-body');

		$.ajax({
			url : $('#form_Select').attr('action'),
			data : $('#form_Select').serialize(),
			success : function(res) {
				pageContent.html(res);
			},
			error : function() {
				alert("你输入的有问题");
			}
		});
	});
</SCRIPT>