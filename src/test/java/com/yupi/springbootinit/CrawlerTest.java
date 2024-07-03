package com.yupi.springbootinit;

import cn.hutool.http.HttpRequest;
import cn.hutool.json.JSONArray;
import cn.hutool.json.JSONObject;
import cn.hutool.json.JSONUtil;
import com.yupi.springbootinit.model.entity.Post;
import com.yupi.springbootinit.service.PostService;
import org.junit.jupiter.api.Assertions;
import org.junit.jupiter.api.Test;
import org.springframework.boot.test.context.SpringBootTest;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

@SpringBootTest
public class CrawlerTest {

    @Resource
    private PostService postService;

    @Test
    void testFetchPassage(){
        // 1. 获取数据
//        String json = "{\"current\":1,\"pageSize\":8,\"sortField\":\"createTime\",\"sortOrder\":\"descend\",\"category\":\"文章\",\"reviewStatus\":1}";
//        String url = "https://www.code-nav.cn/api/post/search/page/vo";
        String url="https://mainssl.geekpark.net/api/v1/topics";
//        String result = HttpRequest
//                .post(url)
//                .body(json)
//                .execute()
//                .body();
        String result=HttpRequest.get(url).execute().body();
//        System.out.println(result);
        // 2. json 转对象
        Map<String, Object> map = JSONUtil.toBean(result, Map.class);
//        JSONObject data=(JSONObject) map.get("topics");
        JSONArray records=(JSONArray) map.get("topics");

        List<Post> postList=new ArrayList<>();
        for(Object record: records){
            JSONObject tempRecord=(JSONObject) record;
            Post post=new Post();
//            post.setId();
            post.setTitle(tempRecord.getStr("title"));
            post.setContent(tempRecord.getStr("description"));
            post.setTags(tempRecord.getStr("title"));
            post.setUserId(1L);
            postList.add(post);
        }
        // 3. 保存数据
        boolean b = postService.saveBatch(postList);

        Assertions.assertTrue(b);
//        System.out.println(postList);
    }
}
