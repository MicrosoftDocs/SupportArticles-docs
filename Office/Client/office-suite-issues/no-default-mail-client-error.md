---
title: No default mail client error
description: Describes an issue in which you receive No default mail client error when you attempt to send a file from Office programs. Provides a solution.
author: helenclu
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - CSSTroubleshoot
ms.author: luche
appliesto: 
  - Microsoft Office
ms.date: 03/31/2022
---

# "No default mail client" error when sending files from Office programs

## Symptoms

When you attempt to send a file from Microsoft Excel, Microsoft  Word, or Microsoft PowerPoint using email, you receive the following error:

```adoc
Either there is no default mail client or the current mail client cannot fulfill the messaging request. Please run Microsoft Outlook and set it as the default  mail client. 
```

## Cause

This problem occurs when the following registry data is present on your computer:

- 32-bit versions of Microsoft Office on 32-bit versions of Windows, or 64-bit versions of Microsoft Office on 64-bit versions of Windows

    Key: **HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows Messaging Subsystem\MSMapiApps**

    REG_SZ: **Version**

    Data value: \<no data\>

- 32-bit versions of Microsoft Office on 64-bit versions of Windows

    Key: **HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Microsoft\Windows Messaging Subsystem\MSMapiApps**

    REG_SZ: **Version**

    Data value: \<no data\>

**NOTE**: If you do not find the **Version** value with no data associated with it, or the **Version** value does not exist at all under this registry path, then there is a different cause of the error. Please search the Microsoft Knowledge Base for additional causes of this error.

## Resolution

> [!IMPORTANT]
> This section, method, or task contains steps that tell you how to modify the registry. However, serious problems might occur if you modify the registry incorrectly. Therefore, make sure that you follow these steps carefully. For added protection, back up the registry before you modify it. Then, you can restore the registry if a problem occurs. For more information about how to back up and restore the registry, see [How to back up and restore the registry in Windows](https://support.microsoft.com/kb/322756/).
  
To resolve this problem, delete the Version value from under the \MSMapiApps key using the following steps:

- 32-bit versions of Microsoft Office on 32-bit versions of Windows, or 64-bit versions of Microsoft Office on 64-bit versions of Windows

  1. Start Registry Editor.
  2. Locate and select the following key in the registry:

     **`HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows Messaging Subsystem\MSMapiApps`**

  3. Right-click the REG_SZ value called **Version** under the **MSMapiApps** key and select **Rename**.
  4. Rename the **Version** value to **Version_Renamed**.
  5. Exit Registry Editor.
- 32-bit versions of Microsoft Office on 64-bit versions of Windows
  1. Start Registry Editor.
  2. Locate and select the following key in the registry:

    **`HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Microsoft\Windows Messaging Subsystem\MSMapiApps`**
  3. Right-click the REG_SZ value called Version under the **MSMapiApps** key and select **Rename**.
  4. Rename the **Version** value to **Version_Renamed**.
  5. Exit Registry Editor.
