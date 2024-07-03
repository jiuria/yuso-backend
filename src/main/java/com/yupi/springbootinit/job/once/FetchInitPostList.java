package com.yupi.springbootinit.job.once;

import cn.hutool.core.collection.CollUtil;
import cn.hutool.http.HttpRequest;
import cn.hutool.json.JSONArray;
import cn.hutool.json.JSONObject;
import cn.hutool.json.JSONUtil;
import com.yupi.springbootinit.esdao.PostEsDao;
import com.yupi.springbootinit.model.dto.post.PostEsDTO;
import com.yupi.springbootinit.model.entity.Post;
import com.yupi.springbootinit.service.PostService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.boot.CommandLineRunner;
import org.springframework.stereotype.Component;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

/**
 * 获取初始帖子目标 es
 *
 * @author <a href="https://github.com/liyupi">程序员鱼皮</a>
 * @from <a href="https://yupi.icu">编程导航知识星球</a>
 */

//@Component
@Slf4j
public class FetchInitPostList implements CommandLineRunner {

    @Resource
    private PostService postService;


    @Override
    public void run(String... args) {
        // 1. 获取数据
//        String json = "{\"current\":1,\"pageSize\":8,\"sortField\":\"createTime\",\"sortOrder\":\"descend\",\"category\":\"文章\",\"reviewStatus\":1}";
//        String url = "https://www.code-nav.cn/api/post/search/page/vo";
        String url="https://mainssl.geekpark.net/api/v1/topics";
//        String result = HttpRequest
//                .post(url)
//                .body(json)
//                .execute()
//                .body();
        String result= HttpRequest.get(url).execute().body();
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
        if (b){
            log.info("获取初始帖子目标成功：{}", postList.size());
        }else{
            log.error("保存数据失败");
        }
        }

//        Assertions.assertTrue(b);
//        System.out.println(postList);
    }

