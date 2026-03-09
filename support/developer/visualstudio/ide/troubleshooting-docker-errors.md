---
title: Troubleshoot Docker client errors on Windows
description: Troubleshoot problems you encounter when using Visual Studio to create and deploy web apps to Docker on Windows by using Visual Studio.
ms.devlang: dotnet
ms.custom: sap:Integrated Development Environment (IDE)\Other, linux-related-content
ms.date: 03/03/2026
ms.reviewer: ghogen, ncarlson, v-shaywood
---
# Troubleshoot Visual Studio development with Docker

_Applies to:_&nbsp;Visual Studio

When you work with Visual Studio Container Tools, you might encounter problems while building or debugging your application. This article introduces some common troubleshooting steps for these problems.

## Volume sharing isn't enabled. Enable volume sharing in the Docker CE for Windows settings (Linux containers only)

You only need to manage file sharing if you're using Hyper-V with Docker. If you're using WSL 2, you don't need to follow the steps in this section, and the file sharing option isn't visible. To resolve this problem:

1. Right-click **Docker for Windows** in the notification area, and then select **Settings**.
1. Select **Resources** > **File Sharing** and share the folder that needs to be accessed. Sharing your entire system drive is possible but not recommended.

    :::image type="content" source="media/troubleshooting-docker-errors/docker-settings-image.png" alt-text="Screenshot of shared drives." lightbox="media/troubleshooting-docker-errors/docker-settings-image.png":::

> [!TIP]
> Visual Studio prompts you when **Shared Drives** aren't configured.

## Problems with paths on Windows containers

When you use file paths that are specific to Linux on a Windows container, you might encounter various file input or output (I/O) errors. If you see these errors, check the value of the environment variable `VSCT_WslDaemon`. If the variable is set, Visual Studio attempts to use Windows Subsystem for Linux (WSL) paths to refer to the Windows files for creating volumes. This approach is necessary for Docker in WSL, but it doesn't work with Docker Desktop on Windows. Always unset this environment variable if you use Windows containers.

## Unable to start debugging

One reason for this problem is stale debugging components in your user profile folder. Run the following commands to remove these folders so that the latest debugging components are downloaded in the next debug session.

- `del %userprofile%\vsdbg`
- `del %userprofile%\onecoremsvsmon`

## Errors specific to networking when debugging your application

Try executing the script downloadable from [Cleanup Container Host Networking](https://github.com/MicrosoftDocs/Virtualization-Documentation/tree/master/windows-server-container-tools/CleanupContainerHostNetworking),
which refreshes the network-related components on your host machine.

## Mounts denied

When using Docker for macOS, you might encounter an error referencing the folder _/usr/local/share/dotnet/sdk/NuGetFallbackFolder_. Add the folder to the **File Sharing** tab in Docker.

## Docker users group

You might encounter the following error in Visual Studio when working with containers:

> The current user must be in the 'docker-users' group to use Docker Desktop.
> Add yourself to the 'docker-users' group and then log out of Windows.

You must be a member of the 'docker-users' group to have permissions to work with Docker containers. To add yourself to the group in Windows 10 or later, follow these steps:

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

By default, Docker stores images in the _%ProgramData%/Docker/_ folder, which is typically on the system drive, _C:\ProgramData\Docker\\_. To prevent images from taking up valuable space on the system drive, you can change the image folder location. To change the location:

 1. Right-click the Docker icon on the task bar and select **Settings**.
 1. Select **Docker Engine**.
 1. In the editing pane, add the `graph` property setting with the value of your desired location for Docker images:

      ```json
         "graph": "D:\\mypath\\images"
      ```

       :::image type="content" source="media/troubleshooting-docker-errors/docker-daemon-settings.png" alt-text="Screenshot of Docker File Sharing." lightbox="media/troubleshooting-docker-errors/docker-daemon-settings.png":::

 1. Select **Apply & Restart**.
    These steps modify the configuration file at _%ProgramData%\docker\config\daemon.json_. Previously built images aren't moved.

## Container type mismatch

When you add Docker support to a project, you choose either a Windows or a Linux container. If the Docker Server host isn't configured to run the same container type as the project target, you see an error similar to:

:::image type="content" source="media/troubleshooting-docker-errors/docker-host-config-change-linux-to-windows.png" alt-text="Screenshot of Docker Host and Project Mismatch.":::

To resolve this problem, right-click the Docker for Windows icon in the System Tray and select **Switch to Windows containers...** or **Switch to Linux containers...**.

## ContainerToolsPackage or DockerComposePackage didn't load correctly

A corrupted Managed Extensibility Framework (MEF) cache can cause this problem. To fix it, delete the _ComponentModelCache_ folder for your Visual Studio instance.

1. Close all instances of Visual Studio.
1. Run the following PowerShell command to delete the _ComponentModelCache_ folder:

   ```PowerShell
   Get-ChildItem -Path "$(Join-Path $Env:LOCALAPPDATA "Microsoft\VisualStudio")" -Recurse -Include "ComponentModelCache" | Remove-Folder
   ```

You can also delete the folder manually:

1. Open _%localappdata%\Microsoft\VisualStudio_ in File Explorer.
1. Open the subfolder that corresponds to your Visual Studio version (for example, _18.0_b653d53f_).
1. Delete the _ComponentModelCache_ folder.

## Other problems

For any other problems you encounter, see [Microsoft/DockerTools](https://github.com/microsoft/dockertools/issues).

## References

- [Container Tools error messages](/visualstudio/containers/container-tools-error-messages)
