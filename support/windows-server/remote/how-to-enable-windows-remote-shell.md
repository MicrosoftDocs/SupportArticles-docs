---
title: How to enable Windows Remote Shell
description: Helps you enable Windows Remote Shell.  
ms.date: 09/27/2020
author: Deland-Han
ms.author: delhan
manager: dscontentpm
audience: itpro
ms.topic: troubleshooting
ms.prod: windows-server
localization_priority: medium
ms.reviewer: kaushika
ms.prod-support-area-path: Administration
ms.technology: RDS
---
# How to enable Windows Remote Shell

This article helps you enable Windows Remote Shell.

_Original product version:_ &nbsp; Windows Server 2003  
_Original KB number:_ &nbsp; 555966

This article was written by [Yuval Sinay](https://mvp.microsoft.com/en-us/PublicProfile/7674?fullName=Yuval%20Sinay), Microsoft MVP.

## Community solutions content disclaimer

Microsoft corporation and/or its respective suppliers make no representations about the suitability, reliability, or accuracy of the information and related graphics contained herein. all such information and related graphics are provided "as is" without warranty of any kind. Microsoft and/or its respective suppliers hereby disclaim all warranties and conditions with regard to this information and related graphics, including all implied warranties and conditions of merchantability, fitness for a particular purpose, workmanlike effort, title, and non-infringement. you specifically agree that in no event shall Microsoft and/or its suppliers be liable for any direct, indirect, punitive, incidental, special, consequential damages or any damages whatsoever including, without limitation, damages for loss of use, data or profits, arising out of or in any way connected with the use of or inability to use the information and related graphics contained herein, whether based on contract, tort, negligence, strict liability or otherwise, even if Microsoft or any of its suppliers has been advised of the possibility of damages.

## Tips

To enable Windows Remote Shell, you need to deploy the server-side and client-side settings:

### Server Side  

> [!NOTE]
> The server definition in the article describe a Windows host that get into remote management shell.

1. Log into the Windows console.
2. Optional (For Windows Vista serves as remote server): Start the service "Windows Remote Management " and set it for auto start after reboot.
3. Write the command prompt `WinRM quickconfig` and press the **Enter** button.
4. The following output should appear:

    ```console
    WinRM is not set up to allow remote access to this machine for management.
    The following changes must be made:

    Set the WinRM service type to delayed auto start.
    Start the WinRM service.
    Create a WinRM listener on HTTP://* to accept WS-Man requests to any IP on this
    machine.

    Make these changes [y/n]? y
    ```

5. After pressing the **y** button, the following output should appear:

    ```console
    WinRM has been updated for remote management.

    WinRM service type changed successfully.
    WinRM service started.
    Created a WinRM listener on HTTP://* to accept WS-Man requests to any IP on this machine.
    ```

    > [!NOTE]
    > We recommend that you change the default settings via the `winrm.cmd` command (Like enable HTTPS support etc.).
    >
    > Windows Remote Shell using SOAP. Some firewalls may block SOAP traffic. For more information, see the vendor documentation.

### Client Side

On Windows Vista/Windows 2008 host, use the command `winrs -r:%servername% remote command` and press the **Enter** button.

Example: To review remote file system, write the following command:

```console
winrs -r:DC1 dir
```

> [!NOTE]
> In Windows Workgroup environment, there is a need to add a trust for the server that the client initiate a connection to it by using the command `winrm set winrm/config/client @{TrustedHosts="%servername1%,"%servername2%"}`.
>
> Verity the new settings by using the command `winrm enumerate winrm/config/listener`.
