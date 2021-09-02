package com.project.ot.recfunding;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.project.ot.funding.NoticeDTO;
import com.project.ot.funding.ProjectDTO;

@Repository
public class RecDAO {

	@Autowired
	private SqlSessionTemplate template;

	@Autowired
	private SqlSession sqlSession;
	   //가계부 - 수입 목록
   public List<ExpenseDTO> inlist(String projectSeq) {
      
      return template.selectList("rec.inlist", projectSeq);
   }

   //가계부 - 지출 목록
   public List<ExpenseDTO> outlist(String projectSeq) {

      return template.selectList("rec.outlist", projectSeq);
   }
	//진행상황 목록
	public List<ProcessDTO> proclist(HashMap<String, String> map) {
		
		return template.selectList("recot.proclist", map);
	}

	//메인페이지 프로젝트 목록
	public List<ProjectDTO> projlist(String id) {
		
		return template.selectList("recot.projlist", id);
	}

	//공지사항 목록
	public List<NoticeDTO> noticelist(String projectSeq) {
		return template.selectList("recot.noticelist", projectSeq);
	}

	public void noticeaddok(NoticeDTO noticedto) {
		
		template.insert("recot.noticeaddok", noticedto);
	}

	//문의사항
	public List<MessageDTO> messageList(MessageDTO messagedto) {

		//현재사용자 seq와 프로젝트seq받아오기
		String myMember = messagedto.getMyMember();
		
		
		//System.out.println(myMember);
		
		//메세지 리스트에 나타낼것들 가져오기 -가장 최근메세지, 보낸사람 profile사진, 보낸사람id
		List<MessageDTO> mlist = template.selectList("recot.messageList", messagedto);
		
		
		for(MessageDTO dto : mlist) {
			
			dto.setMyMember(myMember);
			
			//현재사용자가 해당 room에서 안읽은 메세지의 수 가져오기
			int unread = template.selectOne("recot.countRead",dto);
			
			//현재 사용자가 메세지를 주고받는 상대 profile 가져오기
			String profile = template.selectOne("recot.getProfile",dto);
			
			//안읽은 메세지 갯수를 저장하기,프로필사진set하기
			dto.setUnread(unread);
			dto.setProfileImage(profile);
			
			//보내는이와 현재사용자가 동일하면 다른사용자에게 받는이라고 setting하기
			if(myMember.equals(dto.getFromMemberSeq())) {
				dto.setOtherMember(dto.getToMemberSeq());;
			} else {
				dto.setOtherMember(dto.getFromMemberSeq());
			}
		}
		
		return mlist;
	}

	//방번호별 메세지 가져오기
	public List<MessageDTO> roomContentList(MessageDTO messagedto) {
		
		System.out.println("room: " + messagedto.getRoom());
		System.out.println("toMemberSeq: " + messagedto.getToMemberSeq());
		System.out.println("myMember: " + messagedto.getMyMember());
		
		//메세지 내역 가져오기
		List<MessageDTO> clist = template.selectList("room_content_list", messagedto);
		
		//해당방의 메세지들 중 받는 사람이 현재 사용자의 nick인 메세지를 모두 읽은 처리한다. 
		template.update("message_readchk", messagedto);
		
		return clist;
	}

	//특정방에서 메세지 보내기
	public int messageSendInList(MessageDTO messagedto) {
		
		System.out.println("room: " + messagedto.getRoom());
		System.out.println("받는이: " + messagedto.getToMemberSeq());
		System.out.println("보내는이: " + messagedto.getFromMemberSeq());
		System.out.println("프로젝트번호: " + messagedto.getProjectSeq());
		//메세지 리시트에서 보낸건지 프로필에서 보낸건지 구분하기위함
		int flag = template.insert("messageSendInList", messagedto);
		
		return flag;
	}

	/*
	 * public void addprocess(EmailDTO edto) {
	 * 
	 * template.insert("recot.addprocess", edto); }
	 */

}
