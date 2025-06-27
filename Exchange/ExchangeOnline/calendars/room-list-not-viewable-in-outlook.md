---
title: Can't view a room list in Outlook or OWA
description: Fixes a problem in which a room list in Microsoft Exchange Online cannot be viewed in Microsoft Outlook or Outlook Web App (OWA).
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Calendaring
  - Exchange Online
  - CSSTroubleshoot
ms.reviewer: rrajan, v-six
appliesto: 
  - Exchange Online
search.appverid: MET150
ms.date: 01/24/2024
---
# An Exchange Online room list isn't viewable in Outlook or OWA

_Original KB number:_ &nbsp; 4039148

## Problem

A room list in Microsoft Exchange Online cannot be viewed in Microsoft Outlook or Outlook Web App (OWA).

## Cause

This issue occurs if the room list is reverted to a distribution group.

## Solution

To resolve this issue, follow these steps:

1. Run the following cmdlet to verify the recipient type of the room list. If the recipient type is not displayed as `RoomList`, go to step 2.

    ```powershell
    Get-distributionGroup "Name of the affected room list" | fl recipienttypedetails
    ```

2. If the tenant is a cloud-only tenant, run the following cmdlet in Exchange Online PowerShell:

    ```powershell
    Set-DistributionGroup "Name of the affected group" -RoomList
    ```

3. If you have an on-premises deployment of Microsoft Exchange Server, run the cmdlet from step 2 in the on-premises Exchange Management Shell.
4. If you do not have an on-premises Exchange Server deployment, change the `msExchRecipientTypeDetails` attribute against the affected distribution groups, and set the value as **268435456** by using the Active Directory PowerShell Module. To do this, follow these steps:

    1. Start PowerShell as an administrator on any domain controller or any server that has a remote server administrator pack installed, and then run the following cmdlet to verify that the module exists on the server:

        ```powershell
        Get-Module -ListAvailable activedirectory
        ```

    2. Import the Active Directory PowerShell Module by using the following cmdlet for PowerShell versions earlier than 3.0. (For PowerShell module 3.0 or later versions, the module should autoload based on the commands that are issued.)

        ```powershell
        Import-Module activedirectory
        ```

    3. Run the following cmdlet to check the current value of the `msExchRecipientTypeDetails` attribute. If no result is retuned, the attribute has no set value.

        ```powershell
        Get-ADObject -Filter {Name -eq "Name of the Distribution group"} -Properties * | Out-String -Stream | Select-String msExchRecipientTypeDetails
        ```

    4. If no value is set on the attribute, run the following cmdlet to set the value:

        ```powershell
        Get-ADObject -Filter {Name -eq "Name of the Distribution group"} -Properties * | Set-ADObject -add @{msExchRecipientTypeDetails=268435456}
        ```

    5. If the attribute value is set incorrectly, run the following cmdlet to change the existing value:

        ```powershell
        Get-ADObject -Filter {Name -eq "mailsg1"} -Properties * | Set-ADObject -Replace @{msExchRecipientTypeDetails=268435456}
        ```

## More information

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).
