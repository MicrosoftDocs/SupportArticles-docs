---
title: Outlook issues when msExchMasterAccountSID attribute exists on a user account
description: Documentation for OffCAT diagnostic issue where Outlook has connection issues to Exchange related to msExchMasterAccountSID on the user mailbox.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Exchange Server
  - CSSTroubleshoot
ms.reviewer: tmoore, gregmans, v-six
appliesto: 
  - Outlook 2016
  - Outlook 2013
  - Microsoft Outlook 2010
  - Outlook for Microsoft 365
  - Outlook 2019
search.appverid: MET150
ms.date: 01/24/2024
---
# Outlook issues when the msExchMasterAccountSID attribute exists on a user account in Active Directory

_Original KB number:_ &nbsp;2996202

## Symptoms

After a mailbox move or migration, one or more of the following issues may be displayed:

- Some mailboxes show as linked or shared rather than as user mailboxes.
- Repeated mailbox credential prompts in Microsoft Outlook or Outlook Web App (OWA)
- Unexpected delays in, or halted mail flow.
- Problems accessing Public Folders, and sometimes resulting in the following error:

    > Cannot expand the folder. Microsoft Exchange is not available. Either there are network problems or the Exchange Server is down for maintenance.

## Cause

This behavior can occur if a regular user account has the `msExchMasterAccountSID` attribute populated in Active Directory.

## Resolution

To correct this issue, run the following PowerShell command from the Exchange Management Shell:

```powershell
Set-User -Identity useraddress -LinkedMasterAccount $null
```

For example:

```powershell
Set-User -Identity user@fabricam.com -LinkedMasterAccount $null
```

This command will remove the `msExchMasterAccountSID` attribute from the user's account.

## More information

The `msExchMasterAccountSID` attribute shouldn't exist for a regular user account in Active Directory. A regular user will be identified as having an `msExchRecipientTypeDetails` attribute value of **1** (1 = normal mailbox, 2 = linked mailbox.)

If **msExchRecipientTypeDetails = 1**, then `msExchMasterAccountSID` shouldn't exist on the account in Active Directory.

For more information on possible values for the `msExchRecipientTypeDetails` attribute, see [O365: Exchange and AD - How msExchRecipientDisplayType and msExchangeRecipientTypeDetails Relate to Your On-Premises](https://vermagautam85.blogspot.com/2017/08/o365-exchange-and-ad-how.html).
