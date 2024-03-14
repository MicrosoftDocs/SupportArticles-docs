---
title: Contact's name not phone number displayed
description: In Skype for Business 2016, you may find the contact card of a user only shows the user's phone number, not the display name.
author: simonxjx
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.author: v-six
ms.reviewer: jaym, carlsh
ms.custom: 
  - CSSTroubleshoot
appliesto: 
  - Skype for Business 2016
ms.date: 03/31/2022
---

# Contact card displays phone number instead of name in Skype for Business 2016

## Symptoms

In Skype for Business 2016, you may find that a user's contact card shows the phone number instead of the contact's display name. 

## Cause

This issue occurs when Exchange contact sync is disabled. 

To disable Exchange contact sync, run the following command for a specific user or tenant:

```powershell
Set-CsClientPolicy -EnableExchangeContactSync $false
```

## Resolution

> [!IMPORTANT]
> This resolution applies to Office Click-to-Run version 16.0.8431.2079 or later.

> [!WARNING]
> Serious problems might occur if you modify the registry incorrectly by using Registry Editor or by using another method. These problems might require that you reinstall your operating system. Microsoft cannot guarantee that these problems can be solved. Modify the registry at your own risk.     

To resolve this problem, apply one of the following settings. 

### In-band provisioning setting

Run the following command from a Lync PowerShell command prompt: 

```powershell
$a = New-CsClientPolicyEntry -NameEnableContactResolutionWithTelUriAndEmailOnly -Value "true"
 Set-CsClientPolicy-Identity** **Global -PolicyEntry @{Add=$a}
```

### GPO setting
 
1. In Group Policy Management, create a Group Policy object.
 
   **Note** When you create a GPO, specify a name and leave the source as none.    
2. On the **Settings** tab, right-click **Computer Configuration** or **User Configuration**, and then select **Edit**.    
3. Right-click **Registry**, select **New**, and then select **Registry Item**.    
4. In the **New Registry Properties** dialog box, specify the following information, and then select **OK**:

   ```adoc
   Action: Create
   Hive: HKEY_CURRENT_USER
   Key path: Software\Policies\Microsoft\Office\16.0\Lync
   Value name: EnableContactResolutionWithTelUriAndEmailOnly
   Value type: REG_DWORD
   Value data: 1
   Base: Decimal    
   ```

## More information

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).
