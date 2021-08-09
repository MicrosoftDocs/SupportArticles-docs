---
title: Error 806 or 808 when importing CSV files
description: Describes an issue in which you receive the ZtdDeviceAlreadyAssigned (806) or ZtdDeviceAssignedToOtherTenant (808) error message when you import Windows Autopilot device CSV files in Intune.
ms.date: 07/24/2020
ms.prod-support-area-path: Windows enrollment
---
# Error 806 or 808 when you import Windows Autopilot device CSV files in Intune

This article helps you fix an issue where you receive the **ZtdDeviceAlreadyAssigned (806)** or **ZtdDeviceAssignedToOtherTenant (808)** error message when you import Windows Autopilot device CSV files in Microsoft Intune.

_Original product version:_ &nbsp; Microsoft Intune  
_Original KB number:_ &nbsp; 4564066

## Symptoms

When you try to import a CSV file on the [Windows Autopilot devices](https://portal.azure.com/#blade/Microsoft_Intune_Enrollment/EnrollmentMenu/windowsEnrollment) blade in the Azure portal (**Microsoft Intune** > **Device enrollment** > **Windows enrollment** > **Windows Autopilot devices**), you receive an error message that resembles one of the following:

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

## Resolution

To fix the issue, first check whether the device record exists in Microsoft Store for Business:

1. Sign in to [Microsoft Store for Business](https://businessstore.microsoft.com/).
2. Select **Manage**, and then select **Devices**.
3. Locate the device. If the device record exists, select the device, and then select **Remove devices**.
4. Return to the [Windows Autopilot devices](https://portal.azure.com/#blade/Microsoft_Intune_Enrollment/EnrollmentMenu/windowsEnrollment) blade in the Azure portal, and then reimport the CSV file.

If the device record doesn't exist in Microsoft Store for Business or Intune, you might require assistance from Microsoft Support to remove the device record. In this case, collect the following information, and then create a service request by following the steps in [How to get support for Microsoft Intune](/mem/intune/fundamentals/get-support):

- **Device CSV**: A copy of the device CSV file that generates the error.
- **Proof of ownership**: Typically, this is a bill of sale or an invoice in PDF format.

  > [!IMPORTANT]
  > Microsoft Support must verify ownership of the device before the device record can be removed. Therefore, the following requirements must be met:
  >
  > - The document must be in its original form. Screenshots are not accepted.
  > - The serial number, chassis ID, or other unique identifier must be present in the document. For some vendors, you may have to request additional details about the purchased device to see this information.
  > - Your company name must appear in the document.

- **Diagnostic logs**:

    To collect the logs, log on to the device, and then run the following command:

    ```console
    Mdmdiagnosticstool.exe -area Autopilot -cab c:\out.cab
    ```

    The Out.cab file contains important diagnostic data that can help you to troubleshoot your issue.

> [!NOTE]
> These files can be attached to the service request when you create the request.
