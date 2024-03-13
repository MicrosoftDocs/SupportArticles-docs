---
title: All cash receipt transactions not imported
description: Describes a problem that occurs because duplicate check numbers are in imported transactions. A workaround is provided.
ms.reviewer: theley, ryanklev, cwaswick
ms.topic: troubleshooting
ms.date: 03/13/2024
---
# All the cash receipt transactions are not imported in when duplicate check numbers exist using Lockbox Processing

This article provides a workaround for the issue that all the cash receipt transactions aren't imported due to the duplicate check numbers.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 915100

## Symptoms

When you import cash receipt transactions using Lockbox Processing in Microsoft Dynamics GP, only the first check is imported in where this check number is duplicated in the import file. It will skip the succeeding records for the duplicate check number and these transactions are not listed on the exception report, so the user does not receive any messages that indicate that the transactions were not imported.

## Cause

This problem occurs because duplicate check numbers exist in the imported transactions.

## Workaround

To work around this problem, you must add another field to the Lockbox import file to make the record unique, such as Customer ID or Customer Name. To do this, follow these steps:

1. Open the lockbox file by selecting **Cards**, point to **Sales** and select **Lockbox**.
2. Bring up the Lockbox ID you are using.
3. In the lockbox mapping, add Customer Name or Customer ID to the Header row.
4. Select **Save**.
5. Ask the bank to include either the Customer ID or the Customer Name to the lockbox file they generate. Make sure you mapped the field in the Lockbox file to the same spaces in the line that the bank added it to the lockbox file.
