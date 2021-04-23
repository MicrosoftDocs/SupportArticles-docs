---
title: Cannot sign in to Office 365 Services CRM organization 
description: An error occurs on the Microsoft Dynamics CRM 2011 for Outlook client when signing in to an Office 365 CRM organization. Provides a resolution.
ms.reviewer: aaronric
ms.topic: troubleshooting
ms.date: 3/31/2021
---
# The Microsoft Online Services Sign-in Assistant is not installed error when signing in to Office 365 Services CRM organization

This article provides a resolution for the issue that you can't sign in to an Office 365 Services CRM organization due to a **Cannot connect to Microsoft Dynamics CRM server because we cannot authenticate your credentials** error.

_Applies to:_ &nbsp; Microsoft Dynamics CRM 2011  
_Original KB number:_ &nbsp; 2696603

## Symptoms

When you try to sign in to an Office 365 Services CRM organization, you may receive the following error even though the Microsoft Online Services Sign-In Assistant is installed:

> Cannot connect to Microsoft Dynamics CRM server because we cannot authenticate your credentials. Check your connection or contact your admin for more help.

In the log file, the following message will be displayed:

> The Microsoft Online Services Sign-in Assistant is not installed. To download and install the Microsoft Online Services Sign-in Assistant please download it using the following locations: 32-bit: `https://g.microsoftonline.com/0BX00en/500` 64-bit: `https://g.microsoftonline.com/0BX00en/501`

At this point, the sign-in fails.

## Cause

If the organization has been moved from a Microsoft Dynamics CRM Online organization with Update Rollup 6 to an Office 365 Services CRM organization without installing the Office 365 prerequisite package or without reinstalling the Update Rollup 6 slipstream update, this error will occur. This error will also occur if the Microsoft Dynamics CRM for Outlook client has had any updates applied after RTM and then being set up for the Office 365 services CRM organization.

## Resolution

Manually download and install Microsoft Online Services Sign-in Assistant from the following link after installing the Update Rollup 6 patch.

[Microsoft Online Services Sign-In Assistant for IT Professionals RTW](https://www.microsoft.com/download/details.aspx?id=28177)
