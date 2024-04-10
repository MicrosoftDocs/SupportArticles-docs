---
title: Buttons such as Track and Set Regarding are missing
description: Buttons such as Track and Set Regarding are missing in Microsoft Dynamics 365 App for Outlook. Provides a resolution.
ms.reviewer: 
ms.topic: troubleshooting
ms.date: 03/31/2021
ms.subservice: d365-sales-email-office-integration
---
# Buttons such as Track and Set Regarding are missing in Microsoft Dynamics 365 App for Outlook

This article provides a resolution for the issue that icons for buttons such as Track and Set Regarding are missing in Microsoft Dynamics 365 App for Outlook.

_Applies to:_ &nbsp; Microsoft Dynamics 365  
_Original KB number:_ &nbsp; 4464349

## Symptoms

When opening the Microsoft Dynamics 365 App for Outlook using Outlook desktop or Internet Explorer, icons for buttons such as Track and Set Regarding are missing. The buttons still function but the visual icons are missing. If you open the app in another browser such as Edge or Chrome, the button icons do appear.

> [!NOTE]
> If the Track and Set Regarding options are completely missing, see [Track and Set Regarding options are missing in Microsoft Dynamics 365 App for Outlook](https://support.microsoft.com/help/4462486).

## Cause

This issue can occur if your Internet Explorer security settings are configured to not allow font downloads.

> [!NOTE]
> If you use Outlook desktop, it always loads web pages using Internet Explorer even if you have other browsers installed.

## Resolution

If the symptoms match what is described in the Symptom section, try the following resolution:

1. Open Internet Explorer.
2. Select the gear icon in the upper-right corner and then select **Internet Options**.
3. Select the **Security** tab.
4. Select the security zone used for your Microsoft Dynamics 365 URL and then select **Custom level**.
5. Scroll down to the Downloads section to find the setting **Font download** and verify it is set to **Enable**.
6. Select **OK**.
7. Close and reopen Outlook.

If the steps above do not resolve the issue, refer to the following Blog post that discusses other potential causes for font icons not appearing in Internet Explorer:

[Windows 10 with Internet Explorer 11 some website graphic icons are missing](/archive/blogs/askie/windows-10-with-internet-explorer-11-some-website-graphic-icons-are-missing).
