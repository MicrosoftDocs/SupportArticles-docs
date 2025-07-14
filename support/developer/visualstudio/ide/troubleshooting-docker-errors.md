---
title: Troubleshoot Docker client errors on Windows
description: Troubleshoot problems you encounter when using Visual Studio to create and deploy web apps to Docker on Windows by using Visual Studio.
ms.devlang: dotnet
ms.custom: sap:Integrated Development Environment (IDE)\Other, linux-related-content
ms.date: 02/20/2025
author: aartig13
ms.author: aartigoyle
ms.reviewer: ghogen
---
# Troubleshoot Visual Studio development with Docker

_Applies to:_&nbsp;Visual Studio

When you're working with Visual Studio Container Tools, you may encounter issues while building or debugging your application. This article introduces some common troubleshooting steps for the issues.

## Volume sharing is not enabled. Enable volume sharing in the Docker CE for Windows settings (Linux containers only)

File sharing only needs to be managed if you're using Hyper-V with Docker. If you're using WSL 2, the following steps aren't necessary, and the file sharing option won't be visible. To resolve this issue:

1. Right-click **Docker for Windows** in the notification area, and then select **Settings**.
1. Select **Resources** > **File Sharing** and share the folder that needs to be accessed. Sharing your entire system drive is possible but not recommended.

    :::image type="content" source="media/troubleshooting-docker-errors/docker-settings-image.png" alt-text="Screenshot of shared drives." lightbox="media/troubleshooting-docker-errors/docker-settings-image.png":::

> [!TIP]
> Visual Studio prompts you when **Shared Drives** aren't configured.

## Problems with paths on Windows containers

When you use file paths that are specific to Linux on a Windows container, you might encounter various file input or output (I/O) errors. If so, check the value of the environment variable `VSCT_WslDaemon`. If the variable is set, Visual Studio attempts to use Windows Subsystem for Linux (WSL) paths to refer to the Windows files for creating volumes. This is necessary for Docker in WSL, but doesn't work with Docker Desktop on Windows. This environment variable should always be unset if you use Windows containers.

## Unable to start debugging

One reason for this issue could be related to having stale debugging components in your user profile folder. Execute the following commands to remove these folders so that the latest debugging components are downloaded on the next debug session.

- `del %userprofile%\vsdbg`
- `del %userprofile%\onecoremsvsmon`

## Errors specific to networking when debugging your application

Try executing the script downloadable from [Cleanup Container Host Networking](https://github.com/MicrosoftDocs/Virtualization-Documentation/tree/master/windows-server-container-tools/CleanupContainerHostNetworking),
which will refresh the network-related components on your host machine.

## Mounts denied

When using Docker for macOS, you might encounter an error referencing the folder _/usr/local/share/dotnet/sdk/NuGetFallbackFolder_. Add the folder to the **File Sharing** tab in Docker.

## Docker users group

You might encounter the following error in Visual Studio when working with containers:

> The current user must be in the 'docker-users' group to use Docker Desktop.
> Add yourself to the 'docker-users' group and then log out of Windows.

You must be a member of the 'docker-users' group in order to have permissions to work with Docker containers. To add yourself to the group in Windows 10 or later, follow these steps:

1. From the Start menu, open **Computer Management**.
1. Expand **Local Users and Groups**, and select **Groups**.
1. Find the **docker-users** group, right-click and select **Add to group**.
1. Add your user account or accounts.
1. Sign out and sign back in again for these changes to take effect.

You can also use the `net localgroup` command at the Administrator command prompt to add users to specific groups.

```cmd
net localgroup docker-users DOMAIN\username /add
```

In PowerShell, use the [Add-LocalGroupMember](/powershell/module/microsoft.powershell.localaccounts/add-localgroupmember) function.

## Low disk space

By default, Docker stores images in the *%ProgramData%/Docker/* folder, which is typically on the system drive, _C:\ProgramData\Docker\\_. To prevent images from taking up valuable space on the system drive, you can change the image folder location. To do so:

 1. Right-click on the Docker icon on the task bar and select **Settings**.
 1. Select **Docker Engine**.
 1. In the editing pane, add the `graph` property setting with the value of your desired location for Docker images:

      ```json
         "graph": "D:\\mypath\\images"
      ```

       :::image type="content" source="media/troubleshooting-docker-errors/docker-daemon-settings.png" alt-text="Screenshot of Docker File Sharing." lightbox="media/troubleshooting-docker-errors/docker-daemon-settings.png":::

 1. Select **Apply & Restart**.
    These steps modify the configuration file at *%ProgramData%\docker\config\daemon.json*. Previously built images aren't moved.

## Container type mismatch

When adding Docker support to a project, you choose either a Windows or a Linux container. If the Docker Server host isn't configured to run the same container type as the project target, you see an error similar to:

:::image type="content" source="media/troubleshooting-docker-errors/docker-host-config-change-linux-to-windows.png" alt-text="Screenshot of Docker Host and Project Mismatch.":::

To resolve this issue, right-click the Docker for Windows icon in the System Tray and select **Switch to Windows containers...** or **Switch to Linux containers...**.

## Other issues

For any other issues you encounter, see [Microsoft/DockerTools](https://github.com/microsoft/dockertools/issues) issues.

## References

- [Container Tools error messages](/visualstudio/containers/container-tools-error-messages)
