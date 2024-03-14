---
title: Office 2010 installation requires MSXML
description: Describes that you receive an error message when you try to install Office 2010 on a Windows 7-base computer.
author: helenclu
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
  - MET150
audience: ITPro
ms.custom: 
  - CSSTroubleshoot
ms.topic: troubleshooting
ms.author: luche
appliesto: 
  - Office 2010
ms.date: 03/31/2022
---

# "The installation of Microsoft Office 2010 requires that MSXML version 6.10.1129.0 be installed on your computer" when you install Office 2010 on a Windows 7-based computer

## Symptoms

When you install Office 2010 on a Windows 7-based computer, you may receive the following error message: 

```adoc
Setup is unable to proceed due to the following error(s): The installation of Microsoft Office 2010 requires that MSXML version 6.10.1129.0 be installed on your computer. Install the component and re-run the setup.
```

## Cause

This issue occurs when incorrect permissions are set on a registry entry.

## Resolution

> [!IMPORTANT]
> This section, method, or task contains steps that tell you how to modify the registry. However, serious problems might occur if you modify the registry incorrectly. Therefore, make sure that you follow these steps carefully. For added protection, back up the registry before you modify it. Then, you can restore the registry if a problem occurs. For more information about how to back up and restore the registry, see [How to back up and restore the registry in Windows](https://support.microsoft.com/help/322756).

To resolve this issue, follow these steps:

1. Click **Start**, click **Run**, type regedit, and then click **OK**.   
2. Locate HKEY_CLASSES_ROOT\TypeLib\\{F5078F18-C551-11D3-89B9-0000F81FE221}\6.0\0\win32.
3. Right-click **win32**, and then Click **Permissions**.   
4. Give yourself Full Controlto the key.   
5. Double-click the **(Default)** value under **win32**, and then change its value from %SystemRoot%\System32\msxml6.dllto C:\Windows\System32\msxml6.dll.  
6. Install Office 2010 again.   
