---
title: Shared mailboxes unexpectedly convert to user mailboxes
description: Describes that mailboxes that were moved from the on-premises environment to Office 365 and converted to shared mailboxes are unexpectedly converted to regular mailboxes after directory synchronization runs. Provides a resolution.
author: simonxjx
ms.author: v-six
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.prod: exchange-server-it-pro
localization_priority: Normal
ms.custom: 
- Exchange Hybrid
- CSSTroubleshoot
ms.reviewer: jhayes, benwinz
appliesto:
- Exchange Online
- Exchange Server 2016 Enterprise Edition
- Exchange Server 2016 Standard Edition
- Exchange Server 2013 Standard Edition
- Exchange Server 2013 Enterprise
- Exchange Server 2010 Standard 
- Exchange Server 2010 Enterprise
search.appverid: MET150
---
# Shared mailboxes are unexpectedly converted to user mailboxes after directory synchronization runs in an Exchange hybrid deployment

_Original KB number:_ &nbsp; 2710029

> [!NOTE]
> The Hybrid Configuration wizard that's included in the Exchange Management Console in Microsoft Exchange Server 2010 is no longer supported. Therefore, you should no longer use the old Hybrid Configuration wizard. Instead, use the Office 365 Hybrid Configuration wizard that's available at [https://aka.ms/HybridWizard](https://aka.ms/hybridwizard). For more information, see [Office 365 Hybrid Configuration wizard for Exchange 2010](https://techcommunity.microsoft.com/t5/exchange-team-blog/office-365-hybrid-configuration-wizard-for-exchange-2010/ba-p/604541).

## Symptoms

Assume that you have a hybrid deployment of Microsoft Exchange Online in Microsoft Office 365 and on-premises Microsoft Exchange Server. After directory synchronization runs, regular (user) mailboxes in Exchange Online that were converted to shared mailboxes may unexpectedly be reverted to regular mailboxes. When this occurs, you may be unable to convert the mailboxes back to shared mailboxes. Even if you can make this conversion, the mailboxes may revert to regular mailboxes again the next time that directory synchronization runs.

If a license is not assigned to the user, the mailbox may be disconnected. This can cause potentially irrecoverable data loss.

Additionally, when you view the properties of the shared mailboxes in the Office 365 portal, you may receive the following error message:

> Exchange: Couldn't convert the mailbox because the mailbox \<Guid> is already of the type 'Regular'

## Cause

This issue occurs if the `RemoteRecipientType` attribute is set incorrectly. To be able to convert a User mailbox to a Shared mailbox and not have it be converted back to a User mailbox, the `RemoteRecipientType` attribute must reflect that the mailbox was migrated or that it is a Shared mailbox. If it does not, directory synchronization replicates the attributes to the cloud. Then, Office 365 converts the Shared mailbox to a regular `UserMailbox` object. If the user isn't licensed and if the 30-day grace period has ended, the mailbox is disconnected and converted to a `MailUser` object when license reconciliation runs.

## Resolution

To resolve this issue, make sure that a remote mailbox is provisioned for the account, and then update the `RemoteRecipientType` attribute. To do this, follow these steps:

1. If the mailbox in Exchange Online is disconnected, temporarily assign a license to the user. This automatically reconnects the mailbox.

2. If a remote mailbox doesn't exist for that user, run the following command:

    ```powershell
    Enable-RemoteMailbox -Identity PrimarySmtpAddress -RemoteRoutingAddress TargetAddressDomain
    ```

    > [!NOTE]
    > The `TargetAddressDomain` value represents your coexistence domain (for example, `alias@contoso.mail.onmicrosoft.com`).

3. Set the `RemoteRecipientType` attribute to reflect that the mailbox is a migrated Shared mailbox. To do this, run the following command:

    ```powershell
    Set-ADUser -Identity ((Get-Recipient PrimarySmtpAddress).samaccountname) -Replace @{msExchRemoteRecipientType=100;msExchRecipientTypeDetails=34359738368}
    ```

## More information

This behavior is by design when directory synchronization is configured and the `RemoteRecipientType` attribute is set incorrectly.

You can use the `New-RemoteMailbox` or `Set-RemoteMailbox` cmdlet to set the `Type` parameter of the mailbox to **Shared** with Exchange 2013 CU21 or later, Exchange 2016 CU10 or later, and Exchange 2019 and this process should only be used if you don't have Exchange 2013 or above with the latest or the previous CU or if you do but receive the error "remoteMailbox.RemoteRecipientType must include ProvisionMailbox" when changing the remote mailbox type to shared. Therefore, in order to set the attribute values correctly, the `Set-ADUser` cmdlet is required.

> [!NOTE]
> Under most circumstances, Microsoft does not support the use of non-Exchange tools to manually change Exchange attributes. Because of the limitation in these cmdlets, this behavior is identified as an exception to this support stance.

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/) or the [Exchange TechNet Forums](/answers/topics/office-exchange-server-itpro.html).
