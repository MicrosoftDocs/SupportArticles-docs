---
title: Can't assign federated domain to user in Microsoft 365 Admin Center
description: Discusses a scenario in which you can't assign a federated domain to a user in the Microsoft 365 Admin Center in Office 365.
author: simonxjx
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
- MET150
audience: ITPro
ms.custom: CSSTroubleshoot
ms.prod: office 365
ms.topic: article
ms.author: v-six
appliesto:
- Office 365 Identity Management
---

# You can't assign a federated domain to a user in the Microsoft 365 Admin Center

[!INCLUDE [Branding name note](../../../includes/branding-name-note.md)]

## Problem 

You create a new user in the Microsoft 365 Admin Center in Office 365. However, when you try to assign a federated domain to the new user, the federated domain isn't listed in the user's list of domains. 

The following is an example scenario of what happens when you experience this issue: 
- In the Office 365 portal, single sign-on (SSO) and Active Directory synchronization are enabled.    
- When you view the properties of the domain on the domain properties page, the domain type is listed as **Federated** or **Single sign-on**. For example, adatum.com is the federated domain. 
- When you create a new user, you see that the default domain that's provided by Office 365 is listed as the first option in the drop-down box. For example, the default domain is contoso.onmicrosoft.com.    
- When you click the drop-down box to view the list of domains, the federated domain isn't listed. For example, adatum.com isn't listed. 

## Cause

This behavior is by design in Office 365. You can't create federated users through the portal. All federated users must be created on-premises and must be synced by using the Microsoft Azure Active Directory Sync Tool . 

## Solution 

To work around this behavior, create a matching user account in the on-premises Active Directory Domain Services (AD DS) environment, set up the user principal name (UPN) appropriately, and then sync the account and Azure Active Directory by using directory synchronization. To do this, follow these steps:

1. Obtain the primary SMTP address of the Office 365 user account. To do this, follow these steps:
   1. Sign in to the Office 365 portal ([https://portal.office.com](https://portal.office.com)) as a global admin.   
   2. Click **Admin**, and then click **Exchange** to open Exchange Admin Center.   
   3. Locate the user account, and then double-click it.   
   4. In the left navigation pane, click **Email Address**, and then note the primary SMTP address of the user account.   
2. Start Active Directory Users and Computers, and then create a user account in the on-premises domain that matches the Office 365 user account. For more information about how to do this, see [Create a User Account in Active Directory Users and Computers](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/dd894463(v=ws.10)).   
3. Make sure that the UPN of the user account is updated to the federated domain name. For more information about how to do this, see [Troubleshoot Active Directory user accounts that are piloted as Office 365 SSO-enabled user IDs](https://support.microsoft.com/help/2392130).    
4. Use Active Directory Service Interfaces (ADSI) Edit to edit the **proxyAddresses** attribute of the user object so that it matches the primary SMTP address that you noted in step 1D. To do this, follow these steps:

   > [!NOTE]
   > For more information about how to install ADSI Edit, see [Installing ADSI Edit](/previous-versions/windows/it-pro/windows-server-2003/cc773354(v=ws.10)#bkmk_installingadsiedit).

   1. Click **Start**, click **Run**, type **ADSIEdit.msc**, and then click **OK**.   
   2. Right-click **ADSI Edit**, select **Connect to**, and then click **OK** to load the domain partition.   
   3. In the navigation pane, locate the user object that you want to change, right-click it, and then click **Properties**.   
   4. In the **Attributes** list, click the **proxyAddresses** attribute, and then click **Edit**.   
   5. In the **Value to add** field, enter the appropriate SMTP address, and then click **Add**. 

      > [!NOTE]
      > The primary SMTP address value for the user object should be prepended by an uppercase "SMTP:" designator for the address value to be formatted correctly for the proxyAddressesattribute. For example, "SMTP:username@contoso.com" is an acceptable value, and "username@contoso.com" isn't an acceptable value.
   6. Click **OK** two times, and then exit ADSI Edit.

   For more information about how to use ADSI Edit to edit Active Directory attributes, go to the following Microsoft TechNet website:
  [Using ADSI Edit](/previous-versions/windows/it-pro/windows-server-2003/cc773354(v=ws.10)#bkmk_usingadsiedit) 
5. Force directory synchronization.

## More information

For more information, see 
[Troubleshoot user name issues that occur for federated users when they sign in to Office 365, Azure, or Intune](https://support.microsoft.com/help/2392130).  

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).