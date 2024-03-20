---
title: The Developer Toolkit for Microsoft Dynamics GP
description: This article describes the Developer Toolkit for Microsoft Dynamics GP.
ms.reviewer: theley
ms.date: 03/20/2024
ms.custom: sap:Developer - Customization and Integration Tools
---
# The Developer Toolkit for Microsoft Dynamics GP

This article describes the Developer Toolkit for Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 914090

## Summary

Microsoft Dynamics GP includes the Developer Toolkit for Microsoft Dynamics GP. This toolkit consists of three components that developers can use to build Microsoft .NET-based solutions, customizations, and extensions. The three components are eConnect, Web Services for Microsoft Dynamics GP, and Visual Studio Tools for Microsoft Dynamics GP.

## Introduction

This article discusses the three components of the Developer Toolkit for Microsoft Dynamics GP. These components are as follows:

- Web Services for Microsoft Dynamics GP
- Visual Studio Tools for Microsoft Dynamics GP
- eConnect

This article also includes information about availability of the components.

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

## How to install eConnect

To install eConnect, use one of the following methods:

- Perform a Runtime installation. To do this, locate the following file on the Dynamics GP media and then double-click the file.

   > [!NOTE]
   > The Runtime Install option appears on the splash screen.  
   > `\AdProd\eConnect\Microsoft_Business_Solutions_eConnect_Runtime.exe`

- Perform a full eConnect installation. To do this, locate the following file on the media and then double-click the file:

   `\Tools\eConnect_SDK\Microsoft_Business_Solutions_eConnect.exe`
