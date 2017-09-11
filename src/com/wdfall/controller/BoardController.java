package com.wdfall.controller;


import java.util.List;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.util.UrlPathHelper;

import com.wdfall.dto.BoardDto;
import com.wdfall.service.BoardService;

@Controller
public class BoardController {

	@Autowired
	private BoardService boardService;
	
	/**글목록페이지로 이동
	 * @return jsp경로
	 */
	@RequestMapping("/list")
	public String list() {
		return "/WEB-INF/page/list";
	}
	/**boardList 조회
	 * @param pg 페이지번호
	 * @return boardList JSON
	 */
	@RequestMapping("/loadList")
	public @ResponseBody List<BoardDto> loadList(@RequestParam(value="pg",defaultValue="1") int pg) {
		List<BoardDto> boardList = boardService.list(pg);
		return boardList;
	}
	/**글작성페이지로 이동
	 * @return jsp경로
	 */
	@RequestMapping("/write")
	public String write() {
		return "/WEB-INF/page/write";
	}
	/**작성된 글 저장
	 * @param boardDto 작성된글 내용
	 * @return jsp경로
	 */
	@RequestMapping("/writeSave")
	public String writeSave(BoardDto boardDto) {
		boardService.write(boardDto);
		return "/WEB-INF/page/list";
	}
	/**수정 페이지로이동
	 * 글번호가 숫자값이 아니라면 list로이동
	 * @param seq 글번호
	 * @return 해당글번호,jsp경로
	 */
	@RequestMapping("/modify/{boardSeq}")
	public ModelAndView modify(@PathVariable String boardSeq) {
		ModelAndView mav = new ModelAndView();
		if(isNum(boardSeq)) {
			mav.addObject("boardSeq", boardSeq);
			mav.setViewName("/WEB-INF/page/modify");
		} else {
			mav.addObject("isNum", "fail");
			mav.setViewName("/WEB-INF/page/list");
		}
		return mav;
	}
	/**수정 된 글 저장
	 * @param boardDto 작성된글 내용
	 * @return String jsp경로
	 */
	@RequestMapping("/modifySave")
	public String modifySave(BoardDto boardDto) {
		boardService.modify(boardDto);
		return "redirect:/view/"+boardDto.getBoardSeq();
	}
	/**해당 글번호 조회
	 * @param seq 글번호
	 * @return ModelAndView 해당글번호,jsp경로
	 */
	@RequestMapping("/view/{boardSeq}")
	public ModelAndView view(@PathVariable String boardSeq) {
		ModelAndView mav = new ModelAndView();
		if(isNum(boardSeq)) {
			mav.addObject("boardSeq", boardSeq);
			mav.setViewName("/WEB-INF/page/view");
			return mav;
		} else {
			mav.addObject("isNum", "fail");
			mav.setViewName("/WEB-INF/page/list");
			return mav;
		}
	}
	/**해당글 조회
	 * @param boardSeq 글번호
	 * @return board JSON
	 */
	@RequestMapping("/loadArticle")
	@ResponseBody
	public BoardDto loadArticle(String boardSeq) {
		BoardDto boardDto = boardService.view(boardSeq);
		
		return boardDto;
	}
	/**해당 글번호 삭제
	 * @param seq 글번호
	 * @return jsp경로
	 */
	@RequestMapping(value="/delete/{boardSeq}")
	public String delete(@PathVariable String boardSeq) {
		
		boardService.delete(boardSeq);
		return "redirect:/list";
	}
	public static boolean isNum(String tmp) {
		  try {
		      Integer.parseInt(tmp);
		      return true;
		  } catch(NumberFormatException e) {
		      return false;
		  }
	}
}
