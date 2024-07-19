---
title: Create a running totals query
description: Demonstrates two methods that you can use to create a running totals query in Microsoft Access.
author: helenclu
manager: dcscontentpm
localization_priority: Normal
ms.custom: 
  - CI 111294
  - CSSTroubleshoot
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.author: luche
ms.reviewer: MattBum
appliesto: 
  - Access 2007
  - Access 2003
  - Access 2002
ms.date: 06/06/2024
---

# How to create a running totals query in Microsoft Access

Advanced: Requires expert coding, interoperability, and multiuser skills.

This article applies to a Microsoft Access database (.mdb) file or to a Microsoft Access database (.accdb) file.

## Summary

This article demonstrates two methods that you can use to create a running totals query. A running totals query is a query in which the total for each record is a summation of that record and any previous records. This type of query is useful for displaying cumulative totals over a group of records (or over a period of time) in a graph or report.

**Note** You can see a demonstration of the technique that is used in this article in the sample file Qrysmp00.exe.

## More Information

### Method 1

The first method uses a DSum function and criteria in a query to create a running sum over time. The DSum function sums the current record and any previous records. When the query moves to the next record, the DSum function runs again and updates the cumulative total.

The following sample query uses the **Orders** table from the sample database Northwind to create a running sum of the freight costs for each month in 1997. The sample data is limited to one year for performance reasons. Because the DSum function runs once for every record in the query, it may take several seconds (depending on the speed of your computer) for the query to finish processing. To create and run this query, follow these steps:

1. Open the sample database Northwind.   
2. Create a new select query and add the **Orders** table.   
3. On the **View** menu, click **Totals**.

   **Note** In Access 2007, click **Totals** in the **Show/Hide** group on the **Design** tab.   
4. In the first column of the query design grid, type the following expression in the Field box, and make the following selections for the Total, Sort, and Show boxes:

    ```adoc
    Field: AYear: DatePart("yyyy",[OrderDate])
    Total: Group By
    Sort: Ascending
    Show: Yes
    ```

   The expression in the Field box displays and sorts the year portion of the OrderDate field.

5. In the second column of the query design grid, type the following expression in the Field box, and make the following selections for the Total, Sort, and Show boxes:
    ```adoc
    Field: AMonth: DatePart("m",[OrderDate])
    Total: Group By
    Sort: Ascending
    Show: Yes
    ```

   The expression in the Field box sorts and displays the month portion of the Order Date field as an integer value from 1 to 12.   
6. In the third column of the query design grid, type the following expression in the Field box, and make the following selections for the Total and Show boxes.

   **NOTE** In the following example, an underscore (_) at the end of a line is used as a line-continuation character. Remove the underscore from the end of the line when re-creating this example.

   ```adoc
   Field: RunTot: DSum("Freight","Orders","DatePart('m', _
   [OrderDate])<=" & [AMonth] & " And DatePart('yyyy', _
   [OrderDate])<=" & [AYear] & "")
   Total: Expression
   Show: Yes
   ```

   The expression in the Field box uses the DSum() function to sum the Freight field when the values in both the AMonth and the AYear fields are less than or equal to the current record that the query is processing.   
7. In the fourth column of the query design grid, type the following expression in the Field box, and make the following selections for the Total, Sort, and Show boxes:
   
   ```adoc
   Field: FDate: Format([OrderDate],"mmm")
   Total: Group By
   Sort: Ascending
   Show: Yes
   ```

   The expression in the Field box displays each month in a textual format, such a Jan, Feb, Mar, and so on.
8. In the fifth column of the query design grid, type the following expression in the Field box, and make the following selections for the Total, Criteria, and Show boxes:

   ```adoc
   Field: DatePart("yyyy",[OrderDate])
   Total: Where
   Criteria: 1997
   Show: No
   ```
   The expression in the Field box filters the query's recordset to include data from 1997 only.

9. Run the query. Note that the RunTot field displays the following records with a running sum:
   
   ```adoc
   AYear AMonth RunTot FDate
   --------------------------------------
   1997 1 2238.98 Jan
   1997 2 3840.43 Feb
   1997 3 5729.24 Mar
   1997 4 8668.34 Apr
   1997 5 12129.74 May
   1997 6 13982.39 Jun
   1997 7 17729.29 Jul
   1997 8 22204.73 Aug
   1997 9 26565.26 Sep
   1997 10 32031.38 Oct
   1997 11 36192.09 Nov
   1997 12 42748.64 Dec
   ```

### Method 2

The second method uses a totals query with a DSum() function to create a running total over a group.

The following sample query uses the Orders table to sum freight costs per employee as well as to calculate a running sum of the freight. To create and run the query, follow these steps:

1. Open the sample database Northwind.mdb.   
2. Create a new select query and add the Orders table.   
3. On the Viewmenu, click Totals.

   **Note** In Access 2007, click **Totals** in the **Show/Hide** group on the **Design** tab.   
4. In the first column of the query design grid, add the following field to the Field box, and make the following selections for the Total and Show boxes:
   ```adoc 
   Field: EmpAlias: EmployeeID
   Total: Group By
   Show: Yes
   ```

   This field groups data by EmployeeID.   
5. In the second column of the query design grid, add the following field to the Field box, and make the following selections for the Total and Show boxes:
   ```adoc
   Field: Freight
   Total: Sum
   Show: Yes
   ```
   This field sums the freight data.

6. In the third column of the query design grid, type the following expression in the Field box, and make the following selections for the Total and Show boxes.

   **NOTE** In the following example, an underscore (_) at the end of a line is used as a line-continuation character. Remove the underscore from the end of the line when re-creating this example.

   ```adoc
   Field: RunTot: Format(DSum("Freight","Orders","[EmployeeID]<=" _& [EmpAlias] & ""),"$0,000.00")
   Total: Expression
   Show: Yes
   ```
   The expression in the Field box uses a DSum() function to sum the Freight field when the EmployeeID is less than or equal to the current EmpAlias, and then formats the field in dollars.   
7. Run the query. Note that the RunTot field displays the following records with a running sum:
   ```adoc
   Employee SumOfFreight RunTot
   -------------------------------------------------
   Davolio, Nancy $8,836.64 $8,836.64
   Fuller, Andrew $8,696.41 $17,533.05
   Leverling,Janet $10,884.74 $28,417.79
   Peacock, Margaret $11,346.14 $39,763.93
   Buchanan, Steven $3,918.71 $43,682.64
   Suyama, Michael $3,780.47 $47,463.11
   King, Robert $6,665.44 $54,128.55
   Callahan, Laura $7,487.88 $61,616.43
   Dodsworth, Anne $3,326.26 $64,942.69
   ```
