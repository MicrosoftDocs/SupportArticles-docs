---
title: Running Test-IRMConfiguration in EMS fails
description: Provides a resolution to resolve the failure of the Test-IRMConfiguration cmdlet.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Exchange Server
  - CSSTroubleshoot
search.appverid: 
  - MET150
appliesto: 
  - Exchange Server 2010 Enterprise
  - Exchange Server 2010 Standard
ms.date: 01/24/2024
ms.reviewer: v-six
---
# Test-IRMConfiguration fails: Failed to acquire a use license

_Original KB number:_ &nbsp; 2805976

## Symptoms

When configuring Active Directory Rights Management Service (AD-RMS) with Microsoft Exchange Server 2010, you may receive the following failure when you run `Test-IRMConfiguration` in the Exchange Management Shell (EMS).

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

This problem can occur if the FederatedEmail.4c1f4d8b-8179-4148-93bf-00a95fa1e042 had been deleted and recreated. After reconfiguring the AD-RMS Super Users Group, the above error will still occur.

## Resolution

On Exchange server, follow these steps:

1. Turn off IRM.

    ```powershell
    Set-IRMConfiguration -InternalLicensingEnabled $false
    ```

1. Backup and delete the directories in `C:\ProgramData\Microsoft\DRM\Server`.

    > [!NOTE]
    > The Server folder is a hidden system folder and you will need to unselect the **Hide protected operating system files** to view the folder.

1. Reboot.
1. Enable IRM.

    ```powershell
    Set-IRMConfiguration -InternalLicensingEnabled $true
    ```

1. Test IRM.

    ```powershell
    Test-IRMConfiguration -sender [user@domain.com]
    ```

## More information

Exchange will use the old GIC from the deleted FederatedEmail account. After you remove the files under the Server folder, the new GIC will only contain the Exchange servers local system account.

The Exchange server must be rebooted for the new GIC to with the FederatedEmail account to work correctly.
