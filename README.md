# Quiz Management System

A production-ready Rails 8 quiz management system with admin panel and public quiz interface. Featuring session-based authentication, dynamic form fields and comprehensive result evaluation using the Strategy pattern.

## Features

### Admin Features
- **Quiz Management**: Create, read, and delete quizzes
- **Question Management**: Add multiple questions (Single Choice & Multiple Choice) with dynamic form fields
- **Answer Options**: Define correct/incorrect answer options with visual indicators
- **Admin Dashboard**: Table view of quizzes with quick actions
- **Session Authentication**: Secure login/logout system

### Public Features
- **Quiz Listing**: Browse all available quizzes
- **Quiz Taking**: Interactive quiz interface with SCQ (Single Choice) and MCQ (Multiple Choice) questions
- **Answer Submission**: Submit all answers with validation
- **Results Display**: Instant score, pass/fail indicator

### Question Types
- **SCQ (Single Choice Questions)**: Radio buttons, one correct answer
- **MCQ (Multiple Choice Questions)**: Checkboxes, multiple correct answers required

## Getting Started

### Prerequisites
- Ruby 3.2+
- Rails 8.1+
- sqlite3

### Installation

1. **Install dependencies**
   ```bash
   bundle install
   ```

2. **Setup database**
   ```bash
   bundle exec rails db:create
   bundle exec rails db:migrate
   bundle exec rails db:seed
   ```

3. **Start the server**
   ```bash
   bundle exec rails server
   ```

Visit http://localhost:3000 to access the application.

### Default Admin Credentials
- **Email**: `admin@example.com`
- **Password**: `password123`

## Usage Guide

### For Quiz Takers
1. Visit http://localhost:3000
2. Browse available quizzes
3. Click "Take Quiz" on any quiz
4. Answer all questions (both SCQ and MCQ types)
5. Click "Submit Quiz"
6. View your results with score and pass/fail status

### For Admins
1. Go to http://localhost:3000/admin/login
2. Login with admin credentials
3. Navigate to "Quizzes" to manage quizzes
4. Create new quizzes and add questions
5. Define correct/incorrect options for each question
6. View submissions and analytics

## Architecture

### Design Patterns
- **Strategy Pattern**: Answer evaluators for different question types (ScqEvaluator, McqEvaluator)
- **Service Objects**: AnswerProcessor and ResultsCalculator for business logic
- **Factory Pattern**: Evaluator dispatcher routes to correct evaluator based on question type

## Security

- CSRF protection (Rails default)
- Password hashing with bcrypt
- Strong parameter filtering
- Session-based authentication
- Admin-only access to management features
- Safe database lookups (find_by instead of find)

## Quiz Scoring

- Percentage-based scoring
- 70% pass threshold
- SCQ: Correct if selected option is marked correct
- MCQ: Correct only if ALL correct options are selected (complete match required)

## Performance

- Minimal N+1 query problems
- UUID support for distributed systems


