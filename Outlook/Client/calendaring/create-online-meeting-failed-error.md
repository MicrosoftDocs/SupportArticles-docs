---
title: Create online meeting failed error
description: Describes an issue that triggers an error when you try to create an online meeting in Outlook while you're running Lync 2013 or Lync 2010. This issue involves Group Policy. A resolution is provided.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Outlook for Windows
  - CSSTroubleshoot
ms.reviewer: robevans
appliesto: 
  - Outlook 2013
search.appverid: MET150
ms.date: 10/30/2023
---
# Create online meeting failed error when the Lync add-in is managed by Group Policy

_Original KB number:_ &nbsp; 3046831

## Symptoms

When you try to create an online meeting in Microsoft Outlook while you're running either Lync 2013 or Lync 2010, you receive one of the following error messages.

Outlook 2010

Create online meeting failed. Please make sure that Lync is running and signed-in and try again.

:::image type="content" source="media/create-online-meeting-failed-error/outlook-2010-error.png" alt-text="Screenshot of Outlook 2010 error details." border="false":::

Outlook 2013

Create Lync Meeting failed. Please make sure that Microsoft Lync is running and signed-in and try again.

:::image type="content" source="media/create-online-meeting-failed-error/outlook-2013-error.png" alt-text="Screenshot of Outlook 2013 error details." border="false":::

## Cause

This issue occurs when the following conditions are true:

- You are using the Block all unmanaged add-ins (Outlook) Group Policy setting to manage the list of enabled add-ins.
- **Lync 2013** or **Lync 2010** is one of the enabled add-ins in the list of managed add-ins.
- **Microsoft VBA for Outlook** is not on the list of enabled add-ins in the list of managed add-ins.

## Resolution

To resolve this problem, add the `ProgID` (`Microsoft.VBAAddinForOutlook.1`) for the Microsoft VBA for Outlook add-in to the enabled add-in list of managed add-ins through the Group Policy Editor.

To update an existing policy that's configured to manage add-ins for Outlook, follow these steps:

1. Start the Group Policy Editor.
2. Under **User Configuration**, expand **Administrative Templates** to locate the policy node for your template. When you use the Outlk15.admx template, this node is named Microsoft Outlook 2013.
3. Under **Miscellaneous**, double-click **List of managed add-ins**.

   :::image type="content" source="media/create-online-meeting-failed-error/list-of-managed-add-ins.png" alt-text="Screenshot of the Miscellaneous group policy settings." border="false":::

4. Under **Options**, select **Show**.

   :::image type="content" source="media/create-online-meeting-failed-error/show.png" alt-text="Screenshot of List of managed add-ins setting details window." border="false":::

5. In the **Shows Contents** dialog box, add `Microsoft.VBAAddinForOutlook.1`, and then enter a value of *1*.

   :::image type="content" source="media/create-online-meeting-failed-error/show-contents.png" alt-text="Screenshot of Shows Contents window after you select Show." border="false":::

6. Click **OK** for the rest of the dialog boxes.At this point, the policy setting will be applied on your Outlook client computers when the Group Policy update is replicated.
