---
title: Certificate not updated on a PXE-enabled DP
description: Fixes an issue in which a certificate isn't updated in the registry of a PXE-enabled distribution point if a PXE password is specified.
ms.date: 12/05/2023
ms.custom: sap:Operating Systems Deployment (OSD)\Other
ms.reviewer: kaushika
---
# Certificate isn't updated on a PXE-enabled distribution point and multiple error entries are logged

This article provides a solution for the **Failed to get the encrypted PXE password** error message in Distmgr.log after you update the certificate of a distribution point (DP) that's used for PXE boot.

_Original product version:_ &nbsp; Configuration Manager (current branch)  
_Original KB number:_ &nbsp; 4511618

## Symptoms

After you update the certificate of a DP that's used for PXE boot, the updated certificate doesn't seem to be used. When you restart Windows Deployment Services (WDS) on the PXE-enabled DP, the following error entries are logged in the SMSPXE.log file:

> Begin validation of Certificate [Thumbprint <Old_Cert_Thumbprint>] issued to '\<DP Server>'  
> Certificate [<Old_Cert_Thumbprint>] issued to '<DP_Server>' has expired.  
> Completed validation of Certificate [<Old_Cert_Thumbprint>] issued to '\<DP Server>'  
> reply has no message header marker  
> Failed to send status message (80004005)  
> Unsuccessful in sending status message. 80004005.  
> PXE::MP_ReportStatus failed; 0x80070490  
> Certificate not valid.  
> **A required certificate is not within its validity period when verifying against the current system clock or the timestamp in the signed file. (Error: 800B0101; Source: Windows)**  
> Failed to validate PXEClientKey certificate.  
> PXE Provider failed to read configuration parameters.  
> A required certificate is not within its validity period when verifying against the current system clock or the timestamp in the signed file. (Error: 800B0101; Source: Windows)

> [!NOTE]
> The certificate thumbprint in SMSPXE.log belongs to the previous certificate that has expired. To check a certificate thumbprint, double-click the certificate, select the **Details** tab, and then check the value of the **Thumbprint** field.

Additionally, the following entry is not logged in the Distmgr.log file on the parent site server:

> DP registry settings have been successfully updated on \<DP_Server>

> [!NOTE]
> This log entry would indicate that the new certificate is updated in the registry of the DP.

Instead, the following error entry is logged in Distmgr.log:

> Failed to get the encrypted PXE password

In this scenario, you observe the following conditions:

- The certificate is updated on the **General** tab in the DP **Properties** dialog box.
- The following entry is logged in the Hman.log file on the parent site server:
    > DP cert query: EXEC spUpdateDPCert N'<DP_Server>', N'\<data>', 0x, <Cert_Info_Blob>

    > [!NOTE]
    > This entry indicates that the **spUpdateDPCert** SQL Server stored procedure has run to update the certificate in the database.

- The certificate is updated in the database.
- In the Configuration Manager console, the new certificate is displayed under **Administration** > **Overview** > **Security** > **Certificates**.

## Cause

In most cases, this issue occurs if a PXE password is specified in the properties of the DP, and the parent site is moved to another server or is recovered from a backup on a rebuilt server.

In this case, the machine keys have changed between the old instance of the site and the new instance of the site. The machine keys from the original site are required to correctly decrypt the PXE password. Because the machine keys from the original site are no longer available, the PXE password can't be decrypted and set. If a PXE password is specified, the PXE password must be reset before the new certificate can be set in the registry of the DP.

For more information, see [Post-recovery tasks](/mem/configmgr/core/servers/manage/recover-sites#post-recovery-tasks).

## Resolution

To fix this issue, follow these steps:

1. Temporarily disable the PXE password on the affected DP.

    In the DP **Properties** dialog box, select the **PXE** tab, and then clear the **Require a password when computers use PXE** check box.

2. Verify that the certificate is updated. To do this, check whether the following entry is logged in Distmgr.log

    > DP registry settings have been successfully updated on <DP_Server>

3. Restart WDS on the DP, verify that the certificate thumbprint in SMSPXE.log belongs to the updated certificate, and that no error entry is logged in SMSPXE.log.

4. Re-enable the PXE password on the DP.

    In the DP **Properties** dialog box, select the **PXE** tab, select the **Require a password when computers use PXE** check box, and then enter the password.

After you follow these steps, the new machine keys on the site server will be used to encrypt the PXE password, and you won't see the following error entry in Distmgr.log:

> Failed to get the encrypted PXE password
