-- Successful borrows

EXEC BorrowBook 1, 1, '2025-04-26', '2025-05-10';
EXEC BorrowBook 2, 2, '2025-04-26', '2025-05-10';
EXEC BorrowBook 1, 3, '2025-04-26', '2025-05-10';

-- Unsuccessful: Bob (No copies available)
EXEC BorrowBook 2, 3, '2025-04-26', '2025-05-10';

-- Unsuccessful: Charlie (inactive)
EXEC BorrowBook 3, 1, '2025-04-26', '2025-05-10';
