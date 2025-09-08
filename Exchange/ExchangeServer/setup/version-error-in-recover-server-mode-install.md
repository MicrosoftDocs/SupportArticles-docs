---
title: Version error when you install Exchange Server in RecoverServer mode
description: Provides a resolution for a version error that you encounter when you install Exchange Server in RecoverServer mode.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.reviewer: batre, ninob, meerak, v-trisshores
ms.custom: 
  - sap:Plan and Deploy\Exchange Install Issues, Cumulative or Security updates
  - CI 171721
  - Exchange Server
  - CSSTroubleshoot
search.appverid:
  - MET150
appliesto:
  - Exchange Server 2019
  - Exchange Server 2016
ms.date: 01/24/2024
---

# Version error when you install Exchange Server in RecoverServer mode

## Symptoms

When you try to recover a lost server by [installing Microsoft Exchange Server in RecoverServer mode](/exchange/high-availability/disaster-recovery/recover-exchange-servers), an installation prerequisite check fails and returns the following error message:

> Exchange Server version \<version value\> or later must be used to perform a recovery of this server.

The issue occurs if the lost server has the January 2023 Exchange Server security update (SU) installed. The version value in the error message matches the version of the January 2023 Exchange Server SU.

## Cause

The January 2023 SU updated the `SerialNumber` property in Active Directory for Exchange Server on the lost server. The `SerialNumber` property should contain the Exchange Server cumulative update (CU) version. However, the January 2023 SU updates that property to the SU version instead. The prerequisite check fails because the Exchange Server CU version of the recovery media is earlier than the January 2023 SU version that's stored in the `SerialNumber` property.

## Resolution

To resolve the issue, restore the `SerialNumber` value to the Exchange Server CU version. To do this, use one of the following methods.

### Method 1: Use PowerShell

1. Choose a `SerialNumber` value that matches the CU version that's installed on the lost server. Use the following table.

   | Cumulative Update | SerialNumber |
   | - | - |
   | Exchange Server 2019 CU12 | Version 15.2 (Build 31118.007) |
   | Exchange Server 2019 CU11 | Version 15.2 (Build 30986.005) |
   | Exchange Server 2016 CU23 | Version 15.1 (Build 32507.006) |
   | Exchange Server 2016 CU22 | Version 15.1 (Build 32375.007) |

2. Update the `SerialNumber` property in Active Directory. To do this, run the following commands:

   ```powershell
   $dn = <distinguished name of the Exchange Server installation on the lost server>
   Set-ADObject -Identity "$dn" -Replace @{serialnumber="<SerialNumber>"}
   ```

   For example, you might run the following commands if the lost server has Exchange Server 2019 CU12 installed:

   ```powershell
   $dn = "CN=e161,CN=Servers,CN=Exchange Administrative Group (FYDIBOHF23SPDLT),CN=Administrative Groups,CN=Contoso,CN=Microsoft Exchange,CN=Services,CN=Configuration,DC=Contoso,DC=com"
   Set-ADObject -Identity "$dn" -Replace @{serialnumber="Version 15.2 (Build 31118.007)"}
   ```

   > [!NOTE]
   > If you receive the error message, "The term 'Get-ADObject' is not recognized as the name of a cmdlet," run the following command in an admin session to install the remote administration tools:
   >
   > ```powershell
   > Install-WindowsFeature RSAT-ADDS
   > ```

3. Retry the Exchange Server install in `RecoverServer` mode. Use a recovery media that has an Exchange Server CU version that is the *same as or later than* the CU version that's installed on the lost server.

4. Install the [latest Exchange Server SU](/exchange/new-features/build-numbers-and-release-dates).

> [!NOTE]
> To read the `SerialNumber` value in Active Directory, run the following commands:
>
> ```powershell
> $dn = <distinguished name of the Exchange Server installation on the lost server>
> Get-ADObject -Identity "$dn" -Properties SerialNumber
> ```

### Method 2: Use ADSI Edit

> [!WARNING]
> This method requires the Active Directory Service Interfaces Editor (ADSI Edit). Using ADSI Edit incorrectly can cause serious problems that may require you to reinstall your operating system. Microsoft cannot guarantee that problems that result from the incorrect use of ADSI Edit can be resolved. Use ADSI Edit at your own risk.

1. Open ADSI Edit.

   > [!NOTE]
   > If ADSI Edit isn't installed, run the following command in an admin session to install the remote administration tools:
   >
   > ```powershell
   > Install-WindowsFeature RSAT-ADDS
   > ```

2. Right-click **ADSI Edit**, select **Connect to**, select **Configuration** from the **Select a well known Naming Context** list, and then select **OK**.

3. Navigate to the following node:

   **CN=Configuration** \> **CN=Services** \> **CN=Microsoft Exchange** \> **CN={organization name}** \> **CN=Administrative Groups** \> **CN=Exchange Administrative Group** \> **CN=Servers** \> **CN={server name}**.

4. Right-click the **CN={server name}** node for the lost server, and then select **Properties** to open the Properties window.

5. In the Properties window, replace the `serialNumber` attribute with the appropriate value from the table in step 1 of [Method 1](#method-1-use-powershell).

   > [!NOTE]
   > The `distinguishedName` attribute in the Properties window provides the distinguished name of the Exchange Server installation on the lost server.

6. Retry the Exchange Server install in `RecoverServer` mode. Use a recovery media that has an Exchange Server CU version that is the *same as or later than* the CU version that's installed on the lost server.

7. Install the [latest Exchange Server SU](/exchange/new-features/build-numbers-and-release-dates).

### More information

For more information about Exchange Server versions, see the following resources:

- [Exchange Server build numbers and release dates](/exchange/new-features/build-numbers-and-release-dates)

- [Updates for Exchange Server](/exchange/new-features/updates)

- [Why Exchange Server updates matter](https://techcommunity.microsoft.com/t5/exchange-team-blog/why-exchange-server-updates-matter/ba-p/2280770)

- [Released: January 2023 Exchange Server Security Updates](https://techcommunity.microsoft.com/t5/exchange-team-blog/released-january-2023-exchange-server-security-updates/ba-p/3711808)
