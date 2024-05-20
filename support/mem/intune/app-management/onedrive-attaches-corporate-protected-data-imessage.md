---
title: Corporate protected data is attached to an iMessage
description: Describes an issue in which OneDrive with iMessage integration configured as a managed app lets users attach corporate protected data to an iMessage. Provides a workaround.
ms.date: 12/05/2023
search.appverid: MET150
ms.custom: sap:Application Protection - iOS\Data transfer to other apps
ms.reviewer: kaushika, shhodge
---
# OneDrive with iMessage integration as a managed app attaches corporate protected data to an iMessage

This article fixes an issue in which OneDrive is configured as a managed app, but it lets users attach corporate protected data to an iMessage.

## Symptoms

OneDrive is configured as a managed app with a Microsoft Intune app protection policy (APP), but users can open the Apple iMessage app, go to OneDrive, and then attach corporate protected files.

## Solution

To prevent users from attaching deep links, the **General Intune iOS configuration** policy can be changed. Because the app is using the **Open-In** feature that is controlled by the operating system, Intune cannot change the behavior by using an app protection policy.

You can change the behavior through a mobile device management (MDM) setting by using the **General Intune iOS Configuration** policy. To do this, change the following settings to **No**:  

- **Allow managed documents in other unmanaged apps** (iOS 8.0.1 and later)
- **Allow unmanaged documents in other managed apps** (iOS 8.01 and later)

> [!NOTE]
> These policy settings block users from attaching the deep link to an iMessage.

## More information

OneDrive continues to protect corporate data when it is managed. The recipient is still required to have OneDrive installed and be authenticated by using an account that has access to the document. The attached files are deep links to the document within the app. iMessage is not consuming the document in any way. It is only a medium to transfer a deep link. The **Only Managed Apps** setting is still obeyed.

> [!NOTE]
> This applies to all file types that are managed (links that are made to resemble real files). A file shows a thumbnail only if it is originating from an unmanaged or consumer account.

[!INCLUDE [Third-party information disclaimer](../../../includes/third-party-disclaimer.md)]
