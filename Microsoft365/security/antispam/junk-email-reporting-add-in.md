---
title: The Junk Email Reporting Add-in doesn't appear in Outlook
description: Describes an issue in which the Junk Email Reporting Add-in doesn't appear in Outlook. Provides a resolution.
author: simonxjx
ms.author: v-six
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.prod: office 365
localization_priority: Normal
ms.custom: 
  - CSSTroubleshoot
ms.reviewer: rorylen
appliesto: 
- Exchange Online
- Exchange Online Protection
- Outlook 2013
- Microsoft Outlook 2010
- Microsoft Office Outlook 2007
search.appverid: MET150
---

# The Junk Email Reporting Add-in doesn't appear in Outlook

[!INCLUDE [Branding name note](../../../includes/branding-name-note.md)]

_Original KB number:_&nbsp;2604282

## Problem

The Microsoft Junk Email Reporting Add-in for Microsoft Office Outlook is installed on the computer. However, the add-in doesn't appear in Outlook.

## Cause

This issue may occur if a conflict with a plug-in or an add-in causes the Junk Email Reporting Add-in to become disabled.

## Solution

To resolve this issue, make sure that the Junk Email Reporting Add-in is enabled. To do this, use one of the following procedures, depending on your version of Outlook.

### Outlook 2013 and Outlook 2010

1. On the **File** menu, click **Option**, and then click **Add-In**.
1. In the **Manage** list box, make sure that **COM Add-in** is selected, and then click **Go**.
1. Click to select the **Microsoft Junk E-mail Reporting Add-in** check box.
1. Click **OK**.
1. Restart Outlook.

### Outlook 2007

1. On the **Help** menu, click **Disabled Item**.
1. Select **Junk E-mail Reporting Add-in**.
1. Click **Enable**.
1. Restart Outlook.

## More information

For more information about how to install or uninstall the Junk Email Reporting Add-in for Microsoft Office Outlook, see [Install and Uninstall the Junk Email Reporting Add-in for Microsoft Office Outlook](/microsoft-365/security/office-365-security/enable-the-report-message-add-in).

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).