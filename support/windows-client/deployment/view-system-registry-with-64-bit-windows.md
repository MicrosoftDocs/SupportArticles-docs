---
title: View registry keys with 64-bit versions of Windows
description: Describes how to view the Windows registry by using 64-bit versions of Windows.
ms.date: 04/28/2023
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.service: windows-client
localization_priority: medium
ms.reviewer: kaushika, MBIAS
ms.custom: sap:servicing, csstroubleshoot
ms.subservice: deployment
---
# View the system registry by using 64-bit versions of Windows

This article describes how to view the Windows registry by using 64-bit versions of Windows.

_Applies to:_ &nbsp; Windows 10 - all editions  
_Original KB number:_ &nbsp; 305097

## Summary

The registry in 64-bit versions of Windows is divided into 32-bit and 64-bit keys. Many of the 32-bit keys have the same names as their 64-bit counterparts, and vice versa.

The default 64-bit version of Registry Editor (Regedit.exe) that is included with 64-bit versions of Windows displays both 64-bit keys and 32-bit keys. The WOW64 registry redirector presents 32-bit programs with different keys for 32-bit program registry entries. In the 64-bit version of Registry Editor, 32-bit keys are displayed under the `HKEY_LOCAL_MACHINE\Software\WOW6432Node` registry key.

## View 64-bit and 32-bit registry keys

You can view or edit both 64-bit and 32-bit registry keys and values by using the default 64-bit version of Registry Editor. To view or edit 64-bit keys, you must use the 64-bit version of Registry Editor (Regedit.exe). You can also view or edit 32-bit keys and values by using the 32-bit version of Registry Editor in the `%systemroot%\Syswow64` folder. There are no differences in the way you perform tasks between the 32-bit version of Registry Editor and the 64-bit version of Registry Editor. To open the 32-bit version of Registry Editor, follow these steps:

1. Click **Start**, and then click **Run**.
2. In the **Open** box, type `%systemroot%\syswow64\regedit`, and then click **OK**.

    > [!NOTE]
    > You must close the 64-bit version of Registry Editor before you can open the 32-bit version (and vice versa) unless you start the second instance of Registry Editor with the `-m` switch. For example, if the 64-bit version of Registry Editor is already running, type `%systemroot%\syswow64\regedit -m` in step 2 to start the 32-bit version of Registry Editor.

To support the co-existence of 32-bit and 64-bit COM registration and program states, WOW64 presents 32-bit programs with an alternate view of the registry. 32-bit programs see a 32-bit `HKEY_LOCAL_MACHINE\Software` tree (`HKEY_LOCAL_MACHINE\Software\WOW6432Node`) that is completely separate from the true 64-bit `HKEY_LOCAL_MACHINE\Software` tree. This isolates `HKEY_CLASSES_ROOT`, because the per-computer portion of this tree resides within the `HKEY_LOCAL_MACHINE\Software` registry key.

To enable 64-bit/32-bit program interoperability through COM and other mechanisms, WOW64 uses a Registry Reflector that mirrors certain registry keys and values between the 64-bit and 32-bit registry views. The reflector is intelligent, in that is only reflects COM activation data.

## Reflected keys

The WOW64 Registry reflector may modify the contents of keys and values during the reflection process to adjust path names, and so on. Because of this, the 32-bit and 64-bit contents may differ. For example, pathnames that contain the **system32** registry entry are written as **SysWOW64** in the 32-bit section of the registry. The following keys are reflected:

- `HKEY_LOCAL_MACHINE\Software\Classes` 
- `HKEY_LOCAL_MACHINE\Software\COM3` 
- `HKEY_LOCAL_MACHINE\Software\Ole` 
- `HKEY_LOCAL_MACHINE\Software\EventSystem` 
- `HKEY_LOCAL_MACHINE\Software\RPC` 

## Data collection

If you need assistance from Microsoft support, we recommend you collect the information by following the steps mentioned in [Gather information by using TSS for deployment-related issues](../windows-troubleshooters/gather-information-using-tss-deployment.md).
