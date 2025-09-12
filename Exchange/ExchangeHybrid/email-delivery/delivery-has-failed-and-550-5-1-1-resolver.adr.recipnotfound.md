---
title: Cannot send messages to a moved mailbox
description: Describes an issue in which users can't send messages to a mailbox that was recently moved from an on-premises environment to Exchange Online in Microsoft 365.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Mail Flow
  - Exchange Hybrid
  - CSSTroubleshoot
ms.reviewer: jhayes, v-six
appliesto: 
  - Exchange Online
  - Exchange Server 2013 Enterprise
  - Exchange Server 2013 Standard Edition
  - Exchange Server 2010 Enterprise
  - Exchange Server 2010 Standard
search.appverid: MET150
ms.date: 01/24/2024
---
# Delivery has failed and 550 5.1.1 RESOLVER.ADR.RecipNotFound NDR after a mailbox is moved to Microsoft 365

_Original KB number:_ &nbsp; 2685437

> [!NOTE]
> The Hybrid Configuration wizard that's included in the Exchange Management Console in Exchange 2010 is no longer supported. Stop using the old Hybrid Configuration wizard and instead use the Microsoft 365 Hybrid Configuration wizard at [https://aka.ms/HybridWizard](https://aka.ms/hybridwizard). For more information, see [Microsoft 365 Hybrid Configuration wizard for Exchange 2010](https://techcommunity.microsoft.com/t5/exchange-team-blog/office-365-hybrid-configuration-wizard-for-exchange-2010/ba-p/604541).

## Symptoms

Assume that you have a hybrid deployment of on-premises Microsoft Exchange Server and Exchange Online in Microsoft 365. You use the Mailbox Replication Service through the Exchange Management Console or the Exchange Management Shell to move a mailbox from the on-premises environment to Microsoft 365. However, after the mailbox is moved, on-premises users and external users can't send mail to that mailbox in Microsoft 365. The sender receives the following non-delivery report (NDR):

> Delivery has failed to these recipients or groups:
>
> <**Recipient email address**>
>
> Your e-mail was not delivered to all intended recipients. The e-mail address you specified doesn't exist, or may have been recently deleted. Please also check to ensure you typed the address properly. It is possible that your contact's e-mail address has changed and Outlook's AutoComplete has the old address stored. If this is the case, start typing their name in the To line, press the down arrow to select the outdated entry, and then press Delete. Now use the address book to locate the correct e-mail address.
>
> Diagnostic information for administrators:
>
> Generating server: <>
>
> <**Recipient email address**>
>
> #< # **5.1.1** smtp; **550 5.1.1** RESOLVER.ADR.RecipNotFound; not found> #SMTP#

## Cause

This issue may occur if the on-premises mail-enabled user who represents the moved mailbox isn't stamped correctly with the target address. The Exchange server generates an NDR message because the on-premises Active Directory Domain Services (AD DS) can't locate the user in order to route the mail correctly.

## Resolution

To resolve this issue, add the target address, also known as the service routing address, to the mail-enabled user in the on-premises environment. To do this, use one of the following methods.

### Method 1: Use the Exchange Management Console

1. Open the Exchange Management Console on your local Exchange 2010 server.
2. Select **Microsoft Exchange On-Premises**, and then select **Recipients Configuration**.
3. Right-click the user, and then select **Properties**.
4. On the **E-mail Addresses** tab, select **Add**, select **SMTP Address**, and then enter the email address. Use the `<alias>@<domain>.mail.onmicrosoft.com` format for the email address.
5. Select the name that you entered, and then select **Set as Routing Address**.
6. Select **OK**.

### Method 2: Use Exchange Admin Center

1. In a web browser on your local Exchange 2013 server, browse to the Exchange Admin Center.
2. Select **Recipients**, and then select **Mailboxes**.
3. Select the user, and then select **Edit**.
4. Select **Email Address**, and then select **Add**.
5. Under **Email Address**, select **SMTP**, and then enter the email address. Use the `<alias>@<domain>.mail.onmicrosoft.com` format for the email address.
6. Select **OK**, and then select **Save**.

### Method 3: Use Active Directory Service Interfaces Editor (ADSI Edit)

> [!WARNING]
> This procedure requires ADSI Edit. Using ADSI Edit incorrectly can cause serious problems that may require you to reinstall your operating system. Microsoft cannot guarantee that problems that result from the incorrect use of ADSI Edit can be resolved. Use ADSI Edit at your own risk.

1. Select **Start**, select **Run**, type *adsiedit.msc*, and then select **OK**.
2. Locate and right-click the user, and then select **Properties**.

    > [!NOTE]
    > To determine the container to which the user belongs, view the user properties in the Exchange Management Console.

3. Select the **Attribute Editor** tab, and then double-click **Target Address**.
4. Type the external Simple Mail Transfer Protocol (SMTP) address.
5. Select **OK**.

After the service routing domain is set up, confirm that the issue is resolved.

## More information

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).
