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
from Student S join mark m on S.StudentId = M.StudentId join Subject Sub on M.SubId = Sub.SubId
select S.StudentId, S.StudentName, Sub.Subname, M.Mark
from Student S join mark m on S.StudentId = M.StudentId join Subject Sub on m.SubId = Sub.SubId
where SubName = 'CF';
# Hiển thị tất cả các sinh viên có tên bắt đầu bảng ký tự ‘h’
select StudentName from Student where StudentName like 'h%'

#     Hiển thị các thông tin lớp học có thời gian bắt đầu vào tháng 12.
select StartDate from Class where MONTH(StartDate) = 12;

# Hiển thị tất cả các thông tin môn học có credit trong khoảng từ 3-5.
select * from Subject where Credit between 3 and 5;


# Thay đổi mã lớp(ClassID) của sinh viên có tên ‘Hung’ là 2.
update student set ClassId=2 where StudentName = 'Hung';

# Hiển thị các thông tin: StudentName, SubName, Mark. Dữ liệu sắp xếp theo điểm thi (mark) giảm dần.
# nếu trùng sắp theo tên tăng dần.
select S.StudentName, Sub.Subname, M.Mark
from((mark m
    join student s on m.StudentId = s.StudentId)
    join Subject sub on  m.SubId = Sub.SubId)
order by Mark asc;