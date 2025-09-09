---
title: Expressions to count yes, no, and other responses
description: Describes how to use the expressions to count yes, no, and other responses in Access.
author: Cloud-Writer
manager: dcscontentpm
ms.custom: 
  - CI 111294
  - CSSTroubleshoot
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.author: meerak
ms.reviewer: mattbum
appliesto: 
  - Access 2007
  - Access 2003
  - Access 2002
  - Access 2000
ms.date: 05/26/2025
---

# Description of the expressions to count yes, no, and other responses in Access

Moderate: Requires basic macro, coding, and interoperability skills.

This article applies to a Microsoft Access database (.mdb) file or to a Microsoft Access database (.accdb) file.

## Summary

This article lists sample expressions that you can use to count the occurrences of Yes, No, or Null in a field with a Yes/No data type.

## More information

You can use the following expressions in a report footer to count the occurrences of Yes, No, or Null in a field named YesNoField with a data type of Yes/No:

|Expression| Sums What|
|------------------|--------------------------|
|=Sum(IIF([YesNoField],1,0)) |Yes|
|=Sum(IIF([YesNoField],0,1)) |No|
|=Sum(IIF(Not[YesNoField],1,0)) |No|
|=Sum(IIF(IsNull[YesNoField],1,0)) |Null|
 
You can also create a related expression to count a specific value in a field. For example, the following sample expression counts all occurrences of the value 3 in a field called MyField.

**=Sum(IIF([MyField]=3,1,0))**

### Example Using Sample Database Northwind

1. Open the sample database Northwind in Access.   
2. Use the **Report Wizard** to create a report based on the **Products** table.   
3. Select **CategoryID** and **UnitPrice** as the fields for the report.   
4. Group on **CategoryID**.   
5. In the design view of the report, click **Sorting and Grouping** on the **View** menu, and make sure that the **GroupFooter** property for **CategoryID** is set to **Yes**.

   **Note** In Access 2007, in the design view of the report, on the **Design** tab, click **Group & Sort** in the **Grouping & Totals** group, and make sure that the **with a footer section** property for **CategoryID** is selected.   
6. Add an unbound text box in the **CategoryID footer** section with the **ControlSource** property for the text box set to the following expression:

   **=Sum(IIF([Discontinued],1,0))**
7. Add a second unbound text box with the **ControlSource** property for the text box set to the following expression:

   **=Sum(IIF([Discontinued],0,1))**
8. On the **File** menu, click **Print Preview**. 

   In Access 2007, click **Microsoft Office Button**, point to **Print**, and then click **Print Preview**.

   Notice that the first expression will count the number of products within each category that have the Discontinued field set to Yes. The second expression will count the number of products within each category that have the Discontinued field set to No.
