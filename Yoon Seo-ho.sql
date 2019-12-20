drop sequence member_seq;
create sequence member_seq
start with 0
minvalue 0
increment by 1
nocache;

drop table members;
create table members (
m_num number primary key,
m_email varchar2(50) not null unique,
m_password varchar2(50) not null,
m_nickname varchar2(20) not null,
m_name varchar2(20) not null,
m_phone varchar2(20) not null
);

drop sequence seller_seq;
create sequence seller_seq
start with 0
minvalue 0
increment by 1
nocache;

create table sellers (
s_num number primary key,
s_email varchar2(50) not null unique,
s_password varchar2(50) not null,
s_phone varchar2(20) not null,
s_name varchar2(20) not null,
s_comnumber varchar2(20) not null
);

drop sequence hotel_seq;
create sequence hotel_seq
start with 0
minvalue 0
increment by 1
nocache;


drop table hotel;
create table hotel ( 
h_num number primary key,
s_num number REFERENCES sellers (s_num),
h_name varchar2(50),
h_nation varchar2(50),
h_address1 varchar2(50),
h_address2 varchar2(50),
h_type varchar2(50),
h_phone varchar2(50),
h_room_num number,
h_facilities varchar2(300),
h_internet varchar2(50),
h_animal varchar2(50),
h_parking varchar2(50), 
h_smoke varchar2(50),
h_language varchar2(50), 
h_image varchar2(300), 
h_hotel_url varchar2(50),
h_comment varchar2(300),
h_grade varchar2(20),
h_postcode varchar2(50)
);
select * from hotel;
select * from sellers;
select * from members;
select * from mainorder;
select * from orderdetail;
select * from rooms;
delete mainorder where o_num=0;
commit;
drop sequence room_seq;
create sequence room_seq 
start with 0
minvalue 0
increment by 1 
nocache;


drop table rooms;
create table rooms(
r_num number primary key,
h_num number REFERENCES hotel (h_num),
r_type varchar2(20),
r_price number, 
r_person number,
r_breakfast varchar2(10),
r_stock number
);

drop sequence o_seq;
create sequence o_seq
start with 0
minvalue 0
increment by 1
nocache;

drop table mainorder;
create table mainorder(
o_num number primary key,
m_num number REFERENCES members (m_num),
o_orderdate date default sysdate,
o_checkin date,
o_checkout date,
o_people varchar2(20),
o_totalpeople NUMBER,
o_comment varchar2(2000),
o_checker varchar2(20),
o_engname varchar2(30)
);
update mainorder set o_reviewchecker=0;
select * from mainorder;
select * from hotel;
select * from review;
delete review;
commit;

drop sequence od_seq;
create sequence od_seq
start with 0
minvalue 0
increment by 1
nocache;

drop table orderdetail;
create table orderdetail(
od_num number primary key,
r_num number REFERENCES rooms (r_num),
o_count number,
o_num number REFERENCES mainorder (o_num)
);

drop sequence c_seq;
create sequence c_seq
start with 0
minvalue 0
increment by 1
nocache;

drop table review;
create table review(
c_num number primary key,
m_num number REFERENCES members (m_num),
o_num number REFERENCES mainorder (o_num),
c_comment varchar2(500),
c_star number,
c_checker number,
c_date date default sysdate,
h_num number
);

alter table review add (c_date date default sysdate);
delete review;
select * from hotel;
select * from review;
alter table review add (h_num number);
update mainorder set o_reviewchecker=0;
select * from mainorder;
 commit;
 rollback;

drop sequence qa_seq;
create sequence qa_seq
start with 0
minvalue 0
increment by 1
nocache;

drop table qa;
create table qa(
q_num number primary key,
m_num number REFERENCES members (m_num),
q_title varchar2(50),
q_comment varchar2(2000),
q_reqDate date,
q_checked number
);
select * from review;
desc review;
select * from sellers;
select * from  members;
select * from hotel;
select * from mainorder;
select * from orderdetail;
delete review;
delete mainorder;
commit;
delete sellers;
where m_num=3;

alter table members drop primary key cascade;
alter table sellers drop primary key cascade;
alter table hotel drop primary key cascade;
alter table rooms drop primary key cascade;
alter table mainorder drop primary key cascade;

ALTER TABLE members ADD CONSTRAINTS PK_members PRIMARY KEY (m_num);
ALTER TABLE qa ADD CONSTRAINTS FK_qa FOREIGN KEY (m_num) REFERENCES members(m_num) on delete cascade;
ALTER TABLE mainorder ADD CONSTRAINTS FK_md FOREIGN KEY (m_num) REFERENCES members(m_num) on delete cascade;
alter table review add constraints FK_rv foreign key (m_num) references members(m_num) on delete cascade;

ALTER TABLE hotel ADD CONSTRAINTS PK_hotel PRIMARY KEY (h_num);
ALTER TABLE rooms ADD CONSTRAINTS FK_rm FOREIGN KEY (h_num) REFERENCES hotel(h_num) on delete cascade;
ALTER TABLE review ADD CONSTRAINTS FK_rv3 FOREIGN KEY (h_num) REFERENCES hotel(h_num) on delete cascade;

ALTER TABLE sellers ADD CONSTRAINTS PK_sellers PRIMARY KEY (s_num);
ALTER TABLE hotel ADD CONSTRAINTS FK_ht FOREIGN KEY (s_num) REFERENCES sellers(s_num) on delete cascade;

ALTER TABLE rooms ADD CONSTRAINTS PK_rooms PRIMARY KEY (r_num);
ALTER TABLE orderdetail ADD CONSTRAINTS FK_od FOREIGN KEY (r_num) REFERENCES rooms(r_num) on delete cascade;

ALTER TABLE mainorder ADD CONSTRAINTS PK_mainorder PRIMARY KEY (o_num);
ALTER TABLE orderdetail ADD CONSTRAINTS FK_od2 FOREIGN KEY (o_num) REFERENCES mainorder(o_num) on delete cascade;
alter table review add constraints fk_rv2 foreign key (o_num) references mainorder(o_num) on delete cascade;

select * from review;

delete review where c_num=14;
select * from rooms;
select * from mainorder;
update mainorder set o_reviewchecker = 0 where o_num=8;
commit;
delete mainorder;
select * from hotel;
select * from orderdetail;
,  mainorder o, orderdetail od, rooms r
, r.r_type, o.o_checkin, o.o_checkout 

commit;


select distinct c.c_num, c.c_date, c.C_STAR, c.C_COMMENT, m.m_nickname, o.o_checkin, o.o_checkout, h.h_name , o.o_num, r.r_type
from review c, members m, mainorder o, orderdetail od, rooms r, hotel h
where c.h_num=1 and c.m_num = m.m_num and c.o_num = o.o_num and o.o_num = od.o_num and od.r_num = r.r_num and c.h_num=h.h_num;



select o.o_num , MAX(h.h_name) ,  max(c.c_date), max(c.c_date), max(c.c_comment), max(m.m_nickname), max(o.o_checkin), max(o.o_checkout), MIN(r.r_type)
from review c, members m, mainorder o, orderdetail od, rooms r, hotel h
where c.h_num=1 and c.m_num = m.m_num and c.o_num = o.o_num and o.o_num = od.o_num and od.r_num = r.r_num and c.h_num=h.h_num
group by o.o_num;



select distinct c.c_date, c.C_STAR, c.C_COMMENT, m.m_nickname, o.o_checkin, o.o_checkout, h.h_name , o.o_num, op.r_type
from review c, members m, mainorder o,  hotel h,(
select h_num, LISTAGG(r_type, ', ') WITHIN GROUP (ORDER BY od_num) as r_type 
from (
select * from rooms r, orderdetail od
where r.r_num = od.r_num
) group by h_num
) op
where c.h_num=1 and c.m_num = m.m_num and c.o_num = o.o_num and c.h_num=op.h_num and o.m_num = m.m_num;

select * from review;
delete review where c_num=10;
commit;

select * from mainorder;



select o_num, LISTAGG(r_type, ', ') WITHIN GROUP (ORDER BY od_num) as r_type 
from (
select * from rooms r, orderdetail od
where r.r_num = od.r_num
) group by o_num
;

select * from rooms r, orderdetail od
where r.r_num = od.r_num;

select * from orderdetail;
select * from rooms;
select * from mainorder;
delete mainorder where o_num=0;


select h_num, LISTAGG(r_type, ', ') WITHIN GROUP (ORDER BY od_num) as r_type 
from (
select * from rooms r, orderdetail od
where r.r_num = od.r_num
) group by h_num;

select * from rooms;

select * from rooms r, orderdetail od
where r.r_num = od.r_num;


select c.c_num, c.c_date, c.C_STAR, c.C_COMMENT, m.m_nickname, o.o_checkin, o.o_checkout, h.h_name , op.r_type
from review c, members m, mainorder o, hotel h, (
select o_num, LISTAGG(r_type, ', ') WITHIN GROUP (ORDER BY od_num) as r_type 
from (
select * from rooms r, orderdetail od
where r.r_num = od.r_num
) group by o_num
)op
where c.h_num=1 and c.m_num = m.m_num and c.o_num = o.o_num and o.o_num = op.o_num and  c.h_num=h.h_num;






select c.c_num, c.c_date, c.c_star, c.c_comment,
		m.m_nickname, o.o_checkin, o.o_checkout,  op.r_type, h.h_name
		from review c, members m, mainorder o, hotel h, (
		select o_num, listagg(r_type, ', ') within group (order by od_num) as r_type
		from (
		select * from rooms r, orderdetail od
		where r.r_num = od.r_num
		) group by o_num
		)op
		where c.h_num=1 and c.m_num = m.m_num and c.o_num = o.o_num and o.o_num =
		op.o_num and c.h_num=h.h_num

