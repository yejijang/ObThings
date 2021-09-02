package com.project.ot.mypage;

import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;


@Repository
public class MyPageDAO {
	
	@Autowired
	private SqlSessionTemplate template;


	
	public List<MyLikeDTO> likelist(String memberSeq) {

		return template.selectList("mpot.likelist", memberSeq);
	}



	public List<MyFundingDTO> fundlist(String memberSeq) {
		
		return template.selectList("mpot.fundlist",memberSeq);
	}







}
