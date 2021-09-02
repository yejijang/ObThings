package com.project.ot.auction;

import java.io.File;
import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.project.ot.MemberDTO;

@Controller
public class OtAuctionController {

	@Autowired
	private OtAuctionDAO dao;

	@RequestMapping(value = "/auction/auction.action", method = { RequestMethod.GET })
	public String action(HttpServletRequest req, HttpServletResponse resp, HttpSession session) {

		List<OtAuctionDTO> list = dao.scheduleAuction();
		
		for(int i=0;i<list.size();i++) {
			list.get(i).setStartTime(list.get(i).getStartTime().substring(0,10));
		}
		
		String memberSeq = (String)session.getAttribute("membserSeq");
		
		req.setAttribute("memberSeq", memberSeq);
		req.setAttribute("nowList", list.get(0));
		list.remove(0);
		req.setAttribute("list", list);

		return "auction.auction";
	}

	@RequestMapping(value = "/auction/realAuction.action", method = { RequestMethod.GET })
	public String realAuction(HttpServletRequest req, HttpServletResponse resp, HttpSession session,
			String auctionSeq) {
		
		OtAuctionDTO dto = dao.nowList(auctionSeq);
		dto.setStartTime(dto.getStartTime().substring(0,10));
		dto.setEndTime(dto.getEndTime().substring(0,10));
		String maxBiddingPrice = dao.maxBiddingPrice(auctionSeq);

		MemberDTO mdto = new MemberDTO();
		mdto.setMemberSeq((String) session.getAttribute("memberSeq"));
		mdto.setNickName((String) session.getAttribute("nickName"));

		if (maxBiddingPrice == null) {
			req.setAttribute("biddingPrice", dto.getStartPrice());
		} else {
			int biddingPrice = Integer.parseInt(maxBiddingPrice) + Integer.parseInt(dto.getUnitPrice());
			req.setAttribute("biddingPrice", biddingPrice);
		}

		req.setAttribute("dto", dto);
		req.setAttribute("mdto", mdto);

		return "auction.realAuction";

	}

	@RequestMapping(value = "/auction/auctionAdd.action", method = { RequestMethod.GET })
	public String auctionAdd(HttpServletRequest req, HttpServletResponse resp, HttpSession session, String startTime) {

		return "auction.auctionAdd";
	}

	@RequestMapping(value = "/auction/dateComfirm.action", method = { RequestMethod.POST })
	@ResponseBody
	public int dateComfirm(HttpServletRequest req, HttpServletResponse resp, HttpSession session, String startTime) {

		List<OtAuctionDTO> list = dao.scheduleAuction();
		int result = 0;

		for (OtAuctionDTO dto : list) {
			if (dto.getStartTime().substring(0, 10).equals(startTime)) {
				result = 1;
				break;
			} else {
				result = 0;
			}
		}

		return result;

	}

	@RequestMapping(value = "/auction/auctionAddOk.action", method = { RequestMethod.POST })
	public void auctionAddOk(@RequestParam MultipartFile[] uploadFile, HttpServletRequest req, HttpServletResponse resp,
			HttpSession session, Model model, String name, String startTime, String startPrice, String unitPrice,
			String content) throws IOException, ParseException {

		Calendar cal = Calendar.getInstance();
		SimpleDateFormat fm = new SimpleDateFormat("yyyy-MM-dd");
		Date start = fm.parse(startTime);
		cal.setTime(start);
		fm.format(cal.getTime());

		HashMap<String, String> map = new HashMap<String, String>();
		map.put("name", name);

		map.put("startTime", fm.format(cal.getTime()));
		cal.add(Calendar.DATE, 1);
		map.put("endTime", fm.format(cal.getTime()));
		map.put("startPrice", startPrice);
		map.put("unitPrice", unitPrice);
		map.put("content", content);

		// D:\Study\Sist_Class\spring\.metadata\.plugins\org.eclipse.wst.server.core\tmp0\work\Catalina\localhost\ot\..\resources\img\
		// D:\Study\Sist_Class\spring\.metadata\.plugins\org.eclipse.wst.server.core\tmp0\wtpwebapps\ObjectThings\auctionAddOk
		// D:\Study\Sist_Class\spring\.metadata\.plugins\org.eclipse.wst.server.core\tmp0\wtpwebapps\ObjectThings\resources\img
		/* String path ="../resources/img/"; */
//		String path = "D:\\Study\\Sist_Class\\spring\\ObjectThings\\src\\main\\webapp\\resources\\img";
		String path = req.getSession().getServletContext().getRealPath("\\resources\\img\\projectimage");
		System.out.println(path);
		if (!(uploadFile.length == 0)) {
			uploadFile[0].transferTo(new File(path, uploadFile[0].getOriginalFilename()));
			map.put("thumImage", uploadFile[0].getOriginalFilename());
			for (int i = 1; i < uploadFile.length; i++) {
				map.put("images", uploadFile[i].getOriginalFilename());
			}
		}

		dao.add(map);

		try {
			resp.sendRedirect("/ot/auction/auction.action");
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

	}

	@RequestMapping(value = "/auction/bidding.action", method = { RequestMethod.POST })
	@ResponseBody
	public OtAucListDTO auctionBid(HttpServletRequest req, HttpServletResponse resp, HttpSession session,
			String auctionSeq, String biddingPrice, String memberSeq) throws IOException {

		OtAucListDTO ldto = new OtAucListDTO();
		ldto.setAuctionSeq(auctionSeq);
		ldto.setMemberSeq(memberSeq);
		ldto.setBiddingPrice(biddingPrice);

		HashMap<String, String> map = new HashMap<String, String>();
		map.put("auctionSeq", auctionSeq);
		map.put("memberSeq", memberSeq);

		if ((dao.comfirmBidding(biddingPrice)) == null) {
			if (dao.aucList(map) == null) {
				ldto.setAucListSeq("");
				ldto.setStatus("");
				ldto.setRegdate("");
				dao.addActList(ldto);
			} else {
				dao.updateActList(ldto);
			}
			return ldto;
		} else {
			return null;
		}

		/*
		 * resp.sendRedirect("/ot/auction/realAuction.action?auctionSeq="+ auctionSeq);
		 */

	}

	@RequestMapping(value = "/auction/endauction.action", method = { RequestMethod.GET })
	public String endauction(HttpServletRequest req, HttpServletResponse resp, HttpSession session) {
		
		List<OtAuctionDTO> dto = dao.endAuction();
		for(int i=0; i<dto.size();i++) {
			dto.get(i).setStartTime(dto.get(i).getStartTime().substring(0, 10));
			dto.get(i).setEndTime(dto.get(i).getEndTime().substring(0, 10));
		}
		req.setAttribute("dto", dto);
		return "auction.endAuction";
	}
	
	@RequestMapping(value = "/auction/endDetailAuction.action", method = { RequestMethod.GET })
	public String endDetailAuction(HttpServletRequest req, HttpServletResponse resp, HttpSession session,
			String auctionSeq) {

		OtAuctionDTO dto = dao.nowList(auctionSeq);
		dto.setStartTime(dto.getStartTime().substring(0,10));
		dto.setEndTime(dto.getEndTime().substring(0,10));

		MemberDTO mdto = new MemberDTO();
		mdto.setMemberSeq((String) session.getAttribute("memberSeq"));
		mdto.setNickName((String) session.getAttribute("nickName"));
		
		OtAuctionBiddingInfoDTO idto = dao.aucPeopleTotal(auctionSeq);
		
		
		String nickName = "";
		if(dao.biddingNick(auctionSeq) == null) {
			nickName = "-";
		} else {
			nickName = dao.biddingNick(auctionSeq);
		}
		
		req.setAttribute("idto", idto);
		req.setAttribute("nickName", nickName);
		req.setAttribute("dto", dto);
		req.setAttribute("mdto", mdto);

		return "auction.endDetailAuction";
	}

}
