---
title: Retention policy no longer works after mailbox moved
description: Describes a scenario where the retention policy doesn't work after you move a mailbox from the on-premises environment to Exchange Online in a hybrid deployment. Provides a solution.
author: Cloud-Writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Retention
  - CSSTroubleshoot
ms.reviewer: neozhu
appliesto: 
  - Exchange Online
  - Exchange Server 2016 Enterprise Edition
  - Exchange Server 2016 Standard Edition
  - Exchange Server 2013 Enterprise
  - Exchange Server 2013 Standard Edition
search.appverid: MET150
ms.date: 05/05/2025
---
# Retention policy no longer works after a mailbox is moved from the on-premises environment to Exchange Online

_Original KB number:_ &nbsp; 3194755

## Symptoms

When you move a mailbox from the on-premises Exchange environment to Exchange Online in a hybrid deployment, the retention policy that's applied to the mailbox no longer works.

You experience this issue even though you took one or both of the following actions:

- You re-created the retention policy and assigned it to the mailbox.
- You re-created the retention tag and added it to the retention policy.

## Cause

Retention hold is enabled on the mailbox. By default, retention hold is enabled when a mailbox is moved from the on-premises organization to Exchange Online. When a mailbox is placed on retention hold, the processing of the retention policy for that mailbox is suspended.

To verify that retention hold is enabled on a mailbox, follow these steps:

1. Connect to Exchange Online by using remote PowerShell. For more information, see [Connect to Exchange Online PowerShell](/powershell/exchange/connect-to-exchange-online-powershell).
2. Run the following command:

   ```powershell
   Get-mailbox user@contoso.com |fl
   ```

3. Examine the output. If the `RetentionHoldEnabled` parameter is set to **True**, retention hold is enabled.

## Resolution

Disable retention hold on the mailbox. To do this, follow these steps:

1. Connect to Exchange Online by using remote PowerShell. For more information, see [Connect to Exchange Online PowerShell](/powershell/exchange/connect-to-exchange-online-powershell).
2. Run the following command:

   ```powershell
   Set-Mailbox user@contoso.com -RetentionHoldEnabled $false
   ```

## More information

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/) or the [Microsoft Q&A](/answers/products/?WT.mc_id=msdnredirect-web-msdn).
