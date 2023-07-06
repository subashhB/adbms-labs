-- 1. Find the list of Users that are male or female.
SELECT *
FROM users 
WHERE gender='male'

SELECT *
FROM users 
WHERE gender='female'

SELECT *
FROM users 
WHERE gender='others'

-- 2. Retrive the parents_id, user_id, name, email, mobile_number of all the parents
SELECT p.id, u.id, u.name, u.email, u.mobile_number
FROM parents p INNER JOIN users u ON p.user_id = u.id

-- 3. Retrive the student_id, user_id, name, email, mobile_number of all the students
SELECT s.id, u.id, u.name, u.email, u.mobile_number
FROM students s INNER JOIN users u ON s.user_id = u.id

-- 4. Retrive the teacher_id, user_id, name, email, mobile_number of all the teachers
SELECT t.id, t.user_id, u.name, u.email, u.mobile_number
FROM teachers t INNER JOIN users u ON t.user_id = u.id

-- 5. Find the list of parents with total number childrens 
SELECT psm.parent_id, u.name,COUNT(student_id)
FROM parents_student_maps psm
JOIN parents p on psm.parent_id = p.id
JOIN users u on u.id = p.user_id
GROUP BY psm.parent_id, u.name

-- 6. Find the list of teachers who teach Computer subject(Any subject)
SELECT u.name
FROM teacher_grade_subject_maps tgsm
JOIN teachers t on t.id = tgsm.teacher_id
JOIN users u on u.id = t.user_id
JOIN grade_subject_maps gsm on gsm.id = tgsm.grade_subject_map_id
JOIN subjects s on s.id = gsm.subject_id
WHERE s.name = 'Computer Science'

-- 7. Write a SQL that shows the total merit points of all the students for subject Computer of Class 10.
SELECT s.id as student_id,u.name, SUM(point)
FROM merit_points mp
JOIN students s ON s.id = mp.id
JOIN users u ON u.id = s.user_id
JOIN subjects sb ON sb.id = mp.subject_id
WHERE sb.name = 'Computer Science'
GROUP BY u.name, s.id
;

-- 8. Write a SQL that shows the merit points for all subjects of any student.
SELECT sb.name as subject_name, u.name as student_name, SUM(mp.point) AS total
FROM merit_points mp
JOIN students s ON s.id = mp.student_id
JOIN users u ON u.id = s.user_id
JOIN subjects sb ON sb.id = mp.subject_id
where s.id = 12
GROUP BY sb.name, u.name
ORDER BY sb.name;

-- 9. To simulate a notification event, lets create a notifications table that contains following columns (id, user_device_token, headers, message, deeplink, is_notification_sent, created_at, deleted_at). Create a trigger that inserts data into the notifications table every time a data is added in merit_points table. Use "Merit point update" as header and "Your merit point has been updated by teacher" as body, "https://deeplink.testdeeplink.com/deeplink" as deeplink, false as is_notificat ion_sent.