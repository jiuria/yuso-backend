# 数据库初始化
# @author <a href="https://github.com/liyupi">程序员鱼皮</a>
# @from <a href="https://yupi.icu">编程导航知识星球</a>

-- 创建库
create database if not exists my_db;

-- 切换库
use my_db;

-- 用户表
create table if not exists user
(
    id           bigint auto_increment comment 'id' primary key,
    userAccount  varchar(256)                           not null comment '账号',
    userPassword varchar(512)                           not null comment '密码',
    unionId      varchar(256)                           null comment '微信开放平台id',
    mpOpenId     varchar(256)                           null comment '公众号openId',
    userName     varchar(256)                           null comment '用户昵称',
    userAvatar   varchar(1024)                          null comment '用户头像',
    userProfile  varchar(512)                           null comment '用户简介',
    userRole     varchar(256) default 'user'            not null comment '用户角色：user/admin/ban',
    createTime   datetime     default CURRENT_TIMESTAMP not null comment '创建时间',
    updateTime   datetime     default CURRENT_TIMESTAMP not null on update CURRENT_TIMESTAMP comment '更新时间',
    isDelete     tinyint      default 0                 not null comment '是否删除',
    index idx_unionId (unionId)
) comment '用户' collate = utf8mb4_unicode_ci;

-- 帖子表
create table if not exists post
(
    id         bigint auto_increment comment 'id' primary key,
    title      varchar(512)                       null comment '标题',
    content    text                               null comment '内容',
    tags       varchar(1024)                      null comment '标签列表（json 数组）',
    thumbNum   int      default 0                 not null comment '点赞数',
    favourNum  int      default 0                 not null comment '收藏数',
    userId     bigint                             not null comment '创建用户 id',
    createTime datetime default CURRENT_TIMESTAMP not null comment '创建时间',
    updateTime datetime default CURRENT_TIMESTAMP not null on update CURRENT_TIMESTAMP comment '更新时间',
    isDelete   tinyint  default 0                 not null comment '是否删除',
    index idx_userId (userId)
) comment '帖子' collate = utf8mb4_unicode_ci;

-- 帖子点赞表（硬删除）
create table if not exists post_thumb
(
    id         bigint auto_increment comment 'id' primary key,
    postId     bigint                             not null comment '帖子 id',
    userId     bigint                             not null comment '创建用户 id',
    createTime datetime default CURRENT_TIMESTAMP not null comment '创建时间',
    updateTime datetime default CURRENT_TIMESTAMP not null on update CURRENT_TIMESTAMP comment '更新时间',
    index idx_postId (postId),
    index idx_userId (userId)
) comment '帖子点赞';

-- 帖子收藏表（硬删除）
create table if not exists post_favour
(
    id         bigint auto_increment comment 'id' primary key,
    postId     bigint                             not null comment '帖子 id',
    userId     bigint                             not null comment '创建用户 id',
    createTime datetime default CURRENT_TIMESTAMP not null comment '创建时间',
    updateTime datetime default CURRENT_TIMESTAMP not null on update CURRENT_TIMESTAMP comment '更新时间',
    index idx_postId (postId),
    index idx_userId (userId)
) comment '帖子收藏';


INSERT INTO user (userAccount, userPassword, unionId, mpOpenId, userName, userAvatar, userProfile, userRole, createTime, updateTime, isDelete)
VALUES
    ('zhangsan', 'pwd12345', 'wxUnionId1', 'mpOpenId1', '张三', 'https://example.com/avatar1.png', '喜欢运动和阅读。', 'user', '2024-01-01 12:00:00', '2024-01-01 12:00:00', 0),
    ('lisi', 'pwd23456', 'wxUnionId2', 'mpOpenId2', '李四', 'https://example.com/avatar2.png', '喜欢旅游和美食。', 'admin', '2024-01-02 13:00:00', '2024-01-02 13:00:00', 0),
    ('wangwu', 'pwd34567', 'wxUnionId3', 'mpOpenId3', '王五', 'https://example.com/avatar3.png', '喜欢音乐和电影。', 'user', '2024-01-03 14:00:00', '2024-01-03 14:00:00', 0),
    ('zhaoliu', 'pwd45678', NULL, 'mpOpenId4', '赵六', 'https://example.com/avatar4.png', '喜欢摄影和写作。', 'ban', '2024-01-04 15:00:00', '2024-01-04 15:00:00', 0),
    ('sunqi', 'pwd56789', 'wxUnionId5', NULL, '孙七', 'https://example.com/avatar5.png', '喜欢编程和健身。', 'user', '2024-01-05 16:00:00', '2024-01-05 16:00:00', 0),
    ('zhouba', 'pwd67890', 'wxUnionId6', 'mpOpenId6', '周八', 'https://example.com/avatar6.png', '喜欢绘画和手工。', 'admin', '2024-01-06 17:00:00', '2024-01-06 17:00:00', 0),
    ('wuwei', 'pwd78901', NULL, NULL, '吴九', 'https://example.com/avatar7.png', '喜欢养花和烹饪。', 'user', '2024-01-07 18:00:00', '2024-01-07 18:00:00', 0),
    ('chenjiu', 'pwd89012', 'wxUnionId8', 'mpOpenId8', '陈十', 'https://example.com/avatar8.png', '喜欢登山和钓鱼。', 'user', '2024-01-08 19:00:00', '2024-01-08 19:00:00', 0),
    ('wangshi', 'pwd90123', 'wxUnionId9', NULL, '王十一', 'https://example.com/avatar9.png', '喜欢跑步和读书。', 'ban', '2024-01-09 20:00:00', '2024-01-09 20:00:00', 0),
    ('zhaoshi', 'pwd01234', NULL, 'mpOpenId10', '赵十二', 'https://example.com/avatar10.png', '喜欢游泳和旅行。', 'user', '2024-01-10 21:00:00', '2024-01-10 21:00:00', 0);
