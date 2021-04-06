---
title: Slow performance with McAfee antivirus
description: Provides workarounds for the experience performance issues in Microsoft Dynamics CRM if you are running McAfee Enterprise 8.x virus scanner.
ms.reviewer: dzilch
ms.topic: troubleshooting
ms.date: 
---
# Slow performance with McAfee antivirus

This article provides workarounds for the performance issues in Microsoft Dynamics CRM that may occur if you run the McAfee Enterprise 8.*x* virus scanner.

_Applies to:_ &nbsp; Microsoft Dynamics CRM 2011, Microsoft Security Essentials  
_Original KB number:_ &nbsp; 924341

## Symptoms

You might experience performance issues in Microsoft Dynamics CRM if you are running McAfee Enterprise 8.*x* virus scanner in combination with active Script Scan.

McAfee and Microsoft are working closely together on this performance problem. If you experience this behavior, contact McAfee to open a support case.

## Cause

This problem occurs because McAfee provides the functionality of script scanning.

## Workaround

We suggest the following workarounds:

- Update your virus scanner to McAfee Enterprise version 8.7, and install the latest patches. If you cannot do this, upgrade to McAdfee Enterprise version 8.5, including the latest patches.
- If the first workaround is not viable for you, you can turn off the ScriptScan functionality in McAfee Enterprise version 8.*x*.

[!INCLUDE [Third-party disclaimer](../../includes/third-party-disclaimer.md)]
