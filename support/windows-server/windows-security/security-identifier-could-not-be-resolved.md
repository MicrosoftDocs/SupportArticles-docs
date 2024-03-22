---
title: Security identifier could not be resolved error with a one-way trust
description: Fixes an error (Security identifier could not be resolved) that occurs with a one-way trust.
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:Windows Security Technologies\Domain and forest trusts, csstroubleshoot
---
# Error with a one-way trust in Windows Server 2012 R2: Security identifier could not be resolved

This article provides help to fix an error "Security identifier could not be resolved" that occurs with a one-way trust.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 3212982

## Symptoms

Consider the following scenario:

- Remote Desktop Connection Broker (RDCB) and Remote Desktop Virtualization Host (RDVH) are in Domain A.
- Remote Desktop users are in DomainB\RD_USER_GROUP.
- RD_USER_GROUP is a "Security Group - Universal" group.
- Domain A and Domain B are in different forests.
- Domain A one-way trusts Domain B.

When you try to add DomainB\RD_USER_GROUP directly to the VDI collection in Domain A, you receive the following error message:

> The security identifier could not be resolved. Ensure that a two-way trust exists for the domain of selected users.

## Cause

A two-way trust is required in this scenario.

## Resolution

To resolve this issue, change the one-way trust to a two-way trust.
