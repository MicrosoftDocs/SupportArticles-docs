---
title: Changed Active Directory object information is not updated in the address book in Office 365 dedicated/ITAR
description: Describes a problem in which information in Active Directory is not updated to match the information in the address book in Office 365 dedicated/ITAR. A resolution is provided.
author: MaryQiu1987
ms.author: v-maqiu
manager: dcscontentpm
audience: ITPro 
ms.topic: article 
ms.prod: office 365
ms.custom: CSSTroubleshoot
localization_priority: Normal
ms.reviewer: kellybos
search.appverid: 
- MET150
appliesto:
- Microsoft Business Productivity Online Dedicated
- Microsoft Exchange Online Dedicated
---

# Changed Active Directory object information is not updated in the address book in Office 365 dedicated/ITAR

[!INCLUDE [Branding name note](../../../includes/branding-name-note.md)]

##  Symptoms

When you change or update Active Directory object information, you notice that the information is not updated in the address book in Microsoft Office 365 dedicated/ITAR.

##  Cause

This issue typically occurs when one or more of the following conditions are true:

1. The object isn't provisioned or updated in the managed Active Directory site by the Microsoft Online Services Identity and Provisioning Service (MMSSPP).    
2. The Offline Address Book (OAB) isn't up to date. Therefore, the Microsoft Outlook client doesn't have the most recent version when they use Outlook in Cached mode.   


##  Resolution

To resolve this issue, look for the new object or updated information from Microsoft Office Outlook Web App (Outlook Web App) or Microsoft Outlook in online mode. Both Outlook Web App and Outlook in online mode reference the information directly from the managed Active Directory site. This helps determine the appropriate next action.

If the object or updated information isn't found in Outlook Web App, refer to the following Microsoft Knowledge Base article to troubleshoot MMSSPP provisioning issues: 

[2615447](https://support.microsoft.com/help/2615447) MMSSPP does not synchronize Exchange mailbox and mail-enabled objects to the dedicated managed Office 365 environment

If the object or updated information is displayed correctly in Outlook Web App but cannot be found when you use Outlook in cached mode, you must identify the number of users who are affected. If the issue is limited to a small group of users, follow these steps to troubleshoot the client:

1. Check Outlook to determine whether a new OAB is needed. To do this, follow these steps:
   1. On the **Tools** menu, point to **Send/Receive**, and then click **Download Address Book**.    
   2. Under **information to download**, click **Full Details**.   

2. Force the Outlook client to download a full OAB. To do this follow these steps:
   1. Exit Outlook, Microsoft Lync, and any other applications that may have a connection to Outlook.   
   2. Open Windows Explorer.   
   3. Change the option to show hidden items.   
   4. Locate C:\Users\\\<user alias>\AppData\Local\Microsoft\Outlook\Offline Address Books. (AppData is a hidden folder.)   
   5. Delete the contents of the Offline Address Books folder.   
   6. Restart Outlook.    

    **Note** This step should only be used for troubleshooting to determine whether there's a potential issue in the Outlook client.   

If the issue affects all users, determine whether enough time has passed for the OAB to be updated.

Exchange servers in Office 365 dedicated/ITAR environments are set up to generate an OAB differential file every eight hours. These files together with a much larger full OAB file are distributed to Client Access Servers (CAS) across the customer environment. An Outlook client in cached mode will check for a new differential OAB file every 24 hours. If the differential file is half the size of the full OAB file or larger, the client will download the full OAB file.

For a change that's made in the Active Directory site to reach the client computer, the following events must occur:

- Changes in the customer Active Directory site are replicated to an MMSSPP preferred domain controller.    
- Enough time has passed for the change to be successfully synchronized to the managed Active Directory site by the MMSSPP sync process. This usually takes 30 to 60 minutes.   
- Enough time has passed for the change to reach the OAB generating server and to be included in a new differential file. This usually takes 8 hours.   
-  Enough time has passed for the Outlook client to check for a differential or full OAB download. This usually takes 24 hours.   