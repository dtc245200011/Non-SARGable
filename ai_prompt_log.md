Prompt 1:
"Why does YEAR(created_at)=2026 prevent index usage on created_at in MySQL?"
Answer 1:
"Applying a function to a column makes the predicate non‑SARGable; the optimizer cannot use the column's B‑Tree index."

Prompt 2:
"When creating composite index (transaction_type, created_at), why put transaction_type first?"
Answer 2:
"Because the query filters first by transaction_type; placing the most selective filter first improves index selectivity and range scans on the second column."

Prompt 3:
"Compare LEFT JOIN IS NULL anti-join vs NOT EXISTS performance for large tables."
Answer 3:
"NOT EXISTS and LEFT JOIN ... IS NULL are generally comparable; prefer NOT EXISTS to avoid NULL pitfalls in subqueries, but test with EXPLAIN and real data."
