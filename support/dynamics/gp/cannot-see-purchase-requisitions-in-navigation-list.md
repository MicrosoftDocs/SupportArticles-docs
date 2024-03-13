---
title: Cannot see Purchase Requisitions in Navigation list
description: Users not able to see Purchase Requisitions in Navigation list in Microsoft Dynamics GP. Provides a resolution.
ms.reviewer: cwaswick
ms.topic: troubleshooting
ms.date: 03/13/2024
---
# Users not able to see Purchase Requisitions in Navigation list in Microsoft Dynamics GP

This article provides a resolution for the issue that you can't see Purchase Requisitions in Navigation list in Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 4487254

## Symptoms

Users are not able to see Purchase Requisition transactions listed in the Navigation list pane in Microsoft Dynamics GP.

## Cause

User is not marked to have all requisitions displayed in Purchasing Requisition setup window. This is not controlled by standard GP security. It is controlled by Purchasing Requisition setup.

## Resolution

1. Go to **Purchasing** > **Setup** > **Purchase order processing** > **Requisition**.

2. Select the **REQUISITION** button at the bottom.

3. Make sure the User ID has the checkbox marked for **All Requisitions**. Select **OK**.
