---
title: A WSUS client takes too long to finish an update scan
description: Fixes an issue where a Windows Server Update Services client computer takes longer than expected to finish a scan to determine whether an update applies to the client computer.
ms.date: 12/05/2023
ms.reviewer: kaushika, v-jomcc
ms.custom: sap:Software Update Management (SUM)\Software Update Scanning
---
# A WSUS client takes longer than expected to finish an update scan

This article helps you fix an issue where a Microsoft Windows Server Update Services (WSUS) client computer takes longer than expected to finish a scan to determine whether an update applies to the client computer.

_Original product version:_ &nbsp; Configuration Manager  
_Original KB number:_ &nbsp; 938947

## Symptoms

Consider the following scenario:

- A WSUS client computer is connected to a WSUS or Configuration Manager Software Update Services (SUP) server.
- The WSUS client computer runs a scan to determine whether an update applies to the client computer.

In this scenario, the WSUS client computer takes longer than expected to finish the scan. For example, the scan may take hours or days to finish. Additionally, you experience the following problems on the WSUS client computer:

- Task Manager indicates high CPU usage for the Svchost.exe process.
- You cannot stop the Svchost.exe process.

## Cause

This problem occurs if you don't decline expired definition updates or expired malicious software (also known as malware) updates on the WSUS or SUP server.

## Resolution

To resolve this problem, set the option to approve update revisions on the WSUS or SUP server automatically. Also, set the option to decline expired updates on the server.

1. In the WSUS administration console, click **Options**, and then click **Automatic Approvals**.
1. On the **Advanced** tab, make sure that both **Automatically approve new revisions of approved updates** and **Automatically decline updates when a new revision causes them to expire** are selected.
1. Click **OK**.

## More information

By default, the **Automatically approve new revisions of approved updates** and **Automatically decline updates when a new revision causes them to expire** options are selected. If you decide not to approve the update revisions automatically, the WSUS server will use the older update revision. In this case, you must manually approve the update revision.

> [!NOTE]
> A revision is an update version that has changed. For example, the update version may have expired or the update version may have applicability rules that have updated.

The default settings for the **Automatically approve new revisions of approved updates** and **Automatically decline updates when a new revision causes them to expire** options let you maintain good performance on the WSUS network. If you don't want expired updates to be automatically declined, you can manually decline them. However, make sure that you do this periodically.

It's recommended that you run the server clean-up wizard regularly. For more information, see [General guidance on optimizing WSUS client performance](optimize-wsus-client-performance.md).

## Troubleshoot stuck client computers

To resolve an issue in which a client computer stops responding during an update scan, follow these steps:

1. On the affected client computer, set the startup type for the **Automatic Updates** service (Wuauserv) to **Disabled**.
2. Restart the computer.
3. Delete the `%Windir%\SoftwareDistribution` folder.
4. Set the startup type for the **Automatic Updates** service to **Automatic**, and then start the **Automatic Updates** service.
