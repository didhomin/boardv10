package com.wdfall.controller;


import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.wdfall.dto.MemberDto;
import com.wdfall.service.MemberService;

@Controller
public class MemberController {

	@Autowired
	private MemberService memberService;

	
	/**POST방식일 경우
	 * 입력받은 정보가 DB에 있는지확인 후 
	 * 있으면 세션에 저장 후 id return 
	 * 없으면 fail return
	 * @param MemberDto 아이디,비밀번호
	 * @return id와 로그인성공 유무
	 */
	@RequestMapping(value="/login",method=RequestMethod.POST)
	@ResponseBody
	public Map<String, String> login(MemberDto memberDto,HttpSession session) {
		memberDto = memberService.login(memberDto);
		Map<String,String> map = new HashMap<String, String>();
		if (memberDto != null) {
			session.setAttribute("memberInfo",memberDto);
			map.put("isLogin", "success");
			map.put("id", memberDto.getId());
			return map;
			
		} else {
			map.put("isLogin", "fail");
			return map;
		}
	}
	/**GET방식일 경우
	 * 세션에 로그인정보 삭제
	 */
	@RequestMapping(value="/logout",method=RequestMethod.GET)
	@ResponseBody
	public Map<String, String> logout(HttpSession session) {
		session.removeAttribute("memberInfo");
		Map<String,String> map = new HashMap<String, String>();
		map.put("Logout", "success");
		return map;
	}
	/**이전페이지 정보를가지고
	 * 로그인페이지로이동
	 */
	@RequestMapping("/loginForm")
	public ModelAndView loginForm(@RequestParam String uri) {
		ModelAndView mav = new ModelAndView();
		mav.addObject("uri", uri);
		mav.setViewName("/WEB-INF/page/login");
		return mav;
	}
}
