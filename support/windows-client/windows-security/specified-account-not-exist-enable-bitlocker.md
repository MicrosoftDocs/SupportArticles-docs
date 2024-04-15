---
title: The specified account does not exist when you try to enable BitLocker
description: Provides a resolution for the issue that the Specified Account does not exist when you try to enable BitLocker
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, manojse, dereka
ms.custom: sap:Windows Security Technologies\BitLocker, csstroubleshoot
---
# Error when you enable BitLocker: The specified account does not exist

This article provides a resolution to an error (the specified account doesn't exist) that occurs when you try to enable BitLocker.

_Applies to:_ &nbsp; Windows Server 2012 R2, Windows Server 2008 R2 Service Pack 1, Windows 7 Service Pack 1  
_Original KB number:_ &nbsp; 2665635

## Symptoms

When a new user logs in to a machine and attempts to enable BitLocker, the following error occurs:

> The specified account does not exist.

## Cause

When the current user account isn't recognized by the AD, BitLocker receives a standard error code - ERROR_NO_SUCH_USER, which is converted to the standard error message: The specified account does not exist.

One reason this error message can be thrown is, if the BitLocker wizard failed to back up the recovery password to Active Directory because the account is not fully replicated to all domain controllers, in particular the one the client connected to.

## Resolution

Wait for AD replication to complete for the account and try again.
