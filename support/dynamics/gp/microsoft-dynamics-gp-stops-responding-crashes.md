---
title: Microsoft Dynamics GP stops responding or crashes
description: Introduces how to use the System Configuration Utility tool (Msconfig.exe) to solve issues that cause Microsoft Dynamics GP to stop responding or crash.
ms.reviewer: theley
ms.date: 03/20/2024
ms.custom: sap:System and Security Setup, Installation, Upgrade, and Migrations
---
# Microsoft Dynamics GP stops responding or crashes

This article describes how to use the System Configuration Utility tool (Msconfig.exe) to solve the problems that cause Microsoft Dynamics GP to stop responding or crash. You can also use this tool to troubleshoot these problems in Microsoft Business Solutions - Great Plains.

> [!NOTE]
> By default, the Msconfig tool is installed in Windows Vista, Windows Server 2003, Windows XP, Microsoft Windows Millennium Edition, and Microsoft Windows 98. The Msconfig tool isn't included in Windows 2000, but you can install the tool for use.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 859286

## More information

Use the Msconfig tool to determine whether there are programs that may have a conflict with Microsoft Dynamics GP. To do this, follow these steps:

1. Select **Start** > **Run**, type _msconfig_, and then select **OK**.
2. On the **General** tab, you may notice that some of the following checkboxes are selected or cleared:

   - **Process SYSTEM.INI File**
   - **Process WIN.INI File**
   - **Load System Services**
   - **Load Startup Items**

3. Select **Selective Startup**.
4. Select the **Process SYSTEM.INI File** checkbox.
5. Select the **Process WIN.INI File** checkbox.
6. Select the **Load System Services** checkbox.
7. Clear the **Load Startup Items** checkbox.
8. Select **Use Original BOOT.INI**, and then select **OK**.
9. Restart the computer.
10. Start Microsoft Dynamics GP, and then try to reproduce the problem.

If you can't reproduce the problem, there's a conflict between Microsoft Dynamics GP and another program. To determine the program that is causing the conflict, follow these steps:

1. Select **Start** > **Run**, type _msconfig_, and then select **OK**.
2. On the **General** tab, select the appropriate checkboxes and options to restore the original settings you noticed in step 2 of the previous procedure. Then, select **OK**.
3. Select **Normal Startup - load all device drivers and services**.
4. Restart the computer.
5. Select **Start** > **Run**, type _msconfig_, and then select **OK**.
6. Select the **Startup** tab.
7. In the **Startup Item** list, clear the checkbox for the first item, and then select **OK**.
8. Restart the computer.
9. Start Microsoft Dynamics GP, and then try to reproduce the problem.
10. If the problem persists, repeat steps 5 through 9 in this section. In step 7, select the checkbox of the item that you previously cleared, and then clear the checkbox of the next item. Continue in this manner until you find the program that conflicts with Microsoft Dynamics GP.

## Other information to verify when Microsoft Dynamics GP crashes or stops responding

1. If the issue occurs when you print a report, double check the reports.dic and forms.dic files that may cause the issue.
2. If the report you try to print is a modified report, print the original report to verify that it's not a corrupt report.
3. If you receive the "Microsoft Dynamics GP has stopped working" error message, see [Troubleshooting the error "Microsoft Dynamics GP has stopped working", causing the application to crash/close](https://community.dynamics.com/blogs/post/?postid=b7f386c3-5881-4cf8-8a37-d0f6289fac0c).
4. To solve the crash issue caused by VBA, see [VBA may cause crash issues](https://community.dynamics.com/blogs/post/?postid=10e2dcb9-f1be-47fe-a919-fe38560206e6).
5. Make sure that the current functioning printer is the default printer that you set up. You can double-check the **Print Setup** setting in the Microsoft Dynamics GP menu to do this.
