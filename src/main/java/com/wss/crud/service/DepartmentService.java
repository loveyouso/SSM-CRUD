package com.wss.crud.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.wss.crud.bean.Department;
import com.wss.crud.dao.DepartmentMapper;

@Service
public class DepartmentService {
	
	@Autowired
	DepartmentMapper departmentMapper;
	
	public List<Department> getAll(){
		List<Department> list = departmentMapper.selectByExample(null);
		return list;
	}
}
