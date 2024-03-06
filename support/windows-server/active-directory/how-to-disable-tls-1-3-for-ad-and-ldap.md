---
title: How to disable TLS 1.3 for AD and LDAP
description: Introduces how to disable TLS 1.3 for AD and LDAP to resolve compatibility issues.
ms.topic: troubleshooting
ms.date: 12/26/2023
ms.custom: sap:ldap-configuration-and-interoperability, csstroubleshoot
---
# How to disable TLS 1.3 for AD and LDAP

The Windows updates KB5014668 and KB5014665 add support for Transport Layer Security (TLS) 1.3 when using LDAP over SSL or issuing the `StartTLS` command. The updates were released on 6/21/2022.

You may need to disable the TLS 1.3 support for compatibility reasons. This article introduces how to disable or re-enable the TLS 1.3 support.

## Disable or re-enable TLS 1.3

> [!IMPORTANT]  
> Follow the steps in this section carefully. Serious problems might occur if you modify the registry incorrectly. Before you modify it, [back up the registry for restoration](https://support.microsoft.com/help/322756) in case problems occur.

### LDAP server side

Use **Registry Editor** to modify the following values to disable or re-enable TLS 1.3 for Lightweight Directory Access Protocol (LDAP) on the server side:

- Registry key: `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\NTDS\Parameters`
- Registry value: **LdapDisableTLS1.3**
- Value type: **REG_DWORD**
- Value data: **0** (Default Enabled) / **1** (Disabled)

Restart the **Active Directory Domain Services** service for the setting to be effective.

### LDAP client side

Use **Registry Editor** to modify the following values to disable or re-enable TLS 1.3 for LDAP on the client side:

- Registry key: `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\LDAP`
- Registry value: **DisableTLS1.3**
- Value type: **REG_DWORD**
- Value data: **0** (Default Enabled) / **1** (Disabled)

The setting starts taking effect at the next LDAP connection.
