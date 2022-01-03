package com.ffin.web.menu;


import com.ffin.common.Page;
import com.ffin.common.Search;
import com.ffin.service.domain.Menu;
import com.ffin.service.domain.OptionGroup;
import com.ffin.service.domain.Truck;
import com.ffin.service.domain.User;
import com.ffin.service.menu.MenuService;
import com.ffin.service.truck.TruckService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpRequest;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

// 메뉴 관리 Controller
@Controller
@RequestMapping("/menu/*")
public class MenuController {

    ///FFF
    @Autowired
    @Qualifier("menuServiceImpl")
    private MenuService menuService;
    //Setter method 구현 안 한다.

    @Autowired
    @Qualifier("truckServiceImpl")
    private TruckService truckService;

    @Value("100") //pageUnit은 propertySource를 위에 선언하고 @value의 값을 지정해줌
    //추후 pageUnit과 pageSize 출력되는지 jUnit에서 확인이 필요합니다.
    //@Value("#{commonProperties['pageUnit'] ?: 3}")
    int pageUnit;

    @Value("100")
    int pageSize;

    @RequestMapping(value = "addMenu", method= RequestMethod.GET)
    public ModelAndView addMenu(@RequestParam("truckId") String truckId) throws Exception{

        /*
            사업자가 메뉴를 등록하기 위해 사용하는 화면
            truckId로 truck의 상호를 화면에 뿌려주고, 추가할 메뉴 정보를 받는다.
         */
        System.out.println("/menu/addMenu : GET");
        System.out.println("truckId : " + truckId);

        Truck truck = truckService.getTruck(truckId);
        System.out.println("truck : " + truck);

        ModelAndView modelAndView = new ModelAndView();
        modelAndView.addObject("truck", truck); //화면단에서 truck.truckId를 menuTruckId에 넣기
        modelAndView.setViewName("/views/menu/addMenuView.jsp");

        return modelAndView;
    }

    @Transactional(rollbackFor = Exception.class) //menu만 들어가고 optionGroup은 들어가지 않는 상황 방지
    @RequestMapping(value="addMenuOptionGroup", method=RequestMethod.POST)
    public String addMenuOptionGroup(HttpServletRequest request,@ModelAttribute("optionGroup")OptionGroup optionGroup, @ModelAttribute("menu") Menu menu, Model model) throws Exception{
   // public String addMenuOptionGroup(@ModelAttribute("optionGroup")OptionGroup optionGroup, Model model) throws Exception{
//    public String addMenuOptionGroup(HttpServletRequest request, Model model) throws Exception{

        System.out.println("/menu/addMenuOptionGroup:POST");

        System.out.println("optionGroup = " + optionGroup + ", menu = " + menu + ", model = " + model);

        int menuNo = menuService.addMenu(menu);

        System.out.println("menuNo : " + menuNo);


            optionGroup.setMenuNo(menuNo);

//        optionGroup.setMenuNo(menuNo);
            Menu menu1 = new Menu();

            System.out.println("/////////////////");


            System.out.println("optionGroupName : " + optionGroup.getOptionGroupName());
            System.out.println("optionName : " + optionGroup.getOptionName());
//        System.out.println("optionPrice : " + optionGroup.getOptionPrice());
            System.out.println("optionPrice : " + request.getParameterValues("optionPrice")[0]);


            String[] optionGroupName = optionGroup.getOptionGroupName().split(",");
            String [] optionName = optionGroup.getOptionName().split(",");
            String [] optionPrice = optionGroup.getOptionPrice().split(",");

            System.out.println("optionGroupName length: " + optionGroupName.length);
            System.out.println("optionName length: " + optionName.length);
            System.out.println("optionPrice length: " + optionPrice.length);

            List<OptionGroup> optionGroupList = new ArrayList<OptionGroup>();

            int optGroupNo = menuService.getLatestOptionGroupNo().getOptionGroupNo()+1;
            System.out.println("optGroupNo : " + optGroupNo);
            for(int i = 0; i<optionName.length; i++){



                OptionGroup optionGroup1 = new OptionGroup();

                optionGroup1.setMenuNo(menuNo);
                optionGroup1.setOptionPrice(optionPrice[i]);
                optionGroup1.setOptionName(optionName[i]);
                optionGroup1.setOptionGroupName(optionGroupName[i]);
//            if(optionGroupName[i]==null){
//                for(int j=i; j>0; j--){
//                    if(optionGroupName[j]!=null){
//                        optionGroup1.setOptionGroupName(optionGroupName[j]);
//                    }
//                    if(optionGroup1.getOptionGroupName()!=null){
//                        break;
//                    }
//                }
//
//            }else{
//                optionGroup1.setOptionGroupName(optionGroupName[i]);
//            }

                if(i==0){
                    optionGroup1.setOptionGroupNo(optGroupNo);
                }else{
                    if(optionGroupName[i].equals(optionGroupName[i-1])){
                        optionGroup1.setOptionGroupNo(optGroupNo);
                    }else{
                        optGroupNo++;
                        optionGroup1.setOptionGroupNo(optGroupNo);
                    }
                }
                System.out.println("optionGroup1 : " + optionGroup1);
                System.out.println("///// optGroupNo : " + optGroupNo);
                System.out.println("request = " + request + ", optionGroup = " + optionGroup + ", menu = " + menu + ", model = " + model);

                optionGroupList.add(optionGroup1);

            }

            menuService.addOptionGroup(optionGroupList);
            System.out.println("menuNo : " + menuNo);

//        menu = menuService.getMenu(menuNo);
            // Menu menu1 = menuService.getMenu(menuNo);
//        menuService.addOptionGroup(list);
//            model.addAttribute("menu", menu1);
            model.addAttribute("optionGroup-list", optionGroupList);



        model.addAttribute("menu", menu);
        model.addAttribute("menuNo", menuNo);

        System.out.println("model 확인 : " + model);

        return "redirect:/views/menu/getTruck.jsp";

    }

    @RequestMapping(value="addMenu", method=RequestMethod.POST)
    public String addMenu(HttpServletRequest request,@ModelAttribute("menu") Menu menu, Model model) throws Exception{

        System.out.println("/menu/addMenu:POST");

        System.out.println("request = " + request + ", menu = " + menu + ", model = " + model);

        int menuNo = menuService.addMenu(menu);

        System.out.println("menuNo : " + menuNo);


        model.addAttribute("menu", menu);
        model.addAttribute("truckId", menu.getMenuTruckId());

        System.out.println("model 확인 : " + model);

        return "redirect:/views/menu/getTruck.jsp";

    }

//    @Transactional //menu만 들어가고 optionGroup은 들어가지 않는 상황 방지
//    @RequestMapping(value="addMenuOptionGroup", method=RequestMethod.POST)
//    public String addMenuOptionGroup(@ModelAttribute("optionGroup")OptionGroup optionGroup, @ModelAttribute("menu") Menu menu, Model model) throws Exception{
//   // public String addMenuOptionGroup(@ModelAttribute("optionGroup")OptionGroup optionGroup, Model model) throws Exception{
////    public String addMenuOptionGroup(HttpServletRequest request, Model model) throws Exception{
//
//        System.out.println("/menu/addMenu:POST");
//
//
////        Menu menu = (Menu) request.getAttribute("menu");
////        OptionGroup optionGroup = (OptionGroup) request.getAttribute("optionGroup");
//               // System.out.println("optionGroup = " + optionGroup + ", model = " + model);
//        System.out.println("optionGroup = " + optionGroup + ", menu = " + menu + ", model = " + model);
//
//
//
//        int menuNo = menuService.addMenu(menu);
//        optionGroup.setMenuNo(menuNo);
////        int menuNo =1;
////        optionGroup.setMenuNo(menuNo);
//        List list = new ArrayList();
//        list.add(optionGroup);
//        menuService.addOptionGroup(list);
//        System.out.println("menuNo : " + menuNo);
//
////        menu = menuService.getMenu(menuNo);
//        Menu menu1 = menuService.getMenu(menuNo);
////        menuService.addOptionGroup(list);
//
//        model.addAttribute("menu", menu1);
//        model.addAttribute("optionGroup-list", list);
//        model.addAttribute("menuNo", menuNo);
//
//        System.out.println("model 확인 : " + model);
//
//        return "redirect:/views/menu/getTruck.jsp";
//
//    }


    @RequestMapping(value="getMenu", method=RequestMethod.GET)
    public String getMenu(@ModelAttribute("search") Search search, @RequestParam(value="menuNo", required = false) int menuNo, Model model, HttpServletRequest request, HttpServletResponse response) throws Exception{

        System.out.println("/menu/getMenu : GET");

        System.out.println("search = " + search + ", menuNo = " + menuNo + ", model = " + model + ", request = " + request + ", response = " + response);


        search.setPageSize(pageSize);

        Menu menu = menuService.getMenu(menuNo);

        Map optionGroup = menuService.getOptionGroupByMenu(search,menuNo);

        System.out.println("menu : " + menu);

        model.addAttribute("menu", menu);
        model.addAttribute("menuNo", menuNo);
        model.addAttribute("list", optionGroup.get("list"));

        System.out.println("list="+ optionGroup.get("list")+", search = " + search + ", menuNo = " + menuNo + ", model = " + model + ", request = " + request + ", response = " + response);

        return "forward:/views/menu/getMenu.jsp";
    }

//    @RequestMapping(value="getMenu", method=RequestMethod.POST)
//    public String getMenu(@ModelAttribute("menuNo") int menuNo, Model model, HttpSession session) throws Exception{
//        System.out.println("/menu/getMenu : POST");
//
//        //BL
//        Menu menu = menuService.getMenu(menuNo);
//
//        session.setAttribute("menu", menu);
//
//        return "redirect:/views/menu/getMenu?menuNo="+menu.getMenuNo();
//
//    }

    @RequestMapping(value="updateMenu", method=RequestMethod.GET)
    public String updateMenu(@ModelAttribute("search") Search search, @RequestParam(value="menuNo", required = false) int menuNo, Model model, HttpServletRequest request, HttpServletResponse response) throws Exception{

        System.out.println("/menu/updateMenu : GET");

        //Business Logic

        search.setPageSize(pageSize);

        Menu menu = menuService.getMenu(menuNo);

        Map optionGroup = menuService.getOptionGroupByMenu(search, menuNo);

        System.out.println("menu : " + menu);

        model.addAttribute("menu", menu);
        model.addAttribute("menuNo", menuNo);
        model.addAttribute("list", optionGroup.get("list"));
//
//        String menuNoo = request.getParameter("menuNo");
//
//        int menuNo = Integer.parseInt(menuNoo);
//
//        Menu menu = menuService.getMenu(menuNo);
//
//        //Model - View 연결
//        modelAndView.addObject("menu", menu);
//        modelAndView.addObject("menuNo", menuNo);
//        modelAndView.setViewName("/views/menu/updateMenuView.jsp");
//
//        System.out.println("request = " + request + ", modelAndView = " + modelAndView);
//
//        return modelAndView;
        System.out.println("search = " + search + ", menuNo = " + menuNo + ", model = " + model + ", request = " + request + ", response = " + response);

        return "forward:/views/menu/updateMenuView.jsp";
    }

    //@Transactional(rollbackFor = Exception.class)//menu만 update 방지
    @RequestMapping(value="updateMenuOptionGroup", method=RequestMethod.POST)
    public String updateMenuOptionGroup(HttpServletRequest request,@ModelAttribute("optionGroup")OptionGroup optionGroup, @ModelAttribute("menu") Menu menu, Model model) throws Exception{
        System.out.println("/menu/updateMenuOptionGroup : POST");

        System.out.println("request = " + request + ", optionGroup = " + optionGroup + ", menu = " + menu + ", model = " + model);

//        int menuNo = menu.getMenuNo();

        menuService.updateMenu(menu);

//        optionGroup.setMenuNo(menuNo);

        Menu menu1 = new Menu();

        System.out.println("/////////////////");

        System.out.println("optionGroupName : " + optionGroup.getOptionGroupName());
        System.out.println("optionName : " + optionGroup.getOptionName());
//        System.out.println("optionPrice : " + optionGroup.getOptionPrice());
        System.out.println("optionPrice : " + request.getParameterValues("optionPrice")[0]);
        System.out.println("///////////////////optionNo : " + optionGroup.getOptionNo());

        String[] optionGroupName = optionGroup.getOptionGroupName().split(",");
        String [] optionName = optionGroup.getOptionName().split(",");
        String [] optionPrice = optionGroup.getOptionPrice().split(",");
        String [] optionNo = optionGroup.getOptionNo().split(",");

        System.out.println("optionGroupName length: " + optionGroupName.length);
        System.out.println("optionName length: " + optionName.length);
        System.out.println("optionPrice length: " + optionPrice.length);
        System.out.println("optionNo length : " + optionNo.length);

        List<OptionGroup> optionGroupList = new ArrayList<OptionGroup>();

        //int optGroupNo = menuService.getLatestOptionGroupNo().getOptionGroupNo()+1;
        //System.out.println("optGroupNo : " + optGroupNo);

        /////
        for(int i = 0; i<optionName.length; i++){
            OptionGroup optionGroup1 = menuService.getOption(Integer.parseInt(optionNo[i]));

            optionGroup1.setOptionGroupName(optionGroupName[i]);
            optionGroup1.setOptionName(optionName[i]);
            optionGroup1.setOptionPrice(optionPrice[i]);

            optionGroupList.add(optionGroup1);

            menuService.updateOptionGroup(optionGroup1);

        }


        model.addAttribute("menu", menu1);
        model.addAttribute("optionGroupList", optionGroupList);
//        model.addAttribute("menuNo", menuNo);

        System.out.println("model 확인 : " + model);



        return "redirect:/menu/getMenu?menuNo="+menu.getMenuNo();

    }

    //@Transactional(rollbackFor = Exception.class)//menu만 update 방지
    @RequestMapping(value="updateMenu", method=RequestMethod.POST)
    public String updateMenu(HttpServletRequest request, @ModelAttribute("menu") Menu menu, Model model) throws Exception{
        System.out.println("/menu/updateMenu : POST");

        System.out.println("request = " + request + ", menu = " + menu + ", model = " + model);

//        int menuNo = menu.getMenuNo();

        menuService.updateMenu(menu);

//        optionGroup.setMenuNo(menuNo);

        model.addAttribute("menu", menu);
//        model.addAttribute("menuNo", menuNo);

        System.out.println("model 확인 : " + model);



        return "redirect:/menu/getMenu?menuNo="+menu.getMenuNo();

    }

    @RequestMapping("getMenuList")
    public ModelAndView getMenuList(@ModelAttribute("search") Search search, @RequestParam("truckId") String truckId,
                                  HttpServletRequest request, ModelAndView modelAndView) throws Exception{

        search.setPageSize(pageSize);
        Truck truck  = truckService.getTruck(truckId);

        Map<String , Object> map= menuService.getMenuList(search, truck.getTruckId());

        modelAndView.addObject("list", map.get("list"));
        modelAndView.setViewName("/views/menu/getTruck.jsp");

        return modelAndView;
    }

    @RequestMapping(value="deleteMenu", method=RequestMethod.POST)
    public ModelAndView deleteMenu(HttpServletRequest request, ModelAndView modelAndView) throws Exception{

        System.out.println("/menu/deleteMenu : GET");

        //Business Logic

        String menuNoo = request.getParameter("menuNo");

        int menuNo = Integer.parseInt(menuNoo);

        Menu menu = menuService.getMenu(menuNo);

        menuService.deleteMenu(menu);

        //Model - View 연결
        modelAndView.addObject("menu", menu);
        modelAndView.setViewName("/views/menu/updateMenuView.jsp"); // 진석님과 메뉴 수정 어디서 할 지 상의해보고

        System.out.println("request = " + request + ", modelAndView = " + modelAndView);

        return modelAndView;
    }



}
