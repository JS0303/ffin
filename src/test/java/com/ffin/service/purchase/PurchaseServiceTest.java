package com.ffin.service.purchase;

import com.ffin.common.Search;
import com.ffin.service.domain.*;
import com.ffin.service.user.UserService;
import org.junit.Assert;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.util.AbstractList;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {
        "classpath:config/context-auth.xml",
        "classpath:config/context-common.xml",
        "classpath:config/context-aspect.xml",
        "classpath:config/context-mybatis.xml",
        "classpath:config/context-transaction.xml" })
public class PurchaseServiceTest {

    @Autowired
    @Qualifier("purchaseServiceImpl")
    private PurchaseService purchaseService;


    /////////////////////////GET////////////////////////////////
    //@Test
    public void TestGetPurchase() throws Exception {

        Purchase purchase = new Purchase();

        purchase = purchaseService.getPurchase(1);

        Assert.assertEquals(1, purchase.getOrderNo());
        Assert.assertEquals("user01", purchase.getOrderUserId().getUserId());
        Assert.assertEquals("truck01", purchase.getOrderTruckId().getTruckId());
        Assert.assertEquals("주문요청사항", purchase.getOrderRequest());
        Assert.assertEquals(4, purchase.getOrderStatus());
        Assert.assertEquals(15, purchase.getOrderPickUpTime());
        Assert.assertEquals(10, purchase.getOrderCookingTime());


    }

    //@Test
    public void TestGetCoupon() throws Exception {
        int couponNo = 1;

        Coupon coupon = new Coupon();

        coupon = purchaseService.getCoupon(couponNo);

        Assert.assertEquals(1000, coupon.getCouponDcPrice());

    }

    //@Test
    public void TestGetTotalPoint() throws Exception {

        User user = new User();

        user = purchaseService.getTotalPoint("user01");

        Assert.assertEquals(0, user.getUserTotalPoint());

    }

    //@Test
    public void TestGetLastOrderNo() throws Exception {



        int orderNo = purchaseService.getLastOrderNo("truck01");

        System.out.println("orderNo ddd"+orderNo);
    }

    @Test
    public void TestGetTruckBusiStatus() throws Exception {



        Truck truck = purchaseService.getTruckBusiStatus("truck01");

        System.out.println("orderNo ddd"+truck.getTruckId());
    }




///////////////////////List/////////////////////////////////
    //@Test
    public void TestGetCouponList() throws Exception {

        User user = new User();
        Coupon coupon = new Coupon();
        user.setUserId("user01");
        coupon.setCouponReceivedUserId(user);
        Map map = purchaseService.getCouponList(coupon);
        System.out.println(map);


    }

    //@Test
    public void TestGetCartList() throws Exception {
        Map map = purchaseService.getCartList(1);
        System.out.println(map);

    }

    //@Test
    public void TestGetOrderList() throws Exception {
        Search search = new Search();
        search.setSearchCondition("1");
        search.setCurrentPage(1);
        search.setPageSize(3);
        System.out.println("search : " + search);




        Map map = purchaseService.getOrderList(search,"truck01");
        System.out.println(map);

    }






    //@Test
    public void TestGetPointList() throws Exception {
        Search search = new Search();
        search.setCurrentPage(1);
        search.setPageSize(3);
        Map map = purchaseService.getPointList(search,"user01");
        System.out.println(map);

    }

    //@Test
    public void TestGetPurchaseList() throws Exception {
        Search search = new Search();
        search.setCurrentPage(1);
        search.setPageSize(3);
        Map map = purchaseService.getPurchaseList(search,"user01");
        System.out.println(map);

    }


    //@Test
    public void TestGetSalesList() throws Exception {
        Search search = new Search();
        search.setCurrentPage(1);
        search.setPageSize(3);
        Map map = purchaseService.getSalesList(search,"truck01");
        System.out.println(map);

    }

    //@Test
    public void TestGetOrderDetail() throws Exception {

        Map map = purchaseService.getOrderDetail(1);
        System.out.println(map.get("list"));

    }


    //@Test
    public void TestGetUsePoint() throws Exception {

        int pointAmt = purchaseService.getUsePoint(39);
        System.out.println(pointAmt);

    }


 /*   //@Test
    public void TestGetMainUser() throws Exception {

        Purchase purchase = purchaseService.getMainOrderUser("user01");
        System.out.println(purchase);

    }*/




////////////////////ADD///////////////////////////////////

   //@Test
    public void testAddPurchase() throws Exception {

        Purchase purchase = new Purchase();
        User user = new User();
        user.setUserId("user03");
        Truck truck = new Truck();
        truck.setTruckId("truck03");
        purchase.setOrderUserId(user);
        purchase.setOrderTruckId(truck);
        purchase.setOrderQty(3);
        purchase.setOrderStatus(0);
        purchase.setOrderPickUpTime(15);
        purchase.setOrderTotalPrice(3000);

        int orderNo = purchaseService.addPurchase(purchase);

       System.out.println("받아온정보!!!!"+orderNo);


    }


    //@Test
    public void testAddOrderDetail() throws Exception {

        OrderDetail orderDetail = new OrderDetail();
/*        Purchase purchase = new Purchase();
        purchase.setOrderNo(8);*/
        Purchase purchase = new Purchase();
        purchase.setOrderNo(8);
        orderDetail.setOdOrderNo(purchase);
        orderDetail.setOdMenuImage("imag5-1");
        orderDetail.setOdMenuName("menu10");
        orderDetail.setOdMenuPrice(1000);
        orderDetail.setOdMenuQty(3);
        orderDetail.setOdMenuQtyFlag(1);
        orderDetail.setOdOptionGroupName("null");
        orderDetail.setOdOptionName("null");
        orderDetail.setOdOptionPrice(0);


        OrderDetail orderDetail1 = new OrderDetail();
        orderDetail1.setOdOrderNo(purchase);
        orderDetail1.setOdMenuImage("imag5-1");
        orderDetail1.setOdMenuName("menu10");
        orderDetail1.setOdMenuPrice(2000);
        orderDetail1.setOdMenuQty(4);
        orderDetail1.setOdMenuQtyFlag(0);
        orderDetail1.setOdOptionGroupName("ogption1");
        orderDetail1.setOdOptionName("option1");
        orderDetail1.setOdOptionPrice(1000);

        OrderDetail orderDetail2 = new OrderDetail();
        orderDetail2.setOdOrderNo(purchase);
        orderDetail2.setOdMenuImage("imag5-1");
        orderDetail2.setOdMenuName("menu10");
        orderDetail2.setOdMenuPrice(2000);
        orderDetail2.setOdMenuQty(3);
        orderDetail2.setOdMenuQtyFlag(0);
        orderDetail2.setOdOptionGroupName("ogption2");
        orderDetail2.setOdOptionName("option1");
        orderDetail2.setOdOptionPrice(1000);

        List list = new ArrayList();
        list.add(orderDetail);
        list.add(orderDetail1);
        list.add(orderDetail2);

        purchaseService.addCart(list);



    }

    //@Test
    public void testAddCoupon() throws Exception {
        User user = new User();
        user.setUserId("user01");
       Coupon coupon = new Coupon();
       coupon.setCouponReceivedUserId(user);
        coupon.setCouponDcPrice(1000);
        coupon.setCouponType(3);
        coupon.setCouponStatus(0);
        purchaseService.addCoupon(coupon);
    }


    //@Test
    public void testUpdatePoint() throws Exception {
        User user = new User();
        user.setUserId("user01");
        Point point = new Point();
        point.setPointAmt(50);
        point.setPointBirthCode(2);
        point.setPointStatus(0);
        point.setPointUserId(user);
        point.setPointPlmnStatus(0);
        int pointNo = purchaseService.updatePoint(point);
        System.out.println("pointNo"+pointNo);
    }

///////////////////Update////////////////////////////

    //@Test
    public void testUpdatePurchase() throws Exception {
        int payPointNo;
        Purchase purchase = new Purchase();
        Coupon coupon = new Coupon();
        coupon.setCouponNo(0);

        Point point = new Point();
        point.setPointNo(3);

        Catering catering = new Catering();
        catering.setCtNo(0);

        purchase.setOrderStatus(1);
        purchase.setPayOption(1);
        purchase.setPayPrice(3000);
        purchase.setPayServiceType(0);
       purchase.setPayPointNo(point);
       /*  purchase.setPayCouponNo(coupon);
        purchase.setPayResNo(catering);*/

        purchase.setOrderNo(566);


        purchaseService.updatePurchase(purchase);


        Assert.assertEquals(1, purchase.getOrderStatus());
        Assert.assertEquals(1, purchase.getPayOption());
        Assert.assertEquals(3000, purchase.getPayPrice());
        Assert.assertEquals(0, purchase.getPayServiceType());
        Assert.assertEquals(10, purchase.getPayPointNo().getPointNo());
        Assert.assertEquals("", purchase.getPayCouponNo().getCouponNo());
        Assert.assertEquals("", purchase.getPayResNo().getCtNo());

    }


    //@Test
    public void testUpdateTotalPoint() throws Exception {


        User userOne = new User();
        userOne = purchaseService.getTotalPoint("user01");
        System.out.println("totalPoint"+userOne.getUserTotalPoint());


        User user = new User();
        user.setUserId("user01");
        user.setUserTotalPoint(userOne.getUserTotalPoint()-1000);
        purchaseService.updateTotalPoint(user);


        User user1 = new User();
        user1 = purchaseService.getTotalPoint("user01");
        Assert.assertEquals(userOne.getUserTotalPoint()-1000, user1.getUserTotalPoint());


    }

    //@Test
    public void testUpdateCouponStatus() throws Exception {

        Coupon couponStart = new Coupon();
        couponStart = purchaseService.getCoupon(2);
        Assert.assertEquals(1,couponStart.getCouponStatus());


        Coupon coupon = new Coupon();
        coupon.setCouponNo(2);
        coupon.setCouponStatus(0);
        purchaseService.updateCouponStatus(coupon);



        Coupon coupon1 = new Coupon();
        coupon1 = purchaseService.getCoupon(2);
        Assert.assertEquals(0, coupon1.getCouponStatus());


    }

    //@Test
    public void testUpdateOrderTranCode() throws Exception {

        Purchase purchaseStart = new Purchase();
        purchaseStart = purchaseService.getPurchase(1);
        Assert.assertEquals(1,purchaseStart.getOrderStatus());

        Purchase update = new Purchase();
        update.setOrderNo(1);
        update.setOrderStatus(2);
        purchaseService.updateOrderTranCode(update);


        Purchase end = new Purchase();
        end = purchaseService.getPurchase(1);
        Assert.assertEquals(2, end.getOrderStatus());

    }

    //@Test
    public void testUpdateCookingTime() throws Exception {

        Purchase purchase = new Purchase();
        purchase = purchaseService.getPurchase(1);
        Assert.assertEquals(2,purchase.getOrderStatus());
        Assert.assertEquals(15,purchase.getOrderCookingTime());


        purchase.setOrderNo(1);
        purchase.setOrderStatus(2);
        purchase.setOrderCookingTime(10);
        purchaseService.updateOrderCookingTime(purchase);


        purchase = purchaseService.getPurchase(1);
        Assert.assertEquals(2, purchase.getOrderStatus());
        Assert.assertEquals(10, purchase.getOrderCookingTime());


    }

    //
    //
    // @Test
    public void testUpdateOrderCancel() throws Exception {

        Purchase purchase = new Purchase();
        purchase = purchaseService.getPurchase(1);

//        Assert.assertEquals(3,purchase.getOrderCancelReason());



        purchase.setPayId("imp_963123803912");
        purchase.setPayRefundStatus(1);
        purchase.setOrderStatus(4);
        purchase.setOrderCancelReason(3);
        purchaseService.updateOrderCancel(purchase);


        purchase = purchaseService.getPurchase(1);
        Assert.assertEquals(4, purchase.getOrderStatus());
        Assert.assertEquals(3, purchase.getOrderCancelReason());


    }
    //@Test
    public void testUpdateOrderRefusal() throws Exception {

        Purchase purchase = new Purchase();
        purchase = purchaseService.getPurchase(1);
        Assert.assertEquals(4,purchase.getOrderStatus());
//        Assert.assertEquals(3,purchase.getOrderCancelReason());


        purchase.setOrderNo(1);
        purchase.setOrderStatus(1);
        purchase.setOrderNopeReason(3);
        purchaseService.updateOrderRefusal(purchase);


        purchase = purchaseService.getPurchase(1);
        Assert.assertEquals(1, purchase.getOrderStatus());
        Assert.assertEquals(3, purchase.getOrderNopeReason());


    }

    //@Test
    public void testUpdateRefundStatus() throws Exception {

        Purchase purchase = new Purchase();
        purchase = purchaseService.getPurchase(1);
        Assert.assertEquals(4,purchase.getOrderStatus());
//        Assert.assertEquals(3,purchase.getOrderCancelReason());


        purchase.setOrderNo(1);
        purchase.setOrderStatus(4);
        purchase.setPayRefundStatus(1);
        purchaseService.updateRefundStatus(purchase);


        purchase = purchaseService.getPurchase(1);
        Assert.assertEquals(4, purchase.getOrderStatus());
        Assert.assertEquals(1, purchase.getPayRefundStatus());

    }

    //@Test
    public void testUpdatBusiStatus() throws Exception {

        Truck truck = new Truck();
        truck.setTruckId("truck01");
        truck.setTruckBusiStatus("2");

        purchaseService.updateBusiStatus(truck);

    }





}