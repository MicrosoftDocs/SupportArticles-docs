---
title: How to block message from being sent or received
description: Describes how to block a message from being sent or received in Microsoft 365 based on the file name extension of the attachment.
author: simonxjx
ms.author: v-six
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.prod: exchange-server-it-pro
localization_priority: Normal
ms.custom: 
- Exchange Online
- CSSTroubleshoot
ms.reviewer:
appliesto:
- Exchange Online
search.appverid: MET150
---
# How to block a message from being sent or received based on the file name extension of the attachment in Microsoft 365

_Original KB number:_ &nbsp; 2795329

## Procedure

You can block a message from being sent or received if the file that's attached to the message has an extension that's currently not blocked by Microsoft 365. To do this, create a transport rule by using one of the following methods, as appropriate for your situation.

> [!NOTE]
> The rule doesn't apply to scenarios in which users change the file name extension before they send the message.

To create a transport rule to block messages based on the file name extension of the attachment in Microsoft 365, follow these steps:

1. Sign in to the [Microsoft 365 portal](https://portal.office.com).

2. Select **Admin**, and then select **Exchange**.
3. In the left navigation pane, select **mail flow**, and then select **rules**.
4. Select **New** (![A screen shot of the New icon](./media/how-to-block-message-from-being-sent-or-received/new-icon.jpg)), and then select **Create a new rule**.
5. In the **New Rule** window, select **More options**.
6. In the **Name** box, specify a name for the new rule.
7. Select the ***Apply this rule if** drop-down list, point to **Any attachment,** and then select **File extension includes these words**.

8. In the **Specify words or phrases** window, type the file name extension of any attachment that you want to block, and then select the plus symbol (![A screen shot of the plus symbol ](./media/how-to-block-message-from-being-sent-or-received/plus-symbol.jpg)) to add the file name extension to the list. When the list is completed, select **OK**.

9. Select the ***Do the following** drop-down list, point to **Block the message**, and then select **Reject the message and include an explanation** or select **Delete the message without notifying anyone**.

   If it's required, add a statement to inform users who will receive the non-delivery report (NDR) of the reason that mail delivery failed, and then select **OK**.

10. Specify any additional options such as rule auditing and rule activation or deactivation time, and then select **Save**.

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).
