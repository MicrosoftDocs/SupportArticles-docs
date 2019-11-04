---
title: Contacts appear to be offline or aren't searchable
description: Describes how to troubleshoot instant messaging and presence issues in Skype for Business Online.
author: simonxjx
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
- MET150
audience: ITPro
ms.service: skype-for-business-online
ms.topic: article
ms.author: v-six
ms.reviewer: dahans
ms.custom: CSSTroubleshoot
appliesto:
- Skype for Business Online
---

# Contacts in Skype for Business Online appear to be offline or aren't searchable

## Introduction

This article describes how to troubleshoot the following Skype for Business Online (formerly Lync Online) issues: 

- Contacts seem to be offline in Skype for Business, or they have a status of "presence unknown."   
- You can't search the address book in Skype for Business.   
- Skype for Business Online contacts are lost or missing, or the contacts list isn't updated.   

## Procedure

### Scenario 1: Contacts seem to be offline in Skype for Business

Contacts appear to be offline for several reasons. Verify the following conditions before you do additional troubleshooting:

- The contact seems to be offline and hasn't been blocked by the user in the user's Contacts list. To do this, follow these steps:
  1. In the main Skype for Business window, click **Relationships**.   
  2. Expand the **Blocked Contacts** group, and then verify that the offline contact isn't blocked.

   > [!NOTE]
   > If a contact blocks you, that contact is displayed as offline in your contacts list.   
- The contact is assigned a Skype for Business Online license.   
- If the contact is a member of another Skype for Business organization or an external Skype contact, verify the following:
  - External connectivity is enabled in the Skype for Business Online Admin center.   
  - In the Skype for Business Online Admin center, the contact's domain is an allowed domain and the domain isn't explicitly blocked.

    > [!NOTE]
    > After you add a new Skype or Skype for Business contact from another organization, if the contact ignores the request to add you to their contacts list, that contact will be displayed as offline in your contacts list.   
  - For additional help with external contacts, see the following Microsoft websites:
    - [2392146 ](https://support.microsoft.com/help/2392146) Skype for Business Online users can't communicate with external contacts      

### Scenario 2: You can't search the global address list by using Microsoft Skype for Business

When you try to search the address book, you receive one of the following error messages: 

- Cannot synchronize with the corporate address book. This may be because the proxy server setting in your web browser does not allow access to the address book. If the problem persists, contact your system administrator.   
- The address book is preparing to synchronize. Search results might not be current.   

In Skype for Business Online, address book and GAL lookups are performed through web requests only. The Skype for Business client doesn't download and save a local copy of the address book. This reduces the load on the servers, and it provides the most up-to-date information possible when you run a contact search.

Verify that connectivity to the Address Book web service is available. To do this, follow these steps:

1. In the notification area on the right side of the taskbar, locate the Skype for Business icon, hold down the Ctrl key, right-click the Skype for Business icon, and then click **Configuration Information**.   
2. Copy the ABS External Server URL.   
3. Start Internet Explorer, and then paste the URL into the address bar.   
4. The message that you receive from Internet Explorer indicates whether the URL can be accessed from the computer. If you can't access the URL, this indicates there's something blocking communication to or from the URL, such as a firewall or proxy:
   - If the URL can be accessed, you’ll see one of these error messages (even though a page isn't displayed):

     - 401 Unauthorized: Access Denied   
     - Internet Explorer cannot display the webpage.   

   - If the URL is inaccessible, you'll see one of these error messages:
     - The webpage cannot be found.
     - 404 Not Found       
5. Verify that the Exchange Autodiscover service is set up correctly. To do this, see Method 2 in the "Solution" section in the following Microsoft Knowledge Base article:  

    [2404385 ](https://support.microsoft.com/help/2404385) Outlook can't set up a new profile by using Exchange Autodiscover for an Exchange Online mailbox in Office 365

### Scenario 3:Skype for Business Online contacts are lost or missing, or the contacts list isn't updated

In rare cases, the contacts list may be corrupted because of an invalid character in an "out of office" message or because of a lingering deprovisioned contact. To resolve this problem, force a contacts list update to make sure that your information is synchronized. To this, follow these steps: 

1. Locate the following folder:
   -  For Skype for Business 2016
      - Windows 7, Windows 8, and Windows 10: 

        %localappdata%\Microsoft\Office\16.0\Lync\sip_\<sign-in name>      
   - For Skype for Business 2015 (Lync 2013) 
     - Windows 7, Windows 8, and Windows 10: 

        %localappdata%\Microsoft\Office\15.0\Lync\sip_\<sign-in name>      
   
2. Delete the following files:
     - Galcontacts.db   
      - galcontacts.db.idx   
      - CoreContact.cache   
      - ABS_\<sign-in name>.cache   
      - Mfugroup.cache   
      - PersonalLISDB.cache   
      - PresencePhoto.cache   
3. Restart Skype for Business, and then wait for 30 minutes for resynchronization to finish.   

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).
