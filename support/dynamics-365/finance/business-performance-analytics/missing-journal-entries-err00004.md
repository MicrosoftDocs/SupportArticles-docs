---
title: Missing journal entries error
description: Provides information about the Missing journal entries error (error code ERR00004) in Business performance analytics in Microsoft Dynamics 365 Finance.
author: jinniew
ms.author: jiwo
ms.reviewer: twheeloc 
ms.date: 11/21/2024
ms.custom: sap:Business intelligence, reporting, analytics
ms.search.form: business-performance-analytics
audience: Application User
---
# Missing journal entries: Error code: ERR00004 - [Type: Warning]

## Symptoms

Error code *ERR00004* is logged in the **Bpa self help logs** table in Microsoft Dataverse when the `Recid` column of `generaljournalaccountentry.generaljournalentry` in Dynamics 365 Finance isn't found in the `Recid` column of the `generaljournalentry` table. These records are excluded and aren't transferred to fact tables. Some Microsoft reports might show empty or incomplete data. In these cases, you might have to create modified versions of the reports to address the gaps and ensure accurate reporting.

## Resolution

No immediate action is required, because this issue might be caused by a delay in data synchronization. We recommend that you observe the next few Business performance analytics runs to see whether the issue is fixed.

If the issue persists, confirm that the entries are in the General journal entry table in Dynamics 365 Finance. If the records are in the table, contact Microsoft Support for further assistance.

Here's an example of a record:

> Can't find GeneralJournalEntry for 4 records in GeneralJournalAccountEntry - [Row(GJAE_RECID=Decimal('5637144581')), Row(GJAE_RECID=Decimal('5637144582')), Row(GJAE_RECID=Decimal('5637144583')), Row(GJAE_RECID=Decimal('5637144584'))]

## See also

[Business performance analytics self-help](business-performance-analytics-self-help-overview.md)
