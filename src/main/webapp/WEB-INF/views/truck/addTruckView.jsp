<%@ page contentType="text/html; charset=euc-kr" %>
<%@ page pageEncoding="euc-kr"%>


<!DOCTYPE html>

<html lang="ko">

<head>
    <meta charset="euc-kr">

    <!-- ���� : http://getbootstrap.com/css/   ���� -->
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />

    <title>Ǫ��Ʈ��(�����) ȸ������</title>

    <!-- datepicker -->
    <!-- jQuery UI CSS ���� -->
    <link rel="stylesheet" href="http://code.jquery.com/ui/1.8.18/themes/base/jquery-ui.css" type="text/css" />
    <!-- jQuery �⺻ js����-->
    <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>
    <!-- jQuery UI ���̺귯�� js���� -->
    <script src="http://code.jquery.com/ui/1.8.18/jquery-ui.min.js"></script>


    <!--  ///////////////////////// JavaScript ////////////////////////// -->
    <script type="text/javascript">

        //============= "����"  Event ���� =============
        $(function() {
            //==> DOM Object GET 3���� ��� ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
            $( "button.btn.btn-primary" ).on("click" , function() {
                fncAddTruck();
            });
        });

        //============= "���"  Event ó�� ��  ���� =============
    $(function() {
    //==> DOM Object GET 3���� ��� ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
    $("a[href='#' ]").on("click" , function() {
        self.location = "/truck/loginTruck"
    });
    });


        function fncAddTruck() {

            var id=$("input[name='truckId']").val();
            var pw=$("input[name='truckPassword']").val();
            var pw_confirm=$("input[name='truckPasswordChk']").val();
            var name=$("input[name='truckCEOName']").val();


            if(id == null || id.length <1){
                alert("���̵�� �ݵ�� �Է��ϼž� �մϴ�.");
                return;
            }
            if(pw == null || pw.length <1){
                alert("�н������  �ݵ�� �Է��ϼž� �մϴ�.");
                return;
            }
            if(pw_confirm == null || pw_confirm.length <1){
                alert("�н����� Ȯ����  �ݵ�� �Է��ϼž� �մϴ�.");
                return;
            }
            if(name == null || name.length <1){
                alert("�̸���  �ݵ�� �Է��ϼž� �մϴ�.");
                return;
            }

            if( pw != pw_confirm ) {
                alert("��й�ȣ Ȯ���� ��ġ���� �ʽ��ϴ�.");
                $("input:text[name='truckPasswordChk']").focus();
                return;
            }

            // var value = "";
            // if( $("input:text[name='phone2']").val() != ""  &&  $("input:text[name='phone3']").val() != "") {
            //     var value = $("option:selected").val() + "-"
            //         + $("input[name='phone2']").val() + "-"
            //         + $("input[name='phone3']").val();
            // }
            //
            // $("input:hidden[name='phone']").val( value );

            $("form").attr("method" , "POST").attr("action" , "/truck/addTruck").submit();
        }
    </script>
    <!-- Ǫ��Ʈ�� ���̵� �ߺ�üũ -->
    <script type="text/javascript">
        $("#truckId").blur(function(){

            var truckId = $("#truckId").val();
            $.ajax({
                url : '${pageContext.request.contextPath}/truck/checkDuId?truckId='+ truckId,
                type : 'get',
                //cache : false,
                success : function(data) {

            if(truckId == "" || truckId.length < 2){
                $(".successIdChk").text("���̵�� 2�� �̻� �Է����ּ���.");
                $(".successIdChk").css("color", "red");
                $("#idDoubleChk").val("false");
            }else{

                        if (data == 0) {
                            $("#id_check").text("��밡���� ���̵��Դϴ�.");
                            $("#id_check").css("color", "green");
                            $("#idDoubleChk").val("true");
                        } else {
                            $("#id_check").text("������� ���̵��Դϴ�.");
                            $("#id_check").css("color", "red");
                            $("#idDoubleChk").val("false");
                        }
                    }, error : function() {
                        console.log("����");
                    }
                }
            });
        });
    </script>



    <script>
        function findAddr(){
            new daum.Postcode({
                oncomplete: function(data) {

                    console.log(data);

                    // �˾����� �˻���� �׸��� Ŭ�������� ������ �ڵ带 �ۼ��ϴ� �κ�.
                    // ���θ� �ּ��� ���� ��Ģ�� ���� �ּҸ� ǥ���Ѵ�.
                    // �������� ������ ���� ���� ��쿣 ����('')���� �����Ƿ�, �̸� �����Ͽ� �б� �Ѵ�.
                    var roadAddr = data.roadAddress; // ���θ� �ּ� ����
                    var jibunAddr = data.jibunAddress; // ���� �ּ� ����
                    // �����ȣ�� �ּ� ������ �ش� �ʵ忡 �ִ´�.
                    document.getElementById('member_post').value = data.zonecode;
                    if(roadAddr !== ''){
                        document.getElementById("member_addr").value = roadAddr;
                    }
                    else if(jibunAddr !== ''){
                        document.getElementById("member_addr").value = jibunAddr;
                    }
                }
            }).open();
        }
    </script>
    <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

    <script >

        $( function() {
            $( "#truckCEOBirth" ).datepicker({
                changeMonth : true,
                changeYear : true,
                nextText : '���� ��',
                prevText : '���� ��',
                dateFormat : "yy-mm-dd"
            });
        });

    </script>

</head>

<body>

<div class="container">
    <div class="titleStyle">
        <h3 class=" text-info">Ǫ��Ʈ��(�����) ȸ������</h3>
    </div>
<form method="POST">

<!-- ���̵� �ߺ��˻� -->
<div class="form-group">
    <label for = "truckId">���̵�</label>
    <input type="text" class="form-control" id="truckId" name="truckId" placeholder="���̵� �Է��ϼ���." required maxlength="10">
    <span class="point">�� ������, �ҹ��� �Է°���, �ִ� 10�� ���� �Է�</span>
    <div class="check_font" id="id_check"></div>
</div>


<!-- ��й�ȣ Ȯ�� -->
<br/><br/>
<tr>
    <th>
        <label for="truckPassword">��й�ȣ</label>
    </th>
    <td>
        <input id="truckPassword" type="password" name="truckPassword"  required maxlength="8" autocomplete="off"/>
        <span class="point">�� ��й�ȣ�� �� 8�� ���� �Է°���</span>
    </td>
</tr>
<br/><br/>
<tr>
    <th>
        <label for="truckPasswordChk">��й�ȣ Ȯ��</label>
    </th>
    <td>
        <input id="truckPasswordChk" type="password" name="truckPasswordChk" placeholder="�����ϰ� �Է����ּ���." required maxlength="8" autocomplete="off"/>
        <span class="point successPwChk"></span>
        <input type="hidden" id="pwDoubleChk"/>
    </td>
</tr>

<!-- Ʈ�� ��ǥ�� �̸� �Է¶� -->
<br/><br/>
<tr>
    <th>
        <label for="truckCEOName" class="col-sm-offset-1 col-sm-3 control-label">�̸�</label>
    </th>
    <td>
        <input id="truckCEOName" class="form-control"  name="truckCEOName" placeholder="��ǥ���̸�">
        </div>
    </td>
</tr>

<!-- Ʈ�� ��ǥ�� ������� �Է¶� -->
<br/><br/>
<div class="form-group">
    <label for="truckCEOBirth" class="col-sm-offset-1 col-sm-3 control-label">�������</label>

        <input id="truckCEOBirth" class="form-control"  name="truckCEOBirth" placeholder="��ǥ�� �������">
        &nbsp;

</div>

<br/>

<!-- īī��(����) �ּ�ã�� -->
<p>�ּ�ã��</p>
<div>�����ȣ �Է¶��� Ŭ���ϼ���.</div>
<input id="member_post"  type="text" placeholder="�����ȣ 5�ڸ�" readonly onclick="findAddr()">
<input id="member_addr" type="text" placeholder="�ּ�" readonly> <br>
<input type="text" placeholder="�ּ� ��">


<!-- �޴�����ȣ �Է¶� -->
<br/><br/>
<div class="form-group">
    <label for="truckPhone" class="col-sm-offset-1 col-sm-3 control-label">�޴�����ȣ</label>

    <input id="truckPhone" class="form-control"  name="truckPhone" placeholder="�޴�����ȣ">
</div>

<!-- �̸��� �Է¶� -->
<br/><br/>
<div class="form-group">
    <label for="truckEmail" class="col-sm-offset-1 col-sm-3 control-label">�̸���</label>
    <div class="col-sm-4">
        <input type="text" class="form-control" id="truckEmail" name="truckEmail" placeholder="�̸���">
    </div>
</div>

<!-- Ǫ��Ʈ�� ��ȣ �Է¶� -->
<br/><br/>
<div class="form-group">
    <label for="truckName" class="col-sm-offset-1 col-sm-3 control-label">Ǫ��Ʈ����ȣ</label>
    <div class="col-sm-4">
        <input type="text" class="form-control" id="truckName" name="truckName" placeholder="Ǫ��Ʈ����ȣ">
    </div>
</div>

<!-- Ǫ��Ʈ�� ����ڵ���� ���Ͼ��ε�� -->
<br/><br/>
<div class="form-group">
    <label for="truckBusiLice" class="col-sm-offset-1 col-sm-3 control-label">����ڵ����</label>
    <div class="col-sm-4">
        <input type="text" class="form-control" id="truckBusiLice" name="truckBusiLice" placeholder="����ڵ���� ���Ͼ��ε�">
    </div>
</div>


<!-- Ǫ��Ʈ�� ī�װ� -->
<br/><br/>
<div class="form-group">
    <label for="truckCate" class="col-sm-offset-1 col-sm-3 control-label">Ǫ��Ʈ�� ī�װ�</label>
    <div class="col-sm-4">
        <input type="text" class="form-control" id="truckCate" name="truckCate" placeholder="Ǫ��Ʈ�� ī�װ�">
    </div>
</div>

<!-- Ǫ��Ʈ�� �������̹��� ���Ͼ��ε�� -->
<br/><br/>
<div class="form-group">
    <label for="truckProImg" class="col-sm-offset-1 col-sm-3 control-label">������ �̹���</label>
    <div class="col-sm-4">
        <input type="text" class="form-control" id="truckProImg" name="truckProImg" placeholder="������ �̹��� ���Ͼ��ε�">
    </div>
</div>


<!-- Ǫ��Ʈ�� ����� �Ѹ��� -->
<br/><br/>
<div class="form-group">
    <label for="truckCEOIntro" class="col-sm-offset-1 col-sm-3 control-label">����� �Ѹ���</label>
    <div class="col-sm-4">
        <input type="text" class="form-control" id="truckCEOIntro" name="truckCEOIntro" placeholder="����� �Ѹ���">
    </div>
</div>




<br/><br/>
<div class="form-group">
    <div class="col-sm-offset-4  col-sm-4 text-center">
        <button type="button" class="btn btn-primary" >�� ��</button>
        <a class="btn btn-primary btn" href="#" role="button">�� ��</a>
    </div>
</div>


</form>
</form>
</div>
</body>






</html>

    <hr/>