<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page pageEncoding="EUC-KR"%>


<!DOCTYPE html>

<html lang="ko">

<head>
	<meta charset="EUC-KR">

	<!-- ���� : http://getbootstrap.com/css/   ���� -->
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />

	<!--  ///////////////////////// Bootstrap, jQuery CDN ////////////////////////// -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" >
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" >
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" ></script>

	<%-- kakao login--%>
	<script src="https://developers.kakao.com/sdk/js/kakao.js"></script>


	<style>

		h4{
			color : #fd7622;
		}

		body{
			background-size: cover;
		}
	</style>

	<!--  ///////////////////////// JavaScript ////////////////////////// -->
	<script type="text/javascript">

		$(function () {

			console.log("lalalalala");

			//kakao Login
			Kakao.init('b729adcc43707d7099ee5f895c968b62');
			var id = "";
			$("#kakao-login-btn").on("click", function () {

				Kakao.Auth.login({
					success: function (authObj) {
						//console.log(JSON.stringify(authObj));
						//console.log(Kakao.Auth.getAccessToken());

						//2. �α��� ������, API�� ȣ���մϴ�.
						Kakao.API.request({
							url: '/v2/user/me',
							success: function (res) {
								//console.log(JSON.stringify(res));
								id = res.kakao_account.email;

								$.ajax({
									url: "/user/json/checkDuplication/" + res.kakao_account.email,
									type : "GET",
									headers: {
										"Accept": "application/json",
										"Content-Type": "application/json"
									},
									success: function (idChk) {
										console.log("hey kakao");
										console.log(idChk);
										if (idChk === id) { //DB�� ���̵� ���� ��� => ȸ������
											console.log("ȸ��������...");
											$.ajax({
												url: "views/user/addUser.jsp",
												method: "POST",
												headers: {
													"Accept": "application/json",
													"Content-Type": "application/json"
												},
												data: JSON.stringify({
													userId: res.kakao_account.email,
													userName: res.properties.nickname
													/*userPassword: "kakao123",*/
												}),
												success: function (JSONData) {
													console.log(JSONData)
													alert("ȸ�������� ���������� �Ǿ����ϴ�.");
													$("form").attr("method", "POST").attr("action", "/user/snsLogin/" + res.id).attr("target", "_parent").submit();
												}
											})
										}
										if (!(idChk === id)) { //DB�� ���̵� ������ ��� => �α���
											console.log("�α�����...");
											$("form").attr("method", "POST").attr("action", "/user/snsLogin/" + res.kakao_account.email).attr("target", "_parent").submit();
										}
									}
								})
							},
							fail: function (error) {
								alert(JSON.stringify(error));
							}
						});
					},
					fail: function (err) {
						alert(JSON.stringify(err));
					}
				});
			});
		});


		// login check
		$( function() {

			$("#userId").focus();

			//==> DOM Object GET 3���� ��� ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
			$("button").on("click" , function() {
				var id=$("input:text").val();
				var pw=$("input:password").val();

				if(id == null || id.length <1) {
					alert('ID �� �Է����� �����̽��ϴ�.');
					$("#userId").focus();
					return;
				}

				if(pw == null || pw.length <1) {
					alert('�н����带 �Է����� �����̽��ϴ�.');
					$("#password").focus();
					return;
				}

				$("form").attr("method","POST").attr("action","/user/login").attr("target","_parent").submit();
			});
		});


		// addUser Nav
		$( function() {
			//==> DOM Object GET 3���� ��� ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
			$("a[href='#' ]").on("click" , function() {
				self.location = "/user/addUser"
			});
		});

	</script>

</head>

<body>

<!-- ToolBar Start /////////////////////////////////////-->
<div class="navbar  navbar-default">
	<div class="container">
		<a class="navbar-brand" href="/home.jsp">F.FIN</a>
	</div>
</div>
<!-- ToolBar End /////////////////////////////////////-->

<!--  ȭ�鱸�� div Start /////////////////////////////////////-->
<div class="container">
	<!--  row Start /////////////////////////////////////-->



	<div class="row">

		<div class="col-md-3"></div>

		<div class="col-md-6">

			<br/><br/>

			<div >

				<form class="form-horizontal">

					<div class="form-group">
						<label for="userId" class="col-sm-4 control-label">�� �� ��</label>
						<div class="col-sm-6">
							<input type="text" class="form-control" name="userId" id="userId"  placeholder="���̵�" >
						</div>
					</div>

					<div class="form-group">
						<label for="password" class="col-sm-4 control-label">�� �� �� ��</label>
						<div class="col-sm-6">
							<input type="password" class="form-control" name="password" id="password" placeholder="�н�����" >
						</div>
					</div>

					<!-- īī�� �α��� �߰� -->
					<div id="kakaoLogin"  class="col-sm-offset-4 col-sm-6 text-center">
						<a id="kakao-login-btn">
							<img src="/resources/image/kakao_login_medium_wide.png" width="100%"/>
						</a>
						<a href="http://developers.kakao.com/logout"></a>
					</div>

					<br/><br/><br/>

					<div class="form-group">
						<div class="col-sm-offset-4 col-sm-6 text-center">
							<button type="button" class="btn btn-warning"  >�� &nbsp;�� &nbsp;��</button>
							<a class="btn btn-warning btn" href="#" role="button">ȸ &nbsp;�� &nbsp;�� &nbsp;��</a>
						</div>
					</div>

				</form>
			</div>

		</div>

	</div>
	<!--  row Start /////////////////////////////////////-->

</div>
<!--  ȭ�鱸�� div end /////////////////////////////////////-->

</body>

</html>