---
title: Configure rooms and workspaces for Room Finder
description: Describes common tasks to configure rooms and workspaces for Room Finder in Outlook.
author: MaryQiu1987
ms.author: v-maqiu
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - CI 156476
  - Outlook for Windows
  - CSSTroubleshoot
ms.reviewer: Joew, alexaca, tylewis
appliesto: 
  - Exchange Online
  - Outlook for Windows
  - Outlook for Office 365
  - Outlook on the web
  - Outlook for Mac
  - Outlook for iOS
  - Outlook for Android
search.appverid: MET150
ms.date: 6/6/2022
---

# Configure rooms and workspaces for Room Finder in Outlook

> [!NOTE]
> This article is for Exchange administrators and Microsoft 365 administrators only. For information on how to use Room Finder to reserve meeting rooms and workspaces, see [Use the Scheduling Assistant and Room Finder for meetings in Outlook](https://support.microsoft.com/office/use-the-scheduling-assistant-and-room-finder-for-meetings-in-outlook-2e00ac07-cef1-47c8-9b99-77372434d3fa).  

Room Finder is a web-based feature that you can set up for your users to find available [meeting rooms](https://support.microsoft.com/office/use-the-scheduling-assistant-and-room-finder-for-meetings-in-outlook-2e00ac07-cef1-47c8-9b99-77372434d3fa) and [workspaces](/exchange/troubleshoot/outlook-issues/create-book-workspace-outlook) that are suitable for their use. Every meeting room and workspace must be set up in Exchange Online so that it displays in Room Finder. Each of these spaces is configured with a room mailbox or a workspace mailbox respectively both of which are a specific type of resource mailbox. To reserve these spaces, users need to include the associated mailbox in their meeting request.

Because rooms and workspaces are physical locations, and there can be multiple such spaces in a building, it's best to organize them into logical groups called room lists to manage them easily in Room Finder.

Each room list is a specially designated distribution group, and its members are the resource mailboxes for each room and workspace that's part of the list. While there is no hard limit for the number of rooms and workspaces that can be added to a room list, the maximum number of rooms and workspaces that can be returned in a search on Room Finder is 100. To ensure optimal performance, it's best for each room list to have a maximum of 50 room mailboxes and workspace mailboxes.

Room lists can be organized by:

- Buildings
- Floor ranges within a building
- Wings within a building
- Similar rooms within a building

## Set up properties for rooms and workspaces

One of the significant advantages of using Room Finder is that you can browse for rooms and workspaces by city, and room list. Then you can further refine those results by filtering by the facilities that these spaces provide such as conferencing devices, accessibility features etc.

> [!IMPORTANT]
> For Room Finder to work effectively, it's important to configure the **City** property. The other properties can be configured as appropriate for each room and workspace.

After you set the **City** property for all the rooms and workspaces, you'll be able to browse room lists by a specific city in Room Finder. However, it's important that each room list includes rooms and workspaces from the same city only.  

If the rooms and workspaces in a room list are from different cities, then the room list will display in the results only when you filter by the city in which the maximum number of its rooms and workspaces are located. For example, if a room list includes Room1 in City A, Room2 in City A, and Room 3 in City B, the room list will display only when you filter for rooms in City A.

Room Finder displays room lists as the values for the **Building** filter. It doesn't use the **Building** property that might be specified for rooms and workspaces. Room lists help to support backward compatibility for existing room lists. To ensure forward compatibility, we recommend that you populate the **Building** property when configuring rooms and workspaces.

Next, to add information about features in the rooms and workspaces that are specific to your organization such as coffee machine and bean bags, use the **Tags** property. The tags that you define will display in the drop-down menu for the **Features** filter in Room Finder.

**Note:** It will take 24 to 48 hours for these settings to take effect after you either configure or modify them.  

### List of tasks to set up rooms and workspaces

To set up rooms and workspaces correctly, you must complete the following tasks:

1. Set up rooms and [create room mailboxes](/exchange/recipients/room-mailboxes#create-a-room-mailbox) and [workspace mailboxes](/exchange/troubleshoot/outlook-issues/create-book-workspace-outlook#how-to-create-a-workspace) as appropriate.

   If you need to set up room mailboxes in a hybrid environment, see the [More information](#more-information) section.

1. Configure properties such as **City**, **State** and **Capacity** for the rooms and workspaces.
1. [Create room lists and add rooms and workspaces to them](/exchange/recipients/room-mailboxes#create-a-room-list).  

For example, consider that for an organization that uses *contoso.com* as the domain, you need to set up meeting rooms and workspaces in Building A. This building is located in the city of Seattle that is in the state of Washington. If Building A has a total of 50 rooms and workspaces across three floors, here are the tasks you will need to complete so that your users can find these spaces in Room Finder.

1. Create a room mailbox for each meeting room and set "Seattle" as the value for the **City** property, "Washington" as the **State** property, and a room capacity value for the **Capacity** property. If room1 has a capacity of 5, run the following cmdlets:

    ```powershell
    New-Mailbox -Organization contoso.com -Name room1 -DisplayName "Conference Room 1" -Room
    
    Set-Place room1@contoso.com -State "Washington" -City "Seattle" -Capacity 5
    ```

1. Create a workspace mailbox for each workspace in the building and set "Seattle" as the value for the **City** property, "Washington" as the **State** property, a workspace capacity value for the **Capacity** property. If workspace1 has a capacity of 5, run the following cmdlets:

    ```powershell
    New-Mailbox -Organization contoso.com -Name workspace1 -DisplayName "Workspace 1" -Room | Set-Mailbox -Type Workspace 
    
    Set-Place workspace1@contoso.com -State "Washington" -City Seattle -Capacity 5
    ```

    Also, you can set up automatic workspace capacity evaluation by running the following cmdlet:

    ```powershell
    Set-CalendarProcessing workspace1@contoso.com -EnforceCapacity $true
    ```

1. Select one of the following options:

    - Create one room list with a name such as Building A and add all the 50 rooms and workspaces to it. To create the room list and add room1 to it, run the following cmdlets:

        ```powershell
        New-DistributionGroup -Organization contoso.com -Name "Building A" -RoomList -ManagedBy admin@contoso.com
        
        Add-DistributionGroupMember -Identity BuildingA@contoso.com -Member room1@contoso.com
        ```

    - Create a different room list for each floor of the building such as Building A-Floor 1 and add all the rooms and workspaces on each floor to the corresponding room list.

        ```powershell
        New-DistributionGroup -Organization contoso.com -Name "Building A-Floor 1" -RoomList -ManagedBy admin@contoso.com
        
        Add-DistributionGroupMember -Identity BuildingA-Floor1@contoso.com -Member room1@contoso.com
        ```

For the room named room1:  
The primary SMTP address is room1@contoso.com.  
The displayed name in Room Finder is Conference Room 1.  

For the room list named Building A:  
The primary SMTP address is BuildingA@contoso.com.  
The displayed name in Room Finder is Building A.  

For the room list named Building A-Floor 1:  
The primary SMTP address is BuildingAFloor1@contoso.com.  
The displayed name in Room Finder will be Building A-Floor 1.

## Verify the properties for rooms and workspaces

If a room or workspace that's configured doesn't display in the results in Room Finder, verify that it's configured properly.

Run the following cmdlets on the room list that the room mailbox or workspace mailbox belongs to:

```powershell
$FormatEnumerationLimit=-1
Get-DistributionGroup -Identity "BuildingA@contoso.com"
Get-DistributionGroupMember -Identity "BuildingA@contoso.com"
$members=Get-DistributionGroupMember -Identity "BuildingA@contoso.com" | select Name $members | % {Get-Place -Identity $_.Name | fl}
```

If you see the following results in the output from these cmdlets, then the room or workplace is set up correctly:

- For all the rooms and workspaces, the part of their SMTP address after the @ character is identical to the SMTP address listed for the room list in the **Localities** property.

- All the rooms and workspaces have the same value for the **City** property.

  :::image type="content" source="media/configure-room-finder-rooms-workspaces/get-place-cmdlet.png" alt-text="Screenshot of the command output. The information after the @ character in Identity and Localities and the City information are highlighted.":::

If you don't see these results for all the rooms and workspaces, then re-configure the properties only for the rooms and workspaces that don't have the same results as the others.

## Find rooms and workspaces

After the properties for the rooms and workspaces are configured correctly, and grouped into room lists, users can see them in the following Outlook clients:

- Outlook for Windows
- Outlook on the web
- Outlook for Mac
- Outlook for iOS
- Outlook for Android

For information about how to use Room Finder in these clients, see [Use the Scheduling Assistant and Room Finder for meetings in Outlook](https://support.microsoft.com/office/use-the-scheduling-assistant-and-room-finder-for-meetings-in-outlook-2e00ac07-cef1-47c8-9b99-77372434d3fa).  

## More information

If you have a hybrid environment with on-premises Exchange Servers and Exchange Online, use the following instructions to set up room mailboxes and room lists:  

- Create a room list in an on-premises server and sync it to the cloud.  
- Create an on-premises room mailbox and sync it to the cloud.  
- Create a remote synced room mailbox in Exchange Online by running the `New-RemoteMailbox` cmdlet with the `-Room` switch in Exchange Management Shell.
- Add both the on-premises room mailbox and the remote synced room mailbox to the on-premises room list by running the `Add-DistributionGroupMember` cmdlet in Exchange Management Shell.  
- Configure the properties on both room mailboxes by using the `Set-User` cmdlet in Exchange Management Shell.
