---
title: Duplicated working numbers for contacts are displayed in call drop-down menu
description: Fixes an issue in which duplicated working numbers are shown for contacts in the drop-down menu in Skype for Business 2015 (Lync 2013).
author: simonxjx
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.author: v-six
ms.custom: 
  - CSSTroubleshoot
ms.reviewer: carlsh, suetc, digvish, stankan, jackyfan
appliesto: 
  - Skype for Business 2015
  - Lync 2013
ms.date: 03/31/2022
---

# Duplicated working numbers for contacts are displayed in call drop-down menu in Skype for Business 2015 (Lync 2013)

## Symptoms

Assume that you have custom phone number normalization rules, and you don't use standard extensions. When you hover over a contact, and then click the drop-down menu under the **Call** option in Microsoft Skype for Business 2015 (Lync 2013), you see duplicated working numbers.

## Resolution

To fix this issue, install the latest updates, and then apply the *RenormalizeContactModelPhoneNumbersBeforeDisplay* policy either as a Skype for Business Server In-Band policy or as a client policy in the client registry.

**Note** Lync 2013 was upgraded to Skype for Business in April 2015.

### Set RenormalizeContactModelPhoneNumbersBeforeDisplay as a Skype for Business Server In-Band policy

To set the policy for all users, run the following Windows PowerShell cmdlets: 

```powershell
$a = New-CsClientPolicyEntry –Name "RenormalizeContactModelPhoneNumbersBeforeDisplay" –Value $True
 Set-CsClientPolicy –Identity Global –PolicyEntry @{Add=$a}
```

To set the policy for specific users, run the following PowerShell cmdlets: 

```powershell
$a = New-CsClientPolicyEntry –Name "RenormalizeContactModelPhoneNumbersBeforeDisplay" –Value $True
 new-CsCLientPolicy -Identity TelephoneDisplayNameFromServer
 Set-CsClientPolicy –Identity RenormalizeContactModelPhoneNumbersBeforeDisplay–PolicyEntry @{Add=$a}
 Grant-CsClientPolicy -Identity UserName
```

### Set RenormalizeContactModelPhoneNumbersBeforeDisplay as a client policy in the registry

> [!IMPORTANT]
> Follow the steps in this section carefully. Serious problems might occur if you modify the registry incorrectly. Before you modify it, [back up the registry for restoration ](https://support.microsoft.com/help/322756)in case problems occur. 

To do this, follow these steps: 
1. On the computer that has Skype for Business client installed, open Registry Editor, and then locate one of the following subkeys:

   - HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Office\15.0\Lync    
   - HKEY_CURRENT_USER\Software\Policies\Microsoft\Office\15.0\Lync    
     
2. Right-click the subkey, point to **New**, and then click **DWORD (32-bit) Value**.    
3. Type **RenormalizeContactModelPhoneNumbersBeforeDisplay**, and then press Enter.    
4. Right-click **RenormalizeContactModelPhoneNumbersBeforeDisplay**, and then click **Modify**.    
5. In the **Value data** box, enter **1**, and then click **OK**.    
6. Exit Registry Editor.    

## More information

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).
