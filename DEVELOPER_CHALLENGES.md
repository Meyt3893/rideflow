# Developer Technical Assessment

This document contains real-world bug reports from users. Your task is to investigate, identify the root cause, and fix each issue.

**Important**: These are vague bug reports, just like real users would submit. You need to understand the system before you can fix it.

---

## Challenge 1: "Where did the rides go?"

**From:** Sarah (Operations)

> "Hey, I'm looking at yesterday's rides but I can only see a few of them. I know we had more. Can you check?"

---

## Challenge 2: "Form is broken"

**From:** Mike (Support)

> "A customer just called saying the booking form doesn't work. They clicked submit and nothing happened."

---

## Challenge 3: "Wrong car"

**From:** Customer email

> "This is the second time I got a different car than I ordered. Please fix this."

---

## Challenge 4: "Confusing dashboard"

**From:** Driver WhatsApp

> "The app shows I have a ride but when I called the customer they said they cancelled it. What's going on?"

---

## Important Notes

- The database has been seeded with test data (11 bookings with various statuses)
- Some rides should NOT appear in the list (deleted rides) - this is correct behavior
- Your job is to figure out what's wrong, not just blindly show everything

---

## Evaluation Criteria

1. **Investigation Process** - How do you approach debugging?
2. **Understanding the System** - Can you trace data flow from database → API → frontend?
3. **Root Cause Analysis** - Did you find the actual cause, or just patch symptoms?
4. **Solution Quality** - Is your fix clean? Does it break anything else?
5. **Communication** - Can you explain what you found and why your fix works?

---

## Setup

The application should already be running:
- Frontend: http://localhost:5193
- Backend: http://localhost:3000
- Database: MySQL (check .env for connection details)

To restart services: `pnpm dev`

To re-seed the database:
```bash
docker exec -i joint_work_mysql mysql -uroot -ppassword joint_work < db/seed.sql
```

---

## Time Limit

You have **60 minutes** to solve as many challenges as you can. Quality matters more than quantity.

Good luck!
