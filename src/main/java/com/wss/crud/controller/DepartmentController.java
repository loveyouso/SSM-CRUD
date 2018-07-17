package com.wss.crud.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.wss.crud.bean.Department;
import com.wss.crud.bean.Message;
import com.wss.crud.service.DepartmentService;

@Controller
public class DepartmentController {
	
	@Autowired
	DepartmentService departmentService;
	
	@RequestMapping("/depts")
	@ResponseBody
	public Message getDepts(){
		List<Department> list = departmentService.getAll();
		return Message.success().add("deptInfo", list);
	}
	
}
