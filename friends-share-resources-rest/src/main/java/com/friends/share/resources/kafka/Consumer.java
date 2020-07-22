//package com.ctfo.soft.pipeline.kafka;
//
//import com.alibaba.fastjson.JSON;
//import com.zhidao.oper.car.butler.dto.DriveReportMsg;
//import com.zhidao.oper.car.butler.dto.DriverReport;
//import com.zhidao.oper.car.butler.service.CarButlerService;
//import com.zhidao.oper.car.butler.service.DriverInfoService;
//import lombok.extern.slf4j.Slf4j;
//import org.apache.commons.lang.exception.ExceptionUtils;
//import org.apache.kafka.clients.consumer.ConsumerRecord;
//import org.springframework.beans.factory.annotation.Autowired;
//import org.springframework.kafka.annotation.KafkaListener;
//import org.springframework.kafka.support.Acknowledgment;
//import org.springframework.stereotype.Component;
//import java.util.Objects;
//import java.util.Optional;
//
//@Slf4j
//@Component
//public class Consumer {
//
//    @Autowired
//    CarButlerService carButlerService;
//    @Autowired
//    private DriverInfoService driverInfoService;
//
//    private static final String TPOIC = "CAR_BUTLER";
//    private static final String TPOIC2 = "TOPIC-DRIVE-REPORT";
//
//    @KafkaListener(topics = {TPOIC},containerFactory = "kafkaListener1")
//    public void listen1(ConsumerRecord<?, DriveReportMsg> record/**, Acknowledgment ack*/) {
//        Optional<?> kafkaMessage = Optional.ofNullable(record.value());
//        log.info("[listen1] receive record: {} ", record.value());
//        if (kafkaMessage.isPresent()) {
//            try {
//                Object message = kafkaMessage.get();
//                log.info("[listen1] message: {} ", message.toString());
//                DriveReportMsg driveReportMsg = JSON.parseObject(message.toString(), DriveReportMsg.class);
//                if (Objects.nonNull(driveReportMsg)) {
//                    carButlerService.udpateExaminData(driveReportMsg);
//                }
//            } catch (Exception ex) {
//                log.error("[listen1] 转换 fail: {}", ExceptionUtils.getStackTrace(ex));
//            }
////            finally {
////                ack.acknowledge();
////            }
//        }
//    }
//
//    @KafkaListener(topics = {TPOIC2},containerFactory = "kafkaListener2")
//    public void listen2(ConsumerRecord<?, DriverReport> record) {
//        log.info("[listen2] receive record: {} ", record.value());
//        Optional<?> kafkaMessage = Optional.ofNullable(record.value());
//        if (kafkaMessage.isPresent()) {
//            try {
//                Object message = kafkaMessage.get();
//                log.info("[listen2] message: {} ", message.toString());
//                DriverReport userReportMsg = JSON.parseObject(message.toString(), DriverReport.class);
//                if (Objects.nonNull(userReportMsg)) {
//                    driverInfoService.addDriverInfo(userReportMsg);
//                }
//            } catch (Exception ex) {
//                log.error("[listen2] 转换 fail: {}", ExceptionUtils.getStackTrace(ex));
//            }
//        }
//    }
//
//
//}
