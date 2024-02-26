---
title: Firmware update failures in Windows 8.1
description: Describes how and why firmware updates occasionally fail in a Windows 8.1 environment.
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:driver-installation-or-driver-update, csstroubleshoot
---
# Firmware update failures in Windows 8.1

This article describes how and why firmware updates occasionally fail in a Windows 8.1 environment.

_Applies to:_ &nbsp; Windows 8.1  
_Original KB number:_ &nbsp; 2909710

## Summary

Computers that are running Windows may use Windows Update to update their firmware. Specifically, these computers use Windows driver packages to install firmware updates. After a firmware driver package has been installed, Windows hands off the firmware updates to UEFI system firmware for installation during your computer's next restart. UEFI system firmware is provided by your computer manufacturer and is separate from Windows. Windows itself doesn't install firmware updates but instead hands off firmware updates to the UEFI system firmware for your computer.

## More information

Firmware updates are provided by your computer manufacturer to help improve the stability and performance of your PC. Sometimes firmware updates may not be installed correctly. UEFI system firmware uses a set of return codes to report back to Windows about the success or failure of a firmware installation attempt. These return codes are available in Device Manager and are also reported by Windows Update. In some cases, Windows Update may try to reinstall firmware updates after the initial attempt, depending on the type of failure.

This article describes how to determine whether your PC is using Windows Update and UEFI to install firmware updates. It also describes what each return code means. Finally, it summarizes the Windows Update notifications that you can expect to receive after a failed firmware installation attempt.

### How to tell whether your PC installs firmware updates

Windows PCs that use Windows Update to install firmware updates will have "System Firmware Update" entries in the **View your update history for Windows** page of Windows Update.

To view your update history in Windows Update:

1. On the **Start** screen, type _update history_, and then click **View your update history for Windows**.
2. In the search box, enter _Windows Update_, and then select **View update history**. You can also view the error codes that are returned for a failed firmware update by selecting the failed System Firmware Update entry in your update history. The update history page in Windows Update includes a status column, and this indicates which updates failed to install successfully. You can select the entry and open it to see details about the installation, including the installation status and error details.

A computer that uses UEFI to update firmware may also have entries for updatable firmware components in Device Manager. To determine whether your computer uses UEFI to update firmware, follow these steps:

1. From the computer's desktop, open File Manager.
2. In File Manager, right-click **This PC**, and then click **Properties**.
3. Click **Device Manager**.
4. If your computer is using UEFI to manage firmware, there will be a Firmware group under the PC root of Device Manager. Expand the Firmware group to see each updatable firmware component.

    Firmware that wasn't installed successfully will have a "banged out" (!) entry under the Firmware group.
5. You can right-click a failed firmware component and then click **Properties** to see the error codes that were returned. By combining the preceding two checks, you can determine whether your computer is updating firmware through both Windows Update and UEFI.

> [!IMPORTANT]
> Firmware entries in Device Manager are not guaranteed to be returned from UEFI. In some cases, Windows drivers may install firmware that then is listed under the Firmware group. If you are uncertain about whether your PC is using UEFI, contact your PC manufacturer. You can also view the Hardware IDs details for a particular firmware resource in its properties. UEFI firmware resources are prepended by UEFI\\ in the device hardware ID.

### Transient vs. non-transient failure codes

Windows separates UEFI firmware update failures into two categories: transient and non-transient.

#### Transient failures

Transient failures occur because of temporary conditions such as insufficient battery power or lack of system resources. Windows may try to reinstall firmware updates that fail under these circumstances.

For example, your PC may require a certain level of battery power (for example, 25 percent) to install firmware updates. Firmware updates that have failed to install because of low battery power are always retried after the next computer restart. If your PC doesn't have the required battery power available, firmware updates may fail to install. However, Windows will continue to try to install the firmware update at each restart. This battery level check is enforced by both Windows and your computer's UEFI system firmware to make sure that your PC doesn't lose power during a critical firmware update operation.

> [!IMPORTANT]
> Windows and UEFI ignore available A/C power and only check the available battery level of your PC. If your battery does not charge beyond the required level, you may not be able to install future firmware updates. If the battery for your PC does not charge, contact your PC manufacturer.

Windows will make a total of three installation attempts after the next three restarts for other transient failures such as a lack of system resources or other reasons that are returned by your UEFI system firmware. If your firmware update fails to install on the third and final restart, Windows won't try to install the firmware update again, and it will be marked as failed in both Device Manager and Windows Update history. The update won't be tried again until your PC manufacturer releases a new update that replaces the failed update.

#### Non-transient failures

Non-transient firmware update failures are caused by a condition that can't be repaired. Windows doesn't try to reinstall firmware updates that fail because of non-transient conditions.

Installation of the update won't be retried until your PC manufacturer releases a new update the replaces the failed update.

Windows retries firmware updates as follows.

| Error condition| Number of retries |
|---|---|
|Transient|3|
|Transient: power condition|No limit|
|Non-transient|0|
  
### Windows Update power checks

Because your computer may require a certain level of battery power (for example 25 percent) to install firmware updates, Windows Update monitors your battery power level to prevent your computer from needlessly failing a firmware update during an _interactive install_.

During an interactive install, a user manually checks for updates from the Windows Update control panel or the Settings app and then manually starts the update process. An _automatic background install_ occurs in the background, staging the new updates that are available for your PC and notifying you that your PC requires a restart. Most of your updates are installed automatically in the background.

Windows Update will verify that your PC has at least 40-percent battery power before it starts firmware updates during an interactive install. During an automatic background install, Windows Update doesn't check for the 40-percent battery power threshold. This behavior occurs because Windows won't try to restart your PC until you have at least 40-percent battery power. Additionally, it will automatically retry installation of failed firmware updates when the battery charges to 40 percent or more.

| Windows Update install type| Battery power check |
|---|---|
|Interactive Install|Battery power level must be at least 40% for all interactive install attempts. If you try to install firmware with < 40% battery, Windows Update prompts you to "Plug your PC into power, let it fully recharge, and try again."|
|Automatic Background|None. Firmware will always be staged for the next reboot during automatic background installs. Reboot to complete the install will be enforced only when battery power is greater than 40%.|
  
#### Error codes

The following table lists the LastAttemptStatus error that's reported by UEFI system firmware and the matching NTSTATUS code that's reported by Windows in both Device Manager and Windows Update history. The table also lists the number of times Windows tries to reinstall firmware for each failure code, and the expected Windows Update behavior and update history for each code.

Contact your PC manufacturer for support with failed firmware updates.

> [!IMPORTANT]
>
> - If your PC restarts but does not meet the minimum battery power required by UEFI system firmware, the firmware update may fail to install and will fail with one of the power failure codes in the following table. Windows Update may prompt you to reboot your PC after your battery charges to 40% in the case of a firmware update that has failed a battery power check.
> - Windows and UEFI ignore available A/C power and check only the available battery power level. If your battery will not charge above the required level, you may be unable to install future firmware updates. If the battery for your PC does not charge, contact your PC manufacturer.
> - Transient failures that are not power-related will transition from displaying a "pending reboot" status in Windows Update to "failed" after the third failed installation attempt.
> - Non-transient firmware updates or transient firmware updates that have failed all three install attempts will not be retried until they are replaced by a new firmware update from your PC manufacturer.

| LastAttemptStatus| NTSTATUS| Code| Retries| Windows Update after Automatic Install Attempt| Status Shown in Windows Update History |
|---|---|---|---|---|---|
| _Success_| _STATUS_SUCCESS_| _0x00000000_| _N/A_| _None_| _None_ |
|Error: Unsuccessful|STATUS_UNSUCCESSFUL|0xC0000001|3|Windows Update shows "updates available." Later installation attempts through Windows Update or automatic maintenance will retry the firmware installation.|Pending Restart during the first 3 attempts, then "Failed" with the associated failure code.|
|Error: Insufficient Resources|STATUS_INSUFFICIENT_RESOURCES|0xC000009A|3|
|Error: Incorrect Version|STATUS_REVISION_MISMATCH|0xC0000059|0|Windows Update no longer shows update as available. No other status is provided.|History shows "Failed" and the associated failure code.|
|Error: Invalid Image Format|STATUS_INVALID_IMAGE_FORMAT|0xC000007B|0|
|Error: Unknown Revision|STATUS_UNKNOWN_REVISION|0xC0000058|0|
|Error: No Such File|STATUS_NO_SUCH_FILE|0xC000000F|0|
|Error: Authentication Error|STATUS_ACCESS_DENIED|0xC0000022|3|Windows Update shows "updates available." Later installation attempts through Windows Update or automatic maintenance will retry the firmware installation.|Pending restart during the first 3 attempts, then "Failed" with the associated failure code.|
|Error: Power Event, AC Not Connected|STATUS_POWER_STATE_INVALID|0xC00002D3|No Limit|Windows Update shows "updates available." 15-minute restart timer will also start immediately after battery is recharged to >= 40%.|Pending restart|
|Error: Power Event, Insufficient Battery|STATUS_INSUFFICIENT_POWER|0xC00002DE|No Limit|

## Data collection

If you need assistance from Microsoft support, we recommend you collect the information by following the steps mentioned in [Gather information by using TSS for deployment-related issues](../windows-troubleshooters/gather-information-using-tss-deployment.md).
