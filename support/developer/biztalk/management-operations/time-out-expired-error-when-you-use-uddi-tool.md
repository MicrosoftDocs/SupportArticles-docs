---
title: Time-out expired error when you use the UDDI tool
description: This article provides resolutions for time-out expired error that occurs when you use the UDDI tool in BizTalk Server 2013.
ms.date: 08/25/2020
ms.custom: sap:Management and Operations
ms.reviewer: Mstern
---
# Time-out expired error when you use the UDDI tool in BizTalk Server 2013

This article helps you resolve the time-out expired error that occurs when you use the Universal Description, Discovery, and Integration (UDDI) tool in BizTalk Server 2013.

_Original product version:_ &nbsp; BizTalk Server 2013 Branch, BizTalk Server 2013 Enterprise, BizTalk Server 2013 Standard  
_Original KB number:_ &nbsp; 2884899

## Symptoms

Assume that you use the UDDI tool in Microsoft BizTalk Server 2013. After some calls to the UDDI web service, you receive the following error message:

> Timeout expired. The timeout period elapsed prior to obtaining a connection from the pool. This may have occurred because all pooled connections were in use and max pool size was reached.

## Cause

This issue occurs because the UDDI runtime doesn't close connections.

## Resolution

This issue was first fixed in the following cumulative update of BizTalk Server: [Cumulative update package 3 for Microsoft BizTalk Server 2013](https://support.microsoft.com/help/3088676).

## References

- For information about service packs and a cumulative update list for BizTalk Server, see [Service Pack and cumulative update list for BizTalk Server](https://support.microsoft.com/help/2555976).

- For more information about BizTalk Server hotfixes, see [Information about BizTalk Server hotfixes, cumulative updates, and service packs](../setup-config/biztalk-hotfixes-cumulative-update.md).
