---
title: Use wildcard characters in the SQL statement
description: This article describes how to use wildcard characters in the SQL-SELECT statement to add versatility to this statement.
ms.date: 09/08/2020
ms.prod-support-area-path: 
ms.topic: how-to
ms.prod: Visual FoxPro
---
# Use wildcard characters in the SQL-SELECT statement in Visual FoxPro

This article introduces how to use wildcard characters in the SQL-SELECT statement to add versatility to this statement.

_Original product version:_ &nbsp; Visual FoxPro  
_Original KB number:_ &nbsp; 98434

## Summary

To broaden the selections of a structured query language (SQL-SELECT) statement, two wildcard characters, the percent sign (%) and the underscore (_), can be used.

The percent sign is analogous to the asterisk (*) wildcard character used with MS-DOS. The percent sign allows for the substitution of one or more characters in a field.

The underscore is similar to the MS-DOS wildcard question mark character. The underscore allows for the substitution of a single character in an expression. Three examples showing the use of these characters in SQL-SELECT statements are provided below. The examples use the Customer.dbf file that is included with Microsoft Visual FoxPro in the Home(2)+data folder.

## More information

The following SELECT-SQL statement returns all the records from the Customer.dbf table that contain a "W" as the first character in the `Regionabbreviation` field. The SELECT-SQL statement lists the records from "WY" and "WA" in a Browse window.

```sql
 SELECT * from customer WHERE Region like "W_"
```

The following SELECT-SQL statement lists all the records that have a "P" or a "C" as the last character in the `Regionabbreviation` field. The output includes records from "SP" and "BC."

```sql
SELECT * from customer WHERE Region like "_P" OR region like "_C"
```

The following SELECT-SQL statement uses the percent sign and the underscore to return all the records that have a Cust_ID that starts with "G" and that have a `Regionabbreviation` field that ends with "P."

> [!NOTE]
> The percent sign lets any string of characters follow the "G." Conversely, the underscore permits the substitution of only a single character.

```sql
SELECT * FROM Customer WHERE cust_ID LIKE "G%" AND region LIKE "_P"
```

To do a string search similar to the one performed by the $ function, use a statement like:

```sql
SELECT * from customer WHERE company like "%M%"
```

This SELECT-SQL statement finds all companies that have names that contain "M."

## References

For more information, see the Visual FoxPro Help files. Search for "SELECT - SQL."
