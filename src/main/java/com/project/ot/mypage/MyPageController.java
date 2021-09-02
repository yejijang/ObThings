package com.project.ot.mypage;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.project.ot.recfunding.ProcessDTO;



@Controller
public class MyPageController {

	
	@Autowired
	private MyPageDAO dao;
	
	 @RequestMapping(value = "/mypage/mpmain.action", method = { RequestMethod.GET })
	public String like(HttpServletRequest req, HttpServletResponse resp, HttpSession session) {
	
		//세션에서 멤버 시퀀스 받아오기 
		 String memberSeq = session.getAttribute("memberSeq").toString();
		 
		 //찜한 게시글 목록..
			List<MyLikeDTO> likelist = dao.likelist(memberSeq);
		
			req.setAttribute("likelist", likelist);
			
			List<MyFundingDTO> fundlist = dao.fundlist(memberSeq);
			
			req.setAttribute("fundlist", fundlist);

			System.out.println(fundlist);
			
		return "mypage.mpmain";
	 }
	 
	 
	 @RequestMapping(value = "/mypage/like.action", method = { RequestMethod.GET})
		public String likelist (HttpServletRequest req, HttpServletResponse resp, HttpSession session) {
			
		 
		 String memberSeq = session.getAttribute("memberSeq").toString();
		 
		 
		 	List<MyLikeDTO> likelist = dao.likelist(memberSeq);
			
			req.setAttribute("likelist", likelist);
			
			
			return "mypage.like";
			
		}
	 
	 
	 @RequestMapping(value = "/mypage/fund.action", method = { RequestMethod.GET})
		public String fundlist (HttpServletRequest req, HttpServletResponse resp, HttpSession session) {
			
		 
		 String memberSeq = session.getAttribute("memberSeq").toString();
		 
		 
		 	List<MyFundingDTO> fundlist = dao.fundlist(memberSeq);
		 
		 
			req.setAttribute("fundlist", fundlist);
			
			
			return "mypage.fund";
			
		}
		
	 
	 @RequestMapping(value = "/mypage/detailfund.action", method = { RequestMethod.GET})
		public String detailfund(HttpServletRequest req, HttpServletResponse resp, HttpSession session,String projectSeq) {
			
		 
		 String memberSeq = session.getAttribute("memberSeq").toString();
		 
		 
		 	List<MyFundingDTO> fundlist = dao.fundlist(memberSeq);
		 
		 	
		 	for (MyFundingDTO dto : fundlist) {
				
				String regdate = dto.getRegdate().substring(0,10);
				
				dto.setRegdate(regdate);
				
			}
		 	
		 	
		 
			req.setAttribute("fundlist", fundlist);
			
			
			return "mypage.detailfund";
			
		}
		
	 
	
}
