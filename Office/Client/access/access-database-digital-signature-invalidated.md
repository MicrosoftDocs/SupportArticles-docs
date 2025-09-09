---
title: The digital signature in Access is tampered with or invalidated
description: Describes database usage scenarios that are known to invalidate the digital signature of an Access database. Provides workarounds.
author: Cloud-Writer
manager: dcscontentpm
ms.custom: 
  - CI 177076
  - CSSTroubleshoot
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.author: meerak
ms.reviewer: denniwil
ms.date: 05/26/2025
---

# The digital signature in Access is tampered with or invalidated

## Symptoms

Consider the following scenario:

- Microsoft Access is configured to **Disable all macros except digitally signed macros** within the Microsoft Access [Trust Center settings](https://support.microsoft.com/office/enable-or-disable-macros-in-microsoft-365-files-12b036fd-d140-4e74-b45e-16fed1a7e5c6).
- You open a digitally signed database outside a trusted folder location.

In this scenario, you might receive one or more of the following messages that indicate that the [digital signature](https://support.microsoft.com/office/show-trust-by-adding-a-digital-signature-5f4ebff3-360d-4b61-b2f8-ce0dfb53adf6) that's applied to the database is no longer valid:

- Modifications to the database or project have invalidated the associated digital signature. This may require you to make a trust decision the next time you open the database or project.
- The active content in this file is blocked. Review your Trust Center settings or contact your IT administrator.
- Some active content has been disabled
- Warning: The digital signature has been tampered with after the content was signed. This content can't be trusted.

## Cause

The following database usage scenarios are known to invalidate the digital signature:

- You import, modify, or create forms, reports, macros, or modules
- You import, modify, or create action queries
- You import, modify, or create passthrough queries
- You add, change, or remove Visual Basic for Applications (VBA) references
- You distribute a database that contains ActiveX controls to a computer that uses a different bit version of Microsoft 365 than where the digital signature is applied
- The [Perform name autocorrect](https://support.microsoft.com/office/set-name-autocorrect-options-981b70ef-56ea-47a8-8bb4-a93c10a9d98b#bm3) option is enabled and there are pending name corrections
- The [Track name autocorrect info](https://support.microsoft.com/office/set-name-autocorrect-options-981b70ef-56ea-47a8-8bb4-a93c10a9d98b#bm3) option is enabled after the digital signature is applied 

## Workarounds

To work around this issue, select the option for the appropriate scenario.

### Action queries and passthrough queries

You can use VBA code to create, modify, or delete action queries and passthrough queries in Access without invalidating the digital signature. This is true as long as any changes to objects are reverted in the same database session. 

For example, the digital signature isn't invalidated in the following scenarios:

- You use the [CreateQueryDef](/office/client-developer/access/desktop-database-reference/database-createquerydef-method-dao) method to create a new named passthrough query. Before you close the database, you delete the passthrough query by using the `QueryDefs.Delete` method.
- You use a [QueryDefs collection](/office/client-developer/access/desktop-database-reference/querydefs-collection-dao) to locate a named passthrough query, and you edit the `QueryDef.SQL` property. Before you close the database, you revert the `QueryDef.SQL` property to its original value.
- You create and run an action query or passthrough query by using a temporary [QueryDef](/office/client-developer/access/desktop-database-reference/querydef-object-dao) object.

### The Perform name AutoCorrect option is enabled

Before you apply a digital signature, make sure that there are no pending name corrections. To do this, open and save any objects that might contain pending changes.

**Note:** For databases that have many objects, consider using a code loop to perform this task.

### The Track name AutoCorrect info option is enabled after the digital signature is applied

Enable the **Track name AutoCorrect info** option before you apply a digital signature.

### For the other scenarios that can invalidate the digital signature

Consider using a split database in which the front-end database has a digital signature applied. After each use, replace the front-end database with a new copy by using a batch file or other script.
