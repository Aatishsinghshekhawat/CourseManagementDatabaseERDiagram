-- Table: user
CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    email VARCHAR(255) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL
);

-- Table: student
CREATE TABLE student (
    user_id INT PRIMARY KEY,
    FOREIGN KEY (user_id) REFERENCES users(id)
);

-- Table: teacher
CREATE TABLE teacher (
    user_id INT PRIMARY KEY,
    FOREIGN KEY (user_id) REFERENCES users(id)
);

-- Table: admin
CREATE TABLE admin (
    user_id INT PRIMARY KEY,
    FOREIGN KEY (user_id) REFERENCES users(id)
);

-- Table: course
CREATE TABLE course (
    id SERIAL PRIMARY KEY,
    teacher_id INT NOT NULL,
    name VARCHAR(255),
    description TEXT,
    progress_limited BOOLEAN,
    status VARCHAR(50),
    approve_datetime TIMESTAMP,
    FOREIGN KEY (teacher_id) REFERENCES teacher(user_id)
);

-- Table: enrollment
CREATE TABLE enrollment (
    student_id INT NOT NULL,
    course_id INT NOT NULL,
    enrollment_datetime TIMESTAMP NOT NULL,
    completion_date DATE,
    PRIMARY KEY (student_id, course_id),
    FOREIGN KEY (student_id) REFERENCES student(user_id),
    FOREIGN KEY (course_id) REFERENCES course(id)
);

-- Table: test
CREATE TABLE test (
    id SERIAL PRIMARY KEY,
    course_id INT NOT NULL,
    name VARCHAR(255),
    number INT,
    course_order INT,
    min_marks INT,
    is_pass_required BOOLEAN,
    FOREIGN KEY (course_id) REFERENCES course(id)
);

-- Table: test_question
CREATE TABLE test_question (
    id SERIAL PRIMARY KEY,
    test_id INT NOT NULL,
    question_title TEXT,
    FOREIGN KEY (test_id) REFERENCES test(id)
);

-- Table: test_answer
CREATE TABLE test_answer (
    id SERIAL PRIMARY KEY,
    question_id INT NOT NULL,
    answer_text TEXT,
    is_correct BOOLEAN,
    FOREIGN KEY (question_id) REFERENCES test_question(id)
);

-- Table: student_attempt
CREATE TABLE student_attempt (
    student_id INT NOT NULL,
    test_id INT NOT NULL,
    attempt_datetime TIMESTAMP NOT NULL,
    score INT,
    PRIMARY KEY (student_id, test_id, attempt_datetime),
    FOREIGN KEY (student_id) REFERENCES student(user_id),
    FOREIGN KEY (test_id) REFERENCES test(id)
);

-- Table: lesson
CREATE TABLE lesson (
    id SERIAL PRIMARY KEY,
    course_id INT NOT NULL,
    name VARCHAR(255),
    number INT,
    video_url TEXT,
    FOREIGN KEY (course_id) REFERENCES course(id)
);

-- Table: lesson_detail
CREATE TABLE lesson_detail (
    lesson_id INT PRIMARY KEY,
    course_order INT,
    FOREIGN KEY (lesson_id) REFERENCES lesson(id)
);

-- Table: student_lesson
CREATE TABLE student_lesson (
    student_id INT NOT NULL,
    lesson_id INT NOT NULL,
    completion_datetime TIMESTAMP,
    PRIMARY KEY (student_id, lesson_id),
    FOREIGN KEY (student_id) REFERENCES student(user_id),
    FOREIGN KEY (lesson_id) REFERENCES lesson(id)
);