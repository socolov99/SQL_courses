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
       ('Братья Карамазовы', 'Достоевский Ф.М.', 799.01, 3),
       ('Игрок', 'Достоевский Ф.М.', 480.50, 10),
       ('Стихотворения и поэмы', 'Есенин С.А.', 650.00, 15);

SELECT *
FROM book;

SELECT amount
FROM book
GROUP BY amount;

SELECT author AS Автор, count(title) AS Различных_книг, sum(amount) AS Количество_экземпляров
FROM book
GROUP BY author;

SELECT author, min(price) AS Минимальная_цена, max(price) AS Максимальная_цена, avg(price) AS Средняя_цена
FROM book
GROUP BY author;

SELECT author,
       sum(price * amount)                                                                   AS Стоимость,
       ROUND((sum(price * amount) * (18 / 100)) / (1 + (18 / 100)), 2)                       AS НДС,
       sum(price * amount) - ROUND((sum(price * amount) * (18 / 100)) / (1 + (18 / 100)), 2) as Стоимость_без_НДС
FROM book
GROUP BY author;

SELECT min(price) AS Минимальная_цена, max(price) AS Максимальная_цена, round(avg(price), 2) AS Средняя_цена
FROM book;

SELECT round(avg(price), 2) AS Средняя_цена, sum(price * amount) AS Стоимость
FROM book
WHERE amount >= 5
  AND amount <= 14;

SELECT author, sum(price * amount) AS Стоимость
FROM book
WHERE title <> 'Идиот'
  AND title <> 'Белая гвардия'
GROUP BY author
HAVING sum(price * amount) > 5000
ORDER BY Стоимость DESC;

SELECT author, min(price) AS самая_дешевая_книга_автора
FROM book
WHERE title <> 'Стихотворения и поэмы'
GROUP BY author
HAVING sum(amount) > 10
ORDER BY самая_дешевая_книга_автора ASC;










