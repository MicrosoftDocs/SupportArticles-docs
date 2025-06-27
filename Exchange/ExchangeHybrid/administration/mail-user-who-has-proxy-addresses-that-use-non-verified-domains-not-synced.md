---
title: Mail user who has proxy addresses isn't synced
description: Describes an issue in which a mail user who has proxy addresses that use non-verified domains isn't synced to Exchange Online in an Exchange hybrid deployment.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Hybrid
  - Exchange Hybrid
  - CSSTroubleshoot
ms.reviewer: jbower, jmartin, v-six
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
# A mail user who has proxy addresses that use non-verified domains isn't synced in an Exchange hybrid deployment

> [!NOTE]
> The Hybrid Configuration wizard that's included in the Exchange Management Console in Microsoft Exchange Server 2010 is no longer supported. Therefore, you should no longer use the old Hybrid Configuration wizard. Instead, use the Microsoft 365 Hybrid Configuration wizard that's available at [https://aka.ms/HybridWizard](https://aka.ms/hybridwizard). For more information, see [Microsoft 365 Hybrid Configuration wizard for Exchange 2010](https://techcommunity.microsoft.com/t5/exchange-team-blog/office-365-hybrid-configuration-wizard-for-exchange-2010/ba-p/604541).

_Original KB number:_ &nbsp; 3124148

## Symptoms

Assume that you have a hybrid deployment of on-premises Exchange Server and Exchange Online in Microsoft 365. You convert a remote user mailbox in Exchange Online to a mail user in Exchange Online. In this scenario, you can no longer sync that mail user to the cloud if that user's proxy addresses are set to use non-verified domains.

## Cause

This problem occurs if the value of the `msExchRemoteRecipientType` attribute was incorrectly set to **8** when the remote mailbox was disabled. Non-verified domains aren't synced when the value of the attribute is **8**. The value of the attribute for mail users should be **Null**.

## Workaround

> [!WARNING]
> This procedure requires Active Directory Service Interfaces Editor (ADSI Edit). Using ADSI Edit incorrectly can cause serious problems that may require you to reinstall your operating system. Microsoft cannot guarantee that problems that result from the incorrect use of ADSI Edit can be resolved. Use ADSI Edit at your own risk.

To resolve this problem, use ADSI Edit to clear the value of the `msExchRemoteRecipientType` attribute for the user. To do this, follow these steps:

1. Start ADSI Edit, and then connect to the default naming context.
2. Expand the domain, and then expand the organizational unit (OU) that contains the user object.
3. Right-click the user object, and then select **Properties**.
4. In Attribute Editor, locate and then select the `msExchRemoteRecipientType` attribute.
5. Select **Edit**, delete the value, and then select **OK**.
6. Wait for directory synchronization to run, or manually force synchronization.

## More information

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/) or the [Microsoft Q&A](/answers/products/?WT.mc_id=msdnredirect-web-msdn).
