---
title: Troubleshoot Managed Google Play apps on Intune-managed devices
description: Troubleshoot common issues with Managed Google Play for Android Enterprise devices enrolled in Microsoft Intune.
ms.date: 12/02/2021
ms.prod-support-area-path:
---
# Troubleshoot Managed Google Play apps on Intune-managed devices

This article gives information and troubleshooting steps for common issues with Managed Google Play app on Intune-managed Android Enterprise devices. 

## Managed Google Play apps that aren't deployed through Intune are displayed in the work profile

System apps can be enabled in the work profile by the device OEM at the time that the work profile is created. This isn't controlled by the MDM provider.

To troubleshoot, follow these steps:

  1. Collect Company Portal logs.
  2. Note apps that appear in the work profile unexpectedly.
  3. Un-enroll the device from Intune and uninstall Company Portal.
  4. Install the [Test DPC](https://play.google.com/store/apps/details?id=com.afwsamples.testdpc) app, which allows creation of a work profile without an EMM for testing.
  5. Follow the instructions in [Test DPC](https://play.google.com/store/apps/details?id=com.afwsamples.testdpc) to create a work profile on the device.
  6. Review apps that appear in the work profile.
  7. If the same applications show in the Test DPC app, the apps are expected by the OEM for that device.

## Unapproved Managed Google Play for Work store apps aren't being removed from the Client Apps page in Intune

This is expected behavior.

## Managed Google Play apps aren't being reported under the Discovered Apps blade in the Intune portal

This is expected behavior. Only system apps installed in the Work Profile are inventoried in the Discovered Apps blade. To see installed Managed Google Play apps, use the **Managed Apps** blade.
