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
<script type="text/javascript"
	src="${APP_PATH }/static/js/jquery-1.12.4.min.js"></script>
<link
	href="${APP_PATH }/static/bootstrap-3.3.7-dist/css/bootstrap.min.css"
	rel="stylesheet">
<script
	src="${APP_PATH }/static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
</head>
<body>


	<!-- 修改员工的Modal -->
	<div class="modal fade" id="empUpdateModal" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title">员工修改</h4>
				</div>
				<div class="modal-body">

					<form class="form-horizontal">
						<div class="form-group">
							<label class="col-sm-2 control-label">empName</label>
							<div class="col-sm-10">
								<p class="form-control-static" id="empName_update_static"></p>
							</div>
						</div>
						<div class="form-group">
							<label for="inputPassword3" class="col-sm-2 control-label">Email</label>
							<div class="col-sm-10">
								<input type="email" class="form-control" name="empMail"
									id="empEmail_update_input" placeholder="email@wss.com">
								<span class="help-block"></span>
							</div>
						</div>
						<div class="form-group">
							<label for="inputPassword4" class="col-sm-2 control-label">Gender</label>
							<div class="col-sm-10">
								<label class="radio-inline"> <input type="radio"
									name="empGender" id="gender_update_input1" value="M"
									checked="checked">男
								</label> <label class="radio-inline"> <input type="radio"
									name="empGender" id="gender_update_input2" value="F">女
								</label>
							</div>
						</div>

						<div class="form-group">
							<label for="inputPassword5" class="col-sm-2 control-label">deptName</label>
							<div class="col-sm-4">
								<select class="form-control" name="dId" id="dept_update_select"></select>
							</div>
						</div>
					</form>

				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
					<button type="button" class="btn btn-primary" id="emp_updata_save">更新</button>
				</div>
			</div>
		</div>
	</div>


	<!-- 添加员工的Modal -->
	<div class="modal fade" id="empAddModal" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title" id="myModalLabel">添加员工</h4>
				</div>
				<div class="modal-body">

					<form class="form-horizontal">
						<div class="form-group">
							<label class="col-sm-2 control-label">empName</label>
							<div class="col-sm-10">
								<input type="text" class="form-control" name="empName"
									id="empName_add_input" placeholder="empName"> <span
									class="help-block"></span>
							</div>
						</div>
						<div class="form-group">
							<label for="inputPassword3" class="col-sm-2 control-label">Email</label>
							<div class="col-sm-10">
								<input type="email" class="form-control" name="empMail"
									id="empEmail_add_input" placeholder="email@wss.com"> <span
									class="help-block"></span>
							</div>
						</div>
						<div class="form-group">
							<label for="inputPassword4" class="col-sm-2 control-label">Gender</label>
							<div class="col-sm-10">
								<label class="radio-inline"> <input type="radio"
									name="empGender" id="gender_input1" value="M" checked="checked">男
								</label> <label class="radio-inline"> <input type="radio"
									name="empGender" id="gender_input2" value="F">女
								</label>
							</div>
						</div>

						<div class="form-group">
							<label for="inputPassword5" class="col-sm-2 control-label">deptName</label>
							<div class="col-sm-4">
								<select class="form-control" name="dId" id="dept_add_select"></select>
							</div>
						</div>
					</form>

				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
					<button type="button" class="btn btn-primary" id="emp_add_save">保存</button>
				</div>
			</div>
		</div>
	</div>


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
				<button class="btn btn-primary" id="emp_add_btn">新增</button>
				<button class="btn btn-danger" id="emp_delete_all_btn">删除</button>
			</div>
		</div>

		<!-- 详情table -->
		<div class="row">
			<div class="col-md-12">
				<table class="table table-hover" id="emps_table">
					<thead>
						<tr>
							<th>
								<input type="checkbox" id="check_all"/>
							</th>
							<th>#</th>
							<th>EmpName</th>
							<th>Gender</th>
							<th>Email</th>
							<th>DeptName</th>
							<th>操作</th>
						</tr>
					</thead>
					<tbody>

					</tbody>
				</table>
			</div>
		</div>
		<!-- ======分页====== -->
		<div class="row">
			<div class="col-md-6" id="page_info_area"></div>
			<div class="col-md-6" id="page_nav_area"></div>
		</div>
	</div>

	<script type="text/javascript">
		var currentPage;
		$(function() {
			//去首页
			to_page(1);
		});

		function to_page(pn) {
			$.ajax({
				url : "${APP_PATH}/emps",
				data : "pn=" + pn,
				type : "get",
				success : function(result) {
					//console.log(result);
					//1.解析并返回员工数据
					build_emps_table(result);
					//2.解析并返回分页数据
					build_page_info(result);
					//3.解析并返回导航数据
					build_page_nav(result);
				}
			});
		}

		function build_emps_table(result) {
			//清空table表格
			$("#emps_table tbody").empty();
			var emps = result.extend.pageInfo.list;

			$.each(emps, function(index, item) {
				var checkBoxTd = $("<td><input type='checkbox' class='check_item'/></td>");
				var empIdTd = $("<td></td>").append(item.empId);
				var empNameTd = $("<td></td>").append(item.empName);
				var empGenderTd = $("<td></td>").append(
						item.empGender == 'M' ? "男" : "女");
				var empMailTd = $("<td></td>").append(item.empMail);
				var deptNameTd = $("<td></td>")
						.append(item.department.deptName);
				var editBtn = $("<button></button>").addClass(
						"btn btn-primary  btn-sm edit-btn").append(
						$("<span></span>")).addClass(
						"glyphicon glyphicon-pencil").append(" 编辑");
				editBtn.attr("empId", item.empId);
				var delBtn = $("<button></button>").addClass(
						"btn btn-danger  btn-sm del-btn").append(
						$("<span></span>")).addClass(
						"glyphicon glyphicon-trash").append(" 删除");
				delBtn.attr("del-id",item.empId);
				var btn = $("<td></td>").append(editBtn).append(delBtn);
				$("<tr></tr>").append(checkBoxTd).append(empIdTd).append(empNameTd).append(
						empGenderTd).append(empMailTd).append(deptNameTd)
						.append(btn).appendTo("#emps_table tbody");
			});

		}

		//解析显示分页信息
		function build_page_info(result) {
			$("#page_info_area").empty();
			var pageInfo = result.extend.pageInfo;
			$("#page_info_area").append(
					"当前第" + pageInfo.pageNum + "页,总共" + pageInfo.pages + "页,总共"
							+ pageInfo.total + "条记录");
			currentPage = pageInfo.pageNum;
		}

		function build_page_nav(result) {
			$("#page_nav_area").empty();
			var ul = $("<ul></ul>").addClass("pagination");

			//构建元素
			var firstPageLi = $("<li></li>").append(
					$("<a></a>").append("首页").attr("href", "#"));
			var prePageLi = $("<li></li>").append(
					$("<a></a>").append("&laquo;"));
			if (result.extend.pageInfo.hasPreviousPage == false) {
				firstPageLi.addClass("disabled");
				prePageLi.addClass("disabled");
			} else {
				//为元素添加点击翻页的事件
				firstPageLi.click(function() {
					to_page(1);
				});
				prePageLi.click(function() {
					to_page(result.extend.pageInfo.pageNum - 1);
				});
			}

			var nextPageLi = $("<li></li>").append(
					$("<a></a>").append("&raquo;"));
			var lastPageLi = $("<li></li>").append(
					$("<a></a>").append("末页").attr("href", "#"));
			if (result.extend.pageInfo.hasNextPage == false) {
				nextPageLi.addClass("disabled");
				lastPageLi.addClass("disabled");
			} else {
				nextPageLi.click(function() {
					to_page(result.extend.pageInfo.pageNum + 1);
				});
				lastPageLi.click(function() {
					to_page(result.extend.pageInfo.pages);
				});
			}

			//添加首页和前一页 的提示
			ul.append(firstPageLi).append(prePageLi);
			//1,2,3,4,5遍历给ul中添加页码提示
			$.each(result.extend.pageInfo.navigatepageNums, function(index,
					item) {
				var numLi = $("<li></li>").append($("<a></a>").append(item));
				if (result.extend.pageInfo.pageNum == item) {
					numLi.addClass("active");
				}
				numLi.click(function() {
					to_page(item);
				});
				ul.append(numLi);
			});
			//添加下一页和末页 的提示
			ul.append(nextPageLi).append(lastPageLi);

			//把ul加入到nav
			var navEle = $("<nav></nav>").append(ul);
			navEle.appendTo("#page_nav_area");
		}

		//清空表单样式及内容
		function reset_form(ele) {
			$(ele)[0].reset();
			//清空表单样式
			$(ele).find("*").removeClass("has-error has-success");
			$(ele).find(".help-block").text("");
		}

		//弹出添加员工的模态块
		$("#emp_add_btn").click(function() {
			reset_form("#empAddModal form");

			getDepts("#dept_add_select");
			//加载模态块
			$("#empAddModal").modal({
				backdrop : "static"
			});
		});

		//查询部门信息
		function getDepts(ele) {
			$(ele).empty();
			$.ajax({
				url : "${APP_PATH}/depts",
				type : "GET",
				success : function(result) {
					//console.log(result);
					$.each(result.extend.deptInfo, function() {
						var optionEle = $("<option></option>").append(
								this.deptName).attr("value", this.deptId);
						optionEle.appendTo(ele);
					});
				}
			});
		}

		//校验表单数据
		function validata_add_form() {
			//1、拿到要校验的数据，使用正则表达式
			var empName = $("#empName_add_input").val();
			var regName = /(^[a-zA-Z0-9_-]{6,16}$)|(^[\u2E80-\u9FFF]{2,5})/;
			if (!regName.test(empName)) {
				show_validate_msg("#empName_add_input", "error",
						"用户名可以是2-5位中文或者6-16位英文和数字的组合");
				return false;
			} else {
				show_validate_msg("#empName_add_input", "success", "");
			}
			;

			//2、校验邮箱信息
			var email = $("#empEmail_add_input").val();
			var regEmail = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
			if (!regEmail.test(email)) {
				//应该清空这个元素之前的样式
				show_validate_msg("#empEmail_add_input", "error", "邮箱格式不正确");
				return false;
			} else {
				show_validate_msg("#empEmail_add_input", "success", "");
			}
			return true;
		}

		//显示校验结果的提示信息
		function show_validate_msg(ele, status, msg) {
			//清除当前元素的校验状态
			$(ele).parent().removeClass("has-success has-error");
			$(ele).next("span").text("");
			if ("success" == status) {
				$(ele).parent().addClass("has-success");
				$(ele).next("span").text(msg);
			} else if ("error" == status) {
				$(ele).parent().addClass("has-error");
				$(ele).next("span").text(msg);
			}
		}

		//检查员工是否可用
		$("#empName_add_input").change(
				function() {
					var empName = this.value;
					$.ajax({
						url : "${APP_PATH}/checkUser",
						type : "POST",
						data : "empName=" + empName,
						success : function(result) {
							if (result.code == 200) {
								show_validate_msg("#empName_add_input",
										"success", "用户名可用");
								$("#emp_add_save").attr("ajax-va", "success");
							} else {
								show_validate_msg("#empName_add_input",
										"error", result.extend.va_msg);
								$("#emp_add_save").attr("ajax-va", "error");
							}
						}
					});
				});

		//添加员工
		$("#emp_add_save")
				.click(
						function() {
							//前端校验数据
							if (!validata_add_form()) {
								return false;
							}

							if ($(this).attr("ajax-va") == "error") {
								return false;
							}

							$
									.ajax({
										url : "${APP_PATH}/emps",
										data : $("#empAddModal form")
												.serialize(),
										type : "POST",
										success : function(result) {
											if (result.code == 200) {
												$("#empAddModal").modal("hide");

												to_page(999);
											} else {
												console.log(result);
												//有哪个字段的错误信息就显示哪个字段的；
												if (undefined != result.extend.errorFields.empName) {
													//显示员工名字的错误信息
													show_validate_msg(
															"#empName_add_input",
															"error",
															result.extend.errorFields.empName);
												}
												if (undefined != result.extend.errorFields.empMail) {
													//显示邮箱错误信息
													show_validate_msg(
															"#empEmail_add_input",
															"error",
															result.extend.errorFields.empMail);
												}
											}

										}
									});
						});

		//编辑按钮的动作
		//1、我们是按钮创建之前就绑定了click，所以绑定不上。
		//1)可以在创建按钮的时候绑定。    2)、绑定点击.live()
		//jquery新版没有live，使用on进行替代
		$(document).on("click", ".edit-btn", function() {

			//获取部门信息回显
			getDepts("#dept_update_select");
			//获取员工信息回显
			getEmp($(this).attr("empId"));
			//将id传递给更新按钮
			$("#emp_updata_save").attr("empId", $(this).attr("empId"));
			//加载模态块
			$("#empUpdateModal").modal({
				backdrop : "static"
			});
		});

		//更新员工时表单回显
		function getEmp(id) {
			$.ajax({
				url : "${APP_PATH}/emp/" + id,
				type : "GET",
				success : function(result) {
					//console.log(result);
					var empData = result.extend.emp;
					$("#empName_update_static").text(empData.empName);
					$("#empEmail_update_input").val(empData.empMail);
					$("#empUpdateModal input[name=empGender]").val(
							[ empData.empGender ]);
					$("#empUpdateModal select").val([ empData.dId ]);
				}
			});
		}

		$("#emp_updata_save")
				.click(
						function() {
							var email = $("#empEmail_update_input").val();
							var regEmail = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
							if (!regEmail.test(email)) {
								//应该清空这个元素之前的样式
								show_validate_msg("#empEmail_update_input",
										"error", "邮箱格式不正确");
								return false;
							} else {
								show_validate_msg("#empEmail_update_input",
										"success", "");
							}
							$.ajax({
								url : "${APP_PATH}/emp/"
										+ $(this).attr("empId"),
								type : "PUT",
								data : $("#empUpdateModal form").serialize(),
								success : function(result) {
									//alert(result.msg);
									$("#empUpdateModal").modal('hide');
									to_page(currentPage);
								}
							});
						});

		$(document).on("click", ".del-btn", function() {
			var empName = $(this).parents("tr").find("td:eq(2)").text();
			var empId = $(this).attr("del-id");
			//alert($(this).parents("tr").find("td:eq(1)").text());
			if (confirm("确认删除【" + empName + "】吗？")) {
				//确认，发送ajax请求删除即可
				$.ajax({
					url : "${APP_PATH}/emp/" + empId,
					type : "DELETE",
					success : function(result) {
						alert("操作成功！");
						//回到本页
						to_page(currentPage);
					}
				});
			}
		});
		
		//全选和全部选的功能
		$("#check_all").click(function(){
			//attr获取checked是undefined;
			//我们这些dom是原生的属性；
			//attr获取自定义属性的值；prop修改和读取dom原生属性的值
			$(".check_item").prop("checked",$(this).prop("checked"));
		});
		
		//check_item
		$(document).on("click",".check_item",function(){
			//判断当前选择中的元素是否5个
			var flag = $(".check_item:checked").length==$(".check_item").length;
			$("#check_all").prop("checked",flag);
		});
		
		//点击全部删除，就批量删除
		$("#emp_delete_all_btn").click(function(){
			//
			var empNames = "";
			var del_idstr = "";
			$.each($(".check_item:checked"),function(){
				//组装员工姓名
				empNames += $(this).parents("tr").find("td:eq(2)").text()+",";
				//组装员工id字符串
				del_idstr += $(this).parents("tr").find("td:eq(1)").text()+"-";
			});
			//去除empNames多余的,
			empNames = empNames.substring(0, empNames.length-1);
			//去除删除的id多余的-
			del_idstr = del_idstr.substring(0, del_idstr.length-1);
			if(confirm("确认删除【"+empNames+"】吗？")){
				//发送ajax请求删除
				$.ajax({
					url:"${APP_PATH}/emp/"+del_idstr,
					type:"DELETE",
					success:function(result){
						alert(result.msg);
						//回到当前页面
						to_page(currentPage);
						$("#check_all").prop("checked",false);
					}
				});
			}
			
		});
		
	</script>



</body>
</html>