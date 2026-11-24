---
title: Troubleshoot MsiInstaller Event ID 1024 after a successful System Center Operations Manager Update Rollup or Hotfix installation
description: Learn how to resolve MsiInstaller Event ID 1024 (error 1603) logged after a successful System Center Operations Manager update rollup or hotfix install.
ms.date: 11/24/2026
ms.topic: troubleshooting
manager: dcscontentpm
author: kaushika-msft
ms.author: kaushika
ms.reviewer: v-hsalipalli, manojparvathaneni, jochan 
ms.service: system-center
ai-usage: ai-assisted
---
# Troubleshoot "MsiInstaller Event ID 1024" after a successful System Center Operations Manager Update Rollup or hotfix installation

## Summary

**MsiInstaller Event ID 1024** (error code 1603) can appear in the **Application** event log after you successfully install a System Center Operations Manager update rollup or hotfix. This article explains how to reinstall the affected hotfix or patch so the error no longer appears.

> [!NOTE]
> This event is a false positive and doesn't indicate that the hotfix installation failed. A future release will address this issue.

## Remediation steps

> [!NOTE]
> Before you begin, ensure that you have access to the corresponding System Center Operations Manager RTM installation media and the installation package for the affected hotfix or patch.

To remediate the issue and reinstall the affected hotfix or patch without encountering the error, follow these steps:

1. Back up the System Center Operations Manager operational and data warehouse databases.
2. If the affected System Center Operations Manager management server is hosted on a virtual machine (VM), create a snapshot or checkpoint of the VM.
3. Back up the **Microsoft.SystemCenter.DBUpdateTask.mpb** file from the following directory: `C:\Program Files\Microsoft System Center\Operations Manager\Server\Management Packs for Update Rollups`
4. From the corresponding System Center Operations Manager RTM installation media, copy the **Microsoft.SystemCenter.DBUpdateTask.mpb** file from the Management Packs folder.
5. Uninstall the affected hotfix or patch. Replace `RTMPatchGUID` and `PatchGUID` with the applicable GUIDs, and then run the following command:

   `msiexec /package {RTMPatchGUID} /uninstall {PatchGUID} /qb /l*v Hotfix_Uninstall.log`

6. Replace the **Microsoft.SystemCenter.DBUpdateTask.mpb** file in the following directory with the RTM version you copied in step 4:
   `C:\Program Files\Microsoft System Center\Operations Manager\Server\Management Packs for Update Rollups`
7. In the **Operations** console, uninstall the **Microsoft.SystemCenter.DBUpdateTask.mpb** management pack.
8. Reinstall the applicable System Center Operations Manager hotfix or patch by using the following command:

   `msiexec.exe /p KBXXXXXX-amd64-component.msp /qn /l*vx %temp%\KBXXXXXX-amd64-component.log`

   > [!NOTE]
   > You can also follow the instructions provided in the Installation Instructions section for the hotfix. 

9. After the hotfix or patch installation completes successfully, restore the **Microsoft.SystemCenter.DBUpdateTask.mpb** file that you backed up in step 3 to the following directory: `C:\Program Files\Microsoft System Center\Operations Manager\Server\Management Packs for Update Rollups`
10. In the **Operations** console, import the restored **Microsoft.SystemCenter.DBUpdateTask.mpb** management pack.

## Verify the remediation

After completing the remediation steps, perform the following steps:

1. Verify that the hotfix or patch is installed successfully.
2. Verify that the **Microsoft.SystemCenter.DBUpdateTask.mpb** management pack is successfully imported and available in the **Operations** console.
3. Confirm that the hotfix or patch installation no longer reports the error.
