---
title: The content processing pipeline failed to process the item
description: SharePoint returns "The content processing pipeline failed to process the item" if the service account for Search Host Controller Service doesn't have the required privileges.
ms.author: luche
author: helenclu
manager: dcscontentpm
ms.date: 12/09/2021
audience: Admin
ms.topic: troubleshooting
ms.prod: sharepoint
localization_priority: Normal
search.appverid:
- SPO160
- MET150
appliesto:
- SharePoint Server Subscription Edition
- SharePoint Server 2019
- SharePoint Server 2016
- SharePoint Server 2013
ms.custom: 
- CI 158351
- CSSTroubleshoot 
ms.reviewer: holutz
---

# SharePoint crawl error "The content processing pipeline failed to process the item"

You can use the [crawl log](/sharepoint/search/view-search-diagnostics#crawl-log) in your SharePoint Search service application to track the status of crawled content.

## Symptoms

On the **Crawl Log - Error Breakdown** page, you receive the following error message:

> The content processing pipeline failed to process the item.

When you select the value in the **Count** column, it takes you to the **Crawl Log - URL View** page. And you see an error message that resembles the following example:

> \\fileserver\Folder\Item.txt  
> The content processing pipeline failed to process the item. ( Error parsing document ssic://72. **It was not possible to acquire a worker. Failed to start acquired worker**; ; SearchID = \<GUID\> )

In the ULS logs on the server that hosts the content processing component, one of the following entries are logged:

- > Date Time   NodeRunnerContent1-c5596cf9-a02 (0x1180)   0x3850 Search Document Parsing   **ai3n0**  Monitorable  SandboxWorker[1]: **Parser server failed to start.**  Exception: System.ComponentModel.Win32Exception (0x80004005): **Process needs SeAssignPrimaryTokenPrivilege. Cannot continue.**     at Microsoft.Ceres.Common.Tools.Sandbox.SandBoxInterop.StartProcess(SandBoxedProcessArguments sbpArgs, Boolean fSuspended, ProcessInformation* psandBoxProcessInfo)     at Microsoft.Ceres.Common.Tools.Sandbox.SandBoxedProcess.StartProcessSuspended(SandBoxedProcessArguments sbpArgs)     at Microsoft.Ceres.Common.Tools.Sandbox.SandboxLauncher.Launcher.Start(String application, String arguments, Int32 memoryLimitMegabytes, Boolean suspended, SecurityIdentifier uniqueSidToAllow, Boolean loopForJobMessages, IThreadManager threadManager)     at Microsoft.Ceres.DocParsing.Runtime.Core.Sandbox.SandboxWorker.StartServer()     at Microsoft.Ceres.DocParsing.Runtime.Core.Sandbox.SandboxWorker.StartRetry()
- > Date Time   NodeRunnerContent1-c5596cf9-a02 (0x0F40)   0x14F0 Search Document Parsing   **ai3n0** Monitorable SandboxWorker[1]: **Parser server failed to start.**  Exception: System.ComponentModel.Win32Exception (0x80004005): **Process needs SeIncreaseQuotaPrivilege. Cannot continue.**     at Microsoft.Ceres.Common.Tools.Sandbox.SandBoxInterop.StartProcess(SandBoxedProcessArguments sbpArgs, Boolean fSuspended, ProcessInformation* psandBoxProcessInfo)     at Microsoft.Ceres.Common.Tools.Sandbox.SandBoxedProcess.StartProcessSuspended(SandBoxedProcessArguments sbpArgs)     at Microsoft.Ceres.Common.Tools.Sandbox.SandboxLauncher.Launcher.Start(String application, String arguments, Int32 memoryLimitMegabytes, Boolean suspended, SecurityIdentifier uniqueSidToAllow, Boolean loopForJobMessages, IThreadManager threadManager)     at Microsoft.Ceres.DocParsing.Runtime.Core.Sandbox.SandboxWorker.StartServer()     at Microsoft.Ceres.DocParsing.Runtime.Core.Sandbox.SandboxWorker.StartRetry()

## Cause

This issue occurs if the service account for **Windows Service – Search Host Controller Service** doesn't have the following required user rights:

- [Replace a process level token](/windows/security/threat-protection/security-policy-settings/replace-a-process-level-token) (SeAssignPrimaryTokenPrivilege): It allows the Microsoft SharePoint Search Component (Noderunner.exe) to modify the security access token of the ParserServer.exe process. This means creating the process as a different user from the current user.
- [Adjust memory quotas for a process](/windows/security/threat-protection/security-policy-settings/adjust-memory-quotas-for-a-process) (SeIncreaseQuotaPrivilege): It allows the Microsoft SharePoint Search Component (Noderunner.exe) to adjust the memory quota of the ParserServer.exe process. This ensures that the ParserServer.exe process doesn't consume too much memory.

## Resolution

To fix the issue, assign the required user rights to the service account by using one of the following consoles:

- the Group Policy Management Console (gpmc.msc)
- the Local Group Policy Editor console (gpedit.msc)
- the Local Security Policy console (secpol.msc)

To configure the user rights assignment settings, see [Configure security policy settings](/windows/security/threat-protection/security-policy-settings/how-to-configure-security-policy-settings). Add the service account to both security policies.
