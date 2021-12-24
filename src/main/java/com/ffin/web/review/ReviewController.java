package com.ffin.web.review;

import com.ffin.service.domain.*;
import com.ffin.service.purchase.PurchaseService;
import com.ffin.service.review.ReviewService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.io.File;

// 리뷰 관리 Controller
@Controller
@RequestMapping("/review/*")
public class ReviewController {

    ///FFF
    @Autowired
    @Qualifier("reviewServiceImpl")
    private ReviewService reviewService;

    @Autowired
    @Qualifier("purchaseServiceImpl")
    private PurchaseService purchaseService;

    @Value("100") //pageUnit은 propertySource를 위에 선언하고 @value의 값을 지정해줌
    //추후 pageUnit과 pageSize 출력되는지 jUnit에서 확인이 필요합니다.
    //@Value("#{commonProperties['pageUnit'] ?: 3}")
    int pageUnit;

    @Value("100")
    int pageSize;

    //add는 성원님이 getOrderDetail 수정해주시면 그 때
//    @RequestMapping(value = "addReview", method= RequestMethod.GET)
//    public ModelAndView addReview(@RequestParam("orderNo") int orderNo) throws Exception{
//
//        /*
//            이용자가 리뷰를 등록하기 위해 사용하는 화면
//            orderNo로 이용자의 주문 정보를 화면에 뿌려주고, 추가할 리뷰 정보를 받는다.
//         */
//        System.out.println("/review/addReview : GET");
//        System.out.println("orderNo : " + orderNo);
//
//        Purchase purchase = purchaseService.getPurchase(orderNo);
//
//        OrderDetail orderDetail = purchaseService.getOrderDetail(orderNo);
//        System.out.println("truck : " + truck);
//
//        ModelAndView modelAndView = new ModelAndView();
//        modelAndView.addObject("truck", truck);
//        modelAndView.setViewName("/menu/addMenuView.jsp");
//
//        return modelAndView;
//    }

    @RequestMapping(value="updateReview", method=RequestMethod.GET)
    public ModelAndView updateReview(HttpServletRequest request, ModelAndView modelAndView) throws Exception{

        System.out.println("/review/updateReview : GET");

        //Business Logic

        String reviewNoo = request.getParameter("reviewNo");

        int reviewNo = Integer.parseInt(reviewNoo);

        Review review = reviewService.getReview(reviewNo);

        //Model - View 연결
        modelAndView.addObject("review", review);
        modelAndView.setViewName("/review/updateReviewView.jsp");

        System.out.println("request = " + request + ", modelAndView = " + modelAndView);

        return modelAndView;
    }

    @RequestMapping(value="updateReview", method=RequestMethod.POST)
    public String updateReview(@ModelAttribute("review") Review review, @RequestParam(value="fileUpload", required = false) MultipartFile file, Model model) throws Exception{
//        if(!file.getOriginalFilename().isEmpty()){
//            file.transferTo(new File(FILE_SERVER_PATH, file.getOriginalFilename()));
//        }
//
//        review.setRvImg1(file.getOriginalFilename());

        System.out.println("review = " + review + ", file = " + file + ", model = " + model);

        reviewService.updateReview(review);

        return "forward:/review/updateReview.jsp";
    }

}
