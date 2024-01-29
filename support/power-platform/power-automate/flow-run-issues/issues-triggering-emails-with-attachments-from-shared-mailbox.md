---
title: Issues triggering emails with attachments from shared mailbox
description: Provides a resolution to solve the issues that might occur when a flow has When a new email arrives in a shared mailbox (V2) trigger.
ms.reviewer: jewelden
ms.date: 03/31/2021
ms.subservice: power-automate-flow-run
---
# Issues triggering emails with attachments from shared mailbox

This article provides a resolution to make sure the flow trigger work as expected for emails with attachments from shared mailbox.

_Applies to:_ &nbsp; Power Automate  
_Original KB number:_ &nbsp; 4563989

## Symptoms

In PowerAutomate, when a flow has **When a new email arrives in a shared mailbox (V2)** trigger, for example, you notice any of the following:

- The flow isn't triggering for all the emails that come into the mailbox.
- The flow isn't triggering for emails with attachments.
- You get a 400 Bad Request or similar error in actions that use the trigger output attachment content bytes.

## Cause

By default, the trigger will have the following attachment-related options set to **No**.  This is because triggering on all mails doesn't miss any (you might want to trigger on emails without attachments too) and attachments can be large in size:

- Only with Attachments
  - If set to **No**, it will trigger on all emails.  If **Yes**, it will trigger on emails with attachments. Use the latter if your flow only needs to trigger on mails with attachments; otherwise, keep it set to **No**.
- Include Attachments
  - If set to **No**, it will not include the attachments content (it will be set to null).
  - For example, if set to **No** and you have a SharePoint **Create File** action that uses the null attachment content, then this will result in **400 Bad Request** errors because the file content would be null, or empty, which is invalid.
  - If set to **Yes**, it will include the attachment content bytes instead of being null and SharePoint **Create File** action, for example, will succeed and the file created will contain the attachment content.

> [!NOTE]
> These are the default option values for the trigger output because attachments can be large in size.

## Resolution

To make the flow trigger also on emails that have attachments and to make the attachment content available to other actions (that is, not to set contentBytes to null), in the trigger card:

1. Expand **Show Advanced Options** by selecting it.
2. Set **hasAttachments** to true.
3. Set **includeAttachments** to true.

See associated screenshots for the above steps:

Expand the Show Advanced Options by selecting it:

:::image type="content" source="media/issues-triggering-emails-with-attachments-from-shared-mailbox/expand-show-advanced-options.png" alt-text="Screenshot to select the Show Advanced Options item to expand it.":::

Set **Include Attachments** to Yes to make the content available to other Power Automate actions.

Set **Only with attachments** to make the flow trigger only on emails with attachments.

:::image type="content" source="media/issues-triggering-emails-with-attachments-from-shared-mailbox/options-for-attachement.png" alt-text="Screenshot shows the options for Include Attachments and Only with attachments.":::
