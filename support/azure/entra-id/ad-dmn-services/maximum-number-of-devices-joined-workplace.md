---
title: Error (The maximum number of devices that can be joined to the workplace by the user has been reached) during a Workplace Join
description: Describes a problem in which a (The maximum number of devices that can be joined to the workplace by the user has been reached) error occurs when you try to perform a Workplace Join operation. Provides a resolution.
ms.date: 06/08/2020
ms.reviewer: 
ms.service: active-directory
ms.subservice: hybrid
---
# Error (The maximum number of devices that can be joined to the workplace by the user has been reached) during a Workplace Join

This article describes a problem in which a "The maximum number of devices that can be joined to the workplace by the user has been reached" error occurs when you try to perform a Workplace Join operation.

_Original product version:_ &nbsp; Windows Server 2012 R2 Datacenter, Windows Server 2012 R2 Standard, Windows 8.1 Enterprise, Microsoft Entra ID  
_Original KB number:_ &nbsp; 3045379

## Symptoms

When a user tries to perform a Workplace Join operation on a WIndows device, they receive the following message:

> Confirm you are using the current sign-in info, and that your workplace uses this feature. Also, the connection to your workplace might not be working right now. Please wait and try again.

Additionally, an administrator may see the following Event details in Event Viewer.

> Event ID:200  
Log Name: Microsoft-Windows-Workplace Join/Admin
Source: Microsoft-Windows-Workplace Join
Level: Error
Description: The maximum number of devices that can be joined to the workplace by the user has been reached.  
Registration Service URI: `https://enterpriseregistration.windows.net/EnrollmentServer/DeviceEnrollmentWebService.svc`

## Cause

This problem occurs because the user has joined the maximum number of devices and has fulfilled the designated quota.

## Resolution

To resolve this problem, check the quota configuration. Then, check the number of devices that the user has previously registered. If the quota is reached, follow these steps, depending on the applicable scenario.

- If the user is trying to perform Workplace Join to Microsoft Entra ID
  1. Delete devices for the user.
     1. Sign in to Azure portal or start the Microsoft Entra ID console from the Microsoft 365 admin center as Company Administrator.
     2. Move to the directory that the user is trying the join.
     3. Locate **Users**, and then locate the user who cannot perform the Workplace Join operation.
     4. Locate **Devices**.
     5. Review the list to determine which devices can be deleted. Then, click **Delete Device**.
  2. Increase the Registered Device Quota.
     1. Sign in to the Azure portal or start the Microsoft Entra ID console from the Microsoft 365 admin center as Company Administrator.
     2. Move to the directory that the user is trying the join.
     3. Locate **Devices**, and then locate **Device Settings**.
     4. Change the **Maximum Number of devices per user** setting to a larger value.
- If the user is trying to perform Workplace Join to your local Active Directory site
  1. Delete devices for the user.
     - Use Windows PowerShell scripts to identify devices and to delete devices that are associated with a user.
  2. Increase the Registered **Device Quota** value.
     1. Sign in to your AD FS server.
     2. Run Windows PowerShell as an elevated administrator.
     3. Run the following command to increase the quota:

        ```powershell
        Set-ADFSDeviceRegistration -DevicesPerUser [0 - 1000]
        ```

        For example, run the following command to set the number of devices for the user to 10:

        ```powershell
         Set-ADFSDeviceRegistration -DevicesPerUser 10
        ```

You can also verify that the user has reached the device capacity by reviewing the DRS Event logs.

   1. Open Event Viewer on the DRS server.
   2. Browse to the location: `Applications and Services Logs\Device Registration Service\DRS\Admin`
   3. Look for Event ID 125. It should resemble the following:  

      > User 'user@domain.com : GUID' is not eligible to enroll a device of type 'device_type' Reason 'DeviceCapReached'.

## More information

For more troubleshooting information, see [Diagnostic logging for troubleshooting Workplace Join issues](https://support.microsoft.com/help/3045377).

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
