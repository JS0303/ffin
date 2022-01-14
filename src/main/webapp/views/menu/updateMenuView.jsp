
<%@ page language="java" contentType="text/html; charset=utf-8"
         pageEncoding="utf-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>

<html lang="ko">
<head>

    <title>메뉴 수정</title>
    <jsp:include page="../../common/lib.jsp"/>

    <!-- 참조 : http://getbootstrap.com/css/   참조 -->
    <meta name="viewport" content="width=device-width, initial-scale=1" />

    <%--    <link rel="canonical" href="https://getbootstrap.com/docs/5.1/examples/modals/">--%>



    <!-- Bootstrap core CSS -->
   <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">

<%--    <meta name="theme-color" content="#7952b3">--%>

    <%--    <!--  ///////////////////////// Bootstrap, jQuery CDN ////////////////////////// -->--%>
<%--    <script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>--%>


    <!--  ///////////////////////// CSS ////////////////////////// -->
    <style>
        body {
            padding-top : 50px;
        }

    </style>

    <!--  ///////////////////////// JavaScript ////////////////////////// -->
    <script type="text/javascript">

        //============= "추가"  Event 연결 =============
        // $(function() {
        //     //==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
        //     $( "#updateMenuButton" ).on("click" , function() {
        //         //fncApplyOptionNo();
        //         fncUpdateMenu();
        //     });
        // });

        //============= "취소"  Event 처리 및  연결 =============
        $(function() {
            //==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
            $("a[href='#' ]").on("click" , function() {
                $("form")[0].reset();
            });
        });



        $(function(){



            $(document).on("click", "#updateMenuButton", function(){

                //todo 2022-01-13 업데이트 미루기 - 우회해서 기존 파일은 그대로 두도록 만들기


                //var truckId = $("input[name='truckId']").val();
                // alert("optionGroup개수 : " +$('input#optionGroupName.form-control').length);

                if($('input#optionGroupName.form-control').length===0){
                    $("form").attr("method", "POST").attr("action", "/menu/updateMenu").attr("enctype","multipart/form-data").submit();
                } else{
                    console.log("fncUpdateMenu-target : "+$("form.form-horizontal").html());

                    $("form").attr("method", "POST").attr("action","/menu/updateMenuOptionGroup").attr("enctype","multipart/form-data").submit();
                    // $("form").post("/menu/addMenuOptionGroup", {}, "text")

                }

            });

        });



    </script>

    <style>
        .page-header{
            margin-top:59px;
        }
    </style>

</head>

<body>

<!-- ToolBar Start /////////////////////////////////////-->
<jsp:include page="/views/navbar.jsp" />
<!-- ToolBar End /////////////////////////////////////-->

<!--  화면구성 div Start /////////////////////////////////////-->
<div class="container">


    <div class="page-header text-center">
        <h3 class="text">${menu.menuTruckId}의 ${menu.menuNo}에 대한 메뉴 수정</h3>
    </div>
<div class="forCenter">
    <!-- form Start /////////////////////////////////////-->
    <form class="form-horizontal">


        <div class="form-group">
            <label for="menuName" class="col-sm-offset-1 col-sm-3 control-label">메뉴 이름</label>
            <div class="col-sm-4">
                <input type="text" class="form-control" id="menuName" name="menuName" value="${menu.menuName }" placeholder="메뉴 이름 수정">
                <input type="hidden" name="menuNo" value="${menu.menuNo}">
            </div>
        </div>

        <div class="form-group">
            <label for="menuDetail" class="col-sm-offset-1 col-sm-3 control-label">메뉴상세정보</label>
            <div class="col-sm-4">
                <input type="text" class="form-control" id="menuDetail" name="menuDetail" value="${menu.menuDetail }" placeholder="메뉴상세정보 수정">
            </div>
        </div>

        <div class="form-group">
            <label for="menuPrice" class="col-sm-offset-1 col-sm-3 control-label">메뉴 가격</label>
            <div class="col-sm-4">
                <input type="text" class="form-control" id="menuPrice" name="menuPrice" value="${menu.menuPrice }" placeholder="메뉴 가격 수정">
            </div>
        </div>

        <div class="form-group">
            <label for="isSigMenu" class="col-sm-offset-1 col-sm-3 control-label">대표메뉴여부</label>
            <div class="col-sm-4">
                <input type="text" class="form-control" id="isSigMenu" name="isSigMenu" value="${menu.isSigMenu}" placeholder="대표메뉴여부 수정">
            </div>
        </div>

        <div class="form-group">
            <label for="menuImg11" class="col-sm-offset-1 col-sm-3 control-label">메뉴 이미지1</label>
            <div class="col-sm-4">
                <input type="file" class="form-control" id="menuImg11" name="menuImg11"  value="${menu.menuImg1}" placeholder="메뉴 이미지1 수정" onchange="setImage1Preview(event);">
            </div>
            <div id="image1preview" class="col-sm-4">
                <c:if test="${menu.menuImg1 ne null}">
                    <img src="/resources/menu/${menu.menuImg1}" alt="메뉴 이미지" style="width:100%;">
                </c:if>
            </div>
        </div>

        <div class="form-group">
            <label for="menuImg22" class="col-sm-offset-1 col-sm-3 control-label">메뉴 이미지2</label>
            <div class="col-sm-4">
                <input type="file" class="form-control" id="menuImg22" name="menuImg22"  value="${menu.menuImg2}" placeholder="메뉴 이미지2 수정" onchange="setImage2Preview(event);">
            </div>
            <div id="image2preview" class="col-sm-4">
                <c:if test="${menu.menuImg2 ne null && menu.menuImg2 ne ''}">
                    <img src="/resources/menu/${menu.menuImg2}" alt="메뉴 이미지" style="width:100%;">
                </c:if>
            </div>
        </div>

        <div class="form-group">
            <label for="menuImg33" class="col-sm-offset-1 col-sm-3 control-label">메뉴 이미지3</label>
            <div class="col-sm-4">
                <input type="file" class="form-control" id="menuImg33" name="menuImg33"  value="${menu.menuImg3}" placeholder="메뉴 이미지3 수정"  onchange="setImage3Preview(event);">
            </div>
            <div id="image3preview" class="col-sm-4">
                <c:if test="${menu.menuImg3 ne null && menu.menuImg3 ne ''}">
                    <img src="/resources/menu/${menu.menuImg3}" alt="메뉴 이미지" style="width:100%;">
                </c:if>
            </div>
        </div>

        <script>

            function setImage1Preview(event){

                var DIVimage1preview = $('#image1preview');
                var isTherePreview = DIVimage1preview.find('img').length;
                alert("isTherePreview : " + isTherePreview);
                //이미지파일미리보기 이미 있으면 바꾸기 구현 중-  점심먹고 왔다! 다시 시작!
                var reader  = new FileReader();

                if(isTherePreview==0){

                }else{

                    DIVimage1preview.find('img').remove();

                }

                reader.onload = function(event){
                    var img = document.createElement("img");
                    img.setAttribute("src", event.target.result);
                    img.setAttribute("style",  "width:100%;");
                    document.querySelector("div#image1preview").appendChild(img);

                };

                reader.readAsDataURL(event.target.files[0]);


            }

            function setImage2Preview(event){
                var DIVimage2preview = $('#image2preview');
                var isTherePreview = DIVimage2preview.find('img').length;
                alert("isTherePreview : " + isTherePreview);
                //이미지파일미리보기 이미 있으면 바꾸기 구현 중-  점심먹고 왔다! 다시 시작!
                var reader  = new FileReader();

                if(isTherePreview==0){

                }else{

                    DIVimage2preview.find('img').remove();

                }

                reader.onload = function(event){
                    var img = document.createElement("img");
                    img.setAttribute("src", event.target.result);
                    img.setAttribute("style",  "width:100%;");
                    document.querySelector("div#image2preview").appendChild(img);

                };

                reader.readAsDataURL(event.target.files[0]);


            }

            function setImage3Preview(event){
                var DIVimage3preview = $('#image3preview');
                var isTherePreview = DIVimage3preview.find('img').length;
                alert("isTherePreview : " + isTherePreview);
                //이미지파일미리보기 이미 있으면 바꾸기 구현 중-  점심먹고 왔다! 다시 시작!
                var reader  = new FileReader();

                if(isTherePreview==0){

                }else{

                    DIVimage3preview.find('img').remove();

                }

                reader.onload = function(event){
                    var img = document.createElement("img");
                    img.setAttribute("src", event.target.result);
                    img.setAttribute("style",  "width:100%;");
                    document.querySelector("div#image3preview").appendChild(img);

                };

                reader.readAsDataURL(event.target.files[0]);


            }

        </script>

    <div class="happy">


        <c:set var="count1" value="0"></c:set>
        <c:forEach var="optionGroup1" items="${list}">
            <c:set var="count1" value="${count1 + 1}"/>
            <c:if test="${count1 eq 1}">
                <hr>
            <div class="form-group">
                <div>
                    <label for="optionGroupName" class="col-sm-offset-1 col-sm-3 control-label">옵션 그룹 이름 ${count1}</label>
<%--                <strong>옵션 그룹 이름</strong></div>--%>
                <div class="col-sm-4">
<%--                    <strong>${optionGroup1.optionGroupName}</strong>--%>
                    <input type="text" class="form-control" id="optionGroupName" name="optionGroupName" value="${optionGroup1.optionGroupName }" placeholder="옵션 그룹 이름 수정">

                </div>
                </div></div><hr>
            </c:if>
            <c:if test="${count1 ne 1}">
                <c:set var="count2" value="0"/>
                <c:forEach var="optionGroup2" items="${list}">
                    <c:set var="count2" value="${count2 + 1}"/>
                    <c:if test="${(count1 - 1) eq count2}">
                        <c:if test="${optionGroup1.optionGroupName ne optionGroup2.optionGroupName}">
                            <hr>
                            <div class="form-group">
                            <div>
                                <label for="menuName" class="col-sm-offset-1 col-sm-3 control-label">옵션 그룹 이름 ${count1}</label>
<%--                                <strong>옵션 그룹 이름</strong></div>--%>
                            <div class="col-sm-4">
<%--                                <strong>${optionGroup1.optionGroupName}</strong>--%>
                                <input type="text" class="form-control" id="optionGroupName" name="optionGroupName" value="${optionGroup1.optionGroupName }" placeholder="옵션 그룹 이름 수정">

                            </div>
                            </div></div><hr>
                        </c:if>

                    </c:if>
                </c:forEach>
            </c:if>

                    <div class="form-group">
                    <div><label for="optionName" class="col-sm-offset-1 col-sm-3 control-label">옵션 이름</label></div>
                    <div class="col-sm-3">
<%--                    <input class="form-check-input" type="radio" name="optionName+OGName${optionGroup1.optionGroupName}" id="optionName+OGName${optionGroup1.optionGroupName}" data-op="${optionGroup1.optionName}">${optionGroup1.optionName}--%>
                        <input type="text" class="form-control" id="optionName" name="optionName" value="${optionGroup1.optionName }" placeholder="옵션 이름 수정">
                        <input type="hidden" name="optionGroupNo" value="${optionGroup1.optionGroupNo}">
                    <input type="hidden" name="optionGroupName" value="${optionGroup1.optionGroupName}">
                    <input type="hidden" name="optionNo" value="${optionGroup1.optionNo}">
                    <input type="hidden" name="optionPrice" value="${optionGroup1.optionPrice}">
                    </div>

                        <div><label for="optionPrice" class="col-sm-offset-1 col-sm-3 control-label">옵션 가격</label></div>
<%--                    <span class="col-xs-8 col-md-8" style="right:0px;">${optionGroup1.optionPrice}</span>--%>
                        <div class="col-sm-3">
                        <input type="text" class="form-control" id="optionPrice" name="optionPrice" value="${optionGroup1.optionPrice }" placeholder="메뉴 가격 수정">
                        </div>

                    </div>
        </c:forEach>
</div>
<%--        <c:set var="i" value="0"/>--%>
<%--        <c:forEach var="optionGroup" items="${list}">--%>
<%--            <c:set var="i" value="${i+1}"/>--%>

<%--            <div class="form-group">--%>
<%--                <label for="optionGroupName" class="control-label\">옵션그룹이름</label>--%>
<%--                <div>--%>
<%--                <input type="text" class="form-control" id="optionGroupName" name="optionGroupName"  value="${optionGroup.optionGroupName}" placeholder="${optionGroup.optionGroupName}">--%>
<%--                <input type="hidden" class="form-control" id="optionNo" name="optionNo" value="${optionGroup.optionNo}"/>--%>
<%--                <input type="hidden" class="form-control" id="menuNo" name="menuNo" value="${optionGroup.menuNo}"/>--%>
<%--                </div>--%>
<%--                </div>--%>

<%--<div class="float-left">--%>
<%--        <div class="form-group">--%>
<%--        <label for="optionName" class="control-label">옵션이름</label>--%>
<%--        <div>--%>
<%--            <input type="text" class="form-control" id="optionName" name="optionName"  value="${optionGroup.optionName}" placeholder="${optionGroup.optionName}">--%>
<%--            </div>--%>
<%--        </div>--%>

<%--        <div class="form-group">--%>
<%--        <label for="optionPrice" class="control-label">옵션가격</label>--%>
<%--        <div>--%>
<%--            <input type="text" class="form-control" id="optionPrice" name="optionPrice"  value="${optionGroup.optionPrice}" placeholder="${optionGroup.optionPrice}">--%>
<%--            </div>--%>
<%--        </div>--%>
<%--</div>--%>

<%--        </c:forEach>--%>

    <%--        <c:set var="i" value="0"/>--%>
<%--        <c:forEach var="optionGroup" items="${list}">--%>
<%--            <c:set var="i" value="${i+1}"/>--%>

<%--            <div class="form-group">--%>
<%--                <label for="optionGroupName" class="control-label\">옵션그룹이름</label>--%>
<%--                <div>--%>
<%--                <input type="text" class="form-control" id="optionGroupName" name="optionGroupName"  value="${optionGroup.optionGroupName}" placeholder="${optionGroup.optionGroupName}">--%>
<%--                <input type="hidden" class="form-control" id="optionNo" name="optionNo" value="${optionGroup.optionNo}"/>--%>
<%--                <input type="hidden" class="form-control" id="menuNo" name="menuNo" value="${optionGroup.menuNo}"/>--%>
<%--                </div>--%>
<%--                </div>--%>

<%--<div class="float-left">--%>
<%--        <div class="form-group">--%>
<%--        <label for="optionName" class="control-label">옵션이름</label>--%>
<%--        <div>--%>
<%--            <input type="text" class="form-control" id="optionName" name="optionName"  value="${optionGroup.optionName}" placeholder="${optionGroup.optionName}">--%>
<%--            </div>--%>
<%--        </div>--%>

<%--        <div class="form-group">--%>
<%--        <label for="optionPrice" class="control-label">옵션가격</label>--%>
<%--        <div>--%>
<%--            <input type="text" class="form-control" id="optionPrice" name="optionPrice"  value="${optionGroup.optionPrice}" placeholder="${optionGroup.optionPrice}">--%>
<%--            </div>--%>
<%--        </div>--%>
<%--</div>--%>

<%--        </c:forEach>--%>

        <div id="here"></div>




        <div class="form-group">
            <div class="col-sm-offset-4  col-sm-4 text-center">
                <button type="submit" class="btn btn-primary" id="updateMenuButton">수 &nbsp;정</button>
                <a class="btn btn-primary btn" href="#" role="button">취 &nbsp;소</a>
            </div>
        </div>

    </form>
</div>

</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>

<jsp:include page="/views/footer.jsp" />
</body>

<script>



</script>


</html>



