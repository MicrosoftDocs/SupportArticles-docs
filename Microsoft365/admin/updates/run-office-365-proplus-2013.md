---
title: How to keep on running Microsoft 365 Apps for enterprise 2013
description: Describes how to avoid having your Microsoft 365 Apps for enterprise 2013 installation automatically upgraded to Office 2016.
author: helenclu
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.author: luche
ms.custom: 
  - CSSTroubleshoot
appliesto: 
  - Microsoft 365 Apps for enterprise
ms.date: 03/31/2022
---

# How do I keep on running Microsoft 365 Apps for enterprise 2013?

## Summary

> [!NOTE]
> Support for this family of products will end in early 2017. For more information, see [Support for the 2013 version of Microsoft 365 Apps for enterprise ends February 28, 2017](https://support.microsoft.com/help/3199744).  

To prevent Microsoft 365 Apps for enterprise from being automatically updated to Office 2016 over the Internet, use one of the methods in the "Resolution" section. 

> [!IMPORTANT]
> Apply one of these methods only on installations of Microsoft 365 Apps for enterprise that are configured to automatically receive monthly updates over the Internet. If you've configured Microsoft 365 Apps for enterprise to receive updates from a location on your internal network, or if you've turned off automatic updates, you don't have to use these methods, because you control when the update to Office 2016 occurs.

We've enhanced the upgrade and installation experience, and for Microsoft 365 subscribers we've made changes to how Office 2016 apps will be updated from this point forward. We're also delivering new tools and resources to help you prepare, deploy, and manage Office.

## Resolution

There are two ways to prevent Microsoft 365 Apps for enterprise from updating to Office 2016. Use the method that works best for your organization. 

> [!NOTE]
>
> - These methods also work for Microsoft 365 Business.
> - Prior to implementing either Method 1 or 2 below, ensure that you have the latest Office 2013 updates installed. 

### Method 1: Use Group Policy templates

Use the Enable Automatic Upgrade Group Policy setting that's included in the Office 2013 Group Policy Administrative Template files (ADMX/ADML), which you can download from [here](https://www.microsoft.com/en-in/download/details.aspx?id=35554). This policy setting is located under Computer Configuration\Administrative Templates\Microsoft Office 2013 (Machine)\Updates. Select Disabled.

:::image type="content" source="media/run-office-365-proplus-2013/enable-automatic-upgrade-dialog-box.png" alt-text="Screenshot to select the Disable option in the Enable Automatic Upgrade dialog box.":::

> [!NOTE]
> Group Policy can be used only on computers that are joined to a domain.

### Method 2: Set a registry key 

> [!IMPORTANT]
> Follow the steps in this section carefully. Serious problems might occur if you modify the registry incorrectly. Before you modify it, [back up the registry for restoration ](https://support.microsoft.com/help/322756) in case problems occur.

To have us fix this problem for you, go to the "Here's an easy fix" section. If you prefer to fix this problem manually, go to the "Let me fix it myself" section.

#### Here's an easy fix

To fix this problem automatically, [download this easy fix](https://download.microsoft.com/download/9/D/A/9DA2374F-5766-4CDB-BE7F-36871DFAD05E/MicrosoftEasyFix20156.mini.diagcab), run MicrosoftEasyFix20156.mini.diagcab, and then follow the steps in the easy fix wizard.

- This wizard may be in English only. However, the automatic fix also works for other language versions of Windows.   
- If you're not on the computer that has the problem, save the easy fix solution to a flash drive or a CD, and then run it on the computer that has the problem.   

#### Let me fix it myself

Easy fix 20156

Go to the following location in the registry on each affected computer:

**HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\office\15.0\common\officeupdate**

Then, add the following value under the office update subkey: 

**"enableautomaticupgrade"=dword:00000000**

## More Information

Support for Office 2013 versions of the Microsoft 365 client applications ended on February 28, 2016. Therefore, we recommend that you update to the Office 2016 version of Microsoft 365 Apps for enterprise as soon as possible. For more information, see [Support for the 2013 version of Microsoft 365 Apps for enterprise ends February 28, 2017](https://support.microsoft.com/help/3199744).
