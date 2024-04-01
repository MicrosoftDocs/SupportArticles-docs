---
title: Privilege not exist in service account configuration
description: Describes an issue in which you receive A privilege that the service requires to function properly does not exist in the service account configuration error. Provides a solution.
author: helenclu
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.author: luche
ms.reviewer: dakova, clake, v-thomr
ms.custom: 
  - sap:Search\Search Administration (Setup, configuration, etc)
  - CSSTroubleshoot
  - CI 110752
appliesto: 
  - FAST Search Server 2010 for SharePoint
ms.date: 12/17/2023
---

# "A privilege that the service requires to function properly does not exist in the service account configuration" error in FAST Search Server 2010 for SharePoint

## Symptoms

You install Microsoft FAST Search Server 2010 for SharePoint. When you start the SharePoint services, you receive the following error message:

```adoc
[2010-01-25 16:32:41] WARNING : nodecontroller@RDW07638APP19:13260: systemmsg: Process qrproxy was not running, restarting it
[2010-01-25 16:32:41] INFO : nodecontroller@RDW07638APP19:13260: systemmsg: Starting qrproxy
[2010-01-25 16:32:41] ERROR : nodecontroller@RDW07638APP19:13260: systemmsg: Error starting process qrproxy:
ProcessManagerError: 1297: A privilege that the service requires to function properly does not exist in the service account configuration. \\ You may use the Services Microsoft Management Console (MMC) snap-in (services.msc) and the Local Security Settings MMC snap-in (secpol.msc) to view the service configuration and the account configuration.
```

Additionally, the following error message is logged in the log file on the Node controller:

```adoc
[2010-02-01 01:24:42.791] ERROR systemmsg Error starting process qrproxy: ProcessManagerError: 1297: A privilege that the service requires to function properly does not exist in the service account configuration. \\ You may use the Services Microsoft Management Console (MMC) snap-in (services.msc) and the Local Security Settings MMC snap-in (secpol.msc) to view the service configuration and the account configuration.
```

Additionally, the following error message is logged in the Event Viewer:

```adoc
The FAST Search for SharePoint Sam Admin service failed to start due to the following error: A privilege that the service requires to function properly does not exist in the service account configuration. You may use the Services Microsoft Management Console (MMC) snap-in (services.msc) and the Local Security Settings MMC snap-in (secpol.msc) to view the service configuration and the account configuration.
```

## Cause

This problem may occur if you run a Group Policy that does not have the Create Global Objects policy set.

## Resolution

To resolve this problem, make sure that the SERVICE account includes the Create Global Objects policy.

For more information about global objects, visit the following Websites:

- [Create global objects](/previous-versions/windows/it-pro/windows-server-2003/cc739176(v=ws.10))
- [User Rights](/previous-versions/windows/it-pro/windows-xp/bb457125(v=technet.10))

## More information

Still need help? Go to [SharePoint Community](https://techcommunity.microsoft.com/t5/sharepoint/ct-p/SharePoint).
