---
title: Remote mailbox not moved when move shows as Completed
description: Describes that the Exchange Management Console in Exchange 2010 shows that an on-premises mailbox that you moved to Exchange Online completed successfully even though the mailbox isn't moved. Provides a resolution.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Migration
  - Exchange Online
  - CSSTroubleshoot
ms.reviewer: v-mosha, v-six
appliesto: 
  - Exchange Online
  - Exchange Server 2016 Enterprise Edition
  - Exchange Server 2016 Standard Edition
  - Exchange Server 2013 Enterprise
  - Exchange Server 2013 Standard Edition
  - Exchange Server 2010 Enterprise
  - Exchange Server 2010 Standard
search.appverid: MET150
ms.date: 01/24/2024
---
# Remote mailbox is not moved from Exchange Server 2010 to Exchange Online when move shows as Completed

_Original KB number:_ &nbsp; 2886058

## Symptoms

Consider the following scenario.

- You are using Microsoft 365.
- You perform a move request for a remote mailbox from an on-premises Exchange 2010 server to Exchange Online.
- After you perform the move request, the Exchange Management Console shows the status of the request as **Completed**.

In this scenario, the mailbox isn't moved, and the move request isn't listed on the migration page of the Exchange admin center in Exchange Online.

## Cause

This issue occurs if the on-premises mailbox that you want to move was created in Exchange Server 2016 or Exchange Server 2013, and you have an on-premises environment that's also running Exchange Server 2010. In this scenario, you can't move the mailbox from an Exchange 2010 server.

## Resolution

Perform the remote mailbox request from the Exchange admin center in Exchange Online.

## More information

To check whether the move process is working correctly, follow these steps:

1. Open the Exchange admin center on the on-premises Exchange server.
2. Select **Office 365**, select **recipients** in the left navigation pane, and then select **migration**.

3. View the move status of the mailboxes. You should see the following values:
   - The status shows as **Syncing** during the mailbox move process.
   - The status shows as **Completed** after the mailbox is successfully moved.

> [!NOTE]
> You can also run the following cmdlet in the Exchange Management Shell to check the status of the migration batch:

```powershell
Get-MigrationBatch -Identity <Batch Name>
```

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/) or the [Microsoft Q&A](/answers/products/?WT.mc_id=msdnredirect-web-msdn).
