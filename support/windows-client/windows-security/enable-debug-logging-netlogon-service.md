---
title: Enable debug logging for Netlogon service
description: Describes how to enable logging of debug information of the Netlogon service.
ms.date: 09/21/2020
author: Deland-Han 
ms.author: delhan
manager: dscontentpm
audience: itpro
ms.topic: troubleshooting
ms.prod: windows-client
localization_priority: medium
ms.reviewer: kaushika
ms.prod-support-area-path: Legacy authentication (NTLM)
ms.technology: WindowsSecurity
---
# Enabling debug logging for the Netlogon service

This article describes the steps to enable logging of the Netlogon service in Windows to monitor or troubleshoot authentication, DC locator, account lockout, or other domain communication-related issues.

_Original product version:_ &nbsp; Windows 10 - all editions, Windows Server 2016, Windows Server 2019, Windows Server 2012 R2  
_Original KB number:_ &nbsp; 109626

## More information

> [!IMPORTANT]
> This section, method, or task contains steps that tell you how to modify the registry. However, serious problems might occur if you modify the registry incorrectly. Therefore, make sure that you follow these steps carefully. For added protection, back up the registry before you modify it. Then, you can restore the registry if a problem occurs. For more information about how to back up and restore the registry, click the following article number to view the article in the Microsoft Knowledge Base:
>
> [322756](https://support.microsoft.com/help/322756) How to back up and restore the registry in Windows

To have us enable or disable debug logging for the Netlogon service for you, go to the [Here's an easy fix section](#heres-an-easy-fix). If you prefer to fix this problem manually, go to the [Let me fix it myself](#let-me-fix-it-myself) section.

If you're running Windows NT, you must use the debug version of Netlogon and the required debug DLLs.

### Here's an easy fix

To fix this problem automatically, click the **Download** button. In the **File Download** dialog box, select **Run** or **Open**, and then follow the steps in the easy fix wizard.

- The easy fix solution doesn't work if your computer isn't part of a domain. Netlogon logging doesn't work if the computer is joined to a domain because the Netlogon service doesn't start.
- This wizard may be in English only. However, the automatic fix also works for other language versions of Windows.
- If you're not on the computer that has the problem, save the easy fix solution to a flash drive or a CD, and then run it on the computer that has the problem.

### Let me fix it myself

The version of Netlogon.dll that has tracing included is installed by default on all currently supported versions of Windows. To enable debug logging, set the debug flag that you want by using Nltest.exe, the registry, or Group Policy. To do it, follow these steps:

#### For Windows Server 2019, Windows Server 2016, Windows Server 2012 R2, Windows Server 2012, Windows Server 2008 R2, Windows Server 2008, Windows Server 2003, and Windows 2000 Server

> [!NOTE]
> These steps apply to Windows 2000 Server and Windows Server 2003 only when the support tools are installed. They also apply to Windows XP (if support tools are installed), Windows Vista, Windows 7, Windows 8, Windows 8.1, and Windows 10.

To enable Netlogon logging:

1. Open a Command Prompt window (administrative Command Prompt window for Windows Server 2008 and later versions).
2. Type the following command, and then press Enter:  

    ```console
    Nltest /DBFlag:2080FFFF
    ```

3. It's typically not necessary to stop and restart the Netlogon service for Windows 2000 Server/Professional or later operating systems to enable Netlogon logging. Netlogon-related activity is logged to %windir%\debug\netlogon.log. Verify new writes to this log to determine whether a restart of the Netlogon service is necessary. If you have to restart the service, open a Command Prompt window (administrative Command Prompt window for Windows Server 2008/Windows Vista and later versions of the operating system), and then run the following commands:

    ```console
    net stop netlogon
    net start netlogon
    ```

    > [!NOTE]
    >
    > - In some circumstances, you may have to perform an authentication against the system in order to obtain a new entry in the log to verify that logging is enabled.
    > - Using the computer name may cause no new test authentication entry to be logged.

To disable Netlogon logging:

1. Open a Command Prompt window (administrative Command Prompt window for Windows Server 2008 and higher).
2. Type the following command, and then press Enter:  

    ```console
     Nltest /DBFlag:0x0
    ```

3. It's typically not necessary to stop and restart the Netlogon service for Windows 2000 Server/Professional or later versions of the operating system to disable Netlogon logging. Netlogon-related activity is logged to %windir%\debug\netlogon.log. Verify that no new information is being written to this log to determine whether a restart of the Netlogon service is necessary. If you have to restart the service, then open a Command Prompt window (administrative Command Prompt window for Windows Server 2008/Windows Vista and later versions of the operating system), and then run the following commands:  

    ```console
    net stop netlogon
    net start netlogon
    ```

**Alternative methods to enable Netlogon logging:**  

- In all versions of Windows, you can use the registry method that's provided in the "For Windows NT, Windows 2000 Server (without the support tools), and Windows Server 2003 (without the support tools)" section.
- On computers that are running Windows Server 2003 and later versions of the operating system, you can also use the following policy setting to enable verbose Netlogon logging (value is set in bytes):  

    ```console
    \Computer Configuration\Administrative Templates\System\Net Logon\Specify log file debug output level
    ```

    **Notes**
  - A value of decimal 545325055 is equivalent to 0x2080FFFF (which enables verbose Netlogon logging). This Group Policy setting is specified in bytes.
  - The Group Policy method can be used to enable Netlogon logging on a larger number of systems more efficiently. We don't recommend that you enable Netlogon logging in policies that apply to all systems (such as the Default Domain Policy). Instead, consider narrowing the scope to systems that may be causing problems by doing either of the following:

    - Create a new policy by using this Group Policy setting, and then provide the Read and Apply Group Policy rights to a group that contains only the required computer accounts.
    - Move computer objects into a different OU, and then apply the policy settings at that OU level.

#### For Windows NT, Windows 2000 Server (without the Support tools), and Windows Server 2003 (without the support tools)

These steps also apply to Windows NT Workstation, Windows 2000 Professional (without the support tools), Windows XP (without the support tools), and all newer versions of Windows that are already covered in the preceding steps. To enable logging on Windows NT and Windows 2000 (pre-service pack), you may have to obtain a checked build of Netlogon.dll.

**To enable Netlogon logging:**  

1. Start Registry Editor.
2. If it exists, delete the Reg_SZ value of the following registry entry, create a REG_DWORD value with the same name, and then add the 2080FFFF hexadecimal value:  
    `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Netlogon\Parameters\DBFlag`
3. It's typically not necessary to stop and restart the Netlogon service for Windows 2000 Server/Professional or later versions of the operating system to enable Netlogon logging. Netlogon-related activity is logged to %windir%\debug\netlogon.log. Verify the new writes to this log to determine whether a restart of the Netlogon service is necessary. If you have to restart the service, open a Command Prompt window (administrative Command Prompt window for Windows Server 2008/Windows Vista and above), and then run the following commands:  

    ```console
    net stop netlogon
    net start netlogon
    ```

    **Notes**

    - In some circumstances, you may have to do an authentication against the system to obtain a new entry in the log to verify that logging is enabled.
    - Using the computer name may cause no new test authentication entry to be logged.

**To disable Netlogon logging:**  

1. In Registry Editor, change the data value to 0x0 in the following registry key:

    `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Netlogon\Parameters\DBFlag`
2. Exit Registry Editor.
3. It's typically not necessary to stop and restart the Netlogon service for Windows Server 2003, Windows XP, or later versions of the operating system to disable Netlogon logging. Netlogon-related activity is logged to %windir%\debug\netlogon.log. Verify that no new information is being written to this log to determine whether a restart of the Netlogon service is necessary. If you have to restart the service, open a Command Prompt window (administrative Command Prompt window for Windows Server 2008/Windows Vista and later versions of the operating system), and then run the following commands:  

    ```console
    net stop netlogon
    net start netlogon
    ```

**Setting the maximum log file size for Netlogon logs:**

- The **MaximumLogFileSize** registry entry can be used to specify the maximum size of the Netlogon.log file. By default, this registry entry doesn't exist, and the default maximum size of the Netlogon.log file is 20 MB. When the file reaches 20 MB, it's renamed to Netlogon.bak, and a new Netlogon.log file is created. This registry entry has the following parameters:

    ```console
    Path: HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Netlogon\Parameters Value Name: MaximumLogFileSize Value Type: REG_DWORD Value Data: <maximum log file size in bytes>
    ```

- Remember that the total disk space that's used by Netlogon logging is the size that's specified in the maximum log file size times two (2). It's required to accommodate space for the Netlogon.log and Netlogon.bak file. For example, a setting of 50 MB can require 100 MB of disk space. Which provides 50 MB for Netlogon.log and 50 MB for Netlogon.bak.
- As mentioned earlier, on Windows Server 2003 and later versions of the operating system, you can use the following policy setting to configure the log file size (value is set in bytes):  

    ```console
   \Computer Configuration\Administrative Templates\System\Net Logon\Maximum Log File Size
    ```

For more information, click the following article numbers to view the articles in the Microsoft Knowledge Base:  
    [247811](https://support.microsoft.com/help/247811) How domain controllers are located in Windows

### Did this fix the problem

Check whether the problem is fixed. If the problem is fixed, you're finished with this section. If the problem isn't fixed, you can [contact support](https://support.microsoft.com/home/expcontact/).

```console
 //////////////////////////////////////////////////////////////////////// // Windows Server 2008, Windows Vista, Windows Server 2003, Windows 2000 Debug flags and their values //////////////////////////////////////////////////////////////////////// #define NL_INIT 0x00000001 // Initialization #define NL_MISC 0x00000002 // Misc debug #define NL_LOGON 0x00000004 // Logon processing #define NL_SYNC 0x00000008 // Synchronization and replication #define NL_MAILSLOT 0x00000010 // Mailslot messages #define NL_SITE 0x00000020 // Sites #define NL_CRITICAL 0x00000100 // Only real important errors #define NL_SESSION_SETUP 0x00000200 // Trusted Domain maintenance #define NL_DOMAIN 0x00000400 // Hosted Domain maintenance #define NL_2 0x00000800 #define NL_SERVER_SESS 0x00001000 // Server session maintenance #define NL_CHANGELOG 0x00002000 // Change Log references #define NL_DNS 0x00004000 // DNS name registration // // Very verbose bits // #define NL_WORKER 0x00010000 // Debug worker thread #define NL_DNS_MORE 0x00020000 // Verbose DNS name registration #define NL_PULSE_MORE 0x00040000 // Verbose pulse processing #define NL_SESSION_MORE 0x00080000 // Verbose session management #define NL_REPL_TIME 0x00100000 // replication timing output #define NL_REPL_OBJ_TIME 0x00200000 // replication objects get/set timing output #define NL_ENCRYPT 0x00400000 // debug encrypt and decrypt across net #define NL_SYNC_MORE 0x00800000 // additional replication dbgprint #define NL_PACK_VERBOSE 0x01000000 // Verbose Pack/Unpack #define NL_MAILSLOT_TEXT 0x02000000 // Verbose Mailslot messages #define NL_CHALLENGE_RES 0x04000000 // challenge response debug #define NL_SITE_MORE 0x08000000 // Verbose sites // // Control bits. // #define NL_INHIBIT_CANCEL 0x10000000 // Don't cancel API calls #define NL_TIMESTAMP 0x20000000 // TimeStamp each output line #define NL_ONECHANGE_REPL 0x40000000 // Only replicate one change per call #define NL_BREAKPOINT 0x80000000 // Enter debugger on startup
```
