<%@ page contentType="text/html; charset=euc-kr" %>
<%@ page pageEncoding="euc-kr"%>


<!DOCTYPE html>

<html lang="ko">

<head>
    <meta charset="euc-kr">

    <!-- ���� : http://getbootstrap.com/css/   ���� -->
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />

    <!--  ///////////////////////// Bootstrap, jQuery CDN ////////////////////////// -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" >
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" >
    <script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" ></script>

    <!--  ///////////////////////// CSS ////////////////////////// -->
    <style>
        body >  div.container{
            border: 3px solid #D6CDB7;
            margin-top: 10px;
        }
    </style>

    <!--  ///////////////////////// JavaScript ////////////////////////// -->
    <script type="text/javascript">

        //============= "�α���"  Event ���� =============
        $( function() {

            $("#truckId").focus();

            //==> DOM Object GET 3���� ��� ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
            $("button").on("click" , function() {
                var id=$("input:text").val();
                var pw=$("input:text").val();

                if(id == null || id.length <1) {
                    alert('ID �� �Է����� �����̽��ϴ�.');
                    $("#truckId").focus();
                    return;
                }

                if(pw == null || pw.length <1) {
                    alert('�н����带 �Է����� �����̽��ϴ�.');
                    $("#truckPassword").focus();
                    return;
                }

                $("form").attr("method","POST").attr("action","/truck/loginTruck").attr("target","_parent").submit();
            });
        });

        //============= ȸ��������ȭ���̵� =============
        $( function() {
            //==> DOM Object GET 3���� ��� ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
            $("a[href='#' ]").on("click" , function() {
                self.location = "/truck/addTruck"
            });
        });

    </script>

        </head>

<body>

<div class="container">

    <div class="page-header">
        <h3 class=" text-info">Ʈ���α���</h3>
    </div>

    <!--  ȭ�鱸�� div Start /////////////////////////////////////-->
    <div class="container">
        <!--  row Start /////////////////////////////////////-->

                <br/><br/>

                <div class="jumbotron">
                    <h1 class="text-center">�� &nbsp;&nbsp;�� &nbsp;&nbsp;��</h1>

                    <form class="form-horizontal">

                        <div class="form-group">
                            <label for="truckId" class="col-sm-4 control-label">�� �� ��</label>
                            <div class="col-sm-6">
                                <input type="text" class="form-control" name="truckId" id="truckId"  placeholder="���̵�" >
                            </div>
                        </div>

                        <div class="form-group">
                            <label for="truckPassword" class="col-sm-4 control-label">�� �� �� ��</label>
                            <div class="col-sm-6">
                                <input type="truckPassword" class="form-control" name="truckPassword" id="truckPassword" placeholder="�н�����" >
                            </div>
                        </div>

                        <div class="form-group">
                            <div class="col-sm-offset-4 col-sm-6 text-center">
                                <button type="button" class="btn btn-primary"  >�� &nbsp;�� &nbsp;��</button>
                                <a class="btn btn-primary btn" href="#" role="button">ȸ &nbsp;�� &nbsp;�� &nbsp;��</a>
                            </div>
                        </div>

                    </form>
                </div>

            </div>

        </div>
        <!--  row Start /////////////////////////////////////-->

    </div>

</body>

</html>
