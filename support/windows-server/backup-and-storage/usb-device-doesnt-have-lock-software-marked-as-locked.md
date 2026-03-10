---
title: USB device doesn't have lock software, but Windows marks it as locked
description: Helps you fix an issue in which Windows marks a USB storage device as write-protected or locked, even though the device doesn't have specific lock or encryption software installed.
ms.date: 03/10/2026
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.reviewer: kaushika, simonw, v-tappelgate
ai-usage: ai-assisted
ms.custom:
- sap:backup,recovery,disk,and storage\storage hardware
- pcy:WinComm Storage High Avail
appliesto:
  - <a href=https://learn.microsoft.com/windows/release-health/windows-server-release-info target=_blank>Supported versions of Windows Server</a>
---
# Windows marks as locked a USB device that has no lock software

## Summary

This article helps you fix an issue in which Windows marks a USB storage device as write-protected or locked even though the device doesn't have specific lock or encryption software installed. In a domain environment, the most common cause of this issue is a domain-level Group Policy Object (GPO) that enforces write protection on removable storage devices.

## Symptoms

You connect a USB storage device to a Windows computer that belongs to a domain. You experience the following symptoms:

- Windows shows the USB drive as write-protected or locked.
- You can't save, delete, or modify files on the USB device.

If you try to use the Windows registry or local Group Policy to disable write protection, the change reverts when you restart the Windows device

## Cause

This issue might have the following causes:

- **Physical write-protect switch**: Some USB drives have a physical write-protect switch on the side of the device. Check whether the switch is in the locked position before proceeding.
- **Domain-level Group Policy settings**: In a domain environment, a Group Policy Object (GPO) can enforce write protection on USB storage devices. These settings override local registry modifications or local Group Policy changes. In this case, any changes that you make locally revert the next time that the Windows device refreshes its domain policies. If you can't fix this issue by modifying registry entries or applying local policy changes, a domain GPO is the most likely cause.

## Resolution

> [!TIP]  
> To minimize disruption, perform policy changes outside business hours.

To resolve this issue:

1. Identify the domain GPO that enforces USB write protection. To identify which policies are applied to your device, run the following command in a Command Prompt window:

   ```console
   gpresult /h gp-report.html
   ``

   The report.html file lists all the policy settings that apply to the device. 

1. Review the settings under **Computer Configuration** > **Administrative Templates** > **System** > **Removable Storage Access**. In particular, examine the **Removable Disks: Deny write access** setting.

1. Look for settings such as **Removable Disks: Deny write access**, and then set them to **Not configured** or **Disabled**. If it's necessary, contact you domain administrator to modify the policy settings.

1. To apply the updated GPO to the Windows device, run the following command at the command prompt:

   ```console
   gpupdate /force
   ```

1. To verify that you have write access, test the USB device.

## Data collection

If the problem persists after you follow the resolution steps, gather the following information before you contact Microsoft Support or your IT administrator:

- The version of Windows that you're using. To find this information, go to **Settings** > **System** > **About**.
- A detailed description of the behavior that occurs when you try to write to the USB device. Include screenshots of any error messages.
- The report.html file that the `gpresult /h gp-report.html` command generated, and a list of any USB-related Group Policy settings that apply at the domain level.
- Details of any recent changes to domain policies, security software, or device drivers.
