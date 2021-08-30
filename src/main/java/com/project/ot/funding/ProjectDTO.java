package com.project.ot.funding;

import lombok.Data;

@Data
public class ProjectDTO {

	private String projectSeq;
	private String name;
	private String startDate;
	private String endDate;
	private String teamName;
	private String detail;
	private String thumImage;
	private String target;
	private String searchTag;
	private String status;
	private String content;
	private String memberSeq;
	private String deleteOk;
	private String categorySeq;
	
	private String userName; // 창작자 이름
	private String meanTime; // 펀딩 남은 기간
	private String totalPrice; // 펀딩받은 총 금액
	
	private String categoryName; // 카테고리명
	
}