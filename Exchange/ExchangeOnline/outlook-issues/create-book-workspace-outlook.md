---
title: How to create and book a workspace
description: Gives an introduction about workspace and describes how to create and book a workspace in Outlook.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Exchange Online
  - CI
  - CSSTroubleshoot
ms.reviewer: meerak, joew, gbratton, v-lianna
appliesto: 
  - Exchange Online
  - Outlook for Android
  - Outlook for iOS
  - Outlook for Microsoft 365 for Mac
  - Outlook for Microsoft 365
  - Outlook on the web
search.appverid: MET150
ms.date: 01/24/2024
---

# Create and book a workspace in Outlook

## Defining the workspace

A workspace is a physical location where employees can work. It can be consist of a single desk, a single cube, or multiple desks, depending on the available capacity.

In this case, capacity refers to the total number of people who can work in the workspace at the same time. For example, if a workspace that has 10 desks is booked to 50 percent capacity for a specific period, only five more people can book the workspace for that period. If they do, the workspace will become unavailable to other users. If an 11th person tries to book the workspace, the request will be declined.

## Advantages of a workspace

Administrators can enable users to book desks, cubes, or other workspace types in a quick and simple process. The resources of each workspace can be managed as a conference room.

A workspace can be reserved multiple times by different users at the same time up to a defined capacity. However, rooms can be reserved only one time at a specific time. Like rooms, administrators can add workspaces to room lists, add `Set-Place` tags, and make `Set-CalendarProcessing` settings.

## How to create a workspace

Creating a workspace is similar to configuring a room. The difference is that you set the resource mailbox type to `Workspace` instead of `Room`. Additionally, you set `EnforceCapacity` to `True`. Here are the steps to create a workspace:

1. Create a mailbox as a workspace by using the `New-Mailbox` cmdlet:

    ```powershell
    New-Mailbox -Room <alias> | Set-Mailbox -Type Workspace
    ```

2. Add required metadata (such as Capacity, Street, or City) by using the [Set-Place](/powershell/module/exchange/set-place) cmdlet.

    **Note**:  
    In hybrid environments, this cmdlet doesn't work on the following properties of synchronized room mailboxes: **City**, **CountryOrRegion**, **GeoCoordinates**, **Phone**, **PostalCode**, **State**, and **Street**. To modify these properties, use the `Set-User` or `Set-Mailbox` cmdlet in Exchange Server (on-premises).
3. To show a workspace in a particular building, add the workspace to an appropriate room list (distribution group):

    ```powershell
    Add-DistributionGroupMember -Identity "Building 32" -Member <wkspace3223@contoso.com>  
    ```

4. Enforce the workspace capacity, and specify a minimum reservation duration for workspace booking.

    ```powershell
   Set-CalendarProcessing  -Identity <alias> -EnforceCapacity $True -MinimumDurationInMinutes <int32>  
    ```

**Notes**:

- Distribution groups or lists can't be added to the booking request. Only individual users can be added. Workspace bookings will count the attendees on the request based on the capacity.
- It can take up to 24 hours for workspaces and new room lists to appear in the room finder.
- You can now [add floor plans](/microsoftsearch/manage-floorplans) to your workspaces by using Microsoft Search in Outlook for iOS and Android.

## How to book a workspace

Booking a workspace is the same as booking a room. You can book a workspace through Outlook (Outlook for Windows, Outlook for iOS and Android, Outlook on the web, and Outlook for Mac). The key difference is to choose "workspace" instead of "conference room" in the **Room Finder Type** drop-down list.

**Note**:  
Policies that apply for a room can also apply for a workspace. However, workspaces can be booked by multiple people simultaneously based on a set capacity. Workspaces have a minimum booking duration requirement.

Here are the steps to book a workspace:

1. Open the Outlook calendar, and select **New Meeting** (we recommend that you use the **All day** setting).
2. Set the **Show as:** status to **Free** so that the workspace booking doesn't block your calendar.
3. On the **Room Finder** panel, select a building from the **Building** drop-down list, and then select **Workspaces** from the **Type** drop-down list, as follows:

    **Notes**:
    - If you don't see the **Type** list or the **Workspaces** option, the **Building** (room list) might not include workspaces.
    - The **Building** list is populated based on room lists instead of the **Building** attribute.

    **Screenshot examples**

    In Outlook for Windows:

    :::image type="content" source="media/create-book-workspace-outlook/workspace-outlook-for-windows.png" alt-text="Screenshot of workspace in Outlook for Windows.":::

    In Outlook on the web:

    :::image type="content" source="media/create-book-workspace-outlook/workspace-outlook-on-the-web.png" alt-text="Screenshot of workspace in Outlook on the web.":::

    In Outlook for iOS and Android:

    :::image type="content" source="media/create-book-workspace-outlook/workspace-outlook-ios-android.png" alt-text="Screenshot of workspace in Outlook for iOS and Android.":::
  
    **Note**:  
    Make sure that the workspace booking is enabled in the calendar settings.

4. Browse through the available workspaces. Availability is shown based on whether there is available workspace for the duration.

    Additionally, you can find workspaces in the location suggestions and the address book. This is because workspaces are resource mailboxes.
5. Save the workspace booking. You will receive an autogenerated email message about the booking that resembles the following.

    :::image type="content" source="media/create-book-workspace-outlook/workspace-booking-confirmation.png" alt-text="Screenshot of an autogenerated email about the booking.":::

**Note**:  
You can add more attendees to a workspace booking and reserve seats for them based on the capacity of a workspace. If the number of attendees exceeds the workspace capacity, the workspace booking will be rejected.

## Frequently asked questions

**Q1: Can administrators restrict who can book a workspace?**

**A1:** Yes. Administrators can restrict who can book a workspace in the same way that an administrator can restrict who can [book a room](/exchange/recipients/room-mailboxes).

**Q2: Can administrators configure the minimum reservation duration for booking a workspace?**

**A2:** Yes. Administrators can set the minimum reservation duration for a workspace booking by using the `-MinimumDurationInMinutes` parameter.

**Q3: Can workspaces be reserved in a recurring meeting?**

**A3:** Yes. Workspaces can be reserved in a recurring meeting series in the same manner as rooms. Administrators can also limit how far in advance a workspace can be reserved. For more information, see [Create and manage room mailboxes](/exchange/recipients/room-mailboxes).

**Q4: Can users see the availability and remaining capacity in workspaces?**

**A4:** No. Currently, workspaces show only the total capacity of the workspace.

**Q5: What types of reporting metrics are available for workspaces?**

**A5:** Currently, no workspace reporting metrics are publicly available.

## References

- [Book a workspace in Outlook](https://techcommunity.microsoft.com/t5/exchange-team-blog/book-a-workspace-in-outlook/ba-p/1524560)
- [How to configure the new Room Finder in Outlook](https://techcommunity.microsoft.com/t5/exchange-team-blog/how-to-configure-the-new-room-finder-in-outlook/ba-p/1394162)
- [Create and manage room mailboxes](/exchange/recipients/room-mailboxes)
- [Manage floor plans](/microsoftsearch/manage-floorplans)
