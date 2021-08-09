---
title: Restrict USB devices with Intune administrative templates
description: Introduces how to use Intune administrative templates to configure device profile to restrict USB devices.
author: helenclu
ms.author: luche
ms.reviewer: kufang
ms.date: 08/27/2020
ms.prod-support-area-path: Device configuration
---
# Restrict USB devices by using Intune Administrative Templates

To prevent malware infections or data loss in your organization, you may want to block certain kinds of USB devices, such as a USB flash drive or camera, and allow other kinds of USB devices, such as a keyboard or mouse. Or, you may want to allow USB devices by device IDs.

This article describes how to configure such controls using the Intune Administrative Templates.

## Create the profile

1. Sign in to the [Microsoft Endpoint Manager admin center](https://go.microsoft.com/fwlink/?linkid=2109431).
2. Select **Devices** > **Configuration profiles** > **Create profile**.
3. Select **Windows 10 and later** in **Platform**, select **Administrative Templates** in **Profile**, then select **Create**.
4. In **Basics**, enter a descriptive name for the profile in **Name**. For example, **Restrict USB devices**. Enter a description for the profile in **Description** (this setting is optional).
5. Select **Next**.
6. In **Configuration settings**, configure the following settings:

    - Select **Prevent installation of devices not described by other policy settings**, and then select **Enabled**.

      :::image type="content" source="./media/restrict-usb-with-administrative-template/prevent-installation-setting.png" alt-text="Prevent installation of devices not described by other policy settings":::
    - Select **Allow installation of devices using drivers that match these device setup classes**, and then select **Enabled**. Add the [GUID of device classes](/windows-hardware/drivers/install/system-defined-device-setup-classes-available-to-vendors) that you want to allow. In the following example, Keyboard, Mouse, and Multimedia classes are allowed.

      :::image type="content" source="./media/restrict-usb-with-administrative-template/allow-installation-device-class.png" alt-text="Allow installation of devices using drivers that match these device setup classes":::
    - Select **Allow installation of devices that match any of these Device IDs**, and then select **Enabled**. [Look up the device vendor ID or product ID](/windows/security/threat-protection/device-control/control-usb-devices-using-intune#look-up-device-vendor-id-or-product-id) for devices that you want to allow, and then add the IDs to the list.

       :::image type="content" source="./media/restrict-usb-with-administrative-template/allow-installation-device-id.png" alt-text="Allow installation of devices that match any of these Device IDs":::
7. In **Assignments**, select the device groups that will receive the profile, and then select **Next**.
8. In **Review + create**, review your settings. When you select **Create**, your changes are saved and the profile is assigned.

## Verify on Windows 10 devices

After the device configuration profile is deployed to the targeted Windows 10 devices, verify that it works correctly.

If a USB device is not allowed to be installed, you see the following message:

:::image type="content" source="./media/restrict-usb-with-administrative-template/installation-forbidden.png" alt-text="The installation of the device is forbidden by system policy":::

In the following example, the iPad is blocked because its device ID isn't in the allowed device ID list.

:::image type="content" source="./media/restrict-usb-with-administrative-template/device-status.png" alt-text="Device blocked by group policy":::

## A device is incorrectly blocked

You may find that USB devices that match the allowed device classes are incorrectly blocked. For example, a camera is blocked although the Multimedia class GUID {4d36e96c-e325-11ce-bfc1-08002be10318} was specified in the **Allow installation of devices using drivers that match these device setup classes** setting.

:::image type="content" source="./media/restrict-usb-with-administrative-template/camera-blocked.png" alt-text="Cannot find your camera":::

:::image type="content" source="./media/restrict-usb-with-administrative-template/cam-blocked.png" alt-text="LifeCam blocked":::

To fix this issue, follow these steps:

1. On the Windows 10 device, open the `%windir%\inf\setupapi.dev.log` file.
2. Look for **Restricted installation of devices not described by policy** in the file, and then locate a line that reads **Class GUID of device changed to: {GUID}** within the same device install section.

   In the following example, locate the line that reads **Class GUID of device changed to: {36fc9e60-c465-11cf-8056-444553540000}**.

   ```
   >>>  [Device Install (Hardware initiated) - USB\VID_046D&PID_C534\5&bd89ed7&0&2]
   >>>  Section start 2020/01/20 17:26:03.547
       dvi: {Build Driver List} 17:26:03.597
       …
       dvi: {Build Driver List - exit(0x00000000)} 17:26:03.645
       dvi: {DIF_SELECTBESTCOMPATDRV} 17:26:03.647
       dvi:      Default installer: Enter 17:26:03.647
       dvi:           {Select Best Driver}
       dvi:                Class GUID of device changed to: {36fc9e60-c465-11cf-8056-444553540000}.
       dvi:                Selected Driver:
       dvi:                     Description - USB Composite Device
       dvi:                     InfFile     - c:\windows\system32\driverstore\filerepository\usb.inf_amd64_9646056539e4be37\usb.inf
       dvi:                     Section     - Composite.Dev
       dvi:           {Select Best Driver - exit(0x00000000)}
       dvi:      Default installer: Exit
       dvi: {DIF_SELECTBESTCOMPATDRV - exit(0x00000000)} 17:26:03.664
       dvi: {Core Device Install} 17:26:03.666
       dvi:      {Install Device - USB\VID_046D&PID_C534\5&BD89ED7&0&2} 17:26:03.667
       dvi:           Device Status: 0x01806400, Problem: 0x1 (0xc0000361)
       dvi:           Parent device: USB\ROOT_HUB30\4&278ca476&0&0
   !!! pol:           The device is explicitly restricted by the following policy settings:
   !!! pol:           [-] Restricted installation of devices not described by policy
   !!! pol:      {Device installation policy check [USB\VID_046D&PID_C534\5&BD89ED7&0&2] exit(0xe0000248)}
   !!! dvi:      Installation of device is blocked by policy!
   !   dvi:      Queueing up error report for device install failure.
       dvi: {Install Device - exit(0xe0000248)} 17:26:03.692
       dvi: {Core Device Install - exit(0xe0000248)} 17:26:03.694
   <<<  Section end 2020/01/20 17:26:03.697
   <<<  [Exit status: FAILURE(0xe0000248)]
   ```

3. In the device configuration profile, add the class GUID to the **Allow installation of devices using drivers that match these device setup classes** setting.
4. If the issue persists, repeat steps 1 to 3 to add the additional class GUIDs until the device can be installed.

   In the example, the following class GUIDs have to be added to the device profile:

     - {36fc9e60-c465-11cf-8056-444553540000}: USB Bus devices (hubs and host controllers)
     - {745a17a0-74d3-11d0-b6fe-00a0c90f57da}: Human Interface Devices (HID)
     - {ca3e7ab9-b4c3-4ae6-8251-579ef933890f}: Camera devices
     - {6bdd1fc6-810f-11d0-bec7-08002be2092f}: Imaging devices

### Class GUIDs to allow certain USB devices

To allow a keyboard and mouse, add the following GUIDs to the device profile:

- {4d36e96b-e325-11ce-bfc1-08002be10318}: Keyboard
- {4d36e96f-e325-11ce-bfc1-08002be10318}: Mouse

To allow cameras, headphones and microphones, add the following GUIDs to the device profile:

- {36fc9e60-c465-11cf-8056-444553540000}: USB Bus devices (hubs and host controllers)
- {745a17a0-74d3-11d0-b6fe-00a0c90f57da}: Human Interface Devices (HID)
- {4d36e96c-e325-11ce-bfc1-08002be10318}: Multimedia devices
- {ca3e7ab9-b4c3-4ae6-8251-579ef933890f}: Camera devices
- {6bdd1fc6-810f-11d0-bec7-08002be2092f}: Imaging devices
- {4D36E97D-E325-11CE-BFC1-08002BE10318}: System devices
- {53d29ef7-377c-4d14-864b-eb3a85769359}: Biometric devices
- {62f9c741-b25a-46ce-b54c-9bccce08b6f2}: Generic software devices

To allow 3.5 mm headphones, add the following GUIDs to the device profile:

- {4d36e96c-e325-11ce-bfc1-08002be10318}: Multimedia devices
- {c166523c-fe0c-4a94-a586-f1a80cfbbf3e}: Audio endpoint

> [!NOTE]
> Depending on the devices and drivers to be installed, the actual GUIDs to be added may vary.

[!INCLUDE [Third-party information disclaimer](../../includes/third-party-disclaimer.md)]
