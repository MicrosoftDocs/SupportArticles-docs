---
title: Line breaks are removed in posts made in plain text format
description: Describes the behavior when line breaks are removed in a plain text format post without any indication in Outlook. You can work around this behavior by disabling the Auto Remove Line Breaks feature. Or you can use HTML or RTF to format the message.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Sending, Receiving, Synchronizing, or viewing email\Message format (HTML, Rich Text, Plain Text)
  - Outlook for Windows
  - CSSTroubleshoot
ms.reviewer: 
appliesto: 
  - Outlook 2019
  - Outlook 2016
  - Outlook 2013
  - Microsoft Outlook 2010
  - Microsoft Office Outlook 2007
  - Microsoft Office Outlook 2003
  - Outlook for Microsoft 365
search.appverid: MET150
ms.date: 01/30/2024
---
# Line breaks are removed in posts made in plain text format in Outlook

_Original KB number:_ &nbsp; 287816

## Symptoms

In Microsoft Outlook, you create a new plain text formatted post containing line breaks. Outlook removes the line breaks and displays the message. However, the posts do not display any indication that this has occurred, other than the change in formatting. The information bar message about extra line breaks does not appear, either in the Preview pane or when you read the post. This processing appears to happen when the message is initially posted.

> [!NOTE]
> E-mail message items display the information bar as expected when the line breaks are removed.

## Cause

By default, the Auto Remove Line Breaks feature in Outlook is enabled. This causes the line breaks to be removed. Any two or more successive line breaks are not removed.

## Workaround

Use one of the following methods to work around this behavior.

> [!NOTE]
> If you edit the existing post and you save the changes before you use one of the following methods, the line breaks are lost and can only be replaced manually.

### Method 1 - Disable the feature that removes extra line breaks

This method disables the feature for all plain text items. To do this, follow these steps:

For Outlook 2010 and later versions:

1. Open Outlook.
2. On the **File** tab, select **Options**.
3. In the **Options** dialog, select **Mail**.
4. In the **Message format** section, clear the **Remove extra line breaks in plain text messages** check box.
5. Select **OK**.

For Outlook 2007 or earlier versions:

1. Open Outlook.
2. On the **Tools** menu, select **Options**.
3. On the **Preferences** tab, select the **E-mail Options** button.
4. Clear the **Remove extra line breaks in plain text messages** check box.
5. Select **OK** two times.

### Method 2 - Use HTML or Rich Text format

You can use HTML or Rich Text formats when you create new items. Or you can change existing posts to these formats.

#### New posts

You can change the format for individual messages, or for all messages. To change the format for all messages, follow these steps:

For Outlook 2010 and later versions:

1. Open Outlook.
2. On the **File** tab, select **Options**.
3. In the **Options** dialog, select **Mail**.
4. In the **Compose messages** section, select either **HTML** or **Rich Text** in the **Compose messages in this format** drop-down list.
5. Select **OK**.

For Outlook 2007 or earlier versions:

1. Open Outlook.
1. On the **Tools** menu, select **Options**.
1. Select the **Mail Format** tab.
1. Select either **HTML** or **Rich Text** in the **Message Format** section.
1. Select **OK**.

When you create a post item, you can change the format for an individual message. To do this, follow these steps:

For Outlook 2010 and later versions:

1. Open Outlook.
2. On the **Home** tab, select **New Items**, and under **More Items** select **Post in This Folder**.
3. On the **Format Text** tab, select **As HTML** or select **As Rich Text** in the **Format** section.

For Outlook 2007 or earlier versions:

1. Open Outlook.
2. On the **File** menu, select **New**, and then select **Post in This Folder**.
3. In Outlook 2007, select **HTML** or select **Rich Text** on the **Options** tab in the **Format** group.

In Outlook 2003, or Outlook 2002, select **Plain Text**, and then select **HTML** or **Rich Text**.

#### Existing posts

- In Outlook 2007, select **Other Actions** after you open the post item on the **Discussion** tab in the **Actions** group. Then, select **Revise Contents** before you change the format.
- In Outlook 2003, or Outlook 2002, open the post item, select **Edit**, and then select **Revise Contents** before you change the format.

### Method 3. Restore the line breaks in Outlook 2003 or Outlook 2002

This method allows you to restore the line breaks that were removed. To do this, follow these steps:

1. Open Outlook.
2. Open the post item.
3. Select **Format**.
4. Clear the Unwrap Text check mark.

> [!NOTE]
> This option is not available in Outlook 2010 or Outlook 2007.
