---
title: Unable to access shared mailboxes through POP/IMAP
description: Fixes a problem in which users can't access shared mailboxes through POP/IMAP when they use an account that isn't mail-enabled but has permissions to the shared mailboxes.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Clients and Mobile\Need help with IMAP, POP Clients
  - Exchange Server
  - CI 113906
  - CSSTroubleshoot
ms.reviewer: cmcgurk
appliesto: 
  - Exchange Server 2010 Service Pack 3
  - Exchange Server 2013
  - Exchange Server 2013 Service Pack 1
  - Exchange Server 2016
  - Exchange Server 2019
search.appverid: MET150
ms.date: 01/24/2024
---

# "NoPrimarySmtpAddress" error when accessing shared mailboxes through POP/IMAP in Exchange Server

## Symptoms

Consider the following scenario:

- You're running Microsoft Exchange Server 2019, Exchange Server 2016, or Exchange Server 2013.
- Exchange Server is configured for POP/IMAP access.
- Shared mailboxes in the Exchange environment are configured to enable POP/IMAP access.
- A service account that isn't mail-enabled is granted permissions to the shared mailboxes.

In this scenario, users can't access the shared mailboxes through POP/IMAP by using the service account. Additionally, you see an error message in the POP/IMAP protocol logs that resembles the following:

**"R=""? NO LOGIN failed:"";Msg=NoPrimarySmtpAddress"**

When this problem occurs, the service account can still access the shared mailboxes through Microsoft Outlook, Outlook Web App, Exchange Web Services, or Exchange ActiveSync.

## Cause

This problem occurs because the POP/IMAP authentication process expects authenticated users to have a primary SMTP address defined.

## Resolution

To fix this problem, use either of the following methods (but only one).

### Method 1:  Create a mailbox for the service account

Use the Exchange Admin Center or Exchange Management Shell to create a mailbox for the service account. For more information about how to create a mailbox for an existing user, see [Create user mailboxes in Exchange Server](/Exchange/recipients/create-user-mailboxes).

### Method 2:  Add a primary SMTP address to the proxyAddresses attribute

Add a primary SMTP address to the proxyAddresses attribute for the service account by using Active Directory Users and Computers. To do this, follow these steps:

1. Open Active Directory Users and Computers.
2. Select **View** > **Advanced Features**.
3. Find the user object for the service account.
4. Right-click the object, and then select **Properties**.
5. Select the **Attribute Editor** tab.
6. Find the **userPrincipalName** attribute and note the attribute value (for example, serviceaccount01@contoso.com).
7. Find the **proxyAddresses** attribute, and then select **Edit**.
8. In the **Value to add** text box, add the following text to set a primary SMTP address, and then select the **Add** button:

   **SMTP:serviceaccount01\@contoso.com**

9. Select **OK** two times, and then close Active Directory Users and Computers.

After you make this change, ask users to access the shared mailboxes again through POP/IMAP.
