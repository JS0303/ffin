<%@ page contentType="text/html; charset=euc-kr" %>
<%@ page pageEncoding="euc-kr"%>


<!DOCTYPE html>

<html lang="ko">

<head>
    <meta charset="euc-kr">

    <!-- ���� : http://getbootstrap.com/css/   ���� -->
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />

</head>

<body>

<!--  ȭ�鱸�� div Start /////////////////////////////////////-->
<div class="container">

    <div class="page-header">
        <h3 class=" text-info">Ʈ��������ȸ</h3>
        <h5 class="text-muted">�� Ʈ�� ������ <strong class="text-danger">�ֽ������� ����</strong>�� �ּ���.</h5>
    </div>

    <div class="row">
        <div class="col-xs-4 col-md-2"><strong>�� �� ��</strong></div>
        <div class="col-xs-8 col-md-4">${truck.truckId}</div>
        <div class="col-xs-4 col-md-2"><strong>�� ȣ</strong></div>
        <div class="col-xs-8 col-md-4">${truck.truckName}</div>
        <div class="col-xs-4 col-md-2"><strong>�� ��</strong></div>
        <div class="col-xs-8 col-md-4">${truck.truckAVGStar}</div>
        <div class="col-xs-4 col-md-2"><strong>�� �� �� �� �� ��</strong></div>
        <div class="col-xs-8 col-md-4">${truck.truckProImg}</div>
        <div class="col-xs-4 col-md-2"><strong>�� �� �� ��</strong></div>
        <div class="col-xs-8 col-md-4">${truck.truckBusiStatus}</div>
        <div class="col-xs-4 col-md-2"><strong>�� ȭ �� ȣ</strong></div>
        <div class="col-xs-8 col-md-4">${truck.truckPhone}</div>
        <div class="col-xs-4 col-md-2"><strong>�� ��</strong></div>
        <div class="col-xs-8 col-md-4">${truck.truckMapLa}</div>
        <div class="col-xs-4 col-md-2"><strong>�� ��</strong></div>
        <div class="col-xs-8 col-md-4">${truck.truckMapLo}</div>
        <div class="col-xs-4 col-md-2"><strong>�� �� �� ��</strong></div>
        <div class="col-xs-8 col-md-4">${truck.truckNoticeContent}</div>
        <div class="col-xs-4 col-md-2"><strong>�� �� �� ��</strong></div>
        <div class="col-xs-8 col-md-4">${truck.truckNoticeImg}</div>
    </div>

    <hr/>



</div>
<!--  ȭ�鱸�� div Start /////////////////////////////////////-->

</body>

</html>