---
title: How to force Outlook to resolve proxy addresses and custom properties in Cached mode
description: Explains how to force Outlook to use the online Global Address List to resolve email alias or names in Cached Exchange Mode. This requires you add a registry key named ANR Include Online GAL.
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - CSSTroubleshoot
appliesto:
- Microsoft Outlook 2010
- Microsoft Outlook 2007
- Microsoft Outlook 2003
search.appverid: MET150
ms.reviewer: bwilson, v-six
author: cloud-writer
ms.author: meerak
ms.date: 01/30/2024
---
# How to force Outlook 2010, 2007 or 2003 to resolve proxy addresses and custom properties in Cached Mode

## Summary

When you use Microsoft Office Outlook 2003, Microsoft Office Outlook 2007, or Microsoft Office Outlook 2010 in Cached Exchange Mode, Outlook verifies and resolves the names of e-mail recipients with the Offline Address Book. The process of resolving e-mail addresses with similar fields, such as the DisplayName, is called Ambiguous Name Resolution (ANR).

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

The ANR that is used by the Offline Address Book indexes the following fields for matching names:

- mailNickname (Alias)
- displayName (Display Name)
- physicalDeliveryOfficeName (Office)
- surname (last name)

For OAB version 4, the ANR that is used by the Offline Address Book indexes the following fields for matching names in the OAB:

- mailNickname (Alias)
- displayName (Display Name)
- physicalDeliveryOfficeName (Office)
- sn (Last Name)
- givenname (First name)
- SMTPaddress (email address)

## Workaround

To work around this behavior, add a registry key that forces Outlook to use the online Global Address List to resolve ambiguous names or e-mail aliases.

> [!NOTE]
> When you are using a Cached mode profile with the `ANR Include Online GAL` value set to 1, Outlook will resolve proxy addresses for a user. For example, Marcelo Santos has the following e-mail addresses in Active Directory account:
>
> - Primary SMTP address: `msantos@contoso.com`  
> - secondary smtp address: `marcelosantos@fourthcoffee.com`  
> - custom: marcelo:santos  
> - SIP: `msantos@contoso.com`

To resolve these proxy addresses enter partial addresses. For example, the following proxy addresses will be successfully resolved for the above example user:

- smtp:marcelosantos  
- smtp:`marcelosantos@fourthcoffee`  
- SIP:`msantos@contoso`  
- custom:marcelo

You can tell the name resolved successfully from the GAL because if you double-click the resolved name the dialog box with all of the user's Active Directory attributes (in the GAL) is displayed. However, you cannot enter the complete addresses for proxy address that end with a top-level domain. For example, if you enter the following proxy addresses they will not be resolved for the above example user:

- smtp:`marcelosantos@fourthcoffee.com`  
- SIP:`msantos@contoso.com`

You can tell the name was not resolved successfully from the GAL because if you double-click the resolved name the **E-mail Properties** dialog box is displayed. This dialog box does not display any Active Directory attributes, only Display name, E-mail address, and E-mail type.

## Resolution

In Outlook, you can use the new registry key named `ANR Include Online GAL` to set the address book that Outlook uses to resolve ambiguous names or e-mail aliases. You can use one of the following registry entries to set the `ANR Include Online GAL` registry key manually or with Group Policy.

### In Outlook 2010

Manual Setting: `HKEY_CURRENT_USER\Software\Microsoft\Office\14.0\Outlook\Cached Mode`

Group Policy Setting: `HKEY_CURRENT_USER\Software\Policies\Microsoft\Office\14.0\Outlook\Cached Mode`

Parameter: `ANR Include Online GAL`  
Type: REG_DWORD  
Value: 0 or 1

The value 0 is the default value for the Offline Address Book. If the value is set to 0, Outlook 2010 uses the Offline Address Book to resolve ambiguous names or email aliases when you create an email message.

If the value is set to 1, Outlook 2010 uses the Global Address Book instead of the Offline Address Book to resolve ambiguous names or email aliases when you create an email message. This means that Remote Procedure Calls (RPC) are incurred when the following conditions are true:

- A name is resolved in the **To** box of an email message.
- An email message is sent.
- A reply is sent to a one-off SMTP address.

> [!IMPORTANT]
> This section, method, or task contains steps that tell you how to modify the registry. However, serious problems might occur if you modify the registry incorrectly. Therefore, make sure that you follow these steps carefully. For added protection, back up the registry before you modify it. Then, you can restore the registry if a problem occurs. For more information about how to back up and restore the registry, see [How to back up and restore the registry in Windows](https://support.microsoft.com/topic/how-to-back-up-and-restore-the-registry-in-windows-855140ad-e318-2a13-2829-d428a2ab0692).

You can manually add the `ANR Include Online GAL` registry subkey to the registry.

Follow these steps, and then exit Registry Editor:

1. Select **Start**, select **Run**, type _regedit_, and then select **OK**.
2. Locate and then select the following subkey in the registry `HKEY_CURRENT_USER\Software\Microsoft\Office\14.0\Outlook\Cached Mode`.
3. On the **Edit** menu, point to **New**, and then select **DWORD Value**.
4. Type _ANR Include Online GAL_, and then press ENTER.
5. On the **Edit** menu, select **Modify**.
6. Type _0_ or _1_, and then select **OK**.

### In Outlook 2007

Manual Setting: `HKEY_CURRENT_USER\Software\Microsoft\Office\12.0\Outlook\Cached Mode`

Group Policy Setting: `HKEY_CURRENT_USER\Software\Policies\Microsoft\Office\12.0\Outlook\Cached Mode`

Parameter: `ANR Include Online GAL`  
Type: REG_DWORD  
Value: 0 or 1

The value 0 is the default value for the Offline Address Book. If the value is set to 0, Outlook 2007 uses the Offline Address Book to resolve ambiguous names or e-mail aliases when you create an e-mail message.

If the value is set to 1, Outlook 2007 uses the Global Address Book to resolve ambiguous names or e-mail aliases when you create an e-mail message instead of using the Offline Address Book. This means that there will be Remote Procedure Calls (RPC) incurred whenever the following conditions are true:

- A name is resolved in the **To** box of an e-mail message.
- An e-mail message is sent.
- A reply is sent to a one-off SMTP address.

> [!IMPORTANT]
> This section, method, or task contains steps that tell you how to modify the registry. However, serious problems might occur if you modify the registry incorrectly. Therefore, make sure that you follow these steps carefully. For added protection, back up the registry before you modify it. Then, you can restore the registry if a problem occurs. For more information about how to back up and restore the registry, see [How to back up and restore the registry in Windows](https://support.microsoft.com/topic/how-to-back-up-and-restore-the-registry-in-windows-855140ad-e318-2a13-2829-d428a2ab0692).

You can manually add the `ANR Include Online GAL` registry key to the registry.

Follow these steps, and then quit Registry Editor:

1. Select **Start**, select **Run**, type _regedit_, and then select **OK**.

2. Locate and then select the following key in the registry:

   `HKEY_CURRENT_USER\Software\Microsoft\Office\12.0\Outlook\Cached Mode`

3. On the **Edit** menu, point to **New**, and then select **DWORD Value**.
4. Type _ANR Include Online GAL_, and then press ENTER.
5. On the **Edit** menu, select **Modify**.
6. Type _0_ or _1_, and then select **OK**.

### In Outlook 2003

Manual Setting: `HKEY_CURRENT_USER\Software\Microsoft\Office\11.0\Outlook\Cached Mode`

Group Policy Setting: `HKEY_CURRENT_USER\Software\Policies\Microsoft\Office\11.0\Outlook\Cached Mode`

Parameter: `ANR Include Online GAL`  
Type: REG_DWORD  
Value: 0 or 1

The value 0 is the default value for the Offline Address Book. If the value is set to 0, Outlook 2003 uses the Offline Address Book to resolve ambiguous names or e-mail aliases when you create an e-mail message.

If the value is set to 1, Outlook 2003 uses the Global Address Book to resolve ambiguous names or e-mail aliases when you create an e-mail message instead of using the Offline Address Book. This means that there will be Remote Procedure Calls (RPC) incurred whenever the following conditions are true:

- A name is resolved in the **To** box of an e-mail message.
- An e-mail message is sent.
- A reply is sent to a one-off SMTP address.

> [!IMPORTANT]
> This section, method, or task contains steps that tell you how to modify the registry. However, serious problems might occur if you modify the registry incorrectly. Therefore, make sure that you follow these steps carefully. For added protection, back up the registry before you modify it. Then, you can restore the registry if a problem occurs. For more information about how to back up and restore the registry, see [How to back up and restore the registry in Windows](https://support.microsoft.com/topic/how-to-back-up-and-restore-the-registry-in-windows-855140ad-e318-2a13-2829-d428a2ab0692).

You can manually add the `ANR Include Online GAL` registry key to the registry.

Follow these steps, and then quit Registry Editor:

1. Select **Start**, select **Run**, type _regedit_, and then select **OK**.
2. Locate and then select the following key in the registry:

   `HKEY_CURRENT_USER\Software\Microsoft\Office\11.0\Outlook\Cached Mode`

3. On the **Edit** menu, point to **New**, and then select **DWORD Value**.
4. Type _ANR Include Online GAL_, and then press ENTER.
5. On the **Edit** menu, select **Modify**.
6. Type _0_ or _1_, and then select **OK**.
