---
title: Tips on working with SQL queries
description: Provides tips to solve the error message that you receive when working with a database in Power Automate.
ms.reviewer: pefelesk
ms.date: 09/21/2022
ms.subservice: power-automate-desktop-flows
---
# Tips on working with SQL queries

You may receive an error message when working with a database by using SQL queries, but you can't identify the issue by looking at the error message. This article provides tips on solving the error message that you may receive when you work with SQL queries in Microsoft Power Automate.

_Applies to:_ &nbsp; Power Automate  
_Original KB number:_ &nbsp; 4599054

## Quotes in the SQL statement

Replace any single quote (') characters with double quotes (") or vice versa.

For example:

```sql
%var% = my value' 

            SELECT * FROM logs WHERE message = '%var%';
```

The above query would return an error due to the single quote at the end of the variable's value.

To resolve this issue, replace the single quotes in the SQL statement with double quotes:

```sql
%var% = my value' 

            SELECT * FROM logs WHERE message = "%var%"; 
```

## Percentage sign (%) in the SQL statement

Percentage signs in Power Automate for desktop indicate the beginning of a variable. To use them as a character, they should be escaped by an additional percentage sign (%%). For more information, see [Use variables and the % notation](/power-automate/desktop-flows/variable-manipulation).

## Error communicating with the database

Verify that the firewall or any other network security system isn't blocking the connection between Power Automate for desktop and the database.

## Connection to Microsoft Excel

An SQL connection can be established with Microsoft Excel, as soon as the appropriate driver is installed (Microsoft.ACE.OLEDB).

> [!NOTE]
>
> - The database name is considered the name of the Excel worksheet followed by a dollar sign (`$`), for example [Sheet1$].
> - The database columns are the headers of the Excel data table.
