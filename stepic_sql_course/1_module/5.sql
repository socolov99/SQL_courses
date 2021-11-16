DROP TABLE IF EXISTS book;
CREATE TABLE book
(
    book_id SERIAL PRIMARY KEY,
    title   VARCHAR(50),
    author  VARCHAR(30),
    price   DECIMAL(8, 2),
    amount  INT,
    buy     INT
);

INSERT INTO book(title, author, price, amount, buy)
VALUES ('Мастер и Маргарита', 'Булгаков М.А.', 670.99, 3, 0),
       ('Белая гвардия', 'Булгаков М.А.', 540.50, 5, 3),
       ('Идиот', 'Достоевский Ф.М.', 460.00, 10, 8),
       ('Братья Карамазовы', 'Достоевский Ф.М.', 799.01, 3, 0),
       ('Игрок', 'Достоевский Ф.М.', 480.50, 10, 18),
       ('Стихотворения и поэмы', 'Есенин С.А.', 650.00, 15, 1);

DROP TABLE IF EXISTS supply;
CREATE TABLE supply
(
    supply_id SERIAL PRIMARY KEY,
    title     VARCHAR(50),
    author    VARCHAR(30),
    price     DECIMAL(8, 2),
    amount    INT,
    buy       INT
);

INSERT INTO supply (supply_id, title, author, price, amount, buy)
VALUES (1, 'Лирика', 'Пастернак Б.Л.', 518.99, 2, 4),
       (2, 'Черный человек', 'Есенин С.А.', 570.20, 6, 2),
       (3, 'Белая гвардия', 'Булгаков М.А.', 540.50, 7, 5),
       (4, 'Идиот', 'Достоевский Ф.М.', 360.80, 3, 0);

-- INSERT INTO book(title, author, price, amount)
--         (SELECT title, author, price, amount FROM supply);

INSERT INTO book(title, author, price, amount, buy)
    (SELECT title, author, price, amount, buy
     FROM supply
     WHERE author NOT IN (SELECT author FROM book));

UPDATE book
SET price = price * 0.9
WHERE amount in (5, 10);

UPDATE book
SET buy   = CASE
                WHEN buy > amount THEN amount
                ELSE buy
    END,
    price = CASE
                WHEN buy = 0 THEN 0.9 * book.price
                ELSE price
        END;

UPDATE book
SET amount = amount +
             (SELECT amount FROM supply WHERE book.author = supply.author AND book.title = supply.title),
    price  = 0.5 * (price +
                    (SELECT supply.price
                     FROM supply
                     WHERE book.author = supply.author
                       AND book.title = supply.title));

DELETE
FROM supply
WHERE author IN (SELECT author FROM book GROUP BY author HAVING sum(amount) > 10);

SELECT *
FROM supply;

CREATE TABLE ordering AS
SELECT author, title, (SELECT round(AVG(amount)) FROM book) AS amount
FROM book
WHERE amount < (SELECT round(AVG(amount)) FROM book);

SELECT *
FROM ordering;

