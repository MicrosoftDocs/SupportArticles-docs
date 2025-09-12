---
title: The authentication wasn't successful error
description: Solves the authentication error that occurs when you try to use the Dynamics 365 App for Outlook in the Outlook desktop client.
ms.reviewer: 
ms.date: 03/14/2025
ms.custom: sap:Dynamics 365 App for Outlook Add-In
---
# "Sorry, the authentication was not successful" error occurs in Dynamics 365 App for Outlook

This article outlines several potential causes of the authentication error that occurs when you use the Dynamics 365 App for Outlook in the Outlook desktop client, and provides corresponding resolutions.

_Applies to:_ &nbsp; Dynamics 365 App for Outlook  
_Original KB number:_ &nbsp; 4483111

## Symptoms

When you try to use the [Dynamics 365 App for Outlook](/dynamics365/outlook-app/overview) in the Outlook desktop client, you receive the following error message:

> Sorry, the authentication was not successful. We can help you fix the problem.

## Cause 1 - Not all the URLs used to authenticate and access Dynamics 365 are in the same Internet Explorer security zone

> [!NOTE]
> If you're using Dynamics 365 (online) with an Exchange Online mailbox, this is unlikely to be the cause of the issue.

### Resolution

To solve this issue, follow the steps introduced in ["Something went wrong during sign-in" error using Dynamics 365 App for Outlook](something-went-wrong-during-sign-in.md) to verify that all necessary URLs are in the same Internet Explorer security zone.

## Cause 2 - The LocalLow folder has an incorrect integrity level

The integrity level for the **LocalLow** folder should be set to low, as indicated by the folder name.

### Resolution

To solve this issue, run the following command in a command prompt:

`icacls %userprofile%\Appdata\LocalLow /t /setintegritylevel (OI)(CI)L`

## Cause 3 - QuotaExceededError

When you select the option to show more, you see the following error:  

> Error: QuotaExceededError

The error indicates that your local browser storage is exceeded.

### Resolution

To solve this issue, clear your browser cache.

| Platform| Instructions |
|---|---|
| Internet Explorer or Outlook| [View and delete your browsing history in Internet Explorer](https://support.microsoft.com/topic/view-and-delete-your-browsing-history-in-internet-explorer-098ffe52-5ac9-a449-c296-c735c32c8678) |
| Microsoft Edge| [View and delete browser history in Microsoft Edge](https://support.microsoft.com/microsoft-edge/view-and-delete-browser-history-in-microsoft-edge-00cf7943-a9e1-975a-a33d-ac10ce454ca4) |
| Google Chrome| [Clear cache & cookies in Google Chrome](https://support.google.com/accounts/answer/32050) |

> [!IMPORTANT]
> Although you might have other browsers installed on your computer, the Outlook desktop always uses Internet Explorer when displaying web content, such as inside the Dynamics 365 App for Outlook.

After clearing your browser cache, close all Internet Explorer and Outlook desktop windows, and ensure there are no remaining Internet Explorer processes running by checking Task Manager.

If this issue only exists in the Outlook desktop client and clearing the cache via Internet Options doesn't help, try clearing it via the F12 IEChooser (not applicable for Windows 7):

1. Open the Dynamics 365 App for Outlook in the Outlook desktop client.
2. Open the **IEChooser.exe** located in `%WindowsFolder%\System32\F12` (for example, `C:\Windows\System32\F12`).
3. In the **Choose target to debug** window, select **Dynamics 365**.
4. Select the **Network** tab and then select the **Clear cache** button.

After completing these steps, reopen Outlook and the Dynamics 365 App for Outlook to see if the issue is resolved.

#### More information

[Debug a task pane add-in using the F12 tools](/office/dev/add-ins/testing/debug-add-ins-using-f12-tools-ie#debug-a-task-pane-add-in-using-the-f12-tools)

## Cause 4 - Third-party cookies are blocked in your browser settings

### Resolution

If the issue occurs in Outlook Web Access, open the browser settings to verify that a setting isn't enabled to block third-party cookies.

> [!NOTE]
> Some browsers allow you to block third-party cookies but add specific URLs to a list of allowed sites.

[!INCLUDE [Third-party disclaimer](../../../includes/third-party-disclaimer.md)]
