package com.project.ot;

import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.project.ot.funding.ProjectDTO;

@Repository
public class OtDAO {

	@Autowired
	private SqlSessionTemplate template;

	//로그인
	public MemberDTO signin(HashMap<String, String> map) {
		
		return template.selectOne("ot.signin", map);
	}
	
	public List<String> populList() {

		return template.selectList("ot.populList");
	}

	public List<String> succList() {

		return template.selectList("ot.succList");
	}

	public List<String> newList() {

		return template.selectList("ot.newList");
	}

	public ProjectDTO listInfo(String seq) {
		return template.selectOne("ot.listInfo", seq);
	}

	public String totalPrice(String seq) {

		return template.selectOne("ot.totalPrice", seq);
	}
	
}