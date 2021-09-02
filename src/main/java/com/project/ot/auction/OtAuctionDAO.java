package com.project.ot.auction;

import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class OtAuctionDAO {

	@Autowired
	private SqlSessionTemplate template;

	public OtAuctionDTO nowList(String auctionSeq) {
		// TODO Auto-generated method stub
		return template.selectOne("otauction.nowauction",auctionSeq);
	}

	public void add(HashMap<String, String> map) {
		// TODO Auto-generated method stub
		
		template.insert("otauction.add",map);
		
	}

//	public MemberDTO member(String memSeq) {
//		// TODO Auto-generated method stub
//		return template.selectOne("otauction.mem",memSeq);
//		
//	}

	public OtAucListDTO aucList(HashMap<String, String> map) {
		// TODO Auto-generated method stub
		return template.selectOne("otauction.aucList",map);
	}

	public String maxBiddingPrice(String auctionSeq) {
		// TODO Auto-generated method stub
		return template.selectOne("otauction.maxBiddingPrice",auctionSeq);
		
	}

	public void addActList(OtAucListDTO ldto) {
		// TODO Auto-generated method stub
		
		template.insert("otauction.addActList",ldto);
		
	}

	public void updateActList(OtAucListDTO ldto) {
		// TODO Auto-generated method stub
		template.update("otauction.updateActList",ldto);
	}

	public String comfirmBidding(String biddingPrice) {
		// TODO Auto-generated method stub
		return template.selectOne("otauction.comfirmActList",biddingPrice);
	}


	public List<OtAuctionDTO> scheduleAuction() {
		// TODO Auto-generated method stub
		return template.selectList("otauction.scheduleAuction");
	}
	
	public List<OtAuctionDTO> endAuction() {
		// TODO Auto-generated method stub
		return template.selectList("otauction.endAuction");
	}

	public OtAuctionBiddingInfoDTO aucPeopleTotal(String auctionSeq) {
		// TODO Auto-generated method stub
		return template.selectOne("otauction.aucPeopleTotal",auctionSeq);
	}
	
	public String biddingNick(String auctionSeq) {
		// TODO Auto-generated method stub
		return template.selectOne("otauction.biddingNick",auctionSeq);
	}

	
}
