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
  - CI 9823
  - CI 12201
ms.reviewer: macodero, ninob, v-kccross
appliesto: 
  - Exchange Server 2019
  - Exchange Server 2016
search.appverid: MET150
ms.date: 07/07/2026
---
# Can't remove a remote shared mailbox by using the Exchange admin center on Exchange Server

## Summary

This article describes an issue in Exchange hybrid deployments in which administrators can't remove a remote shared mailbox by using the Exchange admin center (EAC) and receive an error that the mailbox isn't a mailbox user. The issue occurs because EAC uses the `Remove-Mailbox` PowerShell cmdlet, which can't locate the remote shared mailbox object. As a workaround, remove the mailbox by running the `Remove-RemoteMailbox` cmdlet in Exchange Management Shell (EMS).

## Symptoms

In an Exchange hybrid deployment, when you try to remove a remote shared mailbox by using the Exchange admin center (EAC) in Exchange Server, you receive the following error message:

> \<Mailbox_name> isn't a mailbox user.  

## Cause

This issue occurs because the EAC attempts to use the `Remove-Mailbox` cmdlet to remove the mailbox, but this cmdlet is unable to find the specified mailbox object. This behavior can be verified by checking the logs for the commands that were run.

## Workaround

To remove the remote shared mailbox, run the [Remove-RemoteMailbox](/powershell/module/exchange/remove-remotemailbox) cmdlet in [Exchange Management Shell](/powershell/exchange/open-the-exchange-management-shell) instead.
