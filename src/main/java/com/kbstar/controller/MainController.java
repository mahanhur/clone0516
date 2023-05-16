package com.kbstar.controller;

import com.kbstar.dto.Cust;
import com.kbstar.dto.Item;
import com.kbstar.service.CustService;
import com.kbstar.service.ItemService;
import lombok.extern.slf4j.Slf4j;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpSession;
import java.util.List;

@Slf4j
@Controller
public class MainController {

    @Autowired
    CustService custService;
    @Autowired
    ItemService itemService;
    @Autowired
    private BCryptPasswordEncoder encoder;


    @RequestMapping("/")
    public String main(Model model) throws Exception {
        List<Item> list = null;
        list = itemService.get();
        log.info(list.toString());
        model.addAttribute("allitem",list);
        return "index";
    }

    @RequestMapping("/login")
    public String login(Model model){
        model.addAttribute("center","login");
        return "index";
    }

    @RequestMapping("/logout")
    public String logout(Model model, HttpSession session){
        if(session != null){
            session.invalidate();
        }
        return "index";
    }

    @RequestMapping("/loginimpl")
    public String loginimpl(Model model, String id, String pwd, HttpSession session) throws Exception {
        log.info("----------------" + id + pwd);
        Cust cust = null;
        String nextPage = "loginfail";
        try {
            cust = custService.get(id);
            if (cust != null && encoder.matches(pwd, cust.getPwd())) {
                nextPage = "loginok";
                session.setMaxInactiveInterval(100000);
                session.setAttribute("logincust", cust);
            }
        } catch (Exception e) {
            throw new Exception("시스템 장애 잠시후 다시 로그인 하세요");
        }

        model.addAttribute("center", nextPage);
        return "index";
    }

    @RequestMapping("/register")
    public String register(Model model){
        model.addAttribute("center","register");

        return "index";
    }
    @RequestMapping("/registerimpl")
    public String registerimpl(Model model, Cust cust, HttpSession session) throws Exception {

        try {
            cust.setPwd(encoder.encode(cust.getPwd()));
            custService.register(cust);
            // 회원가입 즉시 로그인처리 로그인된 화면 보여주기..
            session.setAttribute("logincust", cust);

        } catch (Exception e) {
            throw new Exception("가입 오류");
        }

        model.addAttribute("rcust", cust);
        model.addAttribute("center", "registerok");
        return "index";
    }
    @RequestMapping("/custinfo")
    public String custinfo(Model model, String id, Cust cust) throws Exception {

            cust = custService.get(id);
            log.info(String.valueOf(cust));

        model.addAttribute("custinfo", cust);
        model.addAttribute("center", "custinfo");
        return "index";
    }

    @RequestMapping("/custinfoimpl")
    public String custinfoimpl(Model model, Cust cust) throws Exception {

        try {
            cust.setPwd(encoder.encode(cust.getPwd()));
            custService.modify(cust);
        } catch (Exception e) {
            throw new Exception("시스템장애");
        }
        return "redirect:/custinfo?id=" + cust.getId();
    }

    @RequestMapping("/cart")
    public String cart(Model model){
        model.addAttribute("center","cart");
        return "index";
    }


}
