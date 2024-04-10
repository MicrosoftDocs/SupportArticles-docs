---
title: Determine the type of processor
description: Describes how to determine the type of processor that is used on a computer.
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, joscon
ms.custom: sap:Windows Device and Driver Management\Peripherals driver installation or update, csstroubleshoot
---
# How to determine the type of processor that your computer uses

This article describes how to determine the type of processor that is used on a computer.

_Applies to:_ &nbsp; Windows Server 2012 R2, Windows 10 - all editions  
_Original KB number:_ &nbsp; 888731

## Introduction

This article describes how to determine the processor type of a computer that is running any one of the following operating systems:  

- Microsoft Windows Server 2003, Enterprise x64 Edition  
- Microsoft Windows Server 2003, Standard x64 Edition
- Microsoft Windows Server 2003, Datacenter x64 Edition
- Microsoft Windows XP Professional x64 Edition

## More information

Information about the processor type is stored in the PROCESSOR_IDENTIFIER registry entry in the following registry subkey:  
`HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\Session Manager\Environment`  
The PROCESSOR_IDENTIFIER registry entry uses a string value that is described as follows:  

- If the string value contains "AMD64" (without the quotation marks), the computer has an Advanced Micro Devices (AMD) AMD64 processor.
- If the string value contains "EM64T" (without the quotation marks), the computer has an Intel Extended Memory 64 Technology (EM64T) processor.  

> [!NOTE]
> The value of the PROCESSOR_ARCHITECTURE registry entry in the following registry subkey is set to AMD64 regardless of the type of processor that the computer uses: `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Environment`  
To determine the processor type, use one of the following methods.

### Method 1: Use the set command

To use the set command to determine the processor type, follow these steps:  

1. Click **Start**, click **Run**, type cmd in the **Open** box, and then press ENTER.
2. At the command prompt, type set, and then press ENTER.
3. Note the string that is displayed next to PROCESSOR_IDENTIFIER.

### Method 2: Use Registry Editor

To use Registry Editor to determine the processor type, follow these steps:  

1. Click **Start**, click **Run**, type regedit in the **Open** box, and then click **OK**.
2. Locate and then click the following registry subkey:  
`HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\Session Manager\Environment`  

3. In the right pane, note the string that is displayed in the **Data** column for the PROCESSOR_IDENTIFIER registry entry.
4. Quit Registry Editor.  

### Technical support for x64-based versions of Microsoft Windows

Your hardware manufacturer provides technical support and assistance for x64-based versions of Windows. Your hardware manufacturer provides support because an x64-based version of Windows was included with your hardware. Your hardware manufacturer might have customized the installation of Windows with unique components. Unique components might include specific device drivers or might include optional settings to maximize the performance of the hardware. Microsoft will provide reasonable-effort assistance if you need technical help with your x64-based version of Windows. However, you might have to contact your manufacturer directly. Your manufacturer is best qualified to support the software that your manufacturer installed on the hardware.

## Data collection

If you need assistance from Microsoft support, we recommend you collect the information by following the steps mentioned in [Gather information by using TSS for deployment-related issues](../../windows-client/windows-troubleshooters/gather-information-using-tss-deployment.md).
