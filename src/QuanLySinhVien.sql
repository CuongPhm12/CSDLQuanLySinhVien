create database QuanLySinhVien;
use QuanLySinhVien;
create table Class
(
    ClassID INT not null auto_increment primary key,
    ClassName varchar(60) not null,
    StartDate datetime not null,
    Status bit

);
create table Student
(
    StudentId int not null auto_increment primary key ,
    StudentName varchar(30) not null ,
    Address varchar(50),
    Phone varchar(20),
    Status bit,
    ClassId int not null,
    foreign key (ClassId) references Class(ClassID)
);
create table Subject
(
    SubId int not null  auto_increment primary key ,
    SubName varchar(30) not null ,
    Credit tinyint not null  default 1 check ( Credit>=1 ),
    Status BIT default 1

);
create table mark
(
    MarkId int not null auto_increment primary key ,
    SubId int not null ,
    StudentId int not null ,
    Mark float default 0 check ( Mark between 0 and 100),
    ExamTimes tinyint default 1,
    UNIQUE (SubId, StudentId),
    FOREIGN KEY (SubId) references Subject(SubId),
    FOREIGN KEY (StudentId) references Student(StudentId)

);
insert into Class
values (1,'A1','2008-12-20',1);
insert into Class
values (2,'A2','2008-12-22',1);
insert into Class
values (3,'B3',current_date,0);

insert into Student( StudentName, Address, Phone, Status, ClassId)
values ('Hung','Ha Noi','0912113113',1,1);
insert into Student( StudentName, Address, Phone, Status, ClassId)
values ('Hoa','Hai Phong','',1,1);
insert into Student( StudentName, Address, Phone, Status, ClassId)
values ('Manh','HCM','0123123123',0,2);

insert into Subject
values (1,'CF',5,1),
       (2,'C',6,1),
       (3,'HDJ',5,1),
       (4,'RDBMS',10,1);
insert into Mark(SubId, StudentId, Mark, ExamTimes)
values (1,1,8,1),
       (1,2,10,2),
       (2,1,12,1);
select * from Student;
select * from Student where Address = 'Ha Noi';
select * from Student where Student.StudentName like '%u%';
select * from Subject where Credit<10;
select S.StudentId, S.StudentName, C.ClassName
from Class C join Student S on C.ClassID = S.ClassId;
select S.StudentId, S.StudentName, C.ClassName
from Student S join Class C on C.ClassID = S.ClassId
where C.ClassName = 'A1';
select S.StudentId, S.StudentName, Sub.Subname, M.Mark
from Student S join mark m on S.StudentId = M.StudentId join Subject Sub on M.SubId = Sub.SubId;
select S.StudentId, S.StudentName, Sub.Subname, M.Mark
from Student S join mark m on S.StudentId = M.StudentId join Subject Sub on m.SubId = Sub.SubId
where SubName = 'CF';
# Hi???n th??? t???t c??? c??c sinh vi??n c?? t??n b???t ?????u b???ng k?? t??? ???h???
select StudentName from Student where StudentName like 'h%';

#     Hi???n th??? c??c th??ng tin l???p h???c c?? th???i gian b???t ?????u v??o th??ng 12.
select StartDate from Class where MONTH(StartDate) = 12;

# Hi???n th??? t???t c??? c??c th??ng tin m??n h???c c?? credit trong kho???ng t??? 3-5.
select * from Subject where Credit between 3 and 5;


# Thay ?????i m?? l???p(ClassID) c???a sinh vi??n c?? t??n ???Hung??? l?? 2.
update student set ClassId=2 where StudentName = 'Hung';

# Hi???n th??? c??c th??ng tin: StudentName, SubName, Mark. D??? li???u s???p x???p theo ??i???m thi (mark) gi???m d???n.
# n???u tr??ng s???p theo t??n t??ng d???n.
select S.StudentName, Sub.Subname, M.Mark
from((mark m
    join student s on m.StudentId = s.StudentId)
    join Subject sub on  m.SubId = Sub.SubId)
order by Mark asc;
# S??? d???ng h??m count ????? hi???n th??? s??? l?????ng sinh vi??n ??? t???ng n??i
select Address, count(StudentId) as 'S??? l?????ng h???c vi??n'
from Student
group by Address;
# T??nh ??i???m trung b??nh c??c m??n h???c c???a m???i h???c vi??n b???ng c??ch s??? d???ng h??m AVG
select s.StudentId, s.StudentName, avg(mark)
from student s join mark m on s.StudentId = m.StudentId
group by s.StudentId, s.StudentName;
#     Hi???n th??? nh???ng b???n h???c vi??n co ??i???m trung b??nh c??c m??n h???c l???n h??n 15
select s.StudentId, s.StudentName, avg(mark) as '??i???m TB m??n'
from student s join mark m on s.StudentId = m.StudentId
group by s.StudentId, s.StudentName
having avg(mark) >15;

# Hi???n th??? th??ng tin c??c h???c vi??n c?? ??i???m trung b??nh l???n nh???t.
select s.StudentId, s.StudentId, avg(mark)
from Student s join mark m on s.StudentId = m.StudentId
group by s.StudentId, s.StudentId
having avg(mark) >= all(select avg(mark ) from mark group by mark.StudentId);

#     Hi???n th??? t???t c??? c??c th??ng tin m??n h???c (b???ng subject) c?? credit l???n nh???t.
select sub.SubId, sub.Subname, sub.credit
from subject sub
having Credit >=all(select credit from subject group by sub.SubId);

# Hi???n th??? c??c th??ng tin m??n h???c c?? ??i???m thi l???n nh???t.

select sub.SubId, sub.SubName, sub.Credit, mark.Mark
from subject sub join mark
having mark >=all(select mark from mark group by mark.SubId);

# Hi???n th??? c??c th??ng tin sinh vi??n v?? ??i???m trung b??nh c???a m???i sinh vi??n, x???p h???ng theo th??? t??? ??i???m gi???m d???n
# select s.StudentId, s.StudentName, s.Address, avg(mark) as '??i???m TB'
select s.StudentName,avg(Mark)
from Student s left join Mark m on s.StudentId = m.StudentId
group by s.StudentName
order by  avg(Mark) desc,StudentName


