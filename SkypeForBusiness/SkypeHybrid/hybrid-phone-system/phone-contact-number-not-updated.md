---
title: Telephone contact number isn't updated for users who migrate to Online
description: Describes an issue in which the telephone contact number isn't updated for users who migrate from Skype for Business to Skype for Business Online for PSTN calling. Provides a solution.
author: simonxjx
manager: dcscontentpm
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - CSSTroubleshoot
ms.author: v-six
appliesto: 
  - Skype for Business Online
ms.date: 03/31/2022
---

# The telephone contact number isn't updated for users who migrate to Skype for Business Online

## Problem 

In Skype for Business Online, you experience one of the following issues:

- Users who are enabled for public switched telephone network (PSTN) calling in Microsoft 365 and who migrate from Skype for Business to Skype for Business Online have an incorrect telephone number displayed on their contact card.     
- Skype for Business users who migrate to the cloud don't have their newly assigned telephone number displayed on their contact card.   
- Users can't manage the telephone number that's displayed in the Microsoft 365 contact card for users who are homed in Microsoft 365.   


## Solution 

To fix this issue, take one of the following actions, depending on your situation: 
 
- If a directory synchronization tool such as Azure Active Directory (Azure AD) Sync or Directory Sync (Microsoft Azure Active Directory Sync Tool) is being used to synchronize users from on-premises to Microsoft 365, the administrator should follow these steps:  
   1. On the **General** tab of the user in **Active Directory Users and Computers** in the on-premises Active Directory schema, edit the **Telephone Number** property so that it reflects the number that you want displayed in the user's contact card.    
   2. Perform a directory synchronization by using Azure AD Sync or Microsoft Azure Active Directory Sync Tool.    
     
- Users who aren't synchronized from an on-premises Active Directory schema can have a Microsoft 365 administrator update their **Office phone** property in the Microsoft 365 admin center. Administrators should follow these steps. (For more information, see [Edit or change users in Microsoft 365](https://support.office.com/article/edit-or-change-users-in-office-365-42bb3f17-8f9d-4182-b434-5f1c8024e614).)  
   1. Sign in to Microsoft 365 by using your work or school account. For more information, go to the following Microsoft website: [Where to sign in to Microsoft 365](https://support.office.com/article/sign-in-to-office-365-e9eb7d51-5430-4929-91ab-6157c5a050b4)     
   2. Go to the Microsoft 365 admin center. For more information, go to the following Microsoft website: [About the Microsoft 365 admin center](https://support.office.com/article/office-365-admin-center-58537702-d421-4d02-8141-e128e3703547)     
   3. Go to **Dashboard Users**.    
   4. On the **Active users** page, click the user whose information you want to edit, and then click **Edit**.    
   5. Click **Additional Details**.    
   6. In the **Office phone** field, enter the new telephone number.    
     
- End users can edit their own telephone numbers in Skype for Business. To this, they should follow these steps:  
   1. Click **Tools**, click **Options**, and then click **Phones**.    
   2. Update the **Work Phone** to the new telephone number, and then make sure that **Include in my contact card** displays the new telephone number to your contacts. For more information, go to the following Microsoft website: [Set Phones options](https://support.office.com/article/set-phones-options-20e03cc1-c023-4e5d-bafd-064ddb59ed5e)     
     
## More information

The contact card uses the **telephone number** schema attribute to populate the telephone number in a user's contact card. After the user is moved to Microsoft 365, is enabled for **Cloud PBX** and **Domestic/International Calling**, and then assigned a telephone number, the number must be edited in the on-premises active directory or added to the user properties in the Microsoft 365 admin center.

For more information, go to the following Microsoft websites: 
 
- [Active Directory Users and Computers](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/cc754217(v=ws.11)?f=255&mspperror=-2147217396)
- [Deploy Microsoft 365 Directory Synchronization (Microsoft Azure Active Directory Sync Tool) in Microsoft Azure](/microsoft-365/enterprise/deploy-microsoft-365-directory-synchronization-dirsync-in-microsoft-azure)    
- [Deploy Azure Active Directory Sync tool with Microsoft 365](/previous-versions//dn509521(v=technet.10))    
- [Use the contact card](https://support.office.com/article/use-the-contact-card-aee867d7-fb39-4101-a386-e93008c8c6a1)    
  
Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).
