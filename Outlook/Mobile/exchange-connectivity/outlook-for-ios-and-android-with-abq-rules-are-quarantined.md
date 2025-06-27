---
title: Outlook for iOS and Android with ABQ rules are quarantined
description: Describes a problem in which Exchange Online users who use Outlook for iOS and Android and who also use Device Access (ABQ) rules are unexpectedly quarantined.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Product Features and How-to Issues\How-to and general questions
  - Outlook for iOS and Android
  - CSSTroubleshoot
ms.reviewer: jchenau
appliesto: 
  - Outlook for iOS
  - Outlook for Android
  - Exchange Online
search.appverid: MET150
ms.date: 01/30/2024
---
# Users who use Outlook for iOS and Android and Device Access (ABQ) rules are unexpectedly quarantined

_Original KB number:_ &nbsp; 3193518

## Symptoms

Exchange Online users who use Outlook for iOS and Android and who also use Device Access (ABQ) rules find that they've been unexpectedly quarantined. This problem occurs in the following scenario:

- The tenant's `DefaultAccessLevel` property that's configured through `Set-ActiveSyncOrganizationSettings` is set to a value of either **Quarantine** or **Block**.
- The tenant administrator previously allowed Outlook for iOS and Android by stamping the DeviceID in the `ActiveSyncAllowedDeviceIDs` property of the mailbox.
- The devices aren't managed by Microsoft Intune.

## Cause

A back-end protocol change in how Microsoft 365 mailbox data is accessed through Outlook for iOS and Android applications changes the DeviceID that the app uses to connect to Exchange Online. The expected behavior is that the new DeviceID will automatically be added to the `ActiveSyncAllowedDeviceID` for the user. But in certain scenarios, the device may be quarantined. In such cases, follow the steps in the Resolution section. This issue is not expected to occur repeatedly.

## Resolution

Contact Support and ask the customer service representative to help you unblock the device.

Or, use one of the following methods to unblock the device:

- Use the Exchange admin center to unblock individual devices. To do this, follow these steps:

  1. Sign in to the Exchange admin center. For more information, see [Exchange admin center in Exchange Online](/exchange/exchange-admin-center).
  2. Select **mobile**, and then under **Quarantined Devices**, select the **Allow** button for each Outlook for iOS and Android app device that needs to be unblocked.

- Use remote PowerShell to unblock all devices. To do this, follow these steps:

  1. Connect to Exchange Online by using remote PowerShell. For more information, see [Connect to Exchange Online PowerShell](/powershell/exchange/connect-to-exchange-online-powershell).
  2. Copy and paste the following code to your remote PowerShell session:

        ```powershell
        function FixUnblock { $Mbxs = Get-CASMailbox -ResultSize 10000 | ?{$_.ActiveSyncAllowedDeviceIDs -ne $null } foreach($Mbx in $Mbxs) { write-host $Mbx.Id $IdList = Get-MobileDevice -Mailbox $Mbx.Id | where {$_.DeviceModel -eq "Outlook for iOS and Android" -and $_.ClientType -eq "REST" -and $_.DeviceAccessState -ne "Allowed" -and $_.FirstSyncTime -ge "9/13/2016"} $CasDevice = Get-CasMailbox $Mbx.Id foreach( $Id in $IdList) { $CasDevice.ActiveSyncAllowedDeviceIDs += $Id.DeviceId } Set-CasMailbox $Mbx.Id -ActiveSyncAllowedDeviceIDs $CasDevice.ActiveSyncAllowedDeviceIDs } }
        ```

  3. In your remote PowerShell session, run the function. To do this, type *FixUnblock*, and then press Enter.

## More information

Users with modern authentication-enabled accounts need to follow the steps in [Account setup with modern authentication in Exchange Online](/exchange/clients-and-mobile-in-exchange-online/outlook-for-ios-and-android/setup-with-modern-authentication) to set up their Outlook for iOS and Android accounts.

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).
