-- select 
-- concat(school_db.lecturers.first_name, ',', school_db.lecturers.last_name) as `Lecturer Full Name`,
-- school_db.courses.title as `Course title`,
-- school_db.courses.number_of_credits as `$Number of Credits`
-- from school_db.classes -- class -- alias
-- inner join school_db.lecturers on school_db.classes.lecturer_id = school_db.lecturers.lecturer_id
-- inner join school_db.courses on school_db.classes.courses_id = school_db.courses.course_id;

select
concat(school_db.lecturers.last_name, ',',school_db.lecturers.first_name) as `Lecturer Full Name`,
concat(school_db.students.last_name, ',',school_db.students.first_name) as `Student full name`,
school_db.courses.title as `Course title`,
school_db.classes.time as `Session time`
from school_db.enrollment
inner join school_db.classes on school_db.classes.id = school_db.enrollment.class_id
inner join school_db.students on school_db.students.id = school_db.enrollment.student_id
inner join school_db.lecturers on school_db.classes.lecturer_id = school_db.lecturers.lecturer_id
inner join school_db.courses on school_db.classes.courses_id = school_db.courses.course_id;

select
school_db.classes.id as 'Classroom number/id' , school_db.students.id as 'Student id'
from school_db.enrollment
inner join school_db.students on school_db.students.id = school_db.enrollment.student_id
inner join  school_db.classes on school_db.classes.id = school_db.enrollment.class_id;

select school_db.classes.courses_id, school_db.courses.title from school_db.classes
inner join school_db.courses on school_db.courses.course_id = school_db.classes.courses_id;


select * from school_db.classes
right join school_db.lecturers on school_db.classes.lecturer_id = school_db.lecturers.lecturer_id;
 /* Bring back all the lecturers even if classes (class.lecturer) didnt match */
  
 select * from school_db.classes
left join school_db.courses on school_db.classes.courses_id = school_db.courses.course_id;
-- bring records for classes even if..

select 
school_db.courses.course_id,
school_db.courses.title,
school_db.courses.number_of_credits,
school_db.courses.course_code
from school_db.classes
inner join school_db.courses on school_db.courses.course_id = school_db.classes.courses_id
group by school_db.courses.course_id;
/* polacz kolumne classes z kol. courses tam gdzie spelniony warunek id kursu =jest rowne= identyfikat. kursu przydzielonego do klasy
a pod selectem pola jakie maja byc wyswietlone 
group by grupuje po danej kolumnie i usuwa powtorzenia zwiazne z wartoscia tej kolumny */
