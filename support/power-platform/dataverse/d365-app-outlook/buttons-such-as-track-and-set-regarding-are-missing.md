---
title: Track and Set Regarding icons are missing
description: Solves the issue that the icons of the Track button and the Set Regarding button are missing in Microsoft Dynamics 365 App for Outlook.
ms.reviewer: 
ms.date: 03/06/2025
ms.custom: sap:Dynamics 365 App for Outlook Add-In
---
# Track and Set Regarding icons are missing in Dynamics 365 App for Outlook

This article provides a resolution for an issue where icons for buttons such as [Track and Set Regarding](/dynamics365/outlook-app/user/track-message-or-appointment) are missing in Microsoft Dynamics 365 App for Outlook.

_Applies to:_ &nbsp; Dynamics 365 App for Outlook  
_Original KB number:_ &nbsp; 4464349

## Symptoms

When you open Dynamics 365 App for Outlook using Outlook desktop or Internet Explorer, icons for buttons such as **Track** and **Set Regarding** are missing. The buttons still function, but the visual icons are missing. However, if you open the app in another browser, such as Microsoft Edge or Google Chrome, the button icons do appear.

> [!NOTE]
> If the **Track** and **Set Regarding** buttons are completely missing, see [Track and Set Regarding options are missing in Microsoft Dynamics 365 App for Outlook](track-set-regarding-options-miss.md).

## Cause

This issue can occur if your Internet Explorer security settings are configured to not allow font downloads.

> [!NOTE]
> If you use Outlook desktop, it always loads web pages using Internet Explorer even if you have other browsers installed.

## Resolution

To solve this issue:

1. Open Internet Explorer.
2. Select the gear icon in the upper-right corner and then select **Internet Options**.
3. Select the **Security** tab.
4. Select the security zone used for your Microsoft Dynamics 365 URL and then select **Custom level**.
5. Scroll down to the **Downloads** section to find the **Font download** setting and verify it's set to **Enable**.
6. Select **OK**.
7. Close and reopen Outlook.

If the steps don't resolve the issue, refer to the following blog post that discusses other potential causes for font icons not appearing in Internet Explorer:

[Windows 10 with Internet Explorer 11 some website graphic icons are missing](/archive/blogs/askie/windows-10-with-internet-explorer-11-some-website-graphic-icons-are-missing)
