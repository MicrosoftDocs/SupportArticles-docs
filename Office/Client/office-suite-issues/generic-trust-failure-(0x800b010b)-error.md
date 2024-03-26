---
title: Generic Trust Failure (0x800B010B) error
description: Fixes an issue in which you receive a Generic Trust Failure (0x800B010B) error message when you try to install Visual Studio 2010 Tools for Office Runtime.
author: helenclu
ms.author: luche
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.reviewer: praveenb, sakris
ms.custom: 
  - CSSTroubleshoot
search.appverid: 
  - MET150
appliesto: 
  - Microsoft Office 2013 Service Pack 1
  - Microsoft Office 2010 Service Pack 2
ms.date: 03/31/2022
---

# "Generic Trust Failure (0x800B010B)" error when you install Visual Studio 2010 Tools for Office Runtime

## Symptoms

When you try to install [Visual Studio 2010 Tools for Office Runtime](https://www.microsoft.com/download/details.aspx?id=105522), you receive the following error message:

> Generic Trust Failure (0x800B010B)

Additionally, an error message that resembles the following is logged in the MSI log:

> c:\\\<temp folder>\vstor40\vstor40_x64.exe - Signature verification for file vstor40\vstor40_x64.exe (c:\\\<temp folder>\vstor40\vstor40_x64.exe) failed with error 0x800b010a (A certificate chain could not be built to a trusted root authority.) No FileHash provided. Cannot perform FileHash verification for vstor40\vstor40_x64.exe File vstor40\vstor40_x64.exe (c:\\\<temp folder>\vstor40\vstor40_x64.exe), failed authentication. (Error = -2146762486). It is recommended that you delete this file and retry setup again. ServiceControl operation succeeded! Final Result: Installation failed with error code: (0x800B010B), "Generic trust failure."

## Cause

This problem occurs because Visual Studio 2010 Tools for Office Runtime are being signed by using a set of new certificates that require updating. Typically, the Windows root certificate program automatically downloads these new root certificates. However, the Windows root certificate program may not function as expected if the computer is disconnected from the Internet or if the root certificates update is disabled through Group Policy.

## Resolution

To resolve this problem, make sure that the computer is connected to Internet and that the Windows root certificate program can update root certificates. 

To check the setting on your computer for the Group Policy that controls automatic certificate updates, follow these steps: 

1. Open the Local Group Policy Editor (Gpedit.msc).   
2. Under **Computer Configuration**, expand **Administrative Templates**, expand **Internet Communication Management**, and then click **Internet Communication settings**.    
3. Check the status of the **Turn off Automatic Root Certificates Update** control.   
Also, see [Configure trusted roots and disallowed certificates](https://technet.microsoft.com/library/dn265983.aspx).

## Workaround

To work around this issue, use the executable file because the file is signed by using an older root certificate that may exist on the computer. To do this, follow these steps:

1. Extract the installation file for Visual Studio 2010 Tools for Office Runtime. To do this, run the following command: 

   `vstor_redist.exe /x`
1. Select a folder in which to extract the file.   
1. Run the executable file to install Visual Studio 2010 Tools for Office Runtime.

   **Note** The executable file resembles Vstor40_*.exe and is located in the Vstor40 subfolder. Select the executable file that corresponds to the bit value of the Windows Operating System.     
