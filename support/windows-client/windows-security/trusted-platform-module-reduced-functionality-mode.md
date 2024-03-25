---
title: TPM is in reduced functionality mode after successful deployment of Windows 10
description: Describes an issue in which TPM is in reduced functionality mode after a successful deployment of Windows 10. Provides a workaround.
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: aaroncz, kaushika
ms.custom: sap:Windows Security Technologies\BitLocker, csstroubleshoot
---
# TPM is in reduced functionality mode after successful deployment of Windows 10

This article provides a workaround for an issue in which the Trusted Platform Module (TPM) is in reduced functionality mode after a successful deployment of Windows 10.

_Applies to:_ &nbsp; Windows 10 – all editions  
_Original KB number:_ &nbsp; 4018657

## Symptoms

Consider the following scenario:

- You use Microsoft Deployment Toolkit (MDT) to deploy Windows 10. (This can be any version of MDT that supports Windows 10.)
- You use the "Enable BitLocker (offline)" step (ZTIBDE.wsf script) to pre-provision BitLocker during Windows PE in the "Preinstall" group.
- The deployment is successful.

In this scenario, you notice that the Trusted Platform Module (TPM) is in reduced functionality mode. In this situation, the TPM Management console (TPM.msc) reports the following issue:

> The TPM is ready for use, with reduced functionality. Information Flags: 0x900  
The TPM owner authorization is not properly stored in the registry.  
Windows's registry information about the TPM's Storage Root Key does not match the TPM Storage Root Key or is missing.

## Cause

This issue occurs because the **TpmValidate** function in the ZTIBDE.wsf script takes ownership of the TPM from Windows PE unnecessarily. Windows should be able to correctly take ownership of the TPM before OOBE to provision it by using the correct parameters.

When this change in ownership of the TPM from Windows PE occurs, the TPM is given parameters that Windows doesn't understand. Therefore, the key hierarchies in the TPM are disabled and made permanently unavailable to Windows.  

## Workaround

To work around this issue for new deployments until a new version of MDT is available, add the following command to the ZTIBDE.wsf script at the start of the "Function Main" section:

```console
reg add hklm\system\currentcontrolset\services\tpm\wmi -v UseNullDerivedOwnerAuth -t REG_DWORD -d 0x01 -f
```
  
> [!NOTE]
> For devices in which the TPM is already in reduced functionality mode, the TPM must be cleared before you can mitigate this issue. We recommend that you reset the TPM if it's in this state. To do this, follow the recommendations in [Clear all the keys from the TPM](/windows/security/information-protection/tpm/initialize-and-configure-ownership-of-the-tpm#clear-all-the-keys-from-the-tpm).

## More information

One option to prevent this issue from occurring isn't to pre-provision BitLocker, and to wait to enable the full system, instead. Be aware that the deployment will take longer to complete by using this method.
