DROP TABLE IF EXISTS book;
CREATE TABLE book
(
    book_id SERIAL PRIMARY KEY,
    title   VARCHAR(50),
    author  VARCHAR(30),
    price   DECIMAL(8, 2),
    amount  INT
);

INSERT INTO book(title, author, price, amount)
VALUES ('Мастер и Маргарита', 'Булгаков М.А.', 670.99, 3),
       ('Белая гвардия', 'Булгаков М.А.', 540.50, 5),
       ('Идиот', 'Достоевский Ф.М.', 460.00, 10),
       ('Братья Карамазовы', 'Достоевский Ф.М.', 799.01, 2),
       ('Стихотворения и поэмы', 'Есенин С.А.', 650.00, 15);

SELECT *
FROM book;

SELECT author, title, price
FROM book;

SELECT title AS Название, author AS Автор
FROM book;

SELECT title, amount, 1.65 * amount AS pack
FROM book;

SELECT title, author, amount, ROUND(price * 0.7, 2) AS new_price
FROM book;

SELECT author,
       title,
       ROUND(CASE
                 WHEN author = 'Булгаков М.А.' THEN price * 1.1
                 WHEN author = 'Есенин С.А.' THEN price * 1.05
                 ELSE price * 1 END
           , 2) AS new_price
FROM book;

SELECT author, title, price
FROM book
WHERE amount < 10;

SELECT title, author, price, amount
FROM book
WHERE (price < 500 OR price > 600)
  AND (price * amount >= 5000);

SELECT title, author
FROM book
WHERE (price BETWEEN 540.50 AND 800)
  AND amount IN (2, 3, 5, 7);

SELECT author, title
FROM book
WHERE (amount BETWEEN 2 AND 14)
ORDER BY 1 DESC, 2 ASC;

SELECT title, author
FROM book
WHERE (title LIKE '_% _%')
  AND (author LIKE '%С.%');

SELECT title, author
FROM book
WHERE ((amount BETWEEN 2 AND 14) AND price < 750)
   OR title = 'Стихотворения и поэмы'
ORDER BY 2 DESC, 1 ASC






















































