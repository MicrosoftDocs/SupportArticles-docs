---
title: Cannot track email after sent and moved to another location
description: You can't track an email in Microsoft Dynamics CRM 2011 for Microsoft Office Outlook when the email is sent and moved to an alternative location other than the Sent Items folder. Provides a resolution.
ms.reviewer: 
ms.topic: troubleshooting
ms.date: 
---
# Cannot track email when it is sent and moved to an alternative location other than the Sent Items folder

This article provides a resolution for the issue that you can't track an email in Microsoft Dynamics CRM 2011 for Microsoft Office Outlook after the email is sent and moved to a separate folder within Outlook other than the Sent Items folder.

_Applies to:_ &nbsp; Microsoft Dynamics CRM 2011  
_Original KB number:_ &nbsp; 2692477

## Symptoms

Consider this scenario:

With the Outlook client for Microsoft Dynamics CRM 2011, you create a new email. During the email creation, after selecting the recipient and filling in the subject and body, you select to *Track* the email in Microsoft Dynamics CRM 2011. Before sending the email, you select the **Options** tab and the drop-down to **Save Sent Item To**, and save the email in a separate folder within Outlook other than the Sent Items folder.

The result is the email is marked as tracked in the Outlook client for Microsoft Dynamics CRM 2011, but an error occurs when selecting the option to **View in CRM**:

> Record Is Unavailable
>
> The requested record was not found or you do not have sufficient permissions to view it.

## Cause

The tracked email message was saved in an alternative folder than the Sent Items folder within Outlook. During the process to track email messages in Microsoft Dynamics CRM 2011, the email message is not recorded until after it is sent. If the tracked email is not present in the sent items folder, it will not be recorded within Microsoft Dynamics CRM 2011.

## Resolution

To fix this issue, follow these steps:

1. Do not select to **Save Sent Item To** in the options of the email, and enable the sent email to be saved in the Sent Items folder within Outlook. Instead, use the Search Folders feature within Outlook to organize email messages. For more information, see [Use Search Folders to find messages or other Outlook items](https://support.microsoft.com/office/use-search-folders-to-find-messages-or-other-outlook-items-c1807038-01e4-475e-8869-0ccab0a56dc5)

2. If you have to save the sent email in a folder other than the default Sent Items folder within Outlook, create an Outlook rule to save a copy of the email in the Sent Items folder. Here are the steps to create a rule within Outlook to recognize the tracking token for Microsoft Dynamics CRM 2011 on an email and save a copy in the Sent Items folder.

    1. Within Outlook, select **File** > **Manage Rules and Alerts** > **New Rule**.
    2. Select to **Apply rule on messages I send** under the start from a blank rule section.
    3. Select **Next** and check the box next to **with specific words in the subject**, select the **specific words** thumbnail.
    4. Fill in the **Search Text** box by using words or phrases that will match the tracking token being used in Microsoft Dynamics CRM 2011. For example: *CRM:* and select **OK**.
    5. Select **Next**, check the **move a copy to the specified folder** box, select the underlined **specified** to select a folder.
    6. Select the Sent Items folder, select **OK**. Check the **stop processing more rules** box, select **Next** > **Next**, make sure **Turn on this rule** is checked, and then select **Finish**.
