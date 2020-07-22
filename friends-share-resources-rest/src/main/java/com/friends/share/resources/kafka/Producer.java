//package com.ctfo.soft.pipeline.kafka;
//
//import com.alibaba.fastjson.JSONObject;
//import com.google.gson.Gson;
//import com.google.gson.GsonBuilder;
//import lombok.extern.slf4j.Slf4j;
//import org.springframework.beans.factory.annotation.Autowired;
//import org.springframework.kafka.core.KafkaTemplate;
//import org.springframework.stereotype.Component;
//
//import java.util.Date;
//
//@Component
//@Slf4j
//public class Producer {
//
//    @Autowired
//    private KafkaTemplate kafkaTemplate1;
////    private static final String TPOIC = "CAR_BUTLER";
//    private static final String TPOIC = "TOPIC-DRIVE-REPORT";
//
//    private static Gson gson = new GsonBuilder().create();
//
//    //发送消息方法
//    public void send(String text) {
//        Message message = new Message();
//        message.setId("KFK_" + System.currentTimeMillis());
//        message.setMsg(text);
//        message.setSendTime(new Date().toString());
//        log.info("msg is: {}", JSONObject.toJSONString(message));
//        kafkaTemplate1.send(TPOIC, gson.toJson(message));
//    }
//
//}
