package com.project.ot.recfunding;

public class MessageDTO {
	
	private String qaSeq2;
	private int room;
	private String fromMemberSeq;
	private String toMemberSeq;
	private String sendTime;
	private String readTime;
	private String content;
	private String readchk;
	private String projectSeq;
	private String nickName;
	
	//현재 사용자의 메세지 상대 mem담기
	private String otherMember;
	
	//현재 사용자의 메세지 상대 profile을 담기
	private String profileImage;
	
	//현재 사용자 mem담기
	private String myMember;
	
	//안읽은 메세지 갯수
	private int unread;

	public String getQaSeq2() {
		return qaSeq2;
	}

	public void setQaSeq2(String qaSeq2) {
		this.qaSeq2 = qaSeq2;
	}

	public int getRoom() {
		return room;
	}

	public void setRoom(int room) {
		this.room = room;
	}

	public String getFromMemberSeq() {
		return fromMemberSeq;
	}

	public void setFromMemberSeq(String fromMemberSeq) {
		this.fromMemberSeq = fromMemberSeq;
	}

	public String getToMemberSeq() {
		return toMemberSeq;
	}

	public void setToMemberSeq(String toMemberSeq) {
		this.toMemberSeq = toMemberSeq;
	}

	public String getSendTime() {
		return sendTime;
	}

	public void setSendTime(String sendTime) {
		this.sendTime = sendTime;
	}

	public String getReadTime() {
		return readTime;
	}

	public void setReadTime(String readTime) {
		this.readTime = readTime;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getReadchk() {
		return readchk;
	}

	public void setReadchk(String readchk) {
		this.readchk = readchk;
	}

	public String getProjectSeq() {
		return projectSeq;
	}

	public void setProjectSeq(String projectSeq) {
		this.projectSeq = projectSeq;
	}

	public String getOtherMember() {
		return otherMember;
	}

	public void setOtherMember(String otherMember) {
		this.otherMember = otherMember;
	}

	

	public String getMyMember() {
		return myMember;
	}

	public void setMyMember(String myMember) {
		this.myMember = myMember;
	}

	public int getUnread() {
		return unread;
	}

	public void setUnread(int unread) {
		this.unread = unread;
	}

	public String getProfileImage() {
		return profileImage;
	}

	public void setProfileImage(String profileImage) {
		this.profileImage = profileImage;
	}

	public String getNickName() {
		return nickName;
	}

	public void setNickName(String nickName) {
		this.nickName = nickName;
	}


	
	
	
	

}
