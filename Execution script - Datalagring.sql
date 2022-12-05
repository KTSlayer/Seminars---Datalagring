  --Task 1

SET STATISTICS TIME ON; 
 
  select
  datepart (YEAR, lesson_period) AS Year,
  datepart (month, lesson_period) AS Month,
  count (sa.lesson_id) as Lessons,
  count (e.lesson_id) as Ensembles,
  count (g.lesson_id) as Group_lesson,
  count (i.lesson_id) as Individual
  from Schedule_and_appointments as sa
  left join Ensemble as e on sa.lesson_id = e.lesson_id
  left join group_lesson as g on sa.lesson_id = g.lesson_id
  left join Individual as i on sa.lesson_id = i.lesson_id
  where lesson_period between 'jan 1, 2022' and 'jan 1, 2023'
  group by
  datepart(month, lesson_period),
  datepart(year, lesson_period)

SET STATISTICS TIME OFF; 

  --Task 2

  SET STATISTICS TIME ON; 

  select s.id, s.person_number, s.name,
  count(Siblings.student_id) as siblings
  from Student as s
  left join Siblings on Siblings.student_id = s.id
  group by s.id, s.person_number, s.name
  order by siblings desc

  SET STATISTICS TIME OFF;

  --Task 3

  SET STATISTICS TIME ON; 

  select i.id, i.person_number, i.name,
  count (lesson.instructor_id) as Lessons,
  count (Ensemble.lesson_id) as Ensemble,
  count (Group_lesson.lesson_id) as Group_lesson,
  count (Individual.lesson_id) as Individual
  from Instructor as i
  left join Lesson on i.id = Lesson.instructor_id
  left join Ensemble on ensemble.lesson_id = Lesson.id
  left join Group_lesson on group_lesson.lesson_id = Lesson.id
  left join Individual on Individual.lesson_id = Lesson.id
  left join Schedule_and_appointments as sa on sa.lesson_id = Lesson.id
  where sa.lesson_period between 'jan 1, 2022' and 'jan 31, 2022'
  group by i.id, i.person_number, i.name
  order by Lessons desc

  SET STATISTICS TIME OFF; 

  --Task 4

  SET STATISTICS TIME ON; 

	  select  lesson.id,Ensemble.genre, sa.lesson_period, Lesson.maximum_students,
	  count (sl.lesson_id) as Students_registered,
	  case 
			when maximum_students - count (sl.lesson_id) >= 0 
				then maximum_students - count (sl.lesson_id)
			else 'ERROR'
			end as Available_seats
	  from Lesson
	  left join Student_lesson as sl on sl.lesson_id = Lesson.id
	  left join Ensemble on Ensemble.lesson_id = Lesson.id
	  left join Schedule_and_appointments as sa on sa.lesson_id = Lesson.id
	  where lesson.id = Ensemble.lesson_id and sa.lesson_period between 'jan 21, 2022' and 'jan 28, 2022'
	  group by Lesson.id, Ensemble.genre, sa.lesson_period, Lesson.maximum_students
	  order by genre

  SET STATISTICS TIME OFF; 