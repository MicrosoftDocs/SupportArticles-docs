---
title: Troubleshoot error 806 or 808 when importing Windows Autopilot CSV files
description: Describes an issue in which you receive the ZtdDeviceAlreadyAssigned (806) or ZtdDeviceAssignedToOtherTenant (808) error message when you import Windows Autopilot device CSV files in Microsoft Intune.
ms.date: 12/05/2023
search.appverid: MET150
ms.custom: sap:Windows enrollment
ms.reviewer: kaushika
---
# Error 806 or 808 when you import Windows Autopilot device CSV files in Intune

This article helps you fix an issue where you receive the **ZtdDeviceAlreadyAssigned (806)** or **ZtdDeviceAssignedToOtherTenant (808)** error message when you import Windows Autopilot device CSV files in Microsoft Intune.

## Symptoms

When you try to import a CSV file in the [Microsoft Intune admin center](https://go.microsoft.com/fwlink/?linkid=2109431) (**Devices** > **Windows** > **Windows enrollment** > **Devices** (under **Windows Autopilot Deployment Program**) > **Import**), you receive an error message similar to these:

> Error details  
> Device is already registered to the same Tenant.  
> Error code:  
> 806 - **ZtdDeviceAlreadyAssigned**  
> CSV line numbers affected:  
> 1

> Error details  
> Internal error  
> Error code:  
> 808 - **ZtdDeviceAssignedToOtherTenant**  
> CSV line numbers affected:  
> 1

## Cause

The **806 - ZtdDeviceAlreadyAssigned** and **808 - ZtdDeviceAssignedToOtherTenant** errors can occur if a device is already registered in your tenant or if a record of the device already exists in Microsoft Store for Business. The record must be removed before the device's CSV file can be imported in Intune.

## Solution

To fix the issue, confirm whether the device record exists in Microsoft Store for Business:

1. Sign in to [Microsoft Store for Business](https://businessstore.microsoft.com/).
1. Select **Manage**, and then select **Devices**.
1. Locate the device. If the device record exists, select the device, and then select **Remove devices**.
1. Return to the [Microsoft Intune admin center](https://go.microsoft.com/fwlink/?linkid=2109431), and then reimport the CSV file.

If the device record doesn't exist in Microsoft Store for Business or Intune, you might require assistance from Microsoft Support to remove the device record. In this case, collect the following information, and then create a service request by following the steps in [How to get support in Microsoft Intune admin center](/mem/intune/fundamentals/get-support):

- **Device CSV**: A copy of the device CSV file that generates the error.
- **Proof of ownership**: Typically, this is a bill of sale or an invoice in PDF format.

  > [!IMPORTANT]
  > Microsoft Support needs to verify ownership of the device before the device record can be removed. Therefore, the following requirements must be met:
  >
  > - The document that proves ownership of the device must be in its original form. Screenshots are not accepted.
  > - The serial number, chassis ID, or other unique identifier of the device must be present in the document. If it isn't, you need to request the vendor for an updated document of ownership which includes these details about the device.
  > - Your company's name must appear in the document.
  > 
  > Customers who use Microsoft Premier Support don't need to provide proof of ownership to deregister a device. However, they still need to prove that the device is in their possession. 

- **Diagnostic logs**:

    To collect the logs, log on to the device, and then run the following command:

    ```console
    Mdmdiagnosticstool.exe -area Autopilot -cab c:\out.cab
    ```

    The *Out.cab* file contains important device data that will be used to remove the device record and can be collected at any point during the Autopilot process.

> [!NOTE]
> These files can be attached to the service request when you create the request.
