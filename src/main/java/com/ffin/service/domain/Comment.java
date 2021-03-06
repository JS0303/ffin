package com.ffin.service.domain;


import java.sql.Timestamp;
import java.util.Date;

import lombok.Data;

@Data
public class Comment {
	
	private int commentNo;
	private int commentPostNo;
	private String commentContent;
	private String commentUserId;
	private String commentUserProImg;	// 코멘트유저프로필이미지 추가
	private String commentTruckId;
	private String commentTruckProImg;	// 코멘트트럭 프로필이미지 추가
	private String commentDate;
	private int secretKey;

	//HHJ
	private int grp; //댓글이 속한 댓글 번호
	private int grps; // 같은 grp중의 순서
	private int grpl; // 모댓글 - 0 / 답글 - 1

	private int replyCount;

	// wdate과 현재시간의 차이를 계산후 받아오기 위함
	private String wgap;

	//프로필사진을 가져온다.
	private String userProImg;
	private String truckProImg;



}
