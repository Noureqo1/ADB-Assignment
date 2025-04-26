CREATE TRIGGER PreventBorrowIfNoCopies
ON BorrowedBooks
INSTEAD OF INSERT
AS
BEGIN
    DECLARE @BookID INT, @MemberID INT, @IsActive BIT, @CopiesAvailable INT;

    SELECT @BookID = BookID, @MemberID = MemberID FROM inserted;

    SELECT @IsActive = IsActive FROM Members WHERE MemberID = @MemberID;
    SELECT @CopiesAvailable = CopiesAvailable FROM Books WHERE BookID = @BookID;

    IF (@CopiesAvailable = 0)
    BEGIN
        RAISERROR ('Cannot borrow: No copies available.', 16, 1);
        RETURN;
    END

    IF (@IsActive = 0)
    BEGIN
        RAISERROR ('Cannot borrow: Member is not active.', 16, 1);
        RETURN;
    END

    -- If checks pass, proceed with the insert
    INSERT INTO BorrowedBooks (MemberID, BookID, BorrowDate, DueDate, ReturnDate, IsReturned)
    SELECT MemberID, BookID, BorrowDate, DueDate, ReturnDate, IsReturned FROM inserted;
END
