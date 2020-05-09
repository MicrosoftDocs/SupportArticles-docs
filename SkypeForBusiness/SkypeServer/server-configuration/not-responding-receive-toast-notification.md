---
title: Stops responding when receiving a toast notification in Citrix VDI environment
description: The Skype for Business client stops responding when receiving a toast notification of an IM or an incoming call in Citrix VDI environment. Provides a resolution.
author: simonxjx
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
- MET150
audience: ITPro
ms.service: skypeforbusiness-powershell
ms.topic: article
ms.author: v-six
ms.custom: CSSTroubleshoot
appliesto:
- Skype for Business
---

# Skype for Business client stops responding when receiving a toast notification of an IM or an incoming call in Citrix VDI environment

## Symptoms

Assume that you use the Microsoft Skype for Business client in a Citrix VDI environment that has HDX RealTime Optimization Pack (RTOP) Connector installed. When you run one or more Lync SDK-based applications and receive a toast notification of an instant messaging (IM) message or an incoming call, the client stops responding. 

## Resolution

> [!IMPORTANT]
> Follow the steps in this section carefully. Serious problems might occur if you modify the registry incorrectly. Before you modify it, [back up the registry for restoration](https://support.microsoft.com/help/322756) in case problems occur. 

To fix this issue, install the April 2, 2019 update for Skype for Business for a Click-to-Run installation. To do this, open an Office program, such as Word, and then select **File** > **Account** > **Update Options** > **Update Now**.

> [!NOTE]
> If "Update Options" does not exist in the client, this is an .msi installation.
 
![The screenshot for Update Options ](https://support.microsoft.com/Library/Images/2999585.png) 

Don't see your Skype for Business client in the list? Click [here](https://technet.microsoft.com/office/dn788954) for a complete list of clients. You can download the Click-to-Run client from the [Office365 Portal](https://portal.office.com/ols/mysoftware.aspx).  

After you apply the update, create a Group Policy to set the following registry key on clients:

Subkey: 
**HKEY_CURRENT_USER\SOFTWARE\Microsoft\Office\16.0\Lync**
 
Value: **EnableDelayPostingOfDeferredCOMEvents**
 
DWORD data: **1**     
A
lternatively, you can enable this fix by creating a custom policy entry and adding it to the client policy, as follows: 

```powershell
$x = New-CsClientPolicyEntry -Name "EnableDelayPostingOfDeferredCOMEvents" -Value "true"
```

```powershell
Set-CsClientPolicy -Identity "<ClientPolicyName>" -PolicyEntry @{Add=$x}
```

Lync 2013 was upgraded to Skype for Business in April 2015. 

**Third-party information disclaimer**

The third-party products that this article discusses are manufactured by companies that are independent of Microsoft. Microsoft makes no warranty, implied or otherwise, about the performance or reliability of these products.

## More information

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).
