-- payflow_optimized.sql
CREATE DATABASE IF NOT EXISTS payflow_db;
USE payflow_db;

CREATE TABLE IF NOT EXISTS Transactions (
  transaction_id INT AUTO_INCREMENT PRIMARY KEY,
  user_id INT,
  amount DECIMAL(15,2),
  transaction_type VARCHAR(20),
  created_at DATETIME,
  INDEX idx_type_date (transaction_type, created_at)
);

-- (Tùy chọn) chèn vài dòng mẫu để test
INSERT INTO Transactions (user_id, amount, transaction_type, created_at)
VALUES (1, 100.00, 'DEPOSIT', '2026-06-05 10:00:00'),
       (2, 50.00, 'DEPOSIT', '2026-06-20 12:00:00'),
       (3, 20.00, 'WITHDRAW', '2026-06-10 09:00:00');

-- EXPLAIN cho truy vấn cũ (tham khảo)
EXPLAIN
SELECT SUM(amount) AS total_deposit
FROM Transactions
WHERE transaction_type = 'DEPOSIT'
  AND YEAR(created_at) = 2026
  AND MONTH(created_at) = 6;

-- Truy vấn tối ưu (SARGable) dùng range
EXPLAIN
SELECT SUM(amount) AS total_deposit
FROM Transactions
WHERE transaction_type = 'DEPOSIT'
  AND created_at >= '2026-06-01 00:00:00'
  AND created_at <  '2026-07-01 00:00:00';
