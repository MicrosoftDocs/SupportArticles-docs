---
# required metadata

title: Troubleshoot issues opening Report Designer
description: Provides a resolution for common issues that can cause problems when you open Report Designer in Microsoft Dynamics 365 Finance.
author: aprilolson
ms.date: 11/30/2023
ms.prod: 
ms.technology: 

# optional metadata

ms.search.form: FinancialReports
# ROBOTS: 
audience: Application User
# ms.devlang: 
ms.reviewer: twheeloc
# ms.tgt_pltfrm: 
ms.collection: get-started
ms.assetid: 3eae6dc3-ee06-4b6d-9e7d-1ee2c3b10339
ms.search.region: Global
# ms.search.industry: 
ms.author: aolson
ms.search.validFrom: 2016-02-28
ms.dyn365.ops.version: AX 7.0.0
---
# Troubleshoot issues opening Report Designer

This article provides a resolution for common issues that can cause problems when you open Report Designer in Microsoft Dynamics 365 Finance.

## Issue 1 - Report Designer doesn't start when you select "New" or "Edit"

### Resolution

To solve this issue, follow these steps:

1. In Internet Explorer, select **Settings** > **Internet Options** > **Security** > **Trusted Sites** > **Sites**. In the **Add this website to zone** field, enter `\*\.dynamics.com`, and then select **Add**.
2. In Internet Explorer, select **Settings** > **Internet Options** > **Security** > **Trusted Sites**. In the area labeled **Security level for this zone**, change the option to **Medium-Low**.
3. Disable the pop-up blocker in your browser.
4. Install [Microsoft .NET Framework 4.7.2 or higher](https://dotnet.microsoft.com/download/dotnet-framework/net472) to workstations.
5. If you're using the Chrome browser, you must install the **ClickOnce** extension to download the Report Designer client. If you're running Chrome in incognito mode, make sure the **ClickOnce** extension is enabled for incognito mode. For more information about the Chrome **ClickOnce** extension, see [System requirements for cloud deployments](/dynamics365/fin-ops-core/fin-ops/get-started/system-requirements).
6. If you're using Microsoft Edge with the Chrome browser, you don't need to install the **ClickOnce** extension for Microsoft Edge Chromium. However, you must enable the **ClickOnce** option to download the Report Designer client. If you're running incognito mode, make sure the **ClickOnce** extension is enabled for incognito mode.

    1. Open a new browser in Microsoft Edge.
    2. Enter **edge://flags** and select <kbd>Enter</kbd>.
    3. Search for the **ClickOnce Support** option or use this direct link: `edge://flags/#edge-click-once`.
    4. Set the drop-down menu option to **Enabled**.
    5. Select **Restart Browser**.

## Issue 2 - The user isn't assigned the required permissions to use Financial reporting

### Resolution

- To verify that the user doesn't have permission, select **Yes** on the error, "Unable to connect to the Financial reporting server. Select Yes if you want to continue and specify a different server address." Then select **Test Connection**. If you don't have permission, you'll see a message that says, "Connection attempt failed. User does not have appropriate permissions to connect to the server. Contact your system administrator."
- The required permissions are listed in [Granting security access to Financial reporting](/dynamics365/finance/general-ledger/financial-reporting-getting-started#granting-security-access-to-financial-reporting). Security in Financial reporting is based on these privileges. You won't have access unless these privileges (or another security role that includes these privileges) are assigned to you.
- The **Company Users Provider to Company** integration task (also responsible for and known as user integration) runs on a 5-minute interval. It might take up to 10 minutes for any permission changes to take effect in Financial reporting.

  If another user can open Report Designer, select **Tools** > **Integration Status**. Verify that the **Company Users Provider to Company** integration map has run successfully because you were assigned permission to use Financial reporting.

- It might be possible that another error has prevented **Dynamics user to Financial reporting user integration** from finishing. Or it's possible that a data mart reset has been initiated and not yet completed, or that another system error has occurred. Try running the process again later. If the problem persists, contact your system administrator.

## Issue 3 - Can't complete sign-in within Report Designer even if you can proceed with the "ClickOnce Report Designer" sign-in page

### Resolution

- The time set on your local computer when you enter your sign-in credentials must be within five minutes of the time on the Financial reporting server. If there's a difference of more than five minutes, the system won't allow sign-in.
- If the time on your computer differs from the time on the Financial reporting server, we recommend enabling the Windows option to set your computer's time automatically.

## See also

- [Troubleshoot report designer issues with Event Viewer](troubleshoot-report-designer-with-event-viewer.md)
- ["Unable to Connect to the Financial reporting server" error when connecting to Financial reporting](unable-to-connect-financial-reporting-server.md)
