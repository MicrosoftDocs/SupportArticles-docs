---
title: New Microsoft SQL Reporting Services Reports for Project Accounting
description: Introduce the new Microsoft SQL Reporting Services Reports for Project Accounting in Microsoft Dynamics GP.
ms.reviewer: theley
ms.date: 03/13/2024
---
# New Microsoft SQL Reporting Services Reports for Project Accounting

This article introduces the new Project Accounting SRS reports in Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 2028986

These are the Project Accounting SRS reports that are now available in Microsoft Dynamics GP 2010.

**Project Accounting Budget vs. Actual with Variance**: Provides the ability to group budget and actual expenditures for a project for selected cost categories and time period.

Source of Data:

- PA01001, PA01101, PA01201, PA01301, PA30100, PA30101, PA30200, PA30201, PA30300, PA30301, PA30500, PA30501, PA30900, PA30901, POP30300, POP30310, PA31101, PA31102, PA23100, PA23202, PA23203, PA33100, PA33202, PA33203, MC40000, MC40200
  
Ranges Available:

- Document Date
- Customer Number
- Contract Number
- Contract Class
- Project ID
- Project Number
- Project Class
- Project Manager
- Business Manager
- Department
  
Sorting Available:

- Customer Number
- Contract Number
- Project ID
- Project Number
- Project Class
- Project Manager
- Business Manager
- Department
  
**Project Accounting Profit and Loss**: Provides the profit and loss for a selected project or range of projects during a selected period of time.

Source of Data:

- RM00101, GL00105, PA01001, PA01201, PA30100, PA30101, PA30200, PA30201, PA30300, PA30301, PA30500, PA30501, PA30900, PA30901, POP30300, POP30310, PA31101, PA31102, PA23100, PA23201, PA23202, PA23203, PA33100, PA23201, PA33202, PA33203, PA33301, PA33302, PA33303, MC40000, MC40200

Ranges Available:

- Document Date
- Customer Number
- Contract Number
- Project Number

Sorting Available:

- Customer Number
- Contract Number
- Project Number

> [!NOTE]
> Uses the default distribution types, accounts and amounts, so if distributions are manipulated from the default, the report information would not match transaction information in Microsoft Dynamics GP.
  
**Project Accounting Closed Projects**: Provides details on closed projects.

Source of Data:

- PA01201

Ranges Available:

- Customer Number
- Contract Number
- Project Class
- Project Number
- End Date

Sorting Available:

- Customer Number
- Contract Number
- Project Number

**Project Accounting Unbilled Expense vs. Retainer**: Compares the project retainer against the charged expenses and the retainer balance for a given project.  

Source of Data:

- PA01101, PA01201, PA01301, PA02101, PA05200, PA30100, PA30101, PA30200, PA30201, PA30300, PA30301, PA30500, PA30501, PA30900, PA30901, PA31101, PA31102, PA13202, PA13201, PA13203, PA23201, MC40200, MC40000

Ranges Available:

- Customer Number
- Contract Number
- Project Class
- Project Number
- As of Date

Sorting Available:

- Project Number
  
**Project Accounting Detail Trial Balance**: This report details the values for accounts effected in Project Accounting. This report first appeared in version 10 for WIP accounts and was updated to include Project Expense, Project Revenue, Unbilled Accounts Receivable, Unbilled Project Revenue, Earnings in Excess of Billings, Billings in Excess of Earnings, Project Billings and Project Loss accounts in GP2010.  

Source of Data:

- GL00105, PA01201, PA30100, PA30101, PA30200, PA30201, PA30300, PA30301, PA30500, PA30501, PA30900, PA30901, POP30300, POP30310, PA31101, PA31102, PA23100, PA23201, PA23202, PA23203, PA33100, PA23201, PA33202, PA33203, PA33301, PA33302, PA33303, PA11905, PA11906, PA33501, MC40000, MC40200

Ranges Available:

- Posting Date
- Project Number
- Cost Category
- Cost Owner

Sorting Available:

- Project Number
- Cost Category ID
- Account Number
- Transaction Type
- Posting Date

> [!NOTE]
> Uses the default distribution types, accounts and amounts, so if distributions are manipulated from the default, the report information would not match transaction information in Microsoft Dynamics GP.

**RM Aged Trial Balance w/Project Information**: Receivables Management Aged Trial Balance information with expanded Project Accounting details. This report will show all Aged Trial Balance information including additional project information for billings that originated in Project Accounting.  

Source of Data:

- RM40201, RM40101, RM00101, PA23200, RM00103, RM40401

Ranges Available:

- Customer Name
- Customer Class
- User Defined 1
- Salesperson
- Sales Territory
- Contract Number
- Project Number

Sorting Available:

- Customer ID
- Customer Name
- Class ID
- Salesperson ID
- Sales Territory ID
- User Defined 1
  
**Combined History**: Combined History Report will show all Project Accounting Cost Transaction information without having to run the Combined History Utility to generate the combined history transactions.  

Source of Data:

- PA41701, PA01101, PA01201, PA01301, PA30100, PA30101, RM00101, UPR00100, PA01001, PA30200, PA30201, PA00701, PA30300, PA30301, PA00801, PA30500, PA30501, PA30900, PA30901, PM00200, POP30310, PA31102

Ranges Available:

- Customer ID
- Contract Number
- Project Number
- Project Class
- Posting Date
  
**Revenue Recognition by Project**: On prior versions revenue recognition document information was difficult to gather and the ranges available were limited. This new report allows you to more easily gather revenue information by a customer, contract, or project range.  

Source of Data:

- PA23301, PA33301, PA23302, PA33304, PA23303, PA33303, PA23304, PA33302

Ranges Available:

- Posting Date
- Customer Number
- Document Number
- Contract Number
- Project Number
