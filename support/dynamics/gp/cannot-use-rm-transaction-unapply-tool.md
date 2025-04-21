---
title: Cannot use RM Transaction Unapply tool
description: Provides a solution to an error that occurs when trying to unapply a receivables payment in history using the RM Transaction Unapply tool in Professional Services Tools Library (PSTL) in Microsoft Dynamics GP.
ms.reviewer: theley, cwaswick
ms.topic: troubleshooting
ms.date: 04/17/2025
ms.custom: sap:Financial - Receivables Management
---
# Unable to use RM Transaction Unapply tool in PSTL in Microsoft Dynamics GP

This article provides a solution to an error that occurs when trying to unapply a receivables payment in history using the RM Transaction Unapply tool in Professional Services Tools Library (PSTL) in Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 4338680

## Symptom

When trying to unapply a receivables payment in history using the RM Transaction Unapply tool in PSTL in Microsoft Dynamics GP, you get this message:

> Documents XXXXXXXX Distributinos have realized gain/loss amounts or discount taken amounts or writeoff amounts and is a Multi currency document, and will not be unapplied.

## Cause

By design, you can't unapply sales documents where a gain/loss or discount was booked at the same time the transaction was posted, as further steps would be needed undo that gain/Loss/discount, and you can't unapply it from each other. So many multi-currency documents can't be unapplied using this tool because of that extra action done at the same time it was posted.

## Resolution

You would have to manually remove both documents from history, and manually reverse out the GL entries. Then you would have to rekey the documents back in.
