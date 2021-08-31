package com.project.ot.funding;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class FundingDAO {

	@Autowired
	private SqlSessionTemplate template;

	public List<CategoryDTO> categoryList() {

		return template.selectList("fund.categoryList");
	}

	public List<String> populList() {

		return template.selectList("fund.populList");
	}

	public List<String> succList() {

		return template.selectList("fund.succList");
	}

	public List<String> newList() {

		return template.selectList("fund.newList");
	}

	public ProjectDTO listInfo(String seq) {
		return template.selectOne("fund.listInfo", seq);
	}

	public String totalPrice(String seq) {

		return template.selectOne("fund.totalPrice", seq);
	}

	public List<String> projectList(String categoryseq) {

		return template.selectList("fund.projectList", categoryseq);
	}

	public String categoryName(String categoryseq) {

		return template.selectOne("fund.categoryName", categoryseq);
	}

	public ProjectDTO projectInfo(String projectseq) {

		return template.selectOne("fund.projectInfo", projectseq);
	}

	public List<String> projectImageList(String projectseq) {

		return template.selectList("fund.projectImageList", projectseq);
	}

	public String projectTotalMember(String projectseq) {

		return template.selectOne("fund.projectTotalMember", projectseq);
	}

	public List<ProjectPackDTO> projectPackList(String projectseq) {

		return template.selectList("fund.projectPackList", projectseq);
	}

	public List<String> genderList(String projectseq) {

		return template.selectList("fund.genderList", projectseq);
	}

	public List<ProjectAgeGroupDTO> ageGroupList(String projectseq) {

		return template.selectList("fund.ageGroupList", projectseq);
	}

	public List<NoticeDTO> noticeList(String projectseq) {
		
		return template.selectList("fund.noticeList", projectseq);
	}

	public int sendQa(QADTO dto) {
		
		return template.insert("fund.sendQa", dto);
	}

}