---
title: 0x80004005 General Error Unable to Open Registry Key
description: Fixes an issue in which you receive 0x80004005 error when trying to access a page that connects to an Access database.
author: helenclu
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.author: luche
ms.custom: 
  - CSSTroubleshoot
appliesto: 
  - Microsoft Access
ms.date: 03/31/2022
---

# PRB: Error Message: 0x80004005: General Error Unable to Open Registry Key

## Symptoms

When you access a page that connects to an Access database, you may receive the following error message in the browser:

```adoc
Microsoft OLE DB Provider for ODBC Drivers (0x80004005)[Microsoft][ODBC Microsoft Access Driver]General error Unable to open registry key 'Temporary (volatile) Jet DSN for process 0x614 Thread 0x6c0 DBC 0x21dd07c Jet'.
(FileName), (LineNumber)
```

## Cause

The account that is being used to access the page does not have access to the HKEY_LOCAL_MACHINE\SOFTWARE\ODBC registry key.

## Resolution

> [!IMPORTANT]
> This section, method, or task contains steps that tell you how to modify the registry. However, serious problems might occur if you modify the registry incorrectly. Therefore, make sure that you follow these steps carefully. For added protection, back up the registry before you modify it. Then, you can restore the registry if a problem occurs. For more information about how to back up and restore the registry, click the following article number to view the article in the Microsoft Knowledge Base: [322756](https://support.microsoft.com/help/322756) How to back up and restore the registry in Windows

1. Start Registry Editor (Regedt32.exe).
2. Select the following key in the registry:

   HKEY_LOCAL_MACHINE\SOFTWARE\ODBC

3. On the Security menu, click Permissions.
4. Type the required permissions for the account that is accessing the Web page.
5. Quit Registry Editor.

## Status

This behavior is by design.