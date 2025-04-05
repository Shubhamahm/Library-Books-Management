

CREATE TABLE college.Books (
    book_id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(255) NOT NULL,
    author VARCHAR(255) NOT NULL,
    genre VARCHAR(50),
    published_year INT,
    available_copies INT DEFAULT 1
);

CREATE TABLE college.Members (
    member_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    phone VARCHAR(15),
    join_date DATE 
);

CREATE TABLE college.Borrowings (
    transaction_id INT PRIMARY KEY AUTO_INCREMENT,
    book_id INT,
    member_id INT,
    borrow_date DATE,
    return_date DATE,
    status ENUM('Borrowed', 'Returned') DEFAULT 'Borrowed',
    FOREIGN KEY (book_id) REFERENCES Books(book_id),
    FOREIGN KEY (member_id) REFERENCES Members(member_id)
);

insert into college.Books
(title, author, genre, published_year, available_copies) VALUES
('To Kill a Mockingbird', 'Harper Lee', 'Fiction', 1960, 3),
('1984', 'George Orwell', 'Dystopian', 1949, 5),
('The Great Gatsby', 'F. Scott Fitzgerald', 'Classic', 1925, 2),
('Moby Dick', 'Herman Melville', 'Adventure', 1851, 4),
('Pride and Prejudice', 'Jane Austen', 'Romance', 1813, 6),
('The Catcher in the Rye', 'J.D. Salinger', 'Coming-of-age', 1951, 3),
('Harry Potter and the Sorcerer\'s Stone', 'J.K. Rowling', 'Fantasy', 1997, 8),
('The Hobbit', 'J.R.R. Tolkien', 'Fantasy', 1937, 7),
('The Da Vinci Code', 'Dan Brown', 'Thriller', 2003, 5),
('The Alchemist', 'Paulo Coelho', 'Philosophical', 1988, 4);

INSERT INTO college.Members (name, email, phone, join_date) VALUES
('Amit Sharma', 'amit.sharma@example.com', '9876543210', '2024-01-15'),
('Priya Verma', 'priya.verma@example.com', '9988776655', '2024-02-10'),
('Rahul Singh', 'rahul.singh@example.com', '9123456789', '2024-03-05'),
('Sneha Gupta', 'sneha.gupta@example.com', '9345678901', '2024-03-20'),
('Vikram Patel', 'vikram.patel@example.com', '9786543210', '2024-04-01'),
('Neha Joshi', 'neha.joshi@example.com', '9456781230', '2024-04-10'),
('Ankit Mehta', 'ankit.mehta@example.com', '9234567890', '2024-04-15'),
('Riya Kapoor', 'riya.kapoor@example.com', '9321456780', '2024-05-01'),
('Sameer Khan', 'sameer.khan@example.com', '9564781230', '2024-05-10'),
('Kavita Rao', 'kavita.rao@example.com', '9890123456', '2024-06-01');

INSERT INTO college.Borrowings (book_id, member_id, borrow_date, return_date, status) VALUES
(1, 3, '2024-03-10', '2024-03-20', 'Returned'),
(2, 5, '2024-04-01', NULL, 'Borrowed'),
(3, 1, '2024-04-05', '2024-04-15', 'Returned'),
(4, 7, '2024-04-12', NULL, 'Borrowed'),
(5, 2, '2024-04-20', '2024-04-30', 'Returned'),
(6, 8, '2024-05-01', NULL, 'Borrowed'),
(7, 4, '2024-05-05', NULL, 'Borrowed'),
(8, 6, '2024-05-08', '2024-05-18', 'Returned'),
(9, 10, '2024-06-01', NULL, 'Borrowed'),
(10, 9, '2024-06-05', NULL, 'Borrowed');

-- Retrieve all books available in the library-- 
select* from college.books;

-- Find details of a book with the title "'To Kill a Mockingbird'"
select book_id, title from college.books
where title= 'To Kill a Mockingbird';

-- List all members who joined the library after January 1, 2024
select name, join_date from college.members
where join_date > '2024-01-01';

-- Retrieve the borrowing history of a specific member using member_id
select borrowings.member_id, name from college.members
join college.borrowings on borrowings.member_id=members.member_id
where members.member_id=5;

-- Find the total number of books in the library by genre
select count(book_id), genre from college.books
group by genre;

-- Find books that have been borrowed but not yet returned
select book_id , status from college.borrowings
where status='Borrowed';

-- Retrieve the top 5 most borrowed books
select title, count(books.book_id) as Number_of_Books from college.borrowings
join college.books on borrowings.book_id=books.book_id
group by books.book_id 
order by Number_of_Books desc
limit 5;

-- Find members who have borrowed more than 0 books in the last 6 months
select borrowings.member_id,count(transaction_id) as No_books_borrowed, name from college.borrowings
join college.members on members.member_id=borrowings.member_id
WHERE borrow_date >= DATE_SUB(CURDATE(), INTERVAL 6 MONTH)
group  by member_id
having No_books_borrowed >=0;

select* from college.borrowings;

-- update the borrow date of a memebr with member id = 5
update college.borrowings
set borrow_date='2025-01-01'
where member_id=5;

