---
title: Profile picture not showing in SharePoint Online
description: Your profile picture is not shown in SharePoint Online.
author: helenclu
ms.reviewer: salarson
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.author: luche
ms.custom: 
  - CSSTroubleshoot
  - CI 150415
appliesto: 
  - SharePoint Online
ms.date: 12/17/2023
---

# Profile picture not showing in SharePoint Online

Your SharePoint Online profile picture isn't displayed on SharePoint sites or in People web parts. To get your profile picture displayed, try the following resolutions.

## Resolution Option 1: Run the Picture Sync diagnostic

> [!NOTE]
> This feature requires a Microsoft 365 administrator account. This diagnostic isn't available for the GCC High or DoD environments, or for Microsoft 365 operated by 21Vianet.

Microsoft 365 admin users have access to diagnostics that can be run within the tenant to verify possible issues with user photos.

Select **Run Tests**, which will populate the diagnostic in the Microsoft 365 Admin Center.

> [!div class="nextstepaction"]
> [Run Tests: Picture Sync](https://aka.ms/PillarPictureSync)

The diagnostic performs a large range of verifications for users who may not be seeing an updated profile picture.


## Resolution Option 2: Select the most relevant option below and follow the steps

<details>
<summary><b>If you have an Exchange Online mailbox</b></summary>

1. Find a photo you want to use and store it on your computer, OneDrive, or other location you can access.
1. Sign into Microsoft 365 with your work or school account at [office.com](https://office.com).
1. Select the circle in the upper corner of the page that shows your initials or a person icon.
1. In the **My accounts** pane, select the camera icon that is next to your initials or the icon of a person.
1. Select **Upload a new photo** and upload the picture.
1. For more information, see [Add your profile photo to Microsoft 365](https://support.microsoft.com/topic/add-your-profile-photo-to-microsoft-365-2eaf93fd-b3f1-43b9-9cdc-bdcd548435b7).

Check for the picture to trigger a sync between Exchange Online and SharePoint Online:

1. Add the users who are missing a photo in SharePoint Online to an existing People web part or create a new page and add the user to a People web part using [Show people profiles on your page with the People web part](https://support.microsoft.com/office/show-people-profiles-on-your-page-with-the-people-web-part-7e52c5f6-2d72-48fa-a9d3-d2750765fa05).
1. In a private (InPrivate/Incognito) browser session, ask each user to browse to the location where they were added to the People web part.

If all these steps have been completed and the photo isn't showing within 24 hours of retrying the steps, contact your Microsoft 365 Administrator. If you aren’t sure who that is, see [How do I find my Microsoft 365 admin?](https://support.microsoft.com/office/how-do-i-find-my-microsoft-365-admin-59b8e361-dbb6-407f-8ac3-a30889e7b99b)
    
</details>


<details>
<summary><b>If you don't have an Exchange Online mailbox</b></summary>

1. Find a photo you want to use and store it on your computer, OneDrive, or other location you can access.
1. Sign into Microsoft 365 with your work or school account at [office.com](https://office.com).
1. Select the circle in the upper corner of the page that shows your initials or a person icon.
1. Select **My Office profile**.
1. Select the camera icon.
1. Choose **Upload picture**.

    :::image type="content" source="media/profile-picture-not-showing/profile-picture.png" alt-text="Screenshot shows the Picture dialog with the Upload Picture button.":::

    **Note** If you see **Change photo** instead of **Upload picture**, you have an Exchange Online mailbox. Follow the steps in **If you have an Exchange Online mailbox** instead.

1. Select the **Basic Information** tab, and then choose **Upload picture**. The **Choose a picture** dialog box is displayed.
1. Upload a picture to SharePoint Online from the **Choose a picture** dialog box.

For more information, see [View and update your profile in Office Delve](https://support.microsoft.com/office/view-and-update-your-profile-in-delve-4e84343b-eedf-45a1-aeb9-8627ccca14ba).

If all these steps have been completed and the photo is still not showing, contact your Microsoft 365 Administrator. If you aren’t sure who that is, see [How do I find my Microsoft 365 admin?](https://support.microsoft.com/office/how-do-i-find-my-microsoft-365-admin-59b8e361-dbb6-407f-8ac3-a30889e7b99b)
    
 </details>

<details>
<summary><b>Steps for SharePoint Administrators</b></summary>

If a user is encountering this problem, check that the Picture profile property is set to be user editable. If this is not set to user editable, SharePoint will not sync the pictures with Exchange Online.

1. Go to the [Microsoft 365 admin center](https://admin.microsoft.com/).
1. Select **Show all** > **SharePoint** > **Classic SharePoint admin center** > **User profiles** > **Manage User Properties**.
1. Select the **Picture** property, and then choose **Edit**.
1. Check the **Allow users to edit values for this property** box and select **OK**.

When you’ve confirmed the Picture property is user editable, have the user retry the steps in the above sections. If the picture still isn’t showing, contact Microsoft support.

> [!NOTE]
>
> - For Exchange Online users, it will still take 24 hours for the sync to occur and update the SharePoint picture.
> - For Exchange Online users, changing **Picture Exchange Sync State** to **0** and uploading a user picture directly to SharePoint would be a temporary change **only**. The next time a picture sync occurs from Exchange Online, the user's previously uploaded SharePoint picture will be overwritten by the profile picture that exists in Exchange Online.

</details>

## References

- [Information about profile picture synchronization in Microsoft 365](https://support.microsoft.com/office/information-about-profile-picture-synchronization-in-microsoft-365-20594d76-d054-4af4-a660-401133e3d48a)

- [Bulk upload user profile pictures](https://github.com/pnp/PnP/tree/master/Samples/Core.ProfilePictureUploader)
    
    **DISCLAIMER**
    Copyright (c) Microsoft Corporation. All rights reserved. This script is made available to you without any express, implied, or statutory warranty, not even the implied warranty of merchantability or fitness for a particular purpose, or the warranty of title or non-infringement. The entire risk of the use or the results from the use of this script remains with you.
