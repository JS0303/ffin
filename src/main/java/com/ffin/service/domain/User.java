package com.ffin.service.domain;


import lombok.Data;

import java.sql.Date;

@Data
public class User {

    private String userId;
    private String userPassword;
    private String userName;
    private String userPhone;
    private String userBirth;
    private String userAddr;
    private String userAddrDetail;
    private String userRegDate;
    private double userMapLa;
    private double userMapLo;
    private int reportCount;
    private String userEmail;
    private int userEmailStatus;
    private String userProImg;
    private String userFavPlace;
    private String userFavPlaceDetail;
    private String userFavMenu;
    private String userIntro;
    private int userTotalPoint;
    private int userByeStatus;
    private int userByeReason;
    private String userByeRegDate;
    private String blackRegDate;
    private String blackEndDate;
    private int role;
    private String sessionKey;
    private Date sessionLimit;
    private boolean autoLogin;

    //HHJ
    //최근 설정한 주소의 위도와 경도값
    private double userCurMapLa;
    private double userCurMapLo;
    private String userCurAdd;

}
