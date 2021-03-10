---
title: Personal Options revert to only the online options
description: Microsoft Dynamics CRM client for Outlook Personal Options unexpectedly revert to only the online Personal Options. Provides a resolution.
ms.reviewer: 
ms.topic: troubleshooting
ms.date: 
---
# Microsoft Dynamics CRM client for Outlook Personal Options unexpectedly revert to only the online Personal Options

This article provides a resolution for the issue that the Personal Options unexpectedly revert to only the online options in Microsoft Dynamics CRM client for Microsoft Office Outlook.

_Applies to:_ &nbsp; Microsoft Dynamics CRM 2011  
_Original KB number:_ &nbsp; 2494048

## Symptoms

When using the Microsoft Dynamics CRM client for Outlook, the Personal Options unexpectedly revert to only the online options, which do not have all the choices of the Outlook client options.

## Cause

The information that instructs the Personal Options page to display the Outlook setting is stored in a client side Internet Explorer cookie. Under normal usage, the cookie is created when Outlook with a Microsoft Dynamics CRM client is opened and deleted when Outlook is closed, which results in Microsoft Dynamics CRM Outlook Personal Options only being displayed when Outlook is open. If the cookie is not present when the Microsoft Dynamics CRM Outlook client Personal Option page is open, then it will display only the Online options.

## Resolution

1. Configure Internet Explorer Options to not **Delete browsing history on exit**.

    1. Open Internet Explorer options and choose the **General** tab.
    2. Uncheck **Delete browsing history on exit** and select **OK**.

2. Avoid deleting Internet Explorer browsing history when the Microsoft Dynamics CRM client for Outlook is open.
3. Closing and reopening the Outlook client will re-create the Microsoft Dynamics CRM cookie and resolve the issue.
