<%@page import="java.awt.PageAttributes"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>员工列表</title>
<%
	pageContext.setAttribute("APP_PATH", request.getContextPath());
%>
<script type="text/javascript" src="${APP_PATH }/static/js/jquery-1.12.4.min.js"></script>
<link href="${APP_PATH }/static/bootstrap-3.3.7-dist/css/bootstrap.min.css" rel="stylesheet">
<script src="${APP_PATH }/static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
</head>
<body>
	<div class="container">
		<!-- 标题 -->
		<div class="row">
			<div class="col-md-12">
				<h1>SSM-CRUD</h1>
			</div>
		</div>
		<!-- 按钮 -->
		<div class="row">
			<div class="col-md-3 col-md-offset-9">
				<button class="btn btn-primary">新增</button>
				<button class="btn btn-danger">删除</button>
			</div>
		</div>

		<!-- 详情table -->
		<div class="row">
			<div class="col-md-12">
				<table class="table table-hover">
					<tr>
						<th>#</th>
						<th>EmpName</th>
						<th>Gender</th>
						<th>Email</th>
						<th>DeptName</th>
						<th>操作</th>
					</tr>
					<c:forEach items="${pageInfo.list }" var="emps">
						<tr>
							<td>${emps.empId }</td>
							<td>${emps.empName }</td>
							<td>${emps.empGender == "M" ? "女" : "男"}</td>
							<td>${emps.empMail }</td>
							<td>${emps.department.deptName }</td>
							<td>
								<button class="btn btn-primary  btn-sm">
									<span class="glyphicon glyphicon-pencil"></span> 编辑
								</button>
								<button class="btn btn-danger  btn-sm">
									<span class="glyphicon glyphicon-trash"></span> 删除
								</button>
							</td>
						</tr>
					</c:forEach>

				</table>
			</div>
		</div>
		<!-- ======分页====== -->
		<div class="row">
			<div class="col-md-6">
				当前第${pageInfo.pageNum }页,总共${pageInfo.pages }页,总共${pageInfo.total }条记录
			</div>
			<div class="col-md-6">
				<nav aria-label="Page navigation">
					<ul class="pagination">
						<li><a href="${APP_PATH }/emps?pn=1">首页</a></li>
						<c:if test="${pageInfo.hasPreviousPage }">
							<li>
								<a href="${APP_PATH }/emps?pn=${pageInfo.pageNum - 1 }" aria-label="Previous"> <span aria-hidden="true">&laquo;</span></a>
							</li>
						</c:if>
						<c:forEach items="${pageInfo.navigatepageNums }" var="nums">
							<c:if test="${pageInfo.pageNum == nums }">
								<li class="active"><a href="${APP_PATH }/emps?pn=${nums }">${nums }</a></li>
							</c:if>
							<c:if test="${pageInfo.pageNum != nums }">
								<li><a href="${APP_PATH }/emps?pn=${nums }">${nums }</a></li>
							</c:if>
						</c:forEach>
						<c:if test="${pageInfo.hasNextPage }">
							<li>
								<a href="${APP_PATH }/emps?pn=${pageInfo.pageNum + 1 }" aria-label="Next"> <span aria-hidden="true">&raquo;</span></a>
								</li>
						</c:if>
						<li><a href="${APP_PATH }/emps?pn=${pageInfo.pages }">末页</a></li>
					</ul>
				</nav>
			</div>
		</div>
	</div>
</body>
</html>