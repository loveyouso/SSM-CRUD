package com.wss.crud.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.wss.crud.bean.Employee;
import com.wss.crud.bean.Message;
import com.wss.crud.service.EmployeeService;

@Controller
public class EmployeeController {

	@Autowired
	EmployeeService employeeService;

	/**
	 * 删除单个员工和批量删除多个员工
	 * 二合一
	 * @param empIds
	 * @return
	 */
	@RequestMapping(value="/emp/{empIds}",method=RequestMethod.DELETE)
	@ResponseBody
	public Message delEmp(@PathVariable(value="empIds")String empIds) {
		if(empIds.contains("-")) {
			List<Integer> del_ids = new ArrayList<>();
			String[] str_ids = empIds.split("-");
			for (String string : str_ids) {
				del_ids.add(Integer.parseInt(string));
			}
			employeeService.delBatchEmp(del_ids);
		}else {
			Integer empId = Integer.parseInt(empIds);
			employeeService.delEmp(empId);
		}
		return Message.success();
	}
	
	@RequestMapping(value="/emp/{empId}",method=RequestMethod.PUT)
	@ResponseBody
	public Message saveEmp(Employee employee) {
		employeeService.updateEmp(employee);
		return Message.success();
	}
	
	@RequestMapping(value="/emp/{id}",method=RequestMethod.GET)
	@ResponseBody
	public Message getEmp(@PathVariable("id")Integer id) {
		Employee employee = employeeService.getEpm(id);
		return Message.success().add("emp", employee);
	}
	
	@ResponseBody
	@RequestMapping("/checkUser")
	public Message checkUser(@RequestParam("empName") String empName) {
		// 先判断用户名是否是合法的表达式;
		String regx = "(^[a-zA-Z0-9_-]{6,16}$)|(^[\u2E80-\u9FFF]{2,5})";
		if (!empName.matches(regx)) {
			return Message.fail().add("va_msg", "用户名必须是6-16位数字和字母的组合或者2-5位中文");
		}

		boolean b = employeeService.checkUser(empName);
		if (b) {
			return Message.success();
		} else {
			return Message.fail().add("va_msg", "用户名不可用");
		}
	}

	@RequestMapping(value = "/emps", method = RequestMethod.POST)
	@ResponseBody
	public Message saveEmp(@Validated Employee employee,BindingResult result) {
		if(result.hasErrors()){
			//校验失败，应该返回失败，在模态框中显示校验失败的错误信息
			Map<String, Object> map = new HashMap<>();
			List<FieldError> errors = result.getFieldErrors();
			for (FieldError fieldError : errors) {
				System.out.println("错误的字段名："+fieldError.getField());
				System.out.println("错误信息："+fieldError.getDefaultMessage());
				map.put(fieldError.getField(), fieldError.getDefaultMessage());
			}
			return Message.fail().add("errorFields", map);
		}else{
			employeeService.saveEmp(employee);
			return Message.success();
		}
	}

	@RequestMapping("/emps")
	@ResponseBody
	public Message getEmpsWithJson(@RequestParam(value = "pn", defaultValue = "1") Integer pn) {

		PageHelper.startPage(pn, 5);
		List<Employee> emps = employeeService.getAll();
		PageInfo pageInfo = new PageInfo<>(emps, 5);

		return Message.success().add("pageInfo", pageInfo);
	}

	/*
	 * @RequestMapping("/emps") public String
	 * getEmps(@RequestParam(value="pn",defaultValue="1")Integer pn, Model model) {
	 * 
	 * PageHelper.startPage(pn, 5); List<Employee> emps = employeeService.getAll();
	 * PageInfo pageInfo = new PageInfo<>(emps,5); model.addAttribute("pageInfo",
	 * pageInfo);
	 * 
	 * return "list"; }
	 */

}
