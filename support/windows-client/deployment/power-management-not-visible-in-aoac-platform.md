---
title: Power Management tab isn't visible for some Wireless Network adapters with AOAC platforms
description: Discusses a by-design behavior where the Power Management tab is no longer available in the Wireless Network advanced properties in an Always On/Always Connected (AOAC) platform.
ms.date: 04/28/2023
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.prod: windows-client
localization_priority: medium
ms.reviewer: kaushika, match
ms.custom: sap:devices-and-drivers, csstroubleshoot
ms.technology: windows-client-deployment
---
# Power Management tab is not visible for some Wireless Network adapters with AOAC platforms in Windows 8

This article discusses a by-design behavior where the Power Management tab is no longer available in the Wireless Network advanced properties in an Always-On/Always-Connected (AOAC) platform.

_Applies to:_ &nbsp; Windows 8  
_Original KB number:_ &nbsp; 2889143

## Summary

Consider the following scenario:

- You have a system that is an AOAC platform.
- The system is running Windows 8.
- You install the [July update rollup 2855336](https://support.microsoft.com/help/2855336).
- After the update is installed, you open up Device Manager.
- You open the Wireless Network adapter properties.

In this scenario, you notice that the **Power Management** tab is no longer available within the advanced driver properties.

## More information

This behavior is by design. For Windows 8, update rollup 2855336 implements this change for Wireless adapter miniports on AOAC platforms.

With AOAC platforms, Windows needs to systematically manage the adapter's power state to achieve Connected Standby. Thus, the **Power Management** tab is not provided for the user to uncheck the **Allow the computer to turn off this device to save power** option. On non-AOAC platforms, the **Power Management** tab is retained.

This update rollup also addresses an issue on both platforms, in which the system might not be able to wake up after the system goes to sleep if the wireless adapter supports OID_RECEIVE_FILTER_SET_FILTER and the checkbox **Allow the computer to turn off this device to save power** is unchecked. This filter is used when an adapter supports NDIS packet coalescing, SR-IOV, or VMQ.

## Data collection

If you need assistance from Microsoft support, we recommend you collect the information by following the steps mentioned in [Gather information by using TSS for deployment-related issues](../windows-troubleshooters/gather-information-using-tss-deployment.md).
