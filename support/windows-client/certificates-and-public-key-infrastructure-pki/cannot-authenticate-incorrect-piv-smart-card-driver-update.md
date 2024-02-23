---
title: Can't authenticate because of incorrect PIV
description: Describes how to resolve a problem that is caused by an incorrect driver update. The user can't sign in to Windows until the incorrect driver is removed.
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: ccraig, wincicadsec, kaushika
ms.custom: sap:smart-card-logon, csstroubleshoot
---
# Can't authenticate because of an incorrect PIV smart card driver update

This article describes how to resolve a problem where users can't sign in to Windows until the incorrect driver is removed.

_Applies to:_ &nbsp; Windows 10, version 2004, Windows 10, version 1909, Windows 10, version 1903  
_Original KB number:_ &nbsp; 4563240

## Summary

If you use a Personal Identity Verification (PIV) smart card or any multifunction device that uses PIV smart cards that rely on the Windows Inbox Smart Card Minidriver, you may have received an incorrect driver update. When you try to use a smart card to authenticate to Windows, you might receive error messages such as "This smart card cannot be used" or "The operation requires a different smart card."

The incorrect update contains the "FEITIAN - SmartCard - 1.0.0.3" provider app that installs the Feitian xPass Smart Card driver. This is a legitimate, signed update that was published by a verified partner. However, it was inadvertently targeted to a broader set of devices than it was originally intended for.

The driver has been pulled from the Windows Update publishing system. To mitigate any adverse effects, any user who received the update has to manually roll back to the Windows inbox driver. For more information, see the "[Resolution](#resolution)" section.

## Symptoms

You observe one or more of the following symptoms:

- You try to sign in to Windows by using a PIV smart card or a device (such as a YubiKey) that supports PIV smart cards and relies on the [Windows Inbox Smart Card Minidriver](/windows-hardware/drivers/smartcard/windows-inbox-smart-card-minidriver). However, you can't sign in.
- You try to sign in to Windows by using a non-Feitian-branded PIV smart card device. However, you can't sign in. If the device supports Fast Identity Online (FIDO) capabilities, such as U2F or FIDO2, those capabilities continue to work.
- The invalid xPass Smart Card driver doesn't correctly interface with other non-Feitian devices that rely on the inbox driver. This generates error messages such as "This smart card cannot be used."

The following example shows the results of the **certutil -scinfo** command that runs on an affected computer. The certificates were generated as part of a Microsoft AD CS enrollment. However, they're no longer able to interface with the YubiKey PIV device after the xPass Smart Card driver is installed.

:::image type="content" source="media/cannot-authenticate-incorrect-piv-smart-card-driver-update/certutil-scinfo-command-result.png" alt-text="Screenshot of the output of certutil -scinfo command, which indicates there is a PIV Smart Card driver problem.":::

## Cause

The Feitian xPass Smart Card driver version 1.0.0.3 specifies SCFILTER\CID_2777BE07-6993-4513-BD80-C184FCB0AB2D as a [compatible identifier](/windows-hardware/drivers/install/compatible-ids) in the .inf file of its driver package. However, the Windows inbox smart card minidriver for PIV smart cards (Identity Device (NIST SP 800-73 [PIV])) uses the same compatible identifier. If you connect a non-Feitian device that uses the inbox driver to your computer, Windows recognizes the Feitian driver as compatible. Windows downloads, installs, and loads the Feitian driver.

For more information about how Windows selects drivers for a device, see [Overview of the Driver Selection Process](/windows-hardware/drivers/install/overview-of-the-driver-selection-process) and [How Windows selects a driver for a device](/windows-hardware/drivers/install/how-windows-selects-a-driver-for-a-device).

## Resolution

If the Feitian xPass Smart Card driver has been installed on your computer, you have to remove it to revert to the inbox Identity Device (NIST SP 800-73 [PIV]) driver. After you remove the xPass Smart Card driver, Windows automatically loads the inbox driver for the device.

To do this, you can manually delete the driver, or create and run a script to delete it.

### Determine whether your computer is affected

In Settings, select **Updates & Security** > **View update history**. You should be able to identify the driver update in the list.

:::image type="content" source="media/cannot-authenticate-incorrect-piv-smart-card-driver-update/driver-updates.png" alt-text="Screenshot of the Driver update list in the Windows update history list." border="false":::

### Manually delete the driver

To manually remove the driver, follow these steps:  

1. Connect the smart card device to the computer.
2. Start Device Manager. You can start Device Manager from Control Panel, or by pressing **Windows** + **R**, and then entering **devmgmt.msc**.
3. Select **Smart cards**, right-click **xPass Smart Card**, and then select **Uninstall device**.

    :::image type="content" source="media/cannot-authenticate-incorrect-piv-smart-card-driver-update/uninstall-device.png" alt-text="Screenshot of the Uninstall device option of xPass Smard Card item in Device Manager." border="false":::

4. When you're prompted, select **Delete the driver software for this device**, and then select **Uninstall**.

    :::image type="content" source="media/cannot-authenticate-incorrect-piv-smart-card-driver-update/select-uninstall.png" alt-text="Screenshot of the Delete the driver software for this device option in the Uninstall Device dialog." border="false":::

### Create a script to delete the driver

To automate the driver removal, create a script that can run in a batch file. The script identifies the driver .inf file name and uses PnPUtil.exe to delete the driver. The script can delete the driver even if a smart card or smart card device isn't connected to the computer. To create and use such a script, follow these steps:  

1. Create a batch file that contains the following command sequence:

    ```console
    @echo off

    for /r %windir%\System32\DriverStore\FileRepository %%i in (*eps_piv_csp11.inf*) do (@echo %%i  
    pnputil /delete-driver %%i /uninstall /force)

    pause
    ```

2. On the affected computer, run the batch file in an administrative Command Prompt window.

## More information

If you've followed the steps in the "Resolution" section but you need additional help, go to the [Microsoft Support](https://support.microsoft.com/)  website.
