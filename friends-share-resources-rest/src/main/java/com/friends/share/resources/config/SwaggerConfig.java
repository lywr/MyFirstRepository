//package com.ctfo.soft.pipeline.config;
//
//import org.springframework.context.annotation.Bean;
//import org.springframework.context.annotation.Configuration;
//
//import springfox.documentation.builders.ApiInfoBuilder;
//import springfox.documentation.builders.PathSelectors;
//import springfox.documentation.builders.RequestHandlerSelectors;
//import springfox.documentation.service.ApiInfo;
//import springfox.documentation.service.Contact;
//import springfox.documentation.spi.DocumentationType;
//import springfox.documentation.spring.web.plugins.Docket;
//import springfox.documentation.swagger2.annotations.EnableSwagger2;
//
//@Configuration
//@EnableSwagger2
//public class SwaggerConfig {
//
//    private static final String BASE_PACKAGE = "com.zhidao.oper.car.butler";
//
//    @Bean
//    public Docket api() {
//        final Docket docket =
//                new Docket(DocumentationType.SWAGGER_2)
//                        .select()
//                        .apis(RequestHandlerSelectors.basePackage(BASE_PACKAGE))
//                        .paths(PathSelectors.ant("/**"))
//                        .build()
//                        //.globalOperationParameters(pars)
//                        .apiInfo(apiInfo());
//        return docket;
//    }
//
//    private ApiInfo apiInfo() {
//
//        return new ApiInfoBuilder()
//                .title("智道-车管家")
//                .description("智道-车管家-内部接口调用")
//                .termsOfServiceUrl("http://www.zhidaoii.com/")
//                .contact(new Contact("zhidao", "http://www.zhidaoii.com/", ""))
//                .version("1.0")
//                .build();
//
//    }
//}
