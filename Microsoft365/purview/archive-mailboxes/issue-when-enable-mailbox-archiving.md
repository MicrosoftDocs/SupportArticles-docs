---
title: Issue when you enable mailbox archiving in an Exchange hybrid deployment.
description: Describes an issue that triggers an error when you use the Exchange admin center in Exchange Online to enable archiving for a mailbox that was moved from your on-premises environment to Exchange Online.
author: helenclu
ms.author: luche
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Archiving
  - CSSTroubleshoot
ms.reviewer: shahmul
appliesto: 
  - Exchange Online
  - Microsoft Exchange Hosted Archive
search.appverid: MET150
ms.date: 06/24/2024
---

# "Error occurred during validation in agent 'Windows LiveId Agent'" when you try to enable archiving for a mailbox in an Exchange hybrid deployment

_Original KB number:_&nbsp;2936559

> [!NOTE]
> The Hybrid Configuration wizard that's included in the Exchange Management Console in Microsoft Exchange Server 2010 is no longer supported. Therefore, you should no longer use the old Hybrid Configuration wizard. Instead, use the Microsoft 365 Hybrid Configuration wizard that's available at  [Microsoft 365 Hybrid Configuration wizard](https://aka.ms/hybridwizard). For more information, see [Microsoft 365 Hybrid Configuration wizard for Exchange 2010](https://techcommunity.microsoft.com/t5/exchange-team-blog/office-365-hybrid-configuration-wizard-for-exchange-2010/ba-p/604541).

## Problem

In a Microsoft Exchange hybrid deployment, you move a mailbox from the on-premises Exchange environment to Exchange Online. However, when you try to enable archiving for that mailbox from the Exchange admin center in Exchange Online, you receive the following error message:

> The following error occurred during validation in agent 'Windows LiveId Agent': 'Unable to perform the save operation. '\<UserName>′ is not within a valid server write scope.'
> Click here for help...'

## Cause

This problem occurs because recipient management must be performed from the on-premises environment when you're using Active Directory synchronization.

## Solution

To resolve this issue, enable archiving for the mailbox from the on-premises Exchange server. To do this, use one of the following methods.

### Method 1: Use the Exchange Admin Center or the Exchange Management Console

#### In Exchange 2013

1. Open the Exchange Admin Center.
2. Click **recipient**, and then click **mailboxes**.
3. Click the mailbox that you want to change, click **Enable** under **In-Place Archive**, and then click **yes**.
4. Wait for two cycles of directory synchronization to run (about six hours). Or, force directory synchronization. For more info about how to do this, see [Synchronize your directories](/azure/active-directory/hybrid/whatis-hybrid-identity).

#### In Exchange 2010

1. Open the Exchange Management Console.
2. In the console tree, expand **Recipient Configuration**, and then click **Mail Contact**.
3. Right-click the contact that you want to change, and then click **Enable Hosted Archive**.
4. Wait for two cycles of directory synchronization to run (about six hours). Or, force directory synchronization. For more info about how to do this, see [Synchronize your directories](/azure/active-directory/hybrid/whatis-hybrid-identity).

### Method 2: Use the Exchange Management Shell

1. Open the Exchange Management Shell, and then run the following cmdlet:

   ```powershell
   Enable-RemoteMailbox <UserName> -Archive
   ```

2. Wait for two cycles of directory synchronization to run (about six hours). Or, force directory synchronization. For more info about how to do this, see [Synchronize your directories](/azure/active-directory/hybrid/whatis-hybrid-identity).

## More information

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/) or the [Exchange TechNet Forums](/answers/topics/office-exchange-server-itpro.html).
