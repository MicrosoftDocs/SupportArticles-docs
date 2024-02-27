---
title: Use Outlook policy to control credential prompt for an Exchange Server mailbox
description: This article discusses how to use a policy to control whether users are prompted for credentials when Microsoft Outlook connects to a Microsoft Exchange Server mailbox.
author: cloud-writer
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.author: meerak
ms.custom: 
  - Outlook for Windows
  - CSSTroubleshoot
appliesto: 
  - Outlook 2013
  - Outlook 2010
  - Office Outlook 2007
  - Office Outlook 2003
ms.date: 01/30/2024
---

# How to use Outlook policy to control credential prompts when connecting to an Exchange Server mailbox

> [!IMPORTANT]
> This article contains information about how to modify the registry. Make sure that you back up the registry before you modify it. Make sure that you know how to restore the registry if a problem occurs. For more information about how to back up, restore, and modify the registry, click the following article number to view the article in the Microsoft Knowledge Base:[256986 ](https://support.microsoft.com/help/256986) Description of the Microsoft Windows registry

## Introduction 

This article discusses how to use a policy to control whether users are prompted for credentials when Microsoft Outlook connects to a Microsoft Exchange Server mailbox.

## More Information

How to access this setting varies, depending on the version of Outlook being used. When in the Exchange account settings, click More Settings… and then click the Security tab.

Note In Outlook 2003 this setting is called Always prompt for user name and password. In Outlook 2007, Outlook 2010 and Outlook 2013, the setting is called Always prompt for logon credentials. To deploy the policy setting for all users, follow these steps.

Important This section, method, or task contains steps that tell you how to modify the registry. However, serious problems might occur if you modify the registry incorrectly. Therefore, make sure that you follow these steps carefully. For added protection, back up the registry before you modify it. Then, you can restore the registry if a problem occurs. For more information about how to back up and restore the registry, click the following article number to view the article in the Microsoft Knowledge Base: [322756](https://support.microsoft.com/help/322756) How to back up and restore the registry in Windows

1. Click **Start**, click **Run**, type regedit, and then click **OK**.

2. In the Registry Editor, locate the following key for Outlook 2013:

    HKEY_CURRENT_USER\Software\Policies\Microsoft\Office\**xx.0**\Outlook\Security
    
    Where **xx.0** is 15.0 for Outlook 2013, 14.0 for Outlook 2010, 12.0 for Outlook 2007, and 11.0 for Outlook 2003

3. Point to **New**, and then click
**DWORD Value**.   
4. Type PromptForCredentials as the name of the new registry entry, and then press ENTER.    
5. In the right pane, right-click **PromptForCredentials**, and then click **Modify**.   
6. In the **Edit DWORD Value **dialog box, and then type one of the following values in the **Value data** dialog box: 

    |Value|Description|
    |----|----|
    |0|Cached credentials are used.|
    |1|Cached credentials cannot be used. You are always prompted for logon credentials.|

7. Click **OK**.   
