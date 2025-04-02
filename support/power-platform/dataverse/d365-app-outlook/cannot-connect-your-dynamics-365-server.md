---
title: Cannot connect to your Dynamics 365 server
description: Provides a solution to an error that occurs when you use Microsoft Dynamics 365 App for Outlook.
ms.reviewer: 
ms.topic: troubleshooting
ms.date: 03/31/2021
ms.custom: sap:Dynamics 365 App for Outlook Add-In
---
# We're unable to connect to your Microsoft Dynamics 365 server Error occurs when using Microsoft Dynamics 365 App for Outlook

This article provides a solution to an error that occurs when you use Microsoft Dynamics 365 App for Outlook.

_Applies to:_ &nbsp; Microsoft Dynamics 365  
_Original KB number:_ &nbsp; 3124910

## Symptoms

When attempting to use the Dynamics 365 App for Outlook, you receive the following message:

> "We're unable to connect to your Microsoft Dynamics 365 server. Please try closing and reopening the app."

## Cause

This error can occur for one of the following reasons:

**Cause 1:** An issue is cached by your web browser.

**Cause 2:** Your Dynamics 365 security role is missing one or more required privileges.

**Cause 3:** The Dynamics 365 App for Outlook doesn't receive a response when requesting a page from the Dynamics 365 server.

## Resolution

**Resolution 1:** Clear your web browser cache.

If you're using Outlook Desktop, Outlook uses Internet Explorer to display the web pages. For more information about how to clear the Internet Explorer history and cache, see [View and delete your browsing history in Internet Explorer](https://support.microsoft.com//topic/view-and-delete-your-browsing-history-in-internet-explorer-098ffe52-5ac9-a449-c296-c735c32c8678).  

> [!IMPORTANT]
> If this error appears to be resolved after clearing your web browser cache but eventually returns, see [Error "We're unable to connect to your Microsoft Dynamics 365 server" when using Dynamics 365 App for Outlook](https://support.microsoft.com/help/4341413) for a potential solution.

**Resolution 2:** Verify your Dynamics 365 security role includes all of the required privileges in [Required privileges for Dynamics 365 App for Outlook](/previous-versions/dynamicscrm-2016/administering-dynamics-365/dn946901(v=crm.8)).

**Resolution 3:** Check to see if your Dynamics 365 (online) organization isn't available or something is blocking communication with Dynamics 365 (online). Verify you can access your Dynamics 365 organization via your web browser. If you can't access your Dynamics 365 organization via your web browser, the Dynamics 365 App for Outlook can't access your organization either. If you're unable to access your Dynamics 365 organization with your web browser, contact your Dynamics 365 administrator.

## More information

For more information about URLs required to access Dynamics 365 (online), see [Troubleshooting: Unblock URLs required for Dynamics 365 (online)](/previous-versions/dynamicscrm-2016/administering-dynamics-365/dn762335(v=crm.8)).
