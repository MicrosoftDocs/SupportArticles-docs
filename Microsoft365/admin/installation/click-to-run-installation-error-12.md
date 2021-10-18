---
title: Error 12 when installing Office Click-to-Run
ms.author: v-maqiu
author: MaryQiu1987
manager: dcscontentpm
ms.date: 10/22/2020
ms.topic: article
audience: ITPro
ms.prod: office-perpetual-itpro
localization_priority: Normal
search.appverid:
- SPO160
- MET150
appliesto:
- Office Click-to-Run
ms.custom: 
- CI 124231
- CSSTroubleshoot 
ms.reviewer: dhirenb
description: How to resolve a Microsoft Office Click-to-Run installation when an error code containing the number 12 is received. 
---

# Click-to-Run error (12) when installing Microsoft Office

## Symptoms

You see an error that contains the number "12" when you try to install Microsoft Office Click-to-Run.

## Resolution

Try the following solutions in order.

### Method 1

The COM+ app registration might be failing, caused by antivirus software installed on the client machine. This will prevent **%windir%\system32\dllhost.exe** from accessing specific portions of the HKLM registry keys, such as **HKLM\Software\Classes\CLSID**. To resolve this issue, change the antivirus settings to allow **dllhost.exe** to access HKLM registry keys.

### Method 2

Make sure that **REGDBVersion** (under **HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\COM3**) matches the clb file under **%windir%\Registration**. 

### Method 3

Make sure that COM+ Enabled (under **HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\COM3**) is set to **1**. If COM+ Enabled is set to **0**, it will be disabled.

## More information

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).