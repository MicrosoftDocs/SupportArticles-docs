---
title: Table hierarchy inconsistency errors in Dexterity
description: Contains information about table hierarchy inconsistency errors that concern Dexterity and Report Writer in Microsoft Dynamics GP.
ms.reviewer: theley
ms.date: 03/20/2024
ms.custom: sap:System and Security Setup, Installation, Upgrade, and Migrations
---
# Information about table hierarchy inconsistency errors in Dexterity in Microsoft Dynamics GP

This article introduces the information about table hierarchy inconsistency errors in Dexterity in Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 921637

## Symptoms

You try to print a report in Dexterity in Microsoft Dynamics GP. Report Writer is unable to resolve the relationship between two or more tables that are used in the report. In this scenario, a table hierarchy inconsistency error occurs.

## More information

Consider the following example:

- Two tables are used in a report.
- Table A is the main table.
- Table B is linked to table A by a relationship.

If the relationship between these tables is removed, an error occurs when you print the report. The error occurs because Report Writer is unable to find a path down the hierarchy of the tables that are used in the report.

A Dexterity developer may have to add data from a new third-party table to the report. To do this as easily as possible, the developer follows these steps:

1. The developer adds a relationship from one of the original Microsoft Dynamics GP tables to the new table.
2. The developer attaches the new table to the report.
3. The developer drags the appropriate field into the report layout.

This technique works in Test mode in Dexterity. However, this method produces table hierarchy inconsistency errors as soon as the customization has been chunked and then added to a runtime environment.

Table relationships are used only to help Report Writer create links between tables. Table relationships are extracted during the chunking process only when one or more of the tables to which the relationships have been added are also extracted. Because the relationships have been added to one or more original Microsoft Dynamics GP tables, and because those tables were not extracted during the chunking process, the relationships that existed in Test mode do not exist in Runtime mode. Therefore, the error occurs.

Because of this situation, you must use a different method to add extra fields to the report. You can use one of the following methods:

- Use Report Writer functions.
- Duplicate Microsoft Dynamics GP tables definitions or Microsoft Business Solutions - Great Plains table definitions, and then change the main table on an alternative report.

  > [!NOTE]
  > The second method does not work when you are using temporary tables.

For more information about these methods and about table hierarchy inconsistency errors, see [Table Hierarchy Inconsistency errors](https://support.microsoft.com/topic/table-hierarchy-inconsistency-errors-af154162-5bf6-1103-fdb6-b0c64d3530c1).

For more information about how to link third-party tables by using Dexterity, see [How to link third-party tables to the SOP Blank Invoice Form report by using Dexterity for Microsoft Dynamics GP](https://support.microsoft.com/topic/how-to-link-third-party-tables-to-the-sop-blank-invoice-form-report-by-using-dexterity-for-microsoft-dynamics-gp-8dba6faf-94d5-9579-22f0-9c1c6670c0ea).

For more information about how to improve the performance of Report Writer functions, see [How to improve the performance of user-defined Report Writer functions in Microsoft Dynamics GP 9.0 or in Microsoft Great Plains](https://support.microsoft.com/topic/how-to-improve-the-performance-of-user-defined-report-writer-functions-in-microsoft-dynamics-gp-9-0-or-in-microsoft-great-plains-5144cb48-01d0-5a51-ccb1-81d252e749b6).
