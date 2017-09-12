package com.wdfall.controller;


import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.wdfall.dto.BoardDto;
import com.wdfall.dto.MemberDto;
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
	@ResponseBody
	public List<BoardDto> loadList(@RequestParam(value="page",defaultValue="1") int page) {
		List<BoardDto> boardList = boardService.list(page);
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
	public String writeSave(BoardDto boardDto,@RequestParam(value="secret",defaultValue="0") String secret) {
		boardDto.setSecret(secret);
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
	@RequestMapping(value="/delete/ {boardSeq}",method=RequestMethod.DELETE)
	@ResponseBody
	public Map<String, String> delete(@PathVariable String boardSeq, HttpSession session) {
		Map<String, String> map = new HashMap<String,String>();
//		String writerId = boardService.view(boardSeq).getId();
		MemberDto memberDto = (MemberDto) session.getAttribute("memberInfo");
		if(memberDto!=null) {
			boardService.delete(boardSeq);
			map.put("isDelete", "success");
		} else {
			map.put("isDelete", "fail");
		}
		return map;
	}
	@RequestMapping(value="/recommend")
	@ResponseBody
	public Map<String,String> recommend(BoardDto boardDto) {
		Map<String,String> map = new HashMap<String,String>();
		int isRecommend = boardService.recommend(boardDto);
		if(isRecommend==1) {
			map.put("isRecommend", "success");
		} else {
			map.put("isRecommend", "fail");
		}
		return map;
	}
	public static boolean isNum(String tmp) {
		  try {
		      Integer.parseInt(tmp);
		      return true;
		  } catch(NumberFormatException e) {
		      return false;
		  }
	}
	  @RequestMapping(value = "/upload", method = RequestMethod.POST)
	    public void communityImageUpload(HttpServletRequest request, HttpServletResponse response, @RequestParam MultipartFile upload) {
		  
	        OutputStream out = null;
	        PrintWriter printWriter = null;
	        response.setCharacterEncoding("utf-8");
	        response.setContentType("text/html;charset=utf-8");
	 
	        try{
	 
	            String fileName = upload.getOriginalFilename();
	            String realPath = request.getServletContext().getRealPath("/ckeditor");
	            byte[] bytes = upload.getBytes();
	            String uploadPath =  realPath + File.separator + "/plugins/image/images/" +  fileName;//저장경로
	 
	            out = new FileOutputStream(new File(uploadPath));
	            out.write(bytes);
	            String callback = request.getParameter("CKEditorFuncNum");
	 
	            printWriter = response.getWriter();
	            String fileUrl = request.getContextPath()+"/ckeditor/plugins/image/images/" + fileName;//url경로
	 
	            printWriter.println("<script type='text/javascript'>window.parent.CKEDITOR.tools.callFunction("
	                    + callback
	                    + ",'"
	                    + fileUrl
	                    + "','이미지를 업로드 하였습니다.'"
	                    + ")</script>");
	            printWriter.flush();
	 
	        }catch(IOException e){
	            e.printStackTrace();
	        } finally {
	            try {
	                if (out != null) {
	                    out.close();
	                }
	                if (printWriter != null) {
	                    printWriter.close();
	                }
	            } catch (IOException e) {
	                e.printStackTrace();
	            }
	        }
	 
	        return;
	    }
}
