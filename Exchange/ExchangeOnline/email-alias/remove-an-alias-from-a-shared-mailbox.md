---
title: Troubleshoot Remove an alias from a shared mailbox
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: Admin
ms.topic: troubleshooting
ms.custom: 
  - Exchange Online
  - CSSTroubleshoot
f1_keywords: 
  - 'O365P_AdminSharedMbx_TSAlias'
  - 'O365M_AdminSharedMbx_TSAlias'
  - 'O365E_AdminSharedMbx_TSAlias'
  - 'AdminSharedMbx_TSAlias'
localization_priority: None
ms.collection: 
  - M365-subscription-management
  - Adm_O365
search.appverid: 
  - BCS160
  - MET150
  - MOE150
ms.assetid: ea585b86-76aa-4cf4-912e-f8271677d1d5
description: Learn how to remove an email address from a shared mailbox in the admin center so that you can reuse it.
ms.date: 01/24/2024
ms.reviewer: v-six
---
# Troubleshoot: Remove an alias from a shared mailbox

Did you get this error when you were creating a new user? "This email address is already being used as an alias for the shared mailbox \<mailbox name>." This article will show you how to remove the email address from the shared mailbox so you can re-use it.
  
> [!TIP]
> Email addresses are how the internet knows where to send your email and all email addresses must be unique - across the entire internet no two email addresses can be the same.
  
## Remove the email alias from the shared mailbox

Before you begin, make sure you've noted which shared mailbox you need to remove the email address from.
  
1. From the [admin center](https://go.microsoft.com/fwlink/p/?linkid=2024339), you can find the shared mailbox a couple of different ways:

   - From the admin center **Home** page, type the name of the shared mailbox into the **search** field, and then select it from the list. It will open the shared mailbox's details card.

   - Go to **Groups** > [Shared mailboxes](https://go.microsoft.com/fwlink/p/?linkid=2066847), and then select the shared mailbox from the list.

2. In the **Name**, **Email**, and **Email aliases** section, select **Edit**.

3. In the **Email aliases** section, remove the email address by selecting the remove (wastebin) icon, and then **Save**.

    > [!NOTE]
    > You can't remove the primary email address. If you need to remove the primary email address, add a second email address for this shared mailbox and select **Set as primary**. Then you can remove the email alias.
  
## Did this solve your problem?

Let us know if this did or didn't solve your problem by giving feedback at the bottom of this page: **Was this information helpful?**
