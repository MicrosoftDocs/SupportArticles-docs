---
title: Event ID 1644 when LDAP queries are run
description: Works around a problem in which an LDAP query performs slowly on a Windows Server 2003 or newer server that uses an AD LDS or an ADAM directory service.
ms.date: 45286
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, herbertm
ms.custom: sap:domain-controller-scalability-or-performance-including-ldap, csstroubleshoot
---
# LDAP queries are executed more slowly than expected in the AD or LDS/ADAM directory service and Event ID 1644 may be logged

This article provides a workaround for an issue where LDAP queries perform slowly on a Windows Server computer that uses an AD LDS or an ADAM directory service.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 951581

## Symptoms

On a Windows Server computer that uses an Active Directory Lightweight Directory Services (AD LDS) or Active Directory Application Mode (AD/AM) directory service, certain applications do not perform at expected performance levels.

When you enable field engineering (debug) logging to trace an LDAP query, the following event log shows that the LDAP query is an inefficient query.

> [!NOTE]
> The attributes that are used in this event are only examples.

Additionally, you experience high CPU utilization and a slow response time. If the database is considerably bigger than physical memory available to the directory server, you may also see increased disk IO while the processing such a query.

When you inspect the attributes in the search filter, you find that they all have indexes that are defined. And if attributes do not have indexes that are defined, and you add the indexes through a schema change, the problem persists or does not improves much.

## Cause

When you create a network trace of the LDAP query, you notice that it is a paged query.

The LDAP server can only use one index while processing a paged query. This is because the LDAP implementation for paged searches does not create an expensive context for the query and thus only uses one index for a paged query.

## Workaround

To work around this problem, you can send the query without using the paged query control. This allows the LDAP server to optimize for more complex filters.

> [!NOTE]
> By default, paged queries are enabled for some LDAP client libraries. Therefore, you may have to write additional code in your application to enable and disable paged queries as appropriate for your specific situation.

## Status

Microsoft has confirmed that this is a problem.

## References

[How to configure Active Directory and LDS diagnostic event logging](configure-ad-and-lds-event-logging.md)
