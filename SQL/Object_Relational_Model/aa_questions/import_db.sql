DROP TABLE IF EXISTS question_likes;
DROP TABLE IF EXISTS question_follows;
DROP TABLE IF EXISTS replies;
DROP TABLE IF EXISTS questions;
DROP TABLE IF EXISTS users;

PRAGMA foreign_keys = ON;


--USERS TABLE 
CREATE TABLE users (
    id INTEGER PRIMARY KEY, 
    fname VARCHAR(255) NOT NULL, 
    lname VARCHAR(255) NOT NULL
); 

INSERT INTO 
    users (fname, lname)
VALUES 
    ('Jake', 'Shapiro'),
    ('Ann', 'West'),
    ('Mary', 'Madison');



--QUESTIONS TABLE 
CREATE TABLE questions (
    id INTEGER PRIMARY KEY,
    title VARCHAR(255) NOT NULL, 
    body TEXT NOT NULL,
    author INTEGER NOT NULL, 

    FOREIGN KEY (author) REFERENCES users(id)
);

INSERT INTO 
    questions (title, body, author)
VALUES 
    ('Jake Question', 'Jake Jake Jake', (SELECT id FROM users WHERE fname = 'Jake' AND lname = 'Shapiro')),
    ('Ann Question', 'Ann Ann Ann', (SELECT id FROM users WHERE fname = 'Ann' AND lname = 'West')),
    ('Mary Question', 'Mary Mary Mary', (SELECT id FROM users WHERE fname = 'Mary' AND lname = 'Madison'));



--QUESTION_FOLLOWS TABLE 
CREATE TABLE question_follows ( 
    id INTEGER PRIMARY KEY, 
    user_id INTEGER NOT NULL, 
    question_id INTEGER NOT NULL, 

    FOREIGN KEY (user_id) REFERENCES users(id), 
    FOREIGN KEY (question_id) REFERENCES questions(id) 
);

INSERT INTO 
    question_follows (user_id, question_id)
VALUES 
    ((SELECT id FROM users WHERE fname = 'Jake' AND lname = 'Shapiro'), (SELECT id FROM questions WHERE title = 'Jake Question')), 
    ((SELECT id FROM users WHERE fname = 'Jake' AND lname = 'Shapiro'), (SELECT id FROM questions WHERE title = 'Ann Question')), 
    ((SELECT id FROM users WHERE fname = 'Jake' AND lname = 'Shapiro'), (SELECT id FROM questions WHERE title = 'Mary Question')), 
    ((SELECT id FROM users WHERE fname = 'Ann' AND lname = 'West'), (SELECT id FROM questions WHERE title = 'Ann Question')),
    ((SELECT id FROM users WHERE fname = 'Ann' AND lname = 'West'), (SELECT id FROM questions WHERE title = 'Mary Question')),
    ((SELECT id FROM users WHERE fname = 'Mary' AND lname = 'Madison'), (SELECT id FROM questions WHERE title = 'Mary Question'));



--QUESTION LIKES TABLE 
CREATE TABLE question_likes (
    id INTEGER PRIMARY KEY, 
    user_id INTEGER NOT NULL, 
    question_id INTEGER NOT NULL, 

    FOREIGN KEY (user_id) REFERENCES users(id), 
    FOREIGN KEY (question_id) REFERENCES questions(id) 
);

INSERT INTO 
    question_likes (user_id, question_id)
VALUES 
    ((SELECT id FROM users WHERE fname = 'Jake' AND lname = 'Shapiro'), (SELECT id FROM questions WHERE title = 'Jake Question')), 
    ((SELECT id FROM users WHERE fname = 'Jake' AND lname = 'Shapiro'), (SELECT id FROM questions WHERE title = 'Ann Question')), 
    ((SELECT id FROM users WHERE fname = 'Ann' AND lname = 'West'), (SELECT id FROM questions WHERE title = 'Ann Question')),
    ((SELECT id FROM users WHERE fname = 'Mary' AND lname = 'Madison'), (SELECT id FROM questions WHERE title = 'Mary Question'));



--REPLIES TABLE 
CREATE TABLE replies ( 
    id INTEGER PRIMARY KEY, 
    question_id INTEGER NOT NULL,
    parent_reply_id INTEGER, 
    author_id INTEGER NOT NULL, 
    body TEXT NOT NULL, 

    FOREIGN KEY (question_id) REFERENCES questions(id), 
    FOREIGN KEY (parent_reply_id) REFERENCES replies(id), 
    FOREIGN KEY (author_id) REFERENCES users(id) 
);

INSERT INTO 
    replies (question_id, parent_reply_id, author_id, body)
VALUES 
    (
        (SELECT id FROM questions WHERE title = 'Jake Question'), 
        NULL,
        (SELECT id FROM users WHERE fname = 'Ann' AND lname = 'West'), 
        'Ann Reply to Jake Question' 
    );

INSERT INTO 
    replies (question_id, parent_reply_id, author_id, body)
VALUES
    (
        (SELECT id FROM questions WHERE title = 'Jake Question'), 
        (SELECT 
            replies.id 
         FROM 
            replies
         JOIN
            questions ON replies.question_id = questions.id 
         WHERE 
            parent_reply_id IS NULL AND title = 'Jake Question'
        ),
        (SELECT id FROM users WHERE fname = 'Mary' AND lname = 'Madison'),
        'Mary Reply to Jake Question'
    );

INSERT INTO 
    replies (question_id, parent_reply_id, author_id, body)
VALUES
    (
        (SELECT id FROM questions WHERE title = 'Ann Question'), 
        NULL,
        (SELECT id FROM users WHERE fname = 'Jake' AND lname = 'Shapiro'), 
        'Jake Reply to Ann Question' 
    );

INSERT INTO 
    replies (question_id, parent_reply_id, author_id, body)
VALUES 
    (
        (SELECT id FROM questions WHERE title = 'Ann Question'), 
        (SELECT 
            replies.id 
         FROM 
            replies
         JOIN
            questions ON replies.question_id = questions.id 
         WHERE 
            parent_reply_id IS NULL AND title = 'Ann Question'
        ),
        (SELECT id FROM users WHERE fname = 'Ann' AND lname = 'West'),
        'Ann Reply to Ann Question'
    );

INSERT INTO 
    replies (question_id, parent_reply_id, author_id, body)
VALUES 
    (
        (SELECT id FROM questions WHERE title = 'Mary Question'), 
        NULL,
        (SELECT id FROM users WHERE fname = 'Jake' AND lname = 'Shapiro'), 
        'Jake Reply to Mary Question' 
    );




