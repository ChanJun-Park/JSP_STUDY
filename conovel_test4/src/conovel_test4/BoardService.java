package conovel_test4;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class BoardService {
	BoardDAO boardDAO;
	
	public BoardService()
	{
		boardDAO = new BoardDAO();
	}
	
	public List<ArticleVO> listArticles()
	{
		List<ArticleVO> articlesList = boardDAO.selectAllArticles();
		return articlesList;
	}
	
	public ArticleVO viewArticle(int articleNO)
	{
		ArticleVO article = null;
		article = boardDAO.selectArticle(articleNO);
		return article;
	}
	
	public void addArticle(ArticleVO article) {
		boardDAO.insertNewArticle(article);
	}
	
	public void modArticle(ArticleVO article) {
		boardDAO.updateArticle(article);
	}
	
	public void deleteArticle(int articleNO) {
		boardDAO.deleteArticle(articleNO);
	}
	
	public Map listArticles(Map pagingMap) {
		Map articlesMap = new HashMap();
		List<ArticleVO> articleList = boardDAO.selectAllArticles(pagingMap);
		int totArticles = boardDAO.selectTotArticles();
		articlesMap.put("articlesList", articleList);
		articlesMap.put("totArticles", totArticles);
		return articlesMap;
	}
}
