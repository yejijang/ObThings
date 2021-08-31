package com.project.ot.funding;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class FundController {

	@Autowired
	private FundingDAO dao;

	@RequestMapping(value = "/funding/fundmain.action", method = { RequestMethod.GET })
	public String main(HttpServletRequest req, HttpServletResponse resp, HttpSession session, String categoryseq) {

		List<CategoryDTO> categoryList = dao.categoryList(); // 카테고리 리스트

		// 전체보기
		if (categoryseq == null || categoryseq.equals("")) {

			List<String> populListSeq = dao.populList(); // 인기 프로젝트 시퀀스 리스트
			List<String> succListSeq = dao.succList(); // 성공 임박 프로젝트 시퀀스 리스트
			List<String> newListSeq = dao.newList(); // 신규 프로젝트 시퀀스 리스트
			List<ProjectDTO> populList = new ArrayList<ProjectDTO>(); // 인기 프로젝트 리스트
			List<ProjectDTO> succList = new ArrayList<ProjectDTO>(); // 신규 임박 프로젝트 리스트
			List<ProjectDTO> newList = new ArrayList<ProjectDTO>(); // 신규 프로젝트 리스트

			for (String seq : populListSeq) { // 인기 프로젝트 리스트
				ProjectDTO dto = dao.listInfo(seq); // 프로젝트 정보
				String totalPrice = dao.totalPrice(seq); // 프로젝트 펀딩받은 총 금액
				dto.setTotalPrice(totalPrice);
				populList.add(dto);
			}

			for (String seq : succListSeq) { // 신규 임박 프로젝트 리스트
				ProjectDTO dto = dao.listInfo(seq); // 프로젝트 정보
				String totalPrice = dao.totalPrice(seq); // 프로젝트 펀딩받은 총 금액
				dto.setTotalPrice(totalPrice);
				succList.add(dto);
			}

			for (String seq : newListSeq) { // 신규 프로젝트 리스트
				ProjectDTO dto = dao.listInfo(seq); // 프로젝트 정보
				String totalPrice = dao.totalPrice(seq); // 프로젝트 펀딩받은 총 금액
				dto.setTotalPrice(totalPrice);
				newList.add(dto);
			}

			req.setAttribute("succList", succList);
			req.setAttribute("populList", populList);
			req.setAttribute("newList", newList);

		} else {

			// 카테고리 선택시
			List<String> projectListSeq = dao.projectList(categoryseq); // 패키지에 해당하는 프로젝트 시퀀스 리스트
			List<ProjectDTO> projectList = new ArrayList<ProjectDTO>(); // 패키지에 해당하는 프로젝트 리스트
			String categoryName = dao.categoryName(categoryseq); // 패키지명

			for (String seq : projectListSeq) { // 패키지에 해당하는 프로젝트 리스트
				ProjectDTO dto = dao.listInfo(seq); // 프로젝트 정보
				String totalPrice = dao.totalPrice(seq); // 프로젝트 펀딩받은 총 금액
				dto.setTotalPrice(totalPrice);
				projectList.add(dto);
			}

			req.setAttribute("projectList", projectList);
			req.setAttribute("categoryName", categoryName);
		}

		req.setAttribute("categoryseq", categoryseq);
		req.setAttribute("categoryList", categoryList);

		return "funding.fundmain";
	}

	@RequestMapping(value = "/funding/funding.action", method = { RequestMethod.GET })
	public String funding(HttpServletRequest req, HttpServletResponse resp, HttpSession session, String projectseq) {

		ProjectDTO project = dao.projectInfo(projectseq); // 프로젝트 정보
		List<String> projectImageList = dao.projectImageList(projectseq); // 프로젝트 이미지 리스트
		String projectTotalMember = dao.projectTotalMember(projectseq); // 프로젝트 총 후원자수
		String totalPrice = dao.totalPrice(projectseq); // 프로젝트 총 후원금액
		List<ProjectPackDTO> projectPackList = dao.projectPackList(projectseq); // 프로젝트 패키지 리스트
		List<String> genderList = dao.genderList(projectseq); // 프로젝트 후원자 성비 리스트
		List<ProjectAgeGroupDTO> ageGroupList = dao.ageGroupList(projectseq); // 프로젝트 후원자 연령대 리스트
		List<NoticeDTO> noticeList = dao.noticeList(projectseq); // 프로젝트 공지사항 리스트

		req.setAttribute("project", project);
		req.setAttribute("projectImageList", projectImageList);
		req.setAttribute("projectTotalMember", projectTotalMember);
		req.setAttribute("totalPrice", totalPrice);
		req.setAttribute("projectPackList", projectPackList);
		req.setAttribute("genderList", genderList);
		req.setAttribute("ageGroupList", ageGroupList);
		req.setAttribute("noticeList", noticeList);

		return "funding.funding";
	}

	@RequestMapping(value = "/funding/sendqa.action", method = { RequestMethod.POST })
	public void sendqa(HttpServletRequest req, HttpServletResponse resp, HttpSession session, QADTO dto,
			String projectSeq) {

		dao.sendQa(dto);

		try {
			resp.setContentType("text/html; charset=UTF-8");
			PrintWriter out = resp.getWriter();
			out.println("<script>alert('문의 내용이 전송되었습니다. :)'); location.href='/ot/funding/funding.action?projectseq=" + projectSeq + "';</script>");
			out.flush();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	@RequestMapping(value = "/funding/sendwarn.action", method = { RequestMethod.POST })
	public void sendwarn(HttpServletRequest req, HttpServletResponse resp, HttpSession session, String warnCategory, String content) {

		

	}

}