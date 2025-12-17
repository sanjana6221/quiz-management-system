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

---

## ASSUMPTIONS & SCOPE

### Initial Assumptions
1. No User Accounts - Public users take quizzes without registration
2. Admin-Only Creation - Quizzes can only be created by authenticated admins
3. Question Types - Support for multiple choice questions (MCQ, boolean and text)
4. Automatic Scoring - Results calculated immediately upon submission
5. Pass/Fail Threshold - display result
6. Database - PostgreSQL

### Scope Definition
1. Admin sign-in (minimal)
2. Admin creates quiz (single page, dynamic)
3. Public quizzes list (/quizzes)
4. User takes quiz
5. Submit & evaluate
6. Results page
7. Seed data
8. Deployment (optional)

### Approach
1.Rails Best Practices - Use Rails conventions and built-in features
2.Clean Architecture - Separate concerns using Service Objects and Strategy pattern
3.DRY Principle - Eliminate code duplication, use helpers and partials effectively
4.Security First - CSRF protection, bcrypt password hashing, safe lookups
5.Performance - Batch loading, efficient queries, Set-based comparisons


## SCOPE CHANGES DURING IMPLEMENTATION

### 1.Removed Text Question Type
- Original Plan: Support SCQ, MCQ, and Text (open-ended) questions
- Actual Implementation: Only SCQ and MCQ (text type removed)
- Reason: Text answers require manual grading which adds complexity. For a production system focused on automated evaluation, MCQ/SCQ is more practical.

### 2.Removed User Information Collection**
- Original Plan: Collect name from quiz takers
- Actual Implementation: Anonymous submissions (no user data collection)
- Reason: Public users don't have accounts; collecting data adds unnecessary complexity.

### 3. Admin Interface Redesign
- Original Plan: Card-based grid layout for quizzes
- Actual Implementation: Table-based admin interface
- Reason: Tables are better for data-heavy admin interfaces, easier to scan

### 4.Optimized Services Architecture
- Original Plan: Use one evaluator with case statements for question types
- Actual Implementation: Strategy pattern with separate evaluator classes (ScqEvaluator, McqEvaluator)
- Reason: Cleaner, more maintainable, easier to extend with new question type

### 5. Use Uuid instead of Integer IDs
- Original Plan: Create ID as primary keys
- Actual Implementation: Use UUIDs for all primary keys
- Reason: Better scalability and uniqueness across distributed systems

## FUTURE IMPROVEMENTS(If We Had More Time... )

1. Test Suite - Add RSpec tests for services and controllers
2. Quiz Editing - Allow admins to edit quizzes after creation
3. Analytics Dashboard in Admin Panel, showing quiz performance & user stats
4. Pagination for quiz list and submissions
5. Take user information (name, email) before quiz
6. Send mail to user with results over email
7. Shuffle question/option order per user
8. Automated testing and deployment using CI/CD pipelines
9. Enable/Add performance monitoring like New Relic
10. Two factor authentication for admin users