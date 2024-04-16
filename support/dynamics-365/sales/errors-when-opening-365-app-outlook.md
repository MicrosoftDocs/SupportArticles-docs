---
title: Errors when opening 365 App for Outlook
description: Troubleshooting errors when attempting to open Dynamics 365 App for Outlook.
ms.reviewer: 
ms.topic: troubleshooting
ms.date: 03/31/2021
ms.subservice: d365-sales-client-outlook
---
# Troubleshooting errors when attempting to open Microsoft Dynamics 365 App for Outlook

This article provides a solution to errors that occur when using Dynamics 365 App for Outlook.

_Applies to:_ &nbsp; Microsoft Dynamics 365  
_Original KB number:_ &nbsp; 4345548

## Symptoms

When attempting to open Dynamics 365 App for Outlook, you receive an error message.

## Use the Help me resolve this issue link

Most errors you may meet will include a **Help me resolve this issue** link. If it appears, make sure to select this link. If Microsoft is aware of a potential solution to the issue, this link will direct you to an article created to help solve that specific error.

## Clear your browser cache

If you're using Office 365 version 16.0.11629 and Windows 10 version 1903 or later, follow these steps as Office Add-ins are now using [Microsoft Edge WebView](https://developer.microsoft.com/office/blogs/microsoft-edge-webview-for-office-add-ins/):

1. Install [Microsoft Edge DevTools Preview](https://www.microsoft.com/p/microsoft-edge-devtools-preview/9mzbfrmz0mnj#activetab=pivot:overviewtab).
2. In Outlook, launch the Dynamics 365 app for Outlook.
3. Run Microsoft Edge DevTools Preview.
4. You should see Dynamics 365 (EXP) as a debug target.
5. Select it to launch the **F12** tools.
6. Go to the **Console** tab.
7. Run: window.localStorage.clear().
8. Open the app again in Outlook.

If you're using early versions of Office 365 and Windows, use the following steps:

|**Platform**|**Instructions**|
|---|---|
|Outlook (same as Internet Explorer)| [View and delete your browsing history in Internet Explorer](https://support.microsoft.com/topic/view-and-delete-your-browsing-history-in-internet-explorer-098ffe52-5ac9-a449-c296-c735c32c8678) |
| Internet Explorer| [View and delete your browsing history in Internet Explorer](https://support.microsoft.com/topic/view-and-delete-your-browsing-history-in-internet-explorer-098ffe52-5ac9-a449-c296-c735c32c8678) |
| Edge| [View and delete browser history in Microsoft Edge](https://support.microsoft.com/microsoft-edge/view-and-delete-browser-history-in-microsoft-edge-00cf7943-a9e1-975a-a33d-ac10ce454ca4) |
| Chrome| [Clear cache & cookies](https://support.google.com/accounts/answer/32050) |

> [!IMPORTANT]
> Although you may have other browsers installed on your computer, Outlook desktop always uses Internet Explorer when displaying web content such as inside Dynamics 365 App for Outlook. As mentioned in the beginning of this section, it's no longer true starting with Office 365 version 16.0.11629.

After clearing your browser cache, close all Internet Explorer and Outlook desktop windows and make sure through Task Manager there are no remaining Internet Explorer processes running.

If this issue only appears in Outlook desktop and clearing the cache via Internet Options doesn't help, try clearing it via F12 chooser (not applicable for Windows 7):

1. Open Dynamics app in Outlook desktop.
2. Open **IEChooser.exe** in `%WindowsFolder%\System32\F12`(example: `C:\Windows\System32\F12`).
3. Select **Dynamics 365**.
4. Select the **Network** tab and then select the **Clear cache** button.

After following the steps above, reopen Outlook and the Dynamics 365 App for Outlook to see if the issue is resolved.

If you're using a Mac, see [Clearing the Office application's cache on a Mac](/office/dev/add-ins/testing/debug-office-add-ins-on-ipad-and-mac#clearing-the-office-applications-cache-on-a-mac).

## Other Known Issues

["The view is not available" error message appears when opening an email in the Dynamics 365 App for Outlook](https://support.microsoft.com/help/4338690)

## Opening a support case

If you're unable to resolve the issue and need help from Microsoft, include the following information to help solve your case as fast as possible:

1. Repro Steps  
    Provide detailed steps that result in the error.
1. Error Details  
    Include the details of any error message that appears. If the error includes a **Show more** option, copy and paste these details into the case.
1. Environment Details  

    Include information such as the version of the following components:

    - Outlook (ex. Office 2013 SP3)
    - Microsoft Exchange (ex. Exchange 2013 CU15 or Exchange Online)
    - Operating System (ex. Windows 10)

1. User Impact  
    Indicate if the issue occurs for all users, or only certain users such as only users with a certain security role or only users with a certain version of Outlook.

[!INCLUDE [Third-party disclaimer](../../includes/third-party-disclaimer.md)]
