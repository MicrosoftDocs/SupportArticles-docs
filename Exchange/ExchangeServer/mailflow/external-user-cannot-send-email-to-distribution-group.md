---
title: Can't externally send emails to Distribution Group
description: This article resolves an issue in which you receive a NDR message when you send an email message from an external domain to a Distribution Group.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Exchange Server
  - CSSTroubleshoot
search.appverid: 
  - MET150
appliesto: 
  - Exchange Server 2010
  - Exchange Server 2007
ms.date: 01/24/2024
ms.reviewer: v-six
---
# 550 550 5.1.1 or 550 5.7.1 NDR message when an external user sends an email message to a Universal Distribution Group

_Original KB number:_ &nbsp; 2773786

## Symptoms

Assume that you create a mail-enabled Universal Distribution Group in Microsoft Exchange Server 2007 or Microsoft Exchange Server 2010. When you try to send an email message from an external domain to this Distribution Group, you receive a non-delivery report (NDR) message together with one of the following error codes:

> 550 550 5.1.1 User unknown (state 14)
>
> 550 5.7.1 RESOLVER.RST.AuthRequired; authentication required

## Cause

This issue occurs because the **Require that all senders are authenticated** option is enabled on the Distribution Group. By default, this option is enabled for any new Distribution Groups that are created in Exchange 2010 or Exchange 2007.

To resolve this issue, use one of the following methods, as appropriate for your situation.

## Resolution 1: Use Exchange Management Console

1. Click **Start**, click **All Programs**, click **Microsoft Exchange Server 2010**, and then click **Exchange Management Console** to open Exchange Management Console.
2. In the Exchange Management Console tree, click **Recipient Configuration**, and then click **Distribution Group**.
3. In the result pane, right-click the affected Distribution Group, and then click **Properties**.
4. On the **Mail Flow Settings** tab, click **Message Delivery Restrictions**, and then click **Properties**.
5. Clear the **Require that all senders are authenticated** option check box, and then click **OK**.
6. Force replication among the domain controllers.

## Resolution 2: Use Exchange Management Shell

1. Click **Start**, click **All Programs**, click **Microsoft Exchange Server 2010**, and then click **Exchange Management Shell** to open Exchange Management Shell.
2. Type the following cmdlet, and then press Enter:

    ```powershell
    Set-Distributiongroup -identity "Distribution group name" -RequireSenderAuthenticationEnabled $false
    ```  

## More information

This issue doesn't occur for Distribution Groups that are migrated from a legacy version of Exchange to Exchange Server 2007 or Exchange Server 2010. For more information about Recipient Restrictions, see [Understanding Recipient Restrictions](/previous-versions/office/exchange-server-2010/bb124405(v=exchg.141)).
