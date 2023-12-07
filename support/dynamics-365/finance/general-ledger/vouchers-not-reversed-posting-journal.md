---
# required metadata

title: Vouchers aren't reversed when posting a journal that has a reversing entry and date 
description: Provides a resolution for an issue where a reversing entry that was entered on a general journal might not be included on the posted transaction in Microsoft Dynamics 365 Finance. 
author: kweekley
ms.date: 12/07/2023
ms.prod: 
ms.technology: 

# optional metadata

ms.search.form: 
audience: Application User
# ms.devlang: 
ms.reviewer: twheeloc
# ms.tgt_pltfrm: 
# ms.custom: 
ms.search.region: Global 
# ms.search.industry: 
ms.author: kweekley
ms.search.validFrom: 2021-5-05
ms.dyn365.ops.version: 10.0.14
---
# Vouchers aren't reversed when you post a journal that has a reversing entry and date

This article resolves an issue where a reversing entry that was entered on a general journal might not be included on the posted transaction in Microsoft Dynamics 365 Finance.

## Symptoms

A general journal includes a reversing entry and reversing date on the journal. When you post the journal, none of the vouchers are reversed.

## Resolution

When the journal is posted, the reversing process looks only at the **Revering entry** and **Reversing date** settings on the **Lines** section of the voucher. This approach allows a journal to include some vouchers that are marked for reversing, and others that aren't.

The values from the journal are only used as defaults when adding *new* lines. Changing the values on the journal doesn't affect existing lines. In this example, the voucher lines were entered first. When you enter the line detail before designating the journal as reversing, the designation as a reversing entry and date won't be applied to any existing lines.

Changing the reversing entry or reversing date on an existing line propagates that change to other lines in the same voucher. To optimize performance, the grid isn't refreshed after propagating changes to other Lines. You can display the updated values by refreshing the grid.
