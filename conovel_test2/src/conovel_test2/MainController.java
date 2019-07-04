package conovel_test2;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.commons.io.FileUtils;

@WebServlet("/main/*")
public class MainController extends HttpServlet {
	private static String ARTICLE_IMAGE_REPO = "C:\\board\\article_image";
	BoardService boardService;
	ArticleVO articleVO;
	
	public void init(ServletConfig config) throws ServletException {
		boardService = new BoardService();
		articleVO = new ArticleVO();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doHandle(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doHandle(request, response);
	}
	
	private void doHandle(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("MainController 진입");
		String nextPage = "";
		String contextPath = request.getContextPath();
		System.out.println("contextPath=" + contextPath);
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");
		String action = request.getPathInfo();
		System.out.println("action:" + action);
		
		if (action == null) {
			mainAction(request, response);
			nextPage = "/blog/index.jsp";
		} 
		else if (action.equals("/listPost.do")) {
			mainAction(request, response);
			nextPage = "/blog/index.jsp";
		} 
		else if (action.equals("/viewPost.do")) {
			viewAction(request, response);
			nextPage = "/blog/viewPost.jsp";
		} 
		else if (action.equals("/writePost.do")) {
			if (isLogin(request, response)) {
				nextPage = "/blog/writePost.jsp";
			} else {
				request.setAttribute("needLogin", true);
				nextPage = "/login/login.jsp";
			}
		} 
		else if (action.equals("/addPost.do")) {
			addPostAction(request, response);
			nextPage = "/main";
		} 
		else if (action.equals("/modPostForm.do")) {
			viewAction(request, response);
			nextPage = "/blog/modPost.jsp";
		} 
		else if (action.equals("/modPost.do")) {
			modPostAction(request, response);
			nextPage = "/main";
		} 
		else if (action.equals("/deletePost.do")) {
			deletePostAction(request, response);
			nextPage = "/main";
		}
		else if (action.equals("/login.do")) {
			nextPage = loginAction(request, response);
		} 
		else if (action.equals("/logout.do")) {
			logoutAction(request, response);
			nextPage = "/main";
		} 
		else if (action.equals("/register.do")) {
			nextPage = registerAction(request, response);
		}
		
		System.out.println("nextPage:" + nextPage);
		RequestDispatcher dispatch = request.getRequestDispatcher(nextPage);
		dispatch.forward(request, response);
	}
	
	private void deletePostAction(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int articleNO = Integer.parseInt(request.getParameter("articleNO"));
		File imgDir = new File(ARTICLE_IMAGE_REPO + "\\" + articleNO);
		if (imgDir.exists()) {
			FileUtils.deleteDirectory(imgDir);
		}
		boardService.deleteArticle(articleNO);
		
	}
	
	private boolean isLogin(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession(false);
		if(session.getAttribute("isLogon") != null) {
			boolean isLogon = (boolean)session.getAttribute("isLogon");
			if (isLogon) {
				return true;
			} 
		}
		return false;
	}
	
	private String registerAction(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String id = request.getParameter("user_id");
		String pwd = request.getParameter("user_pwd");
		String name = request.getParameter("name");
		String email = request.getParameter("user_email");
		MemberDAO memberDAO = new MemberDAO();
		MemberVO memberVO = new MemberVO(id, pwd, name, email);
		if(memberDAO.isRegisteredID(memberVO)) {
			request.setAttribute("idExist", true);
			return "/register/register.jsp";
		} 
		memberDAO.addMember(memberVO);
		return "/main";
	}
	
	private void logoutAction(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession(false);
		session.invalidate();
	}
	
	private String loginAction(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String user_id = request.getParameter("user_id");
		String user_pwd = request.getParameter("user_pwd");
		MemberVO memberVO = new MemberVO();
		memberVO.setId(user_id);
		memberVO.setPwd(user_pwd);
		MemberDAO dao = new MemberDAO();
		boolean result = dao.isExisted(memberVO);
		if (result) {
			HttpSession session = request.getSession();
			session.setAttribute("isLogon", true);
			session.setAttribute("login.id", user_id);
			session.setAttribute("login.pwd", user_pwd);
			return "/main";
		} else {
			request.setAttribute("login_fail", true);
			return "/login/login.jsp";
		}
	}
	
	private void mainAction(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		List<ArticleVO> articlesList = new ArrayList<ArticleVO>();
		articlesList = boardService.listArticles();
		System.out.println(articlesList);
		request.setAttribute("articlesList", articlesList);
	}
	
	private void viewAction(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String articleNO = request.getParameter("articleNO");
		articleVO = boardService.viewArticle(Integer.parseInt(articleNO));
		request.setAttribute("article", articleVO);
	}
	
	private void addPostAction(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession(false);
		Map<String, String> articleMap = upload(request, response);
		String title = articleMap.get("title");
		String content = articleMap.get("content");
		String imageFileName = articleMap.get("imageFileName");
		
		articleVO.setParentNO(0);
		articleVO.setId((String)session.getAttribute("login.id"));
		articleVO.setTitle(title);
		articleVO.setContent(content);
		articleVO.setImageFileName(imageFileName);
		boardService.addArticle(articleVO);
	}
	
	private void modPostAction(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession(false);
		Map<String, String> articleMap = upload(request, response);
		String title = articleMap.get("title");
		String content = articleMap.get("content");
		String imageFileName = articleMap.get("imageFileName");
		String articleNO = articleMap.get("articleNO");
		articleVO.setParentNO(0);
		articleVO.setArticleNO(Integer.parseInt(articleNO));
		articleVO.setId((String)session.getAttribute("login.id"));
		articleVO.setTitle(title);
		articleVO.setContent(content);
		articleVO.setImageFileName(imageFileName);
		
		boardService.modArticle(articleVO);
	}
	
	private Map<String, String> upload(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		Map<String, String> articleMap = new HashMap<String, String>();
		String encoding = "utf-8";
		File currentDirPath = new File(ARTICLE_IMAGE_REPO);
		DiskFileItemFactory factory = new DiskFileItemFactory();
		factory.setRepository(currentDirPath);
		factory.setSizeThreshold(1204 * 1024);
		ServletFileUpload upload = new ServletFileUpload(factory);
		try {
			List items = upload.parseRequest(request);
			for (int i = 0; i < items.size(); i++) {
				FileItem fileItem = (FileItem) items.get(i);
				if (fileItem.isFormField()) {
					System.out.println(fileItem.getFieldName() + "=" + fileItem.getString(encoding));
					articleMap.put(fileItem.getFieldName(), fileItem.getString(encoding));
				} else {
					System.out.println("파리미터 이름 : " + fileItem.getFieldName());
					System.out.println("파일이름 : " + fileItem.getName());
					System.out.println("파일크기 : " + fileItem.getSize());
					articleMap.put(fileItem.getFieldName(), fileItem.getString());
					
					if (fileItem.getSize() > 0) {
						int idx = fileItem.getName().lastIndexOf("\\");
						if (idx == -1) {
							idx = fileItem.getName().lastIndexOf("/");
						}
						
						String fileName = fileItem.getName().substring(idx + 1);
						File uploadFile = new File(currentDirPath + "\\" + fileName);
						fileItem.write(uploadFile);
					}
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return articleMap;
	}
}
