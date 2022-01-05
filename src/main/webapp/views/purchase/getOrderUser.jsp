<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page pageEncoding="EUC-KR" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!doctype html>
<html lang="ko">
<meta charset="EUC-KR">

<head>

    <!-- Required meta tags -->
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">

    <style>
        #map_ma {
            width: 100%;
            height: 400px;
            clear: both;
            border: solid 1px red;
        }
        h5.card-title{
            font-size: 15px;
        }

    </style>
</head>
<body>
<jsp:include page="/views/toolbar.jsp"/>
<script src="https://code.jquery.com/jquery-3.3.1.min.js"
        integrity="sha256-FgpCb/KJQlLNfOu91ta32o/NMZxltwRo8QtmkMRdAu8="
        crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p"
        crossorigin="anonymous"></script>
<script type="text/javascript" src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script type="text/javascript"
        src="http://maps.google.com/maps/api/js?key=AIzaSyBmxlLXS2GGFBgeQTt6n4YPhxU6NKu4Kx8"></script>

<script type="text/javascript">

    $(document).ready(function () {
        var myLatlng = new google.maps.LatLng(35.837143, 128.558612); // ��ġ�� ���� �浵
        var Y_point = 35.837143; // Y ��ǥ
        var X_point = 128.558612; // X ��ǥ
        var zoomLevel = 18; // ������ Ȯ�� ���� : ���ڰ� Ŭ���� Ȯ�������� ŭ
        var markerTitle = "�뱸������"; // ���� ��ġ ��Ŀ�� ���콺�� �������� ��Ÿ���� ����
        var markerMaxWidth = 300; // ��Ŀ�� Ŭ�������� ��Ÿ���� ��ǳ���� �ִ� ũ��
        // ��ǳ�� ����
        var contentString = '<div>' +
            '<h2>�뱸����</h2>' +
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
        google.maps.event.addListener(marker, 'click', function () {
            infowindow.open(map, marker);
        });
    });

    /* Iamport ȯ�ҽý���*/
    function cancelPay() {
        alert("dddd")
        var orderId = $("input[name='payId']").val();
        jQuery.ajax({
            url: "/purchase/json/payRefund/" + orderId, // ��: http://www.myservice.com/payments/cancel
            type: "GET",
            dataType: "json",
            headers: {
                "Accept": "application/json",
                "Content-Type": "application/json"
            },
            success: function (JSONData, status) {

                /* var displayValue = "<select class='custom-select' name='orderStatus' id='

                ${flight.orderId}' onChange='order2('

                ${flight.orderId}')' >"
 	 	 							 displayValue +=   "<option selected value='4'>ȯ�ҿϷ�</option>"
 	 	 							+ "</select>";
 	 	 						var value = "<td>"+JSONData.order.refundDate+"</td>";
 	 							 */
                /*var result = "<p>ȯ�ҿϷ� <i class='far fa-clock'></i>" + JSONData.order.refundDate + "</p>";*/

                /*      $("#" + JSONData.orderId + "s").remove();
                      $("#" + JSONData.orderId + "").html(result);*/
            }

        });
    }


</script>


<main>
    <div class="modal fade" id="exampleModalToggle" aria-hidden="true" aria-labelledby="exampleModalToggleLabel"
         tabindex="-1">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalToggleLabel">Modal 1</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">


                    <div class="container-fluid">
                        <div class="row">
                            <input type="radio" class="btn-check" name="orderCancelReason" id="btnradio1"
                                   autocomplete="off" value="1" checked>
                            <label class="btn btn-outline-primary" for="btnradio1">�����ǻ� ���</label>
                        </div>
                    </div>

                    <div class="container-fluid">
                        <div class="row">
                            <input type="radio" class="btn-check" name="orderCancelReason" id="btnradio2"
                                   autocomplete="off" value="2">
                            <label class="btn btn-outline-primary" for="btnradio2">�޴� �� ���� ����</label>
                        </div>
                    </div>

                    <div class="container-fluid">
                        <div class="row">
                            <input type="radio" class="btn-check" name="orderCancelReason" id="btnradio3"
                                   autocomplete="off" value="3">
                            <label class="btn btn-outline-primary" for="btnradio3">�ֹ����� ����</label>
                        </div>
                    </div>
                    <div class="container-fluid">
                        <div class="row">
                            <input type="radio" class="btn-check" name="orderCancelReason" id="btnradio4"
                                   autocomplete="off" value="4">
                            <label class="btn btn-outline-primary" for="btnradio4">��    Ÿ</label>
                        </div>
                    </div>


                </div>
                <div class="modal-footer">
                    <button class="btn btn-primary" data-bs-dismiss="modal" aria-label="Close">���</button>
                    <button class="btn btn-primary" data-bs-target="#exampleModalToggle2" data-bs-toggle="modal">�� ��
                    </button>
                </div>
            </div>
        </div>
    </div>
    <div class="modal fade" id="exampleModalToggle2" aria-hidden="true" aria-labelledby="exampleModalToggleLabel2"
         tabindex="-1">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalToggleLabel2">Modal 2</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    ������ �ֹ���� �ϳ���??
                </div>
                <div class="modal-footer">

                    <button class="btn btn-primary" data-bs-dismiss="modal" aria-label="Close">���</button>
                    <button class="btn btn-primary" onclick="cancelPay()">Ȯ��</button>
                </div>
            </div>
        </div>
    </div>
    <div class="container py-4">
        <header class="pb-4 mb-5 border-bottom">
            <span class="fs-1">�����ֹ�����</span>

        </header>

        <div class="row">
            <div class="col-md-6">
                <div class="h-100 p-5 bg-light border rounded-3">
                    <c:set var="i" value="0"/>
                    <c:forEach var="cart" items="${map.get('list')}">
                        <c:set var="i" value="${i+1}" />
<script>
    var orderNo = 'fff';
    console.log(orderNo);
</script>






                        <div class="card mb-3 h-10" style="width: 300px; height: 90px" >
                            <div class="row g-0">
                                <div class="col-md-4">
                                    <img src="/resources/image/1.jpg" class="img-fluid rounded-start" alt="image">
                                </div>
                                <div class="col-md-8">
                                    <div class="card-body">
                                        <h5 class="card-title">${cart.odMenuName}</h5>
                                        <p class="card-text"></p>
                                        <p class="card-text"><small class="text-muted">${cart.odMenuPrice + cart.odOptionPrice}</small></p>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <input type="hidden" id="odMenuName" name="odMenuName" value="${cart.odMenuName}"/>
                        <input type="hidden" id="odOptionGroupName" name="odOptionGroupName" value="${cart.odOptionGroupName}"/>
                        <input type="hidden" id="odOptionName" name="odOptionName" value="${cart.odOptionName}"/>
                        <input type="hidden" id="odMenuQty" name="odMenuQty" value="${cart.odMenuQty}"/>
                        <input type="hidden" id="odMenuPrice" name="odMenuPrice" value="${cart.odMenuPrice}"/>
                        <input type="hidden" id="odOptionPrice" name="odOptionPrice" value="${cart.odOptionPrice}"/>
                        <input type="hidden" id="odMenuImage" name="odMenuImage" value="${cart.odMenuImage}"/>
                    </c:forEach>
                    <button type="submit" class="btn btn-primary"></button>
                    <a class="btn btn-primary" data-bs-toggle="modal" href="#exampleModalToggle" role="button">�ֹ����</a>
                </div>
            </div>
            <div class="col-md-6">
                <div class="h-100 p-5 bg-light border rounded-3">
                    <h2>Ǫ��Ʈ����ġ</h2>
                    <div id="map_ma"></div>


                </div>
            </div>
        </div>
        <input type="text" name="payId" id="payId" value="${purchase.payId}">


    </div>
</main>
<jsp:include page="/views/footer.jsp"/>
</body>
</html>



