-- StudyNest database schema (one database for all services)

CREATE DATABASE IF NOT EXISTS studynest_db;
USE studynest_db;

CREATE TABLE IF NOT EXISTS tbl_users (
    user_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(150) NOT NULL UNIQUE,
    password_hash VARCHAR(255) NOT NULL
);

CREATE TABLE IF NOT EXISTS tbl_subjects (
    subject_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT NOT NULL,
    subject_name VARCHAR(100) NOT NULL,
    description VARCHAR(500),
    FOREIGN KEY (user_id) REFERENCES tbl_users(user_id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS tbl_study_sessions (
    session_id INT PRIMARY KEY AUTO_INCREMENT,
    subject_id INT NOT NULL,
    start_time DATETIME NOT NULL,
    end_time DATETIME NOT NULL,
    duration_minutes INT NOT NULL,
    notes VARCHAR(1000),
    FOREIGN KEY (subject_id) REFERENCES tbl_subjects(subject_id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS tbl_study_tasks (
    task_id INT PRIMARY KEY AUTO_INCREMENT,
    subject_id INT NOT NULL,
    title VARCHAR(150) NOT NULL,
    due_date DATE,
    is_completed BOOLEAN NOT NULL DEFAULT FALSE,
    FOREIGN KEY (subject_id) REFERENCES tbl_subjects(subject_id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS tbl_study_goals (
    goal_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT NOT NULL UNIQUE,
    daily_target_minutes INT NOT NULL DEFAULT 0,
    weekly_target_minutes INT NOT NULL DEFAULT 0,
    FOREIGN KEY (user_id) REFERENCES tbl_users(user_id) ON DELETE CASCADE
);

--Dummy Values

USE studynest_db;

--(if something goes wrong, clear the tables first)
DELETE FROM tbl_study_sessions;
DELETE FROM tbl_study_tasks;
DELETE FROM tbl_study_goals;
DELETE FROM tbl_subjects;
DELETE FROM tbl_users;

-- Users
INSERT INTO tbl_users (user_id, name, email, password_hash) VALUES
(1, 'Gaveen', 'gaveen@example.com', '123'),
(2, 'Mona',   'mona@example.com',   '456'),
(3, 'Lily',   'lily@example.com',   '789');

-- Subjects
INSERT INTO tbl_subjects (subject_id, user_id, subject_name, description) VALUES
(1, 1, 'Software Engineering', 'Lectures, UML and project work'),
(2, 1, 'Database Systems',     'SQL, ER diagrams and normalization'),
(3, 1, 'Web Development',      'React, TypeScript and REST APIs'),
(4, 1, 'Mathematics',          'Discrete maths revision'),
(5, 2, 'Networking',           'TCP/IP and subnetting'),
(6, 2, 'Java Programming',     'OOP and Spring Boot');

-- Study sessions (dates are relative to today, so summaries always have data)
INSERT INTO tbl_study_sessions (session_id, subject_id, start_time, end_time, duration_minutes, notes) VALUES
(1,  1, TIMESTAMP(CURDATE(),                       '16:00:00'), TIMESTAMP(CURDATE(),                       '17:30:00'), 90,  'Reviewed use case diagrams'),
(2,  2, TIMESTAMP(CURDATE(),                       '19:00:00'), TIMESTAMP(CURDATE(),                       '19:45:00'), 45,  'Practised joins'),
(3,  3, TIMESTAMP(CURDATE() - INTERVAL 1 DAY,      '10:00:00'), TIMESTAMP(CURDATE() - INTERVAL 1 DAY,      '11:00:00'), 60,  'React components'),
(4,  1, TIMESTAMP(CURDATE() - INTERVAL 2 DAY,      '15:00:00'), TIMESTAMP(CURDATE() - INTERVAL 2 DAY,      '16:15:00'), 75,  NULL),
(5,  4, TIMESTAMP(CURDATE() - INTERVAL 3 DAY,      '20:00:00'), TIMESTAMP(CURDATE() - INTERVAL 3 DAY,      '20:30:00'), 30,  'Set theory'),
(6,  2, TIMESTAMP(CURDATE() - INTERVAL 4 DAY,      '09:00:00'), TIMESTAMP(CURDATE() - INTERVAL 4 DAY,      '10:30:00'), 90,  'ER diagram practice'),
(7,  3, TIMESTAMP(CURDATE() - INTERVAL 5 DAY,      '14:00:00'), TIMESTAMP(CURDATE() - INTERVAL 5 DAY,      '16:00:00'), 120, 'Built the login page'),
(8,  5, TIMESTAMP(CURDATE(),                       '18:00:00'), TIMESTAMP(CURDATE(),                       '19:00:00'), 60,  'Subnetting exercises'),
(9,  6, TIMESTAMP(CURDATE() - INTERVAL 1 DAY,      '17:00:00'), TIMESTAMP(CURDATE() - INTERVAL 1 DAY,      '18:30:00'), 90,  'Spring Boot controllers');

-- Study tasks
INSERT INTO tbl_study_tasks (task_id, subject_id, title, due_date, is_completed) VALUES
(1, 1, 'Finish use case diagram',        CURDATE() - INTERVAL 1 DAY, TRUE),
(2, 2, 'Submit SQL practice sheet',      CURDATE() + INTERVAL 2 DAY, FALSE),
(3, 3, 'Build the subjects page',        CURDATE() + INTERVAL 4 DAY, FALSE),
(4, 4, 'Revise chapters 1 to 3',         CURDATE() + INTERVAL 7 DAY, FALSE),
(5, 3, 'Set up React project',           CURDATE() - INTERVAL 3 DAY, TRUE),
(6, 5, 'Complete subnetting worksheet',  CURDATE() + INTERVAL 3 DAY, FALSE),
(7, 6, 'Read Spring Boot chapter',       NULL,                       FALSE);

-- Study goals (one row per user)
INSERT INTO tbl_study_goals (goal_id, user_id, daily_target_minutes, weekly_target_minutes) VALUES
(1, 1, 120, 600),
(2, 2, 90,  450),
(3, 3, 60,  300);

SELECT * FROM tbl_study_goals;

SHOW TABLES;