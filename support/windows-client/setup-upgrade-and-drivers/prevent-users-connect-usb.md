---
title: Prevent Users From Connecting to a USB Storage Device
description: Provides a resolution to prevent users from connecting to a USB storage device.
ms.date: 08/06/2025
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.reviewer: kaushika, v-lianna
ms.custom:
- sap:windows device and driver management\peripherals driver installation or update
- pcy:WinComm Devices Deploy
---
# How can I prevent users from connecting to a USB storage device?

## Problem description

Assume that you want to prevent users from connecting to a USB storage device that is connected to a computer that is running Windows. This article discusses two methods that you can use to do this.

## Resolution

To prevent users from connecting to USB storage devices, use one or more of the following procedures, as appropriate for your situation.

### If a USB storage device isn't already installed on the computer

If a USB storage device isn't already installed on the computer, assign the user or the group and the local SYSTEM account **Deny** permissions to the following files:

- **%SystemRoot%\Inf\Usbstor.pnf**
- **%SystemRoot%\Inf\Usbstor.inf**

When you do this, users can't install a USB storage device on the computer. To assign a user or group **Deny** permissions to the **Usbstor.pnf** and **Usbstor.inf** files, follow these steps:

1. Start Windows Explorer, and then locate the **%SystemRoot%\Inf** folder.
2. Right-click the **Usbstor.pnf** file, and then select **Properties**.
3. Select the **Security** tab.
4. In the **Group or user names** list, add the user or group that you want to set **Deny** permissions for.
5. In the **Permissions for UserName or GroupNamel** list, select the **Deny** checkbox next to **Full Control**.

    > [!NOTE]
    > Also add the SYSTEM account to the **Deny** list.

6. In the **Group or user names** list, select the SYSTEM account.
7. In the **Permissions for UserName or GroupNamel** list, select the **Deny** checkbox next to **Full Control**, and then select **OK**.
8. Right-click the **Usbstor.inf** file, and then select **Properties**.
9. Select the **Security** tab.
10. In the **Group or user names** list, add the user or group that you want to set **Deny** permissions for.
11. In the **Permissions for UserName or GroupNamel** list, select the **Deny** checkbox next to **Full Control**.
12. In the **Group or user names** list, select the SYSTEM account.
13. In the **Permissions for UserName or GroupNamel** list, select the **Deny** checkbox next to **Full Control**, and then select **OK**.

### If a USB storage device is already installed on the computer

If a USB storage device is already installed on the computer, you can change the registry to make sure that the device doesn't work when the user connects to the computer.

[!INCLUDE [Registry important alert](../../includes/registry-important-alert.md)]

If a USB storage device is already installed on the computer, set the `Start` value in the following registry key to `4`:

`HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\UsbStor`

When you do this, the USB storage device doesn't work when the user connects the device to the computer. To set the `Start` value, follow these steps:

1. Select **Start**, and then select **Run**.
2. In the **Open** box, type **regedit**, and then select **OK**.
3. Locate and then select the following registry key:

    `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\UsbStor`
4. In the details pane, double-click `Start`.
5. In the **Value data** box, type **4**, select **Hexadecimal** (if it isn't already selected), and then select **OK**.
6. Exit Registry Editor.

Did this fix the problem?

Check whether the problem is fixed. If the problem is fixed, you're finished with this article. If the problem isn't fixed, you can [contact support](https://support.microsoft.com/contactus).

## More information

Contact the vendor of your USB device to ask about a newer driver.

Microsoft provides third-party contact information to help you find technical support. This contact information may change without notice. Microsoft doesn't guarantee the accuracy of this third-party contact information.
