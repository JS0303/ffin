<%--
  Created by IntelliJ IDEA.
  User: PSW
  Date: 2022-01-12
  Time: 오후 6:55
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<style>
    .bs-canvas-overlay {
        opacity: 0.85;
        z-index: 1100;
    }

    .bs-canvas {
        top: 0;
        z-index: 1110;
        overflow-x: hidden;
        overflow-y: auto;
        width: 330px;
        transition: margin .4s ease-out;
        -webkit-transition: margin .4s ease-out;
        -moz-transition: margin .4s ease-out;
        -ms-transition: margin .4s ease-out;
    }


    .bs-canvas-right {
        right: 0;
        margin-right: -330px;
    }

    /* Only for demo */

</style>

<form class="cart">
    <div class="bs-canvas bs-canvas-right position-fixed bg-light h-100">
        <header class="bs-canvas-header p-3 bg-primary overflow-auto" id="mainCartCancel" style="background-color: #ffba49 !important;">
            <button type="button" class="bs-canvas-close float-left close" aria-label="Close"><span aria-hidden="true"
                                                                                                    class="text-light" id="cancelCartbar">&times;</span>
            </button>
            <h4 class="d-inline-block text-light mb-0 float-right">장바구니</h4>
        </header>
        <div class="bs-canvas-content px-3 py-5">
            <div class="content">

                <div id="mainCartOrderMenu"></div>


                <div class="row">
                    <div class="col-6">
                        <button type="button" id="buttonMainCartBar" class="btn btn btn-primary" data-toggle="modal"
                                data-target="#orderPickUpTimeCheckModal" style="color: #fff;     background-color: #ffba49; border-color: #ffba49;">
                            주문하기
                        </button>
                    </div>
                    <div class="col-2">

                    </div>
                    <div class="col-4">
                        <button type="button" class="btn btn-primary" id="deleteCartMenu" style="color: #fff; background-color: #ffba49; border-color: #ffba49;">삭제</button>
                    </div>
                </div>
            </div>
        </div>
    </div>


    <%--modal--%>
    <div class="modal fade" id="orderPickUpTimeCheckModal" tabindex="-1" role="dialog"
         aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalCenterTitle">New message</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <div class="mb-3">
                        <label for="mainOrderPickUpTime" class="col-form-label">픽업희망시간:</label>
                        <div class="btn-group" role="group" aria-label="Basic radio toggle button group">
                            <input type="radio" class="btn-check" id="mainOrderPickUpTime" name="mainOrderPickUpTime"
                                   value="5"
                                   id="cancelTime1" autocomplete="off" checked>
                            <label class="btn btn-outline-primary" for="cancelTime1">5분</label>

                            <input type="radio" class="btn-check" name="mainOrderPickUpTime" value="10" id="cancelTime2"
                                   autocomplete="off">
                            <label class="btn btn-outline-primary" for="cancelTime1">10분</label>

                            <input type="radio" class="btn-check" name="mainOrderPickUpTime" value="15" id="cancelTime3"
                                   autocomplete="off">
                            <label class="btn btn-outline-primary" for="cancelTime1">15분</label>

                            <input type="radio" class="btn-check" name="mainOrderPickUpTime" value="20" id="cancelTime4"
                                   autocomplete="off">
                            <label class="btn btn-outline-primary" for="cancelTime1">20분</label>

                            <input type="radio" class="btn-check" name="mainOrderPickUpTime" value="30" id="cancelTime5"
                                   autocomplete="off">
                            <label class="btn btn-outline-primary" for="cancelTime1">30분</label>

                            <input type="radio" class="btn-check" name="mainOrderPickUpTime" value="40" id="cancelTime6"
                                   autocomplete="off">
                            <label class="btn btn-outline-primary" for="cancelTime1">40분</label>

                        </div>
                    </div>
                    <div class="mb-3">
                        <label for="mainOrderRequest" class="col-form-label">주문요청사항:</label>
                        <textarea class="form-control" id="mainOrderRequest" name="mainOrderRequest"
                                  value="${purchase.orderRequest}"></textarea>

                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
                    <button type="button" class="btn btn-primary" id="mainOrderGo">확인</button>

                    <input type="hidden" id="mainOrderUserId" name="mainOrderUserId" value="${user.userId}"/>
                    <div id="mainSessionTruckId"></div>

                </div>
            </div>
        </div>
    </div>


</form>


<script>


    $(function () {


        var beforeAnyway = JSON.parse(sessionStorage.getItem("menuOdList"));

        for (var i in beforeAnyway) {
            // console.log("beforeAnyway : " + beforeAnyway[i]);
            for (var j in beforeAnyway[i]) {
                // console.log("afterAnyway key : " + j + "/value : " + beforeAnyway[i][j]);

            }
        }
        //담을 li

        var finalCart = "";
        var forOne = 0;
        var mqty = 0;
        var mainOrderList = "";

        ////////////시작///////////////////
        if (beforeAnyway) { // sessionStorage에 뭔가 있다?
            // console.log("sessionStorage에 있다! 화면 뿌려주기 준비 시작!");
            for (var i = 0; i < beforeAnyway.length; i++) {//sessionStorage의 orderDetail만큼 for문 돌리기

                // console.log("for문 장바구니이쪽이다!!!!!! 안에 있다!");
                // console.log("beforeAnyway[" + i + "]번째 세션 : " + JSON.stringify(beforeAnyway[i]));
                // finalCart += "<li class=\"list-group-item d-flex justify-content-between lh-sm\">"+
                //     "<div><h6 class=\"my-0\">"+beforeAnyway[i]['odMenuName']+"</h6>"+
                //     "<h6 class=\"my-0\">"+beforeAnyway[i]['odMenuQty']+"</h6>"+
                //     "<small class=\"text-muted\">"+beforeAnyway[i]['odOptionGroupName']+"</small>"+
                //     "<small class=\"text-muted\">"+beforeAnyway[i]['odOptionName']+"</small>"+
                //     "</div><span class=\"text-muted\">"+beforeAnyway[i]['odMenuPrice']+"</span></li>";

                if (beforeAnyway[i]['odMenuQtyFlag'] == 0) {//플래그0일 때 메뉴 수량, 이름 출력
                    var mtotalPrice = 0;
                    finalCart += "" +
                        "<li class=\"list-group-item\" style='padding: 10px; display: flex; align-items: center; flex-direction: column;'>" +
                        "<div class='col-12'>"+
                        "<button type='button' class='close' id='mainCancelMenu'>" +
                        "<span aria-hidden='true'><ion-icon name='close-outline'></ion-icon></span></button>"+
                        "</div>"+
                        "<div class='col-11' style='text-align: initial; padding: 10px;'>"+
                        "<div>"+
                        "<h6style='font-size: 16px; font-weight: 600;' class=\"my-0\">" + beforeAnyway[i]['odMenuName']  + "</h6><p>" +
                        "<h6 class=\"my-0\">수량 : <input type='button' class='my-5' value='-' id='mainDecreaseQuantity'>" +
                        "<input type='hidden' name='mainOrderCount' value='" + i + "'>" +
                        " <input type='text' id='mainNumberUpDown' value='" + beforeAnyway[i]['odMenuQty'] + "' size='2' max=''> " +
                        "<input type='button' value='+' id='mainIncreaseQuantity'> </h6></div><hr/>" +
                        "";

                    mqty = beforeAnyway[i]['odMenuQty'];

                    mtotalPrice = (Number(beforeAnyway[i]['odMenuPrice'].replace('₩','').trim())*Number(mqty));
                    forOne += 1;
                    if (beforeAnyway[i + 1] != null) { //만약 다음 애가 있는데
                        if (beforeAnyway[i + 1]['odMenuQtyFlag'] == 0) { //수량제공메뉴이면(지금 이게 수량제공메뉴란 소리니까 닫아줘야함)
                            finalCart +=  "</div><div class='col-12' style='display: flex; justify-content: flex-end; margin-right: 15px; font-weight: 600;'><span class=\"text-muted\" style='font-size: 16px;'>" + mtotalPrice + " ₩</span></div></li>";
                        }

                    } else { //만약 다음 애가 없으면
                        finalCart += "</div><div class='col-12' style='display: flex; justify-content: flex-end; margin-right: 15px; font-weight: 600;'><span class=\"text-muted\" style='font-size: 16px;'>" + mtotalPrice + " ₩</span></div></li>";
                    }
                } else { //플래그 1일 때
                    // for(var j=i+1; j<beforeAnyway.length; j++){ //옵션그룹 화면에 뿌려주기 위한 for문 (수량제공메뉴+1부터
                    //     if(beforeAnyway[j]['odMenuQtyFlag']==1){
                    finalCart += "" +
                        "<p style='margin: 0; font-size: 18px;'>" +
                        "<input type='hidden' name='mainOrderCancelCount' value='" + i + "'>" +
                        "<small class=\"text-muted\">" + beforeAnyway[i]['odOptionGroupName'] + "</small> : " +
                        "<small class=\"text-muted\">" + beforeAnyway[i]['odOptionName'] + "</small> +" +
                        "<small class=\"text-muted\">" + beforeAnyway[i]['odOptionPrice'] + "원</small>";

                    mtotalPrice += (Number(beforeAnyway[i]['odOptionPrice'])*Number(mqty));

                    forOne += 1;
                    if (beforeAnyway[i + 1] != null) {
                        if (beforeAnyway[i + 1]['odMenuQtyFlag'] == 0) {
                            finalCart += "</div><div class='col-12' style='display: flex; justify-content: flex-end; margin-right: 15px; font-weight: 600;'><span class=\"text-muted\" style='font-size: 16px;'>" + mtotalPrice + " ₩</span></div></li>";
                        }

                    }else{
                        finalCart += "</div><div class='col-12' style='display: flex; justify-content: flex-end; margin-right: 15px; font-weight: 600;'><span class=\"text-muted\" style='font-size: 16px;'>" + mtotalPrice + " ₩</span><div></li>";
                    }

                    // finalCart+="</div><span class=\"text-muted\">"+beforeAnyway[i]['odMenuPrice']+"원</span></li>";
                    // i=forOne;


                }//sessionStorage만큼 for문 돌리기
            }

        }
        $("#mainCartOrderMenu").html(finalCart);


        var beforeAny = JSON.parse(sessionStorage.getItem("menuOdList"));
        var mainOrderList = "";
        var mainSessionTruckId = "";

        for (var i in beforeAny) {


            mainOrderList += "<input type='hidden' name='mainOdMQFlag' id='mainOdMQFlag' value='" + beforeAny[i]['odMenuQtyFlag'] + "'>" +
                "<input type='hidden' name='mainOdMQty' id='mainOdMQty' value='" + beforeAny[i]['odMenuQty'] + "'>" +
                "<input type='hidden' name='mainOdMName' id='mainOdMName' value='" + beforeAny[i]['odMenuName'] + "'>" +
                "<input type='hidden' name='mainOdMPrice' id='mainOdMPrice' value='" + beforeAny[i]['odMenuPrice'] + "'>" +
                "<input type='hidden' name='mainOdOGName' id='mainOdOGName' value='" + beforeAny[i]['odOptionGroupName'] + "'>" +
                "<input type='hidden' name='mainOdOpName' id='mainOdOpName' value='" + beforeAny[i]['odOptionName'] + "'>" +
                "<input type='hidden' name='mainOdOpPrice' id='mainOdOpPrice' value='" + beforeAny[i]['odOptionPrice'] + "'>" +
                "<input type='hidden' name='mainOdMImg1' id='mainOdMImg1' value='" + beforeAny[i]['odMenuImg1'] + "'>";

            mainSessionTruckId = "<input type='hidden' name='mainSessionTruckId' value='" + beforeAny[i]['menuTruckId'] + "'>";


        }

        $("#mainSessionTruckId").html(mainSessionTruckId);
        $("#mainCartOrderMenu").append(mainOrderList);


    });

    /*삭제버튼 클릭 이벤트*/
    $(function () {
        var orderDetail = JSON.parse(sessionStorage.getItem("menuOdList"));

        var orderCancelCount = [];

        $('button#mainCancelMenu').click(function () {
            var orderCount = $(this).parents('li').find('input[name="mainOrderCount"]').val();
            // var orderCancelCount = $(this).parent('li').find('input[name="orderCancelCount"]').val();
            $(this).parents('li').find('input[name="mainOrderCancelCount"]').each(function (i) {
                orderCancelCount.push($(this).val());
            });

            orderDetail.splice(orderCount, orderCancelCount.length + 1);

            sessionStorage.setItem("menuOdList", JSON.stringify(orderDetail));


            $(this).parent('li').remove();

        })

    })

    /*수량버튼 클릭 이벤트*/
    $(function () {

        var orderDetail = JSON.parse(sessionStorage.getItem("menuOdList"));


        $('input#mainDecreaseQuantity').click(function (e) {
            var orderCount = $(this).parent('h6').find('input[name="mainOrderCount"]').val();
            //alert("클릭한 메뉴의 순서 정보"+orderCount);
            e.preventDefault();

            var stat = $(this).parent('h6').find('input#mainNumberUpDown');
            var num = stat.val();
            num--;
            if (num <= 0) {
                alert('더이상 줄일수 없습니다.');
                num = 1;
            }
            // 수량 추가
            orderDetail[orderCount]['odMenuQty'] = num;
            stat.val(num);
            sessionStorage.setItem("menuOdList", JSON.stringify(orderDetail));

            /*$(this).parent('h6').find('.text-muted').text(Number(orderDetail[orderCount]['odMenuPrice'].replace('₩','').trim() * num));*/
            //$('input#numberUpDown').val(num);
        });
        $('input#mainIncreaseQuantity').click(function (e) {
            var orderCount = $(this).parent('h6').find('input[name="mainOrderCount"]').val();
            e.preventDefault();

            var stat = $(this).parent('h6').find('input#mainNumberUpDown');
            var num = stat.val();
            num++;

            if (num > 10) {
                alert('더이상 늘릴수 없습니다.');
                num = 10;
            }

            orderDetail[orderCount]['odMenuQty'] = num;
            stat.val(num);
            sessionStorage.setItem("menuOdList", JSON.stringify(orderDetail));
            // $('input#numberUpDown').val(num);
        });
    });


    /*장바구니 화면을 보여주는 기능*/
    jQuery(document).ready(function ($) {
        $(document).on('click', '.pull-bs-canvas-right, .pull-bs-canvas-left', function () {
            $('body').prepend('<div class="bs-canvas-overlay bg-dark position-fixed w-100 h-100"></div>');
            if ($(this).hasClass('pull-bs-canvas-right'))
                $('.bs-canvas-right').addClass('mr-0');
            else
                $('.bs-canvas-left').addClass('ml-0');
            return false;
        });

        $(document).on('click', '.bs-canvas-close.float-left.close', function () {
            var elm = $(this).hasClass('bs-canvas-close') ? $(this).closest('.bs-canvas') : $('.bs-canvas');
            elm.removeClass('mr-0 ml-0');
            $('.bs-canvas-overlay').remove();
            return false;
        });

        $(document).on('click', '#buttonMainCartBar', function () {
            var elm = $(this).hasClass('bs-canvas-close') ? $(this).closest('.bs-canvas') : $('.bs-canvas');
            elm.removeClass('mr-0 ml-0');
            $('.bs-canvas-overlay').remove();
            return false;
        });
        /* $(document).on('click', '.bs-canvas-close, .bs-canvas-overlay, .btn.btn.btn-primary', function () {
             var elm = $(this).hasClass('bs-canvas-close') ? $(this).closest('.bs-canvas') : $('.bs-canvas');
             elm.removeClass('mr-0 ml-0');
             $('.bs-canvas-overlay').remove();
             return false;
         });*/


    });
    $(function () {
        $("#deleteCartMenu").click(function () {

            sessionStorage.removeItem('menuOdList');
            location.reload();
        });
    });


    /*모달 화면에서 확인 클릭 시 데이터를 List로 담아서 전송*/
    $(function () {
        $("#mainOrderGo").click(function () {

            // 1. menu 없으면 메뉴를 장바구니에 저장된 메뉴가 없습니다.
            // 2. menu 정보가 있으면 장바구니 주문하기 활성화 없으면 비활성화
            //var menucheck = document.getElementById().val;
            var orderCheck = $("input[name='mainSessionTruckId']").val();
            if(orderCheck== undefined){
                alert("담겨있는 메뉴가 없습니다")
                return;
            }


            var order = main_cart()
            append = "<input type=\"hidden\" id=\"orderNo\" name=\"orderNo\" value=\"" + order + "\">";
            $('#app').append(append);
            /*alert(append)*/
            self.location = "/purchase/addCart?orderNo=" + order
            /* $("form").attr("method" , "POST").attr("action" , "/purchase/addCart").submit();*/

        });
    });
    /*    $(function () {
            $("button.btn.btn-primary:Contains('json')").click(function () {
                alert("ddk");
                to_ajax();
                $("form.cart").attr("method", "POST").attr("action", "/purchase/addCart").submit();
            });
        });*/

    function main_cart() {
        var reOrderNo;
        var odMenuName = [];
        var odOptionGroupName = [];
        var odOptionName = [];
        var odMenuQty = [];
        var odMenuPrice = [];
        var odOptionPrice = [];
        var odMenuImage = [];
        var odMenuQtyFlag = [];
        var orderPickUpTime = $('input[name="mainOrderPickUpTime"]:checked').val();
        var orderTotalPrice = $('#mainOrderTotalPrice').val();
        var orderUserId = $('#mainOrderUserId').val();
        var orderTruckId = $('input[name="mainSessionTruckId"]').val();
        var orderRequest = $('#mainOrderRequest').val();
        var orderQty = $('#mainOrderQty').val();


        $('input[name="mainOdMName"]').each(function (i) {
            odMenuName.push($(this).val());
        });

        $('input[name="mainOdOGName"]').each(function (i) {
            odOptionGroupName.push($(this).val());
        });

        $('input[name="mainOdOpName"]').each(function (i) {
            odOptionName.push($(this).val());
        });

        $('input[name="mainOdMQty"]').each(function (i) {
            odMenuQty.push($(this).val());
        });

        $('input[name="mainOdMPrice"]').each(function (i) {
            odMenuPrice.push($(this).val().replace('₩','').trim());
        });

        $('input[name="mainOdOpPrice"]').each(function (i) {
            odOptionPrice.push($(this).val());
        });

        $('input[name="mainOdMImg1"]').each(function (i) {
            odMenuImage.push($(this).val());
        });

        $('input[name="mainOdMQFlag"]').each(function (i) {
            odMenuQtyFlag.push($(this).val());
        });
        /*  alert(orderPickUpTime)
          alert(orderTotalPrice)
          alert(orderUserId)
          alert(orderTruckId)
          alert(orderRequest)
          alert(orderQty)
          alert(odMenuQtyFlag)*/

        var data = {
            "odMenuName": odMenuName,
            "odOptionGroupName": odOptionGroupName,
            "odOptionName": odOptionName,
            "odMenuQty": odMenuQty,
            "odMenuPrice": odMenuPrice,
            "odOptionPrice": odOptionPrice,
            "odMenuImage": odMenuImage,
            "orderPickUpTime": orderPickUpTime,
            "orderTotalPrice": orderTotalPrice,
            "orderUserId": orderUserId,
            "orderTruckId": orderTruckId,
            "orderRequest": orderRequest,
            "orderQty": orderQty,
            "odMenuQtyFlag": odMenuQtyFlag,
        }
        $.ajax({
            type: "post",
            url: '/purchase/json/addCartList',
            contentType: "application/x-www-form-urlencoded; charset=UTF-8",
            data: data,
            async: false,
            dataType: 'json',
            success: function (retVal) {
                reOrderNo = retVal.orderNo;
                sessionStorage.removeItem('menuOdList');
            },
            error: function (xhr, status, error) {
                alert("[Error]" + error);
                return;
            }


        });
        return reOrderNo;
    }

</script>