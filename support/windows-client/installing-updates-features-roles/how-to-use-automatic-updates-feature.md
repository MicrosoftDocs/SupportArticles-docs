---
title: How to schedule automatic updates in Windows
description: Explains how to use the Automatic Updates feature in Windows Server 2003, in Windows XP, and in Windows 2000.
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:Installing Windows Updates, Features, or Roles\Failure to install Windows Updates, csstroubleshoot
---
# How to schedule automatic updates in Windows

This article explains how to use the Automatic Updates feature in Windows Server 2003, in Windows XP, and in Windows 2000.

_Applies to:_ &nbsp; Windows 10 – all editions, Windows Server 2012 R2  
_Original KB number:_ &nbsp; 327838

## Summary

If you're logged on as an administrator, the Automatic Updates feature in Windows notifies you when critical updates are available for your computer. There's a new Automatic Updates feature that you can use to specify the schedule that Windows follows to install updates on your computer. This article describes how to install this new Automatic Updates feature in Windows XP and in Windows 2000 and how to use it to schedule automatic updates.

> [!NOTE]
> This new Automatic Updates feature is included with Windows Server 2003.

For additional information about how to configure other Automatic Updates settings in Windows XP, click the following article number to view the article in the Microsoft Knowledge Base:

[306525](https://support.microsoft.com/help/306525) How to configure and use Automatic Updates in Windows XP  

## Update the Automatic Updates feature (Windows XP and Windows 2000 only)

> [!NOTE]
> If you use Automatic Updates, the feature may have been automatically updated on your computer. To make sure that the new feature is installed, use the procedure that is described in the [Schedule Automatic Updates](#schedule-automatic-updates) section of this article to confirm that the **Automatically download the updates, and install them on the schedule that I specify** option is available on your computer.

To use the new Automatic Updates feature, install the following updates:

Windows XP Service Pack 1 (SP1). For additional information about how to obtain SP1, click the following article number to view the article in the Microsoft Knowledge Base:  
[322389](https://support.microsoft.com/help/322389) How to obtain the latest Windows XP service pack  

> [!NOTE]
> You must restart your computer after you install this update. Automatic Updates does not download any updates until you have configured it to do so. If Automatic Updates is not configured in 24 hours after you install it, either the network administrator or the user who is logged on locally as an administrator is prompted to configure it.

## Schedule automatic updates

> [!NOTE]
> To modify Automatic Updates settings, you must be logged on as an administrator or a member of the Administrators group. If your computer is connected to a network, network policy settings may prevent you from completing this procedure.

### In Windows Server 2003 and in Windows XP

To configure a schedule for Automatic Updates:

1. Click **Start**, click **Control Panel**, and then double-click **System**.
2. On the **Automatic Updates** tab, click **Automatically download the updates, and install them on the schedule that I specify**.
3. Click to select the day and time that you want to download and install updates.

When critical updates are detected, Automatic Updates automatically downloads these updates in the background while you're connected to the Internet. After the download is complete, Automatic Updates waits until the scheduled day and time to install the updates. On the scheduled day and time, all local users receive the following message that has a five-minute countdown timer:

Windows is ready to begin installing the updates available for your computer.

Do you want Windows to install the updates now?

(Windows will restarts your computer if no action is taken within 5:00 minutes)

If you're logged on as an administrator, when you receive this message, you can either click **Yes** to install the updates or click **No** to have Automatic Updates install the updates at the next scheduled day and time. If you don't take any action in five minutes, Windows automatically installs the updates.

> [!IMPORTANT]
> You may have to restart your computer to complete the update installation.

### In Windows 2000

1. Click **Start**, click **Control Panel**, and then double-click **Automatic Updates**.
2. Click **Automatically download the updates, and install them on the schedule that I specify.**  
3. Click to select the day and time that you want to download and install updates.

When critical updates are detected, Automatic Updates automatically downloads these updates in the background while you're connected to the Internet. After the download is complete, Automatic Updates waits until the scheduled day and time to install the updates. On the scheduled day and time, all local users receive the following message that has a five-minute countdown timer:

Windows is ready to begin installing the updates available for your computer.

Do you want Windows to install the updates now?

(Windows will restart your computer if no action is taken within 5:00 minutes)

If you're logged on as an administrator, when you receive this message, you can either click **Yes** to install the updates or click **No** to have Automatic Updates install the updates at the next scheduled day and time. If you don't take any action in five minutes, Windows automatically installs the updates.

> [!IMPORTANT]
> You may have to restart your computer to complete the update installation.

## Data collection

If you need assistance from Microsoft support, we recommend you collect the information by following the steps mentioned in [Gather information by using TSS for deployment-related issues](../windows-troubleshooters/gather-information-using-tss-deployment.md).

## References

For additional information about how to use Automatic Updates, view the following articles:

- [Description of the Automatic Updates feature in Windows](https://support.microsoft.com/help/294871)

- [How to configure Automatic Updates by using Group Policy or registry settings](/windows/deployment/update/waas-wu-settings)

For more information about Software Update Services, visit the following Microsoft Web site:  
[What's new in Windows 10 deployment](/windows/deployment/deploy-whats-new)
