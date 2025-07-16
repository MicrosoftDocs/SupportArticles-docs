---
title: Add-ins are user re-enabled after being disabled
description: This article discusses a behavior that add-ins are user re-enabled after being disabled by Office programs. Provides steps to disable an add-in that was re-enabled.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Developer Issues\Add-in errors
  - Outlook for Windows
  - CSSTroubleshoot
ms.reviewer: gregmans
appliesto: 
  - Outlook 2016
  - Excel 2016
  - Word 2016
  - PowerPoint 2016
  - Outlook 2013
  - Excel 2013
  - Word 2013
  - PowerPoint 2013
search.appverid: MET150
ms.date: 01/30/2024
---
# Add-ins are user re-enabled after being disabled by Office programs

_Original KB number:_ &nbsp; 2758876

## Summary

Programs in Office 2013 and later versions provide add-in resiliency in that the apps will disable an add-in if it performs slowly. However, you can re-enable the add-in and select the **Always enable this add-in** option to prevent the add-in from being auto-disabled by the Office program. For example, the following figure shows an add-in that was disabled because it caused Outlook to shut down slowly. The option to **Always enable this add-in** is shown as well.

:::image type="content" source="media/add-ins-are-user-re-enabled-after-being-disabled/outlook-detected-an-add-in-problem.png" alt-text="Screenshot shows the Always enable this add-in option is shown.":::

> [!NOTE]
> If you re-enable an add-in that caused a performance problem at one time, you may experience performance problems in the future in the Office program under which the add-in is loaded. See the More Information section of this article for additional information on ways you can monitor add-in performance in Office programs.

## More information

> [!WARNING]
> Serious problems might occur if you modify the registry incorrectly by using Registry Editor or by using another method. These problems might require that you reinstall the operating system. Microsoft cannot guarantee that these problems can be solved. Modify the registry at your own risk.

In Office 2013 and later versions, the performance of add-ins is logged in the Application Event log under an Event ID: 45. The following figure shows an example event for an add-in load time in Outlook.

:::image type="content" source="media/add-ins-are-user-re-enabled-after-being-disabled/event-45-outlook.png" alt-text="Screenshot of Event 45 Application Event log." border="false":::

However, if an add-in causes performance issues in an Office program, an Event ID: 59 is added to the Application Event log. For example, the following event shows that an add-in was disabled because it caused Outlook to shut down slowly.

```console
Source: Outlook  
Date: DateTime  
Event ID: 59  
Task Category: None  
Level: Warning  
Keywords: Classic  
User: N/A  
Computer: ComputerName

Description:

Outlook disabled the following add-ins  
ProgID: SlowShutdownAddin  
GUID: {GUID}  
Name: SlowShutdownAddin  
Description:  
Load Behavior: 3  
HKLM: 0  
Location: Mscoree.dll  
Threshold Time (milliseconds): 500  
Time Taken (milliseconds): 719  
Disable Reason: This add-in caused Outlook to close slowly.  
Policy Exception (Allow List): 0
```

In this scenario on the next launch of Outlook, the following notification will be shown to raise an alert that an add-in was disabled.

:::image type="content" source="media/add-ins-are-user-re-enabled-after-being-disabled/notification-to-alert-an-add-in-is-disabled.png" alt-text="Screenshot of an alert that an add-in was disabled.":::

By selecting **View Disabled Add-ins**, the **Disabled Add-ins** dialog box is displayed and you can select the **Always enable this add-in** option to keep the add-in enabled even if it performs slowly.

:::image type="content" source="media/add-ins-are-user-re-enabled-after-being-disabled/always-enable-this-add-in.png" alt-text="Screenshot of the Always enable this add-in option.":::

If you select **Always enable this add-in**, the registry is updated to include details about the add-in that is to be exempted from this automatic disabling feature.

> Key: HKEY_CURRENT_USER\Software\Microsoft\Office\\**x.0**\\\<application>\Resiliency\DoNotDisableAddinList  
> DWORD: < *ProgID* of the add-in>  
> Value: Hex value between 1 and A indicating the reason the add-in was originally disabled. (see table below)
>
> 0x00000001 Boot load (LoadBehavior = 3)  
> 0x00000002 Demand load (LoadBehavior = 9)  
> 0x00000003 Crash  
> 0x00000004 Handling FolderSwitch event  
> 0x00000005 Handling BeforeFolderSwitch event  
> 0x00000006 Item Open  
> 0x00000007 Iteration Count  
> 0x00000008 Shutdown  
> 0x00000009 Crash, but not disabled because add-in is in the allow list  
> 0x0000000A Crash, but not disabled because user selected no in disable dialog

> [!NOTE]
> The **x.0** placeholder represents your version of Office (16.0 = Office 2016, 15.0 = Office 2013).

## Disabling an add-in that was re-enabled

If you re-enable an add-in by selecting the **Always enable this add-in** option, you should consider manually disabling the add-in if you continue to experience slow performance or instability issues in Outlook. Use the following steps to manually disable an add-in that was previously re-enabled using the **Always enable this add-in** option:

1. On the **File** tab, select **Slow and Disabled COM Add-ins** in Outlook 2016 or select **Slow and Disabled Add-ins** in Outlook 2013.

    :::image type="content" source="media/add-ins-are-user-re-enabled-after-being-disabled/slow-and-disabled-add-ins.png" alt-text="Screenshot of the Slow and Disabled Add-ins option.":::

2. Select **Disable this add-in** below the add-in you want to disable.

    :::image type="content" source="media/add-ins-are-user-re-enabled-after-being-disabled/disable-the-add-in.png" alt-text="Screenshot of the Disable this add-in option." border="false":::

3. Select **Close**.
4. Exit and restart Outlook.
