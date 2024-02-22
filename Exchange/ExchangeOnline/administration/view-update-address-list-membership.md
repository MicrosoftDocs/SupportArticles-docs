---
title: View and update address list membership
description: Describes the commands to view and update address list membership in Exchange Online although there is no update-addresslist command.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Exchange Online
  - CSSTroubleshoot
ms.reviewer: pojaya, v-six
appliesto: 
  - Exchange Online
search.appverid: MET150
ms.date: 01/24/2024
---
# How to view and update address list membership for objects in Exchange Online

_Original KB number:_ &nbsp; 4054858

## Summary

This article describes how to view and update address list membership for objects in Microsoft Exchange Online.

## More information

1. To see whom the filter applies to, run the following command:

    ```powershell
    $a = get-addresslist "my list"
    Get-recipient -filter $a.recipientfilter
    ```

1. To see which users are stamped by the address list that you created, run the following command:

    ```powershell
    Get-Recipient -Filter {AddressListMembership -eq 'DistinguishedName of the address list'}
    ```

1. For each object that you see in step 1 but don't see in step 2, you have to tickle the object. To do this, use one of the following options directly in an instance of Windows PowerShell that's connected to Exchange Online.

    **Option 1:** If the object is a mailbox, run the following commands:

    ```powershell
    set-mailbox -applymandatoryproperties
    ```

    ```powershell
    set-Mailbox -SimpleDisplayName
    ```

    **Option 2:** Run the following command:

    ```powershell
    Set-MailUser -SimpleDisplayName
    ```

    **Option 3:** Set any relevant attributes, including custom attributes, on-premises. Then, synchronize the changes to Exchange Online through Microsoft Entra Connect.

    After you tickle the objects, you should see them by running the command from step 2. You can also verify the objects individually by running the following commands:

    ```powershell
    Get-Mailbox -identity user@contoso.com|fl Addresslistmembership
    ```

    ```powershell
    Get-Mailuser -identity user@contoso.com|fl Addresslistmembership
    ```
