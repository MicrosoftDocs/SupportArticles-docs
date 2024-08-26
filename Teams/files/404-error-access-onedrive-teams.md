---
title: 404 error when accessing the OneDrive app in Teams
description: Work around the 404 File not found error when you try to access the OneDrive app in Microsoft Teams. This error occurs after your User Principal Name (UPN) is changed.
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Teams Files\Files Tab
  - CI 194651
  - CSSTroubleshoot
ms.reviewer: salarson
appliesto: 
  - Microsoft Teams
search.appverid: 
  - MET150
ms.date: 08/26/2024
---
# Error "404 File not found" when accessing the OneDrive app in Teams

## Symptoms

Your User Principal Name (UPN) is changed. When you try to access the OneDrive app in Microsoft Teams, you receive the following error message: 

> 404 File not found.  

## Workaround

To work around this issue, follow these steps:

1. Start a one-on-one chat with another user.
1. In the compose box, select :::image type="icon" source="media/404-error-access-onedrive-teams/cross-icon.png" alt-text="Screenshot of the Actions and apps icon."::: (**Actions and apps**) > :::image type="icon" source="media/404-error-access-onedrive-teams/attach-icon.png" alt-text="Screenshot of the Attach file icon."::: **Attach file** , and then select :::image type="icon" source="media/404-error-access-onedrive-teams/upload-icon.png" alt-text="Screenshot of the upload icon."::: **Upload from this device**.
1. Select a file that you want to send, and then select **Open**.
1. Select :::image type="icon" source="media/404-error-access-onedrive-teams/send-icon.png" alt-text="Screenshot of the send icon."::: (**Send**).
1. Select the OneDrive app from the left navigation bar in Teams.

For more information about how UPN changes affect OneDrive, see [How UPN changes affect the OneDrive URL and OneDrive features](/sharepoint/upn-changes).
