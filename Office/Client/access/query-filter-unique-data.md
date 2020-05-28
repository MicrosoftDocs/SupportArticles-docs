---
title: Using query to filter unique data
description: Lists the aggregate functions that you can use in fields that don't contain duplicate data.
author: MaryQiu1987
ms.author: v-maqiu
manager: dcscontentpm 
audience: ITPro 
ms.topic: article
ms.prod: office-perpetual-itpro
localization_priority: Normal
ms.custom: 
- CI 114797
- CSSTroubleshoot
ms.reviewer: carlr, rioj
appliesto:
- Microsoft Office Access 2007
- Microsoft Office Access 2003
search.appverid: MET150
---
# How to use a query to filter unique data in Access

[!INCLUDE [Branding name note](../../../includes/branding-name-note.md)]

_Original KB number:_ &nbsp; 292634

> [!NOTE]
> Requires knowledge of the user interface on single-user computers. This article applies only to a Microsoft Access database (.mdb or .accdb).

## Summary

When you filter a table to eliminate duplicate data in Microsoft Access 2002 or Microsoft Office Access 2003, use a query that uses one of the aggregate (totals) functions, such as First(), Last(), Min(), or Max(), in the fields that do not contain duplicate data. In the fields that do contain duplicate data, use the
GroupBy() function.

## More Information

For example, suppose you import an inventory table from an application and discover that the data has duplicates in it. To get the data back down to a baseline, such as one record per product, so that you can then re-inventory and have a correct and complete set of data, use a query to filter the data.

Suppose the table looks as follows:

|ProdID|Description|Cost|MarkUp|Quantity|
|-----|-----|-----|-----|-----|
|1|A Product|$1.50|0.5|10|
|2|B Product|$2.50|0.7|100|
|3|C Product|$1.59|0.9|25|
|2|D Product|$4.59|0.8|30|
|5|E Product|$1.99|0.7|40|
|6|F Product|$2.69|0.4|60|
|9|G Product|$4.95|0.8|20|
|8|H Product|$6.79|0.9|32|
|9|I Product|$6.89|0.7|0|
|1|J Product|$2.99|0.5|11|

If you want to filter the table so that it has a unique ProdID code and the first entry from each of the other fields, do the following:

1. Create a new query that is based on the original table.
2. Add all the fields from the field list to the query design grid.
3. In Microsoft Office Access 2003 or in earlier versions of Access, click **Totals** on the **View** menu.

   In Microsoft Office Access 2007, click **Totals** in the **Show/Hide** group on the **Design** tab.

4. Set theTotal row of the query design grid to First for every field except ProdID.Set ProdID toGroup By.
5. In Access 2003 or in earlier versions of Access, click **Datasheet View** on the **View** menu.

   In Access 2007, click **Datasheet View** in the **View** list in the **Results** group on the **Design** tab.
   
The data that you see is a list of unique ProdID data with the first value that is encountered for that product in each of the other fields. If you use this procedure on the sample table, your result is as follows:

|ProdID|Description|Cost|MarkUp|Quantity|
|-----|-----|-----|-----|-----|
|1|A Product|$1.50|0.5|10|
|2|B Product|$2.50|0.7|100|
|3|C Product|$1.59|0.9|25|
|5|E Product|$1.99|0.7|40|
|6|F Product|$2.69|0.4|60|
|8|H Product|$6.79|0.9|32|
|9|G Product|$4.95|0.8|20|

To obtain different results, use the Max(), Min(), or Last() function instead of the
First function().

To generate a unique table from this query, change the query type to a make-table query in Design view of the query.

> [!NOTE]
> This query returns unique data. To find duplicate records and to edit the records, or to choose which records to keep, use the Find Duplicates Query Wizard.
