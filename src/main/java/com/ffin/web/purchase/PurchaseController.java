package com.ffin.web.purchase;

import com.ffin.common.Page;
import com.ffin.common.Search;
import com.ffin.service.domain.*;
import com.ffin.service.menu.MenuService;
import com.ffin.service.purchase.PurchaseService;
import com.ffin.service.review.ReviewService;
import com.ffin.service.truck.TruckService;
import com.sun.javafx.collections.MappingChange;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.mock.web.MockHttpSession;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import javax.jws.WebParam;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpSessionContext;
import java.util.*;

@Controller
@RequestMapping("/purchase/*")
public class PurchaseController {

    ///Field
    @Autowired
    @Qualifier("purchaseServiceImpl")
    private PurchaseService purchaseService;
    //setter Method 구현 않음

    @Autowired
    @Qualifier("menuServiceImpl")
    private MenuService menuService;
    //Setter method 구현 안 한다.

    @Autowired
    @Qualifier("truckServiceImpl")
    private TruckService truckService;

    public PurchaseController() {
        System.out.println(this.getClass());
    }

    //==> classpath:config/common.properties  ,  classpath:config/commonservice.xml 참조 할것
    //==> 아래의 두개를 주석을 풀어 의미를 확인 할것
    @Value("#{commonProperties['pageUnit']}")
    //@Value("#{commonProperties['pageUnit'] ?: 3}")
            int pageUnit;

    @Value("#{commonProperties['pageSize']}")
    //@Value("#{commonProperties['pageSize'] ?: 2}")
    int pageSize;

    @Autowired
    @Qualifier("reviewServiceImpl")
    private ReviewService reviewService;

    private static final String FILE_UPLOAD_PATH = "/resources/image/";

    @RequestMapping("getMenuList")
    public ModelAndView getMenuList(@ModelAttribute("search") Search search,
                                    @RequestParam("truckId") String truckId,
                                    HttpServletResponse response,
                                    ModelAndView modelAndView) throws Exception {

//        File file = new File(FILE_UPLOAD_PATH, fileName);
//        byte[] bytes = FileCopyUtils.copyToByteArray(file);
//        String fn = new String(file.getName().getBytes(), "utf-8");
//        response.setHeader("Content-Disposition", "attachment;filename=\""+fn+"\"");
//        response.setContentLength(bytes.length);

        search.setPageSize(pageSize);
        Truck truck = truckService.getTruck(truckId);
        float rvAvg = reviewService.getReviewAvg(search, truckId);
        int rvTotal = reviewService.getReviewTotalCount(search, truckId);
        truck.setTruckAVGStar(rvAvg);

        Map<String, Object> map = menuService.getMenuList(search, truck.getTruckId());

        modelAndView.addObject("list", map.get("list"));
        modelAndView.addObject("path", FILE_UPLOAD_PATH);
        modelAndView.addObject("truck", truck);
        if (rvTotal != 0) {

            modelAndView.addObject("rvTotal", rvTotal);
        }

        modelAndView.setViewName("/views/purchase/getTruck.jsp");

        return modelAndView;
    }

    //장바구니에 출력할 데이터이다 현재는 UI가 없어서 저장된 데이터를 불러오고 있다
    //Session에 저장할때 어떻게 할지 생각해보자
    @RequestMapping(value = "getCartMenuList", method = RequestMethod.GET)
    public ModelAndView getCartMenuList(@RequestParam("orderNo") int orderNo, ModelAndView model, HttpSession session) throws Exception {
        System.out.println("/purchase/getCartMenuList : GET");
        //Session에 저장되어 있는 메뉴정보를 map에 담아서 List 로 확인
        Purchase purchase = new Purchase();
        OrderDetail orderDetail = new OrderDetail();
        Map map = new HashMap();
        map = purchaseService.getOrderDetail(orderNo);

        session.getAttribute("menuOdList");
        System.out.println("session에 저장된 정보" + session);

        // session.setAttribute("cart",orderDetail);
        purchase = purchaseService.getPurchase(orderNo);
        model.addObject("purchase", purchase);
        model.addObject("map", map);
        model.setViewName("forward:/views/purchase/getCartMenuList.jsp");


        return model;
    }

    //user구매목록
    @RequestMapping(value = "getPurchaseList")
    public String getPurchaseList(@ModelAttribute("search") Search search, Model model,
                                  HttpSession session) throws Exception {

        System.out.println("PurchaseController.getPurchaseList");

        if (search.getCurrentPage() == 0) {
            search.setCurrentPage(1);
        }
        search.setPageSize(pageSize);

        Map<String, Object> map = purchaseService.getPurchaseList(search, ((User) session.getAttribute("user")).getUserId());

//        Page resultPage = new Page(search.getCurrentPage(), (Integer) map.get("totalCount"), pageUnit, pageSize);
//        System.out.println("search = " + search + "resultPage = "+resultPage);

        model.addAttribute("list", map.get("list"));
//        model.addAttribute("resultPage", resultPage);
        model.addAttribute("search", search);

        return "/views/user/getPurchaseListByUser.jsp";
    }


    @RequestMapping(value = "addCart", method = RequestMethod.GET)
    public String addCart(@RequestParam("orderNo") int orderNo, Model model) throws Exception {

        System.out.println("/purchase/addCart : GET");
        System.out.println("orderNo = " + orderNo + ", model = " + model);
        Map<String, Object> coupontList = new HashMap<String, Object>();
        Purchase purchase = new Purchase();
        User user = new User();
        Coupon coupon = new Coupon();
        Map map = new HashMap();


        map = purchaseService.getOrderDetail(orderNo);
        Map cart = purchaseService.getCartList(orderNo);
        purchase = purchaseService.getPurchase(orderNo);
        user = purchaseService.getTotalPoint(purchase.getOrderUserId().getUserId());
        coupon.setCouponReceivedUserId(purchase.getOrderUserId());
        coupontList = purchaseService.getCouponList(coupon);

        System.out.println("couponList////////////////////////////////////////////" + coupontList);

        model.addAttribute("map", map);
        model.addAttribute("couponList", coupontList);
        model.addAttribute("purchase", purchase);
        model.addAttribute("cart", cart);
        model.addAttribute("orderNo", purchase.getOrderNo());
        model.addAttribute("totalPoint", user);


        return "forward:/views/purchase/addPayView.jsp";
    }

    //장바구니에서 주문하기 클릭시 선택한 주문정보와 픽업희망시간 주문요청사항을 입력받아서 같이 등록한다.
    @RequestMapping(value = "addCart", method = RequestMethod.POST)
    public String addCart(@ModelAttribute("orderDetail") OrderDetail orderDetail, @ModelAttribute("purchase") Purchase purchase, Model model) throws Exception {

        System.out.println("/purchase/addCart : POST");
        System.out.println("orderDetail11111 = " + orderDetail + ", purchase2222 = " + purchase);
        Point point = new Point();
        Purchase pur = new Purchase();
        Coupon coupon = new Coupon();
        Map<String, Object> coupontList = new HashMap<String, Object>();

        orderDetail.setOdOrderNo(purchase);
        System.out.println(purchase.getOrderNo());

        Map cart = purchaseService.getCartList(purchase.getOrderNo());
        purchase = purchaseService.getPurchase(purchase.getOrderNo());
        coupon.setCouponReceivedUserId(purchase.getOrderUserId());
        User totalPoint = purchaseService.getTotalPoint(purchase.getOrderUserId().getUserId());
        System.out.println("couponList////////////////////////////////////////////" + coupontList);
        coupontList = purchaseService.getCouponList(coupon);


        model.addAttribute("couponList", coupontList);
        model.addAttribute("point", point);
        model.addAttribute("purchase", purchase);
        model.addAttribute("cart", cart);
        model.addAttribute("orderNo", purchase.getOrderNo());
        model.addAttribute("totalPoint", totalPoint);


        return "forward:/views/purchase/addPayView.jsp";
    }

    //결제를 하게 되면 orderNo를 가지고 결제정보를 update를 한다.
    // 추후 Iamport로 데이터를 받아서 navigation 되는데 이게 Rest에서 처리를 해줄지 아니면 Controller에서 넘겨줄지
    // Rest로 하게 되면 add하고 get해서 ㅓㅣㅇㄴㅁ럼니 고민 해보자 뭔가 이유가 있었는데 안돌아간다..
    // 아니다 함쳐야겠다!!!!
    // 아닌가?? 주문하고 주문취소했을때를 위해??
    @RequestMapping(value = "addOrder", method = RequestMethod.POST)
    public String addOrder(@ModelAttribute("purchase") Purchase purchase, @ModelAttribute("user") User user,
                           @ModelAttribute("coupon") Coupon coupon, @ModelAttribute("point") Point point, Model model) throws Exception {
        //결제하기 클릭 시 입력한 결제방법과 결제금액 결제일시
        //
        System.out.println("/purchase/addOrder : POST");
        //addOrder(),updateCouponStatus(),
        //       updatePoint (),updateTotalPoint ()
        System.out.println("1111111111111111: "+purchase);
        purchaseService.updatePurchase(purchase);
        if (coupon.getCouponNo() != 0) {
            purchaseService.updateCouponStatus(coupon);
            purchase.setPayCouponNo(coupon);
        }

        if (point.getPointAmt() != 0) {
            int pointNo = purchaseService.updatePoint(point);
            purchaseService.updateTotalPoint(user);
            point.setPointNo(pointNo);
            purchase.setPayPointNo(point);
        }
/*        point.setPointAmt(purchase.getPayPrice());
        point.setPointPlmnStatus(1);
        purchaseService.updatePoint(point);*/
        //updatePoint메서드 두번을 사용한다 orderNo를 point정보에 넣어서 추후 환불시 거기에 맞게 로직
        //1번째는 point사용시 로지 2번째는 결제시 2%적립 되는로직 생각하자!!

        System.out.println("22222222222"+purchase);
        Map map = purchaseService.getOrderDetail(purchase.getOrderNo());
        System.out.println("3333333333"+map.get("list"));
        model.addAttribute(purchase);




        return "forward:/purchase/getOrderUser";
    }

    @RequestMapping(value = "getOrderUser", method = RequestMethod.POST)
    public ModelAndView getOrderUser(@ModelAttribute("purchase") Purchase purchase, @ModelAttribute("user") User user,
                                     @ModelAttribute("point") Point point, ModelAndView model) throws Exception {

        System.out.println("/purchase/getOrderUser : POSTPOSTPOSTPOSTPOST");

        System.out.println("4444444444444444"+purchase);
        int payPrice = purchase.getPayPrice();
        int payOption = purchase.getPayOption();
        purchase = purchaseService.getPurchase(purchase.getOrderNo());
        if(payPrice != 0 ){
            purchase.setPayPrice(payPrice);
        }
        int orderCheck = 0;
        purchase.setPayOption(payOption);
        purchase.setOrderStatus(1);
        System.out.println("//////////////////////////////////////payPrice :"+payPrice+"payOption :"+payOption);
        System.out.println("5555555555555555"+purchase);
        Map map = new HashMap();
        map = purchaseService.getOrderDetail(purchase.getOrderNo());

        System.out.println("map//////////" + map);
        System.out.println("map.put "+map.get("list"));
        model.addObject("map", map);
        model.addObject("purchase", purchase);
        model.addObject("orderCheck",orderCheck);
        model.setViewName("forward:/views/purchase/getOrderUser.jsp");


        return model;

    }

    @RequestMapping(value = "getOrderUserList")
    public String getOrderUserList(@ModelAttribute("search")Search search, HttpSession session,Model model)throws Exception{
         System.out.println("getOrderList\n\n");

    User user = (User) session.getAttribute("user");
    String userId = user.getUserId();
        System.out.println("userId :: "+userId);

        if(search.getCurrentPage()==0)

    {
        search.setCurrentPage(1);
    }
        search.setPageSize(pageSize);

    Map<String, Object> map = purchaseService.getOrderUserList(search, userId);


//        Page resultPage = new Page(search.getCurrentPage(), ((Integer) map.get("totalCount")).intValue(), pageUnit, pageSize);
//        System.out.println("resultPage :: "+resultPage);
        ArrayList list = new ArrayList<>();
        list.add(map.get("list").toString());
        System.out.println("주문량을 확인"+map.size());
        System.out.println("list"+map.get("list"));
        System.out.println("list에 담은 정보");

        System.out.println("주문량을 확인하기 위해서");
        System.out.println("map = "+map);
        for(int i =0; i<list.size(); i++){
        }
        model.addAttribute("list",map.get("list"));
//        model.addAttribute("resultPage", resultPage);
        model.addAttribute("search",search);

        return "forward:/views/purchase/getOrderUserList.jsp";
}


    //현재주문정보 화면으로 보여줄 데이터를 가져온다.
    @RequestMapping(value = "getOrderUser", method= RequestMethod.GET)
    public ModelAndView getOrderUser(@RequestParam("orderNo") int orderNo, ModelAndView model,Purchase purchase,HttpServletRequest request) throws Exception {

        System.out.println("/purchase/getOrderUser : GETGETGETGETGETGET");

        purchase.setOrderNo(orderNo);
            purchase = purchaseService.getPurchase(purchase.getOrderNo());

           String orderCount =  request.getParameter("orderCount");
        System.out.println("orderCount : orderCount : "+orderCount);
            int orderCheck = 0;
        System.out.println(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>");
        System.out.println("ppppppppppppurchase11111 + "+purchase);
            Map map = new HashMap();
            map = purchaseService.getOrderDetail(purchase.getOrderNo());

        System.out.println("map.get "+map.get("list"));
        System.out.println("map//////////"+map);
            model.addObject("map",map);
            model.addObject("purchase",purchase);
        model.addObject("orderCheck",orderCheck);
        model.addObject("movePage",orderCount);
            model.setViewName("forward:/views/purchase/getOrderUser.jsp");

    return  model;

    }



    //현재주문정보에서 주문취소 버튼을 클릭 시 iamport환불이다...!!!! Rest로 바꿔야된다!!!
    @RequestMapping(value = "updateOrderCancel", method= RequestMethod.POST)
    public String updateOrderCancel(@RequestParam("purchase")Purchase purchase, @RequestParam("user") User user,
                                    @RequestParam("point") Point point, Model model) throws Exception{

        System.out.println("/purchase/updateOrderCancel : POST");

        purchaseService.updateOrderCancel(purchase);
        purchaseService.updateTotalPoint(user);
        purchaseService.updatePoint(point);
        model.addAttribute(purchase);

        return "forward:/purchase/getOrderUser";
    }

    //푸드트럭사장님이 확인할 수 있는 화면으로
    //OrderList로 좌측에 있는 리스트를 보여주는 이때 무한스크롤!!!
    //우측은!! 여기서 왼쪽을 클릭하게 되면 나오는 화면으로 따로 해야되나?? 같이 해야되나???
    //getOrderList로 출력한 Map으로 처음들어갔을때 나오는 화면으로 최신주문orderNo를 가져와서 보여주는것도!!!
    @RequestMapping(value = "getOrderList", method= RequestMethod.GET)
    public String getOrderList(@RequestParam("truckId")String truckId, Model model, Purchase purchase, HttpServletRequest request, HttpServletResponse response) throws Exception{

        System.out.println("/purchase/getOrderList : POST");
        System.out.println("truckId = " + truckId + ", model = " + model + ", purchase = " + purchase + ", request = " + request + ", response = " + response);

        Truck truck = new Truck();
        Search search = new Search();

        if(request.getParameter("search").equals("1") ) {
            search.setSearchCondition(request.getParameter("search"));
        }else if(request.getParameter("search").equals("2")){
            search.setSearchCondition(request.getParameter("search"));
        } else if (request.getParameter("search").equals("0")) {
            search.setSearchCondition(request.getParameter("search"));
        }

        Map map = purchaseService.getOrderList(search,truckId);


        truck = purchaseService.getTruckBusiStatus(truckId);
       // purchase = purchaseService.getPurchase();
        System.out.println(map.get("purchase.getOrderNo"));

        model.addAttribute("map",map);
        model.addAttribute("search",search);
        model.addAttribute("truck",truck);

        System.out.println("END\n\n\n\n\n");

        return "forward:/views/purchase/getOrderTruckList.jsp";
    }


    /*@RequestMapping(value = "getOrderEndList", method= RequestMethod.GET)
    public String getOrderEndList(@RequestParam("truckId")String truckId, Model model, Purchase purchase, HttpServletRequest request, HttpServletResponse response) throws Exception{

        System.out.println("/purchase/getOrderEndList : GET");
        System.out.println("truckId = " + truckId + ", model = " + model + ", purchase = " + purchase + ", request = " + request + ", response = " + response);

        String truckTest = "truck01";
        Search search = new Search();
        search.setSearchCondition("1");
        Map orderMap = new HashMap();
        Truck truck = new Truck();
        Map map = purchaseService.getOrderList(search,truckId);



        if(request.getParameter("orderNo") == null || request.getParameter("orderNo") == ""  ) {
            int orderNo = purchaseService.getLastOrderNo(truckId);
            orderMap = purchaseService.getOrderDetail(orderNo);
            purchase = purchaseService.getPurchase(orderNo);


        }else {
            int orderNo = Integer.parseInt(request.getParameter("orderNo"));
            orderMap = purchaseService.getOrderDetail(orderNo);
            purchase = purchaseService.getPurchase(orderNo);
        }

        truck.setTruckBusiStatus(purchaseService.getTruckBusiStatus(truckId));
        // purchase = purchaseService.getPurchase();
        System.out.println(map.get("purchase.getOrderNo"));
        model.addAttribute("orderMap", orderMap);
        model.addAttribute("map",map);
        model.addAttribute("purchase",purchase);
        model.addAttribute("search",search);
        model.addAttribute("truck",truck);

        return "forward:/views/purchase/getOrderTruckList.jsp";
    }*/
    //접수클릭시 주문상태코드 변경
    @RequestMapping(value = "updateOrderTranCode", method= RequestMethod.GET)
    public String updateOrderTranCode(@RequestParam("purchase")Purchase purchase,Model model) throws Exception{

        System.out.println("/purchase/updateOrderTranCode : GET");

        purchaseService.updateOrderTranCode(purchase);
        model.addAttribute(purchase);

        //.updateOrderRefusal(),updatePoint(), updateTotalPoint()
        return "forward:/purchase/getOrderList";
    }

    //주문거절하게 되면 Iamport로 환불 처리 하는데 이것도 추후 Rest로 전환!!!!
    @RequestMapping(value = "updateRefundStatus", method= RequestMethod.GET)
    public String updateRefundStatus(@RequestParam("purchase")Purchase purchase,
                                   @RequestParam("point") Point point, Model model) throws Exception{

        System.out.println("/purchase/updateRefundStatus : GET");

        purchaseService.updateRefundStatus(purchase);
        model.addAttribute(purchase);

        //.updateOrderRefusal(),updatePoint(), updateTotalPoint()
        return "forward:/purchase/getOrderList";
    }


}