---
title: Manage the First Run screens that appear when Office 2013 is first launched
description: Describes how to disable First Run screens by using Office Customization Tool (OCT) or Group Policy Management Editor.
author: Cloud-Writer
ms.author: meerak
manager: dcscontentpm
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Office Suite (Access, Excel, OneNote, PowerPoint, Publisher, Word, Visio)\Installation, Update, Deployment,  Activation
  - DownloadInstall\AdvancedConfiguration\OfficeDeploymentTool
  - sap:office-experts
  - CSSTroubleshoot
ms.reviewer: jalalb
appliesto: 
  - Office 2013
ms.date: 06/06/2024
---

# How to manage the First Run screens that appear when Office 2013 applications are first started

This article was written by [Jalal Babool](https://social.technet.microsoft.com/profile/JalalB+-+MSFT), Senior Support Ability Project Manager.

## Summary

Microsoft Office 2013 shows the following screens when an application is started for the first time. This article describes how to disable these First Run screens by using the Office Customization Tool (OCT) or Group Policy Management Editor.

:::image type="content" source="media/manage-office-2013-first-run-screens/welcome-to-new-office.png" alt-text="Screenshot of the First Run screens, showing welcome to your new Office.":::

:::image type="content" source="media/manage-office-2013-first-run-screens/meet-sky-drive.png" alt-text="Screenshot of the First Run screens, showing Meet SkyDrive.":::

:::image type="content" source="media/manage-office-2013-first-run-screens/hello-test.png" alt-text="Screenshot of the First Run screens, showing Hello U Test.":::

:::image type="content" source="media/manage-office-2013-first-run-screens/good-to-go.png" alt-text="Screenshot of the First Run screens, showing you're good to go.":::

## More Information

### Use Office Customization Tool (OCT)

> [!NOTE]
> The OCT can only be used with Windows Installer based source files for Office 2013.

1. Open the OCT as an administrator, locate the **Features** section, and then select **Modify user settings** > **Microsoft Office 2013** > **First Run** > **Disable First Run Movie**.
 
   :::image type="content" source="media/manage-office-2013-first-run-screens/disable-first-run-movie-in-oct.png" alt-text="Screenshot to select the Disable First Run Movie item in O C T." border="false":::

1. Set **Disable First Run Movie** to **Enabled**.

   :::image type="content" source="media/manage-office-2013-first-run-screens/enabled-option.png" alt-text="Screenshot to set Disable First Run Movie to Enabled in O C T." border="false":::

1. Select **Disable First Run on application boot**, and then set it to **Enabled**.

   :::image type="content" source="media/manage-office-2013-first-run-screens/disable-first-run-on-application-boot.png" alt-text="Screenshot to set Disable First Run on application boot to Enabled." border="false":::

1. Save the resulting MSP file and use it as part of the Office 2013 deployment.

### Use Group Policy Management Editor

1. Download [Office 2013 Administrative Template files](https://www.microsoft.com/download/details.aspx?id=35554
) if you have not already downloaded.
1. Copy the ADMX files to %systemroot%\PolicyDefinitions, and then copy the ADML files to the language specific folder (such as en-us) under %systemroot%\PolicyDefinitions.
1. In Group Policy Management Editor, locate **User Configuration** > **Policies** > **Administrative Templates: Policy definitions** > **Microsoft Office 2013** > **First Run**.

   :::image type="content" source="media/manage-office-2013-first-run-screens/first-run-policy.png" alt-text="Screenshot to locate First Run in the Group Policy Management Editor window." border="false":::

1. Set both **Disable First Run Movie** and **Disable Office First Run on application boot** to **Enabled**.

   :::image type="content" source="media/manage-office-2013-first-run-screens/disable-first-run-movie.png" alt-text="Screenshot to set Disable First Run Movie to Enabled." border="false":::

   :::image type="content" source="media/manage-office-2013-first-run-screens/disable-office-first-run.png" alt-text="Screenshot to set Disable Office First Run on application boot to Enabled." border="false":::
