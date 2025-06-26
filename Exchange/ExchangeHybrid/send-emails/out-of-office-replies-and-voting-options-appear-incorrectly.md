---
title: Out-of-office replies and voting options show wrongly
description: Discusses that out-of-office replies and voting options in email messages between on-premises users and Exchange Online users do not appear correctly in a hybrid deployment. Provides a resolution.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Mail Flow
  - Exchange Hybrid
  - CSSTroubleshoot
ms.reviewer: vibour, joelric, v-six
appliesto: 
  - Exchange Online
  - Exchange Server 2013 Enterprise
  - Exchange Server 2013 Standard Edition
  - Exchange Server 2010 Enterprise
  - Exchange Server 2010 Standard
search.appverid: MET150
ms.date: 01/24/2024
---
# Out-of-office replies and voting options in email between on-premises and Exchange Online users appear incorrectly

> [!NOTE]
> The Hybrid Configuration wizard that's included in the Exchange Management Console in Microsoft Exchange Server 2010 is no longer supported. Therefore, you should no longer use the old Hybrid Configuration wizard. Instead, use the Microsoft 365 Hybrid Configuration wizard that's available at [https://aka.ms/HybridWizard](https://aka.ms/hybridwizard). For more information, see [Microsoft 365 Hybrid Configuration wizard for Exchange 2010](https://blogs.technet.com/b/exchange/archive/2016/02/17/office-365-hybrid-configuration-wizard-for-exchange-2010.aspx).

_Original KB number:_ &nbsp; 3070442

## Symptoms

Consider the following scenario:

- You have a hybrid deployment of on-premises Microsoft Exchange Server and Exchange Online in Microsoft 365.
- The on-premises environment includes both Exchange Server 2013-based servers and Exchange Server 2010-based servers.
- An Exchange Online user sends an email message to an on-premises user or an on-premises user sends an email message to an Exchange Online user.

In this scenario, the users experience the following symptoms:

- Out-of-office MailTips and replies do not appear correctly.
- Voting options in messages are missing or do not appear correctly.

## Cause

This problem may occur if remote domain settings are missing or are set incorrectly.

## Resolution

To resolve this problem, update the remote domain settings in Microsoft 365. To do this, use the procedure for either or both of the following scenarios, as appropriate for your situation.

### Scenario 1 - Exchange Online users can't view out-of-office replies and voting options of on-premises users

1. Connect to Exchange on-premises PowerShell.
2. Run the following commands, in which `<contoso>.mail.onmicrosoft.com` is the mail routing domain for the Exchange Online tenant. If you have multiple primary SMTP address spaces for users in your organization, repeat these steps for each domain.

   ```powershell
   Set-RemoteDomain "contoso.mail.onmicrosoft.com" -TNEFEnabled $true -AllowedOOFType "InternalLegacy"
   ```

3. Test to verify that the problem is resolved.

### Scenario 2 - On-premises users can't view out-of-office replies and voting options of Exchange Online users

This scenario occurs because Exchange Online strips out the Transport Neutral Encapsulation Format (TNEF) content (specifically, the voting buttons). To prevent Exchange Online from removing the TNEF content when an email message is sent to an on-premises user, enable TNEF on the remote domain.

Create remote domains for each of your on-premises domains that have to use TNEF-based features. Then, set the **TNEFEnabled** parameter on those specific remote on-premises domains. To do this, run the following commands in Exchange Online:

```powershell
New-RemoteDomain -DomainName contoso.com
Set-RemoteDomain "contoso.com" -TNEFEnabled $true -AllowedOOFType "InternalLegacy"
```

## More information

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/) or the [Microsoft Q&A](/answers/products/?WT.mc_id=msdnredirect-web-msdn).
