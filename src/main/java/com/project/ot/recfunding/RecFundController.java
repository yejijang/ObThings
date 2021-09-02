package com.project.ot.recfunding;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.project.ot.funding.FundingDAO;
import com.project.ot.funding.NoticeDTO;
import com.project.ot.funding.ProjectDTO;
import com.project.ot.funding.ProjectMemberDTO;
import com.project.ot.funding.ProjectPackDTO;

@Controller
public class RecFundController {

	@Autowired
	private RecDAO dao;
	@Autowired
	private FundingDAO fdao;
	@Inject
	EmailService emailService; // 서비스를 호출하기위한 의존성 주입

	// 펀딩받기 메인페이지 + 나의 프로젝트 리스트
	@RequestMapping(value = "/recfunding/recmain.action", method = { RequestMethod.GET })
	public String recmain(HttpServletRequest req, HttpServletResponse resp, HttpSession session) {

		// 세션에서 아이디 받아오기
		String id = session.getAttribute("id").toString();

		// 해당 아이디의 프로젝트 목록 가져오기
		List<ProjectDTO> projlist = dao.projlist(id);

		// 글자 자르기
		for (ProjectDTO dto : projlist) {

			String detail = dto.getDetail();
			if (detail.length() > 65)
				detail = detail.substring(0, 64) + "...";

			dto.setDetail(detail);
		}

		req.setAttribute("projlist", projlist);

		return "recfunding.recmain";
	}

	// 프로젝트 관리하기 메인페이지
	@RequestMapping(value = "/recfunding/recproject.action", method = { RequestMethod.GET })
	public String recproject(HttpServletRequest req, HttpServletResponse resp, HttpSession session, String projectSeq) {

		ProjectDTO project = fdao.projectInfo(projectSeq); // 프로젝트 정보
		List<String> projectImageList = fdao.projectImageList(projectSeq); // 프로젝트 이미지 리스트
		String projectTotalMember = fdao.projectTotalMember(projectSeq); // 프로젝트 총 후원자수
		String totalPrice = fdao.totalPrice(projectSeq); // 프로젝트 총 후원금액
		List<ProjectPackDTO> projectPackList = fdao.projectPackList(projectSeq); // 프로젝트 패키지 리스트
		List<ProjectMemberDTO> genderList = fdao.genderList(projectSeq); // 프로젝트 후원자 성비 리스트
		List<ProjectMemberDTO> ageGroupList = fdao.ageGroupList(projectSeq); // 프로젝트 후원자 연령대 리스트
		List<NoticeDTO> noticeList = fdao.noticeList(projectSeq); // 프로젝트 공지사항 리스트

		req.setAttribute("project", project);
		req.setAttribute("projectImageList", projectImageList);
		req.setAttribute("projectTotalMember", projectTotalMember);
		req.setAttribute("totalPrice", totalPrice);
		req.setAttribute("projectPackList", projectPackList);
		req.setAttribute("genderList", genderList);
		req.setAttribute("ageGroupList", ageGroupList);
		req.setAttribute("noticeList", noticeList);
		req.setAttribute("projectSeq", projectSeq);
		return "recfunding.recproject";
	}

	// 프로젝트 관라하기 > 전체문의함
	@RequestMapping(value = "/recfunding/message_list.action", method = { RequestMethod.GET })
	public String message_list(HttpServletRequest req, HttpServletResponse resp, HttpSession session, String projectSeq,
			String memberSeq) {

		// 세션에서 아이디 받아오기
		// System.out.println(session.getAttribute("memberSeq").toString());

		String myMember = session.getAttribute("memberSeq").toString();
		MessageDTO mdto = new MessageDTO();

		// 현재 나의 id 세팅하기
		mdto.setMyMember(myMember);
		mdto.setProjectSeq(projectSeq);

		// System.out.println(mdto.getMyMember());

		// 메세지 리스트
		List<MessageDTO> mlist = dao.messageList(mdto);

		req.setAttribute("messagelist", mlist);
		req.setAttribute("projectSeq", projectSeq);
		req.setAttribute("memberSeq", memberSeq);

		return "recfunding.message_list";
	}

	// 프로젝트 관라하기 > 전체문의함
	@RequestMapping(value = "/recfunding/message_ajax_list.action", method = { RequestMethod.GET })
	public String message_ajax_list(HttpServletRequest req, HttpServletResponse resp, HttpSession session,
			String projectSeq, String memberSeq) {

		// 세션에서 아이디 받아오기
		String myMember = session.getAttribute("memberSeq").toString();
		MessageDTO mdto = new MessageDTO();
		// 현재 나의 id 세팅하기
		mdto.setMyMember(myMember);
		mdto.setProjectSeq(projectSeq);

		// 메세지 리스트
		List<MessageDTO> mlist = dao.messageList(mdto);

		req.setAttribute("messagelist", mlist);
		req.setAttribute("projectSeq", projectSeq);
		req.setAttribute("memberSeq", memberSeq);
		System.out.println(projectSeq);

		return "message_ajax_list";
	}

	// 프로젝트 관라하기 > 전체문의함 > 특정 대화방 메세지조회
	@RequestMapping(value = "/recfunding/message_content_list.action", method = { RequestMethod.GET })
	public String message_content_list(HttpServletRequest req, HttpServletResponse resp, HttpSession session,
			String projectSeq, String memberSeq) {

		String myMember = session.getAttribute("memberSeq").toString();
		int room = Integer.parseInt(req.getParameter("room"));
		System.out.println(room);

		MessageDTO mdto = new MessageDTO();
		mdto.setRoom(room);
		mdto.setMyMember(myMember);

		// 메세지 내용 가져오기
		List<MessageDTO> clist = dao.roomContentList(mdto);
		System.out.println("프로젝트번호 특정방 조회시:" + projectSeq);
		req.setAttribute("projectSeq", projectSeq);
		req.setAttribute("memberSeq", memberSeq);
		req.setAttribute("clist", clist);
		return "message_content_list";
	}

	// message_send_inlist.action
	// 프로젝트 관라하기 > 전체문의함 > 특정 대화방 메세지조회ㅊ
	@ResponseBody
	@RequestMapping(value = "/recfunding/message_send_inlist.action", method = { RequestMethod.GET })
	public int message_send_inlist(HttpServletRequest req, HttpServletResponse resp, HttpSession session,
			String projectSeq, String memberSeq, int room, String other_nick, String content) {

		MessageDTO messagedto = new MessageDTO();
		messagedto.setRoom(room);
		messagedto.setFromMemberSeq(memberSeq);
		messagedto.setToMemberSeq(other_nick);
		messagedto.setContent(content);
		messagedto.setProjectSeq(projectSeq);

		int flag = dao.messageSendInList(messagedto);

		req.setAttribute("projectSeq", projectSeq);
		req.setAttribute("memberSeq", memberSeq);
		return flag;
	}

	// 프로젝트 관라하기 > 공지사항
	@RequestMapping(value = "/recfunding/noticelist.action", method = { RequestMethod.GET })
	public String noticelist(HttpServletRequest req, HttpServletResponse resp, HttpSession session, String projectSeq) {

		List<NoticeDTO> noticelist = dao.noticelist(projectSeq);

		// 날짜짜르기
		for (NoticeDTO dto : noticelist) {

			String regDate = dto.getRegdate().substring(0, 10);
			dto.setRegdate(regDate);
		}

		req.setAttribute("projectSeq", projectSeq);
		req.setAttribute("noticelist", noticelist);

		return "recfunding.noticelist";
	}

	// 프로젝트 관라하기 > 공지사항 > 공지사항 작성하기
	@RequestMapping(value = "/recfunding/noticeadd.action", method = { RequestMethod.GET })
	public String noticeadd(HttpServletRequest req, HttpServletResponse resp, HttpSession session, String projectSeq) {

		req.setAttribute("projectSeq", projectSeq);
		return "recfunding.noticeadd";
	}

	// 프로젝트 관라하기 > 공지사항 > 공지사항 작성하기
	@RequestMapping(value = "/recfunding/noticeaddok.action", method = { RequestMethod.POST })
	public void noticeaddok(HttpServletRequest req, HttpServletResponse resp, HttpSession session,
			NoticeDTO noticedto) {

		System.out.println(noticedto.getProjectSeq());
		System.out.println(noticedto.getSubject());
		System.out.println(noticedto.getContent());
		dao.noticeaddok(noticedto);

		try {
			resp.sendRedirect("/ot/recfunding/noticelist.action?projectSeq=" + noticedto.getProjectSeq());
		} catch (IOException e) {
			e.printStackTrace();
			System.out.println("공지사항 추가 오류");
		}
	}

	// 프로젝트 관라하기 > 진행상황
	@RequestMapping(value = "/recfunding/processlist.action", method = { RequestMethod.GET })
	public String processlist(HttpServletRequest req, HttpServletResponse resp, HttpSession session,
			String projectSeq) {

		// 세션에서 아이디 받아오기
		String memberSeq = session.getAttribute("memberSeq").toString();

		HashMap<String, String> map = new HashMap<String, String>();
		map.put("memberSeq", memberSeq);
		map.put("projectSeq", projectSeq);

		// 진행상황 목록
		List<ProcessDTO> proclist = dao.proclist(map);

		for (ProcessDTO dto : proclist) {
			// 0-9까지
			String regDate = dto.getRegDate().substring(0, 10);
			dto.setRegDate(regDate);

		}

		System.out.println(projectSeq);

		req.setAttribute("projectSeq", projectSeq);
		req.setAttribute("proclist", proclist);
		return "recfunding.processlist";
	}

	// 이메일 쓰기를 누르면 이 메소드로 맵핑되어서
	@RequestMapping(value = "/recfunding/write.action", method = { RequestMethod.GET })
	public String write(HttpServletRequest req, HttpServletResponse resp, HttpSession session, String projectSeq) {

		req.setAttribute("projectSeq", projectSeq);

		return "recfunding.write";
		// 다시 write jsp 페이지로 이동하고 jsp페이지에서 내용을 다 채운 뒤에 확인 버튼을 누르면 send.action로 넘어감
	}

	// 확인 (메일발송) 버튼을 누르면 맵핑되는 메소드
	@RequestMapping(value = "/recfunding/send.action", method = { RequestMethod.POST })
	public String send(@ModelAttribute EmailDTO dto, Model model, HttpServletRequest req, HttpServletResponse resp,
			HttpSession session, String projectSeq) {

		try {

			emailService.sendMail(dto); // dto (메일관련 정보)를 sendMail에 저장함
//	            dao.addprocess(dto);
			model.addAttribute("message", "이메일이 발송되었습니다.");
			// 이메일이 발송되었다는 메시지를 출력시킨다.

		} catch (Exception e) {
			e.printStackTrace();
			model.addAttribute("message", "이메일 발송 실패..."); // 이메일 발송이 실패되었다는 메시지를 출력
		}

		req.setAttribute("projectSeq", projectSeq);
		return "recfunding.write"; // 실패했으므로 다시 write jsp 페이지로 이동함
	}

	// 참여한 후원자 정보
	@RequestMapping(value = "/recfunding/sponsorinfo.action", method = { RequestMethod.GET })
	public String sponsorinfo(HttpServletRequest req, HttpServletResponse resp, HttpSession session,
			String projectSeq) {

		// json으로 데이터 받아와서 그래프에 넣어주기 ...

		req.setAttribute("projectSeq", projectSeq);
		return "recfunding.sponsorinfo";
	}

	// 참여한 후원자 정보 > 후원자 목록 자세히 보기
	@RequestMapping(value = "/recfunding/sponsorlist.action", method = { RequestMethod.GET })
	public String sponsorlist(HttpServletRequest req, HttpServletResponse resp, HttpSession session,
			String projectSeq) {

		// 세션에서 아이디 받아오기
		String memberSeq = session.getAttribute("memberSeq").toString();

		req.setAttribute("projectSeq", projectSeq);
		req.setAttribute("memberSeq", memberSeq);
		return "recfunding.sponsorlist";
	}

	// 가계부
	@RequestMapping(value = "/recfunding/ledger.action", method = { RequestMethod.GET })
	public String ledger(HttpServletRequest req, HttpServletResponse resp, HttpSession session, String projectSeq) {

		// 수입 목록
		List<ExpenseDTO> inlist = dao.inlist(projectSeq);

		// 지출 목록
		List<ExpenseDTO> outlist = dao.outlist(projectSeq);

		req.setAttribute("inlist", inlist);
		req.setAttribute("outlist", outlist);
		req.setAttribute("projectSeq", projectSeq);
		return "recfunding.ledger";
	}
}