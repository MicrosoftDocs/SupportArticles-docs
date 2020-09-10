---
title: Antivirus scanning exclusions
description: This article describes the system processes that you should consider excluding from antivirus scanning on computers that are running Team Foundation Server.
ms.prod: devops
ms.date: 08/17/2020
ms.prod-support-area-path: Installation, Migration, and Move
ms.reviewer: chandrur
ms.topic: article
---
# Antivirus exclusions for Azure DevOp Server

This article describes the system processes that you should consider excluding from antivirus scanning on computers that are running Team Foundation Server.

_Original product version:_ &nbsp; Microsoft Team Foundation Server, Azure DevOp Server  
_Original KB number:_ &nbsp; 2636507

## Summary

This article provides information about the processes that may have to be excluded from antivirus scanning on computers that are running Team Foundation Server 2010, Team Foundation Server Proxy 2010, Team Foundation Server 2012, and Team Foundation Server Proxy 2012, Azure DevOp Server. It also provides links to Microsoft knowledge base articles that cover antivirus exclusions that may be defined on servers that are running deployments of Microsoft SQL Server and SharePoint Server that have been integrated with Team Foundation Server.

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

## Team Foundation Server 2013

Add the `%ProgramFiles%\Microsoft Team Foundation Server 12.0\Application Tier\Web Services\bin` folder to your antivirus software's directory exclusion list to avoid errors that may occur when the antivirus software locks files in this folder. These errors may include intermittent instances where the Team Foundation Server Application Pool crashes. The following list includes errors that you might encounter when this behavior occurs:

- The following event is added to the system's Application log:

    > Event ID 5002  
      Application pool Team Foundation Server Application Pool is being automatically disabled due to a series of failures in the process(es) serving that application pool.

- The following event is added to the system's Application log before the Team Foundation Server Application Pool crashes:

   >TF400850: The request context was not disposed by the caller  
    Exception Message: Cannot access a disposed object.

- The following application domain reload event occurs:

  > The application is being shut down for the following reason: BinDirChangeOrDirectoryRename.
