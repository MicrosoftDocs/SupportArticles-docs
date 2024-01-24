---
title: Chinese (Simplified) input method doesn't work
description: Address an issue in which Windows continues to type and display in English when a domain user uses the Chinese (Simplified) input method in Windows Server 2012.
ms.date: 04/28/2023
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.service: windows-server
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:setup, csstroubleshoot
ms.subservice: deployment
---
# Domain users can't type Chinese (Simplified) in Windows Server 2016

This article helps fix an issue where Windows continues to type and display in English when a domain user uses the Chinese (Simplified) input method.

_Applies to:_ &nbsp; Windows Server 2016  
_Original KB number:_ &nbsp; 4040941

## Symptoms

In a domain, a user logs on to a Windows Server 2016-based computer and set the default language to **Chinese (Simplified)** in **Control Panel**. When the user tries to type by using the Chinese input method, Windows continues to type and display in English.

> [!NOTE]
> This issue occurs only with the **Chinese (Simplified)** input method. Other languages input methods, such as **Chinese (traditional)**, work fine.

## Cause

This issue occurs because the following registry key is missing:

`HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\LexiconUpdate\loc_0804`

## Resolution

To fix this issue, follow these steps:

1. Open Registry Editor.
2. Locate `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft`and create a new key that's named **LexiconUpdate**.
3. Create a new key under `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\LexiconUpdate` and name it **loc_0804**.
4. Restart the computer.

## Data collection

If you need assistance from Microsoft support, we recommend you collect the information by following the steps mentioned in [Gather information by using TSS for deployment-related issues](../../windows-client/windows-troubleshooters/gather-information-using-tss-deployment.md).
