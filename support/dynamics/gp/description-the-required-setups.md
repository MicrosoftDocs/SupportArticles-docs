---
title: Description of the required setups
description: Describes the many Fixed Assets windows that can be set up in Microsoft Dynamics GP.
ms.reviewer: theley
ms.date: 03/20/2024
ms.custom: sap:Financial - Fixed Assets
---
# Description of the required setups and the conditionally required setups in Fixed Assets in Microsoft Dynamics GP

This article describes the Fixed Assets setups that are required and the Fixed Assets setups that are conditionally required.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 874033

## Introduction

There are many setups that can be completed for Fixed Assets in Microsoft Dynamics GP and in Microsoft Business Solutions - Great Plains.

## More information

Before you can add any kind of asset information to Fixed Assets, you must enter and complete the setup information. There are certain setups that are required. Other setups are conditionally required, depending on the needs of the company.

To open the Fixed Assets setup windows in Microsoft Dynamics GP 9.0 or in an earlier version, point to **Setup** on the **Tools** menu, point to **Fixed Assets**, and then select the name of the fixed assets window that you want to set up.

To open the Fixed Assets setup windows in Microsoft Dynamics GP 10.0, point to **Tools** on the **Microsoft Dynamics GP** menu, point to **Setup**, point to **Fixed Assets**, and then select the name of the fixed assets window that you want to set up.

## Required setups

The following setups must be completed for Fixed Assets:

- Fixed Assets Fiscal Calendar

    This setup creates the Fixed Assets calendar for all periods that are required for depreciation calculations. It includes past years and future years. The system will model the periods in each year based on the fiscal periods that are currently in the Dynamics fiscal period setup or in the eEnterprise fiscal period setup.
- Quarters

    The Quarter Setup window is used to define the start date, middle date, and the end date of each quarter in a year. If the mid-quarter averaging convention will be used for any asset or if the mass retirement/mass transfer processes will be used, the quarters must be defined in the system.

- Book

    The Book Setup window is used to define the books that are required for your Fixed Assets reporting needs. You can create up to 32 books for each company. However, you must have at least one book set up to depreciate the assets. All assets don't have to be in every book.

- Class

    The Class Setup window is used to define classes/groups of assets based on account information, insurance information, and depreciation rules. You must have at least one class set up in Fixed Assets. When a new asset is added, it must be assigned to a class.
- Book Class

    The Book Class Setup window is used to enter detail information about each class in relation to the books for which it will be depreciating. Typically, a book class record is created for each class and for each book that has been defined.
- Company

    The Company Setup window is used to set parameters that control certain processes in Fixed Assets. It's used to define the corporate book that will interface with the General Ledger and to define the options for account information, the auto add book information, the user data format, the purchasing series integration, and the general information.

## Conditionally required setups

The following setups may be required, depending on the needs of the company:

- Account Group

    The Account Group window is used to define groups of accounts for default purposes. All the accounts under the account group will be inserted into the asset account record when an asset is added.

- Posting Accounts

    The FA-AP Post Accounts Setup window is used to define the account numbers that will trigger the interface from Payables Management or from Purchase Order Processing by account. Typically, the accounts that are entered in this window will be the Fixed Assets clearing accounts.

- Lease Company

    The Lease Company Setup window is used to define valid lease companies.

- Location ID

    The Location Setup window is used to define valid locations that are grouped by city, by county, and by state. Typically, it's used for property tax reporting.

- Physical Location ID

    The Physical Location Setup window is used to define valid physical locations. It can be used for physical inventory together with the Asset Label.

- Structure ID

    The Structure Setup window is used to define valid structure IDs that can be entered when you add Asset General Information. It may contain a value such as a cost center and is usually the same value as a segment of the chart of accounts.

- Retirement Codes

    The Retirement Setup window is used to define the valid retirement codes that may be entered when disposing of an asset.

- Insurance Classes

    The Insurance Setup window is used to group assets according to similar insurance rates, inflation rates, and depreciation rates.
