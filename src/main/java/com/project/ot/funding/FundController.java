package com.project.ot.funding;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;
import java.util.Locale;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.project.ot.MemberDTO;
import com.siot.IamportRestClient.IamportClient;
import com.siot.IamportRestClient.exception.IamportResponseException;
import com.siot.IamportRestClient.response.IamportResponse;
import com.siot.IamportRestClient.response.Payment;

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

		if (session.getAttribute("memberSeq") != null) {
			String memberSeq = session.getAttribute("memberSeq").toString(); // 로그인한 유저(세션)

			List<String> projectLikeList = dao.projectLike(projectseq);
			
			if (projectLikeList.size() != 0) {
				for (String seq : projectLikeList) {
					if (seq.equals(memberSeq)) {
						req.setAttribute("projectLike", "1");
						break;
					} else {
						req.setAttribute("projectLike", "0");
					}
				}
			} else {
				req.setAttribute("projectLike", "0");
			}	
			
		}

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
			out.println("<script>alert('문의 내용이 전송되었습니다. :)'); location.href='/ot/funding/funding.action?projectseq="
					+ projectSeq + "';</script>");
			out.flush();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	@RequestMapping(value = "/funding/sendwarn.action", method = { RequestMethod.POST })
	public void sendwarn(HttpServletRequest req, HttpServletResponse resp, HttpSession session, String warnCategory,
			String content, WarningDTO dto, String projectSeq) {

		dao.sendWarn(dto);

		try {
			resp.setContentType("text/html; charset=UTF-8");
			PrintWriter out = resp.getWriter();
			out.println("<script>alert('신고 내용이 전송되었습니다. :)'); location.href='/ot/funding/funding.action?projectseq="
					+ projectSeq + "';</script>");
			out.flush();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	@RequestMapping(value = "/funding/fundpayment.action", method = { RequestMethod.GET })
	public String fundpayment(HttpServletRequest req, HttpServletResponse resp, HttpSession session, String projectSeq,
			String packageSeq) {

		String memberSeq = session.getAttribute("memberSeq").toString(); // 로그인한 유저(세션)

		ProjectDTO project = dao.projectInfo(projectSeq); // 프로젝트 정보
		String totalPrice = dao.totalPrice(projectSeq); // 프로젝트 총 후원금액
		ProjectPackDTO projectPack = dao.projectPack(packageSeq); // 프로젝트 패키지 정보
		MemberDTO member = dao.memberInfo(memberSeq);

		req.setAttribute("project", project);
		req.setAttribute("totalPrice", totalPrice);
		req.setAttribute("projectPack", projectPack);
		req.setAttribute("member", member);

		return "funding.fundpayment";
	}

	// PG사 결과값을 서버로 보내, 아임포트 토큰을 발행하고 결과값 리턴
	@ResponseBody
	@RequestMapping(value = "/funding/verifyIamport.action", method = { RequestMethod.POST })
	public IamportResponse<Payment> paymentByImpUid(Model model, Locale locale, HttpSession session, String imp_uid)
			throws IamportResponseException, IOException {
		IamportClient api = new IamportClient("1289306036777188",
				"NOW9AZUKgJJFPpJa3tUNAIDXM3AFf0h2Odcpd69tQS8FhSQllK8VtMTgQuV5ud8irkIErR7hKgX18Ont");

		return api.paymentByImpUid(imp_uid);
	}

	// 결제 이후 펀딩내역 추가
	@RequestMapping(value = "/funding/paycomplete.action", method = { RequestMethod.POST })
	@ResponseBody
	public void paycomplete(HttpServletRequest req, HttpServletResponse resp, HttpSession session, String imp_uid,
			FundingDTO dto) {

		dao.paycomplete(dto);
	}
	
	@RequestMapping(value = "/funding/dellike.action", method = { RequestMethod.POST })
	@ResponseBody
	public int dellike(HttpServletRequest req, HttpServletResponse resp, HttpSession session, LikeDTO dto) {

		System.out.println(dto.getMemberSeq());
		System.out.println(dto.getProjectSeq());

		return dao.dellike(dto);
	}
	
	@RequestMapping(value = "/funding/addlike.action", method = { RequestMethod.POST })
	@ResponseBody
	public int addlike(HttpServletRequest req, HttpServletResponse resp, HttpSession session, LikeDTO dto) {


		return dao.addlike(dto);
	}

}