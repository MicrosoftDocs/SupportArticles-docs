---
title: Windows Virtual Desktop sign-in screen is blank
description: Troubleshoot when Windows Virtual Desktop sign-in screen is blank
author: v-miegge
ms.author: jerrycif
ms.service: virtual-desktop
manager: dscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.date: 02/09/2021
---

# Windows Virtual Desktop sign-in screen is blank

**Windows Virtual Desktop** (WVD) users might encounter sign-in issues that result in a black screen. There are multiple possible causes for black screens, but users can be impacted from issues synchronizing with **AppReadiness**, and multiple sessions signing in or out.

## Causes

The following list contains known scenarios causing black screens, and the non-security fixes which address them. This list does not cover every possible reason a black screen can occur. Verify that you have the latest updates, as blank screen updates are being released on a near-monthly basis.

|Issue|Version of Windows|Article #|
|---|---|---|
|The AppReadiness service sometimes fails to shutdown waiting for some COM objects to disconnect. Resulting in failed user sign in or black screen in WVD scenario.|Windows 2004|[October 1, 2020—KB4577063 (OS Build 19041.546) Preview (microsoft.com)](https://support.microsoft.com/topic/october-1-2020-kb4577063-os-build-19041-546-preview-7d0e27fb-f971-dbc6-aebe-f3026873412d)|
||Windows 1909 & 1903|[September 16, 2020—KB4577062 (OS Builds 18362.1110 and 18363.1110) Preview (microsoft.com)](https://support.microsoft.com/topic/september-16-2020-kb4577062-os-builds-18362-1110-and-18363-1110-preview-0a7c8d93-3b09-a29f-3ff4-24898996ee15)|
||Windows 1809|[September 16, 2020—KB4577069 (OS Build 17763.1490) Preview (microsoft.com)](https://support.microsoft.com/topic/september-16-2020-kb4577069-os-build-17763-1490-preview-fcc63e7f-dbf1-ab01-9a11-1f79983e8526)|
|Addresses an issue where the WVD user might experience a blank screen during sign-in.|Windows 2004|[November 30, 2020—KB4586853 (OS Builds 19041.662 and 19042.662) Preview (microsoft.com)](https://support.microsoft.com/topic/november-30-2020-kb4586853-os-builds-19041-662-and-19042-662-preview-8fb07fb8-a7dd-ea62-d65e-3305da09f92e)|
||Windows 1909 & 1903|[November 19, 2020—KB4586819 (OS Builds 18362.1237 and 18363.1237) Preview (microsoft.com)](https://support.microsoft.com/topic/november-19-2020-kb4586819-os-builds-18362-1237-and-18363-1237-preview-25cbb849-74af-b8b8-29b8-68aa925e8cc3)|
||Windows 1809|[November 19, 2020—KB4586839 (OS Build 17763.1613) Preview (microsoft.com)](https://support.microsoft.com/topic/november-19-2020-kb4586839-os-build-17763-1613-preview-aeebda71-959c-48e0-204f-7d9dc84db0f0)|
|Addresses an issue that displays a black screen to Windows Virtual Desktop (WVD) users when they attempt to sign in.|1909 &1903|[October 20, 2020—KB4580386 (OS Builds 18362.1171 and 18363.1171) Preview (microsoft.com)](https://support.microsoft.com/topic/october-20-2020-kb4580386-os-builds-18362-1171-and-18363-1171-preview-7a1b577a-fb8b-7d8a-7be9-9908281a2d01)|
||Windows 1809|[October 20, 2020—KB4580390 (OS Build 17763.1554) Preview (microsoft.com)](https://support.microsoft.com/topic/october-20-2020-kb4580390-os-build-17763-1554-preview-ac4799c9-838f-8665-a968-0f19b6cb1049)|
|Desktop gets a black screen due to shell not starting AppXSvc deadlock. Addresses an issue that displays a black screen to Windows Virtual Desktop users when they attempt to sign in.|Windows 2004|[September 3, 2020—KB4571744 (OS Build 19041.488) Preview (microsoft.com)](https://support.microsoft.com/topic/september-3-2020-kb4571744-os-build-19041-488-preview-0efa4a7a-3947-6b9a-589e-c91fdb8ef291)|
||Windows 1909 & 1903|[April 21, 2020—KB4550945 (OS Builds 18362.815 and 18363.815) (microsoft.com)](https://support.microsoft.com/topic/april-21-2020-kb4550945-os-builds-18362-815-and-18363-815-1c4a510e-903d-a051-a959-ed3e2567a1d2)|
||Windows 1809|[April 21, 2020—KB4550969 (OS Build 17763.1192) (microsoft.com)](https://support.microsoft.com/topic/april-21-2020-kb4550969-os-build-17763-1192-ef6db414-da26-863e-f113-868741998b9b)|

## Resolution

> [!NOTE]
> Workarounds should not be considered long-term solutions. Back up your registry keys anytime that you test changes.
If the black screen is tied with **AppReadiness** issues, set the following registry entries for the **AppReadiness** pre-shell task, and then change the first sign-in’s timeout window to 30 seconds to avoid the black screen for the first user’s sign-in.  

|Registry Location|Data Type|Value|New timeout duration|
|---|---|---|---|
|`HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\AppReadinessPreShellTimeoutMs`|Data Type: `DWORD`|Value: `0x7530`|30000 ms = 30s|
|`HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System\FirstLogonTimeout`|Data Type: `DWORD`|Value: `0x1e`|30000 ms = 30s|
|`HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System\DelayedDesktopSwitchTimeout`|Data Type: `DWORD`|Value: `0x1e`|30000 ms = 30s|

## More Information

If you continue to see black screens after you confirm that you have the latest updates, perform a **full memory dump** and include it in a support case.

Find the steps to enable and collect a **dump file** at [Collect an OS memory dump](https://docs.microsoft.com/azure/virtual-machines/troubleshooting/boot-error-troubleshoot-windows#collect-an-os-memory-dump)
