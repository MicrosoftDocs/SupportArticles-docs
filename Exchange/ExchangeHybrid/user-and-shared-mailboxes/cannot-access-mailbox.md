---
title: Users in a hybrid deployment can't access a shared mailbox in Exchange Online
description: Describes an issue in which users in an Exchange hybrid deployment are unable to access, view free/busy information, or send mail to a shared mailbox that was created in Exchange Online.
author: simonxjx
audience: ITPro
ms.prod: exchange-server-it-pro
ms.topic: troubleshooting
ms.author: v-six
ms.custom: 
- Exchange Hybrid
- CSSTroubleshoot
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
- MET150
appliesto:
- Exchange Online
- Exchange Server 2016 Enterprise Edition
- Exchange Server 2016 Standard Edition
- Exchange Server 2013 Enterprise
- Exchange Server 2013 Standard Edition
- Exchange Server 2010 Enterprise
- Exchange Server 2010 Standard
---
# Users in a hybrid deployment can't access a shared mailbox that was created in Exchange Online

> [!NOTE]
> The Hybrid Configuration wizard that's included in the Exchange Management Console in Microsoft Exchange Server 2010 is no longer supported. Therefore, you should no longer use the old Hybrid Configuration wizard. Instead, use the Office 365 Hybrid Configuration wizard. For more information, see [Office 365 Hybrid Configuration wizard for Exchange 2010](https://blogs.technet.com/b/exchange/archive/2016/02/17/office-365-hybrid-configuration-wizard-for-exchange-2010.aspx).

## Problem

Consider the following scenario:

- You have a hybrid deployment of on-premises Microsoft Exchange Server and Microsoft Exchange Online in Office 365.
- You create a shared mailbox directly in Exchange Online.
- You assign Full Access permissions to one or more users.

In this scenario, you experience one or more of the following issues:

- Users can't open the shared mailbox in Outlook.
- Users can't view free/busy information for the shared mailbox.
- Users can't send mail to the shared mailbox.
  
## Cause

These issues can occur if the shared mailbox is created by using the Exchange Online management tools. In this situation, the on-premises Exchange environment has no object to reference for the shared mailbox. Therefore, all queries for that SMTP address fail.

## Solution

Create a remote mailbox in the on-premises environment, and then move the mailbox to Exchange Online. To do this, follow these steps.

> [!NOTE]
> For on-premises environments that use Exchange Server 2013 (cumulative update 21 or later versions) or Exchange Server 2016 (cumulative update 10 or later versions), you can skip the following steps and follow the steps under the [Alternative method](#alternative-method) section instead.

1. Convert the shared mailbox to a regular mailbox by using the Exchange admin center in Exchange Online. To do this, follow these steps:  
   1. Open the Exchange admin center in Exchange Online.
   2. Click **recipients**, and then click **shared**.
   3. Select the shared mailbox, and then click **Convert**.
   4. On the Warning page, select **Yes** to convert the shared mailbox.

2. Create an on-premises object for the cloud mailbox by using the `New-RemoteMailbox` cmdlet in the Exchange Management Shell.

    > [!NOTE]
    > This object must have the same name, alias, and user principal name (UPN) as the cloud mailbox.

    For more information, see [New-RemoteMailbox](/powershell/module/exchange/new-remotemailbox).
3. Set the ExchangeGuid property on the new on-premises object that you created in step 2 to match the cloud mailbox. To do this, follow these steps:  
   1. Connect to Exchange Online by using a remote session of Windows PowerShell.

      For more information about how to do this, see [Connect to Exchange Online PowerShell](/powershell/exchange/connect-to-exchange-online-powershell).
   2. Use the `Get-Mailbox` cmdlet to retrieve the value of the `ExchangeGuid` property of the cloud mailbox. For example, run the following command:

        ```powershell
        Get-Mailbox <MailboxName> | FL ExchangeGuid  
        ```

      For more information, see [Get-Mailbox](/powershell/module/exchange/get-mailbox).
   3. Open the Exchange Management Shell on the on-premises Exchange server.
   4. Use the `Set-RemoteMailbox` cmdlet to set the value of the `ExchangeGuid` property on the on-premises object to the value that you retrieved in step 3b. For example, run the following command:

        ```powershell
        Set-RemoteMailbox <MailboxName> -ExchangeGuid <GUID>
        ```

      For more information, see [Set-RemoteMailbox](/powershell/module/exchange/set-remotemailbox).

4. Wait for directory synchronization to occur. Or, force directory synchronization.

    For more information, see [Synchronize your directories](/azure/active-directory/hybrid/whatis-hybrid-identity).
5. Make sure that the Office 365 user object is displayed as **Synced with Active Directory**.
6. Move the mailbox from Exchange Online to the on-premises environment.

    For more information, see [Move mailboxes between on-premises and Exchange Online organizations in hybrid deployments](/exchange/hybrid-deployment/move-mailboxes).
7. Convert the mailbox to a shared mailbox by using the `Set-Mailbox` cmdlet in the Exchange Management Shell. For example, run the following command:

    ```powershell
    Set-Mailbox <MailboxName> -Type Shared
    ```

    For more information, see [Set-Mailbox](/powershell/module/exchange/set-mailbox).
8. Move the mailbox from the on-premises environment to Exchange Online.

    For more information, see [Move mailboxes between on-premises and Exchange Online organizations in hybrid deployments](/exchange/hybrid-deployment/move-mailboxes).
  
### Alternative method

For on-premises environments that use Exchange Server 2013 (cumulative update 21 or later versions) or Exchange Server 2016 (cumulative update 10 or later versions):

Create an on-premises object for the cloud mailbox by using the `New-RemoteMailbox` cmdlet in the Exchange Management Shell.

> [!NOTE]
> This object must have the same name, alias, and user principal name (UPN) as the cloud mailbox. For more information, see [New-RemoteMailbox](/powershell/module/exchange/new-remotemailbox).

For example, run the following command:  

```powershell
New-Remotemailbox -Name "Shared mailbox" -Alias sharedmailbox -UserPrincipleName sharedmailbox@contoso.com -Remoteroutingaddress sharedmailbox@contoso.mail.onmicrosoft.com -Shared
```

## More information

For more information about remote shared mailboxes, see [Cmdlets to create or modify a remote shared mailbox in an on-premises Exchange environment](https://support.microsoft.com/help/4133605/).  

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/) or the [Exchange TechNet Forums](/answers/topics/office-exchange-server-itpro.html).
