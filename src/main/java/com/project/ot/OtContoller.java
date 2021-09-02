package com.project.ot;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.project.ot.funding.ProjectDTO;

@Controller
public class OtContoller {

	@Autowired
	private OtDAO dao;

	@RequestMapping(value = "/main/main.action", method = { RequestMethod.GET })
	public String main(HttpServletRequest req, HttpServletResponse resp, HttpSession session) {

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

		return "main.main";
	}

	@RequestMapping(value = "/main/signin.action", method = { RequestMethod.GET })
	public String signin(HttpServletRequest req, HttpServletResponse resp, HttpSession session) {

		return "main.signin";

	}

	@RequestMapping(value = "/main/signin.action", method = { RequestMethod.POST })
	public void signin(HttpServletRequest req, HttpServletResponse resp, HttpSession session, String id,
			String password) {

		// 1. 데이터 가져오기(pw)
		// 2. DB 작업
		// 3. 인증티켓 발급
		// 4. 결과 처리
		HashMap<String, String> map = new HashMap<String, String>();

		map.put("id", id);
		map.put("password", password);

		MemberDTO signOk = dao.signin(map);

		String name = signOk.getName();
		String email = signOk.getEmail();
		String memberSeq = signOk.getMemberSeq();
		String nickName = signOk.getNickName();
		String point = signOk.getPoint();
		String profileimage = signOk.getProfileimage();

		session.setAttribute("id", id);
		session.setAttribute("password", password);
		session.setAttribute("name", name);
		session.setAttribute("email", email);
		session.setAttribute("memberSeq", memberSeq);
		session.setAttribute("nickName", nickName);
		session.setAttribute("point", point);
		session.setAttribute("profileimage", profileimage);

		System.out.println(memberSeq);

		try {
			resp.sendRedirect("/ot/main/main.action");
		} catch (IOException e) {
			e.printStackTrace();
		}

	}

	@RequestMapping(value = "/main/signout.action", method = { RequestMethod.GET })
	public void signout(HttpServletRequest req, HttpServletResponse resp, HttpSession session) {

		session.removeAttribute("id"); // 인증티켓 제거
		session.removeAttribute("password");
		session.removeAttribute("name");
		session.removeAttribute("email");
		session.removeAttribute("memberSeq");

		// 4
		try {
			resp.sendRedirect("/ot/main/main.action");
		} catch (IOException e) {
			e.printStackTrace();
		}

	}

}