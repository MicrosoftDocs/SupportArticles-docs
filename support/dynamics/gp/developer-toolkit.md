---
title: The Developer Toolkit for Microsoft Dynamics GP
description: This article describes the Developer Toolkit for Microsoft Dynamics GP.
ms.reviewer: 
ms.date: 03/31/2021
---
# The Developer Toolkit for Microsoft Dynamics GP

This article describes the Developer Toolkit for Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 914090

## Summary

Microsoft Dynamics GP 9.0 includes the Developer Toolkit for Microsoft Dynamics GP, a new integration package. This toolkit consists of three components that developers can use to build Microsoft .NET-based solutions, customizations, and extensions. One component, eConnect, is available on CD2 of the Microsoft Dynamics GP 9.0 CDs. The other components, Web Services for Microsoft Dynamics GP and Visual Studio Tools for Microsoft Dynamics GP, will be available when Microsoft Dynamics GP 9.0 Extensions is released.

## Introduction

This article discusses the three components of the Developer Toolkit for Microsoft Dynamics GP. These components are as follows:

- Web Services for Microsoft Dynamics GP
- Visual Studio Tools for Microsoft Dynamics GP
- eConnect

This article also includes information about availability and pricing.

## Components of the Developer Toolkit for Microsoft Dynamics GP

- Web Services for Microsoft Dynamics GP

  By using the new, extensible Web Services for Microsoft Dynamics GP, you can connect applications to your financial management data and support many different models for data access. The Web Services component of the toolkit includes several service layers that allow for extensive Microsoft Dynamics GP module objects, security, policy validations, and defaulting and exception management.

- Visual Studio Tools for Microsoft Dynamics GP

  By using Visual Studio Tools for Microsoft Dynamics GP, you can use Microsoft Visual Studio .NET and .NET languages to build an integration add-in to the Microsoft Dynamics GP application. The architecture lets you use industry standard tools such as Microsoft Visual Studio to perform the following tasks:

  - Respond to Microsoft Dynamics GP events

  - Programmatically reference Microsoft Dynamics GP forms, windows, scrolling windows, fields, global variables, and global scripts

  - Form global scripts

- eConnect

  Although the Web Services component of the toolkit is the preferred tool for integrating data, some objects may not be available. In this case, you can call the eConnect API directly. eConnect is a tool that gives you fast access to the back office of transactions in Microsoft Dynamic GP by calling COM-based or .NET-based API adapters. eConnect combines the use of business logic in the following areas to integrate your data into Microsoft Dynamics GP:

  - Stored procedures
  - Triggers
  - Custom tables
  - XML documentation
  - Optional Windows EAI services

## Availability of the components

The eConnect component of the toolkit is currently available on CD 2 of the Microsoft Dynamics GP 9.0 CDs. The Web Services and Visual Studio Tools components will be available when Microsoft Dynamics GP 9.0 Extension is released. Microsoft Dynamics GP 9.0 Extension is currently scheduled to be released in the early second quarter of calendar year 2006.

To install eConnect from CD 2 of the Microsoft Dynamics GP CDs, use one of the following methods:

- Perform a Runtime installation. To do this, locate the following file on CD 2, and then double-click the file.

   > [!NOTE]
   > The Runtime Install option appears on the splash screen on CD 2.
   > `\AdProd\eConnect\Microsoft_Business_Solutions_eConnect_Runtime.exe`

- Perform a full eConnect installation from CD 2. To do this, locate the following file on CD 2, and then double-click the file:

   `\Tools\eConnect_SDK\Microsoft_Business_Solutions_eConnect.exe`

Installation programs for Web Services and for Visual Studio Tools will be available for download when those components are released.

## Pricing

- Customers

  Starting with Microsoft Dynamics GP 9.0, Microsoft Dynamics GP Professional customers who want to develop their own solutions can purchase the Developer Toolkit. When you purchase the Developer Toolkit, Microsoft grants you a single limited license to the full eConnect installation to use together with your custom internal software products. (For example, Microsoft grants you a single limited license to Microsoft_Business_Solutions_eConnect.exe.) You can use eConnect for the sole purpose of designing, developing, and testing these software products. Updates to the Developer Toolkit are made available for all customers who are current on their product enhancement fees. For specific pricing information, contact your local partner.

- Partners and ISVs

  Starting with Microsoft Dynamics GP 9.0, Microsoft Certified Partners and ISVs can also purchase the Developer Toolkit. For partners and ISVs, the price of the Developer Toolkit is an annual fee that also gives them the right to install unlimited copies of the eConnect full and Runtime installations. Partners and ISVs can use eConnect for the sole purpose of developing, designing, and supporting their custom software solutions. Microsoft also grants partners the right to distribute their software solutions together with the Developer Toolkit Runtime (eConnect Runtime) installation at no more charge. For specific partner pricing, contact your designated Microsoft representative.

- eConnect 8.0.x.x users

  Microsoft grants all customers and partners who purchase the Developer Toolkit access to eConnect version 8.0.4.x (eConnect 8.0 with Service Pack 4) without any other charges. No registration keys are required for the full installation or the Runtime installation of eConnect 8.0 Service Pack 4. Any earlier releases of eConnect 8.0.x.x require the latest update to the registration section of the product.

## References

[General Information](/previous-versions/ms940704(v=msdn.10))

The issue that is described in the Introduction section does not apply to Dynamics GP 10.0.
