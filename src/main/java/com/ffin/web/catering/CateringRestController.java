package com.ffin.web.catering;



import com.ffin.common.Search;
import com.ffin.service.catering.CateringService;
import com.ffin.service.domain.Catering;
import com.ffin.service.domain.Truck;
import com.ffin.service.domain.User;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/catering/*")
public class CateringRestController {

    ///Field
    @Autowired
    @Qualifier("cateringServiceImpl")
    private CateringService cateringService;


    public CateringRestController(){
        System.out.println(this.getClass());
    }

/*

    @Value("#{commonProperties['pageUnit']}")
    //@Value("#{commonProperties['pageUnit'] ?: 3}")
    int pageUnit;

    @Value("#{commonProperties['pageSize']}")
    //@Value("#{commonProperties['pageSize'] ?: 2}")
    int pageSize;
*/

    /*@RequestMapping( value="json/mainCalendar", method= RequestMethod.POST)
    @ResponseBody
    public ArrayList mainCalendar(@ModelAttribute("search") Search search , HttpSession session) throws Exception {
        System.out.println("CateringController.mainCalendar");
        *//*
            메인 화면
            달력으로 노출할 예정
            이용자, 사업자 구분
         *//*
        String id="";
        Map<String , Object> map= new HashMap<String , Object>();
        String role = (String)session.getAttribute("role");// role로 구분할 예정 - user / truck
        System.out.println("role = " + role);

        if (role == "user" || role.equals("user")){
            // user 라면
            // session 처리 되면 주석 풀어서 체크하기. 지금은 임의로 한거.
            //id = ((User)session.getAttribute("user")).getUserId();
            id = (String) session.getAttribute("userId");
            System.out.println("user id: "+id);
            search.setSearchCondition("2");

        }else if(role == "truck" || role.equals("truck")){
            // truck이라면
            // id = ((Truck)session.getAttribute("truck")).getTruckId();
            id = (String) session.getAttribute("truckId");
            System.out.println("truck id: "+id);
            search.setSearchCondition("1");

        }
        map = cateringService.getCtList(search, id);
        List<Catering> list = (List<Catering>) map.get("list");

        JSONObject obj = new JSONObject();
        JSONArray jsonArray = new JSONArray();

        ArrayList ja = new ArrayList();

        if(list.size()>0){
            for(int i=0; i<list.size(); i++){
                Map<String, Object> ctMap = new HashMap<>();

                ctMap.put("title", list.get(i).getCtNo());
                ctMap.put("start", list.get(i).getCtDate());
                ctMap.put("end", list.get(i).getCtDate());
                System.out.println("ctMap = " + ctMap);
                //jsonArray.put(sObject);
                ja.add(i, ctMap);


                System.out.println("ja = " +i+" ::: " + ja);
            }
            //obj.put("item", jsonArray);
        }
        //System.out.println("list = " + list);
        //Map<String, Catering> ctMap = new HashMap<>();

        //ArrayList ctList = new ArrayList();

       // System.out.println("ctList = " + ctList);

        System.out.println("ja = " + ja);
        return ja;


       *//* ModelAndView modelAndView = new ModelAndView();
        modelAndView.addObject("list", map.get("list"));
        modelAndView.setViewName("/views/catering/mainCalendar.jsp");
        return modelAndView;*//*
    }*/

    @RequestMapping( value="json/updateUserRes")
    @ResponseBody
    public Catering updateUserRes(HttpServletRequest request, HttpServletResponse response) throws Exception {

        System.out.println("json/updateUserRes   : POST");
        request.setCharacterEncoding("UTF-8");

        // statusCode (수락시/거절시/취소시)
        // memo (수락메모/거절메모/ 취소시null)
        // update method 쓰고 (status와 memo만 업데이트 하는 메소드 생성)
        // return 값은 예약내용 보내야하니까 ResCatering
        Catering catering = new Catering();
        catering = cateringService.getCtDetail(1); // 그냥... 이건 아늶...
        return catering;
    }




    @RequestMapping( value="json/getCtDetail/{ctNo}", method=RequestMethod.GET)
    @ResponseBody
    public ModelAndView getCtDetail(@PathVariable("ctNo") int ctNo, HttpServletRequest request, HttpServletResponse response) throws Exception {
            /*
                서비스내역, 예약 내역을 불러온다.
                상세정보조회.
             */
        request.setCharacterEncoding("UTF-8");

        System.out.println("CateringController.REST");
        System.out.println("ctNo = " + ctNo);

        Catering catering = cateringService.getCtDetail(ctNo);
        System.out.println("catering = " + catering);
            /*Map<String, Object> map = new HashMap<>();
            map.put("ctNo", catering.getCtNo());
            map.put("ctTruckId", catering.getCtTruck().getTruckId());*/
        ModelAndView mv = new ModelAndView("jsonView");
        mv.addObject("catering", catering);

        return mv;
    }


    @RequestMapping( value="json/updateCtResAdd", method=RequestMethod.POST)
    @ResponseBody
    public String updateCtResAdd(HttpServletRequest request, HttpServletResponse response) throws Exception {
        /*
            이용자가 예약을 등록함
         */
        request.setCharacterEncoding("UTF-8");
        System.out.println("CateringController.updateCtResAdd");

        int ctNo = Integer.parseInt(request.getParameter("ctNo"));
        String ctUserId = request.getParameter("ctUserId");
        String ctPhone = request.getParameter("ctUserPhone");
        String ctAdd = request.getParameter("ctUserAddr");
        String ctAddDetail = request.getParameter("ctUserAddrDetail");
        int ctMenuQty = Integer.parseInt(request.getParameter("ctMenuQty"));
        int ctQuotation = Integer.parseInt(request.getParameter("ctQuotation"));
        String ctStartTime = request.getParameter("ctStartTime");
        String ctEndTime = request.getParameter("ctEndTime");
        String ctUserRequest = request.getParameter("ctUserRequest");

        User user = new User();
        user.setUserId(ctUserId);
        Catering catering = new Catering();
        catering.setCtNo(ctNo);
        catering.setCtUser(user);
        catering.setCtPhone(ctPhone);
        catering.setCtAdd(ctAdd);
        catering.setCtAddDetail(ctAddDetail);
        catering.setCtMenuQty(ctMenuQty);
        catering.setCtQuotation(ctQuotation);
        catering.setCtStartTime(ctStartTime);
        catering.setCtEndTime(ctEndTime);
        catering.setCtUserRequest(ctUserRequest);


        cateringService.updateCtResAdd(catering);

        //Catering resCatering = cateringService.getCtDetail(catering.getCtNo());
        // 업데이트 이후, 등록된 전체 내용을 보내고자 함

       /* ModelAndView modelAndView = new ModelAndView();
        modelAndView.addObject("catering", resCatering);
        modelAndView.setViewName("/views/catering/getCtDetail.jsp");*/
        return "y";
    }



}