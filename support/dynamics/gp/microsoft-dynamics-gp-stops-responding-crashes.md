---
title: Microsoft Dynamics GP stops responding or crashes
description: This article describes how to use the System Configuration Utility tool (Msconfig.exe) to troubleshoot problems that cause Microsoft Dynamics GP to stop responding or to crash.
ms.reviewer: 
ms.topic: how-to
ms.date: 11/29/2022
---
# Troubleshoot problems that cause Microsoft Dynamics GP to stop responding or to crash

This article describes how to use the System Configuration Utility tool (Msconfig.exe) to troubleshoot problems that cause Microsoft Dynamics GP to stop responding or to crash.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 859286

## Introduction

You can use the System Configuration Utility tool (Msconfig.exe) to troubleshoot problems that cause Microsoft Dynamics GP to stop responding or to crash. You can also use this tool to troubleshoot these problems in Microsoft Business Solutions - Great Plains.

## More information

Use the Msconfig tool to determine whether there are programs that may have a conflict with Microsoft Dynamics GP. To do this, follow these steps:

1. Click **Start**, click **Run**, type *msconfig*, and then click **OK**.

2. On the **General** tab, notice that of the following check boxes are selected. Also, notice that of the following check boxes are cleared:

   - **Process SYSTEM.INI File**  

   - **Process WIN.INI File**  

   - **Load System Services**  

   - **Load Startup Items**

3. Click **Selective Startup**.

4. Click to select the **Process SYSTEM.INI File** check box.

5. Click to select the **Process WIN.INI File** check box.

6. Click to select the **Load System Services** check box.

7. Click to clear the **Load Startup Items** check box.

8. Click **Use Original BOOT.INI**, and then click **OK**.

9. Restart the computer.

10. Start Microsoft Dynamics GP, and then try to reproduce the problem.

If you cannot reproduce the problem, there is a conflict between Microsoft Dynamics GP and another program. To determine the program that is causing the conflict, follow these steps:

1. Click **Start**, click **Run**, type *msconfig*, and then click **OK**.

2. On the **General** tab, click to select the appropriate check boxes and options to restore the original settings that you noticed in step 2 of the previous procedure. Then, click **OK**.

3. Click **Normal Startup - load all device drivers and services**.

4. Restart the computer.

5. Click **Start**, click **Run**, type *msconfig*, and then click **OK**.

6. Click the **Startup** tab.

7. In the **Startup Item** list, click to clear the check box for the first item, and then click **OK**.

8. Restart the computer.

9. Start Microsoft Dynamics GP, and then try to reproduce the problem.

10. If the problem persists, repeat steps 5 through 9 in this section. In step 7, click to select the check box of the item that you previously cleared, and then click to clear the check box of the next item. Continue in this manner until you can find the program that conflicts with Microsoft Dynamics GP.

The Msconfig tool is installed together with Windows Vista, Windows Server 2003, Windows XP, Microsoft Windows Millennium Edition, and Microsoft Windows 98. By default, the Msconfig tool is not installed together with Microsoft Windows 2000. However, you can install the tool for use with Windows 2000.

## Other Information to verify when Dynamics GP is crashing / not responding

1. If this is happening during printing of a report, rule out the report.dic and form.dic causing issues.
2. If this is a modified report try to print the original to verify it is not a corrupt report.
3. Review blog [Troubleshooting the error "Microsoft Dynamics GP has stopped working", causing the application to crash/close](https://community.dynamics.com/gp/b/dynamicsgp/posts/troubleshooting-the-error-microsoft-dynamics-gp-has-stopped-working-causing-the-application-to-crash-close)
4. If you have [VBA in your install it may cause crashing](https://community.dynamics.com/gp/b/dynamicsgp/posts/vba-causing-issues-in-dynamics-gp-here-s-a-possible-solution)
5. Make sure you have a default printer set up that is a current fuctioning printer.  From the Microsoft Dynamics GP menu choose Print Setup. 
6. 
