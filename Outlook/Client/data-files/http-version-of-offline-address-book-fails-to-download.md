---
title: HTTP version of OAB does not download
description: Provides solutions to solve the issue that the manual download of the Offline Address Book (OAB) from an HTTP(S) location fails.
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: CSSTroubleshoot
appliesto:
- Outlook
search.appverid: MET150
ms.reviewer: tasitae, v-six
author: cloud-writer
ms.author: meerak
ms.date: 01/30/2024
---
# HTTP version of the Outlook Offline Address Book (OAB) does not download

## Symptoms

You use Microsoft Outlook to connect to a Microsoft Exchange Server mailbox. When you start a manual download of the Offline Address Book (OAB) from an HTTP(S) location, the progress bar that appears in the **Outlook Send/Receive Progress** dialog box seems to freeze or becomes stuck. The download never finishes, and the local OAB files aren't updated.

## Cause

There are a couple of known causes of this problem.

- Wireless devices on the computer have outdated drivers.

  This issue may occur if old or out-of-date device drivers for wireless peripheral devices are installed. This includes keyboard and mouse drivers.
- Policies for the Background Intelligent Transfer Service (BITS) are configured on your computer.

  BITS policies allow you to control the download rate for updates. If the policy values aren't configured correctly, they could effectively prevent downloads from finishing.
- The Background Intelligent Transfer Service service isn't Started.

  If the **Background Intelligent Transfer Service** service isn't running, then the OAB will not download.

## Resolution

To resolve this issue, use one or more of the following solutions.

- Update device drivers for wireless hardware

  Plug in your wireless receiver and then see [Windows Update: FAQ](https://support.microsoft.com/windows/windows-update-faq-8a903416-6f45-0718-f5c7-375e92dddeb2) to check for updates:

  Install the update that is displayed as **Optional Hardware Update** and has the following title:

  **Microsoft HID Non-User Input Data Filter**

  Or, install the latest IntelliPoint or IntelliType software. To do this, see [PC accessories help & learning](https://support.microsoft.com/pc-accessories).

  If you're using a third-party keyboard or mouse, visit manufacturer's website and download the latest version of the device driver or the latest update for the device.

- Check your registry for any BITS policies

  If you're using a HTTP(s) location from which to download the OAB, the OAB download process is handled by BITS. In this configuration, you'll want to determine if you have any BITS policies configured.

  BITS policies are found under the following key in the registry:

  `HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\BITS`

  The following DWORD values may be configured under this key:

  `EnableBitsMaxBandwidth`  
  `MaxBandwidthValidFrom`  
  `MaxBandwidthValidTo`  
  `MaxTransferRateOnSchedule`  
  `MaxTransferRateOffSchedule`

  If you find **EnableBitsMaxBandwith** = **1**, BITS download throttling is in effect, and the other values are used by BITS to manage downloads. Contact your system administrator to disable BITS download throttling to see if this resolves your OAB download issue.

- Make sure the Background Intelligent Transfer Service is started

  If you're using a HTTP(s) location from which to download the OAB, the OAB download process is handled by BITS. In this configuration, you'll want to ensure the status of the **Background Intelligent Transfer Service** service is started.

  1. On the **Start** menu, enter _Services.msc_ in the **Search programs and files** box, and then select **Services.msc** in the results pane.

  2. In the **Services** dialog box, locate the service called **Background Intelligent Transfer Service**.

  3. Review the status of the service. You'll want to make sure the status of the service is **Started**.

     :::image type="content" source="media/http-version-of-offline-address-book-fails-to-download/background- intelligent-transfer-service-is-started.png" alt-text="Screenshot of the status of the Background Intelligent Transfer Service.":::

     If the Background Intelligent Transfer Service service isn't started, continue with these steps to start the service.

  4. Double-click **Background Intelligent Transfer Service** in the **Services** dialog box.

  5. In the **Startup type** drop-down, select **Automatic (Delayed Start)**, and then select **Apply**.

     :::image type="content" source="media/http-version-of-offline-address-book-fails-to-download/bits-automatic-startup.png" alt-text="Screenshot of the Automatic (Delayed Start) startup type option." border="false":::

  6. Then, select **Start** to start the service.

  You can also examine the registry to see the current configuration of the Background Intelligent Transfer Service service.

  Key: `HKEY_LOCAL_MACHINE\system\currentcontrolset\Services\BITS`  
  DWORD: **Start**  
  Values: 4 = Disabled, 3 = Manual, 2 = Automatic

  > [!NOTE]
  > Do not change the status of the service through the registry. This information is provided for reference only.

## More information

For Outlook 2010 and Outlook 2007, you can use the following steps to determine if you're using an HTTP(s) location to download the OAB.

1. Start Outlook if it is not currently running.
2. Hold down the **CTRL** key, right-click the Outlook icon in the notification area on the right side of the taskbar, and then select **Test E-mail AutoConfiguration**.
3. Clear the **Use Guessmart** check box, and then clear the **Secure Guessmart Authentication** check box.
4. Select the **Use AutoDiscover** check box.
5. If not already entered, type your **email address** and **password**, and then select **Test**.
6. On the **Results** tab, note the path for **OAB URL**.

If the **OAB URL** value begins with **HTTP**, then you're using an HTTP(s) location to download the OAB. If the **OAB URL** value is **Public Folders**, then you aren't using an HTTP(s) location to download the OAB.

> [!NOTE]
> Outlook 2016 and Outlook 2013 only uses an HTTP location to download the OAB.
