---
title: Failed to generate the certificate request
description: Discusses an error when you try to create a certificate request in IIS.
ms.date: 03/30/2020
ms.prod-support-area-path: 
ms.reviewer: v-jomcc
---
# Failed to generate the certificate request error message when you create a certificate request in IIS

This article provides information about resolving an issue that an unexpected error may be thrown when you try to create a certificate request in Internet Information Services (IIS).

_Original product version:_ &nbsp; Internet Information Services  
_Original KB number:_ &nbsp; 908572

## Symptoms

When you try to create a certificate request in IIS, you may receive an error message that is similar to the following one:  

> Failed to generate the certificate request. Access is denied.

## Cause

This issue occurs if the administrator who tries to create the certificate request doesn't have **Full Control** permissions on the files and the sub folders in the following folder:  
`\Documents and Settings\All Users\Application Data\Microsoft\Crypto\RSA\MachineKeys`

## Resolution

To resolve this issue, grant the administrator account **Full Control** on all files and sub folders in the `MachineKeys` folder. Follow these steps to resolve the issue:

1. Click **Start**, click **Run**, type `\Documents and Settings\All Users\Application Data\Microsoft\Crypto\RSA\`, and then click **OK**.
2. Right-click **MachineKeys**, and then click **Properties**.
3. On the **Security** tab, click **Administrator** or click the administrator group account you want, click to select the check box to enable **Full Control** permissions, and then click **OK**.

## References

- [Default permissions for the MachineKeys folders](https://support.microsoft.com/help/278381)

- [How to set minimum NTFS permissions and user rights for IIS 5.x or IIS 6.0](https://support.microsoft.com/help/271071)
