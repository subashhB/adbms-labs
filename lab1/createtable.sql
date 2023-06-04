CREATE TABLE users(
	id SERIAL primary key,
	email varchar(50) NOT NULL,
	name varchar(30) NOT NULL,
	gender varchar(10),
	dob DATE NOT NULL,
	mobile_number varchar(10),
	password varchar(50) NOT NULL,
	is_admin boolean,
	is_teacher boolean,
	is_parent boolean,
	is_student boolean,
	is_active boolean,
	created_at TIMESTAMP NOT NULL,
	updated_at TIMESTAMP NOT NULL
	
);

CREATE TABLE user_devive_token(
	id SERIAL primary key,
	device_token varchar(100),
	created_at TIMESTAMP NOT NULL,
	update_at TIMESTAMP NOT NULL,
	user_id int,
	CONSTRAINT fk_users_user_device_tokens FOREIGN KEY(user_id)
	REFERENCES users(id)
);

CREATE TABLE grades(
	id SERIAL primary key,
	name varchar(10),
	name_char varchar(20),
	section varchar(5),
	created_at TIMESTAMP NOT NULL,
	updated_at TIMESTAMP NOT NULL
);

CREATE TABLE students(
	id SERIAL primary key,
	user_id int,
	grade_id int,
	created_at TIMESTAMP NOT NULL,
	updated_at TIMESTAMP NOT NULL,
	CONSTRAINT fk_students_grades FOREIGN KEY(grade_id) REFERENCES grades(id),
	CONSTRAINT fk_students_users FOREIGN KEY(user_id) REFERENCES users(id)
);

CREATE TABLE teachers (
	id SERIAL primary key,
	user_id int,
	created_at TIMESTAMP NOT NULL,
	updated_at TIMESTAMP NOT NULL,
	CONSTRAINT fk_teachers_users FOREIGN KEY(user_id) REFERENCES users(id)
);


CREATE TABLE parents (
	id SERIAL primary key,
	user_id int,
	created_at TIMESTAMP NOT NULL,
	updated_at TIMESTAMP NOT NULL,
	CONSTRAINT fk_parents_users FOREIGN KEY(user_id) REFERENCES users(id)
);

CREATE TABLE parent_student_maps (
	id SERIAL primary key,
	student_id int,
	parent_id int,
	created_at TIMESTAMP NOT NULL,
	updated_at TIMESTAMP NOT NULL,
	CONSTRAINT fk_parent_student_maps_students FOREIGN KEY(student_id) REFERENCES students(id),
	CONSTRAINT fk_parent_student_maps_parents FOREIGN KEY(parent_id) REFERENCES parents(id)
);

CREATE TABLE subjects (
	id SERIAL primary key,
	name varchar(50),
	created_at TIMESTAMP NOT NULL,
	updated_at TIMESTAMP NOT NULL
);

CREATE TABLE grade_subject_maps (
	id SERIAL primary key,
	grade_id int, 
	subject_id int,
	created_at TIMESTAMP NOT NULL,
	updated_at TIMESTAMP NOT NULL,
	CONSTRAINT fk_grade_subject_maps_grades FOREIGN KEY(grade_id) REFERENCES grades(id),
	CONSTRAINT fk_grade_subject_maps_subjects FOREIGN KEY(subject_id) REFERENCES subjects(id)
)


CREATE TABLE teacher_grade_subject_maps (
	id SERIAL primary key,
	teacher_id int,
	grade_subject_map_id int,
	created_at TIMESTAMP NOT NULL,
	updated_at TIMESTAMP NOT NULL,
	CONSTRAINT fk_teacher_grade_subject_maps_teacher FOREIGN KEY(teacher_id) REFERENCES teachers(id),
	CONSTRAINT fk_teacher_grade_subject_maps_hrade_subject_maps FOREIGN KEY(grade_subject_map_id) REFERENCES grade_subject_maps(id)
);


CREATE TABLE merit_points (
	id SERIAL primary key,
	teacher_id int,
	subject_id int,
	student_id int,
	point int,
	remark varchar(50),
	terminal int,
	created_at TIMESTAMP NOT NULL,
	updated_at TIMESTAMP NOT NULL,
	CONSTRAINT fk_merit_points_teachers FOREIGN KEY(teacher_id) REFERENCES teachers(id),
	CONSTRAINT fk_merit_points_students FOREIGN KEY (student_id) REFERENCES students(id),
	CONSTRAINT fk_merit_points_subjects FOREIGN KEY (subject_id) REFERENCES subjects(id)
);
