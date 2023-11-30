---
# required metadata

title: Troubleshoot issues connecting to Financial reporting
description: Provides a resolution for an issue where you can't connect to Financial reporting in Microsoft Dynamics 365 Finance.
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
# "Unable to Connect to the Financial reporting server" error when connecting to Financial reporting

This article provides a resolution for the connection error that occurs when you try to connect to Financial reporting in Microsoft Dynamics 365 Finance.

## Symptoms

When you try to connect to [Financial reporting](/dynamics365/finance/general-ledger/financial-reporting-getting-started), you receive the following error message:

> Unable to Connect to the Financial reporting server

## Resolution

To solve this issue:

- Check if the issue occurs in Google Chrome and Microsoft Edge browsers.
- If the issue occurs only in one browser, it might be an issue with the **ClickOnce** extension.
- When you receive the connection error message, select **Test** to test the connection to see what message appears.
- The issue might be caused by another user not having access to Financial reporting. If a user doesn't have access, they receive a message stating they don't have permission. To resolve the permission issue, see [Issue 2 - The user isn't assigned the required permissions to use Financial reporting](issues-open-report-designer.md#issue-2---the-user-isnt-assigned-the-required-permissions-to-use-financial-reporting).
- If the issue occurs in multiple browsers, make sure the time clock on your workstation is set to **Auto**.
- Work with a user that has security administrator rights in Dynamics 365 Finance, and admin rights to the network domain, to sign in to your workstation to see if they can connect. If they can connect, the issue might be related to network permissions.
- On the workstation, temporarily disable the firewall. If you can then connect to Report Designer, the issue is with your firewall. Work with your organization's IT department to resolve the issue.

## More information

If you need to contact Microsoft Support for help with Financial reporting issues, see [Troubleshoot report designer issues with Event Viewer](troubleshoot-report-designer-with-event-viewer.md).
