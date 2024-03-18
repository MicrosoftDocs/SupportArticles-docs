---
title: Outlook settings change after removing Group Policy settings
description: Provides a resolution to solve the issue that your Outlook settings may unexpectedly change after the Group Policy settings that control some Outlook features are removed.
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - CSSTroubleshoot
appliesto:
- Outlook
search.appverid: MET150
ms.reviewer: randyto, aruiz, sercast, v-six
author: cloud-writer
ms.author: meerak
ms.date: 01/30/2024
---
# Outlook settings may unexpectedly change after administrator removes Group Policy settings that control some Outlook features

## Symptoms

After your administrator removes Group Policy settings that control some Microsoft Outlook 2013, Microsoft Outlook 2010 or Microsoft Office Outlook 2007 features, your Outlook settings may unexpectedly change. The affected Outlook settings include the following. However, the affected settings are not limited to these settings.

- Number of months of free/busy information that is published
- Interval for publishing free/busy information
- Deletion of blank voting and meeting responses after they are processed
- Automatic processing of receipts
- Default reminder time
- Definition of your working hours and work week

## Cause

Outlook reads the settings that are described in the Symptoms section from different locations. One location is the user settings area of the Windows registry. When Office is deployed by using the Office Customization Tool (OCT), an administrator can decide to configure initial settings. These settings are written into the registry. These registry values are considered "seed" values. This means that when Outlook is first run, it reads the values from this "seed" location and then writes them into your Exchange mailbox as roaming settings. From this point forward, Outlook uses only the roaming settings. Because the user settings that are stored in the registry act as initial seed values, Outlook does not read them again. When you use the Outlook user interface to change your Outlook options, these changes are written directly into the roaming settings in your mailbox.

If an administrator decides to configure any of these settings by using a Group Policy object, Outlook uses only the settings from the Group Policy object. This means that the Group Policy settings can differ from what is stored in the mailbox roaming settings. If the Group Policy object is removed, Outlook reverts to using the roaming settings. If the roaming settings differ from what the Group Policy objects defined, you see a change in behavior.

## Resolution

There is no option to globally set or to globally configure the roaming settings by using Group Policy or registry values.

To work around this issue, you must use the Outlook user interface to configure the settings as you want. This is necessary only if you notice a change in the expected behavior of the Outlook features that described in the Symptoms section after Group Policy objects that control those same features are removed.

## More information

Outlook uses the following order of preference when it reads the settings that are described in the Symptoms section:

1. Group Policy
2. Roaming settings
3. User registry values

If the user registry values exist, they are stored in the following locations for Outlook 2013:

`HKEY_CURRENT_USER\Software\Microsoft\Office\15.0\Outlook\Options\Calendar`

`CalDefStart`  
`CalDefEnd`  
`RemindDefault`  
`WorkDay`

`HKEY_CURRENT_USER\Software\Microsoft\Office\15.0\Outlook\Options\General`

`AutoDelRcpts`  
`AutoProcReq`

`HKEY_CURRENT_USER\Software\Microsoft\Office\15.0\Outlook\Preferences`

`FBPublishRange`  
`FBUpdateSecs`

> [!NOTE]
> For Outlook 2010, the registry key path begins as follows:
>
> `HKEY_CURRENT_USER\Software\Microsoft\Office\14.0\Outlook\`
>
> For Outlook 2007, the registry key path begins as follows:
>
> `HKEY_CURRENT_USER\Software\Microsoft\Office\12.0\Outlook\`

You can view the roaming preferences by running MFCMAPI and then viewing the **Associated Contents Folder** of the **Calendar**. Sort by **Subject**, and select **IPM.Configuration.Calendar**. Then, double-click **PR_ROAMING_DICTIONARY**. The **Property Editor** window that opens shows some of the values. (Notice the right side of the screenshot that follows.)

:::image type="content" source="media/settings-unexpectedly-change-deleting-group-policy-settings/roaming-preferences.png" alt-text="Viewing Outlook roaming preferences in MFCMAPI." border="false":::

The roaming preferences map to the registry values as follows:  

|Roaming Preference|Registry Value|
|---|---|
| piFBUserPublishRange| FBPublishRange |
| piFBUpdateSecs| FBUpdateSecs |
| piAutoProcess| AutoProcReq |
| piRemindDefault| RemindDefault |
| piAutoDeleteReceipts| AutoDelRcpts |
| piCalDefStart| CalDefStart |
| piCalDefEnd| CalDefEnd |
| piWorkday| WorkDay |
