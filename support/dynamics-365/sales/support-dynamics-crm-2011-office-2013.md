---
title: Support Dynamics CRM 2011 and Office 2013
description: Describes the support with Microsoft Dynamics CRM 2011 and Microsoft Office 2013, and the functional differences between Update Rollup 10 and Update Rollup 11.
ms.reviewer: 
ms.topic: article
ms.date: 3/31/2021
---
# Support with Microsoft Dynamics CRM 2011 and Microsoft Office 2013

This article describes the support with Microsoft Dynamics CRM 2011 and Microsoft Office 2013, and the functional differences between Update Rollup 10 and Update Rollup 11.

_Applies to:_ &nbsp; Microsoft Dynamics CRM 2011  
_Original KB number:_ &nbsp; 2744957

## Summary

Microsoft Dynamics CRM 2011 with Update Rollup 10 and up is compatible with Microsoft Office 2013 for the scenarios described below.

> [!NOTE]
> The Microsoft Dynamics CRM Server must be on at least Update Rollup 6 for support with Microsoft Office 2013. However, it's recommended that both the Microsoft Dynamics CRM Server and CRM for Outlook client are on Update Rollup 10 or higher.

## What is compatible with Update Rollup 10?

- Office 2013 MSI - Basic functional compatibility (some known issues*).
- Office 2013 Click to Run (C2R) (standalone) - Preview of upcoming functional compatibility (some known issues).
- Office 2013 C2R (side by side w/ Office 2010 only) - Use on Test environments only. When your organization is migrated to Office 2013, it will become the default version of Office. Because of it, your Office 2010 CRM instance isn't guaranteed to be fully functional. A list of the main known issues is identified below.
- Windows 8 - Functional compatibility (w/ manual WIF enablement).

## What is compatible with Update Rollup 11?

- Office 2013 MSI - Enhanced compatibility (functional known issues fixed).
- Office 2013 Click to Run (C2R) (standalone) - Functional compatibility at parity with MSI.
- Office 2013 C2R (side by side w/ Office 2010 only) - Preview of upcoming side by side support with Office 2013 for Office 2010. *Client will only work on Office 2013 and will be blocked in Office 2010*.
- Windows 8 - Enhanced compatibility, WIF is automatically enabled in Outlook Client setup.

## More information

Issues that may occur when using Microsoft Dynamics CRM 2011 with Microsoft Office 2013 and Update Rollup 10:

- Any Office side by side (Office 2007 or Office 2010 with Office 2015) scenario where the user is adding/changing/deleting an organization in the configuration wizard might meet some problems. The following are the subset of the main scenarios but be aware that there might be corner cases not seen below:
  - While a user of Office 2013 side by side with Office 2010 creates a new organization, it will only be created for the Office 2013 instance.
  - While a user of Office 2013 side by side with Office 2010 changes an existing organization, it will only be changed for the Office 2013 instance.
  - While a user of Office 2013 side by side with Office 2010 deletes an existing organization, the Office 2010 instance might become corrupted.
  - While a user of Office 2013 side by side with Office 2010 adds a new organization and then makes it the primary org, it may cause some unexpected UI behavior.
- The Office 2013 add-in limiter may block the CRM Outlook add-in.
  - Additional information for the Office 2013 add-in limiter: If the CRM Outlook add-in is blocked, a yellow ribbon will display *ADD-IN PROBLEM A problem was detected with an add-in and it has been disabled.* If a user selects **View Disabled Add-ins**. A Disabled Add-ins window will be displayed. A user must select **Always enable this add-in**.
- On a Windows 8 machine, the user has to manually enable Windows Identity Foundation (WIF) to successfully authenticate. [Unable to configure the Microsoft Dynamics CRM 2011 Outlook client on a Windows 8 computer](https://support.microsoft.com/help/2727137)

Issues that may occur when using Microsoft Dynamics CRM 2011 with Microsoft Office 2013 and Update Rollup 11:

- Side by Side Scenario: Office 2013 side by side preview is limited to Office 2010 and isn't supported yet with other down level Office versions (Office 2007 and 2003). There are known issues that will severely impact use of other down level Office versions when used side by side with Office 2013.
- All Scenarios: The application is still being tuned for overall performance and resource utilization for Windows 8 and Office 2013.
