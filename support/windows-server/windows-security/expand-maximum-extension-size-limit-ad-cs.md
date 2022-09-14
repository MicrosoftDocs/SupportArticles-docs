---
title: How to expand the maximum extension size limit at AD CS
description: Helps to resolve the issue in which Active Directory Certificate Services (AD CS) gives an error when attempting to issue certificates with more than 4 kilobytes (KB) size extensions.
ms.date: 09/14/2022
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.prod: windows-server
localization_priority: medium
ms.reviewer: kaushika, pgandhi, thirunr, clfish
ms.custom: sap:certificates-and-public-key-infrastructure-pki, csstroubleshoot
ms.technology: windows-server-security
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

You can see the MaxLength property of ExtensionRawValue in the output.

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

The limit can be expanded to 16 KB after the following updates are installed in Windows Server 2019 and later versions.

- [July 19, 2022—KB5015879 (OS Build 20348.859) Preview](https://support.microsoft.com/topic/july-19-2022-kb5015879-os-build-20348-859-preview-be3951fb-2229-48f7-971c-830745931979) or later quality updates
- [August 9, 2022—KB5016683 (Security-only update)](https://support.microsoft.com/topic/august-9-2022-kb5016683-security-only-update-63256731-a090-4f08-95fa-849f33ff02c0) or later security updates

> [!IMPORTANT]
> The next two sections contain instructions to modify the registry. Serious problems might occur if the registry is modified incorrectly. As a precaution, back up the registry before you modify it. For more information about how to back up, restore, and modify the registry, see [How to back up and restore the registry in Windows](https://support.microsoft.com/topic/how-to-back-up-and-restore-the-registry-in-windows-855140ad-e318-2a13-2829-d428a2ab0692).

## Expand the limit by using Registry Editor

In Registry Editor, add the 0x1000 bitmask to the following registry key. Then, restart AD CS.

`HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\CertSvc\Configuration\DBFlags`

> [!NOTE]
> This setting should be done on all AD CS servers where expansion is required.

## Expand the limit by using an administrative command prompt

Run the following commands to add 0x1000 to the DBFlags registry key value and then restart AD CS:

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

To verify the limit settings, run the following command as an administrator and check the MaxLength property of ExtensionRawValue in the output:

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
