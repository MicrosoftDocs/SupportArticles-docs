---
title: Cannot automate websites and apps requiring Windows credentials
description: Provides workarounds for automating the Windows credentials popup dialog.
ms.reviewer: iomavrid
ms.date: 03/12/2026
ms.custom: sap:Desktop flows
---

# Can't automate websites and apps requiring Windows credentials

_Applies to:_ &nbsp; Power Automate  

## Symptoms

Power Automate for desktop has stopped interacting properly with dialogs that prompt for Windows credentials. Examples of these windows are the following: 

:::image type="content" source="media/cannot-automate-websites-and-apps-requiring-windows-credentials/windows-credentials-dialog-website.png" alt-text="Screenshot that shows a web page requesting for Windows credentials.":::

:::image type="content" source="media/cannot-automate-websites-and-apps-requiring-windows-credentials/windows-credentials-dialog-app.png" alt-text="Screenshot that shows a desktop application requesting for Windows credentials.":::

## Cause

A security fix for the CredentialUIBroker.exe, introduced by Windows Updates released on and after January 13, 2026, is causing automated authentication workflows to fail. This exe is used by browsers and UI applications, like Remote Desktop Connection, so that users can log in with their Windows credentials. The "1B.26" Windows Updates that introduced this change include:

KB [5074109](https://support.microsoft.com/en-us/topic/january-13-2026-kb5074109-os-builds-26200-7623-and-26100-7623-3ec427dd-6fc4-4c32-a471-83504dd081cb): January 13, 2026—KB5074109 (OS Builds 26200.7623 and 26100.7623) <- The 1B.26 Windows Update Windows 11 25H2 and 24H2

KB [5073455](https://support.microsoft.com/en-us/topic/january-13-2026-kb5073455-os-build-22631-6491-2b25841a-1d56-4e3d-9331-6f79872efea4): January 13, 2026—KB5073455 (OS Build 22631.6491) <- The 1B.26 Windows Update for Windows 11 23H2

KB 5073724: January 13, 2026—KB5073724 (OS Builds 19045.6809 and 19044.6809) <- The 1B.26 Windows Update for Windows 10 ESU + Enterprise LTSC 2021

KB [5073723](https://support.microsoft.com/en-us/topic/january-13-2026-kb5073723-os-build-17763-8276-cc521cb1-c774-41da-b7fa-6906c9450230): January 13, 2026—KB5073723 (OS Build 17763.8276) <- The 1B.26 Windows Update for Windows 10 Ent LTSC 2019

KB [5073379](https://support.microsoft.com/en-us/topic/january-13-2026-kb5073379-os-build-26100-32230-a6021fd2-b3b7-45a7-b68e-35c28a2a77da): January 13, 2026—KB5073379 (OS Build 26100.32230) <- The 1B.26 Windows Update for Windows Server 2025

KB [5073457](https://support.microsoft.com/en-us/topic/january-13-2026-kb5073457-os-build-20348-4648-d4d057c8-29c3-48a5-8d98-ce86b77ee570): January 13, 2026—KB5073457 (OS Build 20348.4648) <- The 1B.26 Windows Update for Windows Server 2022

KB [5073723](https://support.microsoft.com/en-us/topic/january-13-2026-kb5073723-os-build-17763-8276-cc521cb1-c774-41da-b7fa-6906c9450230): January 13, 2026—KB5073723 (OS Build 17763.8276) <- The 1B.26 Windows Update for Windows Server 2019

KB [5075999](https://support.microsoft.com/en-us/topic/february-10-2026-kb5075999-os-build-14393-8868-640ac4ff-7447-4805-b0f6-ce3049375fcb): February 10, 2026—KB5075999 (OS Build 14393.8868) <- The 1B.26 Windows Update for Windows Server 2016

After the release of the above updates, Power Automate for desktop is not able to automate these windows properly.

## Workarounds

The current workarounds for this issue until a fix is available are the following:

1. For web automation issues, you can use an alternative browser. Currently only Microsoft Edge is affected, so Firefox or Chrome should be used when possible.
2. You can run Power Automate for desktop as administrator for local attended (console) runs. This is not available for unattended/attended cloud runs.
