---
title: Cannot see contact photos
description: Describes an issue that prevents you from seeing contact photos in Outlook 2016, Outlook 2013, Outlook 2010, Lync 2013, Lync 2010 or Skype for Business. Provides a resolution.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Outlook for Windows
  - CSSTroubleshoot
ms.reviewer: robevans
appliesto: 
  - Outlook LTSC 2021
  - Outlook 2019
  - Outlook 2016
  - Outlook 2013
  - Microsoft Outlook 2010
  - Skype for Business
  - Microsoft Lync 2013
  - Lync 2010
  - Outlook for Microsoft 365
search.appverid: MET150
ms.date: 01/30/2024
---
# You can't see contact photos in Outlook, Skype for Business, or Lync

_Original KB number:_ &nbsp; 3049193

## Symptoms

In Microsoft Outlook 2010 and later versions, you discover that contact photos are missing from email messages and from contacts in the global address list (GAL). The following screenshots show an example of this issue in Outlook 2016.

:::image type="content" source="media/cannot-see-contact-photos/example-1.png" alt-text="Screenshot of an email displaying no contact photo.":::

You expect the contact photo to be displayed in Outlook, resembling the following.

:::image type="content" source="media/cannot-see-contact-photos/example-2.png" alt-text="Screenshot of an email displaying contact photo.":::

You also discover that contact photos are missing in Skype for Business or Lync, as shown in the following screenshot.

:::image type="content" source="media/cannot-see-contact-photos/example-3.png" alt-text="Screenshot of Skype for Business displaying no contact photos." border="false":::

## Cause

This issue occurs when the **Show user photographs when available** check box is cleared in the **Outlook Options** dialog box.

:::image type="content" source="media/cannot-see-contact-photos/show-user-photographs-when-available.png" alt-text="Screenshot of the Show user photographs option in the People tab of Outlook Options." border="false":::

## Resolution Method 1 - Outlook Options

1. On the **File** menu in Outlook, select **Options**, and then select **People** (or **Contacts** in Outlook 2010).
2. Enable the **Show user photographs when available** check box.
3. Select **OK**.  
4. Close and restart Outlook, and Skype for Business or Lync.

## Resolution Method 2 - Group Policy

If you are using Group Policy to manage this setting, disable the **Do not display photograph** policy setting.

To update an existing policy that's configured to disable the **Show user photographs when available** option, follow these steps:

1. Start the Group Policy Management Console (GPMC).
2. Under User Configuration, expand Administrative Templates to locate the policy node for your template.

   - When you are using the Office16.admx and Office16.adml templates, this node is named Microsoft Office 2016.
   - When you are using the Office15.admx and Office15.adml templates, this node is named Microsoft Office 2013.

3. Under **Contact Card**, double-click **Do not display photograph**.

   :::image type="content" source="media/cannot-see-contact-photos/contact-card-setting.png" alt-text="Screenshot of the Contact Card Group Policy settings." border="false":::

4. Select **Disabled** or **Not Configured**, and then select **OK**.
5. Select **OK** for the rest of the dialog boxes.

The policy setting will be applied on the client computers after the Group Policy update is replicated, and then Outlook and Skype for Business or Lync must be closed and restarted for the setting to take effect.

## More information

The **Do not display photograph** setting is managed by the following registry data:

- Without Group Policy:

  Key: `HKEY_CURRENT_USER\software\Microsoft\Office\x.0\common`  
  DWORD: TurnOffPhotograph  
  Value: 1
- With Group Policy:

  Key: `HKEY_CURRENT_USER\software\Policies\Microsoft\Office\x.0\common`  
  DWORD: TurnOffPhotograph  
  Value: 1

> [!NOTE]
> The *x.0* placeholder represents your version of Office (16.0 = Office 2016, Office 2019, Office LTSC 2021, or Microsoft 365, 15.0 = Office 2013, 14.0 = Office 2010).
