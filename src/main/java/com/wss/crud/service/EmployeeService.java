package com.wss.crud.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.wss.crud.bean.Employee;
import com.wss.crud.bean.EmployeeExample;
import com.wss.crud.bean.EmployeeExample.Criteria;
import com.wss.crud.dao.EmployeeMapper;

@Service
public class EmployeeService {
	
	@Autowired
	EmployeeMapper employeeMapper;
	
	public List<Employee> getAll(){
		return employeeMapper.selectByExampleWithDept(null);
	}
	/**
	 * ����Ա��
	 * @param employee
	 */
	public void saveEmp(Employee employee) {
		employeeMapper.insertSelective(employee);
	}
	/**
	 * ����û����Ƿ����
	 * @param empName
	 * @return
	 */
	public boolean checkUser(String empName) {
		EmployeeExample example = new EmployeeExample();
		Criteria criteria = example.createCriteria();
		criteria.andEmpNameEqualTo(empName);
		long countByExample = employeeMapper.countByExample(example);
		return countByExample == 0;
	}
	/**
	 * ����id��ȡ����Ա��
	 * @param id
	 * @return
	 */
	public Employee getEpm(Integer id) {
		// TODO Auto-generated method stub
		Employee employee = employeeMapper.selectByPrimaryKey(id);
		return employee;
	}
	/**
	 * ����Ա��
	 * @param employee
	 */
	public void updateEmp(Employee employee) {
		// TODO Auto-generated method stub
		employeeMapper.updateByPrimaryKeySelective(employee);
	}
	/**
	 * ����idɾ������Ա��
	 * @param empId
	 */
	public void delEmp(Integer empId) {
		// TODO Auto-generated method stub
		employeeMapper.deleteByPrimaryKey(empId);
	}
	/**
	 * ����ɾ��Ա��
	 * @param del_ids
	 */
	public void delBatchEmp(List<Integer> del_ids) {
		// TODO Auto-generated method stub
		EmployeeExample example = new EmployeeExample();
		Criteria criteria = example.createCriteria();
		criteria.andEmpIdIn(del_ids);
		employeeMapper.deleteByExample(example);
	}
}
