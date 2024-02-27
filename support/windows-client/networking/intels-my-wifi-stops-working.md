---
title: Intel's My WiFi Technology stops working
description: Fixes an issue where Intel's My WiFi Technology stops working after your computer resumes from sleep or hibernate.
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:wireless-networking-and-802.1x-authentication, csstroubleshoot
---
# Intel's My WiFi Technology stops working after resuming from sleep or hibernate in Windows 7

This article provides help to fix an issue where Intel's My WiFi Technology stops working after your computer resumes from sleep or hibernate.

_Applies to:_ &nbsp; Windows 7 Service Pack 1  
_Original KB number:_ &nbsp; 2560995

## Symptoms

Consider the following scenario:

- You have Windows 7 installed on a notebook computer.
- The notebook computer has an Intel Wireless LAN device that supports Intel's My WiFi Technology (MWT).
- Within the Intel My Wifi Utility window, you select the Enable button.
- The computer enters sleep or hibernation.
- You wake the computer.

In this scenario, you may see the following status in the Intel My WiFi Utility window:

Disabled because the Hardware Radio Switch is Off. Turn on the hardware radio switch to enable Intel My WiFi Technology on your computer.  

In addition, the Enable button is either not present or does not function. The expected behavior is that the Enable button should be available and functional within the application.

## Cause

The above scenario may occur when the power management option " *Allow the computer to turn off this device to save power* " has been disabled for the Intel Wireless LAN device.

## Resolution

You can work around this issue by using either of the two steps below:

- Enable the power management option "*Allow the computer to turn off this device to save power*" for the Intel Wireless LAN device using the following steps:

  1. Click on the **Start** button and select **Control Panel**.
  2. Select **System and Security**.
  3. Select **Device Manager** under **System**.
  4. Select and expand the **Network adapters** from the list of devices.
  5. Find the Intel Wireless LAN device and select it to bring up the **Properties** page.
  6. Select the **Power Management** tab.
  7. Under the **Power Management** tab, make sure the following option is checked (enabled): "*Allow the computer to turn off this device to save power*".

        > [!NOTE]
        > If you have **Control Panel** configured to view by small or large icons, you may not see the **System and Security** category listed in step 2. In this case, select **System** from the available **Control Panel** applets and select **Device Manager** from the left pane. You can then skip steps 2 and 3 and continue with step 4.

- Alternatively, you can reboot your computer.

## More information

More information on Intel's My WiFi Technology, including supported wireless networking adapters, can be obtained by visiting Intel's website.
