---
title: Determine hardware DEP is available
description: Describes the requirements for using hardware-enforced DEP. Also describes how to confirm that hardware DEP is working.
ms.date: 09/27/2020
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, chrisw, patste, mmill
ms.custom: sap:performance-monitoring-tools, csstroubleshoot
---
# How to determine that hardware DEP is available and configured on your computer

This article describes how to determine that hardware DEP is available and configured on your computer.

_Applies to:_ &nbsp; Windows Server 2012 R2, Windows 10 - all editions  
_Original KB number:_ &nbsp; 912923

## Introduction

Data Execution Prevention (DEP) is a set of hardware and software technologies that perform additional checks on memory to help protect against malicious code exploits.

Hardware-enforced DEP marks all memory locations in a process as non-executable unless the location explicitly contains executable code. A type of malicious code attacks tries to insert and run code from non-executable memory locations. DEP helps prevent these attacks by intercepting them and raising an exception.

This article describes the requirements for using hardware-enforced DEP. This article also describes how to confirm that hardware DEP is working in Windows.

## More information

### Requirements for using hardware-enforced DEP

To use hardware-enforced DEP, you must meet all the following conditions:

1. The computer's processor must support hardware-enforced DEP.

   Many recent processors support hardware-enforced DEP. Both Advanced Micro Devices (AMD) and Intel Corporation have defined and shipped Windows-compatible architectures that are compatible with DEP. This processor support may be known as NX (no-execute) or XD (execute disable) technology. To determine whether your computer's processor supports hardware-enforced DEP, contact the manufacturer of your computer.
2. Hardware-enforced DEP must be enabled in the BIOS.

   On some computers, you can disable processor support for hardware-enforced DEP in the BIOS. This support can't be disabled. Depending on your computer manufacturer, the option to disable this support may be labeled "Data Execution Prevention," "XD," "Execute Disable," or "NX."
3. The computer must have Windows XP with Service Pack 2 or Windows Server 2003 with Service Pack 1 installed.

   > [!NOTE]
   > Both 32-bit versions and 64-bit versions of Windows support hardware-enforced DEP. Windows XP Media Center Edition 2005 and Microsoft Windows XP Tablet PC Edition 2005 include all the features and components of Windows XP SP2.
4. Hardware-enforced DEP must be enabled for programs on the computer.

   In 64-bit versions of Windows, hardware-enforced DEP is always enabled for 64-bit native programs. However, depending on your configuration, hardware-enforced DEP may be disabled for 32-bit programs.  

For information about how to configure memory protection in Windows XP with Service Pack 2, visit the following Microsoft Web site:  
[https://technet.microsoft.com/library/cc700810.aspx](https://technet.microsoft.com/library/cc700810.aspx)  

### How to confirm that hardware DEP is working in Windows

To confirm that hardware DEP is working in Windows, use one of the following methods.

#### Method 1: Use the `Wmic` command-line tool

You can use the `Wmic` command-line tool to examine the DEP settings. To determine whether hardware-enforced DEP is available, follow these steps:  

1. Click **Start**, click **Run**, type cmd in the **Open** box, and then click **OK**.
2. At the command prompt, type the following command, and then press ENTER:  

   ```console  
   wmic OS Get DataExecutionPrevention_Available  
   ```  

If the output is "TRUE," hardware-enforced DEP is available.  

To determine the current DEP support policy, follow these steps.  

1. Click **Start**, click **Run**, type cmd in the **Open** box, and then click **OK**.
2. At the command prompt, type the following command, and then press ENTER:  

   ```console  
   wmic OS Get DataExecutionPrevention_SupportPolicy  
   ```  

   The value returned will be 0, 1, 2 or 3. This value corresponds to one of the DEP support policies that are described in the following table.

    | DataExecutionPrevention_SupportPolicy property value| Policy Level| Description |
    |---|---|---|
    |2|OptIn (default configuration)|Only Windows system components and services have DEP applied|
    |3|OptOut|DEP is enabled for all processes. Administrators can manually create a list of specific applications that do not have DEP applied|
    |1|AlwaysOn|DEP is enabled for all processes|
    |0|AlwaysOff|DEP is not enabled for any processes|

   > [!NOTE]
   > To verify that Windows is running with hardware DEP enabled, examine the DataExecutionPrevention_Drivers property of the Win32_OperatingSystem class. In some system configurations, hardware DEP may be disabled by using the /nopae or /execute switches in the Boot.ini file. To examine this property, type the following command at a command prompt:  
   wmic OS Get DataExecutionPrevention_Drivers  

#### Method 2: Use the graphical user interface

To use the graphical user interface to determine whether DEP is available, follow these steps:  

1. Click **Start**, click **Run**, type `wbemtest` in the **Open** box, and then click **OK**.
2. In the **Windows Management Instrumentation Tester** dialog box, click **Connect**.
3. In the box at the top of the **Connect** dialog box, type root\cimv2, and then click **Connect**.
4. Click **Enum Instances**.
5. In the **Class Info** dialog box, type Win32_OperatingSystem
in the **Enter superclass name** box, and then click **OK**.
6. In the **Query Result** dialog box, double-click the top item.
   > [!NOTE]
   > This item starts with "Win32_OperatingSystem.Name=Microsoft..."
7. In the **Object editor** dialog box, locate the DataExecutionPrevention_Available property in the **Properties** area.
8. Double-click **DataExecutionPrevention_Available**.
9. In the **Property Editor** dialog box, note the value in the **Value** box.  
  If the value is TRUE, hardware DEP is available.

>[!Note]
>
>- To determine the mode in which DEP is running, examine the DataExecutionPrevention_SupportPolicy property of the Win32_OperatingSystem class. The table at the end of Method 1 describes each support policy value.  
>
>- To verify that hardware DEP is enabled in Windows, examine the DataExecutionPrevention_Drivers property of the Win32_OperatingSystem class. In some system configurations, hardware DEP may be disabled by using the /nopae or /execute switches in the Boot.ini file.  

The third-party products that this article discusses are manufactured by companies that are independent of Microsoft. Microsoft makes no warranty, implied or otherwise, regarding the performance or reliability of these products.
