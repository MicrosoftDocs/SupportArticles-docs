---
title: Device configuration profile error 2016281112 
description: Fixes a problem that occurs in a custom VPN profile after you create and assign a device configuration profile in the Microsoft Intune portal.
ms.date: 12/05/2023
search.appverid: MET150
ms.custom: sap:Configure Devices - Windows\VPN settings
ms.reviewer: kaushika, Joelste, intunecic, chhahn
---
# 2016281112 (Remediation Failed) error in a custom VPN profile in the Intune admin portal

This article discusses a **2016281112 (Remediation Failed)** error message in Intune.

## Symptoms

After you create and assign a device configuration profile that defines a custom VPN connection by using OMA-URI settings, Windows 10 clients receive the profile and can connect to the VPN endpoint successfully. However, the profile reports a **2016281112 (Remediation Failed)** error message in the Microsoft Intune admin center.

## Cause

This issue occurs because, in certain scenarios, the response that is sent by the Windows 10 client includes XML that is formatted differently than the XML that is sent through the Intune policy.

If the policy is applied successfully, the XML in the response should exactly match the XML in the policy. This is how Intune verifies that the policy has been applied correctly. If the XML differs between the policy and the client response, Intune interprets the mismatch as a remediation failure.

## Solution

You can safely ignore this error because the connection works as expected.

Alternatively, you can create a standard VPN device configuration profile instead of using a custom profile that uses OMA-URI settings. If you [create a standard profile](/mem/intune/configuration/vpn-settings-configure#create-the-profile), Intune does not generate the error message that is described in the **Symptoms** section.

This is a known issue in all versions of Windows 10 up to and including Windows 10, version 1809. This issue is scheduled to be addressed in a future Windows 10 release.
