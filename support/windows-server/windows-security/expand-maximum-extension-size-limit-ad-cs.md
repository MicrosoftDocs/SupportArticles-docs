---
title: How to expand the maximum extension size limit at AD CS
description: Helps to resolve the issue in which Active Directory Certificate Services (AD CS) gives an error when attempting to issue certificates with more than 4 kilobytes (KB) size extensions.
ms.date: 09/15/2022
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, pgandhi, thirunr, clfish
ms.custom: sap:certificates-and-public-key-infrastructure-pki, csstroubleshoot
---
# How to expand the maximum extension size limit at AD CS

This article helps to resolve the issue in which Active Directory Certificate Services (AD CS) gives an error when attempting to issue certificates with more than 4 kilobytes (KB) size extensions.

_Original KB number:_ &nbsp; 5017242

You may also see this error message in the certsrv logging:

```output
CertSrv: Field length is greater than maximum 0xc80005e2 (ESE: -1506 JET_errColumnTooBig)
```

> [!NOTE]
> Certsrv logging helps to determine the cause of the error. For more information on enabling the certsrv logging, see [Certificate Enrollment Web Services in Active Directory Certificate Services](https://social.technet.microsoft.com/wiki/contents/articles/7734.certificate-enrollment-web-services-in-active-directory-certificate-services.aspx#Certsrv_Logging).

## Data stored in the custom extension has a limit of 4 KB

The data stored in the custom extension has a limit of 4 KB, which can be confirmed by running the following command as an administrator:

```console
certutil -schema Ext
```

You can see the `MaxLength` property of `ExtensionRawValue` in the output:

```output
C:\>certutil -schema Ext
Schema:
  Column Name                   Localized Name                Type    MaxLength
  ----------------------------  ----------------------------  ------  ---------
  ExtensionRequestId            Extension Request ID          Long    4 -- Indexed
  ExtensionName                 Extension Name                String  254
  ExtensionFlags                Extension Flags               Long    4
  ExtensionRawValue             Extension Raw Value           Binary  4096

CertUtil: -schema command completed successfully.
```

The limit can be expanded to 16 KB after installing one of the following or subsequent updates:

- Windows Server 2019 - [July 21, 2022—KB5015880 (OS Build 17763.3232) Preview](https://support.microsoft.com/topic/july-21-2022-kb5015880-os-build-17763-3232-preview-1c984723-cdf0-4a24-9a4f-5df11d3024a1)
- Windows Server 20H2 - [July 26, 2022—KB5015878 (OS Builds 19042.1865, 19043.1865, and 19044.1865) Preview](https://support.microsoft.com/topic/july-26-2022-kb5015878-os-builds-19042-1865-19043-1865-and-19044-1865-preview-549f5551-fcc5-4fee-8811-c5df12e04d40)
- Windows Server 2022 - [July 19, 2022—KB5015879 (OS Build 20348.859) Preview](https://support.microsoft.com/topic/july-19-2022-kb5015879-os-build-20348-859-preview-be3951fb-2229-48f7-971c-830745931979)

> [!IMPORTANT]
> The next two sections contain instructions to modify the registry. Serious problems might occur if the registry is modified incorrectly. As a precaution, back up the registry before you modify it. For more information about how to back up, restore, and modify the registry, see [How to back up and restore the registry in Windows](https://support.microsoft.com/topic/how-to-back-up-and-restore-the-registry-in-windows-855140ad-e318-2a13-2829-d428a2ab0692).

## Expand the limit by using Registry Editor

In Registry Editor, add the `0x1000` bitmask to the following registry key. Then, restart AD CS.

`HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\CertSvc\Configuration\DBFlags`

> [!NOTE]
> This setting should be done on all AD CS servers where expansion is required.

## Expand the limit by using an administrative command prompt

Run the following commands to add `0x1000` to the `DBFlags` registry key value and then restart AD CS:

```console
certutil -setreg DBFlags +0x1000
net stop certsvc && net start certsvc
```

> [!NOTE]
> This setting should be done on all AD CS servers where expansion is required.
>
> This setting causes an irreversible database operation to expand the limit permanently once the service is restarted.
>
> After the expansion is complete and new backups are captured, you may consider destroying the old backups to prevent an accidental rollback.

## Verify the limit settings

To verify the limit settings, run the following command as an administrator and check the `MaxLength` property of `ExtensionRawValue` in the output:

```output
C:\>certutil -schema Ext

Schema:
  Column Name                   Localized Name                Type    MaxLength
  ----------------------------  ----------------------------  ------  ---------
  ExtensionRequestId            Extension Request ID          Long    4 -- Indexed
  ExtensionName                 Extension Name                String  254
  ExtensionFlags                Extension Flags               Long    4
  ExtensionRawValue             Extension Raw Value           Binary  16384

CertUtil: -schema command completed successfully.
```
