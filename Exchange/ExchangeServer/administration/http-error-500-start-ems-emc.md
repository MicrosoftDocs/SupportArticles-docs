---
title: HTTP 500 error when you start Exchange Management Shell or Exchange Management Console
description: Provides guidance to resolve HTTP 500 errors that occur when starting the Exchange Management Shell or Exchange Management Console.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:OWA  And Exchange Admin Center\Issues connecting to Exchange Management Shell
  - Exchange Server
  - CSSTroubleshoot
  - CI 9823
  - CI 11512
ms.reviewer: benwinz, v-six, v-kccross
search.appverid: 
  - MET150
appliesto: 
  - Exchange Server SE
  - Exchange Server 2019
  - Exchange Server 2016
ms.date: 04/26/2026
---

# HTTP server error status (500) when you try to start Exchange Management Shell (EMS) or Exchange Management Console (EMC)

_Original KB number:_ &nbsp; 2027063

## Summary

An HTTP 500 error might occur when starting the EMS or EMC because of a missing `ExchangeInstallPath` system variable or an incorrect PowerShell virtual directory path. This article explains how to correct these settings.

## Symptoms

When you try to start EMS or EMC on a computer that is running Exchange Server, you receive the following error message:

> Connecting to remote server failed with the following error message: The WinRM client received an HTTP server error status (500), but the remote service did not include any other information about the cause of the failure. For more information, see the about_Remote_Troubleshooting Help topic. It was running the command 'Discover-ExchangeServer -UseWIA $true -SuppressError $true'.

Additionally, you might see the following warning event logged in the Windows System log:

> Source: Microsoft-Windows-WinRM  
> EventID: 10113  
> Level: Warning  
> Description: Request processing failed because the WinRM service cannot load data or event source: DLL="%ExchangeInstallPath%Bin\Microsoft.Exchange.AuthorizationPlugin.dll"

## Cause

This problem occurs because one of the following conditions is true:

- The **ExchangeInstallPath** system variable is missing.
- The path of the PowerShell virtual directory was modified.

## Resolution

To resolve this problem, use one of the following methods:

- Make sure that the `ExchangeInstallPath` value is set correctly.

    Follow these steps to set the `ExchangeInstallPath` system variable:
    1. Open the **System** item in **Control Panel**.
    1. Select **Advanced system settings**.
    1. Select **Environment variables** on the **Advanced** tab.
    1. In the **System variables** box, locate the `ExchangeInstallPath` variable. Enter the correct value for this variable. By default, the value should be `C:\Program Files\Microsoft\Exchange Server\V15\`.

- In IIS Manager, under **Default Web Site**, locate the entry for the PowerShell virtual directory. Then, make sure that the entry points to the `\Program Files\Microsoft\Exchange Server\v15\ClientAccess\PowerShell` folder.
