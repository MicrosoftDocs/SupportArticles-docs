---
title: Manage the First Run screens that appear when Office 2013 is first launched
description: Describes how to disable First Run screens by using Office Customization Tool (OCT) or Group Policy Management Editor. 
author: MaryQiu1987
manager: dcscontentpm
search.appverid: 
- MET150
localization_priority: Normal
audience: ITPro
ms.prod: office-perpetual-itpro
ms.topic: article
ms.custom: CSSTroubleshoot
ms.author: jalalb
appliesto:
- Office 2013
---

# How to manage the First Run screens that appear when Office 2013 applications are first started

This article was written by [Jalal Babool](https://social.technet.microsoft.com/profile/JalalB+-+MSFT), Senior Support Ability Project Manager.

## Summary

Microsoft Office 2013 shows the following screens when an application is started for the first time. This article describes how to disable these First Run screens by using the Office Customization Tool (OCT) or Group Policy Management Editor.

![Welcome to Office screen](./media/manage-office-2013-first-run-screens/screen-1.png)

![Meet SkyDrive screen](./media/manage-office-2013-first-run-screens/screen-2.png)

![Hello Test screen](./media/manage-office-2013-first-run-screens/screen-3.png)

![You're good to go screen](./media/manage-office-2013-first-run-screens/screen-4.png)

## More Information

### Use Office Customization Tool (OCT)

> [!NOTE]
> The OCT can only be used with Windows Installer based source files for Office 2013.

1. Open the OCT as an administrator, locate the **Features** section, and then select **Modify user settings** > **Microsoft Office 2013** > **First Run** > **Disable First Run Movie**.
 
   ![Locate Disable First Run Movie in OCT](./media/manage-office-2013-first-run-screens/disable-first-run-movie-in-oct.png)

1. Set **Disable First Run Movie** to **Enabled**.

   ![Set Disable First Run Movie to Enabled](./media/manage-office-2013-first-run-screens/enabled.png)

1. Select **Disable First Run on application boot**, and then set it to **Enabled**.

   ![Set Disable First Run on application boot to Enabled](./media/manage-office-2013-first-run-screens/disable-first-run-on-application-boot.png)

1. Save the resulting MSP file and use it as part of the Office 2013 deployment.

### Use Group Policy Management Editor

1. Download [Office 2013 Administrative Template files](https://www.microsoft.com/download/details.aspx?id=35554
) if you have not already downloaded.
1. Copy the ADMX files to %systemroot%\PolicyDefinitions, and then copy the ADML files to the language specific folder (such as en-us) under %systemroot%\PolicyDefinitions.
1. In Group Policy Management Editor, locate **User Configuration** > **Policies** > **Administrative Templates: Policy definitions** > **Microsoft Office 2013** > **First Run**.

   ![Locate First Run in Group Policy Management Editor](./media/manage-office-2013-first-run-screens/first-run-policy.png)

1. Set both **Disable First Run Movie** and **Disable Office First Run on application boot** to **Enabled**.

   ![Set Disable First Run Movie to enabled in Group Policy Management Editor](./media/manage-office-2013-first-run-screens/enable-setting1-in-group-policy.png)

   ![Set Disable Office First Run on application boot to enabled in Group Policy Management Editor](./media/manage-office-2013-first-run-screens/enable-setting2-in-policy.png)