<%@ page contentType="text/html; charset=utf-8" %>
<%@ page pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html lang="ko">

<head>

    <title>F.FIN | 게시글 작성</title>
    <jsp:include page="../../common/lib.jsp"/>
    <!-- 참조 : http://getbootstrap.com/css/   참조 -->
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <!-- bootstrap core css -->
    <link rel="stylesheet" type="text/css" href="../../resources/bootstrap/css/bootstrap.css" />
    <!-- Custom styles for this template -->
    <link href="../../resources/bootstrap/css/style.css" rel="stylesheet" />

    <!--    Favicons-->
    <link rel="apple-touch-icon" sizes="180x180" href="../../resources/bootstrap/assets/favicons/apple-touch-icon.png">
    <link rel="icon" type="image/png" sizes="32x32" href="../../resources/bootstrap/assets/favicons/favicon-32x32.png">
    <link rel="icon" type="image/png" sizes="16x16" href="../../resources/bootstrap/assets/favicons/favicon-16x16.png">
    <link rel="shortcut icon" type="image/x-icon" href="../../resources/bootstrap/assets/favicons/favicon.ico">
    <link rel="manifest" href="../../resources/bootstrap/assets/favicons/manifest.json">
    <meta name="msapplication-TileImage" content="../../resources/bootstrap/assets/favicons/mstile-150x150.png">
    <meta name="theme-color" content="#ffffff">


    <!--  ///////////////////////// JavaScript ////////////////////////// -->
    <script type="text/javascript">

        //============= "작성완료"  Event 연결 =============
        $(function () {
            //==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
            $("#addPostView").on("click", function () {
                fncAddPost();
            });
        });

        //============= "취소"  Event 처리 및  연결 =============
        $(function () {
            //==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
            $("button.btn.btn-cancle").on("click", function () {
                self.location = "/community/getPostList"
            });
        });

        function fncAddPost() {
            // 유효성체크
            var title = $("input[name='postTitle']").val();
            var content = $("textarea[name='postContent']").val();

            if (title == null || title.length < 1) {
                alert("게시물 제목은 반드시 입력하셔야 합니다.");
                return;
            }
            if (content == null || content.length < 1) {
                alert("게시물 내용은 반드시 입력하셔야 합니다.");
                return;
            }
            $("form").attr("method", "POST").attr("action", "/community/addPost").attr("enctype", "multipart/form-data").submit();
            alert("게시물 작성이 완료되었습니다.");
        }


    </script>

</head>


<body id="page-top">

<jsp:include page="/views/navbar.jsp"/>
<br/><br/><br/><br/>
<c:if test="${sessionScope.user != null || sessionScope.truck != null}">
<div class="container">

    <div class="page-header" style="text-align: center">
        <label for="page-top"/>
        <i class="fa fa-quote-left" aria-hidden="true" style="color: #f17228;"></i>
        <h4 style="margin-top: 10px;"> 게시글 작성
        </h4>
</div>
    <br>

<form class="form-horizontal">
<!-- 게시판 글쓰기 양식 영역 시작 -->
<div class="form-group">
    <table class="table table-striped" style="text-align: center; border: 1px solid #dddddd">
        <tbody>
        <tr>
            <td><input id="postTitle" type="text" class="form-control" placeholder="게시글 제목" name="postTitle"
                       maxlength="50"></td>
        </tr>
        <tr>
            <td><textarea id="postContent" class="form-control" placeholder="게시글 내용" name="postContent" maxlength="3000"
                          style="height: 350px;"></textarea></td>
        </tr>
        <!-- 푸드트럭 사업자등록증 파일업로드란 -->
        <td>
            <label class="col-sm-2 col-form-label"><strong>첨부 파일</strong></label>
            <div class="form-group">
                <div class="col-sm-6 offset-2" style="display: flex; align-items: baseline;">
                    <label for="file1" class="col-sm-offset-1 col-sm-4 control-label">첨부파일1</label>
                    <input type="file" class="form-control" id="file1" name="file1"  value="${post.postFile1}" placeholder="이미지1" onchange="setPostFile1Preview(event);">
                </div>
                <div id="file1preview"></div>
            </div>
            <div class="form-group">
                <div class="col-sm-6 offset-2" style="display: flex; align-items: baseline;">
                    <label for="file2" class="col-sm-offset-1 col-sm-4 control-label">첨부파일2</label>
                    <input type="file" class="form-control" id="file2" name="file2"  value="${post.postFile2}" placeholder="이미지2" onchange="setPostFile2Preview(event);">
                </div>
                <div id="file2preview"></div>
            </div>
            <div class="form-group">
                <div class="col-sm-6 offset-2" style="display: flex; align-items: baseline;">
                    <label for="file3" class="col-sm-offset-1 col-sm-4 control-label">첨부파일3</label>
                    <input type="file" class="form-control" id="file3" name="file3"  value="${post.postFile3}" placeholder="이미지3" onchange="setPostFile3Preview(event);">
                </div>
                <div id="file3preview"></div>
            </div>
            </td>

        <script>


            function setPostFile1Preview(event){

                var DIVimage1preview = $('#file1preview');
                var isTherePreview = DIVimage1preview.find('img').length;
                //alert("isTherePreview : " + isTherePreview);
                //이미지파일미리보기 이미 있으면 바꾸기 구현 중-  점심먹고 왔다! 다시 시작!
                var reader  = new FileReader();

                if(isTherePreview==0){

                }else{

                    DIVimage1preview.find('img').remove();

                }

                reader.onload = function(event){
                    var img = document.createElement("img");
                    img.setAttribute("src", event.target.result);
                    document.querySelector("div#file1preview").appendChild(img);

                };

                reader.readAsDataURL(event.target.files[0]);


            }

            function setPostFile2Preview(event){
                var reader  = new FileReader();
                var DIVimage2preview = $('#file2preview');
                var isTherePreview = DIVimage2preview.find('img').length;
                //alert("isTherePreview : " + isTherePreview);
                //이미지파일미리보기 이미 있으면 바꾸기 구현 중-  점심먹고 왔다! 다시 시작!
                var reader  = new FileReader();

                if(isTherePreview==0){

                }else{

                    DIVimage2preview.find('img').remove();

                }

                reader.onload = function(event){
                    var img = document.createElement("img");
                    img.setAttribute("src", event.target.result);
                    document.querySelector("div#file2preview").appendChild(img);

                };

                reader.readAsDataURL(event.target.files[0]);

            }

            function setPostFile3Preview(event){
                var reader  = new FileReader();
                var DIVimage3preview = $('#file3preview');
                var isTherePreview = DIVimage3preview.find('img').length;
                //alert("isTherePreview : " + isTherePreview);
                //이미지파일미리보기 이미 있으면 바꾸기 구현 중-  점심먹고 왔다! 다시 시작!
                var reader  = new FileReader();

                if(isTherePreview==0){

                }else{

                    DIVimage3preview.find('img').remove();

                }

                reader.onload = function(event){
                    var img = document.createElement("img");
                    img.setAttribute("src", event.target.result);
                    document.querySelector("div#file3preview").appendChild(img);

                };

                reader.readAsDataURL(event.target.files[0]);

            }

        </script>



        </tbody>
    </table>
</div>
<!-- 게시판 글쓰기 양식 영역 끝 -->

    <br/>
    <div class="form-group">
    <div class="offset-3 col-sm-6 text-center">
    <button type="button" class="btn btn-default" id="addPostView">작 성 완 료</button>
    <button class="btn btn-cancle" type="button">취 소</button>
    </div>
    </div>
    </form>

    </div>
</c:if>
<c:if test="${sessionScope.user == null && sessionScope.truck == null}">
<div class="col-sm-offset-6 text-center">
    <h3>회원가입 이후 게시판을 이용하실 수 있습니다</h3>
    <br/><br/>
    <a href="/views/user/addUserInfo.jsp" class="btn-warning">일반회원가입</a>
    <a href="/views/truck/addTruckView.jsp" class="btn-warning">사업자회원가입</a>
    <a href="/catering/mainTruckList" class="btn-warning">메인화면으로</a>
</div>
</c:if>
    <jsp:include page="/views/footer.jsp"/>

    </body>

    </html>
