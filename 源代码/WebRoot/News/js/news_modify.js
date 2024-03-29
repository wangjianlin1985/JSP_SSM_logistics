$(function () {
	//实例化编辑器
	//建议使用工厂方法getEditor创建和引用编辑器实例，如果在某个闭包下引用该编辑器，直接调用UE.getEditor('editor')就能拿到相关的实例
	UE.delEditor('news_content_edit');
	var news_content_edit = UE.getEditor('news_content_edit'); //公告内容编辑器
	news_content_edit.addListener("ready", function () {
		 // editor准备好之后才可以使用 
		 ajaxModifyQuery();
	}); 
  function ajaxModifyQuery() {	
	$.ajax({
		url : "News/" + $("#news_newsId_edit").val() + "/update",
		type : "get",
		data : {
			//newsId : $("#news_newsId_edit").val(),
		},
		beforeSend : function () {
			$.messager.progress({
				text : "正在获取中...",
			});
		},
		success : function (news, response, status) {
			$.messager.progress("close");
			if (news) { 
				$("#news_newsId_edit").val(news.newsId);
				$("#news_newsId_edit").validatebox({
					required : true,
					missingMessage : "请输入新闻id",
					editable: false
				});
				$("#news_title_edit").val(news.title);
				$("#news_title_edit").validatebox({
					required : true,
					missingMessage : "请输入标题",
				});
				news_content_edit.setContent(news.content);
				$("#news_publishDate_edit").datetimebox({
					value: news.publishDate,
					required: true,
					showSeconds: true,
				});
			} else {
				$.messager.alert("获取失败！", "未知错误导致失败，请重试！", "warning");
				$(".messager-window").css("z-index",10000);
			}
		}
	});

  }

	$("#newsModifyButton").click(function(){ 
		if ($("#newsEditForm").form("validate")) {
			$("#newsEditForm").form({
			    url:"News/" +  $("#news_newsId_edit").val() + "/update",
			    onSubmit: function(){
					if($("#newsEditForm").form("validate"))  {
	                	$.messager.progress({
							text : "正在提交数据中...",
						});
	                	return true;
	                } else {
	                    return false;
	                }
			    },
			    success:function(data){
			    	$.messager.progress("close");
                	var obj = jQuery.parseJSON(data);
                    if(obj.success){
                        $.messager.alert("消息","信息修改成功！");
                        $(".messager-window").css("z-index",10000);
                        //location.href="frontlist";
                    }else{
                        $.messager.alert("消息",obj.message);
                        $(".messager-window").css("z-index",10000);
                    } 
			    }
			});
			//提交表单
			$("#newsEditForm").submit();
		} else {
			$.messager.alert("错误提示","你输入的信息还有错误！","warning");
			$(".messager-window").css("z-index",10000);
		}
	});
});
