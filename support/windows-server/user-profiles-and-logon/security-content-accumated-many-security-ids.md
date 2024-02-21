---
title: Error 1384 when you log on to a domain
description: Discusses an issue where you get a 1384 error when you log on to a domain or connect to a network share on a server.
ms.date: 12/26/2023
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, richfl
ms.custom: sap:user-logon-fails, csstroubleshoot
---
# Error message: During a logon attempt, the user's security context accumulated too many security IDs

This article discusses an issue where you get a 1384 error when you log on to a domain or connect to a network share on a server.

_Applies to:_ &nbsp; Windows 10 - all editions, Windows Server 2012 R2  
_Original KB number:_ &nbsp; 275266

## Symptoms

When you try to log on to a domain or connect to a network share on a server, you may receive the following error code 1384 error message:

> During a logon attempt, the user's security context accumulated too many security IDs.

## Cause

This behavior occurs because Windows systems contain a limit that prevents a user's security access token from containing more than 1,000 security identifiers (SIDs). This means that when a user is being validated for access rights to establish a new session with a server, that user must not be a member of more than 1,000 groups in that server's domain. If this limit is exceeded, access to the server is denied, and the error code 1384 is returned to the user.

If the server that the user connects to is in a second domain (for example, if the user connects to a server in a Windows 2000 resource domain), the total number of groups the user is a member of is determined by adding the user's group membership in that second domain to the user's global group membership in their domain.

## Status

Microsoft has confirmed that this is a problem. This behavior is by design.

## More information

If a group from the user's domain is included in multiple groups in the second domain, the user's total group membership is not just incremented by one for their inclusion in this group. Instead, it is additionally incremented by the number of groups in the second domain that this group is a member of.

For example, if you add a user to a global group in their domain, and add this global group to four local groups in a second domain, the user's total group membership (and SID count) in that second domain is increased by five, instead of just being increased by one as you may expect.
