---
title: Users can't see free/busy information after a mailbox is moved to Microsoft 365
description: Describes an issue in which on-premises users can't see free/busy information for a mailbox that is moved to Microsoft 365. Provides a workaround.
author: cloud-writer
ms.author: meerak
audience: ITPro
ms.topic: troubleshooting
manager: dcscontentpm
ms.custom: 
  - sap:Migration
  - Exchange Online
  - CSSTroubleshoot
search.appverid: 
  - MET150
appliesto: 
  - Exchange Online
ms.date: 01/24/2024
ms.reviewer: v-six
---
# Users can't see free/busy information after a mailbox is moved to Microsoft 365

## Symptoms

After a mailbox is moved to Microsoft 365, an on-premises user can't see the free/busy information for the mailbox in Scheduling Assistant.

:::image type="content" source="./media/cannot-see-free-busy-information/scheduling-assistant-without-data.png" alt-text="Screenshot shows an on-premises user can't see the free/busy information for the mailbox in Scheduling Assistant.":::

Also, the user can no longer view the Calendar folder, and the user receives a "Could not be updated" error.

:::image type="content" source="./media/cannot-see-free-busy-information/calendar-folder-error.png" alt-text="Screenshot shows the user can no longer view the Calendar folder and receives an error.":::

## Cause

The default permissions of the Calendar folder are set to **None** or **Contributor**. When you query free/busy information by using Scheduling Assistant in a cross-forest scenario, the Availability service uses the organization relationship instead of delegated user permissions. Scheduling Assistant makes cross-forest requests on behalf of the organization relationship instead of on behalf of the user who is requesting it. The organization relationship links to the default account that is seen in the calendar permissions. Therefore, it can't process an explicitly granted permission such as "Free/Busy time" or "Free/Busy time, subject, location."

## Workaround

When the default permissions of the Calendar folder are set to **None** or **Contributor**, details can be obtained only when user delegation is used by attaching calendars directly to the calendar view of Outlook. In a hybrid deployment, free/busy and calendar-sharing functionality work differently than when both users are in the same environment. The default permissions determine the kind of free/busy information that users in a remote forest can see. If the default permissions are set to **None** or **Contributor**, no free/busy information is displayed for remote users, and users cannot view the mailbox calendar. This is because neither kind of permission offers any level of free/busy visibility.

:::image type="content" source="./media/cannot-see-free-busy-information/calendar-properties-contributor.png" alt-text="Screenshot shows the default permission level is set to Contributor, without offers any level of free/busy visibility." border="false":::

:::image type="content" source="./media/cannot-see-free-busy-information/calendar-properties-none.png" alt-text="Screenshot shows the default permission level is set to None, without offers any level of free/busy visibility." border="false":::

If a remote user must be able to see free/busy information for the mailbox, the mailbox owner can work around this issue by changing the default permissions to **Free/Busy time** or **Free/Busy time, subject, location**. This changes the free/busy information that is shared for all remote users. For example, the default permissions can be set to **Free/Busy time**:

:::image type="content" source="./media/cannot-see-free-busy-information/calendar-properties-free-busy-time.png" alt-text="Screenshot of changing the default permission level to Free/Busy time." border="false":::

Remote users can see the free/busy data in Scheduling Assistant:

:::image type="content" source="./media/cannot-see-free-busy-information/scheduling-assistant-with-data.png" alt-text="Screenshot shows remote users can see the free/busy data in Scheduling Assistant.":::

Or, remote users can see the free/busy data as an additional calendar:

:::image type="content" source="./media/cannot-see-free-busy-information/additional-calendar-with-data.png" alt-text="Screenshot shows remote users can see the free/busy data as an additional calendar.":::

A remote user can be granted Calendar folder permissions to obtain additional access to the contents of the Calendar folder:

:::image type="content" source="./media/cannot-see-free-busy-information/calendar-properties-reviewer.png" alt-text="Screenshot shows the user permission is set to reviewer, which can read Full Details." border="false":::

> [!NOTE]
> Granting the **Free/Busy time, subject, location (Limited Details)** permission is insufficient in a hybrid environment. The user has to be granted at least **Reviewer** permission to view calendar item details.

The remote user (Test User 1) can now see the mailbox Calendar folder:

:::image type="content" source="./media/cannot-see-free-busy-information/calendar-folder-remote-user.png" alt-text="Screenshot shows the mailbox Calendar folder.":::

## More Information

For more information about cross-forest free/busy configuration, click the following article number to view the article in the Microsoft Knowledge Base:

[3079932](https://support.microsoft.com/help/3079932) Users can see only basic free/busy mailbox information in a remote forest in Microsoft 365

There are some differences with contributor permissions when you set the default calendar permissions or when you explicitly grant a user calendar permission. When the default calendar permissions are set, the **Free/busy setting** uses **None**.

:::image type="content" source="./media/cannot-see-free-busy-information/calendar-properties-contributor-setting.png" alt-text="Screenshot shows the Free/busy setting is set to None when the default calendar permission level is set to Contributor." border="false":::

When a user is granted contributor rights, the permission level will automatically change to **Custom**. This includes **Free/Busy time**.

:::image type="content" source="./media/cannot-see-free-busy-information/calendar-properties-custom.png" alt-text="Screenshot shows the permission level will automatically change to Custom after the user is granted contributor rights, which includes Free/Busy time." border="false":::

This is expected behavior, because users who can create items in a calendar can also see the folder and view free/busy information.
