from faker import Faker
import psycopg2

def get_database_connection():
    db_connection = psycopg2.connect(
        dbname = 'test',
        user = 'postgres',
        password='12345678',
        host = 'localhost',
        port = 5432,
    )
    return db_connection

def insert_to_user_table(cursor, fake):
    import random
    gender = ['male', 'female', 'others']
    first_name = fake.first_name()
    last_name = fake.last_name()
    company = fake.company().split()[0].strip(',')
    dns_org = 'com'
    email = f"{first_name}.{last_name}@{company}.{dns_org}".lower()
    random_dob = fake.date_between(start_date='today', end_date='+30y')

    insert_sql = f"""insert into users(email, name, gender, dob, mobile_number, password, created_at, updated_at) values ( '{ email }', '{ first_name+last_name }', '{ random.choice(gender) }', TO_DATE('YYYY-MM_DD', '{ str(fake.date_between(start_date='today', end_date='+30y'))}'), '9841{random.randint(100000,999999)}', 'test@123', now(), now() )"""
    print(insert_sql)
    cursor.execute(insert_sql)
    print('SQL exedcuted')

def insert_to_user_device_token_table(cursor, fake):
    import random
    import uuid
    user_id = random.randint(1,1000)
    device_token = uuid.uuid4()
    insert_sql = f"""insert into user_device_tokens(user_id, device_token, created_at, update_at) values ('{ user_id }', '{ device_token }', now(), now())"""
    print(insert_sql)
    cursor.execute(insert_sql)
    print('SQL executed')

#function to generate data for name_char column of grades table for correspoding class name
def get_grades_char(num):
    if(num == 1):
        return 'One'
    elif(num == 2):
        return 'Two'
    elif(num == 3):
        return 'Three'
    elif(num == 4):
        return 'Four'
    elif(num == 5):
        return 'Five'
    elif(num == 6):
        return 'Six'
    elif(num == 7):
        return 'Seven'
    elif(num == 8):
        return 'Eight'
    elif(num == 9):
        return 'Nine'
    elif(num == 10):
        return 'Ten'
    else:
        return 'N/A'

def insert_to_grades_table(cursor):
    import random
    for i in range(1, 11):
        insert_sql = f"""insert into grades(name, name_char, section, created_at, updated_at) values('{ str(i) }', '{ get_grades_char(i) }','{ str(random.randint(1,5)) }', now(), now() )"""
        print(insert_sql)
        cursor.execute(insert_sql)
    print('SQL executed.')

def insert_to_students_table(cursor):
    import random
    user_ids = random.sample(range(101, 551),450)
    for user_id in zip(user_ids):
        user_id, = user_id
        grade_id = random.randint(1,10)
        insert_sql = f"""insert into students(user_id, grade_id, created_at, updated_at) values('{ user_id }','{ grade_id }',now(),now())"""
        cursor.execute(insert_sql)
        print(insert_sql)
    print('SQL executed')

def insert_to_teachers_table(cursor):
    import random 
    user_ids = random.sample(range(1,101), 100)
    for user_id in zip(user_ids):
        user_id, = user_id
        insert_sql = f"""insert into teachers(user_id, created_at, updated_at) values('{ user_id }',now(), now()) """
        print(insert_sql)
        cursor.execute(insert_sql)
    print("SQL executed")

def insert_to_parents_table(cursor):
    import random
    user_ids = random.sample(range(451,1001), 450)
    for user_id in zip(user_ids):
        user_id, = user_id
        insert_sql = f"""insert into parents(user_id, created_at, updated_at) values('{ user_id }',now(),now())"""
        print(insert_sql)
        cursor.execute(insert_sql)
    print("SQL executed")

def insert_to_parents_students_maps(cursor):
    import random
    student_ids = random.sample(range(1, 451), 450)
    parents_ids = random.sample(range(1, 451), 450)

    for student_id, parent_id in zip(student_ids, parents_ids):
        insert_sql = f"""insert into parents_student_maps(student_id, parent_id, created_at, updated_at) values('{ student_id }','{ parent_id }', now(), now()) """
        print(insert_sql)
        cursor.execute(insert_sql)
    print("SQL executed")

def insert_to_subject_table(cursor):
    subjects = ['English', 'Nepali', 'Social Studies', 'English Grammar', 'Nepali Byakaran', 'General Knowledge', 'Computer Science', 'Mathematics', 'Accounts', 'Science', ]
    for subject in zip(subjects):
        subject, = subject
        insert_sql = f"""insert into subjects(name, created_at, updated_at) values('{ subject }', now(), now())"""
        print(insert_sql)
        cursor.execute(insert_sql)
    print("SQL executed")

def insert_to_grade_subject_maps(cursor):
    import random
    for i in range(1,11):
        subject_id = []
        if(i <= 5):
            subject_ids = [1,2,3,4,5,6,8,10]
        elif(i >= 6 and i <= 8): 
            subject_ids = [1,2,3,4,5,8,10]
        elif(i >= 8 and i < 11):
            subject_ids = [1,2,3,4,5,7,8,9,10]
        else:
            subject_id = []
        for subject_id in subject_ids:
            insert_sql = f"""insert into grade_subject_maps(grade_id, subject_id, created_at, updated_at) values('{ i }','{ subject_id }',now(),now()) """
            print(insert_sql)
            cursor.execute(insert_sql)
    print("SQL executed")

def insert_to_teacher_grade_subject_maps(cursor):
    import random
    for i in range(1,80):
        teacher_id = random.randint(1,100)
        insert_sql = f"""insert into teacher_grade_subject_maps(teacher_id, grade_subject_map_id, created_at, updated_at) values('{ teacher_id }','{ i }', now(), now()) """
        print(insert_sql)
        cursor.execute(insert_sql)
    print("SQL executed")

def get_remarks(point):
    import random
    choice = random.randint(1,5)
    remark = ''
    if(point < 0):
        if(choice == 1):
            remark = 'Late Assignment Submission'
        elif(choice == 2):
            remark = 'Disciplinary Code Breached: Fighting'
        elif(choice == 3):
            remark = "Forged Signature of Respective Teacher"
        elif(choice == 4):
            remark = "Forged Signature of Parent"
        elif(choice == 5):
            remark = "Absent WIthout Prior Notice: Bunk"
        else:
            remark = "- Negative choice error"
    elif(point > 0):
        if(choice == 1):
            remark = 'Good Performance in Test.'
        elif(choice == 2):
            remark = 'Submitted Assignment Timely.'
        elif(choice == 3):
            remark = "Good Performance in Classroom activites."
        elif(choice == 4):
            remark = "Assisted Others to complete their work."
        elif(choice == 5):
            remark = "100% Attendance Record"
        else:
            remark = "- Positive choice error"
    else: 
        remark = "Point Error"
    return remark


# ! Please note that for now the teacher who aren't teaching that subject is able to give merit point which shouldn't be the case. But I decided not to over-engineer this and proceed with the random values
def insert_to_merit_points(cursor):
    import random
    teacher_id = random.randint(1,100)
    subject_id = random.randint(1,10)
    student_id = random.randint(1,450)
    terminal = random.randint(1,3)
    point = random.randint(-5,5)
    while point == 0:
        point = random.randint(-5,5)

    insert_sql = f""" insert into merit_points(teacher_id, subject_id, student_id, point, remarks, terminal, created_at, updated_at) values('{ teacher_id }','{ subject_id }','{ student_id }','{ point }','{ get_remarks(point) }','{ terminal }',now(), now()) """
    print(insert_sql)
    cursor.execute(insert_sql)
    



    

#Starting our inserting data script
conn = get_database_connection()
fake = Faker()

#inserting 1000 random data for users table
def insert_data_into_users():
    for i in range (0,1000):
        insert_to_user_table(conn.cursor(), fake)
        conn.commit()

#inserting 1000 random data for user device token table
def insert_data_into_user_device_token():
    for i in range(0, 1000):
        insert_to_user_device_token_table(conn.cursor(), fake)
        conn.commit()

#inserting data for grades table
def insert_data_into_grades():
    insert_to_grades_table(conn.cursor())
    conn.commit()

#inserting data for student table
def insert_data_into_students():
    insert_to_students_table(conn.cursor())
    conn.commit()

#inserting data for teachers table
def insert_data_into_teachers():
    insert_to_teachers_table(conn.cursor())
    conn.commit()

#inserting data for parents table
def insert_data_into_parents():
    insert_to_parents_table(conn.cursor())
    conn.commit()

#inserting data for parents student maps table
def insert_data_into_parents_students_maps():
    insert_to_parents_students_maps(conn.cursor())
    conn.commit()

#inserting data for subjects table
def insert_data_into_subjects():
    insert_to_subject_table(conn.cursor())
    conn.commit()

#inserting data for grades subject maps table
def insert_data_into_grade_subject_maps():
    insert_to_grade_subject_maps(conn.cursor())
    conn.commit()

#inserting data for teacher grades subject map table
def insert_data_into_teacher_grade_subject_maps():
    insert_to_teacher_grade_subject_maps(conn.cursor())
    conn.commit()

def insert_data_into_merit_points_table():
    for _ in range (1000):
        insert_to_merit_points(conn.cursor())
        conn.commit()
    print("SQL executed")



# insert_data_into_users()
# insert_data_into_user_device_token()
# insert_data_into_grades()
# insert_data_into_students()
# insert_data_into_teachers()
# insert_data_into_parents()
# insert_data_into_parents_students_maps()
# insert_data_into_subjects()
# insert_data_into_grade_subject_maps()
# insert_data_into_teacher_grade_subject_maps()
insert_data_into_merit_points_table()

conn.close()
