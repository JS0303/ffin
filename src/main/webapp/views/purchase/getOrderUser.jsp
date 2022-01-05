<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page pageEncoding="EUC-KR" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!doctype html>
<html lang="ko">
<meta charset="EUC-KR">

<head>
    <jsp:include page="../../common/lib.jsp"/>

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
<jsp:include page="/views/navbar.jsp"/>
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
        var myLatlng = new google.maps.LatLng(35.837143, 128.558612); // 위치값 위도 경도
        var Y_point = 35.837143; // Y 좌표
        var X_point = 128.558612; // X 좌표
        var zoomLevel = 18; // 지도의 확대 레벨 : 숫자가 클수록 확대정도가 큼
        var markerTitle = "대구광역시"; // 현재 위치 마커에 마우스를 오버을때 나타나는 정보
        var markerMaxWidth = 300; // 마커를 클릭했을때 나타나는 말풍선의 최대 크기
        // 말풍선 내용
        var contentString = '<div>' +
            '<h2>대구남구</h2>' +
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
        google.maps.event.addListener(marker, 'click', function () {
            infowindow.open(map, marker);
        });
    });

    /* Iamport 환불시스템*/
    function cancelPay() {
        alert("dddd")
        var orderId = $("input[name='payId']").val();
        jQuery.ajax({
            url: "/purchase/json/payRefund/" + orderId, // 예: http://www.myservice.com/payments/cancel
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
 	 	 							 displayValue +=   "<option selected value='4'>환불완료</option>"
 	 	 							+ "</select>";
 	 	 						var value = "<td>"+JSONData.order.refundDate+"</td>";
 	 							 */
                /*var result = "<p>환불완료 <i class='far fa-clock'></i>" + JSONData.order.refundDate + "</p>";*/

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
                            <label class="btn btn-outline-primary" for="btnradio1">구매의사 취소</label>
                        </div>
                    </div>

                    <div class="container-fluid">
                        <div class="row">
                            <input type="radio" class="btn-check" name="orderCancelReason" id="btnradio2"
                                   autocomplete="off" value="2">
                            <label class="btn btn-outline-primary" for="btnradio2">메뉴 및 수량 변경</label>
                        </div>
                    </div>

                    <div class="container-fluid">
                        <div class="row">
                            <input type="radio" class="btn-check" name="orderCancelReason" id="btnradio3"
                                   autocomplete="off" value="3">
                            <label class="btn btn-outline-primary" for="btnradio3">주문접수 지연</label>
                        </div>
                    </div>
                    <div class="container-fluid">
                        <div class="row">
                            <input type="radio" class="btn-check" name="orderCancelReason" id="btnradio4"
                                   autocomplete="off" value="4">
                            <label class="btn btn-outline-primary" for="btnradio4">기    타</label>
                        </div>
                    </div>


                </div>
                <div class="modal-footer">
                    <button class="btn btn-primary" data-bs-dismiss="modal" aria-label="Close">취소</button>
                    <button class="btn btn-primary" data-bs-target="#exampleModalToggle2" data-bs-toggle="modal">다 음
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
                    정말로 주문취소 하나요??
                </div>
                <div class="modal-footer">

                    <button class="btn btn-primary" data-bs-dismiss="modal" aria-label="Close">취소</button>
                    <button class="btn btn-primary" onclick="cancelPay()">확인</button>
                </div>
            </div>
        </div>
    </div>
    <div class="container py-4">
        <header class="pb-4 mb-5 border-bottom">
            <span class="fs-1">현재주문정보</span>

        </header>

        <div class="row">
            <div class="col-md-6">
                <div class="h-100 p-5 bg-light border rounded-3">
                    <div id="order"></div>
                    <c:set var="i" value="0"/>
                    <c:forEach var="cart" items="${map.get('list')}">
                        <c:set var="i" value="${i+1}"/>


                        <div class="form-check">
                            <input class="form-check-input" type="checkbox" value="" id="flexCheckChecked" checked>
                            <label class="form-check-label" for="flexCheckChecked">
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
                    </label>
                </div>

                        <input type="hidden" id="odMenuName" name="odMenuName" value="${cart.odMenuName}"/>
                        <input type="hidden" id="odOptionGroupName" name="odOptionGroupName"
                               value="${cart.odOptionGroupName}"/>
                        <input type="hidden" id="odOptionName" name="odOptionName" value="${cart.odOptionName}"/>
                        <input type="hidden" id="odMenuQty" name="odMenuQty" value="${cart.odMenuQty}"/>
                        <input type="hidden" id="odMenuPrice" name="odMenuPrice" value="${cart.odMenuPrice}"/>
                        <input type="hidden" id="odOptionPrice" name="odOptionPrice" value="${cart.odOptionPrice}"/>
                        <input type="hidden" id="odMenuImage" name="odMenuImage" value="${cart.odMenuImage}"/>
                        <input type="hidden" id="odMenuQtyFlag" name="odMenuQtyFlag" value="${cart.odMenuQtyFlag}"/>


                    </c:forEach>

                    <div id="total"></div>
                    <button type="submit" class="btn btn-primary"></button>
                    <a class="btn btn-primary" data-bs-toggle="modal" href="#exampleModalToggle" role="button">주문취소</a>
                </div>
            </div>
            <div class="col-md-6">
                <div class="h-100 p-5 bg-light border rounded-3">
                    <h2>푸드트럭위치</h2>
                    <div id="map_ma"></div>


                </div>
            </div>
        </div>
        <input type="text" name="payId" id="payId" value="${purchase.payId}">


    </div>
</main>
<jsp:include page="/views/footer.jsp"/>




<%--
<script>
    $(function () {
        var odMenuNameCount = $("input[name='odMenuName']").length;


        var odMenuNameL;
        var odOptionGroupNameL;
        var odOptionNameL;
        var odMenuQtyL;
        var odMenuPriceL;
        var odOptionPriceL;
        var odMenuImageL;

        for (var i = 0; i < odMenuNameCount; i++) {
            var odMenuName = $("input[name='odMenuName']").eq(i).val();
            var odOptionGroupName = $("input[name='odOptionGroupName']").eq(i).val();
            var odOptionName = $("input[name='odOptionName']").eq(i).val();
            var odMenuQty = $("input[name='odMenuQty']").eq(i).val();
            var odMenuPrice = $("input[name='odMenuPrice']").eq(i).val();
            var odOptionPrice = $("input[name='odOptionPrice']").eq(i).val();
            var odMenuImage = $("input[name='odMenuImage']").eq(i).val();
            var odMenuQtyFlag = $("input[name='odMenuQtyFlag']").eq(i).val();


            var odMenuImageCopy;
            var odMenuNameCopy;
            var odOptionGroupNameCopy;
            var odOptionNameCopy;
            var odMenuQtyCopy;
            var odMenuPriceCopy;
            var odOptionPriceCopy;
            var test2;
            var totalPrice;


            if (odMenuNameCopy != undefined && odMenuQtyFlag == 0) {
                odMenuNameCopy = odMenuNameCopy + "," + odMenuName;
                odMenuImageCopy = odMenuImageCopy + "," + odMenuImage;
                odMenuQtyCopy = odMenuQtyCopy + "," + odMenuQty;
                odMenuPriceCopy = odMenuPriceCopy + "," + odMenuPrice;
                totalPrice = totalPrice + parseInt(odMenuPrice);
            } else if (odMenuNameCopy == undefined) {

                odMenuNameCopy = odMenuName;
                odMenuImageCopy = odMenuImage;
                odMenuQtyCopy = odMenuQty;
                odMenuPriceCopy = odMenuPrice;
                totalPrice = parseInt(odMenuPrice);

            }

            odMenuNameL = odMenuNameCopy.split(",");
            odMenuImageL = odMenuImageCopy.split(",");
            odMenuQtyL = odMenuQtyCopy.split(",");
            odMenuPriceL = odMenuPriceCopy.split(",").map(Number);

            if(odOptionNameCopy == undefined){
                odOptionNameCopy = odOptionName;
                test2 = odMenuName;
                odOptionGroupNameCopy = odOptionGroupName;
                odOptionPriceCopy = odOptionPrice;

            }else if(test2 != odMenuName &&  odOptionNameCopy.substring(odOptionNameCopy.length-1,odOptionNameCopy.length) != "/"){
                odOptionNameCopy = odOptionNameCopy +"/"+odOptionName;
                odOptionGroupNameCopy = odOptionGroupNameCopy +"/"+odOptionGroupName;
                odOptionPriceCopy = odOptionPriceCopy +"/"+odOptionPrice;

            }else if(odOptionNameCopy != undefined){

                odOptionNameCopy = odOptionNameCopy +","+odOptionName;
                test2 = odMenuName;
                odOptionGroupNameCopy = odOptionGroupNameCopy +","+odOptionGroupName;
                odOptionPriceCopy = odOptionPriceCopy+odOptionPrice;
            }

            odOptionNameL = odOptionNameCopy.split("/");
            odOptionGroupNameL = odOptionGroupNameCopy.split("/");
            odOptionPriceL = odOptionPriceCopy.split("/").map(Number);


            alert("total"+odMenuPriceL)
            alert("price"+odOptionPriceL)


        }




        var menuPrice = 0;
        for (var i = 0; i < odMenuNameL.length; i++) {

            alert(odMenuNameL[i]);
            alert(odOptionNameL[i]);

            menuPrice += (odOptionPriceL[i]+odMenuPriceL[i]);




            divElemApply1 = "<div class=\"card mb-3\" style=\"max-width:300px; height: 90px\">" +
                " <div class=\"row g-0\">" +
                "<div class=\"col-md-4\">" +
                "<img src=\"/resources/image/1.jpg\" class=\"img-fluid rounded-start\" alt=\"image\">" +
                "</div>" +
                "<div class=\"col-md-8\">" +
                "<div class=\"card-body\">" +
                "<h5 class=\"card-title\">" + odMenuNameL[i] + "</h5>" +
                "<p class=\"card-text\"><small class=\"text-muted\">옵션 "+odOptionNameL[i]+" :"+odOptionGroupNameL[i]+"  :</small></p>" +
                "<p class=\"card-text\"><small class=\"text-muted\">수량 :"+odMenuQtyL[i]+" 가격 :"+(odOptionPriceL[i]+odMenuPriceL[i])+" </small></p>" +
                "</div>" +
                "</div>" +
                "</div>" +
                "</div>"


            $('#order').append(divElemApply1);

        }
        alert(menuPrice)

        divElemApply2 = "<input type=\"text\" name=\"orderPrice\" id=\"orderPrice\" value=\""+menuPrice+"\">"

        $('#total').append(divElemApply2);


    });
--%>


    /*




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



*/


</script>
</body>
</html>



