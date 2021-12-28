<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html lang="ko">
<head>
    <title>������������ϱ�</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" >
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" >
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" ></script>
    <script type="text/javascript" src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
    <script type="text/javascript" src="http://maps.google.com/maps/api/js?key=AIzaSyBmxlLXS2GGFBgeQTt6n4YPhxU6NKu4Kx8" ></script>
    <style>
        #map_ma {width:100%; height:400px; clear:both; border:solid 1px red;}
    </style>
</head>
<body>

<script type="text/javascript">
   /* $(document).ready(function() {
        var myLatlng = new google.maps.LatLng(35.837143,128.558612); // ��ġ�� ���� �浵
     var Y_point = 35.837143; // Y ��ǥ
     var X_point = 128.558612; // X ��ǥ
     var zoomLevel = 18; // ������ Ȯ�� ���� : ���ڰ� Ŭ���� Ȯ�������� ŭ
     var markerTitle = "�뱸������"; // ���� ��ġ ��Ŀ�� ���콺�� �������� ��Ÿ���� ����
     var markerMaxWidth = 300; // ��Ŀ�� Ŭ�������� ��Ÿ���� ��ǳ���� �ִ� ũ��
        // ��ǳ�� ����
     var contentString = '<div>' +
         '<h2>�뱸����</h2>'+
         '<p>�ȳ��ϼ���. ���������Դϴ�.</p>' +

         '</div>';
     var myLatlng = new google.maps.LatLng(Y_point, X_point);
     var mapOptions = {
         zoom: zoomLevel,
         center: myLatlng,
         mapTypeId: google.maps.MapTypeId.ROADMAP
     }
     var map = new google.maps.Map(document.getElementById('map_ma'), mapOptions);
     var marker = new google.maps.Marker({
         position: myLatlng,
         map: map,
         title: markerTitle
     });
     var infowindow = new google.maps.InfoWindow(
         {
             content: contentString,
             maxWizzzdth: markerMaxWidth
         }
         );
     google.maps.event.addListener(marker, 'click', function() {
         infowindow.open(map, marker);
     });
    });*/
</script>

<div class="container">

    <!-- �ٴܷ��̾ƿ�  Start /////////////////////////////////////-->
    <div class="row">

        <!--  Menu ���� Start /////////////////////////////////////-->
        <div class="col-md-3">
            <table class="table table-hover table-striped" >

                <thead>
                <tr>
                    <th align="center">No</th>
                    <th align="left" >ȸ�� ID</th>
                    <th align="left">ȸ����</th>
                    <th align="left">�̸���</th>
                    <th align="left">��������</th>
                </tr>
                </thead>

                <tbody>

                <c:set var="i" value="0" />
                <c:forEach var="cart" items="${map.get('list')}">
                    <c:set var="i" value="${ i+1 }" />
                    <tr>
                        <td align="center">${ i }</td>
                        <td align="left"  title="Click : ȸ������ Ȯ��">${cart.odMenuName}</td>
                        <td align="left">${cart.odOptionGroupName}</td>
                        <td align="left">${cart.odOptionName}</td>
                        <td align="left">
                            <i class="glyphicon glyphicon-ok" id= "${cart.odMenuQty}"></i>
                            <input type="hidden" value="${cart.odMenuPrice}">
                        </td>
                    </tr>
                </c:forEach>

                </tbody>

            </table>


        </div>

        <!--  Menu ���� end /////////////////////////////////////-->

        <!--  Main start /////////////////////////////////////-->
        <div class="col-md-9">
            <div class="jumbotron ">


                <div id="map_ma"></div>

            </div>
        </div>

    </div>
</div>

</body>
</html>



