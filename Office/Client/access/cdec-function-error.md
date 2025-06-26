---
title: Error when you use CDec() function in Access query
description: Describes that you receive an error message when you use the CDec() function in a Microsoft Access query.
author: helenclu
manager: dcscontentpm
ms.custom: 
  - CI 111294
  - CSSTroubleshoot
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.author: luche
ms.reviewer: mattbum
appliesto: 
  - Access 2010
  - Access 2007
  - Access 2003
  - Access 2002
ms.date: 05/26/2025
---

# "The expression you entered has a function containing the wrong number of arguments" when you use CDec() function in an Access query

Moderate: Requires basic macro, coding, and interoperability skills.

This article applies only to a Microsoft Access database (.mdb).

## Symptoms

When you use the CDec() function in a Microsoft Access query, you may receive the following error message:

"The expression you entered has a function containing the wrong number of arguments."

## Cause

The CDec() function is supported in Visual Basic for Applications code, but not in Access queries.

## Resolution

Create a custom function that uses the CDec() function. Call this custom function from your Access query. For example:

1. Create a new module and type the following code:

```vb
Function NewCDec(MyVal)
   NewCDec = CDec(MyVal)
End Function

```
2. Save and close the module.   
3. Type MyID: NewCDec([CategoryID]) in the Field row of a query. When you run this function, it returns a valid value for the MyID field.   

## Status

Microsoft has confirmed that this is a problem in the Microsoft products that are listed at the beginning of this article.

## More information

### Steps to Reproduce Behavior

#### Office Access 2002 and Office Access 2003

1. Open the sample database Northwind.mdb.   
2. In the Database window, click Queries under Objects, and then click New.   
3. In the New Query box, click Design View, and then click OK.    
4. In the Show Table box, click the Categories table. Click Add, and then click Close.   
5. Drag the CategoryName field from the Field List box to the Field row of the first column of the query design grid.   
6. Type MyID: CDec(CategoryID) in the Field row of the second column.   
7. Try to move to the next column in the query design grid. Note that you receive the error message mentioned in the "Symptoms" section.   

#### Office Access 2007 and Office Access 2010

1. Create a new database.
2. Create a new table with the following fields:

    |Name|Data Type|Field Size|
    |---|---|--|
    | ID|AutoNumber|Long Integer|
    |MyNum|Number|Double|

3. Save the table as Table1.
4. Open the table to add data and enter 10.55 in the **MyNum** column.
5. Close Table1.
6. Create a new query in Query Design.
7. Select Table1 in the **Show Table** window and click **Add**.
8. Click **Close** to close the **Show Table** window.
9. Drag the myNum field from the **Field List** box at the top of the design screen to the Field row of the first column of the query design grid.
10. In the **Field** row in the second column type: 

    **MyNewNum: CDec(myNum)**
11. Try to move to the next column in the query design grid. Note that you receive the error message mentioned in the "Symptoms" section.
