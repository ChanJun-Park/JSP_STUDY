package conovel;

import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/main/*")
public class MainController extends HttpServlet {
	BoardService boardService;
	MemberDAO memberDAO;
	MemberVO memberVO;
	
	public void init(ServletConfig config) throws ServletException {
		System.out.println("MainController 생성자 호출");
		memberDAO = new MemberDAO();
		boardService = new BoardService();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doHandle(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doHandle(request, response);
	}

	private void doHandle(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("MainController 진입\n");
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");
		String action = request.getPathInfo();
		System.out.println("action:" + action);
		
		String nextPage = "";
		if(action == null || action.equals("/listPost.do")) {
			listPostAction(request, response);
			nextPage = "/blog/index.jsp";
		} else if (action.equals("/registerForm.do")) {
			nextPage = "/register/register.jsp";
		} else if (action.equals("/register.do")) {
			boolean registerResult = registerAction(request, response);
			if (registerResult) {
				nextPage = "/main/listPost.do";
			} else {
				nextPage = "/register/register.jsp";
			}
		} else if (action.equals("/admin.do")) {
			adminAction(request, response);
			nextPage = "/admin/admin.jsp";
		} else if (action.equals("/userInfoModForm.do")) { 
			String _id = request.getParameter("user_id");
			MemberVO memInfo = memberDAO.findMember(_id);
			request.setAttribute("memInfo", memInfo);
			nextPage = "/register/user_info_modify.jsp";
		} else if (action.equals("/userInfoMod.do")) {
			userInfoModAction(request, response);
			nextPage = "/main/admin.do";
		} else if (action.equals("/userInfoDel.do")) {
			userInfoDelAction(request, response);
			nextPage = "/main/admin.do";
		}
		
		System.out.println("nextPage:" + nextPage);
		RequestDispatcher dispatch = request.getRequestDispatcher(nextPage);
		dispatch.forward(request, response);
	}
	
	private void listPostAction(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		List<ArticleVO> articlesList = boardService.listArticles();
		request.setAttribute("articlesList", articlesList);
	}
	
	private void userInfoDelAction(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String id = request.getParameter("user_id");
		memberDAO.delMember(id);
	}
	
	private void userInfoModAction(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String id = request.getParameter("user_id");
		String pwd = request.getParameter("user_pwd");
		String name = request.getParameter("user_name");
		String email = request.getParameter("user_email");
		memberVO = new MemberVO(id, pwd, name, email);
		memberDAO.modMember(memberVO);
	}
	
	private void adminAction(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		List membersList = memberDAO.listMembers();
		request.setAttribute("membersList", membersList);
	}
	
	private boolean registerAction(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String id = request.getParameter("user_id");
		String pwd = request.getParameter("user_pwd");
		String name = request.getParameter("user_name");
		String email = request.getParameter("user_email");
		memberVO = new MemberVO(id, pwd, name, email);
		if (memberDAO.isRegisteredID(memberVO)) {
			request.setAttribute("registeredID", true);
			return false;
		}
		memberDAO.addMember(memberVO);
		return true;
	}
}