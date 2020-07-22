package com.friends.share.resources;

import lombok.extern.slf4j.Slf4j;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
@Slf4j
@SpringBootApplication(scanBasePackages={"com.friends.share"})
public class FriendShareApplication {

    public static void main(String[] args) {
        SpringApplication.run(FriendShareApplication.class, args);
        log.info("-------------------------------------");
        log.info("start success");
        log.info("-------------------------------------");
    }
}
