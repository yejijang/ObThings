package com.project.ot.schedule;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;


@Controller
public class ScheduleController {
	
//	@Autowired
//	private ScheduleDAO dao;
	
	@RequestMapping(value = "/schedule/schedule.action", method = { RequestMethod.GET })
	public String schedule(HttpServletRequest req, HttpServletResponse resp, HttpSession session) {

//		//세션에서 아이디 받아오기
//		String id = session.getAttribute("id").toString();
//		
//		// 해당 아이디의 창작 리스트 목록 가져오기
//		List<ScheduleDTO> makelist = dao.makelist(id);
//		
//		req.setAttribute("makelist", makelist);
		
		return "schedule.schedule";
	}
	
}
