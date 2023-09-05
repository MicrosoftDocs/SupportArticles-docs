---
title: CDS User role cannot access flows or workflows
description: CDS User role cannot access Power Automate flows, business process flows, or on-demand workflows. Provides a resolution.
ms.reviewer: sudeepu
ms.topic: troubleshooting
ms.date: 03/31/2021
ms.subservice: power-automate-flows
---
# CDS User Role cannot access Power Automate flows, business process flows, or on-demand workflows

This article provides a resolution for the issue that the CDS User role can't access Power Automate flows, business process flows, or on-demand workflows.

_Applies to:_ &nbsp; Microsoft Dynamics 365  
_Original KB number:_ &nbsp; 4562298

## Symptoms

Users that are assigned only the **CDS User** role are unable to access previously available Power Automate flows, business process flows, or on-demand workflows.

## Cause

The **CDS User** role is being updated to match the needs of a default user, to ensure that they can use flows shared with them or created by them.

## Resolution

Any one of these options:

1. Explicitly share the workflows with users that need access to them.
2. Create a new role with the desired access-level privileges on Process entity and assign to users that need it ('User','Team','Business Unit','Parent-Child Business Unit','Organization').
3. Modify the existing **CDS User** role to the desired access-level privilege.
