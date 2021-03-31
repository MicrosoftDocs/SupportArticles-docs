---
title: Email is not tracked in Microsoft Dynamics CRM
description: This article provides a resolution for the problem that occurs when multiple organizations are configured for one user.
ms.reviewer: vaniaf, mmaasjo
ms.topic: troubleshooting
ms.date: 
---
# Email is not tracked in Microsoft Dynamics CRM if multiple organizations are configured for one user

This article helps you resolve the problem that occurs when multiple organizations are configured for one user.

_Applies to:_ &nbsp; Microsoft Dynamics CRM 2011  
_Original KB number:_ &nbsp; 2505366

## Symptoms

Consider the following scenario:

- User A has access to Organization Y and Organization Z in Microsoft Dynamics CRM.
- User A configures Microsoft Dynamics CRM for Microsoft Office Outlook for Organization Y and Organization Z.
- Email for Organization Z is not tracked to the Microsoft Dynamics CRM server.

## Cause

You can only have one **Synchronizing Organization**. The second organization is a secondary organization. You can view the Microsoft Dynamics CRM data, but you cannot go offline, synchronize data or tag email for the secondary organization.

## Resolution

If you need both organizations to be **Synchronizing Organizations**, you must use a separate Microsoft Exchange account for each organization.
