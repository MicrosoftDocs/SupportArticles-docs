---
title: Office applications periodically prompt for credentials
description: Describes a situation in which Lync and Office periodically prompt for credentials to SharePoint Online and OneDrive in some cases.
author: helenclu
manager: dcscontentpm
localization_priority: Normal
audience: ITPro
ms.topic: troubleshooting
ms.author: luche
ms.custom: 
  - CSSTroubleshoot
search.appverid: 
  - MET150
appliesto: 
  - Office 2016
  - Office 2013
ms.date: 03/31/2022
---

# Office applications periodically prompt for credentials to SharePoint Online, OneDrive, and Lync Online

## Symptoms

Users are periodically being prompted by Office 2013 and Lync 2013 for credentials to SharePoint Online, OneDrive, and Lync Online.

The following are some examples of the credential messages:

- Sign in with your organizational account   
- Credentials are required   
- We are unable to connect right now, Check your network connection.   

## Cause

Microsoft has confirmed that this is a problem in the Microsoft products that are listed in the "Applies to" section.

User names and passwords entered for Office 2013 and Lync 2013 in order to log on to SharePoint Online, OneDrive, and Lync Online can be optionally saved in Windows CredMan. This typically happens when the user selects the **Keep me signed-in** check box. For federated user accounts, the user name and passwords are not saved. This is because Integrated Windows Authentication can be used, which does not require the password. For a third-party federated identity provider that does not support Integrated Windows Authentication, the password is not available from CredMan, and therefore it must be prompted for.

## Resolution

> [!IMPORTANT]
> This section, method, or task contains steps that tell you how to modify the registry. However, serious problems might occur if you modify the registry incorrectly. Therefore, make sure that you follow these steps carefully. For added protection, back up the registry before you modify it. Then, you can restore the registry if a problem occurs. For more information about how to back up and restore the registry, see [How to back up and restore the registry in Windows](https://support.microsoft.com/help/322756).

1. Start Registry Editor.   
2. Navigate to the following registry subkey: 
 
   Office 2016

   HKEY_CURRENT_USER\Software\Microsoft\Office\16.0\Common\Identity

   Office 2013

   HKEY_CURRENT_USER\Software\Microsoft\Office\15.0\Common\Identity
1. Right-click the entry, and then select **New**.   
1. Add a new DWORD value to the registry called NoDomainUser, and then set it to a value of 1.   

The registry entry alters the behavior for a federated user account so that the password is saved in CredMan.
