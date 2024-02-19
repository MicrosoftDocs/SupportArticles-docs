---
title: Add a user to Services RDP permissions
description: Describes three methods to add users or groups to Terminal Services Remote Desktop Protocol (RDP) permissions.
ms.date: 45286
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, SPAT, slight
ms.custom: sap:administration, csstroubleshoot
---
# How to add a user to RDP permissions by using WMI

This article describes three methods to add users or groups to Remote Desktop Protocol (RDP) permissions.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 290720

## Summary

Two of the three methods use Windows Management Instrumentation (WMI). One method is through the graphical user interface (GUI), and the other two methods use WMI by using a script and the WMI command-line utility, wmic.

## More information

To add users or groups to RDP permissions, use one of the following methods.

## Using the GUI

1. Open Remote Desktop Services Configuration.
2. In the Connections folder, right-click **RDP-Tcp**.
3. Select **Properties**.
4. On the **Permissions** tab, select **Add**, and then add the wanted users and groups.

> [!NOTE]
> You can't use the GUI to configure permissions to sign in to the console session with RDP. To change permissions for the console session (session zero), you must use the WMI methods below, and specify Console instead of RDP-Tcp for the terminal name.

## Using WMI in a script

Microsoft provides programming examples for illustration only, without warranty either expressed or implied. Which includes, but isn't limited to, the implied warranties of merchantability or fitness for a particular purpose. This article assumes that you're familiar with the programming language that is being demonstrated and with the tools that are used to create and to debug procedures. Microsoft support engineers can help explain the functionality of a particular procedure. However, they won't modify these examples to provide added functionality or construct procedures to meet your specific requirements. Create a script by using the following code sample:

```console
set RDPObj = GetObject("winmgmts:{impersonationLevel=impersonate}!Win32_TSPermissionsSetting.TerminalName='RDP-Tcp'")
RDPobj.AddAccount "Domain\User", X
```

Where **"Domain\User", X**:

- **Domain\User**: Target domain and account (user or group) to which permissions are to be granted. For local accounts, replace **Domain\User** with only **User**, where **User** is a local account on the computer on which you're running the command.
- **X**: The type of access to be granted:  
    0 = WINSTATION_GUEST_ACCESS  
    1 = WINSTATION_USER_ACCESS  
    2 = WINSTATION_ALL_ACCESS

To change permissions for the console session, change the terminal name to Console instead of to RDP-Tcp.

```console
set RDPObj = GetObject("winmgmts:{impersonationLevel=impersonate}!Win32_TSPermissionsSetting.TerminalName='Console'")RDPobj.AddAccount "Domain\User", X
```

To revert the permissions back to the default permissions, specify the relevant terminal name. Then, call the `RestoreDefaults` method.

```console
set RDPObj = GetObject("winmgmts:{impersonationLevel=impersonate}!Win32_TSPermissionsSetting.TerminalName='Console'")RDPobj.RestoreDefaults
```

## Using the WMI command-line utility: WMIC

1. At a command prompt, type wmic.
    > [!NOTE]
    > If it isn't in the path, add `%SystemRoot%\System32\Wbem\`, or change to that directory and run wmic.
2. At the `wmic:root\cli> prompt`, type the following command:  
   PATH WIN32_TSPermissionsSetting.TerminalName="RDP-TCP" call AddAccount "Domain\user",X

   Where **"Domain\User", X**:
    - **Domain\User**: Target domain and account (user or group) to which permissions are to be granted. For local accounts, replace **Domain\User** with only **User**, where **User** is a local account on the computer on which you're running the command.
    - **X**: The type of access to be granted:  
        0 = WINSTATION_GUEST_ACCESS  
        1 = WINSTATION_USER_ACCESS  
        2 = WINSTATION_ALL_ACCESS

    To change permissions for the console session, change the terminal name to Console instead of to RDP-Tcp.

    ```console
    PATH WIN32_TSPermissionsSetting.TerminalName="Console" call AddAccount "Domain\user",X
    ```

    To revert the permissions back to the default permissions, specify the relevant terminal name. Then, call the RestoreDefaults method.

    ```console
    PATH WIN32_TSPermissionsSetting.TerminalName="Console" call RestoreDefaults
    ```

3. The following information is an example of the text that you'll see after you run wmic and input the command:

    ```console
    C:\WINDOWS\system32\wbem>wmic
    wmic:root\cli>
    wmic:root\cli> PATH WIN32_TSPermissionsSetting.TerminalName="RDP-TCP" call AddAccount "Domain\User", 2

    Execute (\\<ComputerName>\\root\vimv2: WIN32_TSPermissionsSetting.TerminalName="RDP-TCP")->AddAccount() (Y/N/?)

    Method Execution Successful.
    Out Parameters:
    instance of _PARAMETERS
    {
    RetureValue=0;
    };
    ```

4. Type quit to exit the wmic prompt and to return to the command prompt.
