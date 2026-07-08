---
title: Running Test-IRMConfiguration in EMS fails
description: Provides a resolution to resolve the failure of the Test-IRMConfiguration cmdlet.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Information Rights Management
  - Exchange Server
  - CSSTroubleshoot
  - CI 9823
  - CI 11995
search.appverid: 
  - MET150
appliesto: 
  - Exchange Server SE
  - Exchange Server 2019
  - Exchange Server 2016
ms.date: 06/05/2026
ms.reviewer: v-six, v-kccross
---

# Test-IRMConfiguration fails: Failed to acquire a use license

_Original KB number:_ &nbsp; 2805976

## Summary

Test-IRMConfiguration fails with "Failed to acquire a use license" because Exchange uses cached identity and licensing data from a deleted and recreated FederatedEmail arbitration mailbox.
To resolve the issue, disable Information Rights Management (IRM), back up and delete the contents of the C:\ProgramData\Microsoft\DRM\Server folder, restart the Exchange server, and then re-enable IRM. After the cache rebuilds, run `Test-IRMConfiguration` again to confirm that IRM works correctly.

## Symptoms

If you configure Active Directory Rights Management Service (AD RMS) with Microsoft Exchange Server, you might receive the following failure if you run `Test-IRMConfiguration` in the Exchange Management Shell (EMS).

```console
Results : Checking Exchange Server ...
 - PASS: Exchange Server is running in Enterprise.
 Loading IRM configuration ...
 - PASS: IRM configuration loaded successfully.
 Retrieving RMS Certification Uri ...
 - PASS: RMS Certification Uri: https://rms.Domain.com/_wmcs/certification.
 Verifying RMS version for https://rms.Domain.com/_wmcs/certification ...
 - PASS: RMS Version verified successfully.
 Retrieving RMS Publishing Uri ...
 - PASS: RMS Publishing Uri: https://rms.Domain.com/_wmcs/licensing.
 Acquiring Rights Account Certificate (RAC) and Client Licensor Certificate (CLC)...
 - PASS: RAC and CLC acquired.
 Acquiring RMS Templates ...
 - PASS: RMS Templates acquired.
 Retrieving RMS Licensing Uri ...
 - PASS: RMS Licensing Uri: https://rms.Domain.com/_wmcs/licensing.
 Verifying RMS version for https://rms.Domain.com/_wmcs/licensing ...
 - PASS: RMS Version verified successfully.
 Creating Publishing License ...
 - PASS: Publishing License created.
 Acquiring Prelicense for 'User@Domain.com' from RMS Licensing Uri (https://rmc.Domain.com/_wmcs/licensing)...
 - PASS: Prelicense acquired.
 Acquiring Use License from RMS Licensing Uri (https://rms.Domain.com/_wmcs/licensing)...
 - FAIL: Failed to acquire a use license. This failure may cause features such as Transport Decryption, Jo
 urnal Report Decryption, IRM in OWA, IRM in EAS and IRM Search to not work. Please make sure that the account
 "FederatedEmail.4c1f4d8b-8179-4148-93bf-00a95fa1e042" representing the Exchange Servers Group is granted sup
 er user privileges on the Active Directory Rights Management Services server. For detailed instructions, see
 "Add the Federated Delivery Mailbox to the AD RMS Super Users Group" at https://go.microsoft.com/fwlink/?linkid=193400.
```

## Cause

This problem can occur if the arbitration mailbox `FederatedEmail.4c1f4d8b-8179-4148-93bf-00a95fa1e042` is deleted and recreated. After reconfiguring the AD RMS Super Users Group, the error still occurs.

## Resolution

On Exchange server, follow these steps:

1. Use an account that has [sufficient permissions](/exchange/permissions/permissions) on your Exchange Server to open the [Exchange Management Shell (EMS)](/powershell/exchange/open-the-exchange-management-shell) or [connect to your Exchange server by using remote PowerShell](/powershell/exchange/connect-to-exchange-servers-using-remote-powershell).

1. To turn off IRM, use the [Set-IRMConfiguration](/powershell/module/exchangepowershell/set-irmconfiguration) PowerShell cmdlet as shown in the following example:

    ```powershell
    Set-IRMConfiguration -InternalLicensingEnabled $false
    ```

1. Backup and delete the folders in `C:\ProgramData\Microsoft\DRM\Server`.

    > [!NOTE]
    > The Server folder is a hidden system folder. Unselect the **Hide protected operating system files** to view the folder.

1. Reboot the computer.
1. To enable IRM, use the [Set-IRMConfiguration](/powershell/module/exchangepowershell/set-irmconfiguration) PowerShell cmdlet as shown in the following example:

    ```powershell
    Set-IRMConfiguration -InternalLicensingEnabled $true
    ```

1. To test IRM, use the [Test-IRMConfiguration](/powershell/module/exchangepowershell/test-irmconfiguration) PowerShell cmdlet as shown in the following example:

    ```powershell
    Test-IRMConfiguration -sender [user@domain.com]
    ```

## More information

Exchange uses old cached identity and licensing data from the deleted FederatedEmail account. After you remove the files under the Server folder, the cache includes the Exchange servers local system account.

Restart the Exchange server to make sure that Exchange rebuilds the cache and uses the updated identity data.