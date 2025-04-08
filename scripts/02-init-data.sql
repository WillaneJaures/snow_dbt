\c bookshop;

-- Insert test data
INSERT INTO category (id, intitule, created_at) VALUES
(1, 'Roman', NOW()),
(2, 'Science-Fiction', NOW()),
(3, 'Biographie', NOW());

INSERT INTO books (id, category_id, code, intitule, isbn_10, isbn_13, created_at) VALUES
(1, 1, 'ROM001', 'Les Misérables', '1234567890', '1234567890123', NOW()),
(2, 2, 'SF001', 'Dune', '0987654321', '0987654321098', NOW()),
(3, 3, 'BIO001', 'Steve Jobs', '5432109876', '5432109876543', NOW());

INSERT INTO customers (id, code, first_name, last_name, created_at) VALUES
(1, 'CUS001', 'Jean', 'Dupont', NOW()),
(2, 'CUS002', 'Marie', 'Martin', NOW()),
(3, 'CUS003', 'Pierre', 'Bernard', NOW());

INSERT INTO factures (id, code, date_edit, customers_id, qte_totale, total_amount, total_paid, created_at) VALUES
(1, 'FAC001', '20240315', 1, 2, 50.00, 50.00, NOW()),
(2, 'FAC002', '20240316', 2, 1, 30.00, 30.00, NOW()),
(3, 'FAC003', '20240317', 3, 3, 75.00, 75.00, NOW());

INSERT INTO ventes (id, code, date_edit, factures_id, books_id, pu, qte, created_at) VALUES
(1, 'VEN001', '20240315', 1, 1, 25.00, 1, NOW()),
(2, 'VEN002', '20240315', 1, 2, 25.00, 1, NOW()),
(3, 'VEN003', '20240316', 2, 3, 30.00, 1, NOW()),
(4, 'VEN004', '20240317', 3, 1, 25.00, 3, NOW()); 