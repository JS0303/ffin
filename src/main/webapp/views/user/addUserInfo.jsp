<%@ page contentType="text/html; charset=utf-8" %>
<%@ page pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html lang="ko">


<head>

	<title>F.FIN | 회원가입</title>
	<jsp:include page="../../common/lib.jsp"/>

	<!-- bootstrap core css -->
	<link rel="stylesheet" type="text/css" href="../../resources/bootstrap/css/bootstrap.css" />
	<!-- Custom styles for this template -->
	<link href="../../resources/bootstrap/css/style.css" rel="stylesheet" />

	<!--    Favicons-->
	<link rel="apple-touch-icon" sizes="180x180" href="../../resources/bootstrap/assets/favicons/apple-touch-icon.png">
	<link rel="icon" type="image/png" sizes="32x32" href="../../resources/bootstrap/assets/favicons/favicon-32x32.png">
	<link rel="icon" type="image/png" sizes="16x16" href="../../resources/bootstrap/assets/favicons/favicon-16x16.png">
	<link rel="shortcut icon" type="image/x-icon" href="../../resources/bootstrap/assets/favicons/favicon.ico">
	<link rel="manifest" href="../../resources/bootstrap/assets/favicons/manifest.json">
	<meta name="msapplication-TileImage" content="../../resources/bootstrap/assets/favicons/mstile-150x150.png">
	<meta name="theme-color" content="#ffffff">

	<%--주소API--%>
	<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>


	<script type="text/javascript">


		/*정규식*/
		var empEx = /\s/g;
		var userIdEx = /^[a-z0-9]{5,25}$/;
		var userPwEx = /^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*#?&])[A-Za-z\d@$!%*#?&]{8,}$/;
		var userNameEx = /^[가-힣]{2,4}|[a-zA-Z]{2,10}\s[a-zA-Z]{2,10}$/;
		var userMailEx = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;
		var userBirthEx = /^(19[0-9][0-9]|20\d{2})-(0[0-9]|1[0-2])-(0[1-9]|[1-2][0-9]|3[0-1])$/;
		var userPhoneEx = /^01([0|1|6|7|8|9])-?([0-9]{3,4})-?([0-9]{4})$/;
		var userEmail = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;


		/* V.C */
		var idChk = false;
		var idDupleChk = false;
		var idExChk = false;
		var pwChk = false;
		var rePwChk = false;
		var pwExChk = false;
		var pwCorrectChk = false;
		var nameChk = false;
		var nameExChk = false;
		var phoneChk = false;
		var phoneExChke = false;
		var phoneAuthChke = false;
		var birthChk = false;


		/* 가입하기 버튼 클릭 */
		$(function () {
			$("a[href='#' ]").click(function () {

				var userId = $("#userId").val();
				var userPassword = $("#userPassword").val();
				var reUserPassword = $("#reUserPassword").val();
				var userName = $("#userName").val();
				var userPhone = $("#userPhone").val();
				var userBirth = $("#userBirth").val();

				/* Id V.C */
				if(userId === "") {
					$(".id_input_chk").css("display","block");
					$("#userId").css({
						"border-color" : "#f17228",
						"box-shadow" : "0 0 0 0.1rem rgb(241, 114, 40)"
					});
					idChk = false;
				}else {
					$(".id_input_chk").css("display","none");
					idChk = true;
				}

				/* password V.C */
				if(userPassword === ""){
					$(".pw_input_chk").css("display","block");
					$("#userPassword").css({
						"border-color" : "#f17228",
						"box-shadow" : "0 0 0 0.1rem rgb(241, 114, 40)"
					});
					pwChk = false;
				}else {
					$(".pw_input_chk").css("display","none");
					pwChk = true;
				}

				/* RePassword V.C */
				if(reUserPassword === ""){
					$(".rePw_input_chk").css("display","block");
					$("#reUserPassword").css({
						"border-color" : "#f17228",
						"box-shadow" : "0 0 0 0.1rem rgb(241, 114, 40)"
					});
					rePwChk = false;
				}else {
					$(".rePw_input_chk").css("display","none");
					rePwChk = true;
				}

				/* name V.C */
				if(userName === ""){
					$(".name_input_chk").css("display","block");
					$("#userName").css({
						"border-color" : "#f17228",
						"box-shadow" : "0 0 0 0.1rem rgb(241, 114, 40)"
					});
					nameChk = false;
				}else {
					$(".name_input_chk").css("display","none");
					nameChk = true;
				}

				/* phone V.C */
				if(userPhone === ""){
					$(".phone_input_chk").css("display","block");
					$(".phone_auth_chk").css("display","none");
					$("#userPhone").css({
						"border-color" : "#f17228",
						"box-shadow" : "0 0 0 0.1rem rgb(241, 114, 40)"
					});
					phoneChk = false;
				}else {
					$(".phone_input_chk").css("display","none");
					$(".phone_auth_chk").css("display","block");
					$("#userPhone").css({
						"border-color": "#ffe537",
						"box-shadow": "0 0 0 0.1rem rgb(255, 229, 55)"
					});
					phoneChk = true;
				}

				if(userBirth === ""){
					$("#userBirth").css({
						"border-color" : "#f17228",
						"box-shadow" : "0 0 0 0.1rem rgb(241, 114, 40)"
					});
					birthChk = false;
				}else {
					birthChk = true;
				}

				//문자인증은 유료라서 빼놨음
				if(idChk&&idDupleChk&&idExChk&&pwChk&&rePwChk&&pwExChk&&pwCorrectChk&&nameChk&&nameExChk&&phoneChk&&phoneExChke&&birthChk){
					$("#user_join_form").attr("method", "POST").attr("action","/user/addUser").submit();
					//alert("가입 축하축하");
				}
				return false;
			});
		});


		/* Id Chk */
		$(function () {
			$("#userId").on("propertyChange change keyup paste input", function () {

				var userId = $("#userId").val();
				var data = {userId : userId}

				/*
					일단 여기에 추가해뒀는데 이유가 뭐냐면,

					'가입하기'버튼을 눌렀을 때에 저 위의 function이 먹기 때문에 동기적 상황이 된거같고
					(즉, '가입하기'버튼을 누르면 -> userId가 없네? -> 해당 문구 노출시킴 -> 그리고 그 이후에 아이디를 치는 상황은 비동기적, 즉 실시간인 상황)
					이 css를 none을 시키려면 비동기적 상황, 실시간(?)으로 판단하여 실행이 되어야 해서
					ajax를 건드리는 keyUp 이벤트에서 처리를 해줘야할 것 같아서 여기에 일단 두었어

					그리고 지웠을 때 가능한건 190번 라인,
					즉 ajax로 판단하여 지웠을떄 저게 공란이여서 none이 된거였거든
					그래서 비동기적 상황에서 이걸 판단할 부분이 필요할 것 같아!!!!
					일단 통째로 이걸 옮겨놨구 수정 필요할꺼에옹
					일단 없어지긴 해!

					+
					가입버튼 누르기 전에,
					애초에 가입페이지를 열었을 때의 빈칸에서는 저걸 노출시킬 필요는 없는거얌?

				 */
				if(userId === "") {
					$(".id_input_chk").css("display","block");
					$("#userId").css({
						"border-color" : "#f17228",
						"box-shadow" : "0 0 0 0.1rem rgb(241, 114, 40)"
					});
					idChk = false;
				}else {
					$(".id_input_chk").css("display","none");
					idChk = true;
				}

				$.ajax({
					type : "POST",
					url : "/user/json/idChkDuplication/",
					data : data,
					success : function (result) {

						console.log(result);

						if(userId === result) {

							//정규식
							if (userIdEx.test(userId) === true) {

								//중복검사
								if (result !== false) {
									$(".id_vc_chk_1").css("display", "inline-block");
									$(".id_vc_chk_2").css("display", "none");
									$(".id_ex_chk").css("display", "none");

									$("#userId").css({
										"border-color": "#ffe537",
										"box-shadow": "0 0 0 0.1rem rgb(255, 229, 55)"
									});

									idDupleChk = true;
								} else {
									$(".id_vc_chk_1").css("display", "none");
									$(".id_vc_chk_2").css("display", "inline-block");
									$(".id_ex_chk").css("display", "none");

									$("#userId").css({
										"border-color": "#f17228",
										"box-shadow": "0 0 0 0.1rem rgb(241, 114, 40)"
									});

									idDupleChk = false;
								}
								idExChk = true;

							} else {
								console.log("아이디 형식 잘못됨!");
								$(".id_vc_chk_1").css("display", "none");
								$(".id_ex_chk").css("display", "inline-block");
								$("#userId").css({
									"border-color": "#f17228",
									"box-shadow": "0 0 0 0.1rem rgb(241, 114, 40)"
								});

								idExChk = false;
							}
						} else {
							$(".id_vc_chk_1").css("display", "none");
							$(".id_vc_chk_2").css("display", "block");
							$(".id_input_chk").css("display", "none");
							$(".id_ex_chk").css("display", "none");
							$("#userId").css({
								"border-color": "#f17228",
								"box-shadow": "0 0 0 0.1rem rgb(241, 114, 40)"
							});
						}
					}
				})
			});
		});


		/* ps Chk */
		$(function () {
			$("#reUserPassword").on("propertyChange change keyup paste input", function () {

				var pw = $("#userPassword").val();
				var rePw = $("#reUserPassword").val();
				$(".pw_input_chk").css("display","none");

					if (pw !== "") {

						//정규식
						if (userPwEx.test(pw) === false) {

							$(".pw_ex_chk").css("display", "block");
							$("#userPassword").css({
								"border-color": "#f17228",
								"box-shadow": "0 0 0 0.1rem rgb(241, 114, 40)"
							});
							pwExChk = false;

						} else {
							//비밀번호 확인
							if (pw === rePw) {
								$(".rePw_vc_chk").css("display", "none");
								$("#userPassword").css({
									"border-color": "#ffe537",
									"box-shadow": "0 0 0 0.1rem rgb(255, 229, 55)"
								});
								$("#reUserPassword").css({
									"border-color": "#ffe537",
									"box-shadow": "0 0 0 0.1rem rgb(255, 229, 55)"
								});
								pwCorrectChk = true;
							} else {
								$(".rePw_vc_chk").css("display", "block");
								$("#reUserPassword").css({
									"border-color": "#f17228",
									"box-shadow": "0 0 0 0.1rem rgb(241, 114, 40)"
								});
								pwCorrectChk = false;
							}

							$(".pw_ex_chk").css("display", "none");
							$(".rePw_input_chk").css("display", "none");
							$("#userPassword").css({
								"border-color": "#ffe537",
								"box-shadow": "0 0 0 0.1rem rgb(255, 229, 55)"
							});
							pwExChk = true;
						}
					} else {
						$(".pw_input_chk").css("display", "none");
						$(".pw_ex_chk").css("display", "none");
						$(".rePw_input_chk").css("display", "none");
					}
			});
		});


		/* name Chk */
		$(function () {

			$("#userName").on("propertyChange change keyup paste input", function () {

				var userName = $("#userName").val();
				$(".name_input_chk").css("display", "none");

				//정규식
				if (userNameEx.test(userName) === true) {
					$(".name_ex_chk").css("display", "none");
					$("#userName").css({
						"border-color": "#ffe537",
						"box-shadow": "0 0 0 0.1rem rgb(255, 229, 55)"
					});
					nameExChk = true;
				} else {
					$(".name_ex_chk").css("display", "block");
					$("#userName").css({
						"border-color": "#f17228",
						"box-shadow": "0 0 0 0.1rem rgb(241, 114, 40)"
					});
					nameExChk = false;
				}
			});
		});


		/* birth Chk */
		$(function () {
			$("#userBirth").on("propertyChange change keyup paste input", function () {

				var userBirth = $("#userBirth").val();

				//정규식
				if (userBirthEx.test(userBirth) === true) {
					$(".brith_ex_chK").css("display", "none");
					$("#birthHelp").css("display", "block");
					$("#userBirth").css({
						"border-color": "#ffe537",
						"box-shadow": "0 0 0 0.1rem rgb(255, 229, 55)"
					});
				} else {
					$(".brith_ex_chK").css("display", "block");
					$("#birthHelp").css("display", "none");
					$("#userBirth").css({
						"border-color": "#f17228",
						"box-shadow": "0 0 0 0.1rem rgb(241, 114, 40)"
					});
				}

			});
		});

		/* phone chk */
		$(function () {
			$("#userPhone").on("propertyChange change keyup paste input", function () {

				var userPhone = $("#userPhone").val();

				//정규식
				if (userPhoneEx.test(userPhone) === true) {

					$(".phone_ex_chk").css("display", "none");
					$(".phone_input_chk").css("display", "none");
					$(".phone_auth_chk").css("display", "block");
					$("#userPhone").css({
						"border-color": "#ffe537",
						"box-shadow": "0 0 0 0.1rem rgb(255, 229, 55)"
					});

					phoneExChke = true;

				} else {
					$(".phone_ex_chk").css("display", "block");
					$(".phone_auth_chk").css("display", "none");
					$("#userPhone").css({
						"border-color": "#f17228",
						"box-shadow": "0 0 0 0.1rem rgb(241, 114, 40)"
					});

					phoneExChke = false;
				}
			});
		});

		/* 휴대폰 인증 */
		$(function () {

			var code2 = "";

			$(".auth-phone").click(function () {

				alert(1234);

				var inputPhone = $("#userPhone").val();
				var authInputBox = $("#authNumPhone");
				alert(inputPhone);
				$.ajax({
					type : "GET",
					url : "/user/json/sendSMS/" + inputPhone,
					success : function (data){
						console.log(data);
						authInputBox.attr("disabled", false);
						$("#auth-email").text("인증번호 재전송")
						code2 = data;
					}
				});



			});

			//휴대폰 인증번호 대조
			$("#authNumPhone").on("keyup", function () {

				var inputCode = $("#authNumPhone").val();

				if (inputCode.length >= 4) {
					if (inputCode === code2) {
						console.log("SMS OK!!!")
						$(".phone_auth_chk_ok").css("display", "block");
						$(".phone_auth_chk").css("display", "none");
						$(".phone_auth_chk_fail").css("display", "none");
						$("#auth-email").css("disabled",true);
						$("#authNumPhone").css({
							"border-color": "#ffe537",
							"box-shadow": "0 0 0 0.1rem rgb(255, 229, 55)"
						});
						phoneAuthChke = true;
					} else {
						console.log("NOPE");
						$(".phone_auth_chk_fail").css("display", "block");
						$(".phone_auth_chk").css("display", "none");
						$("#authNumPhone").css({
							"border-color": "#f17228",
							"box-shadow": "0 0 0 0.1rem rgb(241, 114, 40)"
						});
						phoneAuthChke = false;
					}
				}
			});
		});


		/* Email Ex */
		$(function () {
			$("#userEmail").on("propertyChange change keyup paste input", function () {

				var userEmail = $("#userEmail").val();

				//정규식
				if (userMailEx.test(userEmail) === true) {

					$(".email_ex_chk").css("display", "none");
					$(".email_auth_chk").css("display", "block");
					$("#userEmail").css({
						"border-color": "#ffe537",
						"box-shadow": "0 0 0 0.1rem rgb(255, 229, 55)"
					});

				} else {

					$(".email_ex_chk").css("display", "block");
					$(".email_auth_chk").css("display", "none");
					$("#userEmail").css({
						"border-color": "#f17228",
						"box-shadow": "0 0 0 0.1rem rgb(241, 114, 40)"
					});
				}
			});
		});


		/* 이메일 인증 */
		$( function() {

			var code = "";

			/* 인증번호 이메일 전송 */
			$(".auth-email").click(function () {

				var inputEmail = $("#userEmail").val();
				var authInputBox = $("#authEmail");

				alert(inputEmail);

				$.ajax({
					type:"GET",
					url:"/auth/json/emailAuth/"+inputEmail,
					success:function (data){
						authInputBox.attr("disabled",false);
						code = data;
					}
				});
			});

			/* email 인증번호 비교 */
			$("#authEmail").on("keyup",function (){

				var inputCode = $("#authEmail").val();

				if(inputCode.length >= 6){
					if(inputCode === code){
						console.log("OKOKOOKOKOK");
						$(".email_auth_chk").css("display", "none");
						$(".email_auth_chk_ok").css("display", "block");

						$("#authEmail").css({
							"border-color": "#ffe537",
							"box-shadow": "0 0 0 0.1rem rgb(255, 229, 55)"
						});
					}else {
						console.log("NONONONONONONONON");
						$(".email_auth_chk").css("display", "none");
						$(".email_auth_chk_ok").css("display", "none");
						$(".email_auth_chk_fail").css("display", "block");
						$("#authEmail").css({
							"border-color": "#f17228",
							"box-shadow": "0 0 0 0.1rem rgb(241, 114, 40)"
						});
					}
				}
			});
		});

		/* Daum API */
		function addrApi(){
			new daum.Postcode({
				oncomplete: function(data) {

					/*alert(data);
					alert(data.roadAddress);*/

					// 각 주소의 노출 규칙에 따라 주소를 조합한다.
					// 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
					var addr = ''; // 주소 변수
					var extraAddr = ''; // 참고항목 변수

					//사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
					if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
						addr = data.roadAddress;
					} else { // 사용자가 지번 주소를 선택했을 경우(J)
						addr = data.jibunAddress;
					}

					// 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
					if(data.userSelectedType === 'R'){
						// 법정동명이 있을 경우 추가한다. (법정리는 제외)
						// 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
						if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
							extraAddr += data.bname;
						}
						// 건물명이 있고, 공동주택일 경우 추가한다.
						if(data.buildingName !== '' && data.apartment === 'Y'){
							extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
						}
						// 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
						if(extraAddr !== ''){
							extraAddr = ' (' + extraAddr + ')';
						}
						// 조합된 참고항목을 해당 필드에 넣는다.
						// document.getElementById("sample6_extraAddress").value = extraAddr;
						addr += extraAddr;
					} else {
						// document.getElementById("sample6_extraAddress").value = '';
						addr = '';
					}

					// 우편번호와 주소 정보를 해당 필드에 넣는다.
					// document.getElementById('sample6_postcode').value = data.zonecode;
					// document.getElementById("sample6_address").value = addr;
					//$(".userAddr").val(data.zonecode);
					// 커서를 상세주소 필드로 이동한다.
					// document.getElementById("sample6_detailAddress").focus();
					$("#userAddr").val(addr);
					$("#userAddrDetail").attr("readonly", false);
					$("#userAddrDetail").focus();
				}
			}).open();
		}

	</script>
</head>

<body id="page-top">

<!-- toolbar -->
<jsp:include page="/views/navbar.jsp" />


<!-- client section -->

<section class="client_section layout_padding">
	<div class="container">
		<div class="col-md-11 col-lg-10 mx-auto">
			<div id="customCarousel1" class="carousel slide">
				<div class="carousel-inner">
					<div class="carousel-item active">
						<div class="detail-box">
							<i class="fa fa-quote-left" aria-hidden="true" style="color: #f17228;"></i>
							<h4 style="margin-top: 10px;">
								회원가입
							</h4>
						</div>
						<form class="row justify-content-center" id="user_join_form">

							<div class="col-md-6 data-input-box">

								<div class="data-input-box">
									<label for="userId" class="form-label label-name" style="display: flex;">ID<i class="fas fa-asterisk" style="zoom: 70%; margin-bottom: 5px;"></i></label>
									<input type="text" class="form-control" id="userId" name="userId" placeholder="아이디">
									<span class="id_vc_chk_1">사용 가능한 아이디입니다.</span>
									<span class="id_vc_chk_2">사용 중인 아이디입니다.</span>
									<span class="id_input_chk">아이디를 입력해주세요.</span>
									<span class="id_ex_chk">아이디는 소문자와 숫자를 포함한 5 ~ 25자리만 가능합니다.</span>
								</div>

								<div class="data-input-box">
									<label for="userPassword" class="form-label label-name" style="display: flex;">Password<i class="fas fa-asterisk" style="zoom: 70%; margin-bottom: 5px;"></i></label>
									<input type="password" class="form-control" id="userPassword" name="userPassword" placeholder="비밀번호">
									<span class="pw_input_chk">비밀번호를 입력해주세요.</span>
									<span class="pw_ex_chk">대소문자, 숫자를 포함하여 8자 이상으로 입력해주세요.</span>
									<input type="password" class="form-control" id="reUserPassword" placeholder="비밀번호 확인" style="margin-top: 10px">
									<span class="rePw_input_chk">비밀번호를 확인해주세요.</span>
									<span class="rePw_vc_chk">비밀번호가 일치하지 않습니다.</span>
								</div>

								<div class="data-input-box">
									<label for="userName" class="form-label label-name" style="display: flex;">성명<i class="fas fa-asterisk" style="zoom: 70%; margin-bottom: 5px;"></i></label>
									<input type="text" class="form-control" id="userName" name="userName">
									<span class="name_input_chk">이름을 입력해주세요.</span>
									<span class="name_ex_chk">이름을 정확하게 입력해주세요.</span>
								</div>

								<div class="data-input-box">
									<label for="userBirth" class="form-label label-name" style="display: flex;">생년월일<i class="fas fa-asterisk" style="zoom: 70%; margin-bottom: 5px;"></i></label>
									<input type="text" class="form-control" id="userBirth" name="userBirth">
									<div id="birthHelp" class="form-text" style="font-size: 10pt; margin-left: 5px; color: grey">연 1회 생일 축하 쿠폰이 발급됩니다.</div>
									<span class="brith_ex_chK">생년월일을 'YYYY-DD-MM' 형식으로 입력해주세요.</span>
								</div>

								<div class="data-input-box">
									<label for="userPhone" class="form-label label-name" style="display: flex;">전화번호<i class="fas fa-asterisk" style="zoom: 70%; margin-bottom: 5px;"></i></label>
									<input type="text" class="form-control" id="userPhone" name="userPhone" placeholder="전화번호를 입력하세요.">
									<%--<div id="phoneHelp" class="form-text" style="font-size: 10pt; float:left; margin-right:10px; margin-top: 12px; margin-left: 5px;">인증번호를 요청하세요.</div>--%>
									<span class="phone_input_chk">휴대폰번호를 입력해주세요.</span>
									<span class="phone_ex_chk">휴대폰번호를 정확하게 입력해주세요</span>
									<span class="phone_auth_chk">인증번호를 요청하세요.</span>

									<button type="button" class="btn btn-outline-warning auth-phone" style="float: right; margin-bottom: 5px;" >인증번호 요청</button>
									<input type="text" class="form-control auth-Num-Phone" id="authNumPhone" placeholder="인증번호 확인" disabled="disabled" >
									<span class="phone_auth_chk_ok">휴대폰번호 인증 완료</span>
									<span class="phone_auth_chk_fail">인증번호가 일치하지 않습니다.</span>
								</div>

								<div class="data-input-box">
									<label for="userAddr" class="form-label label-name">주소</label>
									<div>
										<input type="text" class="form-control" id="userAddr" name="userAddr" placeholder="주소 검색" style="width: 80%; display: inline-block;">
										<button type="button" class="btn btn-outline-warning addrApi" onclick="addrApi()" style="width: auto;">검색</button>
									</div>
									<input type="text" class="form-control" id="userAddrDetail" placeholder="상세주소" style="margin-top: 8px">
								</div>

								<div class="data-input-box">
									<label for="userEmail" class="form-label label-name">Email</label>
									<input type="text" class="form-control" id="userEmail" name="userEmail" placeholder="이메일을 입력하세요.">
									<span class="email_input_chk">이메일을 입력해주세요.</span>
									<span class="email_ex_chk">이메일을 정확하게 입력해주세요</span>
									<span class="email_auth_chk">인증번호를 요청하세요.</span>

									<button type="button" class="btn btn-outline-warning auth-email" style="float: right; margin-bottom: 5px;" >인증번호 요청</button>
									<label for="authEmail" class="form-label label-name"></label>
									<input type="text" class="form-control" id="authEmail" placeholder="인증번호 확인" disabled="disabled" style="margin-top: 25px">
									<span class="email_auth_chk_ok">이메일 인증 완료</span>
									<span class="email_auth_chk_fail">인증번호가 일치하지 않습니다.</span>
								</div>

							</div>
						</form>

						<div class="btn-box">
							<a href="#">
								가입하기
							</a>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</section>

<jsp:include page="/views/footer.jsp" />

</body>
</html>