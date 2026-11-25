---------------------------------------------------------------
--Porject1Student_Course_Management_System 
---------------------------------------------------------------

---------------------------------------------------------------
--Database Creation 
---------------------------------------------------------------
CREATE DATABASE  student course mangmant system ;

---------------------------------------------------------------
-- Tables Creation 
---------------------------------------------------------------
create table student 
(
student_id   int   primary key ,
student_name  varchar(20)  not null , 
major  varchar(30) not null , 
gpa   float ,
)

create table course 
(
course_id    int primary key , 
course_name  varchar(15) not null , 
number_of_houres   varchar(1) not null , 
);
create table enrollmant
(
grade_of_course   float check(grade_of_course between 37 and 100 )  ,
enroll_id  int  identity(1,1)  primary key ,
student_id int not null ,
course_id int not null  ,
constraint student_id_fk1 foreign key (student_id) references student,
constraint course_id_fk2 foreign key (course_id) references course
);
alter table student 
add constraint chack_gpa  check ( gpa between  0 and 4  and gpa is not null ) ;
alter table enrollmant
add constraint check_grade check (grade_of_course between 37 and 100 );


---------------------------------------------------------------
-- Insert Data 
---------------------------------------------------------------
insert into student
values
(2024901092 ,'dana malkawi', 'CS',3),
(2024908022,'lana malkawi','BIT',3.5),
(2025901890,'sara malkawi','CIS',3.95)
;
insert into course
values(101,'database',3),
(102,'datastruct',3),
(103,'database_l',1)
;
insert into  enrollmant 
(student_id,course_id,grade_of_course)
values
(2024901092,102,90),
(2024901092, 101,86),
(2024908022,102,88),
(2024908022,103,70),
(2025901890,103,77)
;

---------------------------------------------------------------
-- Reporting Queries 
---------------------------------------------------------------

-- Query1 : list all data (student and cousre and enrollment)
select * from enrollmant;
select *from student;
select *from course;

--Query 2: list student with their courses and grades 
select student_name  , course_name , grade_of_course 
from student ,course , enrollmant 
where student.student_id=enrollmant.student_id and course.course_id =enrollmant.course_id 
order by student_name;

---- same query 2 but anther way 
select s.student_name  , c.course_name ,e.grade_of_course 
from  student s join enrollmant e on s.student_id=e.student_id 
join course c  on c.course_id = e. course_id 
order by s.student_name;
--Query3 : count number of courses per student
select s.student_name , count(e.course_id)  count_of_course
from student s join enrollmant  e on s.student_id =e.student_id 
join course c on c.course_id=e.course_id
group by s.student_name;

--Query4: calculate  average grade per student 
select s.student_name , AVG(e.grade_of_course) Averge_of_courses
from student s join enrollmant e on s.student_id=e.student_id 
group by s.student_name;

-- Query5: count namber of students ber courses 
select c.course_name , count(s.student_name) as count_students
from course c join enrollmant e on c.course_id=e.course_id
join student s on s.student_id=e.student_id
group by c.course_name ;

--Query6: find student  with mix grade above 80
select s.student_name , max(e.grade_of_course) as max_80
from student s join enrollmant e on s.student_id= e.student_id 
join course c on c.course_id = e.course_id
group by s.student_name
having max(e.grade_of_course) >80;

--Query7: Rank students by GPA (Highest first )
select  s.student_name , avg(e.grade_of_course) as GPA
from student s join enrollmant e on (s.student_id = e. student_id )
join course c on (c.course_id =e.course_id) 
group by s.student_name 
order by avg(e.grade_of_course) desc;

