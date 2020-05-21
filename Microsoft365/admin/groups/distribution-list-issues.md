---
title: Distribution group issues
ms.author: kwekua
author: kwekua
manager: dcscontentpm
audience: Admin
ms.topic: troubleshooting
ms.service: o365-administration
localization_priority: Normal
ms.collection: Adm_O365
ms.custom: CSSTroubleshoot
search.appverid:
- BCS160
- MET150
- MOE150
ms.assetid: 79e180b1-6290-48ff-8003-fb3e6a3f70af
description: "Learn how to solve distribution group issues in Office 365 like emails not being delivered to the group, or external members not getting emails."
---

# Distribution group issues

[!INCLUDE [Branding name note](../../../includes/branding-name-note.md)]

This topic discusses how to solve distribution group (also known as distribution list) issues that you may run into when using Office 365.

> [!NOTE]
> To find and edit existing groups, go to **Groups** \> **Groups** in the left pane, select the group you want to review or edit, and then select **Manage**.
  
## Emails not being delivered to distribution group

There could be a couple of issues here:
  
- It usually takes about 60 minutes for distribution groups to be fully created and ready for management. Make sure you've waited the appropriate amount of time and try sending the email again.
    
- Sometimes, people create an Office 365 Group instead of a distribution group. Check out your distribution group in the admin center and make sure you created a distribution group.
    
## External members not getting emails sent to distribution group

There could be a couple of issues here:
  
- Make sure you've allowed people outside your organization to send emails to the distribution group. The two toggles at the bottom of the **Edit details** pane should be set to **On**.
    
    ![Allow external members to send to a group](./media/distribution-list-issues/edit-distribution-group.png) 
 
- External members don't receive email messages that are sent to a group they're a member of, and the senders don't receive non-delivery message about the email. Read [External members don't receive email...](https://go.microsoft.com/fwlink/?LinkID=855988) for steps on how to fix this issue. 
    
## I'm an admin and I can't edit a distribution group in the admin center

Make sure you have an Office 365 license. You need an Office 365 for business license before you can edit distribution groups in the admin center. Read [Assign licenses to users in Office 365 for business](https://docs.microsoft.com/office365/admin/subscriptions-and-billing/assign-licenses-to-users) for the steps. 
    

