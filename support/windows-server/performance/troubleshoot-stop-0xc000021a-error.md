---
title: Troubleshoot a STOP 0xC000021A error in Windows XP or Windows Server 2003
description: This article presents advanced troubleshooting steps for the STOP 0xC000021A error.
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:System Performance\System Reliability (crash, errors, bug check or Blue Screen, unexpected reboot), csstroubleshoot
---
# How to troubleshoot a STOP 0xC000021A error in Windows XP or Windows Server 2003

This article presents advanced troubleshooting steps for the STOP 0xC000021A error.

**Home users**: This article is intended for use by support agents and IT professionals. If you're looking for more information about a blue-screen error code while using your computer, see [Troubleshoot blue-screen errors](https://windows.microsoft.com/windows-10/troubleshoot-blue-screen-errors).

_Applies to:_ &nbsp; Windows 10 - all editions,  Windows Server 2012 R2  
_Original KB number:_ &nbsp; 156669

This article is intended for advanced computer users. If you aren't comfortable with advanced troubleshooting, ask someone for help or contact Technical Support.

When you use a server or workstation that's running one of the operating systems listed in the "Applies to" section, you may receive the following error message:

> STOP: c000021a {Fatal System Error}  
The Windows Logon Process system process terminated unexpectedly with a status of 0xc0000034 (0x00000000 0x0000000)  
 The system has been shut down.

> [!NOTE]
> The parameters in parentheses are specific to your computer configuration and may be different for each occurrence.

## Cause

The STOP 0xC000021A error occurs when either Winlogon.exe or Csrss.exe fails. When the Windows NT kernel detects that either of these processes has stopped, it stops the system and raises the STOP 0xC000021A error. This error may have several causes, including:

- Mismatched system files have been installed.
- A Service Pack installation has failed.
- A backup program that's used to restore a hard disk didn't correctly restore files that may have been in use.
- An incompatible third-party program has been installed.

## Resolution

To troubleshoot this problem, you must determine which of these processes failed and why.

To determine which process failed, register Dr. Watson as the default system debugger if it isn't already the default debugger. Dr. Watson for Windows NT logs diagnostic information about process failures to a log file Drwtsn32.log. Also, you can configure this program to produce memory dump files of failed processes. Then you can analyze the files in a debugger to determine why a process fails.

To set up Dr. Watson to trap user-mode program errors, follow these steps:

1. At a command prompt, type *System Root\System32\Drwtsn32.exe -I*, and then press Enter.

    This command configures Dr. Watson as the default system debugger.
2. At a command prompt, type *System Root\System32\Drwtsn32.exe*, and then select the following options:

    - **Append to existing log file**  
    - **Create crash dump**  
    - **Visual Notification**  
3. After the computer restarts from the STOP 0xC000021A error, run Dr. Watson (Drwtsn32.exe).
4. View the Dr. Watson log to determine what user mode process may be causing the problem.
5. If the Dr. Watson log doesn't contain sufficient information to determine the cause of the problem, analyze the User.dmp file to determine the cause of the STOP 0xC000021A error.

    If Dr. Watson didn't create a User.dmp file for either Winlogon.exe or Csrss.exe, you may have to use a different tool to generate a memory dump file of the process that fails. For more information, see the following article:

    [241215](https://support.microsoft.com/help/241215) How to use the Userdump.exe tool to create a dump file

    > [!NOTE]
    > Follow the instructions in the Knowledge Base article to troubleshoot a process that shuts down with an exception. While you follow these instructions, monitor the following processes to troubleshoot the STOP 0xC000021A error:
    >
    > - Winlogon.exe
    > - Csrss.exe
    >
    > Most STOP 0xC000021A errors occur because Winlogon.exe fails. This typically occurs because of a faulty third-party Graphical Identification and Authentication (GINA) DLL. The GINA is a replaceable DLL component that Winlogon.exe loads. The GINA implements the authentication policy of the interactive logon model. The GINA performs all identification and authentication user interactions.

It's very common for certain types of remote control software to replace the default Windows GINA DLL (Msgina.dll). A good first step is to examine the system to see if it has a third-party GINA DLL. To do so, locate the following registry key:

`HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\WinlogonValue = GinaDLL REG_SZ`

- If the Gina DLL value is present, and if it's anything other than Msgina.dll, it probably means that a third-party product has changed this value.
- If this value isn't present, the system uses Msgina.dll as the default GINA DLL. If this error first occurred after the installation of a new or updated device driver, system service, or third-party program, the new software should be removed or disabled. Contact the manufacturer of the software to see if an update is available.

### Last known good configuration

If the previous steps in this article don't resolve the problem, start the computer by using the last known good configuration. To start the computer by using the last known good configuration, follow these steps.

> [!NOTE]
> Because there are several versions of Microsoft Windows, the following steps may be different on your computer. If they are, see your product documentation to complete these steps.

1. Select **Start** > **Shut Down**.
2. Select **Restart** > **OK**.
3. Press F8 at the indicated time:
   - For an x86-based computer: When a screen of text appears and then disappears, press F8. (The screen of text may include a memory test, lines about the BIOS, and other lines.) There may also be a prompt that tells you when to press F8.
   - For an Itanium architecture-based computer: After you make your selection from the boot menu, press F8. There may be a prompt that tells you when to press F8.
4. Use the arrow keys to select **Last Known Good Configuration**, and then press Enter.

    NUM LOCK must be off before the arrow keys on the numeric keypad will function.
5. Use the arrow keys to highlight an operating system, and then press Enter.

> [!NOTE]
>
> - Choosing the Last Known Good Configuration startup option provides a way to recover from problems such as a newly added driver that may be incorrect for your hardware. However, it doesn't solve problems that are caused by corrupted or missing drivers or files.
> - When you choose the Last Known Good Configuration option, only the information in registry key HKLM\System\CurrentControlSet is restored. Any changes you have made in other registry keys remain.

### Remove incompatible software by using the Recovery Console

If the previous steps in this article don't resolve the problem, remove incompatible software by using the Recovery Console. Complete steps that describe how to do so are beyond the scope of this article. However, you may use the following articles as guidelines:

[816104](https://support.microsoft.com/help/816104) How to replace a driver by using Recovery Console in Windows Server 2003  
[326215](https://support.microsoft.com/help/326215) How to use the Recovery Console on a Windows Server 2003-based computer that does not start  
[307654](https://support.microsoft.com/help/307654) How to install and use the Recovery Console in Windows XP  
