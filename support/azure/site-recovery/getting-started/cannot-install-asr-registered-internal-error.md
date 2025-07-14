---
title: Error when you try to install Microsoft Azure Site Recovery Provider
description: You can't install Microsoft Azure Site Recovery Provider and receive an error message ASR cannot be registered due to an internal error.
ms.date: 10/10/2020
ms.service: azure-site-recovery
ms.author: genli
author: genlin
ms.reviewer: NicholaD
ms.custom: sap:I need help getting started with Site Recovery
---
# Error when you try to install Microsoft Azure Site Recovery Provider: ASR cannot be registered due to an internal error

This article provides a resolution to an issue that you can't install Microsoft Azure Site Recovery Provider with error **`ASR` cannot be registered due to an internal error**.

_Original product version:_ &nbsp; Azure Backup  
_Original KB number:_ &nbsp; 3139299

## Symptoms

When you try to install and register the Microsoft Azure Site Recovery Provider on a System Center 2012 R2 Virtual Machine Manager (VMM 2012 R2) server, the attempt fails with the following error:

> The `ASR` cannot be registered due to an internal error. Run Setup again to register the server.

The Azure Site Recovery Provider Setup log (located at _%PROGRAMDATA%\ASRLogs_) also contains an error that resembles the following one:

> RegistrationClient called with acsUrl `https://eus2pod01rrp1users01.accesscontrol.windows.net/` relyingParty `http://windowscloudbackup/m3` 10:46:23:Exception while initializing RegisterActionProcessor: Threw Exception.Type: Microsoft.DisasterRecovery.Registration.DRRegistrationException, Exception.Message: Azure Site Recovery installation is incomplete. Please uninstall and reinstall again to proceed.

## Cause

This exception indicates that a required value on the Virtual Machine Manager 2012 R2 server is missing. These values are stored in the following registry location:

`HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Microsoft System Center Virtual Machine Manager Server\Setup`

```
ProductVersion REG_SZ 3.1.6027.0
InstallPath REG_SZ C:\Program Files\Microsoft System Center 2012\Virtual Machine Manager\
TempPath REG_SZ C:\ProgramData\Microsoft\Virtual Machine Manager\
CompatibleMPVersion REG_SZ 3.1.6011.0
AgentVersion REG_SZ 3.1.6027.0
GuestAgentVersion REG_SZ 3.1.6011.0
VmmID REG_SZ 
VmmServiceAccount REG_SZ CONTOSO\user
SetupLanguage REG_SZ en-US
VmmServicePrincipalNames REG_SZ SCVMM/user,SCVMM/user.contoso.com
SCPGUIDBindingString REG_SZ LDAP://<GUID=>
```

The problem occurs because the VmmID value is blank.

## Resolution

To resolve this issue, first collect the VmmID value from the Virtual Machine Manager 2012 R2 database (VirtualManagerDb). You can extract it from the database through SQL Server Management Studio by running the following SQL query:

```sql
USE [VirtualManagerDb]
SELECT [VMMId] FROM [tbl_DR_VMMRegistrationDetails]
```

Then, add the retrieved VmmID value to the following registry subkey on the VMM 2012 R2 computer:

`HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Microsoft System Center Virtual Machine Manager Server\Setup
"VmmID"=""`

Microsoft Azure Site Recovery Provider should now install successfully.

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
