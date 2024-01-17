---
title: Open in new tab or window not working
description: Provides the workaround to solve the issue that you cannot open a hyperlink in a new tab or in a new window in Internet Explorer 8 and later versions.
ms.date: 03/23/2020
ms.reviewer: JoelBa
---
# Open in new tab or Open in new window do not work in Internet Explorer 8 and later versions

[!INCLUDE [](../../../includes/browsers-important.md)]

Often due to the installation of other applications that either re-register or update existing interface registrations, Internet Explorer fails to perform the **Open in new window** and **Open in new tab** functions properly. This article will aid you in re-registering the supporting binaries to attempt to restore the missing functionality.

_Original product version:_ &nbsp; Internet Explorer 8 and later versions  
_Original KB number:_ &nbsp; 2574731

## Symptoms

When you try to use the right-click context menu options to either **Open in new tab** or **Open in new window** on a hyperlink, the appropriate tab or window may not appear or navigate as expected.

If the tab or window does appear, you may observe the tab to be busy but navigation does not complete. If the navigation attempt is stopped, the new tab or window can be navigated by providing the address into the appropriate address bar.

Note that the keyboard shortcuts to create new tabs (Ctrl+T) and new windows (Ctrl+N) may not be impacted.

## Cause

The registry information used to initiate these functionalities is either missing, invalid, or assigned to a different binary file.

## Resolution

In many cases, it is possible to restore this functionality by re-registering the function-specific Internet Explorer files.

As a standard precaution for any registry modifications, it is recommended that you create a System Restore restore point or system state backup where possible before proceeding.

Using a Windows Command Prompt that leverages an Administrator account privilege, type the following commands that apply to your specific Windows processor architecture:

> [!TIP]
> On Windows Vista and newer operating systems, this can be achieved by right-clicking the command prompt shortcut and choosing the **Run as administrator** function and providing the credentials of a user account which has local administrator privilege, if prompted.

**For Internet Explorer installations on 64-bit versions of Windows:**  
At the command prompt, type the following commands (do not copy/paste), hitting the Enter key after each:

```console
%SystemRoot%\System32\regsvr32 '%programfiles%\Internet Explorer\ieproxy.dll'  
%SystemRoot%\Syswow64\regsvr32 '%programfiles(x86)%\Internet Explorer\ieproxy.dll'
%SystemRoot%\System32\regsvr32 /i /n ieframe.dll
%SystemRoot%\Syswow64\regsvr32 /i /n ieframe.dll  
```

**For Internet Explorer installations on 32-bit versions of Windows:**  
At the command prompt, type the following commands (do not copy/paste), hitting the Enter key after each:

```console
regsvr32 '%programfiles%\Internet Explorer\ieproxy.dll'
regsvr32 /i /n 'ieframe.dll'  
```

Reminder: There is no need to prepend `regsvr32` with `%SystemRoot%\System32` on 32-bit systems.

> [!NOTE]
> At the execution of each `regsvr32` command, you should receive a message box that indicates registration was successful. If you receive a message indicating a status other than successful, it is recommended that you contact Microsoft Product Support for further assistance. For more information on `regsvr32` usage, see the following article:  
> [Explanation of Regsvr32 usage and error message](https://support.microsoft.com/help/249873)

## More information

Manual re-registration of these Internet Explorer files may be necessary in the following conditions:

- The Internet Explorer installation file registrations were blocked or delayed before the restart occurred.
- An Internet Explorer update package installation failed to complete file registrations before the restart occurred.
- One or more applications overwrite the Internet Explorer registration information with alternative data.
