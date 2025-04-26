-- 5. SCALAR FUNCTION: GetBooksBorrowed
CREATE FUNCTION GetBooksBorrowed (@MemberID INT)
RETURNS INT
AS
BEGIN
    DECLARE @Count INT;
    SELECT @Count = COUNT(*) FROM BorrowedBooks
    WHERE MemberID = @MemberID AND IsReturned = 0;
    RETURN @Count;
END
