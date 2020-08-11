---
title: A SharePoint Skill search isn't supported in Skype for Business Online
description: Describes the problem that you can't use a SharePoint Skill search with Skype for Business Online because the Skill search is unsupported. A workaround is provided.
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

# A Microsoft SharePoint Skill search isn't supported in Skype for Business Online

## Problem

When you search for a contact by using Skype for Business Online (formerly Lync Online), and the search fails, Skype for Business Online displays a link that suggests that you can use the Microsoft SharePoint Skill search. However, when you try to use a SharePoint Skill search, the search fails, and you receive an error message.

## Solution

Important This section, method, or task contains steps that tell you how to modify the registry. However, serious problems might occur if you modify the registry incorrectly. Therefore, make sure that you follow these steps carefully. For added protection, back up the registry before you modify it. Then, you can restore the registry if a problem occurs. For more information about how to back up and restore the registry, click the following article number to view the article in the Microsoft Knowledge Base: 

[322756 ](https://support.microsoft.com/help/322756) How to back up and restore the registry in Windows

If your computer previously logged on to an on-premises Office Communications Server (OCS) or Lync Server, and then the same computer logs on to Skype for Business Online, you must delete the policies that were previously pushed by the administrator. To do this, follow these steps:

1. Click **Start**, type regedit, and then from the search results, click **Regedit.exe**.   
2. In Registry Editor, you must delete the SPSearchInternalURL value from the following registry subkeys:
      - **HKEY_CURRENT_USER\Software\Policies\Microsoft\Communicator**   
      - **HKEY_LOCAL_MACHINE\Software\Policies\Microsoft\Communicator**   

## More Information

This issue occurs because a SharePoint Skill search isn't supported when you use Skype for Business Online.

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).