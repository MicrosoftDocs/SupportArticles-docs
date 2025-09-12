---
title: Print Age as of in Aged Trial Balance and Historical Aged Trial Balance
description: Describes the difference between the Print/Age as of option in the Aged Trial Balance and in the Historical Aged Trial Balance.
ms.reviewer: theley, v-jomcc
ms.date: 04/17/2025
ms.custom: sap:Financial - General Ledger
---
# The difference between the "Print/Age as of" option in the Aged Trial Balance and in the Historical Aged Trial Balance

The Historical Aged Trial Balance is for previous periods and the Aged Trial Balance will include everything that has been posted but is unapplied or partially applied. In the Aged Trial Balance, what does the `Print/Age as of` field do, and will it make a difference if I put a different date in this field?

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 853181

The `Print/Age as of` option in the Aged Trial Balance is used to select how you want to age the documents included on the report. The date that you enter in the field will be the date that the report is aged as of.

The Aged Trial Balance includes all open documents aged according to the `Print/Age as of` date. The Historical Trial Balance also includes all open documents, and it also includes all Historical Transactions within the `Print/Age as of` date. It's aged according to this date as well.

For example, an open document dated 7/15/07 will be included in the Current Column on the Aged Trial Balance report if it's `aged as of` 6/30/07. If you print the same report and change the `Aged as of` date to 8/30/07, the document will appear in the **31-60 Days** column, depending how you're aging in the PM Setup. The same document won't be included on the Historical Aged Trial Balance if you have your `Age as of` date set to 6/30/07 and if the document date is 7/15/07.
