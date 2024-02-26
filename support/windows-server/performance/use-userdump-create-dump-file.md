---
title: Use Userdump.exe to create a dump file
description: Describes how to use the Userdump.exe tool to generate a user dump of a process that shuts down with an exception or that stops responding.
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:shutdown-is-slow-or-hangs, csstroubleshoot
---
# Use the Userdump.exe tool to create a dump file

This article provides the steps to use the Userdump.exe tool to create a dump file of a process that shuts down with an exception or that stops responding.

_Applies to:_ &nbsp; Windows 10 - all editions, Windows Server 2012 R2  
_Original KB number:_ &nbsp; 241215

## Summary

You can use the Userdump.exe tool to generate a user dump of a process that shuts down with an exception or that stops responding (hangs).

## More information

### To create a dump (.dmp) file for a process that shuts down with an exception

1. Run the Setup.exe program for your processor.

    > [!NOTE]
    >
    > - By default, this Setup.exe program is included with the Userdump.exe tool in the C:\kktools\userdump8.1\Architecture folder.
    > - This Setup.exe program installs a kernel-mode driver, installs the Userdump.sys file, and creates the Process Dump icon in Control Panel.
    > - Unless you have a specific need, disable the "dump on process termination" feature when you run the Setup.exe program.  

2. In Control Panel, double-click **Process Dump**.
3. On the **Exception Monitoring** tab, click
 **New**, add the appropriate program name to the **Monitor** list, and then click
 **OK**. For example, add a program name such as Lsass.exe, Winlogon.exe, Mtx.exe, or Dllhost.exe.
4. In the **Monitor** box, click the program name that you added in step 3, and then click **Rules**.
5. Click to select **Custom Rules**, select the type of error that you want to trigger for the program that you added in step 3 in the **Custom rules** list, and then click **OK**.

For example, select the **Access violation (c0000005)** error type. When the monitored program generates an access violation error message, the Userdump.exe tool starts, and then the Userdump.exe tool creates a dump (.dmp) file in the
 **%SystemRoot%** folder. By analyzing this .dmp file, you may be able to isolate the cause of Winlogon access violation error messages.

### To create a dump file for a hanging process

1. Run the Setup.exe program for your processor.

    > [!NOTE]  
    >
    >- By default, this Setup.exe program is included with the Userdump.exe tool in the C:\kktools\userdump8.1\architecture folder.
    >- This Setup.exe program installs a kernel-mode driver, installs the Userdump.sys file, and creates the Process Dump icon in Control Panel.
    >- Unless you have a specific need, disable the "dump on process termination" feature when you run the Setup.exe program.  

2. When the program stops responding, move to the version of Userdump.exe for your processor at the command prompt, and then type the following command:  
`userdump PID`

    > [!NOTE]
    > In this command, **PID** is a placeholder for the process ID (PID) of the program that has stopped responding. To obtain the PID of the program, open Task Manager, and then click the
     **Process** tab.When you run the userdump **PID** command, a .dmp file is generated. You can use this dump file to perform post-mortem debugging with a program such as the Windbg.exe tool.

If you run Setup to install the Userdump.exe tool, some additional features are enabled. These additional features of the Userdump.exe tool are described in detail in the Userdocs.doc file that accompanies the Userdump.exe tool. These additional features include the following:

- Process self-dumping. You can configure the Userdump.exe tool to automatically create a dump file for a certain program when that program encounters a certain kind of error, such as an exception handler block or a top-level unhandled exception filter.
- Hot-key process snapshot. You can associate a single keystroke with an image binary to trigger the Userdump.exe tool to create a dump file.
- Exception monitoring. The Userdump.exe tool can monitor programs for exceptions and can automatically generate dump files when certain exceptions occur. You can configure whether an exception triggers a dump file for each program by using the Process Dump utility. You can access the Process Dump utility from Control Panel.
