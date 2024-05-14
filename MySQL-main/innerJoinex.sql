select distinct courses_id from school_db.classes
group by courses_id;


select school_db.courses.course_id, school_db.courses.title, school_db.courses.number_of_credits, school_db.courses.course_code from school_db.classes
inner join school_db.courses on school_db.classes.courses_id = school_db.courses.course_id
group by school_db.courses.course_id, school_db.courses.title, school_db.courses.number_of_credits, school_db.courses.course_code;


select school_db.classes.id, school_db.students.first_name, school_db.lecturers.first_name from school_db.enrollment
inner join school_db.classes on school_db.classes.id = school_db.enrollment.class_id
inner join school_db.students on school_db.students.id = school_db.enrollment.student_id
inner join school_db.lecturers on school_db.lecturers.lecturer_id = school_db.classes.lecturer_id;

/* wyieramy pola do laczenia, kazde z pol laczymy inner joinem z polem z ktorym wystepuje odpowiadajcy klucz obcy */

 use school_db;
 select courses.title, avg(enrollment.grade) from school_db.enrollment
 inner join classes on classes.id = enrollment.id
 inner join courses on courses.course_id = enrollment.class_id
 group by courses.title;
 
select school_db.lecturers.first_name, school_db.courses.title from school_db.classes
inner join school_db.lecturers on school_db.lecturers.lecturer_id = school_db.classes.lecturer_id
inner join school_db.courses on school_db.courses.course_id = school_db.classes.courses_id;

select school_db.courses.title, school_db.classes.time, (school_db.enrollment.student_id) /*,school_db.lecturers.first_name*/ from school_db.enrollment
inner join school_db.classes on school_db.enrollment.class_id = school_db.classes.id
inner join school_db.courses on school_db.courses.course_id = school_db.classes.courses_id
-- inner join school_db.lecturers on school_db.lecturers.lecturer_id = school_db.classes.id
group by school_db.classes.id;
/*lecturer can be inner join becuae clasess table has been already joined */

select count(school_db.students.id), school_db.courses.title from school_db.enrollment
inner join school_db.students on school_db.students.id = school_db.enrollment.student_id
inner join school_db.classes on school_db.classes.id = school_db.enrollment.class_id
inner join school_db.courses on school_db.courses.course_id = school_db.classes.courses_id
group by school_db.courses.course_id;

select count(school_db.students.id), school_db.courses.title from school_db.enrollment
inner join school_db.classes on school_db.classes.id = school_db.enrollment.class_id
inner join school_db.students on school_db.students.id = school_db.enrollment.student_id
inner join school_db.courses on school_db.courses.course_id = school_db.classes.courses_id
group by school_db.courses.title;

select class_id,min(grade), max(grade) from school_db.enrollment
group by class_id
having min(grade)>50;

use school_db;
select concat(students.last_name, ',',students.first_name) 'Student Name',
sum(courses.number_of_credits) 'credits'
from enrollment
inner join students on students.id = enrollment.student_id
inner join classes on classes.id = enrollment.class_id
inner join courses on courses.course_id = classes.courses_id
group by students.id
-- having sum(courses.number_of_credits) = 3










