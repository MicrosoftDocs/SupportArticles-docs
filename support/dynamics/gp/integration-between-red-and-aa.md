---
title: Integration between RED and AA
description: Describes the integration between RED and AA in Microsoft Dynamics GP.
ms.reviewer: theley, cwaswick
ms.topic: troubleshooting
ms.date: 03/13/2024
---
# Integration between RED and AA in Microsoft Dynamics GP

There is limited compatibility between Revenue and Expense Deferrals (RED) and Analytical Accounting (AA) at this time in Microsoft Dynamics GP. This article discusses how to get AA codes on your deferral entries.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 3006081

## Cause

Limited compatibility between AA and RED.

## Resolution

You are not able to add/edit AA codes at time of entry for deferrals at this time. But as a workaround, you can use one of the options outlined below to go back and add/edit the AA data on the deferrals in a two-step process:

Option 1 - Post the deferral in GL. Then select **Transactions**, point to **Financial**, point to Analytical Accounting, and select **Edit Analysis**. Select the Journal Entry of the deferral and proceed to add/edit the AA data.

Option 2 - Stop the batch in GL and add the AA codes to the transactions in the GL work batch.

Option 3 - Enter default AA codes in the Trx Dimension Code Default fields on the Accounting Class, and these codes will get automatically assigned to the deferral entries. However, you would still have to use one of the other options if you want to change any of the codes.
