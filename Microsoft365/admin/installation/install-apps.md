---
title: Install Microsoft 365 apps
ms.author: luche
author: helenclu
manager: dcscontentpm
audience: Admin
ms.topic: troubleshooting
ms.custom: 
  - CSSTroubleshoot
ms.collection: 
  - M365-subscription-management
  - Adm_O365
search.appverid: 
  - BCS160
  - MET150
  - MOE150
ms.assetid: c4f63dc5-9944-40aa-9618-3b2007f17003
ROBOTS: NOINDEX
description: Learn how to install Microsoft 365 apps.
ms.date: 03/31/2022
---

# Install Microsoft 365 apps

Sometimes, things just aren't working. Here's some help for fixing administrative problems with Microsoft 365.
  
 **If you need immediate help, [contact support](/office365/admin/contact-support-for-business-products)** to help resolve your technical issues.
  
## Troubleshoot Office installation issues

Do you [need to install](https://support.office.com/article/4414eaaf-0478-48be-9c42-23adc4716658) Office apps for yourself, or are the Office apps not installing for you or your users? Get [help for your users](https://support.office.com/article/35ff2def-e0b2-4dac-9784-4cf212c1f6c2), or expand an option below to get help for admins.
  
### I'm an admin and don't have an option to install Office, Project, or Visio

When you first sign up for Microsoft 365 for business and you try to install Office (or Project or Visio if you've also signed up for a plan that includes those applications), you might see a message that says you can't install Office because you don't have a license. This could happen because of a delay between your initial sign in and Microsoft 365 for business setting up your environment. Try signing out of Microsoft 365 and then signing back in. 
  
It could also happen because you haven't assigned a license to yourself or your users. Do the following to check your licenses.
  
 **Check that you have a license**
  
1. If you're not already signed in, go to [https://admin.microsoft.com](https://admin.microsoft.com) and sign in with your work or school account.

    > [!NOTE]
    > If you're unable to sign in with your work or school account, you may be signing in to the wrong Microsoft 365 service, see [Where to sign in to Microsoft 365 for business](https://support.office.com/article/e9eb7d51-5430-4929-91ab-6157c5a050b4).
  
2. Select your account icon in the upper-right, and then choose **My account**.
  
3. In the left navigation, select **Subscriptions**.

   You'll see the services that you're licensed to use, such as the latest desktop version of Office, Project, Visio, SharePoint Online or OneDrive for Business, and Exchange Online. If you don't see **The latest desktop version of Office** in the list (or **Project** or **Visio** if you bought plans with those applications), see [Assign licenses to users in Microsoft 365 for business](/office365/admin/subscriptions-and-billing/assign-licenses-to-users).
    
Not all Microsoft 365 plans come with Office. If your organization has a plan that doesn't include the latest desktop version of Office, as the admin, you can [switch to a different Microsoft 365 plan or subscription](/office365/admin/subscriptions-and-billing/switch-to-a-different-plan). 
  
If you're not sure what plan you have, follow the steps in [What subscription do I have?](/office365/admin/admin-overview/what-subscription-do-i-have) For a comparison of plans, see the [small business plans comparison](https://products.office.com/business/compare-office-365-for-business-plans) or [enterprise plans comparison](https://products.office.com/en-us/business/compare-more-office-365-for-business-plans).
  
### I recently switched plans and now get messages I can't use Office

When you install Office it's automatically linked to your Microsoft 365 plan. This means if you recently switched plans you'll need to uninstall and then reinstall Office to associate it with your updated subscription. Use this easy fix tool and then follow the steps to reinstall Office.
  
1. Select this easy fix button to uninstall Office.<br/>[:::image type="icon" source="media/install-apps/download-button.png":::](https://aka.ms/diag_officeuninstall)

2. For the remaining steps showing how to save and use the easy fix, follow the steps for your browser:
    
    **Edge or Internet Explorer**
    
    1. At the bottom of the browser window, select **Open** to open the **O15CTRRemove.diagcab** file.

        :::image type="content" source="media/install-apps/open-easy-fix-tool.png" alt-text="Screenshot to open the O15CTRRemove easy fix tool.":::

        If the file doesn't open automatically, select **Save** \> **Open Folder**, and then double-click the file (it should start with "**O15CTRRemove**") to run the easy fix tool.
    
    2. The Uninstall Microsoft Office wizard launches. Select **Next** and follow the prompts. 
    
    3. When you see the **Uninstallation successful** screen, follow the prompt to restart your computer for the changes to take effect. Select **Next**.
    
    4. Restart your computer and then try installing Office again.
    
    **Chrome**
    
    1. In the lower-lower left corner select the **o15CTRRemove** file and from the drop-down list, choose **Show in folder**.

       :::image type="content" source="media/install-apps/show-in-folder.png" alt-text="Screenshot shows steps to select the Show in folder option.":::<br/>Double-click the download, **o15CTRRemove** to run the easy fix tool.
    
    2. The Uninstall Microsoft Office wizard launches. Select **Next** and follow the prompts. 
    
    3. When you see the **Uninstallation successful** screen, follow the prompt to restart your computer for the changes to take effect. Select **Next**.
    
    4. Restart your computer and then try installing Office again.
    
    **Firefox**
    
    1. Select **Save File**, and then **OK**.

        :::image type="content" source="media/install-apps/save-file-firefox.png" alt-text="Screenshot to save the O15CTRRemove.diagcab file in Firefox.":::  <br/>In the upper-right browser window, select **Show all downloads**. In the Library, select **Downloads** \> **O15CTRRemove.diagcab**, and then select the folder icon. Double-click the **O15CTRRemove.diagcab**.
    
    2. The Uninstall Microsoft Office wizard launches. Select **Next** and follow the prompts. 
    
    3. When you see the **Uninstallation successful** screen, follow the prompt to restart your computer for the changes to take effect. Select **Next**.
    
    4. Restart your computer and then try installing Office again.
    
 **Install Office**
  
To reinstall newer versions of Office, follow the steps in [Download and install or reinstall Office on your PC or Mac](https://support.office.com/article/4414eaaf-0478-48be-9c42-23adc4716658?wt.mc_id=SCL_DemsToken_262f265f-4c5e-4c46-852f-2a3890829d34).
  
To reinstall Office 2016 or Office 2013, see [Download and install or reinstall Office 2016 or Office 2013](https://support.office.com/article/download-and-install-or-reinstall-office-2016-or-office-2013-7c695b06-6d1a-4917-809c-98ce43f86479).
  
### I have a different problem

For a detailed troubleshooting instructions, and to help your users troubleshoot potential issues, see [Troubleshoot Office installation issues in Microsoft 365 for business](https://support.office.com/article/fbbf663b-1e76-46d2-a417-0aa78ed2fb9a).

> [!NOTE]
> If you're using Microsoft 365 operated by 21Vianet in China, please [contact the 21Vianet support team](/office365/admin/contact-support-for-business-products).
