---
title: Alerts occur when you go offline
description: Provides a solution to an error that occurs when Microsoft Dynamics CRM for Microsoft Office Outlook 2010 is in Offline mode.
ms.reviewer: mmaasjo
ms.topic: troubleshooting
ms.date: 3/31/2021
---
# Intranet Settings Alerts displayed when you go offline in Microsoft Dynamics CRM for Microsoft Office Outlook 2010

This article provides a solution to an error that occurs when Microsoft Dynamics CRM for Microsoft Office Outlook 2010 is in Offline mode.

_Applies to:_ &nbsp; Microsoft Dynamics CRM 2011  
_Original KB number:_ &nbsp; 2507372

## Symptoms

When Microsoft Dynamics CRM for Microsoft Office Outlook 2010 is in Offline mode, the following warning appears:

> "Intranet Settings are now turned off by default. Intranet Settings are less secure than Internet settings. Click for options..."

## Cause

Internet Explorer Security Settings on the Local Intranet Zone aren't set appropriately.

## Resolution

Change the Local Intranet Zone Settings.

1. Open Internet Explorer.
2. Select **Tools**, select the **Security** tab, select **Local Intranet**, and then select **Sites**.
3. Unmark **Automatically detect intranet network**.
4. Mark the following ones:
   - Include all local (intranet sites not listed in other zones)
   - Include all sites that bypass the proxy server
   - Include all network paths (UNCs)
5. Select **OK**, and then select **OK**.
6. Close Outlook and Internet Explorer.
