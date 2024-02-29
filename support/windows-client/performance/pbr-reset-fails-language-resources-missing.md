---
title: Push-button reset fails because language resources are missing
description: Fixes an issue in which Push-button reset fails because language resources are missing.
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.reviewer: kaushika
ms.custom: sap:servicing, csstroubleshoot
localization_priority: medium
---

# Push-button reset fails because language resources are missing

This article describes an issue in which push-button reset fails because language resources are missing, and provides a workaround for the issue.

_Applies to:_ &nbsp; Windows 10 Education, version 2004

## Symptoms

Push-button reset (PBR) fails and a user receives the error message, **There was a problem resetting your PC. ErrorCode 0x80041002, WBEM_E_NOT_FOUND**.

The issue occurs after leaving a personal computer (PC) idle, and a PBR Reset command is executed. This issue may also occur after executing a **SilentCleanup** task. The issue is seen PCs with multiple language resources.

## Cause

This error is a known issue. If PBR fails in an early stage and rollback, the rollback process will set the Windows Recovery Environment (WinRE) Boot Configuration Data (BCD) as the default BCD entry, but will fail to restore the default BCD entry to the Operating System (OS). Changing the default BCD entry to the WinRE entry will cause a successful PBR to delete the WinRE entry, and disable the WinRE BCD.

The following steps reproduce this error:

1. Set up a PC without including language resource 2020.8B.

2. Execute SilentCleanupTask manually.

3. Apply language resource 2020.8B to the PC.

4. Execute PBR Reset/Refresh. PBR fails with the error message, **There was a problem resetting your PC**.

This issue will be resolved in next Windows OS upgrade release.

## Resolution

### Workaround for users with internet

For users who can access internet:

When the issue is reproduced, WinRE is installed correctly, but its BCD entry is accidentally deleted. To correct this issue, run the `Reagentc /enable` command twice from an administrator command prompt.

When the first `Reagentc /enable` runs, it will ask about the state of the WinRE, and it will detect the current WinRE state. Although `Reagentc /enable` cannot fix the issue, it will perform a cleanup, and will fully uninstall the WinRE. The WinRE file still exists (copied to staging location) allowing it to be enabled in the future.

When the second `Reagentc /enable` runs, the WinRE file is purged. It can then be installed for the OS, and run without issue.

> [!NOTE]
> When `Reagentc /enable` runs for the first time, it will report the error message, **Unable to update Boot Configuration Data**.
>
> When `Reagentc /enable` runs for the second time, WinRE will be enabled.

### Workaround for users without internet access

For users who can't access internet:

1. Apply language resource 2020.8B.
1. Run `Dism /online /cleanup-image /restorehealth`.
1. Run **PBR Reset/Refresh**.
1. Attempt a PBR.
1. Rerun **PBR Reset/Refresh**.
1. Run `reagentc /enable` twice.
1. Run the **PBR Reset/Refresh**.

> [!NOTE]
> There is a scenario that is currently under investigation where the `Reagentc /enable` will not fix the issue previously discussed. If the staging location is same as the location of the WinRE, the current logic of `Reagentc /enable` will not work. Microsoft is updating the logic in `Reagentc /enable`, and will release the updated command as part of a Latest Cumulative Update (LCU).

## More information

- [Push-button reset](/windows-hardware/manufacture/desktop/push-button-reset-overview)
- [How Push-button reset works](/windows-hardware/manufacture/desktop/how-push-button-reset-features-work)
- [Windows Recovery Environment (Windows RE)](/windows-hardware/manufacture/desktop/windows-recovery-environment--windows-re--technical-reference)
