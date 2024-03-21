---
title: How to enable Windows Remote Shell
description: Helps you enable Windows Remote Shell.
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:Remote Desktop Services and Terminal Services\Deployment, configuration, and management of Remote Desktop Services infrastructure, csstroubleshoot
---
# How to enable Windows Remote Shell

This article helps you enable Windows Remote Shell.

_Applies to:_ &nbsp; Windows Server 2003  
_Original KB number:_ &nbsp; 555966

This article was written by [Yuval Sinay](https://mvp.microsoft.com/en-us/PublicProfile/7674?fullName=Yuval%20Sinay), Microsoft MVP.

## Tips

To enable Windows Remote Shell, you need to deploy the server-side and client-side settings:

### Server Side  

> [!NOTE]
> The server definition in the article describes a Windows host that gets into remote management shell.

1. Log into the Windows console.
2. Optional (For Windows Vista serves as remote server): Start the service "Windows Remote Management " and set it for auto start after reboot.
3. Write the command prompt `WinRM quickconfig` and press the **Enter** button.
4. The following output should appear:

    ```output
    WinRM is not set up to allow remote access to this machine for management.
    The following changes must be made:

    Set the WinRM service type to delayed auto start.
    Start the WinRM service.
    Create a WinRM listener on HTTP://* to accept WS-Man requests to any IP on this
    machine.

    Make these changes [y/n]? y
    ```

5. After pressing the **y** button, the following output should appear:

    ```output
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
> Verify the new settings by using the command `winrm enumerate winrm/config/listener`.

[!INCLUDE [Community Solutions Content Disclaimer](../../includes/community-solutions-content-disclaimer.md)]
