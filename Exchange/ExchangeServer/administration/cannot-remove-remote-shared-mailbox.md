---
title: Can't remove a remote shared mailbox
description: Provides a workaround for an issue in which you can't remove a remote shared mailbox in on-premises Exchange admin center because it uses the Remove-Mailbox cmdlet that can't find the specified mailbox object.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:OWA  And Exchange Admin Center\Need help in configuring EAC
  - Exchange Server
  - CSSTroubleshoot
  - CI 163381
ms.reviewer: macodero, ninob
appliesto: 
  - Exchange Server 2016
  - Exchange Server 2019
search.appverid: MET150
ms.date: 01/24/2024
---
# Can't remove a remote shared mailbox by using the Exchange admin center on Exchange Server

## Symptoms

In an Exchange hybrid deployment, when you try to remove a remote shared mailbox by using the Exchange admin center (EAC) in Exchange Server, you receive the following error message:

> \<Mailbox_name> isn't a mailbox user.  

## Cause

This issue occurs because the EAC attempts to use the `Remove-Mailbox` cmdlet to remove the mailbox, but this cmdlet is unable to find the specified mailbox object. This behavior can be verified by checking the logs for the commands that were run.

## Workaround

To remove the remote shared mailbox, run the [Remove-RemoteMailbox](/powershell/module/exchange/remove-remotemailbox) cmdlet in [Exchange Management Shell](/powershell/exchange/open-the-exchange-management-shell) instead.
