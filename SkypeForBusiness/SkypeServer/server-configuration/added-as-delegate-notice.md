---
title: You are prompted with You have been added as a delegate for %User%
description: Fixes an issue in which a Skype for Business or Lync user is prompted with a You have been added as a delegate for %User% notification. The user previously dismissed the delegator that's described in the notification.
author: simonxjx
manager: dcscontentpm
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.author: v-six
ms.custom: 
  - CSSTroubleshoot
appliesto: 
  - Microsoft Lync 2013
  - Skype for Business 2016
ms.date: 03/31/2022
---

# Lync 2013 and Skype for Business 2016 users are prompted with "You have been added as a delegate for %User%" notice that was previously dismissed

## Symptoms

This issue occurs when a user starts Microsoft Lync 2013 or Skype for Business 2016, and the user is a delegate for more than two delegators. 

> [!NOTE]
> %User% is the name of a previously dismissed delegator. 

When this issue occurs, the delegator's SIP URI appears in both of the following registry paths:

- **HKEY_CURRENT_USER\Software\Microsoft\Office\15.0\Lync\%UserSipUri%\Dismissed DelegatorList**   
- **HKEY_CURRENT_USER\Software\Microsoft\Office\15.0\Lync\%UserSipUri%\Last DelegatorList**   

## Cause

This issue occurs because Lync and Skype for Business are limited by design in the number of delegators or delegates that exceed specific thresholds. Therefore, when the number of delegators is more than two, a user may encounter a problem. 

## Resolution

To fix this issue, use one of the following methods, depending on your Office installation type. See the "[More Information](#more-information)" section to determine whether your Office installation is MSI-based or Click-to-Run.

This issue has been fixed in Lync 2013 (Skype for Business) and Skype for Business 2016 Click-to-Run clients. When these clients are updated, users are no longer prompted by notices that they previously dismissed.

Additionally, design improvements have been implemented to increase the supported threshold of delegators and delegates that can be configured. For more information, see the updated "More Information" section.

To fix this issue for Lync 2013 (Skype for Business) MSI clients, apply the following update:

[January 12, 2016, update for Lync 2013 (Skype for Business) (KB3114502)](https://support.microsoft.com/help/3114502)

Lync 2013 (Skype for Business) Click-to-Run clients:

This issue is fixed in builds 15.0.4787.1002 and later builds.

Skype for Business 2016 Click-to-Run clients:

Current Channel: Builds 16.0.6741.2017 and later builds
First Release Deferred Channel: 16.0.6741.2017 and later builds
Deferred Channel: 16.0.6741.2048and later builds

For more information about C2R Channel builds, see [Microsoft 365 client update channel releases](/officeupdates/release-notes-microsoft365-apps).

## Workaround

To work around this issue for Skype for Business 2016 MSI clients, make sure that the affected delegate (admin) has no more than two delegators (bosses). Microsoft is aware of this issue and will provide updates as they become available. 

## More Information

Lync 2013 (Skype for Business) MSI and Click-to-Run clients and Skype for Business 2016 Click-to-Run clients support the following delegate and delegator relationship thresholds if they're running the versions that are described in the "Resolution" section or later versions:

- A boss (delegator) can have 25 administrators (delegates).    
- An administrator (delegate) can have up to 25 bosses (delegators).

    Skype for Business 2016 MSI clients are still limited to 2 bosses per delegate.   

To determine whether your Office installation is Click-to-Run or MSI-based, follow these steps:

1. Start an Office 2016 application.    
2. On the **File** menu, select **Account**.   
3. For Office 2016 Click-to-Run installations, an **Update Options** item is displayed. For MSI-based installations, the **Update Options** item isn't displayed.   

|Office 2016 Click-to-Run installation|MSI-based Office 2016|
|-|-|
|:::image type="content" source="./media/added-as-delegate-notice/click-to-run.png" alt-text="Screenshot that shows the Word click to run installation option.":::|:::image type="content" source="./media/added-as-delegate-notice/about-word.png" alt-text="Screenshot that shows the Word MSI.":::|

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).
