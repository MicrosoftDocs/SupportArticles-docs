---
title: Visibility to which GL accounts are inactive in FA batch
description: Visibility to which GL accounts are inactive in an FA batch in Microsoft Dynamics GP.
ms.reviewer: theley
ms.date: 03/13/2024
ms.custom: sap:Financial - General Ledger
---
# Visibility to which GL accounts are inactive in an FA batch in Microsoft Dynamics GP

This article describes a functionality request about the visibility to which GL accounts are inactive in an FA batch in Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 4508204

## Summary

When trying to post FA to General Ledger (that is, **MDGP** > **Tools** > **Routines** > **FA** > **GL Posting**), if any of the GL accounts in the batch are inactive, you cannot post and receive a message that some of the accounts are inactive.

However, there doesn't appear to be any notification of which inactive accounts are the problem. Including the problem account(s) along with the rest of the message would be ideal. If that is not possible, then providing some other means of easily identifying the inactive accounts in the FA batch would be helpful.

Our workaround of dumping the edit list to excel and then doing a vlookup against a list of inactive accounts wasn't too difficult, but nevertheless is a bit time consuming and should be unnecessary IMHO.

## Status

Microsoft is considering this functionality for a future release.
