//package com.ctfo.soft.pipeline.globalexception;
//
//import com.zhidao.commons.support.globalexception.GlobalExceptionHandler;
//import com.zhidao.commons.support.response.RestResult;
//import lombok.extern.slf4j.Slf4j;
//import org.springframework.http.HttpStatus;
//import org.springframework.web.bind.annotation.ControllerAdvice;
//import org.springframework.web.bind.annotation.ExceptionHandler;
//import org.springframework.web.bind.annotation.ResponseBody;
//import org.springframework.web.bind.annotation.ResponseStatus;
//import javax.servlet.http.HttpServletRequest;
//import javax.servlet.http.HttpServletResponse;
//
//@Slf4j
//@ControllerAdvice
//public class CarButlerGlobalExceptionHandler extends GlobalExceptionHandler {
//
//    /**
//     * 处理业务异常，返回业务异常的错误信息
//     *返回业务异常的错误信息
//     * @param request
//     * @param ex
//     * @return
//     */
//    @ExceptionHandler(CarButlerException.class)
//    @ResponseStatus(HttpStatus.OK)
//    @ResponseBody
//    public RestResult handleBusinessException(HttpServletRequest request, HttpServletResponse response, CarButlerException ex) {
//        log.error("CarButlerException [path={}][code={}][msg={}]", request.getRequestURI(), ex.getCode(),
//                ex.getMessage());
//        return RestResult.failure(ex.getCode(),ex.getMessage());
//    }
//
//    @ExceptionHandler(Exception.class)
//    @ResponseStatus()
//    @ResponseBody
//    public RestResult
//
//}