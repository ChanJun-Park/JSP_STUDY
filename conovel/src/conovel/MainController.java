package conovel;

import java.io.File;
import java.io.IOException;
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
	BoardService boardService;
	MemberDAO memberDAO;
	MemberVO memberVO;
	private String ARTICLE_IMAGE_REPO;
	
	public void init(ServletConfig config) throws ServletException {
		System.out.println("MainController 생성자 호출");
		memberDAO = new MemberDAO();
		boardService = new BoardService();
		ARTICLE_IMAGE_REPO = "C:\\board\\article_image";
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
		} 
		else if (action.equals("/loginForm.do")) {
			nextPage = "/login/login.jsp";
		} 
		else if (action.equals("/login.do")) {
			boolean result = loginAction(request, response);
			if (result) {
				nextPage = "/main/listPost.do";
			} else {
				nextPage = "/login/login.jsp";
			}
		} 
		else if(action.equals("/logout.do")) { 
			logoutAction(request, response);
			nextPage = "/main/listPost.do";
		} 
		else if(action.equals("/writePost.do")) { 
			nextPage="/blog/writePost.jsp";
		} 
		else if(action.equals("/addPost.do")) {
			addPostAction(request, response);			
			nextPage="/main/listPost.do";
		} 
		else if (action.equals("/viewPost.do")) {
			viewPostAction(request, response);
			nextPage = "/blog/viewPost.jsp";
		}
		else if (action.equals("/modPostForm.do")) {
			viewPostAction(request, response);
			nextPage = "/blog/modPost.jsp";
		}
		else if (action.equals("/modPost.do")) {
			modPostAction(request, response);
			nextPage = "/main/listPost.do";
		}
		else if (action.equals("/delPost.do")) {
			delPostAction(request, response);
			nextPage = "/main/listPost.do";
		}
		else if (action.equals("/registerForm.do")) {
			nextPage = "/register/register.jsp";
		} 
		else if (action.equals("/register.do")) {
			boolean registerResult = registerAction(request, response);
			if (registerResult) {
				nextPage = "/main/listPost.do";
			} else {
				nextPage = "/register/register.jsp";
			}
		} 
		else if (action.equals("/admin.do")) {
			adminAction(request, response);
			nextPage = "/admin/admin.jsp";
		} 
		else if (action.equals("/userInfoModForm.do")) { 
			String _id = request.getParameter("user_id");
			MemberVO memInfo = memberDAO.findMember(_id);
			request.setAttribute("memInfo", memInfo);
			nextPage = "/register/user_info_modify.jsp";
		}
		else if (action.equals("/userInfoMod.do")) {
			userInfoModAction(request, response);
			nextPage = "/main/admin.do";
		} 
		else if (action.equals("/userInfoDel.do")) {
			userInfoDelAction(request, response);
			nextPage = "/main/admin.do";
		} else {
			nextPage = "/main/listPost.do";
		}
		
		System.out.println("nextPage:" + nextPage);
		RequestDispatcher dispatch = request.getRequestDispatcher(nextPage);
		dispatch.forward(request, response);
	}
	
	private void delPostAction(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int articleNO = Integer.parseInt(request.getParameter("articleNO"));
		boardService.removeArticle(articleNO);
	}
	
	private void modPostAction(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		Map<String, String> articleMap = upload(request, response);
		int articleNO = Integer.parseInt(request.getParameter("articleNO"));
		String title = articleMap.get("title");
		String content = articleMap.get("content");
		String imageFileName = articleMap.get("imageFileName");
		ArticleVO articleVO = new ArticleVO();
		
		HttpSession session = request.getSession(true);
		String user_id = (String)session.getAttribute("login_id");
		articleVO.setArticleNO(articleNO);
		articleVO.setParentNO(0);
		articleVO.setId(user_id);
		articleVO.setTitle(title);
		articleVO.setContent(content);
		articleVO.setImageFileName(imageFileName);
		boardService.modArticle(articleVO);
		
		if (imageFileName != null && imageFileName.length() != 0) {
			String originalFileName = articleMap.get("originalFileName");
			File srcFile = new File(ARTICLE_IMAGE_REPO + "\\temp\\" + imageFileName);
			File destDir = new File(ARTICLE_IMAGE_REPO + "\\" + articleNO);
			destDir.mkdirs();
			FileUtils.moveFileToDirectory(srcFile, destDir, true);
			File oldFile = new File(ARTICLE_IMAGE_REPO + "\\" + articleNO + "\\" + originalFileName);
			oldFile.delete();
		}
	}
	
	private void viewPostAction(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String articleNO = request.getParameter("articleNO");
		ArticleVO articleVO = boardService.viewArticle(Integer.parseInt(articleNO));
		request.setAttribute("article", articleVO);
	}
	
	private Map<String, String> upload(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		Map<String, String> articleMap = new HashMap<String, String>();
		String encoding = "utf-8";
		File currentDirPath = new File(ARTICLE_IMAGE_REPO);
		DiskFileItemFactory factory = new DiskFileItemFactory();
		factory.setRepository(currentDirPath);
		factory.setSizeThreshold(1024 * 1024);
		ServletFileUpload upload = new ServletFileUpload(factory);
		try {
			List items = upload.parseRequest(request);
			for (int i = 0; i < items.size(); i++) {
				FileItem fileItem = (FileItem)items.get(i);
				if (fileItem.isFormField()) {
					System.out.println(fileItem.getFieldName() + "=" + fileItem.getString(encoding));
					articleMap.put(fileItem.getFieldName(), fileItem.getString(encoding));
				} else {
					System.out.println("파라미터 이름 : " + fileItem.getFieldName());
					System.out.println("파일이름 : " + fileItem.getName());
					System.out.println("파일크기 : " + fileItem.getSize() + "bytes");
					articleMap.put(fileItem.getFieldName(), fileItem.getName());
					if (fileItem.getSize() > 0) 
					{
						int idx = fileItem.getName().lastIndexOf("\\");
						if (idx == -1) 
						{
							idx = fileItem.getName().lastIndexOf("/");
						}
						
						String fileName = fileItem.getName().substring(idx + 1);
						File uploadFile = new File(currentDirPath + "\\temp\\" + fileName);
						fileItem.write(uploadFile);
					}
				}
			}
		} catch(Exception e) {
			e.printStackTrace();
		}
		return articleMap;
	}
	
	private void addPostAction(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int articleNO = 0;
		Map<String, String> articleMap = upload(request, response);
		String title = articleMap.get("title");
		String content = articleMap.get("content");
		String imageFileName = articleMap.get("imageFileName");
		ArticleVO articleVO = new ArticleVO();
		
		HttpSession session = request.getSession(true);
		String user_id = (String)session.getAttribute("login_id");
		articleVO.setParentNO(0);
		articleVO.setId(user_id);
		articleVO.setTitle(title);
		articleVO.setContent(content);
		articleVO.setImageFileName(imageFileName);
		articleNO = boardService.addArticle(articleVO);
		
		if (imageFileName != null && imageFileName.length() != 0) {
			File srcFile = new File(ARTICLE_IMAGE_REPO + "\\temp\\" + imageFileName);
			File destDir = new File(ARTICLE_IMAGE_REPO + "\\" + articleNO);
			destDir.mkdirs();
			FileUtils.moveFileToDirectory(srcFile, destDir, true);
		}
	}
	
	private void logoutAction(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession(false);
		if (session != null) 
			session.invalidate();
	}
	
	private boolean loginAction(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String user_id = request.getParameter("user_id");
		String user_pwd = request.getParameter("user_pwd");
		memberVO = new MemberVO();
		memberVO.setId(user_id);
		memberVO.setPwd(user_pwd);
		boolean result = memberDAO.isExisted(memberVO);
		if(result) {
			HttpSession session = request.getSession();
			session.setAttribute("isLogOn", true);
			session.setAttribute("login_id", user_id);
			session.setAttribute("login_pwd", user_pwd);
		} else {
			request.setAttribute("invalidLogin", true);
		}
		return result;
	}
	
	private void listPostAction(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//		List<ArticleVO> articlesList = boardService.listArticles();
//		request.setAttribute("articlesList", articlesList);
		
		String _section = request.getParameter("section");
		String _pageNum = request.getParameter("pageNum");
		int section = Integer.parseInt((_section == null)? "1" : _section);
		int pageNum = Integer.parseInt((_pageNum == null)? "1" : _pageNum);
		Map pagingMap = new HashMap();
		pagingMap.put("section", section);
		pagingMap.put("pageNum", pageNum);
		Map articlesMap = boardService.listArticles(pagingMap);
		articlesMap.put("section", section);
		articlesMap.put("pageNum", pageNum);
		request.setAttribute("articlesMap", articlesMap);
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