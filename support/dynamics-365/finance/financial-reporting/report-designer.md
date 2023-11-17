---
# required metadata

title: Troubleshooting issues opening Report Designer
description: This article describes some common issues that can cause problems when you open Report Designer and how to resolve them.
author: aprilolson
ms.date: 04/04/2023
ms.topic: article
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

# Troubleshooting issues opening Report Designer

There are a few common issues that can cause problems when you open Report Designer. Those issues and the steps to resolve them are as follows.

## Symptom

 Report Designer doesn't start when you select **New** or **Edit**.

## Resolution
* In Internet Explorer, select **Settings**, then select **Internet Options**. Select the **Security** tab. Select Trusted Sites and then select **Sites**. In the **Add this website to zone** field, enter "\*\.dynamics.com" (without quotation marks), and then select **Add**. 
* In Internet Explorer, select **Settings**, then select **Internet Options**. Select the **Security** tab. Select Trusted Sites. In the area labeled Security level for this zone, change the option to **Medium-Low**.
* Disable the pop-up blocker in your browser.
* Workstations are required to install Microsoft .NET Framework 4.7.2 or higher. This version of the Microsoft .NET Framework can be downloaded and installed from the [Microsoft Download Center](https://dotnet.microsoft.com/download/dotnet-framework/net472).
* If you are using a Chrome browser, you must install a ClickOnce extension in order to download the Report Designer client. If you are running Chrome in incognito mode, make sure the ClickOnce extension is enabled for incognito mode. For more information about the Chrome ClickOnce Extension, see [System requirements for cloud deployments](/dynamics365/fin-ops-core/fin-ops/get-started/system-requirements).
* If you are using Microsoft Edge with a Chrome browser, you do not need to install a ClickOnce extension for Edge Chromium. However, you must enable the ClickOnce option in order to download the Report Designer client. If you are running incognito mode, make sure the ClickOnce extension is enabled for incognito mode.

    1. Open a new browser in Microsoft Edge.
    2. Enter **edge://flags** and select **Enter**.
    3. Search for the **ClickOnce Support** option or use this direct link: **edge://flags/#edge-click-once**.
    4. Set the drop-down menu option to **Enabled**.
    5. Select **Restart Browser**.

**Symptom** 
The user hasn't been assigned the required permissions to use Financial reporting. 

**Resolution**
* To verify if the user does not have permission, select **Yes** on the error, "Unable to connect to the Financial reporting server. Select Yes if you want to continue and specify a different server address." Then select **Test Connection**. If you don't have permission, you will see a message that says, "Connection attempt failed. User does not have appropriate permissions to connect to the server. Contact your system administrator."
* Required permissions are listed above in [Granting security access to Financial reporting](/dynamics365/finance/general-ledger/financial-reporting-getting-started#granting-security-access-to-financial-reporting). Security in Financial reporting is based on these privileges. You won't have access unless these privileges (or another security role that includes these privileges) are assigned to you. 
* The **Company Users Provider to Company** integration task (which is also responsible for and known as user integration) runs on a 5-minute interval. It may take up to 10 minutes for any permission changes to take effect in Financial reporting. 

    If another user can open Report Designer, select **Tools**, and then select **Integration Status**. Verify that the integration map, "Company Users Provider to Company," has run successfully because you were assigned permission to use Financial reporting. 

* It may be possible that another error has prevented **Dynamics user to Financial reporting user integration** from finishing. Or it's possible that a datamart reset has been initiated and not yet completed, or that another system error has occurred. Try running the process again later. If the problem persists, contact your system admin.

**Symptom**
You can proceed past the **ClickOnce Report Designer** sign-in page, but are unable to complete sign in within Report Designer. 

**Resolution**
* The time set on your local computer when you enter your login credentials must be within five minutes of the time on the Financial reporting server. If there is a difference of more than five minutes, the system will not allow sign in. 
* If the time on your computer differs from the time on Financial reporting server, we recommend enabling the Windows option to set your computer's time automatically. 
