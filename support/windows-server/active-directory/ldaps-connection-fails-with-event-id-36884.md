---
title: LDAPS connection fails with event ID 36884
description: Introduce how to troubleshoot event ID 36884 that occurs during LDAPS connections.
author: Deland-Han
ms.author: delhan
ms.topic: troubleshooting
ms.date: 12/26/2023
ms.reviewer: garymu
ms.custom: sap:ldap-configuration-and-interoperability, csstroubleshoot
---
# Event ID 36884 when you try to connect to an LDAPS server

This article introduces how to troubleshoot the event ID 36884 issue that occurs when you try to build a Lightweight Directory Access Protocol (LDAP) connection.

## Issue scenario and event log

Consider the following scenario:

- You installed a certificate on an LDAPS connection point.
- The certificate has the following characteristics:  
  - Subject: ldap.contoso.com  
  - Subject Alternate Name (SAN): ldap.contoso.com
- In the DNS server, you have the following entries:  
  - ldap.contoso.com CNAME myldapserver.contoso.com  
  - myldapserver.contoso.com HOST 10.0.0.1

When you try to connect to the LDAPS connection point, the connection is dropped, and you receive event ID 36884.

```output
Log Name:      System
Source:        Schannel
Date:          <date_and_time>
Event ID:      36884
Task Category: None
Level:         Error
Keywords:      
User:          CONTOSO\<user_name>
Computer:      <computer_name>
Description:
The certificate received from the remote server does not contain the expected name. It is therefore not possible to determine whether we are connecting to the correct server. The server name we were expecting is <computer_name>. The TLS connection request has failed. The attached data contains the server certificate.
The SSPI client process is ldp (PID: 5148).
```

## Cause

LDAPS is looking for myldapserver.contoso.com to be associated with it. However, myldapserver.contoso.com isn't covered by the SAN entries. Therefore, a server name match isn't made, and the connection is dropped.

## How to fix the issue

To fix this issue, use one of the following solutions:

- Use extra SAN(s) to cover the resolved HOST names on the certificate.
- Use a HOST record in DNS instead of the CNAME record.
- Configure the following registry value on the client to use the CNAME for the server name comparison.

  > [!IMPORTANT]
  > This section, method, or task contains steps that tell you how to modify the registry. However, serious problems might occur if you modify the registry incorrectly. Therefore, make sure that you follow these steps carefully. For protection, back up the registry before you modify it so that you can restore it if a problem occurs. For more information about how to back up and restore the registry, see [How to back up and restore the registry in Windows](https://support.microsoft.com/help/322756).

  1. Start Registry Editor.
  2. Locate the following subkey in the registry:  
     `HKEY_LOCAL_MACHINE\System\CurrentControlSet\Services\LDAP`
  3. Create a new **REG_DWORD** value that is named **UseHostnameAsAlias**, and set the value to anything other than zero.
  4. Exit Registry Editor, and then restart the computer.

  After the registry value is configured, the client computer uses ldap.contoso.com to make the match. It's covered by the certificate SANs, so the connection is allowed.
