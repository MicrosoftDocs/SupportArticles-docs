---
title: How to troubleshoot data loss prevention policy tips in Exchange Online Protection in Microsoft 365
description: Provides guidance about troubleshooting data loss prevention (DLP) policy tips in Exchange Online Protection in Microsoft 365.
author: helenclu
ms.author: luche
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - CSSTroubleshoot
ms.reviewer: sathyana, camlat
appliesto: 
  - Exchange Online
  - Exchange Online Protection
  - Office Professional Plus 2013
  - Microsoft 365 Apps for enterprise
search.appverid: MET150
ms.date: 03/31/2022
---
# How to troubleshoot data loss prevention policy tips in Exchange Online Protection in Microsoft 365

_Original KB number:_&nbsp;2823263

## Problem

Assume that you create or change a data loss prevention (DLP) policy in Microsoft Exchange Online Protection in Microsoft 365 policy. This policy notifies users when an email message that they create in Microsoft Outlook 2013 contains sensitive information. However, when a user creates an email message that contains sensitive information, the policy tips aren't displayed as expected.

## Solution

The following table contains possible causes and resolutions for this issue. Use the resolution that's appropriate for your situation.

|Cause|Resolution|
|---|---|
|The full Microsoft Office 2013 Professional Plus suite isn't installed on the computer. Outlook 2013 relies on components from other programs in Office 2013. Policy tips don't work if you install Outlook 2013 separately.</br> **NOTE** Policy tips aren't supported in Office 2010 or earlier versions of Office.|Install the full Office 2013 Professional Plus suite. For more information about features and business benefits of Office Professional Plus 2013, go to the following Microsoft website: </br>[https://office.microsoft.com](https://office.microsoft.com/) |
|Outlook 2013 isn't set up to use policy tips.|Make sure that policy tips are enabled in Outlook 2013. To do this, follow these steps: </br>1. In Outlook 2013, click the **File** tab, click **Options**, and then click **Mail**.</br>2. Scroll to the **MailTips** section, and then click the **MailTips Options** button.</br>3. In the **Select MailTips to be displayed selection** dialog box, make sure that the **Policy tip notification** option is selected.</br>4. Click **OK** two times to close the File window.</br>5. Restart Outlook 2013.|
|The DLP policy doesn't have policy tips enabled.|In the properties of the DLP policy in Exchange Online Protection, under **Choose a mode for the requirements in this DLP policy,** make sure that either the **Enforce** or **Test DLP policy either Policy Tips** option is selected.|
|Sensitive data threshold for the DLP policy isn't met. Therefore, the associated DLP policy tips aren't displayed.|Modify the conditions of the applicable DLP policy by using the steps in [Manage DLP Policies](/microsoft-365/compliance/dlp-learn-about-dlp). For example, you may have to adjust the minimum or maximum sensitive item count values or adjust the kind of sensitive data that triggers the policy.|

> [!NOTE]
> Outlook 2013 doesn't support all the sensitive information types that are listed in
 [Sensitive information types inventory](/Exchange/what-the-sensitive-information-types-in-exchange-look-for-exchange-2013-help).

## More information

For an example of a DLP policy that's applied successfully, see the following screenshot:

:::image type="content" source="media/data-loss-prevention-tips/dlp-example.png" alt-text="Screenshot of an email message, showing a D L P policy that is applied successfully.":::

> [!NOTE]
> Only valid credit card number formats will trigger the rule.

For more information about DLP features in Exchange Online Protection, go to the following TechNet website:

[Data loss prevention](/Exchange/policy-and-compliance/data-loss-prevention/data-loss-prevention)

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).
