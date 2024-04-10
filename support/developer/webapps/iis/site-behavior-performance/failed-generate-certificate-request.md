---
title: Fail to generate the certificate request
description: This article discusses an error that occurs when you try to create a certificate request in IIS.
ms.date: 03/30/2020
ms.custom: sap:Site behavior and performance
ms.reviewer: v-jomcc
ms.subservice: site-behavior-performance
---
# Error when you create a certificate request in IIS: Failed to generate the certificate request

This article helps you resolve the problem where an unexpected error might be thrown when you try to create a certificate request in Internet Information Services (IIS).

_Original product version:_ &nbsp; Internet Information Services  
_Original KB number:_ &nbsp; 908572

## Symptoms

When you try to create a certificate request in IIS, you may receive an error message that is similar to the following one:  

> Failed to generate the certificate request. Access is denied.

## Cause

This issue occurs if the administrator who tries to create the certificate request doesn't have Full Control permissions on the files and the sub folders in the following folder:  
`\Documents and Settings\All Users\Application Data\Microsoft\Crypto\RSA\MachineKeys`

## Resolution

To resolve this issue, grant the administrator account Full Control on all files and sub folders in the `MachineKeys` folder. Follow these steps to resolve the issue:

1. Select **Start**, select **Run**, type `\Documents and Settings\All Users\Application Data\Microsoft\Crypto\RSA\`, and then select **OK**.
2. Right-click **MachineKeys**, and then select **Properties**.
3. On the **Security** tab, select **Administrator** or select the administrator group account you want, select the check box to enable Full Control permissions, and then select **OK**.

## References

- [Default permissions for the MachineKeys folders](https://support.microsoft.com/help/278381)

- [How to set minimum NTFS permissions and user rights for IIS 5.x or IIS 6.0](https://support.microsoft.com/help/271071)
