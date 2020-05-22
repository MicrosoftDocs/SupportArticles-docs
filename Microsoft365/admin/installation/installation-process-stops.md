---
title: Office 365 or Office 2013 installation process stops at the "10% - Configuring" stage
description: Resolves an issue in which the Office 365 or Office 2013 installation process stops at the "10% - Configuring" stage.
author: simonxjx
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
- MET150
audience: ITPro
ms.prod: office-perpetual-itpro
ms.topic: article
ms.custom: CSSTroubleshoot
ms.author: v-six
ms.reviewer: mmaxey, tomol, doakm, trevormc, bobbied, swebster, andyfel
appliesto:
- Office 2013
---

# Office 365 or Office 2013 installation process stops at the "10% - Configuring" stage

[!INCLUDE [Branding name note](../../../includes/branding-name-note.md)]

## Symptoms

Assume that you access the Internet by using a proxy server. When you try to install Microsoft Office 365 or Microsoft Office 2013 Click-to-Run, the installation process stops at the "10% - Configuring" stage.

## Cause

This issue occurs because the Internet Explorer proxy is set in the user account instead of in the System account.

## Resolution

To work around this issue, use one of the following methods:

### Method 1

Run the following PsExec command to set the proxy for the System account. To do this, follow these steps:

**Psexec –s "netsh winhttp set proxy **proxyserver**"**

To download the Psexec tool, go to [PsExec v2.2](https://technet.microsoft.com/sysinternals/bb897553.aspx).

### Method 2

Use the Office Deployment Tool to download the Office 365 Click-to-Run source. For more information about how to use the Office Deployment Tool, see [Overview of the Office Deployment Tool](https://technet.microsoft.com/library/jj219424.aspx).

### Method 3

If you are a user of the Microsoft Volume Licensing Service Center, you can download a Windows Installer package (.msi file) volume-licensed edition of Office 2013 from the Volume Licensing Service Center.
