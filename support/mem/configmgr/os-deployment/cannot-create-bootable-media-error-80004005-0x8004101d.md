---
title: Can't Create Bootable Media with Errors 80004005 and 0x8004101d
description: Fixes an issue in which you can't create bootable media with errors 80004005 and 0x8004101d in Microsoft Configuration Manager (current branch, version 2409).
ms.date: 05/20/2025
ms.reviewer: kaushika, umaikhan
ms.custom: sap:Operating Systems Deployment (OSD)\Task Sequence Media (all types)
---
# Can't create bootable media with errors 80004005 and 0x8004101d

_Applies to:_ &nbsp; Configuration Manager (current branch, version 2409)

## Symptoms

In Microsoft Configuration Manager (current branch, version 2409), you can't create bootable media when selecting a cloud management gateway for a management point.

The following error is logged in the **SMSProv.log** file:

```output
Failed to get MP installation directory path
~*~*~D:\dbs\sh\cmgm\1213_044837_0\cmd\1b\src\SiteServer\SDK_Provider\SMSProv\ssptspackage.cpp(3101) : GetTSMediaAdditionalInfo failed due to error 80004005
~*~*~GetTSMediaAdditionalInfo failed due to error 80004005
```

Additionally, the following error is logged in the **CreateTSMedia.log** file:

```output
Error invoking WMI method SMS_TaskSequencePackage.GetTSMediaAdditionalInfo (0x8004101d)
StageCertificate::RetrieveTokenForMediaCert() failed. 0x8004101d
```

## Cause

This issue occurs because the SMS provider isn't in the same location as the management point. In Configuration Manager (current branch, version 2409), the system checks the location of the management point and attempts to use the DLLs available in that location.

## Workaround

Since a management point can't be hosted on a central administration site, you need to create the bootable media on a primary site. Additionally, ensure that all Configuration Manager providers are in the same location as the management point.

## Status

Microsoft is working on a resolution and will update this article when it's available.
