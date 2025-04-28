---
title: Force Outlook to use the Global Address List to resolve proxy addresses and custom properties in Cached Exchange mode
description: Describes how to force Outlook to use the online Global Address List to resolve email aliases in Cached Exchange mode.
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:People or Contacts\Resolving email addresses and ambiguous name resolution
  - CSSTroubleshoot
appliesto:
- Outlook for Microsoft 365
- Outlook 2021
- Outlook 2019
- Outlook 2016
search.appverid: MET150
ms.reviewer: bwilson, gbratton
author: cloud-writer
ms.author: meerak
ms.date: 04/25/2025
---
# Force Outlook to use the Global Address List to resolve proxy addresses and custom properties in Cached Exchange mode

Microsoft Outlook verifies and resolves the names of e-mail recipients by using the Offline Address Book (OAB) when you use Outlook in Cached Exchange mode. The process of resolving e-mail addresses by using fields such as the DisplayName, is called Ambiguous Name Resolution (ANR).

- displayName
- mail
- givenName
- legacyExchangeDN
- mailNickname
- physicalDeliveryOfficeName
- proxyAddresses
- name
- sAMAccountName
- surname (last name)

The ANR that is used by the OAB indexes the following fields to match names:

- mailNickname (Alias)
- displayName (Display Name)
- physicalDeliveryOfficeName (Office)
- surname (last name)

In OAB version 4, the ANR that is used by the OAB indexes the following fields to match names:

- mailNickname (Alias)
- displayName (Display Name)
- physicalDeliveryOfficeName (Office)
- sn (Last Name)
- givenname (First name)
- SMTPaddress (email address)

## Set the Global Address List as the default method to resolve proxy addresses

If you don't want Outlook to use the OAB, you can add a registry key named `ANR Include Online GAL` to force Outlook to use the online Global Address List (GAL) to resolve ambiguous names or e-mail aliases. Use one of the following registry entries to set the `ANR Include Online GAL` registry key manually or with Group Policy:

Manual setting: `HKEY_CURRENT_USER\Software\Microsoft\Office\14.0\Outlook\Cached Mode`

Group Policy setting: `HKEY_CURRENT_USER\Software\Policies\Microsoft\Office\14.0\Outlook\Cached Mode`

Parameter: `ANR Include Online GAL`  
Type: REG_DWORD  
Value: 0 or 1

The value 0 is the default value for the Offline Address Book. If the value is set to 0, Outlook uses the OAB to resolve ambiguous names or email aliases when you create an email message.

If the value is set to 1, Outlook uses the GAL instead of the OAB to resolve ambiguous names or email aliases when you create an email message. This means that Remote Procedure Calls (RPC) are incurred when the following conditions are true:

- A name is resolved in the **To** box of an email message.
- An email message is sent.
- A reply is sent to a one-off SMTP address.

[!INCLUDE [Important registry alert](../../../includes/registry-important-alert.md)]

To add the `ANR Include Online GAL` registry subkey to the registry manually, use the following steps:

1. Start the Registry Editor.
2. Locate and then select the following subkey in the registry `HKEY_CURRENT_USER\Software\Microsoft\Office\14.0\Outlook\Cached Mode`.
3. On the **Edit** menu, point to **New**, and then select **DWORD (32-bit) Value**.
4. Type _ANR Include Online GAL_, and then press ENTER.
5. Right-click the registry entry and select **Modify**.
6. Type _1_, and then select **OK**.
7. Exit the Registry Editor.

> **Note**:
> When you use a Cached mode profile with the `ANR Include Online GAL` value set to 1, Outlook resolves proxy addresses for a user. For example, Marcelo Santos has the following e-mail addresses in the Active Directory account:
>
> - Primary SMTP address: `msantos@contoso.com`  
> - secondary smtp address: `marcelosantos@fourthcoffee.com`  
> - custom: marcelo:santos  
> - SIP: `msantos@contoso.com`

To resolve these proxy addresses, enter partial addresses. For example, the following proxy addresses will resolve successfully for the user in the example:

- smtp:marcelosantos  
- smtp:`marcelosantos@fourthcoffee`  
- SIP:`msantos@contoso`  
- custom:marcelo

If the name is resolved successfully, then all the Active Directory attributes in the GAL for the user are displayed in the **E-mail Properties** dialog box when you double-click the resolved name.

However, you can't enter the complete addresses for a proxy address that ends with a top-level domain. For example, if you enter the following proxy addresses they won't resolve for the user in the example:

- smtp:`marcelosantos@fourthcoffee.com`  
- SIP:`msantos@contoso.com`

In this instance, nonme of the Active Directory attributes in the GAL for the user are displayed in the **E-mail Properties** dialog box when you double-click the resolved name. Only the Display name, E-mail address, and E-mail type are displayed.
