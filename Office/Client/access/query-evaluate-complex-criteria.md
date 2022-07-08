---
title: Create a query to evaluate complex criteria
description: Describes how to create a query that has parameters to evaluate complex criteria in Access.
author: MaryQiu1987
ms.author: v-maqiu
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - CI 114797
  - CSSTroubleshoot
ms.reviewer: chriswy
appliesto: 
  - Access 2010
  - Microsoft Office Access 2007
  - Microsoft Office Access 2003
search.appverid: MET150
ms.date: 3/31/2022
---
# How to create a query that has parameters to evaluate complex criteria in Access

_Original KB number:_ &nbsp; 290178

> [!NOTE]
> This article applies only to a Microsoft Access database (.mdb or .accdb). Requires basic macro, coding, and interoperability skills.

## Summary

In Microsoft Access, you can use variable parameters in queries. This article discusses how to construct a query that requires more than one prompt. You can use each parameter both as criteria and as a field to allow complicated evaluation of the value that is entered in each parameter.

## More Information

> [!CAUTION]
> If you follow the steps in this example, you modify the sample database Northwind.mdb. You may want to back up the Northwind.mdb file and follow these steps on a copy of the database.

The following parameter query is based on the Orders table in the sample database Northwind.mdb. It selects orders written between two dates provided by the user.

If the user does not enter either the Start Date or the End Date, the query returns all dates greater than or equal to the Start Date, or less than or equal to the End Date. If the user enters not a Start Date or an End Date, the query returns all orders.

1. Open the sample database Northwind.mdb.
2. Create a new query that is based on the Orders table.
3. Enter the following query:

   ```console
   Query: FindOrdersByDate
   ------------------------------------------------
   Type: Select Query

   Field: OrderID
   Show: Yes

   Field: OrderDate
   Sort: Ascending
   Show: Yes
   First Criteria Line: Between [Start Date] and [End Date]
   Second Criteria Line: <=[End Date]
   Third Criteria Line: >=[Start Date]

   Field: [Start Date]
   Show: No
   First Criteria Line: Is Not Null
   Second Criteria Line: Is Null
   Third Criteria Line: Is Not Null
   Fourth Criteria Line: Is Null

   Field: [End Date]
   Show: No
   First Criteria Line: Is Not Null
   Second Criteria Line: Is Not Null
   Third Criteria Line: Is Null
   Fourth Criteria Line: Is Null
   ```

4. In Microsoft Office Access 2003 or Microsoft Access 2002, on the **Query** menu, click **Parameters**. In Microsoft Office Access 2007, click the **Design** tab, and then click **Parameters** in the **Show/Hide** group. In the **Query Parameters** dialog box, add two entries, one for each parameter in the query, as follows:

   ```console
   Query Parameters
   -----------------------
   Parameter: Start Date
   Data Type: Date/Time

   Parameter: End Date
   Data Type: Date/Time
   ```

5. In Access 2003 or in Access 2002, click **Datasheet** on the **View** menu to run the query. In Access 2007, click the **Design** tab, and then click **Datasheet View** in the **View** list in the **Results** group to run the query.

   > [!NOTE]
   > Access prompts you for the value of the parameters. Then, Access substitutes the proper values in the query.
