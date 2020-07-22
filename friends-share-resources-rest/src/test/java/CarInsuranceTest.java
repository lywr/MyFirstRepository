//import com.alibaba.fastjson.JSONObject;
//import com.zhidao.oper.car.butler.CarButlerApplication;
//import com.zhidao.oper.car.butler.client.AssetClient;
//import com.zhidao.oper.car.butler.client.BigDataClient;
//import com.zhidao.oper.car.butler.dos.TestResultDO;
//import com.zhidao.oper.car.butler.dto.AssetWarrantyReqDto;
//import com.zhidao.oper.car.butler.dto.AssetWarrantyResDto;
//import com.zhidao.oper.car.butler.dto.DriveReportDTO;
//import com.zhidao.oper.car.butler.dto.MyOilDto;
//import com.zhidao.oper.car.butler.entity.AssetsResponse;
//import com.zhidao.oper.car.butler.entity.CarInsurance;
//import com.zhidao.oper.car.butler.entity.TestResult;
//import com.zhidao.oper.car.butler.mapper.RankListMapper;
//import com.zhidao.oper.car.butler.mapper.TestResultMapper;
//import com.zhidao.oper.car.butler.service.CarButlerService;
//import com.zhidao.oper.car.butler.service.insurance.CarInsuranceService;
//import io.swagger.annotations.ApiModelProperty;
//import org.junit.Test;
//import org.junit.runner.RunWith;
//import org.springframework.beans.factory.annotation.Autowired;
//import org.springframework.boot.test.context.SpringBootTest;
//import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
//
//import java.util.Date;
//
///**
// * @Author：ly
// * @Date：2019/4/12 3:28 PM
// */
//@SpringBootTest(classes = CarButlerApplication.class)
//@RunWith(SpringJUnit4ClassRunner.class)
//public class CarInsuranceTest {
//    @Autowired
//    private CarInsuranceService carInsuranceService;
//    @Autowired
//    private AssetClient assetClient;
//    @Autowired
//    private BigDataClient bigDataClient;
//    @Autowired
//    private RankListMapper rankListMapper;
//    @Autowired
//    private CarButlerService carButlerService;
//    @Autowired
//    private TestResultMapper testResultMapper;
//
//    @Test
//    public void test01(){
//        carInsuranceService.addInsuranceExtTime();
//    }
//    @Test
//    public void test02(){
//        String warranty1 = carInsuranceService.getMetadataBykey("warrantyEquity");
//        System.out.println(warranty1+"###");
//    }
////    @Test
////    public void test03(){
////        carInsuranceService.getUserMessage();
////    }
//    @Test
//    public void test04(){
//        AssetWarrantyResDto insuranceList = carInsuranceService.getInsuranceList(591306757009l);
//        System.out.println(JSONObject.toJSON(insuranceList)+"###");
//    }
//
//    @Test
//    public void test05(){
//        carInsuranceService.insertInsuranceFlow(new CarInsurance());
//    }
//    @Test
//    public void test06(){
//        AssetsResponse carInsurance = assetClient.getCarInsurance("oper", "s1");
//        System.out.println(carInsurance);
//    }
//    @Test
//    public void test07(){
//        AssetWarrantyReqDto assetWarrantyReqDto=new AssetWarrantyReqDto();
//        assetWarrantyReqDto.setUserId("string");
//        assetWarrantyReqDto.setSn("string");
//        assetWarrantyReqDto.setWarrantyExtension(0l);
//        assetWarrantyReqDto.setWarrantyExtEnd(0l);
//        assetWarrantyReqDto.setWarrantyExtStart(0l);
//        AssetsResponse oper = assetClient.addInsuranceExtTime("oper", assetWarrantyReqDto);
//        System.out.println(JSONObject.toJSON(oper)+"####");
//    }
//    @Test
//    public void test08(){
//        DriveReportDTO driveInfo = bigDataClient.getDriveInfo("XTCAA814203000291541320895936");
//        System.out.println(JSONObject.toJSON(driveInfo));
//    }
//    @Test
//    public void test09(){
//        Integer integer = rankListMapper.selectOrderBySn("12");
//        System.out.println(integer);
//    }
//    @Test
//    public void test10(){
//        MyOilDto ze802C1915P00012 = carButlerService.getMyOilDate(584787614801L, "ZE802C1915P00012", null);
//        System.out.println(JSONObject.toJSON(ze802C1915P00012));
//    }
//    @Test
//    public void test11(){
//        TestResultDO testResult=new TestResultDO();
//        testResult.setUserId(11L);
//        testResult.setDriveScore("10");
//        testResult.setSurplusOid("11");
//        testResult.setBatteryVoltage("11");
//        testResult.setSurplusOid("11");
//        testResult.setFaultCodes("11");
//        testResult.setCreateTime(new Date());
//        testResult.setDeleteFlag(1L);
//        testResult.setPathId("111");
//        testResult.setPathUpdateTime(1L);
//        testResult.setTestScore(10);
//        testResult.setSurplusOidPercent("11");
//        testResult.setSn("11");
//        testResult.setWaterTankTemperature(1);
//        testResult.setUpdateTime(new Date());
//        int i = testResultMapper.insertSelective(testResult);
//        System.out.println(testResult);
//    }
//    @Test
//    public void test12(){
//        System.out.println("开始任务");
//        carButlerService.test();
//        System.out.println("结束任务");
//    }
//
//}
