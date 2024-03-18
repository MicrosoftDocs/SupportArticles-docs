---
title: ConfigMgr PXE boot doesn't work
description: Fixes a problem in which a Configuration Manager PXE boot process doesn't work because a self-signed certificate is not created.
ms.date: 12/05/2023
ms.custom: sap:Operating Systems Deployment (OSD)\PXE
ms.reviewer: kaushika
---
# PXE boot doesn't work because a self-signed certificate isn't created

This article helps you fix an issue in which the Preboot Execution Environment (PXE) boot doesn't work in Configuration Manager if a self-signed certificate isn't created.

_Original product version:_ &nbsp; Microsoft System Center 2012 Configuration Manager, Microsoft System Center 2012 R2 Configuration Manager, Configuration Manager (current branch)  
_Original KB number:_ &nbsp; 4469580

## Symptoms

When you try to start a computer through the PXE boot by using Configuration Manager, the PXE boot process doesn't work.

When this problem occurs, the following error entry is logged in the SMSPXE log on the PXE-enabled distribution point (DP) when you start Windows Deployment Services (WDS):

> SMSPXE    Failed to create certificate store from encoded certificate. Verify the provided Certificate was provisioned correctly. .  
> An error occurred during encode or decode operation. (Error: 80092002; Source: Windows)  
> SMSPXE    Failed to create certificate store from encoded certificate. Verify the provided Certificate was provisioned correctly. .  
> An error occurred during encode or decode operation. (Error: 80092002; Source: Windows)  
> SMSPXE    PXE::MP_GetList failed; 0x80092002  
> SMSPXE    PXE::MP_ReportStatus failed; 0x80092002  
> SMSPXE    PXE::CPolicyProvider::InitializePerformanceCounters failed; 0x80070002  
> SMSPXE    Failed to create certificate store from encoded certificate. Verify the provided Certificate was provisioned correctly. .  
> An error occurred during encode or decode operation. (Error: 80092002; Source: Windows)  
> SMSPXE    Failed to create certificate store from encoded certificate. Verify the provided Certificate was provisioned correctly. .  
> An error occurred during encode or decode operation. (Error: 80092002; Source: Windows)  
> SMSPXE    PXE::MP_GetList failed; 0x80092002  
> SMSPXE    PXE::MP_LookupDevice failed; 0x80092002  
> SMSPXE    PXE Provider failed to initialize MP connection.  
> An error occurred during encode or decode operation. (Error: 80092002; Source: Windows)  
> SMSPXE    Failed to create certificate store from encoded certificate. Verify the provided Certificate was provisioned correctly. .  
> An error occurred during encode or decode operation. (Error: 80092002; Source: Windows)  
> SMSPXE    Failed to create certificate store from encoded certificate. Verify the provided Certificate was provisioned correctly. .  
> An error occurred during encode or decode operation. (Error: 80092002; Source: Windows)  
> SMSPXE    PXE::MP_GetList failed; 0x80092002  
> SMSPXE    PXE::MP_ReportStatus failed; 0x80092002  
> SMSPXE    PXE::CPolicyProvider::InitializeMPConnection failed; 0x80092002

Additionally, the SMSPXE.log file includes the following error entries when you try to run a PXE boot:

> SMSPXE    Failed to create certificate store from encoded certificate. Verify the provided Certificate was provisioned correctly. .  
> An error occurred during encode or decode operation. (Error: 80092002; Source: Windows)  
> SMSPXE    Failed to create certificate store from encoded certificate. Verify the provided Certificate was provisioned correctly. .  
> An error occurred during encode or decode operation. (Error: 80092002; Source: Windows)  
> SMSPXE    Failed to create certificate store from encoded certificate. Verify the provided Certificate was provisioned correctly. .  
> An error occurred during encode or decode operation. (Error: 80092002; Source: Windows)  
> SMSPXE    PXE::MP_GetList failed; 0x80092002  
> SMSPXE    Failed to create certificate store from encoded certificate. Verify the provided Certificate was provisioned correctly. .  
> An error occurred during encode or decode operation. (Error: 80092002; Source: Windows)  
> SMSPXE    PXE::MP_LookupDevice failed; 0x80092002  
> SMSPXE    PXE::MP_GetList failed; 0x80092002  
> SMSPXE    PXE::MP_LookupDevice failed; 0x80092002  
> SMSPXE    Failed to create certificate store from encoded certificate. Verify the provided Certificate was provisioned correctly. .  
> An error occurred during encode or decode operation. (Error: 80092002; Source: Windows)  
> SMSPXE    Failed to create certificate store from encoded certificate. Verify the provided Certificate was provisioned correctly. .  
> An error occurred during encode or decode operation. (Error: 80092002; Source: Windows)  
> SMSPXE    Failed to create certificate store from encoded certificate. Verify the provided Certificate was provisioned correctly. .  
> An error occurred during encode or decode operation. (Error: 80092002; Source: Windows)  
> SMSPXE    PXE::MP_GetList failed; 0x80092002  
> SMSPXE    PXE::MP_ReportStatus failed; 0x80092002  
> SMSPXE    Failed to create certificate store from encoded certificate. Verify the provided Certificate was provisioned correctly. .  
> An error occurred during encode or decode operation. (Error: 80092002; Source: Windows)  
> SMSPXE    PXE Provider failed to process message.  
> An error occurred during encode or decode operation. (Error: 80092002; Source: Windows)  
> SMSPXE    PXE::MP_GetList failed; 0x80092002  
> SMSPXE    PXE::MP_ReportStatus failed; 0x80092002  
> SMSPXE    PXE Provider failed to process message.  
> An error occurred during encode or decode operation. (Error: 80092002; Source: Windows)

If you try to fix the problem by re-creating the self-signed certificate in the properties of the DP by changing the date or time of the self-signed certificate, the certificate isn't re-created.  

> [!NOTE]
> You can view certificates for the DP in the Configuration Manager console under **Administration** > **Security** > **Certificates**.

When you re-create the self-signed certificate for a DP, the **Start Date** value should be approximately the time when the date and time values were changed for the certificate in the DP properties.

When this problem occurs, the CertMgr.log file includes the following error entries:

> SMS_CERTIFICATE_MANAGER ~Found notification file C:\Program Files\Microsoft Configuration Manager\inboxes\certmgr.box\5_\<DP_FQDN>.CMN  
> SMS_CERTIFICATE_MANAGER Successfully made a network connection to \\\\<DP_FQDN>\ADMIN$.~  
> SMS_CERTIFICATE_MANAGER Successfully made a network connection to \\\\<DP_FQDN>\ADMIN$.~  
> SMS_CERTIFICATE_MANAGER Cannot get copy of security registry key on server (\<DP_FQDN>) (0x80070005)  
> SMS_CERTIFICATE_MANAGER Failed to get the copy of Security registry key on server <DP_FQDN> (0x80070005)  
> SMS_CERTIFICATE_MANAGER Cancelling network connection to \\\\<DP_FQDN>\ADMIN$.  
> SMS_CERTIFICATE_MANAGER Cancelling network connection to \\\\<DP_FQDN>\ADMIN$.

## Cause

This issue occurs if the `IssuingCertificateList` registry key is missing from the following registry subkey on the DP:

`HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\SMS\Security`

> [!NOTE]
> The registry key value could also be missing on the management point.

## Resolution

To fix the issue, copy the `IssuingCertificateList` registry key value from the following registry subkey on the management point:

`HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\SMS\Security`

Then, copy this value to the same registry key on the DP. To do this, you can run the following command at an elevated command prompt on the DP:

```console
REG.exe ADD "HKLM\SOFTWARE\Microsoft\SMS\Security" /v IssuingCertificateList /t REG_MULTI_SZ /d <Value_From_MP> /f
```

> [!NOTE]
> In this command, replace <*Value_From_MP*> with the value that you got from the management point (without the angle brackets).

If the registry key value is also missing on the management point, open SQL Server Management Studio on the primary site, and then run the following query against the primary site database:

```sql
SELECT SD.SiteCode, SC.ComponentName, SCP.Name, SCP.Value1, SCP.Value2, SCP.Value3 FROM SC_Component SC
JOIN SC_SiteDefinition SD ON SD.SiteNumber = SC.SiteNumber
JOIN SC_Component_Property SCP ON SCP.ComponentID = SC.ID
WHERE SCP.Name = 'IssuingCertificateList'
```

> [!IMPORTANT]
> The value in the **Value1** column must be copied to the registry on both the DP and the management point.

Copy the value in the **Value1** column, and then run the following command at an elevated command prompt on both the DP and management point:

```console
REG.exe ADD "HKLM\SOFTWARE\Microsoft\SMS\Security" /v IssuingCertificateList /t REG_MULTI_SZ /d <Value_from_DB> /f
```

> [!NOTE]
> In this command, replace <*Value_from_DB*> with the value that you copied from the primary site database (without the angle brackets).

You may want to check the CertMgr.log file to see whether additional DPs are affected. If they are, run the `REG.exe` command on the additional DPs.
