---
title: Microsoft Support and Recovery Assistant indicates offline scan
description: Describes an issue that the Outlook Advanced Diagnostic scenario in Support and Recovery Assistant results indicate an offline scan was forced by group policy for Outlook object model access. Provides a resolution.
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: CSSTroubleshoot
appliesto:
- Outlook 2019
- Outlook 2016
- Outlook 2013
- Microsoft Outlook 2010
search.appverid: MET150
ms.reviewer: tasitae, v-six
author: cloud-writer
ms.author: meerak
ms.date: 03/14/2024
---
# Outlook Advanced Diagnostic scenario in SaRA results indicate an offline scan was forced by group policy for Outlook object model access

## Symptoms

When you run the Outlook Advanced Diagnostics scenario in the Support and Recovery Assistant (SaRA), the results indicate an Offline scan was performed.

:::image type="content" source="media/results-for-advanced-diagnostic-indicate-offline-scan-was-forced/offline-scan-forced-by-offcat.png" alt-text="Results screen from SaRa." border="false":::

[!INCLUDE [Microsoft Support and Recovery Assistant note](../../../includes/sara-note-new-outlook.md)]

## Cause

> [!WARNING]
> Serious problems might occur if you modify the registry incorrectly by using Registry Editor or by using another method. These problems might require that you reinstall the operating system. Microsoft cannot guarantee that these problems can be solved. Modify the registry at your own risk.

This alert occurs when you have the following data configured in the Windows Registry. This configuration causes Outlook to automatically deny requests from any programs that attempt to access Outlook data.

Outlook 2010 and later versions:

Key: `HKEY_CURRENT_USER\Software\Policies\Microsoft\Office\x.0\Outlook\Security`  
DWORD: `AdminSecurityMode`  
Value: **3**

And one or both of the following registry keys:

Key: `HKEY_CURRENT_USER\Software\Policies\Microsoft\Office\x.0\Outlook\Security`  
DWORD: `PromptOOMAddressInformationAccess`  
Value: **0**

OR

Key: `HKEY_CURRENT_USER\Software\Policies\Microsoft\Office\x.0\Outlook\Security`  
DWORD: `PromptOOMAddressBookAccess`  
Value: **0**  

> [!NOTE]
> In the above registry key path, **x.0** corresponds to your version of Outlook (17.0 = Outlook 2019, 16.0 = Outlook 2016, 15.0 = Outlook 2013, 14.0 = Outlook 2010).

## Resolution

If you need to perform a full scan of Outlook, you can temporarily modify the `PromptOOMAddressInformationAccess` and/or `PromptOOMAddressBookAccess` registry values to **1**. This will cause Outlook to no longer automatically deny requests (_from any program_) to access Outlook data and will instead prompt you to approve the access request. The value of 1 is the default setting for this feature.

The available value data for these registry values is listed below.

0: Automatically deny  
1: Prompt user  
2: Automatically approve

The above registry data in the Policies hive may be controlled by a Group Policy. The Policy may need to be modified to permanently modify these settings.
