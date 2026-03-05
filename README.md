# Real Estate Agency Database (SQL)

A small relational database project for a real estate agency.  
The model covers the core workflow: **properties** managed by **agents**, **clients** booking **viewings**, and the final **transactions** and **contracts**.

**Tech:** Oracle SQL / PL/SQL (triggers), ERD modeling (diagram in `docs/erd.png`)

## What’s inside
- `docs/erd.png` – entity–relationship diagram (ERD)
- `sql/01_schema.sql` – tables + foreign keys (DDL)
- `sql/02_seed.sql` – sample data (INSERTs)
- `sql/03_queries.sql` – example/reporting queries
- `sql/04_triggers.sql` – triggers (PL/SQL)
- `examples/trigger_demo.sql` – optional manual tests for triggers
- `original/` – original project files (kept for reference)

## How to run (optional)
You need access to an **Oracle** database (local or remote) and any SQL client (e.g. Oracle SQL Developer).

Recommended order:
1. Run `sql/01_schema.sql`
2. Run `sql/02_seed.sql`
3. Run `sql/04_triggers.sql` (optional)
4. Run `sql/03_queries.sql` to see example reports
5. (Optional) Run `examples/trigger_demo.sql`

## Domain model (high level)
- **Agent** manages many **Property** records
- **Client** can book multiple **Viewings**
- **Transaction** links a **Client** with a **Property**
- **Contract (Umowa)** formalizes the transaction

