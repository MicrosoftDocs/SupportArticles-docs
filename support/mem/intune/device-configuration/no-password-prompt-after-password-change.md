---
title: No password prompt after iOS email profile change in Intune
description: Fixes an issue in which there is no password prompt for iOS email profiles in Microsoft Intune after the password is changed.
ms.date: 12/05/2023
search.appverid: MET150
ms.custom: sap:Configure device profiles
ms.reviewer: kaushika, intunecic, waluja
---
# No password prompt for iOS email profiles in Intune after password change

This article provides a workaround for an issue where there is no password prompt for an email profile in Microsoft Intune after the password is changed.

## Symptoms

After the email password is changed for an iOS email profile in Microsoft Intune, you are not prompted to enter the new password. Therefore, no email can be sent or received.

## Cause

This issue occurs because of a limitation of the Exchange ActiveSync (EAS) protocol when it uses basic authentication.

## Solution

To work around this issue, enable Open Authentication (OAuth) in the email profile.

> [!IMPORTANT]
> When you use OAuth, make sure that your email solution supports OAuth before it targets this profile. Office 365 Exchange Online supports OAuth, but on-premises Exchange and other third-party solutions may not. If the email profile uses OAuth and the email service does not support it, the **Re-Enter Password** option may be broken. For example, nothing happens when you select the **Re-Enter Password** option in **Settings** on the iOS device. Make sure that you understand all the ramifications of enabling OAuth before you do this in a production environment.

[!INCLUDE [Third-party information disclaimer](../../../includes/third-party-disclaimer.md)]
