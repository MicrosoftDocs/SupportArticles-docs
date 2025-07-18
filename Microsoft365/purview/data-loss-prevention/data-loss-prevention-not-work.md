---
title: Changes to a data loss prevention policy don't take effect in Outlook 2013 in Microsoft 365
description: Describes an issue in which policy tips aren't displayed correctly and messages aren't appropriately blocked by the policy. Provides a workaround.
author: Cloud-Writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Data loss prevention (DLP)
  - CSSTroubleshoot
appliesto: 
  - Exchange Online
  - Exchange Online Protection
search.appverid: MET150
ms.date: 05/05/2025
---

# Changes to a data loss prevention policy don't take effect in Outlook 2013 in Microsoft 365

_Original KB number:_&nbsp;2823261

## Problem

After you make a change to a data loss prevention (DLP) policy, the change doesn't take effect in Microsoft Outlook 2013 in Microsoft 365. For example, you experience one or more of the following symptoms:

- Policy tips aren't displayed correctly when the conditions in the DLP policy are met.
- Messages aren't appropriately blocked by the DLP policy.

You experience these symptoms even though the DLP policies were working correctly before the change was made.

## Cause

This problem occurs if the updated DLP policy wasn't downloaded to Outlook 2013. Outlook 2013 checks for changes to DLP policies one time every 24 hours.

## Workaround

> [!IMPORTANT]
> This section contains steps that tell you how to modify the registry. However, serious problems might occur if you modify the registry incorrectly. Therefore, make sure that you follow these steps carefully. For added protection, back up the registry before you modify it. Then, you can restore the registry if a problem occurs. For more information about how to back up and restore the registry, see the following Microsoft Knowledge Base article:
>
> [322756](https://support.microsoft.com/help/322756) How to back up and restore the registry in Windows

To work around this issue, force Outlook 2013 to download the updated DLP policies. To do this, follow these steps:

1. Use Registry Editor to remove existing DLP policies that are applied to Outlook 2013. To do this, follow these steps:
   1. Exit Outlook 2013.
   1. Click **Start**, click **Run**, type regedit, and then click **OK**.
   1. In Registry Editor, locate the following subkey:

      `HKEY_CURRENT_USER\SOFTWARE\Microsoft\Office\15.0\Outlook\PolicyNudges`

   1. Delete the LastDownloadTimesPerAccount registry entry.
   1. . Exit Registry Editor.

2. Start Outlook 2013, create a new message, and then type some text. When you do this, you force Outlook 2013 to download DLP policies.

Did this fix the problem?

- Check whether the problem is fixed.
  - If the problem is fixed, you are finished with these steps.
  - If the problem is not fixed, visit [Microsoft Community](https://answers.microsoft.com/) or [contact support](https://support.microsoft.com/contactus/).

## More information

For more information about DLP features in Exchange Online Protection, go to the following Microsoft TechNet website:

> [Data Loss Prevention](/Exchange/policy-and-compliance/data-loss-prevention/data-loss-prevention)

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).
