package com.chengxusheji.mapper;

import java.util.ArrayList;
import org.apache.ibatis.annotations.Param;
import com.chengxusheji.po.News;

public interface NewsMapper {
	/*添加新闻动态信息*/
	public void addNews(News news) throws Exception;

	/*按照查询条件分页查询新闻动态记录*/
	public ArrayList<News> queryNews(@Param("where") String where,@Param("startIndex") int startIndex,@Param("pageSize") int pageSize) throws Exception;

	/*按照查询条件查询所有新闻动态记录*/
	public ArrayList<News> queryNewsList(@Param("where") String where) throws Exception;

	/*按照查询条件的新闻动态记录数*/
	public int queryNewsCount(@Param("where") String where) throws Exception; 

	/*根据主键查询某条新闻动态记录*/
	public News getNews(int newsId) throws Exception;

	/*更新新闻动态记录*/
	public void updateNews(News news) throws Exception;

	/*删除新闻动态记录*/
	public void deleteNews(int newsId) throws Exception;

}
