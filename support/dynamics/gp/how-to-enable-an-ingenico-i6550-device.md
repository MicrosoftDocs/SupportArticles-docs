---
title: How to enable an Ingenico i6550 device
description: Describes how to enable an Ingenico i6550 device in Microsoft Dynamics Retail Management System Store Operations 2.0.
ms.reviewer: 
ms.topic: how-to
ms.date: 03/31/2021
---
# How to enable an Ingenico i6550 device in Microsoft Dynamics Retail Management System Store Operations 2.0

This article describes how to enable an Ingenico i6550 device in Microsoft Dynamics Retail Management System (RMS) Store Operations 2.0.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 935588

> [!IMPORTANT]
> This article contains information about how to modify the registry. Make sure that you back up the registry before you modify it. Make sure that you know how to restore the registry if a problem occurs. For more information about how to back up, restore, and modify the registry, see [Windows registry information for advanced users](../../windows-server/performance/windows-registry-advanced-users.md).

## More information

> [!WARNING]
> Serious problems might occur if you modify the registry incorrectly by using Registry Editor or by using another method. These problems might require that you reinstall the operating system. Microsoft cannot guarantee that these problems can be solved. Modify the registry at your own risk.

To enable an Ingenico i6550 device in Store Operations, follow these steps.

### Step 1 - Install the OPOS drivers

To install the OLE for Point of Sale (OPOS) drivers, follow these steps:

1. Download the OPOS driver file for the Ingenico i6550 device.

2. Create a folder, and then name this folder *Ingenico Files*.
3. Extract the files from the driver file that you downloaded in step 1. Extract the files to the Ingenico Files folder.
4. Create a folder, and then name this folder Ingenico_6550.
5. Extract the files from the SL00031-02.30-0 (Build 2).zip file to the Ingenico_6550 folder.
6. In the Ingenico_6550 folder, double-click the **OPOS for the Ingenico i6XXX** file to start the installation wizard.
7. Select **Accept**, and then select **Next**.
8. Select **Custom**, and then select **Next**.
9. Select the following check boxes:

   - **Ingenico-specific Controls**
   - **Control Panel Application**
   - **OPOS Service Objects for the Ingenico 6XXX**

10. Clear the **OPOS Control Objects** check box.

    > [!NOTE]
    > If you install these OPOS control objects, the Microsoft Dynamics RMS control objects will be overwritten. Therefore, you may have to reinstall the Microsoft Dynamics RMS control objects.
11. Select **Next**, and then select **Install**.
12. After the installation process is complete, select **Finish**.

### Step 2 - Configure the "Ingenico i6550" device

1. Select **Start**, point to **All Programs**, point to **Ingenico**, point to **OPOS for the Ingenico 6XXX**, and then select **Ingenico 6XXX Setup**.
2. In the **Device Connection Type** list, select **USB Device**.
3. In the **Signature Format** list, select **UPOS Point Array**.
4. In the **Device Model** list, select **6550**.
5. In the **Line Display Mode** list, select **10X30**.
6. Select the **Enable Backlight to Power Off During Inactivity** check box.
7. Clear the **Allow Bitmap Background on Signature Form** check box.
8. Select **OK**.

### Step 3 - Configure the "signature capture" form

1. In the Ingenico Files folder, extract the following files from the **Ingenico 6550 OPOS Sig Cap Form.zip** file:

   - 6550BeginCapRegEntry.txt
   - Sig6550.icgExtract these files to the following folder:

     C:\Program Files\Ingenico

2. Select **Start**, select **Run**, type *regedit*, and then select **OK**.

3. In Registry Editor, locate and then select the following registry subkey:

   `HKEY_LOCAL_MACHINE\SOFTWARE\OLEforRetail\ServiceOPOS\SignatureCapture\ING6XXX`

4. In Registry Editor, point to **New** on the **Edit** menu, and then select **String Value**.

5. Type *sig6550*, and then press ENTER.

6. Double-click the **sig6550** entry.

7. In the **Value data** field, type the path of the folder in which the form is located.

    > [!NOTE]
    > Typically, the path is as follows:  
    > C:\Program Files\Ingenico\sig6550.icg

8. Select **OK**.

### Step 4 - Enable the "Ingenico i6550" device in Store Operations

1. In Store Operations Manager, select **Database**, point to **Registers**, and then select **Register List**.
2. Select the register on which you want to enable the device, and then select **Properties**.
3. In the **Register Properties** dialog box, select the **PIN Pad** tab.
4. Selectt the **PIN Pad is enabled for this register** check box.
5. In the **OPOS device name** field, type *Ing6XXX*.
6. In the **Transaction host** field, type *0*, and then select **OK**.

    > [!NOTE]
    > Before you can use the PIN pad to process debit cards in Store Operations, the preferred acquirer must insert all the PIN pads. For more information, contact the preferred acquirer.
7. Select the **MSR** tab.
8. Select the **Magnetic stripe reader is enabled for this register** check box.
9. In the **OPOS device name** field, type *Ing6XXX*, and then select **OK**.
10. Select the **Signature Capt.** tab.
11. Select the **Signature capture device is enabled for this register** check box.
12. In the **OPOS device name** field, type *Ing6XXX*.
13. In the **Form name** field, type *sig6550*, and then select **OK**.

    > [!NOTE]
    > You cannot enable the "Real time capture" feature because the "Ingenico i6550" device does not support this feature.
14. If you are currently not using a pole display for the register, you can enable the Ingenico i6550 device for the Pole Display function. To do this, select the **Pole Display** tab, select the **Pole display is enabled for this register** check box, type *Ing6XXX* in the **OPOS device name** field, and then select **OK**.

    > [!NOTE]
    > You may experience some performance problems if you enable the "Ingenico i6550" device for the Pole Display function because the Pole Display function is currently not supported by the "Ingenico i6550" device.
