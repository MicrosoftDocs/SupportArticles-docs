---
title: Unable to Connect to Your Dynamics 365 Server Error
description: Provides a solution to an error that occurs when you use Microsoft Dynamics 365 App for Outlook.
ms.reviewer: 
ms.date: 04/17/2025
ms.custom: sap:Dynamics 365 App for Outlook Add-In
---
# "We're unable to connect to your Microsoft Dynamics 365 server" error when using Dynamics 365 App for Outlook

This article lists possible causes and solutions for issues connecting to Dynamics 365 server when using Dynamics 365 App for Outlook.

_Applies to:_ &nbsp; Microsoft Dynamics 365  
_Original KB number:_ &nbsp; 3124910

## Symptoms

When you try to use Dynamics 365 App for Outlook, you receive the following error message:

> We're unable to connect to your Microsoft Dynamics 365 server. Please try closing and reopening the app.

## Cause 1: Web browser cache

### Resolution

If you're using older versions of Outlook desktop or Windows (prior to Windows 10), App for Outlook uses Internet Explorer to display the web pages. Try clearing the Internet Explorer history and cache by following the steps in [View and delete your browsing history in Internet Explorer](https://support.microsoft.com//topic/view-and-delete-your-browsing-history-in-internet-explorer-098ffe52-5ac9-a449-c296-c735c32c8678).  

> [!IMPORTANT]
> If this error appears to be resolved after clearing your web browser cache but eventually returns, see [Error "We're unable to connect to your Microsoft Dynamics 365 server" when using Dynamics 365 App for Outlook](we-are-unable-to-connect-to-your-dynamics-365-app-for-outlook-error.md) for a potential solution.

## Cause 2: Your Dynamics 365 security role is missing one or more required privileges

### Resolution

Verify your Dynamics 365 security role includes all of the required privileges in [Required privileges for Dynamics 365 App for Outlook](/dynamics365/outlook-app/deploy-dynamics-365-app-for-outlook#step-3-provide-security-role-access).

## Cause 3: Dynamics 365 App for Outlook doesn't receive a response when requesting a page from the Dynamics 365 server

### Resolution

Check to see if your Dynamics 365 organization is unavailable or if something is blocking communication with Dynamics 365. Verify you can access your Dynamics 365 organization via your web browser. If you can't access your Dynamics 365 organization via your web browser, Dynamics 365 App for Outlook can't access your organization either. In this case, consult with your Dynamics 365 administrator to understand what may be blocking communications.

## More information

For more information about URLs required to access Dynamics 365, see [Power Platform URLs and IP address ranges](/power-platform/admin/online-requirements) and[Troubleshooting: Unblock URLs required for Dynamics 365 (online)](/previous-versions/dynamicscrm-2016/administering-dynamics-365/dn762335(v=crm.8)).
