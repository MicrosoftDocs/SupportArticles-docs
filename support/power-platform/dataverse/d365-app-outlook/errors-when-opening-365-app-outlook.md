---
title: Errors when opening Dynamics 365 App for Outlook
description: Solves common errors that might occur when attempting to open Microsoft Dynamics 365 App for Outlook.
ms.reviewer: 
ms.date: 03/10/2025
ms.custom: sap:Dynamics 365 App for Outlook Add-In
---
# Error occurs when trying to open Dynamics 365 App for Outlook

This article provides resolutions for an issue where you can't open Microsoft Dynamics 365 App for Outlook due to an error.

_Applies to:_ &nbsp; Dynamics 365 App for Outlook  
_Original KB number:_ &nbsp; 4345548

## Symptoms

When trying to open Dynamics 365 App for Outlook, you might receive an error message.

## Resolution 1: Use the "Help me resolve this issue" link

If an error occurs, check for a **Help me resolve this issue** link. Selecting this link will direct you to an article created to help solve the specific error if Microsoft is aware of a potential solution.

## Resolution 2: Clear your browser cache

### For Office 365 version 16.0.11629 and Windows 10 version 1903 or later

Follow these steps as Office Add-ins are now using [Microsoft Edge WebView](https://developer.microsoft.com/office/blogs/microsoft-edge-webview-for-office-add-ins/):

1. Install [Microsoft Edge DevTools Preview](https://www.microsoft.com/p/microsoft-edge-devtools-preview/9mzbfrmz0mnj#activetab=pivot:overviewtab).
2. In Outlook, open Dynamics 365 App for Outlook.
3. Run Microsoft Edge DevTools Preview. You should see Dynamics 365 (EXP) as a debug target.
4. Select it to open the **F12** tools.
5. Go to the **Console** tab.
6. Run `window.localStorage.clear()`.
7. Reopen Dynamics 365 App for Outlook in Outlook.

### For earlier versions of Office 365 and Windows

|Platform|Instructions|
|---|---|
| Internet Explorer or Outlook| [View and delete your browsing history in Internet Explorer](https://support.microsoft.com/topic/view-and-delete-your-browsing-history-in-internet-explorer-098ffe52-5ac9-a449-c296-c735c32c8678) |
| Microsoft Edge| [View and delete browser history in Microsoft Edge](https://support.microsoft.com/microsoft-edge/view-and-delete-browser-history-in-microsoft-edge-00cf7943-a9e1-975a-a33d-ac10ce454ca4) |
| Google Chrome| [Clear cache & cookies in Google Chrome](https://support.google.com/accounts/answer/32050) |

> [!IMPORTANT]
> Although other browsers might be installed on your computer, the Outlook desktop client always uses Internet Explorer to display web content, such as the content inside Dynamics 365 App for Outlook. However, starting with Microsoft 365 version 16.0.11629, this is no longer the case. This means that Outlook desktop no longer relies solely on Internet Explorer for displaying web content and might use other browsers or web technologies instead.

After clearing your browser cache, close all Internet Explorer and Outlook desktop windows. Use Task Manager to ensure that no Internet Explorer processes are running.

### Use F12 IEchooser (not applicable for Windows 7)

If this issue only appears in the Outlook desktop client and clearing the cache via Internet Options doesn't help, try clearing it via F12 IEchooser (not applicable for Windows 7):

1. Open Dynamics 365 App for Outlook in the Outlook desktop client.
2. Open **IEChooser.exe** located in `%WindowsFolder%\System32\F12` (for example: `C:\Windows\System32\F12`).
3. In the **Choose target to debug** window, select **Dynamics 365**.
4. Select the **Network** tab and then select the **Clear cache** button.

After completing the preceding steps, reopen Outlook and Dynamics 365 App for Outlook to check if the issue is resolved.

#### More information

[Debug a task pane add-in using the F12 tools](/office/dev/add-ins/testing/debug-add-ins-using-f12-tools-ie#debug-a-task-pane-add-in-using-the-f12-tools)

### For Mac users

To solve the issue, see [Clearing the Office application's cache on a Mac](/office/dev/add-ins/testing/debug-office-add-ins-on-ipad-and-mac#clearing-the-office-applications-cache-on-a-mac).

## Resolution 3: Open a support case

If you can't resolve the issue and need assistance from Microsoft, include the following information to expedite your support case:

1. Repro steps  

    Provide detailed steps that result in the error.

1. Error details

    Include the details of any error message that appears. If the error includes a **Show more** option, copy and paste these details into the case.

1. Environment details  

    Include information such as the version of the following components:

    - Outlook
    - Microsoft Exchange
    - Operating system

1. User impact  

   Indicate if the issue occurs for all users or only specific users, such as those with a certain security role or Outlook version.

[!INCLUDE [Third-party disclaimer](../../../includes/third-party-disclaimer.md)]
