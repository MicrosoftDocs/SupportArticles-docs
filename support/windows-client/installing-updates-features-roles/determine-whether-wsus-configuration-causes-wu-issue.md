---
title: Determine Whether WSUS Configuration Causes WU Installation Failures
description: Helps you isolate whether the cause of a WU issue is with the WSUS configuration or the WU service.
ms.date: 07/01/2025
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.reviewer: winciccore,warrenw
ms.custom:
- sap:installing windows updates,features,or roles\failure to install windows updates
- pcy:WinComm Devices Deploy
---
# Determine whether WSUS configuration causes WU installation failures

Assume that Windows Server Update Service (WSUS) is deployed in an environment. This article helps you determine whether a Windows Update (WU) issue is caused by the WSUS configuration or the WU service.

## Introduction

When WSUS is used to manage Windows updates, it can be difficult to determine the cause of updates not being delivered to the Windows client. The issue can be caused by the WU service subsystem, the WSUS configuration, or the Windows client's ability to sync with the WSUS server.

To help narrow down the cause, a quick and easy test is to try to manually install the update on the client.

- If the update can be installed manually, the problem is likely due to a WSUS configuration or communication error.
- If the update fails to install manually, note the error and follow the guidance in the next section.

## Troubleshooting

To troubleshoot WU issues, see the following articles:

- [Troubleshoot problems updating Windows](https://support.microsoft.com/en-us/windows/troubleshoot-problems-updating-windows-188c2b0f-10a7-d72f-65b8-32d177eb136c)
- [Troubleshoot issues with Windows Server Update Services (WSUS) client agents](../../mem/configmgr/update-management/troubleshoot-issues-with-wsus-client-agents.md)
- [How to download updates that include drivers and hotfixes from the Windows Update Catalog](download-updates-drivers-hotfixes-windows-update-catalog.md)
- [Microsoft Update Catalog](https://catalog.update.microsoft.com/home.aspx)
