---
title: Antivirus scanning exclusions
description: This article describes the system processes that you should consider excluding from antivirus scanning on computers that are running Team Foundation Server.
ms.date: 02/09/2022
ms.custom: sap:Installation, Migration, and Move
ms.reviewer: chandrur
ms.topic: article
ms.service: az-devops-project
---
# Antivirus exclusions for Azure DevOps Server

This article describes the system processes that you should consider excluding from antivirus scanning on computers that are running Team Foundation Server.

_Original product version:_ &nbsp; Microsoft Team Foundation Server, Azure DevOps Server
_Original KB number:_ &nbsp; 2636507

## Summary

This article provides information about the processes that may have to be excluded from antivirus scanning on computers that are running Team Foundation Server 2010, Team Foundation Server Proxy 2010, Team Foundation Server 2012, and Team Foundation Server Proxy 2012, Azure DevOps Server. It also provides links to Microsoft knowledge base articles that cover antivirus exclusions that may be defined on servers that are running deployments of Microsoft SQL Server and SharePoint Server that have been integrated with Team Foundation Server.

## Symptoms

Target files will be locked when the antivirus software is scanning. You may encounter errors if proper folders are not added to the antivirus software's directory exclusion list. These errors may include intermittent instances where the Team Foundation Server Application Pool crashes. The following list includes errors that you might encounter when this behavior occurs:

- The following event is added to the system's Application log:

    > Event ID 5002  
      Application pool Team Foundation Server Application Pool is being automatically disabled due to a series of failures in the process(es) serving that application pool.

- The following event is added to the system's Application log before the Team Foundation Server Application Pool crashes:

   >TF400850: The request context was not disposed by the caller  
    Exception Message: Cannot access a disposed object.

- The following application domain reload event occurs:

  > The application is being shut down for the following reason: BinDirChangeOrDirectoryRename.

## Exclusion list

You may have to configure your antivirus software to exclude the following processes, folders and their sub-folders from antivirus scanning:

- :::no-loc text="C:\Users\\<TFS_Service_Account\>\AppData\Local\Temp"
- :::no-loc text="C:\inetpub\temp"
- :::no-loc text="%ProgramFiles%\Microsoft Team Foundation Server \<VersionNumber\>\Application Tier\Web Services\bin"
- :::no-loc text="%ProgramFiles%\Microsoft Team Foundation Server \<VersionNumber\>\Application Tier\Web Services\_tfs_data"
- TFS Client Cache
  - On TFS server: :::no-loc text="C:\Users\\<TFS_Service_Account\>\AppData\Local\Microsoft\Team Foundation\\<VersionNumber\>\Cache"
  - On Client: :::no-loc text="C:\Users\\<UserName\>\AppData\Local\Microsoft\Team Foundation\\<VersionNumber\>\Cache"
- TFS application tier Cache Location
- Pipeline agent folders
- :::no-loc text="\Builds, \Symbols, \Drop"
- :::no-loc text="%ProgramFiles%\Microsoft Visual Studio \<VersionNumber\>"
- :::no-loc text="C:\Windows\Microsoft.NET\Framework"
- :::no-loc text="C:\Windows\Microsoft.NET\Framework\\<VersionNumber\>\Temporary ASP.NET Files"
- :::no-loc text="C:\Windows\Microsoft.NET\Framework64\\<VersionNumber\>\Temporary ASP.NET Files"
- `TFSJobAgent.exe` process that is typically located at `%ProgramFiles%\Microsoft Team Foundation Server \<VersionNumber\>\Application Tier\TFSJobAgent\TFSJobAgent.exe`

## More information

For better performance of source control and other Team Foundation Server operations, we recommend adding the Internet Information Services (IIS) worker process (w3wp.exe) to the list of antivirus exclusions. This is not a requirement for Team Foundation Server.

The w3wp.exe process is typically located at `C:\Windows\System32\inetsrv\w3wp.exe`. You can also locate this process by following these steps:

1. Make a Team Foundation Server web request such as by connecting to Team Foundation Server through Team Explorer.
2. On the Team Foundation Server application tier or the Team Foundation Server proxy machine, open **Task Manager**, and then click the **Details** tab.
3. Find **w3wp.exe** in the list of items that are running.
4. Right-click **w3wp.exe**, and then select **Open file location**.

For more information about SQL Server folder exclusions, see the following:

- [How to choose antivirus software to run on computers that are running SQL Server](https://support.microsoft.com/help/309422)

- [Certain folders may have to be excluded from antivirus scanning when you use file-level antivirus software in SharePoint](https://support.microsoft.com/office/certain-folders-may-have-to-be-excluded-from-antivirus-scanning-when-you-use-file-level-antivirus-software-in-sharepoint-01cbc532-a24e-4bba-8d67-0b1ed733a3d9)