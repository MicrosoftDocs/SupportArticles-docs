---
title: Enable debug logging for Netlogon service
description: Describes how to enable logging of debug information of the Netlogon service.
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:legacy-authentication-ntlm, csstroubleshoot
---
# Enabling debug logging for the Netlogon service

This article describes the steps to enable logging of the `Netlogon` service in Windows to monitor or troubleshoot authentication, DC locator, account lockout, or other domain communication-related issues.

_Applies to:_ &nbsp; Windows 10 - all editions, Windows Server 2016, Windows Server 2019, Windows Server 2012 R2  
_Original KB number:_ &nbsp; 109626

## More information

> [!IMPORTANT]
> This section, method, or task contains steps that tell you how to modify the registry. However, serious problems might occur if you modify the registry incorrectly. Therefore, make sure that you follow these steps carefully. For added protection, back up the registry before you modify it. Then, you can restore the registry if a problem occurs. For more information about how to back up and restore the registry, click the following article number to view the article in the Microsoft Knowledge Base:
>
> [322756](https://support.microsoft.com/help/322756) How to back up and restore the registry in Windows

The version of Netlogon.dll that has tracing included is installed by default on all currently supported versions of Windows. To enable debug logging, set the debug flag that you want by using Nltest.exe, the registry, or Group Policy. To do it, follow these steps:

### For Windows Server 2019, Windows Server 2016, Windows Server 2012 R2

> [!NOTE]
> These steps also apply to Windows 10.

To enable `Netlogon` logging:

1. Open a Command Prompt window (administrative Command Prompt window for Windows Server 2012 R2 and later versions).
2. Type the following command, and then press Enter:  

    ```console
    Nltest /DBFlag:2080FFFF
    ```

3. It's typically unnecessary to stop and restart the `Netlogon` service for Windows Server 2012 R2 or later to enable `Netlogon` logging. Netlogon-related activity is logged to %windir%\debug\netlogon.log. Verify new writes to this log to determine whether a restart of the `Netlogon` service is necessary. If you have to restart the service, open a Command Prompt window (administrative Command Prompt window for Windows 10, and Windows Server 2012 R2 and later versions). Then run the following commands:

    ```console
    net stop netlogon
    net start netlogon
    ```

    > [!NOTE]
    >
    > - In some circumstances, you may have to perform an authentication against the system in order to obtain a new entry in the log to verify that logging is enabled.
    > - Using the computer name may cause no new test authentication entry to be logged.

To disable `Netlogon` logging, follow these steps:

1. Open a Command Prompt window (administrative Command Prompt window for Windows Server 2012 R2 and higher).
2. Type the following command, and then press Enter:  

    ```console
     Nltest /DBFlag:0x0
    ```

3. It's typically unnecessary to stop and restart the `Netlogon` service for Windows Server 2012 R2 or later versions to disable `Netlogon` logging. Netlogon-related activity is logged to %windir%\debug\netlogon.log. Verify that no new information is being written to this log to determine whether a restart of the `Netlogon` service is necessary. If you have to restart the service, open a Command Prompt window (administrative Command Prompt window for Windows 10, and Windows Server 2012 R2 and later versions). Then run the following commands:  

    ```console
    net stop netlogon
    net start netlogon
    ```

#### Alternative methods to enable Netlogon logging

- In all versions of Windows, you can use the registry method that's provided in the [Enable/Disable logging by using registry method](#enabledisable-logging-by-using-registry-method) section.
- On computers that are running Windows Server 2012 R2 and later versions of the operating system, you can also use the following policy setting to enable verbose `Netlogon` logging (value is set in bytes):  

    \Computer Configuration\Administrative Templates\System\Net Logon\Specify log file debug output level

> [!NOTE]
>
> - A value of decimal 545325055 is equivalent to 0x2080FFFF (which enables verbose `Netlogon` logging). This Group Policy setting is specified in bytes.
> - The Group Policy method can be used to enable `Netlogon` logging on a larger number of systems more efficiently. We don't recommend that you enable `Netlogon` logging in policies that apply to all systems, such as the Default Domain Policy. Instead, consider narrowing the scope to systems that may be causing problems by using one of the following methods:
>
>   - Create a new policy by using this Group Policy setting, and then provide the Read and Apply Group Policy rights to a group that contains only the required computer accounts.
>   - Move computer objects into a different OU, and then apply the policy settings at that OU level.

##### Enable/Disable logging by using registry method

To enable logging, you may have to obtain a checked build of Netlogon.dll.

1. Start Registry Editor.
2. If it exists, delete the Reg_SZ value of the following registry entry, create a REG_DWORD value with the same name, and then add the 2080FFFF hexadecimal value:  
    `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Netlogon\Parameters\DBFlag`
3. It's typically unnecessary to stop and restart the `Netlogon` service for Windows Server 2012 R2 and later versions to enable `Netlogon` logging. Netlogon-related activity is logged to %windir%\debug\netlogon.log. Verify the new writes to this log to determine whether a restart of the `Netlogon` service is necessary. If you have to restart the service, open a Command Prompt window (administrative Command Prompt window for Windows Server 2012 R2/Windows 10 and above). Then run the following commands:  

    ```console
    net stop netlogon
    net start netlogon
    ```

> [!NOTE]
>
> - In some circumstances, you may have to do an authentication against the system to obtain a new entry in the log to verify that logging is enabled.
> - Using the computer name may cause no new test authentication entry to be logged.

To disable `Netlogon` logging, follow these steps:

1. In Registry Editor, change the data value to 0x0 in the following registry key:

    `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Netlogon\Parameters\DBFlag`
2. Exit Registry Editor.
3. It's typically unnecessary to stop and restart the `Netlogon` service for Windows Server 2012 R2, Windows 10, or later versions to disable `Netlogon` logging. Netlogon-related activity is logged to %windir%\debug\netlogon.log. Verify that no new information is being written to this log to determine whether a restart of the `Netlogon` service is necessary. If you have to restart the service, open a Command Prompt window (administrative Command Prompt window for Windows Server 2012 R2/Windows 10 and later versions of the operating system). Then run the following commands:  

    ```console
    net stop netlogon
    net start netlogon
    ```

Set the maximum log file size for `Netlogon` logs:

- The **MaximumLogFileSize** registry entry can be used to specify the maximum size of the Netlogon.log file. By default, this registry entry doesn't exist, and the default maximum size of the Netlogon.log file is 20 MB. When the file reaches 20 MB, it's renamed to Netlogon.bak, and a new Netlogon.log file is created. This registry entry has the following parameters:

  - Path: `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Netlogon\Parameters`
  - Value Name: MaximumLogFileSize
  - Value Type: REG_DWORD
  - Value Data: \<maximum log file size in bytes>

- Remember that the total disk space that's used by `Netlogon` logging is the size that's specified in the maximum log file size times two (2). It's required to accommodate space for the Netlogon.log and Netlogon.bak file. For example, a setting of 50 MB can require 100 MB of disk space, which provides 50 MB for Netlogon.log and 50 MB for Netlogon.bak.
- As mentioned earlier, on Windows Server 2012 R2 and later versions of the operating system, you can use the following policy setting to configure the log file size (value is set in bytes):  

   \Computer Configuration\Administrative Templates\System\Net Logon\Maximum Log File Size

For more information, click the following article numbers to view the articles in the Microsoft Knowledge Base:  
    [247811](https://support.microsoft.com/help/247811) How domain controllers are located in Windows
