---
title: Microsoft 365 users don't receive out-of-office message
description: Describes an issue in which Microsoft 365 users don't receive out-of-office replies from on-premises users in a hybrid deployment of on-premises Exchange Server and Exchange Online. Provides a workaround.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Mail Flow
  - Exchange Hybrid
  - CSSTroubleshoot
ms.reviewer: v-six
appliesto: 
  - Exchange Online
search.appverid: MET150
ms.date: 01/24/2024
---
# Microsoft 365 users don't receive out-of-office notifications from on-premises users in a hybrid deployment

_Original KB number:_ &nbsp; 2871053

> [!NOTE]
> The Hybrid Configuration wizard that's included in the Exchange Management Console in Microsoft Exchange Server 2010 is no longer supported. Therefore, you should no longer use the old Hybrid Configuration wizard. Instead, use the Microsoft 365 Hybrid Configuration wizard that's available at [https://aka.ms/HybridWizard](https://aka.ms/hybridwizard). For more information, see [Microsoft 365 Hybrid Configuration wizard for Exchange 2010](https://techcommunity.microsoft.com/t5/exchange-team-blog/office-365-hybrid-configuration-wizard-for-exchange-2010/ba-p/604541).

## Symptoms

Consider the following scenario. You have a hybrid deployment of on-premises Microsoft Exchange Server and of Exchange Online in Microsoft 365, in which there are both on-premises mailboxes and Exchange Online mailboxes. When Microsoft 365 users send mail to on-premises users who have set up an out-of-office notification, Microsoft 365 users don't receive the out-of-office notification after the mail is sent.

Microsoft 365 users experience this issue even though the following conditions are true:

- Internal out-of-office replies are working correctly for the on-premises user.
- The internal out-of-office MailTip of the on-premises user is displayed in the mail client of the Microsoft 365 user.
- The properties of the on-premises remote domain are correctly set to `InternalLegacy`.

## Workaround

To work around this issue, do one of the following, as appropriate for your on-premises Exchange environment.

> [!NOTE]
> After you perform either of these procedures, Microsoft 365 mailboxes are treated as external mailboxes for the purposes of out-of-office messages. You may want to modify on-premises external out-of-office messages, if that becomes necessary.

### Exchange Server 2010 - Change the out-of-office setting for the remote domain

If you have an Exchange 2010 hybrid server, follow these steps:

1. On the Exchange Server 2010 hybrid server, open the Exchange Management Console.
2. Navigate to **Organization Configuration**, select **Hub Transport**, select the **Remote Domains** tab, and then double-click the remote domain.
3. Select the **General** tab, select **Allow external out-of-office message only**, and then select **OK**.

For more information about how to configure this setting in Exchange 2010, see [Configure remote domain properties](/previous-versions/office/exchange-server-2010/bb124931(v=exchg.141)).

### Exchange Server 2013 - Use the Exchange Management Shell to change the -AllowedOOFType property of the remote domain

If you have an Exchange Server 2013 hybrid server, use the `Set-RemoteDomain` cmdlet to change the `-AllowedOOFType` property of the Microsoft 365 remote domain. Here are two examples:

- `Set-RemoteDomain Contoso -AllowedOOFType External`
- `Set-RemoteDomain Contoso -AllowedOOFType ExternalLegacy`

For more information about the `Set-RemoteDomain` cmdlet, see [Set-RemoteDomain](/powershell/module/exchange/set-remotedomain?view=exchange-ps&preserve-view=true).

For more information about how to configure this setting in Exchange Server 2013, see [Configure remote domain out-of-office replies](/exchange/configure-remote-domain-out-of-office-replies-exchange-2013-help).

## Status

Microsoft is aware of this issue and is working to resolve it. We will post more information in this article when it becomes available.

## More information

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/) or the [Microsoft Q&A](/answers/products/?WT.mc_id=msdnredirect-web-msdn).
