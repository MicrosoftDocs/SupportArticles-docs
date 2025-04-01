---
title: Cannot Connect To Your Dynamics 365 Server Error
description: Provides a solution to an error that occurs when you use Microsoft Dynamics 365 App for Outlook.
ms.reviewer: 
ms.date: 03/31/2021
ms.custom: sap:Dynamics 365 App for Outlook Add-In
---
# "We're unable to connect to your Microsoft Dynamics 365 server" error when using Dynamics 365 App for Outlook

This article provides a solution to an error that occurs when you use Microsoft Dynamics 365 App for Outlook.

_Applies to:_ &nbsp; Microsoft Dynamics 365  
_Original KB number:_ &nbsp; 3124910

## Symptoms

When you try to use the Dynamics 365 App for Outlook, you receive the following error message:

> We're unable to connect to your Microsoft Dynamics 365 server. Please try closing and reopening the app.

## Cause 1: An issue is cached by your web browser

### Resolution

If you're using Outlook desktop, Outlook uses Internet Explorer to display the web pages. For more information about how to clear the Internet Explorer history and cache, see [View and delete your browsing history in Internet Explorer](https://support.microsoft.com//topic/view-and-delete-your-browsing-history-in-internet-explorer-098ffe52-5ac9-a449-c296-c735c32c8678).  

> [!IMPORTANT]
> If this error appears to be resolved after clearing your web browser cache but eventually returns, see [Error "We're unable to connect to your Microsoft Dynamics 365 server" when using Dynamics 365 App for Outlook](we-are-unable-to-connect-to-your-dynamics-365-app-for-outlook-error.md) for a potential solution.

## Cause 2: Your Dynamics 365 security role is missing one or more required privileges

### Resolution

Verify your Dynamics 365 security role includes all of the required privileges in [Required privileges for Dynamics 365 App for Outlook](/previous-versions/dynamicscrm-2016/administering-dynamics-365/dn946901(v=crm.8)#required-privileges).

## Cause 3: The Dynamics 365 App for Outlook doesn't receive a response when requesting a page from the Dynamics 365 server

### Resolution

Check to see if your Dynamics 365 organization isn't available or something is blocking communication with Dynamics 365. Verify you can access your Dynamics 365 organization via your web browser. If you can't access your Dynamics 365 organization via your web browser, the Dynamics 365 App for Outlook can't access your organization either. If you're unable to access your Dynamics 365 organization with your web browser, contact your Dynamics 365 administrator.

## More information

For more information about URLs required to access Dynamics 365, see [Troubleshooting: Unblock URLs required for Dynamics 365 (online)](/previous-versions/dynamicscrm-2016/administering-dynamics-365/dn762335(v=crm.8)).
