---
title: Set up Fixed Asset Management in Microsoft Dynamics GP
description: Provides steps that you should follow when you use Fixed Asset Management in Microsoft Dynamics GP.
ms.reviewer: theley
ms.topic: how-to
ms.date: 04/17/2025
ms.custom: sap:Financial - Fixed Assets
---
# How to set up Fixed Asset Management in Microsoft Dynamics GP

This article describes how to set up Fixed Asset Management in Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 865914

When you set up Fixed Asset Management in Microsoft Dynamics GP, follow these steps.

## Step 1: Set up Fixed Asset Management before you add any kind of asset information

Before you can add any kind of asset information to Fixed Asset Management, you must enter and then complete the required setup information. Other setup information is conditionally required, depending on the needs of the company. You enter setup information in several windows in Fixed Asset Management. To open these windows, use the appropriate method:

- In Microsoft Dynamics GP 10.0, and higher versions, point to **Tools** on the **Microsoft Dynamics GP** menu, point to **Setup**, point to **Fixed Assets**, and then click the name of the window that you want to open.

- In Microsoft Dynamics GP 9.0 or in earlier versions, point to **Setup** on the **Tools** menu, point to **Fixed Assets**, and then click the name of the window that you want to open.

### Required setup information

You must enter setup information in the following windows:

- Book Class Setup

    Use the Book Class Setup window to enter detailed information about each class and about the books that are depreciated for each class. Typically, a book class record is created for each class and for each book that you define.

- Book Setup

    Use the Book Setup window to define the books that are required for your Fixed Asset Management reporting needs. You can create up to 32 books for each company. However, you must set up at least one book to depreciate the assets. All the assets do not have to be in every book.

- Build Fixed Assets Fiscal Calendar

    Use the Build Fixed Assets Fiscal Calendar window to create the Fixed Asset Management fiscal calendar for all the periods that are required for your depreciation calculations. Include past years and future years. Microsoft Dynamics GP will model the periods in each fiscal year based on the fiscal periods that are set up in Microsoft Dynamics GP or in eEnterprise.

- Class Setup

    Use the Class Setup window to define the classes of assets and the groups of assets. Base the definitions on the account information, on the insurance information, and on the depreciation rules. You must set up at least one class in Fixed Asset Management. When you add a new asset, you must assign that asset to a class.

- Company Setup

  Use the Company Setup window to set parameters that control certain processes in Fixed Asset Management. Use the Company Setup window to define the corporate book that will interface with the general ledger. Also, use this window as follows:
  - To define the options for account information
  - To automatically add book information
  - To configure the user data format
  - To configure the purchasing series integration
  - To configure the general information

- Quarter Setup

Use the Quarter Setup window to define the start date, the middle date, and the end date of each quarter in a year. If you will use the mid-quarter averaging convention for any asset, you must define the quarters in Microsoft Dynamics GP. You must also define the quarters in Microsoft Dynamics GP if you will use the mass retirement process or the mass transfer process.

### Conditionally required setup information

You may have to enter setup information in one or more of the following windows, depending on the needs of the company:

- Account Group

  Use the Account Group window to define groups of accounts for default purposes. All the accounts under the account group will be inserted into the asset account record when an asset is added.

- Insurance Setup

    Use the Insurance Setup window to group assets according to similar insurance rates, to similar inflation rates, and to similar depreciation rates.

- FA-AP Post Accounts Setup

    Use the FA-AP Post Accounts Setup window to define the account numbers that will trigger the interface from the following modules:
  - Payables Management in Microsoft Dynamics GP
  - Purchase Order Processing in Microsoft Dynamics GP.
  
    Typically, you enter the Fixed Asset Management clearing accounts in this window.

- Lease Company Setup

    Use the Lease Company Setup window to define valid lease companies.

- Location Setup

    Use the Location Setup window to define valid locations that are grouped by city, by county, and by state. Typically, you enter this setup information for property tax reporting.

- Physical Location Setup

    Use the Physical Location Setup window to define valid physical locations. You can use this window for items that have an asset label and that are in the physical inventory.

- Retirement Setup

    Use the Retirement Setup window to define the valid retirement codes that may be entered when the company disposes of an asset.

- Structure Setup

    Use the Structure Setup window to define valid structure IDs that can be entered when you add general asset information. The Structure Setup window may contain a value such as a cost center. This value is typically the same value as a segment of the chart of accounts.

## Step 2: Enter existing assets

To enter existing assets in Microsoft Dynamics GP, we recommend that you use one of the following methods:

- Use the following windows:
  - Asset General Information
  - Asset Account Information
  - Asset Book Information
  - Other asset windowsFor more information, see Chapter 4, "Fixed Asset Management cards" in the FixedAssets.pdf document. This document is in the Documentation subfolder of the Microsoft Dynamics GP application folder.

- Use the Asset Import Export utility.

- Use a conversion service to transfer the Fixed Asset Management data from an existing Microsoft Dynamics GP installation to the new installation.

We do not recommend that you use another import tool, such as Dynamics Table Import for the following reasons:

- Each asset may contain information in multiple tables.

- The cost, the year-to-date depreciation amount, the life-to-date depreciation amount, and the depreciated-to-date information must all match for each asset book.

If you add the assets at the end of a fiscal year, the year-to-date depreciation amount should be zero, and the depreciated-to-date information should be for the last day of the year. Otherwise, the life-to-date depreciation amount should include the year-to-date depreciation amount. And, the depreciated-to-date information should be the date through which depreciation was calculated. Also, be aware that the current fiscal year in the book setup record should be the current fiscal year.

## Step 3: Review reports

Review reports such as the Depreciation Ledger report and the Depreciation Detail report to make sure that you entered all the assets together with the correct amounts. For more information, see Chapter 19, "Reports" in the FixedAssets.pdf document.

Balance the following totals against the balances from your previous system:

- The total cost per book
- The total life-to-date depreciation
- The total year-to-date depreciation

Optionally, you can run projected depreciation for the next periods. Then, you can review the periodic projection reports.

## Step 4: Process the general ledger interface

For more information about how to process the general ledger interface, see Chapter 14, "General Ledger integration" in the FixedAssets.pdf document.

Fixed Asset Management automatically generates entries for the general ledger when you add assets. These entries are stored in the Financial Detail file. Review the report from the general ledger interface to make sure that the account numbers in the Asset Account records have been entered correctly.

If you previously posted the entries to General Ledger in Microsoft Dynamics GP, the financial entries that are generated by Fixed Asset Management should not be posted to General Ledger. You should create the batch in Fixed Asset Management and then flag the records in the Financial Detail file. The batch number, the transaction date, a date stamp, and a time stamp will be added to the records that were updated by the general ledger interface. Then, delete the FATRX **xxxx** batch.

## Step 5: Delete the batch that is created when you process the general ledger interface

When you process the general ledger interface, a batch is created. Do not post this batch to General Ledger in Microsoft Dynamics GP.
