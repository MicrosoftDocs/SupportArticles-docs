---
title: Dynamic distribution group members don't receive emails
description: Describes an issue in an Exchange hybrid deployment in which email messages are not delivered to members of a dynamic distribution group. Provides a solution.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Groups, Lists, Contacts, Public Folders
  - Exchange Hybrid
  - CSSTroubleshoot
ms.reviewer: v-six
appliesto: 
  - Exchange Online
  - Exchange Server 2013 Enterprise
  - Exchange Server 2013 Standard Edition
search.appverid: MET150
ms.date: 01/24/2024
---
# Members of a dynamic distribution group in an Exchange hybrid deployment don't receive email messages

_Original KB number:_ &nbsp; 3061396

## Symptoms

You have a hybrid deployment of Exchange Online in Microsoft 365 and on-premises Exchange Server. In this environment, certain members of a dynamic distribution group do not receive email messages. Senders also do not receive a non-delivery report (NDR). However, if a sender manually adds the user to the **To** field of an email message instead of sending the message to the distribution group, the message is delivered to and received by the user.

Additionally, if you run a command such as the following to return a list of recipients in the dynamic distribution group, the user doesn't appear in the list:

```console
$list = Get-DynamicDistributionGroup sales@contoso.com  
Get-Recipient -RecipientPreviewFilter $list.RecipientFilter -OrganizationalUnit $list.RecipientContainer
```

## Cause

This problem occurs if the dynamic distribution group was set up before the environment became a hybrid deployment and if the dynamic distribution group uses filters to include only mailboxes. Mailboxes that are migrated to Microsoft 365 become mail-enabled users in the on-premises directory.

## Resolution

Use the `Set-DynamicDistributionGroup` cmdlet to update the filters for the dynamic distribution group to include mail-enabled users. For example, run the following command:

```powershell
Set-DynamicDistributionGroup -Identity sales@contoso.com -RecipientFilter {(RecipientType -eq 'UserMailbox') -or (RecipientType -eq 'MailUser') -or (RecipientType -eq 'MailContact')}
```

> [!IMPORTANT]
> When you add filters to an existing dynamic distribution, be sure to include the existing recipient filters. Why? The `Set-DynamicDistributionGroup` cmdlet replaces the existing recipient filters with the value that you specify. Also, you don't need to specify the default recipient filters. Exchange will add these filters automatically.

## More information

For more information, see [Get-DynamicDistributionGroup](/powershell/module/exchange/get-dynamicdistributiongroup) and [Set-DynamicDistributionGroup](/powershell/module/exchange/set-dynamicdistributiongroup).

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/) or the [Exchange TechNet Forums](/answers/topics/office-exchange-server-itpro.html).
