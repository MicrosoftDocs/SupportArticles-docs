---
title: A high pitched noise is heard when using Bluetooth headphones
description: Provides a solution to an issue where a high pitched noise is heard when using Bluetooth headphones.
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:Windows Device and Driver Management\Peripherals driver installation or update, csstroubleshoot
---
# A high pitched noise is heard when using Bluetooth headphones in Windows 8

This article provides a solution to an issue where a high pitched noise is heard when using Bluetooth headphones.

_Applies to:_ &nbsp; Windows 8  
_Original KB number:_ &nbsp; 2800101

## Symptoms

Consider the following scenario:

- You have Windows 8 installed on a computer with a Bluetooth transceiver.
- You have Bluetooth A2DP headphones or speakers paired to the Bluetooth transceiver on the computer.
- Music or audio is streamed to the headphones or speakers.

In this scenario, you may hear a high pitched noise coming from the Bluetooth A2DP audio output device. This noise is audible even if the volume of the output device is set to 0.

## Resolution

This issue is fixed by going to Windows Update and installing the latest important updates for your computer. If Windows Update is unavailable for your computer, a stand-alone cumulative update package for Windows 8 that has fixes to address this issue and others can be found on the [Microsoft Download Center](https://download.microsoft.com/) and then searching for KB2785094.

## More information

Advanced Audio Distribution Profile (A2DP) is a profile that defines how high-quality audio is streamed to a device over a Bluetooth connection.

## Data collection

If you need assistance from Microsoft support, we recommend you collect the information by following the steps mentioned in [Gather information by using TSS for deployment-related issues](../windows-troubleshooters/gather-information-using-tss-deployment.md).
