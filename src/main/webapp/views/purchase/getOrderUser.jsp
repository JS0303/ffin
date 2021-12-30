<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!doctype html>
<html lang="ko">
<meta charset="EUC-KR">

<head>
<jsp:include page="/views/toolbar.jsp" />
<!-- Required meta tags -->
<meta name="viewport" content="width=device-width, initial-scale=1">
<!-- Bootstrap CSS -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">

    <style>
        #map_ma {width:100%; height:400px; clear:both; border:solid 1px red;}

    </style>
</head>
<body>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
<script type="text/javascript" src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script type="text/javascript" src="http://maps.google.com/maps/api/js?key=AIzaSyBmxlLXS2GGFBgeQTt6n4YPhxU6NKu4Kx8" ></script>

<script type="text/javascript">
/*    $(document).ready(function() {
        var myLatlng = new google.maps.LatLng(35.837143,128.558612); // 위치값 위도 경도
     var Y_point = 35.837143; // Y 좌표
     var X_point = 128.558612; // X 좌표
     var zoomLevel = 18; // 지도의 확대 레벨 : 숫자가 클수록 확대정도가 큼
     var markerTitle = "대구광역시"; // 현재 위치 마커에 마우스를 오버을때 나타나는 정보
     var markerMaxWidth = 300; // 마커를 클릭했을때 나타나는 말풍선의 최대 크기
        // 말풍선 내용
     var contentString = '<div>' +
         '<h2>대구남구</h2>'+
         '<p>안녕하세요. 구글지도입니다.</p>' +

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
<main>
    <div class="container py-4">
        <header class="pb-4 mb-5 border-bottom">
            <span class="fs-1">현재주문정보</span>

        </header>

        <div class="row align-items-md-stretch">
            <div class="col-md-6">
                <div class="h-100 p-5 bg-light border rounded-3">
                    <table class="table table-hover table-striped" >

                        <thead>
                        <tr>
                            <th align="center">No</th>
                            <th align="left" >회원 ID</th>
                            <th align="left">회원명</th>
                            <th align="left">이메일</th>
                            <th align="left">간략정보</th>
                        </tr>
                        </thead>

                        <tbody>

                        <c:set var="i" value="0" />
                        <c:forEach var="cart" items="${map.get('list')}">
                            <c:set var="i" value="${ i+1 }" />
                            <tr>
                                <td align="center">${ i }</td>
                                <td align="left"  title="Click : 회원정보 확인">${cart.odMenuName}</td>
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
                    <button type="button" class="btn btn-secondary">결제취소</button>
                </div>
            </div>
            <div class="col-md-6">
                <div class="h-100 p-5 bg-light border rounded-3">
                    <h2>푸드트럭위치</h2>
                    <div id="map_ma"></div>


                </div>
            </div>
        </div>

        <footer class="pt-3 mt-4 text-muted border-top">
            &copy; 2021
        </footer>
    </div>
</main>
<jsp:include page="/views/footer.jsp" />
</body>
</html>



