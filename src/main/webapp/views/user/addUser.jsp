<%@ page contentType="text/html; charset=euc-kr" %>
    
    
    
<!DOCTYPE html>


<html lang="ko">

<head>
	<meta charset="EUC-KR">
	
	<title>ȸ������</title>

	<!-- ���� : http://getbootstrap.com/css/   ���� -->
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />

	<!--  ///////////////////////// CSS ////////////////////////// -->
	<style>
 		body {
            padding-top : 50px;
        }
        
        div h3, div h5 {text-align: center;}
        
        label {
        	color : #6593A6;
        }

		.correct{
			color : greenyellow;
		}
		.incorrect{
			color: #d00000;
		}

        
     </style>

	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" >
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" >
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" ></script>

	<%--�ּ�API--%>
	<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>


	<script type="text/javascript">

		$( function() {

			var code = "";
``
			/* ������ȣ �̸��� ���� */
			$(".email-auth").click(function () {

				var inputEmail = $("#userEmail").val();
				var authInputBox = $(".mail-check-input");
				var boxWrap = $(".mail-check-input-box");

				alert(inputEmail);
				$.ajax({
					type:"GET",
					url:"/auth/json/emailAuth/"+inputEmail,
					success:function (data){
						//console.log("data : "+data);
						/*$("#userEmailAuth").attr("disabled",false);*/
						authInputBox.attr("disabled",false);
						boxWrap.attr("id", "mail-check-input-box-ture")
						code = data;
					}
				});
			});

			/* email ������ȣ �� */
			$(".mail-check-input").on("keyup",function (){

				var inputCode = $(".mail-check-input").val();
				var checkResult = $("#mail-check-input-box-warn");
				/*console.log("inputCode"+inputCode);
				console.log("code"+code);*/
				if(inputCode.length >= 6){
					if(inputCode == code){
						checkResult.html("OK");
						checkResult.attr("class", "correct");
					}else {
						checkResult.html("NOPE");
						checkResult.attr("class","incorrect");
					}
				}

			});


			/* coolSMS */
			// $(".sms-auth").click(function (){
			//
			// 	alert("zzz...");
			// 	/*var code = "";*/
			// 	var userPhone = $("#userPhone").val();
			// 	$("form").attr("method","POST").attr("action", "/auth/sendSMS").submit();
			//
			// 	alert("������ȣ�� ���۵Ǿ����ϴ�.");
			// });

		});

		/* Daum API */
		function addrApi(){
			new daum.Postcode({
				oncomplete: function(data) {

					alert(data);
					alert(data.roadAddress);

					// �� �ּ��� ���� ��Ģ�� ���� �ּҸ� �����Ѵ�.
					// �������� ������ ���� ���� ��쿣 ����('')���� �����Ƿ�, �̸� �����Ͽ� �б� �Ѵ�.
					var addr = ''; // �ּ� ����
					var extraAddr = ''; // �����׸� ����

					//����ڰ� ������ �ּ� Ÿ�Կ� ���� �ش� �ּ� ���� �����´�.
					if (data.userSelectedType === 'R') { // ����ڰ� ���θ� �ּҸ� �������� ���
						addr = data.roadAddress;
					} else { // ����ڰ� ���� �ּҸ� �������� ���(J)
						addr = data.jibunAddress;
					}

					// ����ڰ� ������ �ּҰ� ���θ� Ÿ���϶� �����׸��� �����Ѵ�.
					if(data.userSelectedType === 'R'){
						// ���������� ���� ��� �߰��Ѵ�. (�������� ����)
						// �������� ��� ������ ���ڰ� "��/��/��"�� ������.
						if(data.bname !== '' && /[��|��|��]$/g.test(data.bname)){
							extraAddr += data.bname;
						}
						// �ǹ����� �ְ�, ���������� ��� �߰��Ѵ�.
						if(data.buildingName !== '' && data.apartment === 'Y'){
							extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
						}
						// ǥ���� �����׸��� ���� ���, ��ȣ���� �߰��� ���� ���ڿ��� �����.
						if(extraAddr !== ''){
							extraAddr = ' (' + extraAddr + ')';
						}
						// ���յ� �����׸��� �ش� �ʵ忡 �ִ´�.
						// document.getElementById("sample6_extraAddress").value = extraAddr;
						addr += extraAddr;
					} else {
						// document.getElementById("sample6_extraAddress").value = '';
						addr = '';
					}

					// �����ȣ�� �ּ� ������ �ش� �ʵ忡 �ִ´�.
					// document.getElementById('sample6_postcode').value = data.zonecode;
					// document.getElementById("sample6_address").value = addr;
					//$(".userAddr").val(data.zonecode);
					// Ŀ���� ���ּ� �ʵ�� �̵��Ѵ�.
					// document.getElementById("sample6_detailAddress").focus();
					$("#userAddr").val(addr);
					$("#userAddrDetail").attr("readonly", false);
					$("#userAddrDetail").focus();
				}
			}).open();
		}





</script>
</head>

<body>


 	<div class="container">
	
		<div class="page-header" >
	       <h3 class="text-info">ȸ �� �� ��</h3>
	       <h5 class="text-muted">ȸ�������� <strong class="text-danger">��Ȯ�ϰ� �Է�</strong>�� �ּ���.</h5>
	    </div>
		
		<form class="form-horizontal">

			<div class="form-group">
			    <label for="userName" class="col-sm-offset-1 col-sm-3 control-label">ID</label>
			    <div class="col-sm-4">
			      <input type="text" class="form-control" id="userId" name="userId" placeholder="ID">
			    </div>
			  </div>
			
			<hr/>
			
			<div class="form-group">
			    <label for="userName" class="col-sm-offset-1 col-sm-3 control-label">Password</label>
			    <div class="col-sm-4">
			      <input type="text" class="form-control" id="userPassword" name="userPassword" placeholder="Password">
			    </div>
			  </div>
			
			<hr/>
			
			<div class="form-group">
			    <label for="userName" class="col-sm-offset-1 col-sm-3 control-label">�̸�</label>
			    <div class="col-sm-4">
			      <input type="text" class="form-control" id="userName" name="userName" placeholder="�̸�">
			    </div>
			  </div>

			<hr/>
            <div class="form-group">
                <label for="userName" class="col-sm-offset-1 col-sm-3 control-label">Phone</label>
                <div class="col-sm-4">
                    <input type="text" class="form-control" id="userPhone" name="userAddr" placeholder="�ڵ�����ȣ">
                </div>
                <div class="col-sm-3">
                    <button type="button" class="btn btn-warning sms-auth" >������ȣ</button>
                </div>
            </div>
            <div class="form-group">
                <label for="userName" class="col-sm-offset-1 col-sm-3 control-label"></label>
                <div class="col-sm-4">
                    <input type="text" class="form-control" id="userPhoneAuth" name="userPhoneAuth" placeholder="������ȣ" disabled required>
                    <input type="hidden" name="text" id="authNum"><%--������ȣ hidden���� ����--%>
                </div>
                <div class="col-sm-3">
                    <button type="button" class="btn btn-group-xs" id="userPhoneAuthNum">�� ��</button>
                    <br/>
                    <span class="point successPhoneChk">�޴��� ��ȣ�� ���� �Է����ּ���.</span>
                </div>
            </div>
			<hr/>

			<div class="form-group">
				<label for="userName" class="col-sm-offset-1 col-sm-3 control-label">�ּ�</label>
				<div class="col-sm-4">
					<input type="text" class="form-control" id="userAddr" name="userAddr" placeholder="�ּҰ˻�" readonly="readonly">
				</div>
				<div class="col-sm-3">
					<button type="button" class="btn btn-success" onclick="addrApi()">�ּҰ˻�</button>
				</div>
			</div>
			<div class="form-group">
				<label for="userName" class="col-sm-offset-1 col-sm-3 control-label"></label>
				<div class="col-sm-4">
					<input type="text" class="form-control" id="userAddrDetail" name="userAddrDetail" placeholder="���ּҸ� �Է����ּ���" readonly="readonly">				</div>
			</div>

			<hr/>

			<div class="form-group">
				<label for="userName" class="col-sm-offset-1 col-sm-3 control-label">Email</label>
				<div class="col-sm-4">
					<input type="text" class="form-control" id="userEmail" name="userEmail" placeholder="Email" >
				</div>
				<div class="col-sm-3">
					<button type="button" class="btn btn-info email-auth">email����</button>
				</div>
			</div>
			<div class="form-group mail-check-wrap">
				<label for="userName" class="col-sm-offset-1 col-sm-3 control-label"></label>
				<div class="col-sm-4 mail-check-input-box" id="mail-check-input-box-fail">
					<input type="text" class="form-control mail-check-input" id="userEmailAuth" name="userEmailAuth" placeholder="������ȣ" disabled="disabled">
					<span id="mail-check-input-box-warn"></span>
					<div class="clearfix"></div>
				</div>
			</div>


			
			<hr/>


 		<div class="form-group">
		    <div class="col-sm-offset-4  col-sm-4 text-center">
		      <button type="button" class="btn btn-primary"  >��&nbsp;��</button>
			  <a class="btn btn-primary btn" href="#" role="button">��&nbsp;��</a>
		    </div>
		</div>
		  
	</form>
	</div>
</body>
</html>