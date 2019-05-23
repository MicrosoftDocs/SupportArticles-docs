---
title: Users can't see free/busy information after a mailbox is moved to Office 365
description: Describes an issue in which on-premises users can't see free/busy information for a mailbox that is moved to Office 365. Provides a workaround.
author: simonxjx
manager: willchen
audience: ITPro
ms.service: exchange-online
ms.topic: article
ms.author: v-six
---

# Users can't see free/busy information after a mailbox is moved to Office 365

## Symptoms

After a mailbox is moved to Microsoft Office 365, an on-premises user can't see the free/busy information for the mailbox in Scheduling Assistant.

![Screen shot of the Scheduling Assistant page ](https://support.microsoft.com/Library/Images/3080491.png)

Also, the user can no longer view the Calendar folder, and the user receives a "Could not be updated" error.

![Screen shot of the Calendar folder  ](https://support.microsoft.com/Library/Images/3080492.jpg) 

## Cause

The default permissions of the Calendar folder are set to **None** or **Contributor**. When you query free/busy information by using Scheduling Assistant in a cross-forest scenario, the Availability service uses the organization relationship instead of delegated user permissions. Scheduling Assistant makes cross-forest requests on behalf of the organization relationship instead of on behalf of the user who is requesting it. The organization relationship links to the default account that is seen in the calendar permissions. Therefore, it can't process an explicitly granted permission such as "Free/Busy time" or "Free/Busy time, subject, location."

## Workaround

When the default permissions of the Calendar folder are set to **None** or **Contributor**, details can be obtained only when user delegation is used by attaching calendars directly to the calendar view of Outlook. In a hybrid deployment, free/busy and calendar-sharing functionality work differently than when both users are in the same environment. The default permissions determine the kind of free/busy information that users in a remote forest can see. If the default permissions are set to **None** or **Contributor**, no free/busy information is displayed for remote users, and users cannot view the mailbox calendar. This is because neither kind of permission offers any level of free/busy visibility.

![Screen shot of the Calendar Properties page ](https://support.microsoft.com/Library/Images/3079922.png)
 
![Screen shot of the Calendar Properties page ](https://support.microsoft.com/Library/Images/3079923.png) 

If a remote user must be able to see free/busy information for the mailbox, the mailbox owner can work around this issue by changing the default permissions to **Free/Busy time** or **Free/Busy time, subject, location**. This changes the free/busy information that is shared for all remote users. For example, the default permissions can be set to **Free/Busy time**:

![Screen shot of the Calendar Properties page ](https://support.microsoft.com/Library/Images/3079924.png)

Remote users can see the free/busy data in Scheduling Assistant:

![Screen shot of the Scheduling Assistant page ](https://support.microsoft.com/Library/Images/3079925.png)

Or, remote users can see the free/busy data as an additional calendar:

![A screenshot of the calendar folder page](https://msegceporticoprodassets.blob.core.windows.net/asset-blobs/4091872_en_1)

A remote user can be granted Calendar folder permissions to obtain additional access to the contents of the Calendar folder:

![Screen shot of the Calendar Properties page ](https://support.microsoft.com/Library/Images/3079927.png)

> [!NOTE]
> Granting the **Free/Busy time, subject, location (Limited Details)** permission is insufficient in a hybrid environment. The user has to be granted at least **Reviewer** permission to view calendar item details.

The remote user (Test User 1) can now see the mailbox Calendar folder:

![Screen shot of the Calendar folder ](https://support.microsoft.com/Library/Images/3079928.png) 

## More Information

For more information about cross-forest free/busy configuration, click the following article number to view the article in the Microsoft Knowledge Base:

[3079932](https://support.microsoft.com/help/3079932) Users can see only basic free/busy mailbox information in a remote forest in Office 365 
 
There are some differences with contributor permissions when you set the default calendar permissions or when you explicitly grant a user calendar permissions. When the default calendar permissions are set, the **Free/busy setting** uses **None**.

![Screen shot of the Calendar Properties page ](https://support.microsoft.com/Library/Images/3080493.png)

When a user is granted contributor rights, the permission level will automatically change to **Custom**. This includes **Free/Busy time**.

![Screen shot of the Calendar Properties page ](https://support.microsoft.com/Library/Images/3080494.png)

This is expected behavior, because users who can create items in a calendar can also see the folder and view free/busy information.