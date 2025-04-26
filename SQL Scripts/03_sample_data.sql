INSERT INTO Books (BookID, Title, Author, CopiesAvailable, TotalCopies) VALUES
(1, '1984', 'George Orwell', 3, 3),
(2, 'Brave New World', 'Aldous Huxley', 2, 2),
(3, 'To Kill a Mockingbird', 'Harper Lee', 1, 1);

INSERT INTO Members (MemberID, Name, Email, TotalBooksBorrowed, IsActive) VALUES
(1, 'Alice', 'alice@example.com', 0, 1),
(2, 'Bob', 'bob@example.com', 0, 1),
(3, 'Charlie', 'charlie@example.com', 0, 0); -- Zero for Inactive member (BOOl IsActive)
