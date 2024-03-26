---
title: Mailbox declined your meeting because it is recurring error
description: Provides a resolution to make sure you can successfully direct book a meeting with a resource mailbox.
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - CSSTroubleshoot
appliesto:
- Outlook
search.appverid: MET150
ms.reviewer: gregmans, aruiz, v-six
author: cloud-writer
ms.author: meerak
ms.date: 01/30/2024
---
# "\<resource mailbox> declined your meeting because it is recurring" Outlook error when direct booking a resource

## Symptoms

When you schedule a meeting with a resource mailbox that is configured for Direct Booking, you receive one of the following error messages, depending on the version of Outlook that you are using to schedule the meeting:

- Outlook 2010

  > "\<mailbox name>" declined your meeting because it is recurring. You must book each meeting separately with this resource.

  This error message is shown in the following figure:

  :::image type="content" source="media/mailbox-declined-your-meeting-because-recurring-error/direct-booking-recurring-meeting-error-in-outlook-2010.png" alt-text="Screenshot of the error message in Outlook 2010." border="false":::

- Outlook 2007

  > You marked "\<mailbox name>" as a resource. You cannot schedule a meeting with "\<mailbox name>" because you do not have the appropriate permissions for that account. Either enter the name as a required or optional attendee or talk to your administrator about giving you permission to schedule "\<mailbox name>".

  This error is shown in the following figure:

  :::image type="content" source="media/mailbox-declined-your-meeting-because-recurring-error/direct-booking-recurring-meeting-error-in-outlook-2007.png" alt-text="Screenshot of the error message in Outlook 2007." border="false":::

  You receive this error message even though the meeting is a single-instance, non-recurring meeting.

## Cause

This problem occurs when you use Outlook 2010 to configure the resource mailbox for direct booking, and you manually set the Calendar folder's permissions by selecting **Set Permissions** in the **Resource Scheduling** dialog box.

The **Set Permissions** button is shown in the following figure:

:::image type="content" source="media/mailbox-declined-your-meeting-because-recurring-error/resource-scheduling-dialog-set-permissions.png" alt-text="The Set Permissions button." border="false":::

When you select **Set Permissions**, the **Permissions** tab in the **Calendar Properties** dialog box is displayed. Because this is a direct booking resource mailbox, the default permissions should be set to **Author** as shown in the following figure:

:::image type="content" source="media/mailbox-declined-your-meeting-because-recurring-error/permissions-tab-in-calendar-properties.png" alt-text="Screenshot for default Permission Level value in Calendar Properties dialog box." border="false":::

The problem occurs when you select **OK** in the **Calendar Properties** dialog box that is shown here. The permissions to the Calendar folder are correctly set for the Default object. However additional, required permissions to the Freebusy Data folder of the mailbox are not set correctly.

> [!NOTE]
> This problem can also occur if you view the permissions to the Calendar folder of the resource mailbox by right-clicking on the folder and selecting **Properties**. This opens the same **Calendar Properties** dialog box that was displayed earlier. If you select **OK**, you see that the required permissions to the Freebusy Data folder are not configured properly.

If you use Outlook 2007 and you select **OK** in the **Calendar Properties** dialog box, the correct permissions are set on both the Calendar and Freebusy Data folders. Only Outlook 2010 fails to set the required permissions to the Freebusy Data folders when you use the steps that were described earlier in this article.

## Resolution

To resolve this problem, install the [Description of the Outlook 2010 hotfix package (outlook-x-none.msp): February 22, 2011 (KB2475877)](https://support.microsoft.com/topic/description-of-the-outlook-2010-hotfix-package-outlook-x-none-msp-february-22-2011-19bf94eb-aa4d-6f5d-6ec3-59709c0db637).

After installing hotfix KB2475877, use the following steps to correct the permissions on an existing resource mailbox:

1. Start Outlook by using a profile that is configured to open the direct booking resource mailbox.
2. On the **File** tab, select **Options**.
3. In the **Outlook Options** dialog box, select **Calendar**.
4. In the **Resource Scheduling** section, select **Resource Scheduling**.
5. In the **Resource Scheduling** dialog box that is displayed, make sure the **Automatically accept meeting requests and remove canceled meetings** check box is selected.

   > [!NOTE]
   > This check box should already be selected for resource mailboxes that were previously configured for direct booking.

6. Select **Set Permissions** to open the **Calendar Properties** dialog box.
7. Select **OK** three times.

## Workaround

If you are unable to install hotfix KB2475877, you can use the following workaround to manually correct the permissions:

To work around this problem, follow these steps to manually correct the permissions:

1. Start Outlook by using a profile that is configured to open the direct booking resource mailbox.
2. On the **File** tab, select **Options**.
3. In the **Outlook Options** dialog box, select **Calendar**.
4. In the **Resource Scheduling** section, select **Resource Scheduling**.
5. In the **Resource Scheduling** dialog box that is displayed, select the **Ensure that the calendar permissions are set to allow offline updates** check box at the bottom.
6. Select **OK**.

> [!NOTE]
> If the **Ensure that the calendar permissions are set to allow offline updates** option is missing from the **Resource Scheduling** dialog box, follow the following steps to reconfigure the direct booking resource mailbox.

1. Start Outlook by using a profile that is configured to open the direct booking resource mailbox.
2. On the **File** tab, select **Options**.
3. In the **Outlook Options** dialog box, select **Calendar**.
4. In the **Resource Scheduling** section, select **Resource Scheduling**.
5. Clear the **Automatically accept meeting requests and remove canceled meetings** check box.
6. Select **OK**.
7. In the Outlook navigation pane, right-click the Calendar folder, and then select **Properties**.
8. On the **Permissions** tab, configure all entries so that none has permissions higher than Free/Busy time, subject, location. To do this, select the **Permission Level** drop-down list and make sure that each entry is set to either Free/Busy time, subject, location, Free/Busy time or None.
9. Select **OK**.
10. On the **File** menu, select **Options**.
11. In the **Outlook Options** dialog box, select **Calendar**.
12. In the **Resource Scheduling** section, select **Resource Scheduling**.
13. Select the **Automatically accept meeting requests and remove canceled meetings** check box.
14. Select the **Ensure that the calendar permissions are set to allow offline updates** check box.
15. Select **OK** two times.

At this point, the **Default** permissions on the Calendar will be set to **Author**, which is the required level of permissions for Direct Booking.

## More information

To examine the permissions on the **Freebusy Data** folder, follow these steps:

1. Access the resource mailbox by using an Online mode profile with MFCMAPI.
2. Expand **Root Container**.
3. Right-click **Freebusy Data**, and then select **Display ACL table**.
4. Select the **Free Busy Rights Visible** check box, and then select **OK**.
5. Select the item in the top pane, and then double-click the `PR_MEMBER_RIGHTS` property in the lower pane.

The following figure shows incorrectly configured permissions caused by this problem:

:::image type="content" source="media/mailbox-declined-your-meeting-because-recurring-error/pr-member-rights-broken.png" alt-text="Screenshot for incorrectly configured permissions caused by this problem." border="false":::

The following figure shows the correctly configured permissions after you solve the problem by using the steps in the Resolution section of this article:

:::image type="content" source="media/mailbox-declined-your-meeting-because-recurring-error/pr-member-rights-good.png" alt-text="Screenshot for correctly configured permissions after you fix the problem by using the steps in the Resolution section." border="false":::
