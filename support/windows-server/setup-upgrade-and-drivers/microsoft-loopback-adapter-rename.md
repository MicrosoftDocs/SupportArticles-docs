---
title: Installing the Microsoft Loopback Adapter in Windows
description: Fixes an issue where you can't find the Microsoft Loopback Adapter.
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:driver-installation-or-driver-update, csstroubleshoot
---
# Installing the Microsoft Loopback Adapter in Windows

This article helps fix an issue where you can't find the Microsoft Loopback Adapter.

_Applies to:_ &nbsp; Windows 10 – all editions, Windows Server 2012 R2  
_Original KB number:_ &nbsp; 2777200

## Symptoms

You're trying to install the Microsoft Loopback Adapter, but are unable to find it.

## Cause

The Microsoft Loopback Adapter was renamed in Windows 8 and Windows Server 2012. The new name is "Microsoft KM-TEST Loopback Adapter".

## Resolution

When using the Add Hardware Wizard to manually add a network adapter, choose Manufacturer "Microsoft" and choose network adapter "Microsoft KM-TEST Loopback Adapter".

## Data collection

If you need assistance from Microsoft support, we recommend you collect the information by following the steps mentioned in [Gather information by using TSS for deployment-related issues](../../windows-client/windows-troubleshooters/gather-information-using-tss-deployment.md).
