---
title: Your subscription has expired for Skype for Business Online
description: Describes a subscription expiration issue in Skype for Business Online. Explains how to renew your subscription either by adding the computer to an active account or by entering your product key.
author: simonxjx
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
- MET150
audience: ITPro
ms.service: skype-for-business-online
ms.topic: article
ms.author: v-six
ms.custom: CSSTroubleshoot
appliesto:
- Skype for Business Online
---

# "Your subscription has expired" error for Skype for Business Online users in Office 365 Business

## Problem 

When you use Skype for Business Online (formerly Lync Online), you receive the following error message:

**Your subscription has expired.**

![Screen shot of the Your subscription has expired message](./media/your-subscription-has-expired/expired-message.png)

## Solution 

To resolve this issue, take one of the following actions: 
 
- If you have an Office 365 Business Premium or Office 365 subscription and haven't renewed into one of the new Office 365 Business offerings, do one of the following:  
   - Administrators can renew current licenses through September 30, 2015, or they can renew by using one of the new Business offerings starting October 1, 2014.    
   - After the licenses are renewed, users must reactivate Office and install Lync Basic 2013.

     > [!NOTE]
     > Renewing and purchasing new subscriptions must be done by an Office 365 administrator.    
     
- If you already renewed into one of the new Office 365 Business offerings, you must do the following within 30 days of renewing the subscription:   
   - Reactivate Office    
   - Install Lync Basic 2013    

### Reactivate Office and install Lync Basic 2013

1. To reactivate Office, click **Sign In** in the **Your subscription has expired** dialog box. In the **Activate Office** dialog box, enter your Office 365 email address, as shown in the following screen shot:
 
    ![Screen shot of the Activate Office dialog](./media/your-subscription-has-expired/active-office.png)    
2. After you enter your email address and password, select a product from the list:

    ![Screen shot of the Choose a Product dialog](./media/your-subscription-has-expired/choose-product.png)    
3. When you try to run Lync 2013, you receive the following message:  

    **The products we found in your account can't be used to activate Lync.**
 
    ![Screen shot of the Products we found in your account can't be used to activate Lync message](./media/your-subscription-has-expired/activate-lync-message.png)

    Click **Help** to be directed to the Office 365 Downloads page, where you can then install Lync Basic 2013.    
  
## More information

This issue occurs for Skype for Business Online users when the following conditions are true: 
 
- You're running the version of Lync 2013 that's included with Microsoft 365 Apps for enterprise, and you have a current Office 365 Business Premium or Office 365 subscription.    
- You either haven't renewed into one of the new Office 365 offerings (for example, Office 365 Business Essentials, Office 365 Business, or Office 365 Business Premium) or you haven't installed Lync Basic 2013 after you renewed your subscription.    
 
Lync 2013 will go into reduced functionality mode after 30 days if one of the conditions is true: 
 
- Customers have renewed their subscription by using one of the new offerings, but they didn't reactivate Office by using the new subscription and installing Lync Basic 2013.    
- Customers didn't renew their subscriptions with the new Office 365 Business offerings before October 1, 2015.    
 
Users who have a hybrid deployment with Lync Server 2013 may want to use their volume license product keys instead of their Office 365 subscription. In that case, users should click **Enter Key** when they receive the "Your subscription is expired" message and then enter the volume license key that's provided by their administrator.  

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).