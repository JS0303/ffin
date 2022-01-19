<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html lang="ko">

<!doctype html>
<html lang="ko">
<meta charset="EUC-KR">

<!-- Bootstrap CSS -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
<head>
    <jsp:include page="../../common/lib.jsp"/>
</head>
<body>
<jsp:include page="/views/navbar.jsp"/>
<!-- Bootstrap Dropdown Hover CSS -->
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.10.2/dist/umd/popper.min.js" integrity="sha384-7+zCNj/IqJ95wo16oMtfsKbZ9ccEh31eOz1HGyDuCQ6wgnyJNSYdrPa03rtR1zdB" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.min.js" integrity="sha384-QJHtvGhmr9XOIpI6YVutG+2QOK9T+ZnN4kzFN1RtK3zEFEIsxhlmWl5/YESvpZ13" crossorigin="anonymous"></script>

<style>
    .btn-outline-success {
        color: #ffba49;
        border-color: #ffba49;
    }

    .btn-check:active+.btn-outline-success, .btn-check:checked+.btn-outline-success, .btn-outline-success.active, .btn-outline-success.dropdown-toggle.show, .btn-outline-success:active {
        color: #fff;
        background-color: #ffba49;
        border-color: #ffba49;
    }

    .btn-primary {
        color: #f8f9fa;
        background-color: #ffba49;
        border-color: #ffba49;
    }
    .row {
        display: -ms-flexbox;
        display: flex;
        -ms-flex-wrap: wrap;
        flex-wrap: wrap;
        margin-right: -28px;
        margin-left: -17px;
    }

    /*장바구니내부 스크롤*/
    .card-body ul, .order-wrap-pc ul {
        max-height: 300px;
        overflow-x: hidden;
        overflow-y: auto;
    }
    body{
        margin-top: 80px;
    }
</style>
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
                            <input type="radio" class="btn-check" name="orderNopeReason" id="btnradio1"
                                   autocomplete="off" value="1" checked>
                            <label class="btn btn-outline-primary" for="btnradio1">고객 요청</label>
                        </div>
                    </div>

                    <div class="container-fluid">
                        <div class="row">
                            <input type="radio" class="btn-check" name="orderNopeReason" id="btnradio2"
                                   autocomplete="off" value="2">
                            <label class="btn btn-outline-primary" for="btnradio2">고객 정보 부정확</label>
                        </div>
                    </div>

                    <div class="container-fluid">
                        <div class="row">
                            <input type="radio" class="btn-check" name="orderNopeReason" id="btnradio3"
                                   autocomplete="off" value="3">
                            <label class="btn btn-outline-primary" for="btnradio3">주문 지연</label>
                        </div>
                    </div>
                    <div class="container-fluid">
                        <div class="row">
                            <input type="radio" class="btn-check" name="orderNopeReason" id="btnradio4"
                                   autocomplete="off" value="4">
                            <label class="btn btn-outline-primary" for="btnradio4">재료 소진</label>
                        </div>
                    </div>
                    <div class="container-fluid">
                        <div class="row">
                            <input type="radio" class="btn-check" name="orderNopeReason" id="btnradio5"
                                   autocomplete="off" value="5">
                            <label class="btn btn-outline-primary" for="btnradio4">기타</label>
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




    <!-- Modal -->
    <div class="modal fade" id="staticBackdrop" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="staticBackdropLabel">영업모드</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <c:if test="${truck.truckBusiStatus.equals('1')}">
                        영업종료하시겠습니까??
                    </c:if>
                    <c:if test="${truck.truckBusiStatus.equals('0')}">
                        영업시작하시겠습니까??
                    </c:if>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
                    <button type="button" class="btn btn-primary" id="busiStatus">등록</button>
                </div>
            </div>
        </div>
    </div>


    <div class="container py-4">
        <header class="pb-4 mb-5 py-4 border-bottom">
            <span class="fs-1">주문내역</span>
            <input type="hidden" id="truckId" name="truckId"
                   value="${truck.truckId}"/>
        </header>

        <div class="container-fluid">
            <div class="row justify-content-evenly">

                <div class="col-5 p-3 mb-2  bg-light text-dark">

                    <div class="row ">
                        <div class="col-2">

                            <button class="btn btn-primary" id="ing" type="button">처리중</button>

                            <button class="btn btn-primary" id="end" type="button">픽업완료</button>

                            <button class="btn btn-primary" id="cancel" type="button">주문취소</button>
                        </div>
                        <div class="col-10">
                            <div class="row justify-content-between">
                                <div class="col-6 text-center"> 전체 :</div>
                                <div class="col-6">
                                    <div class="form-check form-switch">
                                        <c:if test="${truck.truckBusiStatus.equals('1')}">
                                            <input class="form-check-input" type="checkbox" role="switch"
                                                   id="swCh" name="swCh"  data-bs-toggle="modal" data-bs-target="#staticBackdrop" checked>
                                            <label class="form-check-label" for="swCh">영업중</label>
                                        </c:if>
                                        <c:if test="${truck.truckBusiStatus.equals('0')}">
                                            <input class="form-check-input" type="checkbox" role="switch"
                                                   id="swCh" name="swCh"  data-bs-toggle="modal" data-bs-target="#staticBackdrop">
                                            <label class="form-check-label" for="swCh">영업종료</label>
                                        </c:if>

                                    </div>
                                </div>
                                <br><br>
                            </div>

                            <c:set var="i" value="0"/>
                            <c:forEach var="cart" items="${map.get('list')}">
                                <c:set var="i" value="${i+1}"/>

                                <hr class="my-2">
                                <div class="row">
                                    <div class="col-1">
                                            ${i}
                                    </div>
                                    <div class="col-8">
                                        <div class="row">
                                            <div class="col-4">
                                                <a type="button" class="text-break" id="orderUserId">${cart.orderUserId.userId}</a>
                                                <input type="hidden" id="orderNo" name="orderNo" value="${cart.orderNo}"/>


                                            </div>
                                            <div class="col-6" id="orderPickUp">
                                                픽업희망시간 : ${cart.orderPickUpTime}
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col-4">
                                                <a href="#" class="text-break"><%--${cart.odMenuName}--%></a>

                                            </div>
                                            <div class="col-6">
                                                예상조리시간 : ${cart.orderCookingTime}
                                            </div>
                                        </div>

                                    </div>
                                    <div class="col-3">
                                        <c:if test="${cart.orderStatus == 1}">
                                            주문대기
                                        </c:if>
                                        <c:if test="${cart.orderStatus == 2}">
                                            주문접수
                                        </c:if>
                                        <c:if test="${cart.orderStatus == 3}">
                                            픽업요청
                                        </c:if>
                                        <c:if test="${cart.orderStatus == 4}">
                                            픽업완료
                                        </c:if>
                                        <c:if test="${cart.orderStatus == 5}">
                                            주문취소
                                        </c:if>

                                    </div>
                                </div>

                                <%--                                <input type="hidden" id="orderNo" name="orderNo" value="${cart.odOrderNo.orderNo}"/>--%>
                                <input type="hidden" id="userId" name="userId"
                                       value="${cart.orderUserId.userId}"/>
                                <input type="hidden" id="orderStatus" name="orderStatus"
                                       value="${cart.orderStatus}"/>
                                <input type="hidden" id="odMenuPrice" name="orderPickUpTime"
                                       value="${cart.orderPickUpTime}"/>
                                <input type="hidden" id="orderCookingTime" name="orderCookingTime"
                                       value="${cart.orderCookingTime}"/>
                                <input type="hidden" name="searchCondition" value="${search.searchCondition}">

                                <%--<input type="hidden" id="odMenuName" name="odMenuName" value="${cart.odMenuName}"/>--%>

                            </c:forEach>
                        </div>
                    </div>


                </div>

                <div class="col-6 p-3 mb-2 bg-light  text-dark">
                    <div class="row " id="CookingTime">

                    </div>
                    <hr class="my-2">
                    <div class="row">

                        <div class="col-7">

                            <div class="row" id="oRt">
                                <label for="orderRequest" class="col-form-label">주문요청사항 :</label>
                                <textarea class="form-control" id="orderRequest" name="orderRequest"
                                          value="" disabled></textarea>
                            </div>
                            <div class="row" id="cancelOrder">

                            </div>
                            <br>
                            <div class="row" id="opt">
                                <label for="orderRequest" class="col-form-label">픽업희망시간
                                    : </label>
                            </div>
                            <hr class="my-2">
                            <div class="row" id="list">

                                <label for="orderRequest" class="col-form-label">주문내역 :</label>

                                <div id="order"></div>

                                <div id="total"><p class="text-end">결제금액 : </p> </div>
                            </div>

                        </div>
                        <div class="col-1">
                            <div class="d-flex" style="height: 672px;">
                                <div class="vr"></div>
                            </div>
                        </div>

                        <div class="col-4">
                            <div class="row" id="orderMenuHidden">
                                <div id="pointNoCouponNo"></div>
                                <label for="orderRequest" class="col-form-label">고객정보
                                    : </label>
                            </div>

                            <div class="row" id="img">





                            </div>

                            <br>
                            <div class="row" id="usId" >
                                <input type="hidden" name="usId" value=""/>
                                ${purchase.orderUserId.userId}
                            </div>
                            <br>
                            <div class="row" id="orNo">
                                주문번호 :
                            </div>
                            <br>
                            <div class="row" id="paDa">
                                주문일시 :
                            </div>
                            <br>
                            <div class="row" id="usUN">
                                이름 :
                            </div>
                            <br>
                            <div class="row" id="usUP">
                                연락처 :
                            </div>
                            <br>

                            <div class="row" id="paOp">

                            </div>

                        </div>

                    </div>

                </div>
            </div>

        </div>

    </div>

</main>

<script>

    $("#busiStatus").on("click",function(){
        var truckId = $("input[name='truckId']").val();
        var tb = $("input[name='swCh']:checked").val();


        if(tb == 'on'){
            tb=1;
        }else if(tb==undefined){
            tb=0;
        }

        $.ajax({
            url: "/purchase/json/updateBusiStatus",
            method: "POST",
            contentType: "application/x-www-form-urlencoded; charset=UTF-8",
            data: {
                "truckId": truckId,
                "tb" : tb
            },
            success: function (data) {

                alert("영업모드 변경되었습니다!")

                window.location.reload();
            }
        });


    });

    $("#ing").on("click",function(){

        var truckId = $("input[name='truckId']").val();
        var search = "0";
        self.location = "/purchase/getOrderList?truckId="+truckId+"&search="+search

    });
    $("#cancel").on("click",function(){
        var truckId = $("input[name='truckId']").val();
        self.location = "/purchase/getOrderList?truckId="+truckId+"&search="+2
    })

    $("#end").on("click",function(){
        var truckId = $("input[name='truckId']").val();
        self.location = "/purchase/getOrderList?truckId="+truckId+"&search="+1
    })




    /*이용자아이디 클릭시*/
    $("a#orderUserId.text-break").on("click", function () {

        var orderNo = $(this).parent().find("input[name='orderNo']").val();
        var couponNo = 0;
        var pointNo = 0;

        $.ajax({
            url: "/purchase/json/getDetailOrder",
            method: "POST",
            contentType: "application/x-www-form-urlencoded; charset=UTF-8",
            data: {
                "orderNo": orderNo,
            },
            success: function (data) {

                if(data.purchase.payCouponNo==null){
                }else{

                    couponNo = data.purchase.payCouponNo.couponNo
                }

                if(data.purchase.payPointNo == null){
                }else{
                    pointNo = data.purchase.payPointNo.pointNo
                }
                var usId = "";
                var orNo = "";
                var paDa = "";
                var usUN = "";
                var usUP = "";
                var paOp = "";
                var img = "";
                var oRt = "";
                var opt = "";
                var total = "";
                var CookingTime = "";
                var orderMenuHidden = "";
                var pointNoCouponNo = "";
                var cancel = "";






               switch(data.purchase.orderCancelReason) {
                   case 1:
                       cancel = "<div style='margin-bottom: 30px;'>" +
                           " <label  class='form-label label-name'>주문취소사유</label>" +
                           "<input type='text' class='form-control' value='구매의사 취소'  readonly style='width: 340px;' >" +
                           "</div>";
                       break;
                   case 2 :
                       cancel = "<div style='margin-bottom: 30px;'>" +
                           " <label  class='form-label label-name'>주문취소사유</label>" +
                           "<input type='text' class='form-control' value='메뉴 및 수량 변경'  readonly style='width: 340px;' >" +
                           "</div>";
                       break;
                   case 3 :
                       cancel = "<div style='margin-bottom: 30px;'>" +
                           " <label  class='form-label label-name'>주문취소사유</label>" +
                           "<input type='text' class='form-control' value='주문접수 지연'  readonly style='width: 340px;' >" +
                           "</div>";
                       break;
                   case 4 :
                       cancel = "<div style='margin-bottom: 30px;'>" +
                           " <label  class='form-label label-name'>주문취소사유</label>" +
                           "<input type='text' class='form-control' value='기 타'  readonly style='width: 340px;' >" +
                           "</div>";
                       break;
               }
                switch(data.purchase.orderNopeReason){
                case 1 :
                    cancel = "<div style='margin-bottom: 30px;'>"+
                        "<label  class='form-label label-name'>주문거절사유</label>"+
                        "<input type='text' class='form-control' value='고객 요청' readonly style='width: 340px;' >"
                    break;
                case 2 :
                    cancel = "<div style='margin-bottom: 30px;'>"+
                        "<label  class='form-label label-name'>주문거절사유</label>"+
                        "<input type='text' class='form-control' value='고객 정보 부정확' readonly style='width: 340px;' >"
                    break;
                case 3 :
                    cancel = "<div style='margin-bottom: 30px;'>"+
                        "<label  class='form-label label-name'>주문거절사유</label>"+
                        "<input type='text' class='form-control' value='주문 지연' readonly style='width: 340px;' >"
                    break;
                case 4 :
                    cancel = "<div style='margin-bottom: 30px;'>"+
                        "<label  class='form-label label-name'>주문거절사유</label>"+
                        "<input type='text' class='form-control' value='재료 소진' readonly style='width: 340px;' >"
                    break;
                case 5 :
                    cancel = "<div style='margin-bottom: 30px;'>"+
                        "<label  class='form-label label-name'>주문거절사유</label>"+
                        "<input type='text' class='form-control' value='기 타' readonly style='width: 340px;' >"
                    break;
                }














                usId ="<input type='hidden' name='usId' value='"+data.purchase.orderUserId.userId+"'/>"+data.purchase.orderUserId.userId;

                orNo = "주문번호 :"+data.purchase.orderNo;

                paDa = "주문일시 :"+data.purchase.payDateTime;
 /*<time datetime="YYYY-MM-DD">
                      <i class="fas fa-calendar-alt mr-2"></i>${orderDetail.odOrderNo.payDateTime}
                    </time>*/
                usUN = "이름 : "+data.purchase.orderUserId.userName;


                if(data.purchase.payOption == 0){
                    paOp = "결제방법 : 일반결제";
                }else if(data.purchase.payOption == 1){
                    paOp = "결제방법 : 휴대폰결제";
                }

                img = "<img src='/resources/image/"+data.purchase.orderUserId.userProImg+"' width='90' height='120' alt='주문상품 이미지'>";

                usUP = "연락처 : "+data.purchase.orderUserId.userPhone;

                opt = "<label for='orderRequest' class='col-form-label'>픽업희망시간 : "+data.purchase.orderPickUpTime+"</label>";

                oRt = "<label for='orderRequest' class='col-form-label'>주문요청사항 :</label><textarea class='form-control' id='orderRequest' name='orderRequest'"+
                                          "value='"+data.purchase.orderRequest+"' disabled>"+data.purchase.orderRequest+"</textarea>";

                if(data.purchase.orderStatus == 1){
                    CookingTime =  "<div class='col-4'> 상호 :<br> "+data.purchase.orderTruckId.truckName+"</div>"+
                            "<div class='col-2'>"+
                                "<button class='btn btn-primary' data-bs-toggle='modal' href='#exampleModalToggle' type='button'>주문거절</button>"+
                            "</div>"+
                                "<div class='col-4'>"+
                                "<input type='radio' class='btn-check' name='cookingTime' id='cookingTimes' autocomplete='off' value='5' checked>"+
                                "<label class='btn btn-outline-success' for='cookingTimes' >5분</label>"+
                                "<input type='radio' class='btn-check' name='cookingTime' id='cookingTimes1' autocomplete='off' value='10'>"+
                                "<label class='btn btn-outline-success' for='cookingTimes1' >10분</label>"+
                                "<input type='radio' class='btn-check' name='cookingTime' id='cookingTimes2' autocomplete='off'  value='15'>"+
                                "<label class='btn btn-outline-success' for='cookingTimes2'>15분</label>"+
                                "<input type='radio' class='btn-check' name='cookingTime' id='cookingTimes3' autocomplete='off'  value='20'>"+
                                "<label class='btn btn-outline-success' for='cookingTimes3'>20분</label>"+
                                "<input type='radio' class='btn-check' name='cookingTime' id='cookingTimes4' autocomplete='off'  value='30'>"+
                                "<label class='btn btn-outline-success' for='cookingTimes4'>30분</label>"+
                                "<input type='radio' class='btn-check' name='cookingTime' id='cookingTimes5' autocomplete='off'  value='40'>"+
                                "<label class='btn btn-outline-success' for='cookingTimes5'>40분</label>"+
                           "</div>"+
                            "<div class='col-2'>"+
                                "<button class='btn btn-primary' type='button' id='updateTranCode' name='updateTranCode' value='주문 접수'>주문접수</button>"+
                            "</div>";
                }else if(data.purchase.orderStatus == 2){

                    CookingTime =  "<div class='col-2'> 상호 : "+data.purchase.orderTruckId.truckName+"</div>"+
                            "<div class='col-5'>"+
                                "<button class='btn btn-primary' data-bs-toggle='modal' href='#exampleModalToggle' type='button'>주문거절</button>"+
                            "</div>"+
                           " <div class='col-5'>"+
                                "<button class='btn btn-primary' type='button' id='updateTranCode' name='updateTranCode' value='픽업 요청'>픽업요청</button>"+
                            "</div>";
                    }else if(data.purchase.orderStatus == 3){
                    CookingTime = "<div class='col-2'> 상호 : "+data.purchase.orderTruckId.truckName+"</div>"+
                            "<div class='col-5'></div>"+
                            "<div class='col-5'>"+
                                "<button class='btn btn-primary' type='button' id='updateTranCode' name='updateTranCode' value='픽업 완료를 확인'>픽업완료</button>"+
                            "</div>";
                    }else if(data.purchase.orderStatus == 4){
                    CookingTime = "<div class='col-2'> 상호 : "+data.purchase.orderTruckId.truckName+"</div>"+
                            "<div class='col-5'></div>"+
                            "<div class='col-5'>주문처리가 완료되었습니다 </div>";
                    }else if(data.purchase.orderStatus == 5){

                    CookingTime = "<div class='col-2'> 상호 : "+data.purchase.orderTruckId.truckName+"</div>"+
                           "<div class='col-5'></div>"+
                            "<div class='col-5'>주문취소된 메뉴 입니다</div>";
                    }else if(data.purchase.orderStatus == 6) {

                    CookingTime = "<div class='col-2'> 상호 : " + data.purchase.orderTruckId.truckName + "</div>" +
                        "<div class='col-5'></div>" +
                        "<div class='col-5'>주문처리가 완료되었습니다</div>";
                    }else if(data.purchase.orderStatus == 7) {

                        CookingTime = "<div class='col-2'> 상호 : " + data.purchase.orderTruckId.truckName + "</div>" +
                            "<div class='col-5'></div>" +
                            "<div class='col-5'>주문처리가 완료되었습니다</div>";
                    }

                    orderMenuHidden = ""+
                    "<input type='hidden' name='payId' id='payId' value='"+data.purchase.payId+"'>"+
                    "<input type='hidden' name='purchaseOrder' id='purchaseOrder' value='"+data.purchase.orderNo+"'>"+
                    "<input type='hidden' name='truck' value='"+data.purchase.orderTruckId.truckId+"'>"+
                    "<input type='hidden' name='cookingTime' value='"+data.purchase.orderCookingTime+"'>";

                    pointNoCouponNo = "<input type='hidden' name='couponNo' value='"+couponNo+"'>"+
                    "<input type='hidden' name='pointNo' value='"+pointNo+"'>";

                total = "<p class='text-end'>결제금액 : "+data.purchase.payPrice+"</p>";
                $("#usId").html(usId);
                $("#orNo").html(orNo);
                $("#paDa").html(paDa);
                $("#usUN").html(usUN);
                $("#usUP").html(usUP);
                $("#paOp").html(paOp);
                $("#img").html(img);
                $("#oRt").html(oRt);
                $("#opt").html(opt);
                $("#total").html(total);
                $("#CookingTime").html(CookingTime);
                $("#orderMenuHidden").html(orderMenuHidden);
                $("#orderMenuHidden").append(pointNoCouponNo);
                $("#cancelOrder").html(cancel);




                var list = data.map;

                var totototoprice =0; // 전체 금액
                var totototoqty =0; // 수량
                var pricepriceprice =0 // 임시 가격

                var menuCount = 0;

                var optionNameShow = []; // 이름 보여지게 할 값 만들기~ (최종)
                var optionPriceShow = [];
                var odMenuQtyL = [];
                var odMenuImageL = [];
                var odMenuNameL = [];
                var totalshow =0;

                var name = "" ;
                var image = "";
                var qty = "";

                for(var i = 0; i<list.length; i++){
                    var odMenuImage = list[i]['odMenuImage'];
                    var odMenuName = list[i]['odMenuName'];
                    var odMenuPrice = list[i]['odMenuPrice'];
                    var odMenuQty = list[i]['odMenuQty'];
                    var odMenuQtyFlag = list[i]['odMenuQtyFlag'];
                    var odOptionName = list[i]['odOptionName'];
                    var odOptionPrice = list[i]['odOptionPrice'];
                    var odOptionGroupName = list[i]['odOptionGroupName'];

                    /* HHJ */

                    if (optionNameShow[menuCount] == undefined){
                        optionNameShow[menuCount] = " ";
                    }


                    if ( odMenuQtyFlag == '0'){

                        pricepriceprice = Number(odMenuPrice);
                        totototoqty = Number(odMenuQty);
                        menuCount++;
                        totalshow=0;
                        name = odMenuName;
                        image = odMenuImage;
                        qty = odMenuQty;
                        console.log("name"+name)
                        console.log("image"+image)
                        console.log("qty"+qty)

                        //pricepriceprice *= qtyqtyqty;
                        //console.log("pricepriceprice *= qtyqtyqty" + (pricepriceprice *= qtyqtyqty));
                        //tttttppppprrrr += Number(pricepriceprice)// 처음 들어온 값도 0, 이후엔 곱해짐 // 기존값 더함
                        //qtyqtyqty = Number(odMenuQty); // 수량값 기억하고 있도록 for문 밖에 선언해준 qtyqtyqty 에 저장
                    }else { // 옵션이면
                         //console.log("odOptionName : "+odOptionName)
                        pricepriceprice = Number(odOptionPrice);
                        optionNameShow[Number(menuCount-1)] += odOptionName + "(+" + odOptionPrice + ") ";

                    }
                    //console.log("optionNameShow[menuCount]: "+optionNameShow[menuCount])
                    totototoprice+= Number(pricepriceprice * totototoqty);
                    totalshow += Number(pricepriceprice * totototoqty);
                    optionPriceShow[Number(menuCount-1)] = totalshow;
                    odMenuQtyL[Number(menuCount-1)] = qty;
                    odMenuImageL[Number(menuCount-1)] = image;
                    odMenuNameL[Number(menuCount-1)] = name;
                    console.log("ttototototo :: " + totototoprice)

                    console.log("odMenuQtyL"+odMenuQtyL)
                    console.log("odMenuImageL"+odMenuImageL)
                    console.log("odMenuNameL"+odMenuNameL)


                }
                console.log("optionNameShow"+optionNameShow[0])
                console.log("optionNameShow"+odMenuQtyL[1])
                console.log("optionNameShow"+optionPriceShow[0])
                console.log("optionNameShow"+menuCount)
                /*alert(totalPrice) 총금액*/
                /*$("#order").html(menuList);*/
                for (var i = 0; i < menuCount; i++) {




                    divElemApply1 = "<div class=\"card mb-3\">" +
                        " <div class=\"row g-0\">" +
                        "<div class=\"col-md-4\">" +
                        "<img src=\"/resources/menu/"+odMenuImageL[i]+"\" class=\"img-fluid rounded-start\" alt=\"image\">" +
                        "</div>" +
                        "<div class=\"col-md-8\">" +
                        "<div class=\"card-body\">" +
                        "<h5 class=\"card-title\">" + odMenuNameL[i] + "</h5>" +
                        "<p class=\"card-text\"><small class=\"text-muted\"><span class='badge' style='background-color: #fae100; color: #110000'>&nbsp;옵션&nbsp;</span> " + optionNameShow[i] + "  </small><br>" +
                        "<small class=\"text-muted\"><span class='badge' style='background-color: #fae100; color: #110000'>&nbsp;수량&nbsp;</span> " + odMenuQtyL[i] + " <br><span class='badge' style='background-color: #fae100; color: #110000'>총 가격</span> " + optionPriceShow[i] + " </small></p>" +
                        "</div>" +
                        "</div>" +
                        "</div>" +
                        "</div>"




                    $('#order').html(divElemApply1);

                }
            }
        })
       /* self.location = "/purchase/getOrderList?truckId="+truckId+"&orderNo="+orderNo+"&search="+search;*/

    });



    /*주문접수버튼*/
    $("body").on("click","button[name='updateTranCode']", function () {

        var orderUserId = $("input[name='usId']").val();
        var orderCookingTime = $("input[name='cookingTime']:checked").val();
        if(orderCookingTime == undefined){
            orderCookingTime = $("input[name='cookingTime']").val();

        }
        var m_sg = $(this).value();
        console.log("m_sg: "+m_sg)

        $.ajax({
            url: "/purchase/json/updateTranCode",
            method: "POST",
            contentType: "application/x-www-form-urlencoded; charset=UTF-8",
            data: {
                "orderNo": $("input[name='purchaseOrder']").val(),
                "orderCookingTime" : orderCookingTime
            },
            success: function (data) {

                alert("접수되었습니다!")

                console.log("purchase.socket::::" + socket);

                var orderTruckId = '${sessionScope.truck.truckId}';

                if(socket) {
                    // websocket에 보내기!!! (message, 보내는이, 받는이)

                    let socketMessage = "purchaseUser,"+orderTruckId+","+orderUserId+","+orderUserId+","+m_sg;
                    console.log("socketM::::" + socketMessage);
                    socket.send(socketMessage);
                }
                window.location.reload();
            }
        });

    });





    /* Iamport 환불시스템*/
    function cancelPay() {
        var pointNo = $("input[name='pointNo']").val();
        var couponNo = $("input[name='couponNo']").val();
        var payId = $("input[name='payId']").val();
        var orderNo = $("input[name='purchaseOrder']").val();
        var orderNopeReason = $("input[name='orderNopeReason']:checked").val();
        if(pointNo == undefined && pointNo =='' ){
            pointNo = 0;

        }else if(pointNo ===null && pointNo == ""){
            pointNo = 0;

        }

        if(couponNo == undefined || couponNo == '' && couponNo == null){
            couponNo = 0;
        }
        var orderCancelReason =0;

        $.ajax({
            url: "/purchase/json/payRefund", // 예: http://www.myservice.com/payments/cancel
            type: "POST",
            async: false,
            dataType: "json",
            data: {
                "payId": payId,
                "orderNo": orderNo,
                "orderNopeReason": orderNopeReason,
                "orderCancelReason": orderCancelReason,
                "couponNo": couponNo,
                "pointNo": pointNo,
            },

            success: function (map) {
                var orderTruckName = '${sessionScope.truck.truckName}';
                var orderUserId = $("input[name='usId']").val();
                if(socket) {
                    // websocket에 보내기!!! (message, 보내는이, 받는이)
                    let socketMessage = "cancel,"+orderTruckName+","+orderUserId+","+orderUserId;
                    console.log("socketM::::" + socketMessage);
                    socket.send(socketMessage);
                }
                location.reload();
            },
            error: function (xhr, status, error) {
                alert("[Error]" + error);
                return;
            }

        });

    }


</script>
</body>
<%--<jsp:include page="/views/footer.jsp"/>--%>
</html>