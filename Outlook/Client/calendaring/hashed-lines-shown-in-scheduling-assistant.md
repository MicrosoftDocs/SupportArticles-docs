---
title: Hashed lines shown in scheduling assistant
description: Hashed lines are shown in scheduling assistant when Exchange Server 2016 tries to retrieve free/busy information across untrusted forests.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Outlook for Windows
  - CSSTroubleshoot
ms.reviewer: balinger, v-shum, v-huzhan
appliesto: 
  - Exchange Server 2016
search.appverid: MET150
ms.date: 01/30/2024
---
# Hashed lines shown in scheduling assistant when Exchange Server 2016 tries to retrieve free/busy information across untrusted forests

_Original KB number:_ &nbsp; 4456243

## Symptoms

Consider the following scenario:

- You deploy Exchange Server 2016 in a cross-forest topology.
- You [configure availability service in untrusted forest](/exchange/architecture/client-access/availability-service-for-cross-forest-topologies#use-the-exchange-management-shell-to-configure-organization-wide-freebusy-information-in-an-untrusted-cross-forest-topology) to share free/busy information.
- You use the Scheduling Assistant feature to view the free/busy information about another forest mailbox in Outlook.

In this scenario, you could only see "\\\\\\\\\\\\\\" in the free/busy information. In addition, the Outlook on the web (previously known as Outlook Web App) client is also affected.

## Cause

This issue occurs because the Exchange Server doesn't send the `AvailabilityAddressSpace` authentication header. Therefore, a "The request failed with HTTP status 401: Unauthorized" error message occurs.

## Resolution

To resolve this issue, install [Cumulative Update 11](https://support.microsoft.com/help/4134118) for Exchange Server 2016 or [a later cumulative update](/Exchange/new-features/build-numbers-and-release-dates) for Exchange Server 2016.

## References

Learn about the [terminology](/troubleshoot/windows-client/deployment/standard-terminology-software-updates) that Microsoft uses to describe software updates.
