---
title: Can't update details for Viva Connections desktop app 
description: Provides methods to update app details for the Viva Connections desktop app.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro 
ms.topic: troubleshooting 
localization_priority: Normal
ms.custom: 
  - CI 159607
  - CSSTroubleshoot
ms.reviewer: bpeterse
ms.date: 02/10/2022
search.appverid: 
- MET150
---

# Can't update details for Viva Connections desktop app

If your organization is using the custom line of business Viva Connections desktop app, you can't update the following app details in the Microsoft Teams admin center:

- Short name
- Short description
- Full description
- Privacy statement URL
- Organization's website URL
- Terms of use URL
- Icons for the app

You must use one of two methods every time that you want to update the details of the custom line of business Viva Connections desktop app. Choose the method that works best for you.

## Method 1: Update the manifest and upload it to the Microsoft Teams admin center

Use this method only if you have access to the Viva Connections desktop package that was used to build the app. The package is a .zip file that contains the Teams app manifest. You must have Teams administrator permissions to use this method.

1. In the .zip file, edit the manifest.json file to update details such as name, description, URL, and file details for the app icons.
2. If you have to update the icons for the app, delete the two .png files in the .zip file, and then upload new files for the icons.
3. In the Microsoft Teams admin center, in the left navigation pane, select [**Teams Apps** > **Manage Apps**](https://admin.teams.microsoft.com/policies/manage-apps).
4. Use the **Search** field to find your custom line of business Viva Connections desktop app.
5. Select the app and then select **Upload file**.  
6. In the **Update app** dialog box, select **Select a file**.
7. Navigate to the .zip file that you updated in steps 1 and 2, and then select **Open**.
8. After the file is uploaded, verify that the updated app details appear in the Microsoft Teams admin center.

## Method 2: Create a new package and upload it to the Microsoft Teams admin center

Use this method if you don't have access to the Viva Connections desktop package that was used to build the app or if you don't want to update the manifest directly. To use this method, you must have both SharePoint administrator and Teams administrator permissions.

1. Create a new Viva Connections desktop package by following the instructions in [this guide](/sharepoint/viva-connections-desktop#step-by-step-guide-to-setting-up-viva-connections-desktop-only). Provide the updated app details to create a .zip file for the package.
2. Upload the package to the Microsoft Teams admin center:

   1. In the Teams admin center, select [**Teams Apps** > **Manage Apps**](https://admin.teams.microsoft.com/policies/manage-apps) in the left navigation pane.
   2. Use the **Search** field to locate your new Viva Connections desktop app.
   3. Select the app and then select **Upload file**.
   4. In the **Update app** dialog box, select **Select a file**.
   5. Navigate to the .zip file that you updated in steps 1 and 2, and then select **Open**.

3. After the file is uploaded, toggle the **Status** option from **Blocked** to **Allowed** to make the new Viva Connections desktop app available to users within your organization.
4. Use the **Search** field to find your old Viva Connections desktop app, and select it.
5. Toggle the **Status** option for this old app from **Allowed** to **Blocked** to make it unavailable to users within your organization. Alternatively, you can delete the old app.  
6. Verify that the details for the new Viva Connections desktop app in the Teams admin center are correct.  

## More information

The custom line of business Viva Connections app is available only for the desktop version of Microsoft Teams. If your organization wants to use the Viva Connections app for both the Teams desktop and Teams mobile environments, you can enable the Viva Connections first-party app from the Microsoft Teams admin center by using the following steps. Updates to this app can be made directly from the Teams admin center.

1. Use the steps in [this guide](/viva/connections/guide-to-setting-up-viva-connections) to set up the first-party Viva Connections app.
2. By default, the first-party Viva Connections app is blocked. Leave it set to **Blocked** and complete all the other requirements.
3. Toggle the **Status** option for the first-party Viva Connections app from **Blocked** to **Allowed**.
4. Delete and uninstall the custom line of business Viva Connections desktop app.
