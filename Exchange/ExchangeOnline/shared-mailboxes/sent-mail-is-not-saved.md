---
title: Messages sent from a shared mailbox aren't saved to the Sent Items folder
description: Describes an issue in Office 365 in which email messages that you send on behalf of another user from a shared mailbox in Outlook aren't saved to the Sent Items folder of the shared mailbox. Provides a resolution.
author: simonxjx
audience: ITPro
ms.service: exchange-online
ms.topic: article
ms.author: v-six
manager: dcscontentpm
localization_priority: Normal
ms.custom: CSSTroubleshoot
search.appverid: 
- MET150
appliesto:
- Exchange Online
---

# Messages sent from a shared mailbox aren't saved to the Sent Items folder of the shared mailbox in Outlook

## Problem 

Assume that you're using Microsoft Outlook 2010 or a later version, and you've been delegated permission to send email messages as another user or on behalf of another user from a shared mailbox. However, when you send a message as another user or on behalf of the user, the sent message isn't saved to the Sent Items folder of the shared mailbox. Instead, it's saved to the Sent Items folder of your mailbox.

## Cause 

In Office 365, shared mailboxes don't require a license and can't be added to Outlook as an independent mailbox. You can't sign in to a shared mailbox. Instead, you sign in to your own mailbox, and then you open the shared mailbox. When you send or reply to a new message from the shared mailbox, Outlook automatically sends or replies from the sender's account. Therefore, messages are stored in the Sent Items folder of the sender's mailbox.

## Solution 

> [!IMPORTANT]
> Follow the steps in this section carefully. Serious problems might occur if you modify the registry incorrectly. Before you modify it, [back up the registry for restoration ](https://support.microsoft.com/help/322756) in case problems occur.

To work around this issue, use one of the following methods. 

### Method 1: Set the DelegateSentItemsStyle registry value on the Outlook client
 
> [!NOTE]
> Outlook must be configured to run in cached mode for this option to work correctly. For more information, see the following Microsoft Knowledge Base article:

[2703723](https://support.microsoft.com/help/2703723) Email remains in the Outbox when you use the DelegateSentItemsStyle registry value 
 
If you're running Outlook 2010, install the Outlook 2010 hotfix package that's dated December 14, 2010. Then, follow these steps. 

For more information about this hotfix package, see the following Microsoft Knowledge Base article:

[2459115](https://support.microsoft.com/help/2459115) Description of the Outlook 2010 hotfix package (outlook-x-none.msp): December 14, 2010 
 
> [!NOTE]
> If you're running Outlook 2013 or a later version, you don't have to install any hotfix.

1. Click **Start**, click **Run**, type regedit, and then click **OK**.    
2. Locate and then click the following registry subkey:

    **HKEY_CURRENT_USER\Software\Microsoft\Office\x.0\Outlook\Preferences** 

    > [!NOTE]
    > The **x.0** placeholder represents your version of Office (16.0 = Office 2016, 15.0 = Office 2013, 14.0 = Office 2010).    
3. On the **Edit** menu, point to **New**, and then click **DWORD Value**.    
4. Type DelegateSentItemsStyle, and then press Enter.    
5. Right-click **DelegateSentItemsStyle**, and then click **Modify**.    
6. In the **Value data** box, type 1, and then click **OK**.    
7. Exit Registry Editor.    
 
### Method 2: Configure the mailbox to save a copy of the message to the Sent Items folder of the shared mailbox in Exchange Online or in on-premises Exchange Server

#### Exchange Online in Office 365 or Exchange Server 2013 Cumulative Update 9 or later update
 
Cumulative Update 9 for Exchange Server 2013 introduced a new feature that lets administrators configure the Sent Items folder to which a message is copied. For more information, see [Exchange Blog - Want more control over Sent Items when using shared mailboxes?](https://blogs.technet.com/b/exchange/archive/2015/03/03/want-more-control-over-sent-items-when-using-shared-mailboxes.aspx)

#### Exchange Server 2010 Service Pack 2 Update Rollup 4 or later update
 
Update Rollup 4 for Exchange Server 2010 Service Pack 2 introduced a new Exchange PowerShell cmdlet to configure the Sent Items folder to which a message is copied. Because this new feature is handled by the server that's running Exchange Server, Outlook can be configured in online mode or cached Exchange mode. However, this feature works only if the Outlook DelegateSentItemsStyleregistry value is disabled.

For more information about the Set-MailboxSentItemsConfiguration cmdlet, see the following Microsoft Knowledge Base article:

[2632409](https://support.microsoft.com/help/2632409) Messages sent by using the "Send As" and "Send on behalf" permissions are only copied to the Sent Items folder of the sender in an Exchange Server 2010 environment  

> [!NOTE]
> The **MessageCopyForSentAsEnabled** and **MessageCopyForSendOnBehalfEnabled** settings are not supported if the user mailbox and shared mailbox are located in different environments (cloud and on-premises). The settings are supported only if both mailboxes are in the same environment (cloud or on-premises).

## More information

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/) or the [Exchange TechNet forums](https://social.technet.microsoft.com/forums/exchange/home?category=exchange2010%2cexchangeserver).