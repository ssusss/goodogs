--=============================
-- goodogs계정 생성 @관리자
--=============================
--alter session set "_oracle_script" = true;
--
--create user goodogs
--identified by goodogs
--default tablespace users;
--
--grant connect, resource to goodogs;
--
--alter user goodogs quota unlimited on users;

--==============================
-- 초기화 블럭
--==============================
--drop table bookmark;
--drop table like_list;
--drop table news;
--drop table news_image;
--drop table news_script_rejected;
--drop table deleted_news;
--drop table news_script;
--drop table news_comment;
--drop table withdraw_member;
--drop table member;
--drop sequence seq_withdraw_member_no;
--drop sequence seq_news_script_rejected_no;
--drop sequence seq_news_comment_no;
--drop sequence seq_news_script_no;
--drop trigger trg_news_script_to_news;
--drop trigger trg_news_to_deleted_news;
--drop trigger trg_member_to_withdraw_member;
--drop trigger trg_news_script_to_rejected;

--==============================
-- 테이블 생성
--==============================
CREATE TABLE member (
	member_id varchar2(50) NOT NULL,
	gender char(1) NOT NULL,
	password varchar2(20)	NOT NULL,
	nickname varchar2(20)	NOT NULL,
	phone varchar2(20)	NOT NULL,
	enroll_date Timestamp DEFAULT sysdate,
	member_role char(1) DEFAULT 'M',
	member_profile varchar2(200) default null,
	is_banned number DEFAULT 0,
    constraints pk_member_member_id primary key(member_id),
    constraints ck_member_role check(member_role in ('M', 'A', 'R')),
    constraints ck_member_gender check(gender in ('M', 'F', 'N')),
    constraints uq_member_nickname unique(nickname)
);

CREATE TABLE withdraw_member (
	withdraw_member_no number NOT NULL,
	member_id varchar2(50) NOT NULL,
	gender char(1),
	nickname varchar2(20),
	phone varchar2(20),
	enroll_date Timestamp,
	withdraw_date Timestamp DEFAULT sysdate,
	withdraw_reason varchar2(200) default '-',
    constraints pk_withdraw_member_no primary key(withdraw_member_no)
);
create sequence seq_withdraw_member_no;


CREATE TABLE news_script (
	script_no number,
	script_writer varchar2(50) NOT NULL,
	script_title varchar2(300) NOT NULL,
	script_category varchar2(10)	NOT NULL,
	script_content clob NOT NULL,
	script_write_date timestamp DEFAULT sysdate,
	script_tag varchar2(100),
	script_state number NOT NULL,
    constraints pk_news_script_script_no primary key(script_no)
);
create sequence seq_news_script_no;

CREATE TABLE news_image (
	script_no number NOT NULL,
	original_imagename varchar2(255) NOT NULL,
	renamed_filename varchar2(255) NOT NULL,
	image_reg_date Timestamp DEFAULT sysdate,
    constraints fk_news_image_script_no foreign key(script_no) references news_script(script_no) on delete cascade
);

CREATE TABLE news_script_rejected (
	script_rejected_no number,
	script_no number,
	script_writer varchar2(50),
	script_title varchar2(300),
	script_category varchar2(10),
	script_content clob,
	script_write_date timestamp,
	script_tag varchar2(100),
	script_rejected_reason varchar2(1000) default '-',
    constraints pk_news_script_rejected_script_no primary key(script_rejected_no)
);
create sequence seq_news_script_rejected_no;

CREATE TABLE news (
	news_no number	,
	news_writer varchar2(50),
	news_title varchar2(300),
	news_category varchar2(10),
	news_content clob,
	news_write_date Timestamp,
	news_tag varchar2(100),
	news_like_cnt number DEFAULT 0,
	news_read_cnt number DEFAULT 0,
	news_confirmed_date Timestamp DEFAULT sysdate,
    constraints pk_news_no primary key(news_no)
);

CREATE TABLE deleted_news (
	news_no number,
	news_writer varchar2(50),
	news_title varchar2(300),
	news_category varchar2(10),
	news_content clob,
	news_tag varchar2(20),
	news_write_date Timestamp,
	news_like_cnt number,
	news_read_cnt number	,
	news_confirmed_date Timestamp,
	news_deleted_date Timestamp DEFAULT sysdate,
    news_deleted_reason varchar2(1000) DEFAULT '-'
);

CREATE TABLE news_comment (
	comment_no number,
	news_no number	 NOT NULL,
	news_comment_level number DEFAULT 1,
	news_comment_writer varchar2(50) NOT NULL,
	comment_no_ref number, -- null 댓글인경우 | board_comment.no 대댓글인 경우
	news_comment_nickname varchar2(20) NOT NULL,
	news_comment_content varchar2(1000) NOT NULL,
	comment_reg_date Timestamp DEFAULT sysdate,
	news_comment_report_cnt number DEFAULT 0,
	comment_state number DEFAULT 0,
    constraints pk_news_comment_no primary key(comment_no),
    constraints fk_news_comment_ref foreign key(comment_no_ref) references news_comment(comment_no) on delete cascade
);
create sequence seq_news_comment_no;

CREATE TABLE bookmark (
	member_id varchar2(50) NOT NULL,
	news_no number	 NOT NULL,
	new_bookmarked_content clob	NOT NULL,
	bookmark_date Timestamp DEFAULT sysdate,
    constraints fk_bookmark_member_id foreign key(member_id) references member(member_id) on delete cascade,
    constraints fk_bookmark_news_no foreign key(news_no) references news(news_no) on delete cascade
);

CREATE TABLE like_list (
	member_id varchar2(50) NOT NULL,
	news_no number	 NOT NULL,
	like_date Timestamp	DEFAULT sysdate,
    constraints fk_like_list_member_id foreign key(member_id) references member(member_id) on delete cascade,
    constraints fk_like_list_news_no foreign key(news_no) references news(news_no) on delete cascade
);
--=================================================
-- trigger 생성
--=================================================
CREATE OR REPLACE TRIGGER trg_news_script_to_news -- 원고 승인시 원고에서 뉴스테이블로 넘기는 트리거
AFTER UPDATE OF script_state ON news_script
FOR EACH ROW
WHEN (NEW.script_state = 2)
BEGIN
    INSERT INTO news (
        news_no,
        news_writer,
        news_title,
        news_category,
        news_content,
        news_write_date,
        news_tag
    ) VALUES (
        :new.script_no,
        :new.script_writer,
        :new.script_title,
        :new.script_category,
        :new.script_content,
        :new.script_write_date,
        :new.script_tag
    );
END;
/

CREATE OR REPLACE TRIGGER trg_news_to_deleted_news -- 뉴스 삭제 트리거
BEFORE DELETE ON news
FOR EACH ROW
BEGIN
    INSERT INTO deleted_news (
        news_no,
        news_writer,
        news_title,
        news_category,
        news_content,
        news_tag,
        news_write_date,
        news_like_cnt,
        news_read_cnt,
        news_confirmed_date,
        news_deleted_date,
        news_deleted_reason
    ) VALUES (
        :old.news_no,
        :old.news_writer,
        :old.news_title,
        :old.news_category,
        :old.news_content,
        :old.news_tag,
        :old.news_write_date,
        :old.news_like_cnt,
        :old.news_read_cnt,
        :old.news_confirmed_date,
        sysdate,
        default
    );
END;
/

CREATE OR REPLACE TRIGGER trg_member_to_withdraw_member -- 멤버탈퇴 트리거
BEFORE DELETE ON member
FOR EACH ROW
BEGIN
    INSERT INTO withdraw_member (
        withdraw_member_no,
        member_id,
        gender,
        nickname,
        phone,
        enroll_date,
        withdraw_date,
        withdraw_reason
    ) VALUES (
        seq_withdraw_member_no.NEXTVAL,
        :old.member_id,
        :old.gender,
        :old.nickname,
        :old.phone,
        :old.enroll_date,
        sysdate,
        default
    );
END;
/

CREATE OR REPLACE TRIGGER trg_news_script_to_rejected -- 원고 반려 트리거
AFTER UPDATE OF script_state ON news_script
FOR EACH ROW
WHEN (NEW.script_state = 3)
BEGIN
    INSERT INTO news_script_rejected (
        script_rejected_no,
        script_no,
        script_writer,
        script_title,
        script_category,
        script_content,
        script_write_date,
        script_tag,
        script_rejected_reason
    ) VALUES (
        seq_news_script_rejected_no.NEXTVAL,
        :new.script_no,
        :new.script_writer,
        :new.script_title,
        :new.script_category,
        :new.script_content,
        :new.script_write_date,
        :new.script_tag,
        default
    );
END;
/


--=================================================
-- sample data 생성
--=================================================
-- 일반멤버
insert into member values('honggd@naver.com', 'M', 'qwe123!', '길동좌', '01011112222', to_date('20140909','yyyymmdd'), 'M', default, default);
insert into member values('sinsa@naver.com', 'F', 'qwe123!', '신사임당', '01011113333', to_date('20191111','yyyymmdd'), 'M', default, default);
insert into member values('sejong@naver.com', 'N', 'qwe123!', '킹세종', '01011114444', to_date('20160307','yyyymmdd'), 'M', default, default);
insert into member values('naga@naver.com', 'N', 'qwe123!', 'naga', '0101111568', to_date('20160617','yyyymmdd'), 'M', default, default);


-- 관리자
insert into member values('admin@naver.com', 'M', 'qwe123!', '어드민', '01033332222', to_date('20131024','yyyymmdd'), 'A', default, default);
insert into member values('kny0910@naver.com', 'F', 'qwe123!', 'na0', '01033332222', to_date('20150910','yyyymmdd'), 'A', default, default);

-- 기자
insert into member values('kjh0425@naver.com', 'M', 'qwe123!', '준한', '01055552222', to_date('20180425','yyyymmdd'), 'R', default, default);
insert into member values('kdc0526@naver.com', 'M', 'qwe123!', '동찬', '01044442222', to_date('20190526','yyyymmdd'), 'R', default, default);

-- 원고
insert into news_script values(seq_news_script_no.NEXTVAL,'kjh0425@naver.com','만 나이 통일법 시행','사회','오늘(28일)부터 1~2살 어려지는걸 알고계신가요? 나이세는 방식이 만 나이로 바뀌기 때문입니다. 아 집가고싶다',default,'사회',1);
insert into news_script values(seq_news_script_no.NEXTVAL,'kjh0425@naver.com','라면 회사 부도','테크','아납주ㅏ우ㅏ무나 ㅏㅈ부ㅏㅜㅇㅈ바ㅜㄴ매ㅓ애ㅡㅂ재ㅡㅇ ㅡ ㅁ냐 ㅐ으ㅐㅡㅂ재읜믜으',default,'사회',1);
insert into news_script values(seq_news_script_no.NEXTVAL,'kdc0526@naver.com','집가고 싶어요','정치','ㅂ자ㅜㅏ암느읒븨긤느이ㅡ지집에 가고싶다니까요 집에가고싶다구요',default,'사회',1);
insert into news_script values(seq_news_script_no.NEXTVAL,'kdc0526@naver.com','세미하기싫다','스포츠','집가고싶다구요 집가고싶다구요집가고싶다구요집가고싶다구요집가고싶다구요집가고싶다구요집가고싶다구요집가고싶다구요집가고싶다구요집가고싶다구요 집가고싶다구요',default,'사회',1);
insert into news_script values(seq_news_script_no.NEXTVAL,'kjh0425@naver.com','시종일관','테크','asldmqwnklndqlkwndklnqklnsaklhioh9120uio12oijhokdakslndnasnm,nm,xznmznx,.nlkaskldmasdml;m',to_date('20230110','yyyymmdd'),'테크',0);
insert into news_script values(seq_news_script_no.NEXTVAL,'kjh0425@naver.com','동의보감','스포츠','qn2n12n3nklnkldnkl120i012u4ioj13krnknklandlknaslkmd;lm;l,12nknkn,nm,xznmznx,.nlkaskldmasdml;m',to_date('20230411','yyyymmdd'),'스포츠',0);
insert into news_script values(seq_news_script_no.NEXTVAL,'kjh0425@naver.com','집에가고싶은걸까','사회','k12ih3io1jhj90u90ucinndjkbhej2vbrhjbjhbjdknjknjkndjanjk,nm,xznmznx,.nlkaskldmasdml;m',to_date('20200601','yyyymmdd'),'사회',3);
insert into news_script values(seq_news_script_no.NEXTVAL,'kjh0425@naver.com','애국가1절','정치','동해물과 백두산이 마르고 닳도록 하느님이 보우하사 우리나라만세 무궁화 삼천리 화려강산 대한사람 대한으로 길이 보전하세',to_date('20230710','yyyymmdd'),'정치',2);
insert into news_script values(seq_news_script_no.NEXTVAL,'kjh0425@naver.com','애국가2절','세계','남산위에 저 소나무 철갑을 두른듯 바람서리 불변함은 우리기상일세 무궁화 삼천리 화려강산 대한사람 대한으로 길이 보전하세',to_date('20220622','yyyymmdd'),'세계',2);
insert into news_script values(seq_news_script_no.NEXTVAL,'kdc0526@naver.com','애국가3절','스포츠','가을 하늘 공활한데 높고 구름없이 밝은달은 우리가슴 일편 단심일세 무궁화 삼천리 화려강산 대한사람 대한으로 길이 보전하세',to_date('20230210','yyyymmdd'),'스포츠',2);
insert into news_script values(seq_news_script_no.NEXTVAL,'kdc0526@naver.com','애국가4절','경제','이 기상과 이 맘으로 충성을 다하여 괴로우나 즐거우나 나라 사랑하세 무궁화 삼천리 화려강산 대한사람 대한으로 길이 보전하세',to_date('20210903','yyyymmdd'),'경제',2);




-- 기사
insert into news values(8,'kjh0425@naver.com','애국가1절','정치','동해물과 백두산이 마르고 닳도록 하느님이 보우하사 우리나라만세 무궁화 삼천리 화려강산 대한사람 대한으로 길이 보전하세',to_date('20230710','yyyymmdd'),'정치',4,10,sysdate);
insert into news values(9,'kjh0425@naver.com','애국가2절','세계','남산위에 저 소나무 철갑을 두른듯 바람서리 불변함은 우리기상일세 무궁화 삼천리 화려강산 대한사람 대한으로 길이 보전하세',to_date('20220622','yyyymmdd'),'세계',4,10,'22-06-23');
insert into news values(10,'kdc0526@naver.com','애국가3절','스포츠','가을 하늘 공활한데 높고 구름없이 밝은달은 우리가슴 일편 단심일세 무궁화 삼천리 화려강산 대한사람 대한으로 길이 보전하세',to_date('20230210','yyyymmdd'),'스포츠',8,40,'23-02-15');
insert into news values(11,'kdc0526@naver.com','애국가4절','경제','이 기상과 이 맘으로 충성을 다하여 괴로우나 즐거우나 나라 사랑하세 무궁화 삼천리 화려강산 대한사람 대한으로 길이 보전하세',to_date('20210903','yyyymmdd'),'경제',3,25,'21-09-05');


-- 기사 댓글 
insert into news_comment values (2, 8, 1,'admin@naver.com', null, '어드민','바보양ㅋ', to_date('20180425','yyyymmdd'), 8, 0);
insert into news_comment values (3, 8, 1,'honggd@naver.com', null, '길동좌','어쩔티비저쩔티비', to_date('20180425','yyyymmdd'), 9, 0);
insert into news_comment values (4, 8, 1,'kjh0425@naver.com', null, '준한','쿠루루삥뻥', to_date('20180425','yyyymmdd'), 2, 0);
insert into news_comment values (5, 8, 1,'sejong@naver.com', null, '킹세종','어쩔', to_date('20180425','yyyymmdd'), 3, 0);
insert into news_comment values (6, 8, 1,'sejong@naver.com', null, '킹세종','배고프다', to_date('20180425','yyyymmdd'), 5, 0);
insert into news_comment values (7, 8, 1,'kny0910@naver.com', null, 'na0','마라탕이', to_date('20180425','yyyymmdd'), 2, 1);
insert into news_comment values (8, 8, 1,'sejong@naver.com', null, '킹세종','먹고시플지도', to_date('20180425','yyyymmdd'), 1, 2);
insert into news_comment values (9, 8, 1,'kdc0526@naver.com', null, '동찬','아닌강.ㅋ', to_date('20180425','yyyymmdd'), 3, 0);


insert into news_comment values (112, 8, 1,'admin@naver.com', null, '어드민','바보양ㅋ', to_date('20180425','yyyymmdd'), 8, 0);
insert into news_comment values (113, 8, 1,'honggd@naver.com', null, '길동좌','어쩔티비저쩔티비', to_date('20180425','yyyymmdd'), 9, 0);
insert into news_comment values (114, 8, 1,'kjh0425@naver.com', null, '준한','쿠루루삥뻥', to_date('20180425','yyyymmdd'), 2, 0);
insert into news_comment values (115, 8, 1,'sejong@naver.com', null,'킹세종','어쩔', to_date('20180425','yyyymmdd'), 3, 0);
insert into news_comment values (116, 8, 1,'sejong@naver.com', null,'킹세종','배고프다', to_date('20180425','yyyymmdd'), 5, 0);
insert into news_comment values (117, 8, 1,'kny0910@naver.com', null, 'na0','마라탕이', to_date('20180425','yyyymmdd'), 2, 1);
insert into news_comment values (118, 8, 1,'sejong@naver.com', null,'킹세종','먹고시플지도', to_date('20180425','yyyymmdd'), 1, 2);
insert into news_comment values (119, 8, 1,'kdc0526@naver.com', null, '동찬','아닌강.ㅋ', to_date('20180425','yyyymmdd'), 3, 0);

-- 뉴스이미지

insert into news_image values(8,'제목없음.png','20230717_091648367_729.png',default);
insert into news_image values(9,'제목없음.png','20230717_092040407_043.png',default);
insert into news_image values(10,'제목없음.png','20230717_092222567_980.png',default);
insert into news_image values(11,'제목없음.png','20230717_093900145_618.png',default);

-- like_list 샘플 데이터
insert into like_list values('honggd@naver.com', 8, default);
insert into like_list values('honggd@naver.com', 9, default);
insert into like_list values('honggd@naver.com', 10, default);
insert into like_list values('admin@naver.com', 8, default);
insert into like_list values('admin@naver.com', 9, default);
--북마크 샘플 데이터
insert into bookmark values('honggd@naver.com',8,'백두산이',DEFAULT );
insert into bookmark values('honggd@naver.com',9,'소나무',DEFAULT );
insert into bookmark values('kjh0425@naver.com',9,'소나무',DEFAULT );
insert into bookmark values('kdc0526@naver.com',9,'소나무',DEFAULT );
commit;


---- 테스트
--select * from member;
--select * from news_comment;
--update member set is_banned = 0 where member_id = 'honggd@naver.com';
--commit;

--
--select * from news where news_writer = 'kjh0425@naver.com';
--
select * from news_image;

--select n.*, i.renamed_filename from (select row_number() over(order by news_no desc) rnum, n.* from news n) n join news_image i on n.news_no = i.script_no where rnum between ? and ?


select * from news_image;
select * from news;




select * from bookmark;
--select * from news_script where script_writer = ?;
--
--delete from news_script where script_no = ?;
--
---- 트리거 테스트
--select * from news_script;
--update news_script set script_state = 2 where script_no = 8;
--select * from news;
--
--select * from news;
--delete from news where news_no = 1003;
--select * from deleted_news;
--
--select * from member;
--delete from member where member_id = 'naga@naver.com';
--select * from withdraw_member;
--
--select * from news_script;
--update news_script set script_state = 3 where script_no = 4;
--select * from news_script_rejected;
