# Query Optimization Plan

## Initial SQL Query
```sql
SELECT S.Name, C.Title, E.Grade
FROM STUDENT S, COURSE C, ENROLLMENT E
WHERE S.StudentID = E.StudentID
  AND C.CourseID = E.CourseID
  AND S.Major = 'Computer Science'
  AND C.Credits >= 3;
```

## Step 1: Initial Canonical Query Tree
**Description:**
All selections and join conditions are applied at the top, with all tables in a single Cartesian Product.

**Relational Algebra:**
```sql
π_{S.Name, C.Title, E.Grade} (
  σ_{S.Major='Computer Science' ∧ C.Credits>=3 ∧ S.StudentID=E.StudentID ∧ C.CourseID=E.CourseID}
    (STUDENT × COURSE × ENROLLMENT)
)
```
**Explanation:**
This is the least efficient form. All combinations are generated before filtering, leading to large intermediate results.

## Step 2: Push Down Selections

### Filter Students
```sql
σ[S.Major = 'Computer Science'](STUDENT)
```
**Rationale**: Apply the most selective condition first to reduce the student relation size early. This minimizes the data volume for subsequent operations.

### Filter Courses
```sql
σ[C.Credits >= 3](COURSE)
```
**Rationale**: Similarly, filter courses early to work with only relevant course records.

## Step 3: Replace Cartesian Products with Joins

### First Join Operation
```sql
(σ[Major = 'Computer Science'](STUDENT)) ⋈[S.StudentID = E.StudentID] ENROLLMENT
```
**Rationale**: Use natural join instead of cartesian product followed by selection. This dramatically reduces intermediate result size.

### Second Join Operation
```sql
(Previous_Result) ⋈[C.CourseID = E.CourseID] (σ[Credits >= 3](COURSE))
```
**Rationale**: Join with filtered courses using CourseID. The join operation is more efficient than filtering after a cartesian product.

## Step 4: Apply Most Restrictive Selections First
**Description:**
The most selective filters are applied first to minimize data as soon as possible.

**Relational Algebra:**
```sql
π_{S.Name, C.Title, E.Grade} (
  σ_{S.StudentID=E.StudentID ∧ C.CourseID=E.CourseID}
    (σ_{S.Major='Computer Science'}(STUDENT) × σ_{C.Credits>=3}(COURSE) × ENROLLMENT)
)
```
**Explanation:**
Most restrictive conditions (like major and credits) are applied first for maximum efficiency.

## Step 5: Replace Cartesian Product and Selection with Joins
**Description:**
Cartesian products and selections are replaced with joins.

**Relational Algebra:**
```sql
π_{S.Name, C.Title, E.Grade} (
  (σ_{S.Major='Computer Science'}(STUDENT)
    ⋈_{S.StudentID=E.StudentID}
    (ENROLLMENT ⋈_{C.CourseID=E.CourseID} σ_{C.Credits>=3}(COURSE)))
)
```
**Explanation:**
Joins are more efficient than Cartesian products followed by selection.

## Final Optimized Expression
**Description:**
Projections are pushed down to remove unnecessary columns as early as possible.

**Relational Algebra:**
```sql
π_{S.Name, C.Title, E.Grade} (
  (π_{StudentID, Name}(σ_{S.Major='Computer Science'}(STUDENT))
    ⋈_{S.StudentID=E.StudentID}
    (ENROLLMENT ⋈_{C.CourseID=E.CourseID} π_{CourseID, Title, Credits}(σ_{C.Credits>=3}(COURSE))))
)
```
**Explanation:**
Minimizes data carried through the query by projecting only needed columns early.

```sql
π[S.Name, C.Title, E.Grade](Final_Join_Result)
```
**Rationale**: Project only the required columns (Name, Title, Grade) at the end to minimize the final output size.

```sql
π[Name, Title, Grade](
    (σ[Major = 'Computer Science'](STUDENT) 
    ⋈[StudentID] ENROLLMENT) 
    ⋈[CourseID] σ[Credits >= 3](COURSE)
)
```

## Optimization Benefits

1. **Early Selection**: Reduces data volume at the start
2. **Join Strategy**: Eliminates expensive cartesian products
3. **Minimal Data Transfer**: Only necessary columns are carried through
4. **Efficient Processing**: Smaller intermediate results throughout the query
