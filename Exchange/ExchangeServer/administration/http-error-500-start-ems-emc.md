---
title: HTTP 500 when you start Exchange Management Shell
description: Provides resolutions to help resolve the HTTP error 500 when you try to start Exchange Management Shell or Exchange Management Console.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:OWA  And Exchange Admin Center\Issues connecting to Exchange Management Shell
  - Exchange Server
  - CSSTroubleshoot
ms.reviewer: benwinz, v-six
search.appverid: 
  - MET150
appliesto: 
  - Exchange Server 2010
ms.date: 01/24/2024
---
# HTTP server error status (500) when you try to start Exchange Management Shell or Exchange Management Console

_Original KB number:_ &nbsp; 2027063

## Symptoms

When you try to start EMS or EMC on a computer that is running Exchange Server 2010, you receive the following error message:

> Connecting to remote server failed with the following error message: The WinRM client received an HTTP server error status (500), but the remote service did not include any other information about the cause of the failure. For more information, see the about_Remote_Troubleshooting Help topic. It was running the command 'Discover-ExchangeServer -UseWIA $true -SuppressError $true'.

Additionally, you may see the following warning event logged in the System log:

> Source: Microsoft-Windows-WinRM  
> EventID: 10113  
> Level: Warning  
> Description: Request processing failed because the WinRM service cannot load data or event source: DLL="%ExchangeInstallPath%Bin\Microsoft.Exchange.AuthorizationPlugin.dll"

## Cause

This problem occurs because one of the following conditions is true:

- The **ExchangeInstallPath** variable is missing.
- The path of the PowerShell virtual directory was modified.

## Resolution

To resolve this problem, use one of the following methods:

- Make sure that the **ExchangeInstallPath** value is set correctly.

    To do this, open the **System** item in **Control Panel**, click **Advanced system settings**, and then click **Environment variables** on the **Advanced** tab. In the **System variables** box, locate the **ExchangeInstallPath** variable. The corresponding value for this variable should be `C:\Program Files\Microsoft\Exchange Server\V14\`.

- In IIS Manager, locate the entry for the PowerShell virtual directory under **Default Web Site**. Then, make sure that the entry points to the `\Program Files\Microsoft\Exchange Server\v14\ClientAccess\PowerShell` folder.
