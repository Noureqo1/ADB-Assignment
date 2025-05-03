
## Database Schema

The system consists of three main tables:
1. `Books` - Stores book information
   - BookID (PK)
   - Title
   - Author
   - CopiesAvailable
   - TotalCopies

2. `Members` - Stores member information
   - MemberID (PK)
   - Name
   - Email
   - TotalBooksBorrowed
   - IsActive

3. `BorrowedBooks` - Tracks borrowing history
   - BorrowID (PK)
   - MemberID (FK)
   - BookID (FK)
   - BorrowDate
   - DueDate
   - ReturnDate
   - IsReturned

## Features

1. **Book Management**
   - Track book inventory
   - Monitor available copies
   - Record total copies

2. **Member Management**
   - Member registration
   - Track borrowing history
   - Active/inactive status management

3. **Borrowing System**
   - Track borrowing and returning
   - Due date management
   - Automatic return status updates

4. **Query Optimization**
   - Optimized query plans
   - Efficient data retrieval
   - Performance optimization

## Setup

1. Create the database schema using [01_create_tables.sql](cci:7://file:///d:/ADB%20Assignment/SQL%20Scripts/01_create_tables.sql:0:0-0:0)
2. Import sample data using `0_3_sample_data.sql`
   - Books Table
    ![sample_data](Tests/Screenshot%202025-04-26%20193006.png)
   - Members Table
    ![sample_data](Tests/Screenshot%202025-04-26%20192819.png)

3. Set up triggers from `06_prevent_borrow_trigger.sql`
    ![prevent_borrow_trigger](Tests/Screenshot%202025-04-26%20195028.png)

## Documentation

- Query optimization details are documented in `Query_Tree_Optimization/Optimized_Query_Plan.md`
- Database structure is visualized in `ERD/ERD.mermaid`

## Testing

1. Triger and Prevent Borrow.
![trigers](Tests/Screenshot%202025-04-26%20195907.png)
- Two failed attempts.
- One successful attempt.
  
2. Borrowed_Books after running the procedures.
    ![borrow_book](Tests/Screenshot%202025-04-26%20200055.png)

    - BorrowedBook procedure.
    ![borrow_book](Tests/Screenshot%202025-04-26%20194204.png)
    - GetBooksBorrowed procedure.
    ![borrow_book](Tests/Screenshot%202025-04-26%20194732.png)

Test cases are located in the `Tests` directory to verify system functionality.
