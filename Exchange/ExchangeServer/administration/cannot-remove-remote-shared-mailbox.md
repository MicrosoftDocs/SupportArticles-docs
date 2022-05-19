---
title: Can't remove a remote shared mailbox
description: Provides a workaround for an issue in which you can't remove a remote shared mailbox in Exchange admin center (EAC) because the EAC uses the Remove-Mailbox cmdlet that can't find the specified remote object.
author: MaryQiu1987
ms.author: v-maqiu
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Exchange Server
  - CSSTroubleshoot
  - CI 163381
ms.reviewer: macodero, ninob
appliesto: 
  - Exchange Server 2016
  - Exchange Server 2019
search.appverid: MET150
ms.date: 5/19/2022
---
# Can't remove a remote shared mailbox in Exchange admin center

## Symptoms

When you try to remove a remote shared mailbox in the Exchange admin center (EAC), you receive the following error message:

> \<Mailbox_name> isn't a mailbox user.  

## Cause

This issue occurs because the EAC uses the `Remove-Mailbox` cmdlet to remove a mailbox, but the cmdlet can't find the specified object to remove the remote shared mailbox.

**Note:** You can open the Show Command Logging window to check the cmdlet logs.

## Workaround

To remove the remote shared mailbox, use the [Remove-RemoteMailbox](/powershell/module/exchange/remove-remotemailbox) cmdlet in [Exchange Management Shell](/powershell/exchange/open-the-exchange-management-shell).
