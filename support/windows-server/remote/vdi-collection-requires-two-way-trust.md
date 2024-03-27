---
title: VDI collection requires two-way trust
description: Provides a solution to an error that occurs when you try to add DomainB\RD_USER_GROUP directly to VDI collection in DomainA.
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:Remote Desktop Services and Terminal Services\Virtual Desktop Infrastructure (VDI), csstroubleshoot
---
# Server 2012 VDI collection require two-way trust when adding user group of external domain

This article provides a solution to an error that occurs when you try to add DomainB\RD_USER_GROUP directly to VDI collection in DomainA.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 2877933

## Symptoms

Consider the following scenario:

1. RDCB and RDVH are in DomainA.

2. RD users are in DomainB\RD_USER_GROUP, RD_USER_GROUP is a "Security Group - Universal".

3. DomainA and DomainB are in different forests.

4. DomainA one-way trusts DomainB.

When you tried to add DomainB\RD_USER_GROUP directly to VDI collection in DomainA, we got an error "The security identifier could not be resolved. Ensure that a two-way trust exists for the domain of selected users".

## Cause

Two-way trust is required for this scenario to work.

## Resolution

Change one-way trust to two-way trust.
