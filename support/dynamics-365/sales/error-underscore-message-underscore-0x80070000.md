---
title: Error_Message_0x80070000
description: Provides a solution to an error that occurs when using Microsoft Dynamics 365 App for Outlook.
ms.reviewer: 
ms.topic: troubleshooting
ms.date: 
---
# Error_Message_0x80070000 when using Microsoft Dynamics 365 App for Outlook

This article provides a solution to an error that occurs when using Microsoft Dynamics 365 App for Outlook.

_Applies to:_ &nbsp; Microsoft Dynamics CRM  
_Original KB number:_ &nbsp; 4021075

## Symptoms

When attempting to use the Dynamics 365 App for Outlook, you receive the following message:

> "We're sorry  
Sorry, something went wrong. Please try again, or restart the application.  
Error code: Error_Message_0x80070000"  

## Cause

### Cause 1

Your Dynamics 365 security role is missing one or more required privileges.

### Cause 2

An issue is cached by your web browser.

### Cause 3

The Dynamics 365 App for Outlook doesn't receive a response when requesting a page from the Dynamics 365 server.  

## Resolution

### Resolution 1

Verify your Dynamics 365 security role includes all of the required privileges in [Deploy Dynamics 365 App for Outlook](/previous-versions/dynamicscrm-2016/administering-dynamics-365/dn946901(v=crm.8))

### Resolution 2

Clear your web browser cache. For more information about how to clear the Internet Explorer history and cache, see [View and delete your browsing history in Internet Explorer](https://support.microsoft.com/topic/view-and-delete-your-browsing-history-in-internet-explorer-098ffe52-5ac9-a449-c296-c735c32c8678).

### Resolution 3

Check to see if your Dynamics 365 (online) organization isn't available or something is blocking communication with Dynamics 365 (online). Verify you can access your Dynamics 365 organization via your web browser. If you can't access your Dynamics 365 organization via your web browser, the Dynamics 365 App for Outlook won't be able to access your organization either. If you're unable to access your Dynamics 365 organization with your web browser, contact your Dynamics 365 administrator.
