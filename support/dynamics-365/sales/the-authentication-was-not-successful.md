---
title: The authentication wasn't successful
description: Provides a solution to an error that occurs when you try to use the Dynamics 365 App for Outlook on Outlook desktop.
ms.reviewer: 
ms.topic: troubleshooting
ms.date: 03/31/2021
ms.subservice: d365-sales-client-outlook
---
# Sorry, the authentication was not successful error occurs in Microsoft Dynamics 365 App for Outlook

This article provides a solution to an error that occurs when you try to use the Dynamics 365 App for Outlook on Outlook desktop.

_Applies to:_ &nbsp; Microsoft Dynamics 365  
_Original KB number:_ &nbsp; 4483111

## Symptoms

When attempting to use the Dynamics 365 App for Outlook on Outlook desktop, you see the following error:

> "Sorry, the authentication was not successful. We can help you fix the problem."

## Cause

**Cause 1:** It can occur if not all of the URLs used to authenticate and access Dynamics 365 are in the same Internet Explorer security zone.

> [!NOTE]
> If you're using Dynamics 365 (online) with an Exchange Online mailbox, it's not likely the cause of the issue.

**Cause 2:** It can occur if the LocalLow folder has an incorrect integrity level. The correct setting is to have the integrity level set to low as the folder name indicates.

**Cause 3:** If you select the option to show more and you see:  
> "Error: QuotaExceededError"

Which indicates your local browser storage limit has been met.

**Cause 4:** If you're accessing Outlook Web Access, it can occur if third-party cookies are blocked in your browser settings.

## Resolution

**Resolution 1:**  
Use the steps in ["Something went wrong during sign-in" error using Dynamics 365 App for Outlook](https://support.microsoft.com/help/4035750) to verify each of the necessary URLs are in the same Internet Explorer security zone.

**Resolution 2:**

1. Open a command prompt.
2. Run the following command:  
    `icacls %userprofile%\Appdata\LocalLow /t /setintegritylevel (OI)(CI)L`

**Resolution 3:**  
Clear your browser cache.

| **Platform**| **Instructions** |
|---|---|
| Outlook (same as Internet Explorer)| [View and delete your browsing history in Internet Explorer](https://support.microsoft.com/topic/view-and-delete-your-browsing-history-in-internet-explorer-098ffe52-5ac9-a449-c296-c735c32c8678) |
| Internet Explorer| [View and delete your browsing history in Internet Explorer](https://support.microsoft.com/topic/view-and-delete-your-browsing-history-in-internet-explorer-098ffe52-5ac9-a449-c296-c735c32c8678) |
| Edge| [View and delete browser history in Microsoft Edge](https://support.microsoft.com/microsoft-edge/view-and-delete-browser-history-in-microsoft-edge-00cf7943-a9e1-975a-a33d-ac10ce454ca4) |
| Chrome| [Clear cache & cookies](https://support.google.com/accounts/answer/32050) |

> [!IMPORTANT]
> Although you may have other browsers installed on your computer, Outlook desktop always uses Internet Explorer when displaying web content such as inside Dynamics 365 App for Outlook.

After clearing your browser cache, close all Internet Explorer and Outlook desktop windows, and make sure through Task Manager, there are no remaining Internet Explorer processes running.

If this issue only appears in Outlook desktop and clearing the cache via Internet Options doesn't help, try clearing it via F12 chooser (not applicable for Windows 7):

1. Open Dynamics app in Outlook desktop.
2. Open **IEChooser.exe** in `%WindowsFolder%\System32\F12` (example: `C:\Windows\System32\F12`)
3. Select **Dynamics 365**  
4. Select the **Network** tab and then select the **Clear cache** button.

After following the steps above, reopen Outlook and the Dynamics 365 App for Outlook to see if the issue is resolved.

**Resolution 4:**  
If the issue occurs in Outlook Web Access, open the settings for your browser to verify a setting isn't enabled to block third-party cookies.

> [!NOTE]
> Some browsers allow you to block 3rd party cookies but add specific URLs to a list of allowed sites.

[!INCLUDE [Third-party disclaimer](../../includes/third-party-disclaimer.md)]
