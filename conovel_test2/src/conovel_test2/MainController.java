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

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

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
		} else if (action.equals("/listPost.do")) {
			mainAction(request, response);
			nextPage = "/blog/index.jsp";
		} else if (action.equals("/viewPost.do")) {
			viewAction(request, response);
			nextPage = "/blog/viewPost.jsp";
		} else if (action.equals("/writePost.do")) {
			nextPage = "/blog/writePost.jsp";
		} else if (action.equals("/addPost.do")) {
			addPostAction(request, response);
			mainAction(request, response);
			nextPage = "/blog/index.jsp";
		} else if (action.equals("/modPostForm.do")) {
			
			nextPage = "/blog/modPost.jsp";
		} else if (action.equals("/modPost.do")) {
			
			nextPage = "/blog/index.jsp";
		}
		
		RequestDispatcher dispatch = request.getRequestDispatcher(nextPage);
		dispatch.forward(request, response);
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
		Map<String, String> articleMap = upload(request, response);
		String title = articleMap.get("title");
		String content = articleMap.get("content");
		String imageFileName = articleMap.get("imageFileName");
		
		articleVO.setParentNO(0);
		articleVO.setId("hong");
		articleVO.setTitle(title);
		articleVO.setContent(content);
		articleVO.setImageFileName(imageFileName);
		boardService.addArticle(articleVO);
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
