Database Design:
1. TableName - admin_users(Used only to protect the admin panel)

Fields:
    id (uuid, PK)
    email (string, unique, not null)
    password_digest (string, not null)
    created_at
    updated_at

---
2. TableName - quizzes(Top-level entity)

Fields:
    id (uuid, PK)
    title (string, not null)
    description (text, nullable)
    created_at
    updated_at

Associations:
    has_many :questions
    has_many :submissions

---
3. TableName - questions(Belongs to a quiz and defines its type)

Fields:
    id (uuid, PK)
    quiz_id (uuid, FK → quizzes.id)
    body (text, not null)
    question_type (string, not null)
    created_at
    updated_at
    ------
Notes:
    question_type values (mcq | scq)
    mcq - multiple choice question (multiple correct answers possible)
    scq - single choice question (only one correct answer)

---
4. TableName - options(Only used for MCQ and Boolean questions)

Fields:
    id (uuid, PK)
    question_id (uuid, FK → questions.id)
    text (string, not null)
    correct (boolean, default: false)
    created_at
    updated_at
    
---
5. TableName - submissions(Represents one quiz attempt by a public user)

Fields:
    id (uuid, PK)
    quiz_id (uuid, FK → quizzes.id)
    score (integer)
    total_questions (integer)
    created_at
    updated_at

---
6. TableName - attempt_answers(Stores user answers for each question in a submission)

Fields:
    id (uuid, PK)
    submission_id (uuid, FK → submissions.id)
    question_id (uuid, FK → questions.id)
    selected_option_ids (integer[], nullable)
    correct (boolean)
    created_at
    updated_at

