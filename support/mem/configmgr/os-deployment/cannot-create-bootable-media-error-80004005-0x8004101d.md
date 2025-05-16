---
title: Can't create bootable media with errors 80004005 and 0x8004101d
description: Fixes an issue in which you can't create bootable media with errors 80004005 and 0x8004101d in Microsoft Configuration Manager (current branch - version 2409).
ms.date: 05/16/2025
ms.reviewer: kaushika, umaikhan
ms.custom: sap:Operating Systems Deployment (OSD)\Task Sequence Media (all types)
---
# Can't create bootable media with errors 80004005 and 0x8004101d

_Applies to:_ &nbsp; Configuration Manager (current branch)

## Symptoms

In Microsoft Configuration Manager (current branch - version 2409), you can't create bootable media and select a cloud management gateway for a management point.

The following errors are logged in the **SMSProv.log** file:

```output
Failed to get MP installation directory path
~*~*~D:\dbs\sh\cmgm\1213_044837_0\cmd\1b\src\SiteServer\SDK_Provider\SMSProv\ssptspackage.cpp(3101) : GetTSMediaAdditionalInfo failed due to error 80004005
~*~*~GetTSMediaAdditionalInfo failed due to error 80004005
```

The following errors are logged in the **CreateTSMedia.log** file:

```output
Error invoking WMI method SMS_TaskSequencePackage.GetTSMediaAdditionalInfo (0x8004101d)
StageCertificate::RetrieveTokenForMediaCert() failed. 0x8004101d
```

## Cause

This issue occurs because the SMS Provider isn't located in the same location as the management point. In Configuration Manager (current branch - version 2409), the system checks the location of management point and attempts to use the DLLs available in that location.

## Resolution

Since a management point can't be hosted on a central administration site, you must create the bootable media on a primary site. Additionally, ensure that all Configuration Manager providers are located in the same location as the management point.
