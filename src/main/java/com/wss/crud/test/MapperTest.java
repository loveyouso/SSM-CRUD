package com.wss.crud.test;

import java.util.UUID;

import org.apache.ibatis.session.SqlSession;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.wss.crud.bean.Department;
import com.wss.crud.bean.Employee;
import com.wss.crud.dao.DepartmentMapper;
/**
 * Mapped测试单元类
 * @author soaped
 * 使用spring test模块测试
 */
import com.wss.crud.dao.EmployeeMapper;
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations= {"classpath:applicationContext.xml"})
public class MapperTest {
	
	@Autowired
	DepartmentMapper departmentmapper;
	
	@Autowired
	EmployeeMapper employeeMapper;
	
	@Autowired
	SqlSession sqlsession;
	
	@Test
	public void testCRUD() {
		System.out.println(departmentmapper);
		System.out.println(employeeMapper);
		
		//departmentmapper.insertSelective(new Department(null, "开发部"));
		//departmentmapper.insertSelective(new Department(null, "测试部"));
	
		//employeeMapper.insertSelective(new Employee(null, "Jerry", "M", "Jerry@wss.com", 1));
	
		EmployeeMapper employeeMapper2 = sqlsession.getMapper(EmployeeMapper.class);
		for(int i = 0;i < 100 ;i++) {
			String uuid = UUID.randomUUID().toString().substring(0, 5)+i;
			employeeMapper2.insertSelective(new Employee(null, uuid, "M",uuid+"@wss.com", 1));
		}
		System.out.println("批量插入完成");
	}

}
