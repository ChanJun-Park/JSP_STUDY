package conovel_test2;

import java.util.List;

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
}
