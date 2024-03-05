---
title: How to determine which program uses or blocks specific TCP ports in Windows Server 2003
description: Discusses how to determine which program uses or blocks specific Transmission Control Protocol (TCP) ports.
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: jamirc, kaushika
ms.custom: sap:performance-monitoring-tools, csstroubleshoot
---
# How to determine which program uses or blocks specific Transmission Control Protocol ports in Windows Server 2003

This step-by-step article discusses how to determine which program uses or blocks specific Transmission Control Protocol (TCP) ports.

For a Microsoft Windows XP version of this article, see [281336](https://support.microsoft.com/help/281336).  

_Applies to:_ &nbsp; Windows Server 2003  
_Original KB number:_ &nbsp; 323352

## Summary

The *Netstat.exe* utility has a new switch, the `-o` switch, that can display the process identifier (ID) that is associated with each connection. This information can be used to determine which process (program) listens on a particular port. For example, the `netstat -ano` command can produce the following output:

```output
Proto Local Address Foreign Address State PID  
TCP 0.0.0.0:80 0.0.0.0:0 Listening 888
```

If you use Task Manager, you can match the process ID that is listed to a process name (program). With this feature, you can find the specific port that a program currently uses. Because a program already uses this specific port, another program is prevented from using that same port.

## How to match the process ID to a program

To match the process ID to a program, follow these steps:

1. Select <kbd>Ctrl</kbd>+<kbd>Shift</kbd>+<kbd>Esc</kbd> to open **Task Manager**.
2. Select the **Processes** tab.
3. If you don't have a PID column, select **View** > **Select Columns**, and then select to select the **PID** (Process Identifier) check box.
4. Select the column header that is labeled "PID" to sort the process by PIDs. You should be able to easily find the process ID and match it to the program that is listed in Task Manager.

## How to obtain additional information about the Netstat.exe utility

To obtain additional information about the *Netstat.exe* utility, follow these steps:

1. Select **Start** > **Run**.
2. In the **Open** box, type *cmd*, and then select **OK**.
3. At a command prompt, type `netstat /?`.
