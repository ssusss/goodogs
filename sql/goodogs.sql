--=============================
-- goodogs怨꾩젙 �깮�꽦 @愿�由ъ옄
--=============================
alter session set "_oracle_script" = true;

create user goodogs
identified by goodogs
default tablespace users;

grant connect, resource to goodogs;

alter user goodogs quota unlimited on users;

--==============================
-- 珥덇린�솕 釉붾윮
--==============================
drop table bookmark;
drop table like_list;
drop table news;
drop table news_image;
drop table news_script_rejected;
drop table deleted_news;
drop table news_script;
drop table news_comment;
drop table withdraw_member;
drop table member;
drop sequence seq_withdraw_member_no;
drop sequence seq_news_script_rejected_no;
drop sequence seq_news_comment_no;
drop sequence seq_news_script_no;
drop trigger trg_news_script_to_news;
drop trigger trg_news_to_deleted_news;
drop trigger trg_member_to_withdraw_member;
drop trigger trg_news_script_to_rejected;

--==============================
-- �뀒�씠釉� �깮�꽦
--==============================
CREATE TABLE member (
	member_id varchar2(50) NOT NULL,
	gender char(1) NOT NULL,
	password varchar2(20)	NOT NULL,
	nickname varchar2(20)	NOT NULL,
	phone varchar2(20)	NOT NULL,
	enroll_date date DEFAULT sysdate,
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
	enroll_date date,
	withdraw_date date DEFAULT sysdate,
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
	script_write_date date DEFAULT sysdate,
	script_tag varchar2(100),
	script_state number NOT NULL,
    constraints pk_news_script_script_no primary key(script_no)
);
create sequence seq_news_script_no;

CREATE TABLE news_image (
	script_no number NOT NULL,
	original_imagename varchar2(255) NOT NULL,
	renamed_filename varchar2(255) NOT NULL,
	image_reg_date date DEFAULT sysdate,
    constraints fk_news_image_script_no foreign key(script_no) references news_script(script_no) on delete cascade
);

CREATE TABLE news_script_rejected (
	script_rejected_no number,
	script_no number,
	script_writer varchar2(50),
	script_title varchar2(300),
	script_category varchar2(10),
	script_content clob,
	script_write_date date,
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
	news_write_date date,
	news_tag varchar2(100),
	news_like_cnt number DEFAULT 0,
	news_read_cnt number DEFAULT 0,
	news_confirmed_date date DEFAULT sysdate,
    constraints pk_news_no primary key(news_no)
);

CREATE TABLE deleted_news (
	news_no number,
	news_writer varchar2(50),
	news_title varchar2(300),
	news_category varchar2(10),
	news_content clob,
	news_tag varchar2(20),
	news_write_date date,
	news_like_cnt number,
	news_read_cnt number	,
	news_confirmed_date date,
	news_deleted_date date DEFAULT sysdate,
    news_deleted_reason varchar2(1000) DEFAULT '-'
);

CREATE TABLE news_comment (
	comment_no number,
	news_no number	 NOT NULL,
	news_comment_level number DEFAULT 1,
	news_comment_writer varchar2(50) NOT NULL,
	comment_no_ref number, -- null �뙎湲��씤寃쎌슦 | board_comment.no ���뙎湲��씤 寃쎌슦
	news_comment_nickname varchar2(20) NOT NULL,
	news_comment_content varchar2(1000) NOT NULL,
	comment_reg_date date DEFAULT sysdate,
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
	bookmark_date date DEFAULT sysdate,
    constraints fk_bookmark_member_id foreign key(member_id) references member(member_id) on delete cascade,
    constraints fk_bookmark_news_no foreign key(news_no) references news(news_no) on delete cascade
);

CREATE TABLE like_list (
	member_id varchar2(50) NOT NULL,
	news_no number	 NOT NULL,
	like_date date	DEFAULT sysdate,
    constraints fk_like_list_member_id foreign key(member_id) references member(member_id) on delete cascade,
    constraints fk_like_list_news_no foreign key(news_no) references news(news_no) on delete cascade
);
--=================================================
-- trigger �깮�꽦
--=================================================
CREATE OR REPLACE TRIGGER trg_news_script_to_news -- �썝怨� �듅�씤�떆 �썝怨좎뿉�꽌 �돱�뒪�뀒�씠釉붾줈 �꽆湲곕뒗 �듃由ш굅
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

CREATE OR REPLACE TRIGGER trg_news_to_deleted_news -- �돱�뒪 �궘�젣 �듃由ш굅
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

CREATE OR REPLACE TRIGGER trg_member_to_withdraw_member -- 硫ㅻ쾭�깉�눜 �듃由ш굅
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

CREATE OR REPLACE TRIGGER trg_news_script_to_rejected -- �썝怨� 諛섎젮 �듃由ш굅
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
-- sample data �깮�꽦
--=================================================
-- �씪諛섎ħ踰�
insert into member values('honggd@naver.com', 'M', 'qwe123!', '湲몃룞醫�', '01011112222', to_date('20140909','yyyymmdd'), 'M', default, default);
insert into member values('sinsa@naver.com', 'F', 'qwe123!', '�떊�궗�엫�떦', '01011113333', to_date('20191111','yyyymmdd'), 'M', default, default);
insert into member values('sejong@naver.com', 'N', 'qwe123!', '�궧�꽭醫�', '01011114444', to_date('20160307','yyyymmdd'), 'M', default, default);
insert into member values('naga@naver.com', 'N', 'qwe123!', 'naga', '0101111568', to_date('20160617','yyyymmdd'), 'M', default, default);


-- 愿�由ъ옄
insert into member values('admin@naver.com', 'M', 'qwe123!', '�뼱�뱶誘�', '01033332222', to_date('20131024','yyyymmdd'), 'A', default, default);
insert into member values('kny0910@naver.com', 'F', 'qwe123!', 'na0', '01033332222', to_date('20150910','yyyymmdd'), 'A', default, default);

-- 湲곗옄
insert into member values('kjh0425@naver.com', 'M', 'qwe123!', '以��븳', '01055552222', to_date('20180425','yyyymmdd'), 'R', default, default);
insert into member values('kdc0526@naver.com', 'M', 'qwe123!', '�룞李�', '01044442222', to_date('20190526','yyyymmdd'), 'R', default, default);

-- �썝怨�
insert into news_script values(seq_news_script_no.NEXTVAL,'kjh0425@naver.com','留� �굹�씠 �넻�씪踰� �떆�뻾','�궗�쉶','�삤�뒛(28�씪)遺��꽣 1~2�궡 �뼱�젮吏��뒗嫄� �븣怨좉퀎�떊媛��슂? �굹�씠�꽭�뒗 諛⑹떇�씠 留� �굹�씠濡� 諛붾�뚭린 �븣臾몄엯�땲�떎. �븘 吏묎�怨좎떢�떎',default,'�궗�쉶',1);
insert into news_script values(seq_news_script_no.NEXTVAL,'kjh0425@naver.com','�씪硫� �쉶�궗 遺��룄','�뀒�겕','�븘�궔二쇈뀖�슦�뀖臾대굹 �뀖�뀍遺��뀖�뀥�뀋�뀍諛붵뀥�꽩留ㅳ뀚�븷�뀫�뀆�옱�뀫�뀋 �뀫 �뀅�깘 �뀗�쑝�뀗�뀫�뀆�옱�씄誘쒖쑝',default,'�궗�쉶',1);
insert into news_script values(seq_news_script_no.NEXTVAL,'kdc0526@naver.com','吏묎�怨� �떢�뼱�슂','�젙移�','�뀆�옄�뀥�뀖�븫�뒓�쓵釉④륵�뒓�씠�뀫吏�吏묒뿉 媛�怨좎떢�떎�땲源뚯슂 吏묒뿉媛�怨좎떢�떎援ъ슂',default,'�궗�쉶',1);
insert into news_script values(seq_news_script_no.NEXTVAL,'kdc0526@naver.com','�꽭誘명븯湲곗떕�떎','�뒪�룷痢�','吏묎�怨좎떢�떎援ъ슂 吏묎�怨좎떢�떎援ъ슂吏묎�怨좎떢�떎援ъ슂吏묎�怨좎떢�떎援ъ슂吏묎�怨좎떢�떎援ъ슂吏묎�怨좎떢�떎援ъ슂吏묎�怨좎떢�떎援ъ슂吏묎�怨좎떢�떎援ъ슂吏묎�怨좎떢�떎援ъ슂吏묎�怨좎떢�떎援ъ슂 吏묎�怨좎떢�떎援ъ슂',default,'�궗�쉶',1);
insert into news_script values(seq_news_script_no.NEXTVAL,'kjh0425@naver.com','�떆醫낆씪愿�','�뀒�겕','asldmqwnklndqlkwndklnqklnsaklhioh9120uio12oijhokdakslndnasnm,nm,xznmznx,.nlkaskldmasdml;m',to_date('20230110','yyyymmdd'),'�뀒�겕',0);
insert into news_script values(seq_news_script_no.NEXTVAL,'kjh0425@naver.com','�룞�쓽蹂닿컧','�뒪�룷痢�','qn2n12n3nklnkldnkl120i012u4ioj13krnknklandlknaslkmd;lm;l,12nknkn,nm,xznmznx,.nlkaskldmasdml;m',to_date('20230411','yyyymmdd'),'�뒪�룷痢�',0);
insert into news_script values(seq_news_script_no.NEXTVAL,'kjh0425@naver.com','�깮媛곷굹�뒗��濡� ��','�젙移�','9123jhiji1rb1wheb12uyv34hv1hj5vbjkbkj53n1k3lmlk6mlk5m437m543,nm,n64,nm,xznmznx,.nlkaskldmasdml;m',to_date('20220117','yyyymmdd'),'�젙移�',2);
insert into news_script values(seq_news_script_no.NEXTVAL,'kjh0425@naver.com','吏묒뿉媛�怨좎떢��嫄멸퉴','�궗�쉶','k12ih3io1jhj90u90ucinndjkbhej2vbrhjbjhbjdknjknjkndjanjk,nm,xznmznx,.nlkaskldmasdml;m',to_date('20200601','yyyymmdd'),'�궗�쉶',3);



-- 湲곗궗
insert into news values(1000,'kjh0425@naver.com','�븷援�媛�1�젅','�젙移�','�룞�빐臾쇨낵 諛깅몢�궛�씠 留덈Ⅴ怨� �떝�룄濡� �븯�뒓�떂�씠 蹂댁슦�븯�궗 �슦由щ굹�씪留뚯꽭 臾닿턿�솕 �궪泥쒕━ �솕�젮媛뺤궛 ���븳�궗�엺 ���븳�쑝濡� 湲몄씠 蹂댁쟾�븯�꽭',to_date('20230710','yyyymmdd'),'�젙移�',4,10,sysdate);
insert into news values(1001,'kjh0425@naver.com','�븷援�媛�2�젅','�꽭怨�','�궓�궛�쐞�뿉 �� �냼�굹臾� 泥좉컩�쓣 �몢瑜몃벏 諛붾엺�꽌由� 遺덈��븿�� �슦由ш린�긽�씪�꽭 臾닿턿�솕 �궪泥쒕━ �솕�젮媛뺤궛 ���븳�궗�엺 ���븳�쑝濡� 湲몄씠 蹂댁쟾�븯�꽭',to_date('20220622','yyyymmdd'),'�꽭怨�',4,10,'22-06-23');
insert into news values(1002,'kdc0526@naver.com','�븷援�媛�3�젅','�뒪�룷痢�','媛��쓣 �븯�뒛 怨듯솢�븳�뜲 �넂怨� 援щ쫫�뾾�씠 諛앹��떖�� �슦由ш��뒾 �씪�렪 �떒�떖�씪�꽭 臾닿턿�솕 �궪泥쒕━ �솕�젮媛뺤궛 ���븳�궗�엺 ���븳�쑝濡� 湲몄씠 蹂댁쟾�븯�꽭',to_date('20230210','yyyymmdd'),'�뒪�룷痢�',8,40,'23-02-15');
insert into news values(1003,'kdc0526@naver.com','�븷援�媛�4�젅','寃쎌젣','�씠 湲곗긽怨� �씠 留섏쑝濡� 異⑹꽦�쓣 �떎�븯�뿬 愿대줈�슦�굹 利먭굅�슦�굹 �굹�씪 �궗�옉�븯�꽭 臾닿턿�솕 �궪泥쒕━ �솕�젮媛뺤궛 ���븳�궗�엺 ���븳�쑝濡� 湲몄씠 蹂댁쟾�븯�꽭',to_date('20210903','yyyymmdd'),'寃쎌젣',3,25,'21-09-05');


-- 湲곗궗 �뙎湲� 
insert into news_comment values (2, 1000, 1,'admin@naver.com', null, '�뼱�뱶誘�','諛붾낫�뼇�뀑', to_date('20180425','yyyymmdd'), 8, 0);
insert into news_comment values (3, 1000, 1,'honggd@naver.com', null, '湲몃룞醫�','�뼱姨뷀떚鍮꾩�姨뷀떚鍮�', to_date('20180425','yyyymmdd'), 9, 0);
insert into news_comment values (4, 1000, 1,'kjh0425@naver.com', null, '以��븳','荑좊（猷⑥궏六�', to_date('20180425','yyyymmdd'), 2, 0);
insert into news_comment values (5, 1000, 1,'sejong@naver.com', null, '�궧�꽭醫�','�뼱姨�', to_date('20180425','yyyymmdd'), 3, 0);
insert into news_comment values (6, 1000, 1,'sejong@naver.com', null, '�궧�꽭醫�','諛곌퀬�봽�떎', to_date('20180425','yyyymmdd'), 5, 0);
insert into news_comment values (7, 1000, 1,'kny0910@naver.com', null, 'na0','留덈씪�깢�씠', to_date('20180425','yyyymmdd'), 2, 1);
insert into news_comment values (8, 1000, 1,'sejong@naver.com', null, '�궧�꽭醫�','癒밴퀬�떆�뵆吏��룄', to_date('20180425','yyyymmdd'), 1, 2);
insert into news_comment values (9, 1000, 1,'kdc0526@naver.com', null, '�룞李�','�븘�땶媛�.�뀑', to_date('20180425','yyyymmdd'), 3, 0);


insert into news_comment values (112, 1000, 1,'admin@naver.com', null, '�뼱�뱶誘�','諛붾낫�뼇�뀑', to_date('20180425','yyyymmdd'), 8, 0);
insert into news_comment values (113, 1000, 1,'honggd@naver.com', null, '湲몃룞醫�','�뼱姨뷀떚鍮꾩�姨뷀떚鍮�', to_date('20180425','yyyymmdd'), 9, 0);
insert into news_comment values (114, 1000, 1,'kjh0425@naver.com', null, '以��븳','荑좊（猷⑥궏六�', to_date('20180425','yyyymmdd'), 2, 0);
insert into news_comment values (115, 1000, 1,'sejong@naver.com', null,'�궧�꽭醫�','�뼱姨�', to_date('20180425','yyyymmdd'), 3, 0);
insert into news_comment values (116, 1000, 1,'sejong@naver.com', null,'�궧�꽭醫�','諛곌퀬�봽�떎', to_date('20180425','yyyymmdd'), 5, 0);
insert into news_comment values (117, 1000, 1,'kny0910@naver.com', null, 'na0','留덈씪�깢�씠', to_date('20180425','yyyymmdd'), 2, 1);
insert into news_comment values (118, 1000, 1,'sejong@naver.com', null,'�궧�꽭醫�','癒밴퀬�떆�뵆吏��룄', to_date('20180425','yyyymmdd'), 1, 2);
insert into news_comment values (119, 1000, 1,'kdc0526@naver.com', null, '�룞李�','�븘�땶媛�.�뀑', to_date('20180425','yyyymmdd'), 3, 0);


---- �뀒�뒪�듃
--select * from member;
--select * from news_comment;
--update member set is_banned = 0 where member_id = 'honggd@naver.com';
--commit;
-- select * from like_list;
--
--select * from news where news_writer = 'kjh0425@naver.com';
--
select * from news_script;
--select * from news_script where script_writer = ?;
--
--delete from news_script where script_no = ?;
--
---- �듃由ш굅 �뀒�뒪�듃
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


