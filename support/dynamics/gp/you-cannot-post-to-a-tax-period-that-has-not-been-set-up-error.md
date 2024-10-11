---
title: You can't post to a tax period that has not been set up
description: You can't post on a new Australian installation for Microsoft Dynamics GP. Provides a resolution.
ms.reviewer: theley, cwaswick
ms.topic: troubleshooting
ms.date: 03/20/2024
ms.custom: sap:Financial - General Ledger
---
# "You can't post to a tax period that has not been set up" in Microsoft Dynamics GP

This article provides a resolution for the issue that you can't post on a new Australian installation for Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 4498538

## Symptoms

When trying to post on a new Australian installation for Microsoft Dynamics GP, you receive the following error message:

> You can't post to a tax period that has not been set up.

## Cause

No tax periods have been set up.

## Resolution

Set up the tax periods as follows:

1. Go to **Microsoft Dynamics GP** > **Tools** > **Setup** > **Company** > **Tax periods**.  
2. Select the Year and select **Calculate**.
3. Edit dates as needed and select **OK**.
