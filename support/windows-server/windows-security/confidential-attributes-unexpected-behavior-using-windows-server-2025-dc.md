---
title: Operations on Confidential Attributes Produce Unexpected Results When Using Windows Server 2025 DCs
description: Discusses new requirements for using LDAP clients to access confidential attributes while connected to Windows Server 2025-based domain controllers (DCs).
ms.date: 02/12/2026
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.reviewer: kaushika, herbertm, v-appelgatet
ms.custom:
- sap:windows security technologies\ad object permissions, access control, delegation, adminsdholder and auditing
- pcy:WinComm Directory Services
appliesto:
  - ✅ <a href=https://learn.microsoft.com/windows/release-health/windows-server-release-info target=_blank>Supported versions of Windows Server</a>
  - ✅ <a href=https://learn.microsoft.com/windows/release-health/supported-versions-windows-client target=_blank>Supported versions of Windows Client</a>
---
# Unexpected results for operations on confidential attributes on Windows Server 2025 DCs

This article discusses new requirements for using LDAP clients to access confidential attributes while they're connected to Windows Server 2025-based domain controllers (DCs).

## Symptoms

When you search for or edit Active Directory Domain Services (AD DS) objects, you notice the following behavior:

- When you run a Lightweight Directory Access Protocol (LDAP) search request against a Windows Server 2025-based DC, the resulting attribute list doesn't include confidential attributes. However, if you run the same LDAP query against a DC that runs on Windows Server 2022 or earlier, you obtain a full attribute list in the response.

- When you run an LDAP update request that adds or modifies confidential attribute values against a Windows Server 2025-based DC, the update request fails and returns an `INSUFF_ACCESS_RIGHTS` error message. If you run the same LDAP update request against a DC that runs on Windows Server 2022 or earlier, the update request succeeds.

### Example 1: Search results omit confidential attributes

In this example, you run an [Ldifde](/previous-versions/windows/it-pro/windows-server-2012-r2-and-2012/cc731033(v=ws.11)) query try to read the legacy Local Administrator Password Solution (LAPS) password attribute. The query resembles the following example:

```console
ldifde /s DC25 /d "CN=test-comp01,OU=New-Computers,DC=contoso,DC=com" /f test-comp01.txt /l ms-Mcs-AdmPwd,cn
```

The client connects and exports a list of the object's attributes, and generates output that resembles the following example (as expected).

```output
Connecting to "dc25"
Logging in as current user using SSPI
Exporting directory to file test-comp01.txt
Searching for entries...
Writing out entries.
1 entries exported
```

> [!NOTE]  
> This example text is created by using an LDAP client on Windows 11, 23H2, or an earlier version of Windows.

However, when you review the exported list, you find the "cn" attribute but not the "ms-Mcs-AdmPwd" attribute.

When you target the query to a DC that runs an earlier version of Windows, the resulting exported list includes both "cn" and "ms-Mcs-AdmPwd."

The following table summarizes the behavior across different client and server versions.

| Client | Target DC | Returned attributes |
| --- | --- | --- |
| Windows 11, version 24H2 | Windows Server 2025 | "cn"<br />"ms-Mcs-AdmPwd" |
| Windows Server 2025 (member server) | Windows Server 2025 | "cn"<br />"ms-Mcs-AdmPwd" |
| Windows versions earlier than Windows 11, version 24H2 | Windows Server 2025 | "cn" |
| Non-Windows operating system (for example, a UNIX-based client) | Windows Server 2025 | "cn" |
| Windows versions earlier than Windows 11, version 24H2 | Windows Server 2022 or an earlier version | "cn"<br />"ms-Mcs-AdmPwd" |
| Non-Windows operating system (for example, a UNIX-based client) | Windows Server 2022 or an earlier version | "cn"<br />"ms-Mcs-AdmPwd" |

### Example 2: Operations on confidential attributes fail

In this example, you create an LDIFDE file (named Update.txt) that modifies the value of a confidential attribute. For convenience, this example refers to the same legacy LAPS password as the previous example. (Note: We don't recommend this type of change in practice). The file text resembles the following example:

```console
dn: CN=test-comp01,OU=New-Computers,DC=contoso,DC=com
changetype: modify
replace: ms-Mcs-AdmPwd
ms-Mcs-AdmPwd: <PasswordText>
-
```

To import the file, open a Windows Command Prompt window, and then run the following command:

```console
ldifde /s dc25 -i /f .\update.txt
```

The resulting output resembles the following example:

```output
Connecting to "dc25"
Logging in as current user using SSPI
Importing directory from file ".\update.txt"
Loading entries.
Add error on entry starting on line 1: Insufficient Rights
The server side error is: 0x2098 Insufficient access rights to perform the operation.
The extended server error is:
00002098: SecErr: DSID-03151656, problem 4003 (INSUFF_ACCESS_RIGHTS), data 0
```

When you use a similar approach to try to create an object and set a value for a confidential attribute on that object, the resulting output resembles the following example:

```output
Add error on entry starting on line 1: Insufficient Rights
The server side error is: 0x2098 Insufficient access rights to perform the operation.
The extended server error is:
00002098: SecErr: DSID-03153BAC, problem 4003 (INSUFF_ACCESS_RIGHTS), data 0
```

Similarly to the previous query example, the operations succeed or fail depending on the client and server versions. The following table summarizes these interactions.

| Client | Target DC | Operation result |
| --- | --- | --- |
| Windows 11, version 24H2 | Windows Server 2025 | Success |
| Windows Server 2025 (member server) | Windows Server 2025 | Success |
| Windows version earlier than Windows 11, version 24H2 | Windows Server 2025 | INSUFF_ACCESS_RIGHTS |
| Non-Windows operating system (for example, a UNIX-based client) | Windows Server 2025 | INSUFF_ACCESS_RIGHTS |
| Windows version earlier than Windows 11, version 24H2 | Windows Server 2022 or an earlier version | Success |
| Non-Windows operating system (for example, a UNIX-based client) | Windows Server 2022 or an earlier version | Success |

## Cause

Because of new functionality in Windows Server 2025 DCs, your administrative client must establish an encrypted connection to AD DS in order to search, read, add, or modify confidential object attributes. [What's new in Windows Server 2025](/windows-server/get-started/whats-new-windows-server-2025#active-directory-domain-services) describes the new functionality:

- **Improved security for confidential attributes**: DCs and AD LDS instances allow LDAP only to add, search, and modify operations that involve confidential attributes when the connection is encrypted.

This behavior doesn't affect LDAP clients that run on Windows Server 2025-based member servers or Windows 11, version 24H2-based computers. On these operating system versions, LDAP clients use encrypted sessions by default.

## Workaround

To work around this issue, use one of the following methods:

- Configure your LDAP client to use the [**LDAP_OPT_ENCRYPT**](/previous-versions/windows/desktop/ldap/session-options) session option (or update to a client that supports this option). If you're using ldifde on Windows, use the `/h` switch (for example, run `ldifde /h /s dc25 -i /f .\update.txt`).

- Use Windows Server 2025 or Windows 11 24H2, or a newer version, as an LDAP client. By default, these operating systems encrypt LDAP sessions. For more information about this feature, see [What's new in Windows Server 2025](/windows-server/get-started/whats-new-windows-server-2025#active-directory-domain-services).

- If you can't use either of the previous methods, you can temporarily disable the encrypted session requirements. For more information, see [How dsHeuristics affects the encrypted session requirements and related events](#how-dsheuristics-affects-the-encrypted-session-requirements-and-related-events) in this article.

  > [!IMPORTANT]  
  > This method isn't secure. Use it only as a temporary step.

## More information

Several new Directory Service events document this behavior. The following table summarizes these events.

| Event ID | Action that a client attempted during an unencrypted session | User error (returned to the client) |
| --- | --- | --- |
| 3079 | Search for one or more confidential attributes. | None |
| 3080 | Set a value for a confidential attribute of an existing object. | `INSUFF_ACCESS_RIGHTS` |
| 3081 | Add an object that has values for confidential attributes. | `INSUFF_ACCESS_RIGHTS` |

### Details of Event ID 3079

```output
Log Name: Directory Service
Source: Microsoft-Windows-ActiveDirectory_DomainService
Event ID: 3079
Task Category: Security
Level: Warning
Keywords: Classic
User: contoso\admin
Computer: dc25.contoso.com
Description:
The directory blocked access to one or more confidential attributes on one or more LDAP search requests because one or more clients were using an unencrypted LDAP connection.
```

### Details of Event ID 3080

```output
Log Name: Directory Service
Source: Microsoft-Windows-ActiveDirectory_DomainService
Event ID: 3080
Task Category: Security
Level: Warning
User: contoso\admin
Computer: dc25.contoso.com
Description:
The directory blocked one or more LDAP modify requests including changes to one or more confidential attributes because one or more clients were using an unencrypted LDAP connection.
```

### Details of Event ID 3081

```output
Log Name: Directory Service
Source: Microsoft-Windows-ActiveDirectory_DomainService
Event ID: 3081
Task Category: Security
Level: Warning
User: contoso\admin
Computer: dc25.contoso.com
Description:
The directory blocked one or more LDAP add requests including changes to one or more confidential attributes because one or more clients were using an unencrypted LDAP connection.
```

### How dsHeuristics affects the encrypted session requirements and related events

It's possible (for example, in testing scenarios) to use the `dsHeuristics` attribute to modify the requirements for encrypted sessions. For example, if you configure `dsHeuristics` to disable the encrypted session requirement for searching confidential attributes, searches that use nonencrypted sessions successfully return both nonconfidential and confidential results. Event ID 3079 doesn't appear in the event log.

The `dsHeuristics` value is a string in which individual characters or sets of characters reflect parameter values. The 31st character represents the value of `DisableConfidentialAttributeEncryptionRequirements`. This value ranges from **0** (all the encrypted session requirements are enforced) to **7** (all the encrypted session requirements are disabled). For example, **0000000001000000000200000000037** is a `dsHeuristics` value that disables all the encrypted session requirements. `DisableConfidentialAttributeEncryptionRequirements` is a three-bit value. The following table describes how the values correlate to the encrypted session requirements.

| Affected requirement | Bit | Not set (default) | Set (integer value) |
| --- | --- | --- | --- |
| Encrypted session required to search confidential attribute values | 0 | **0** (enforced) | **1** (disabled) |
| Encrypted session required to modify existing confidential attribute values | 1 | **0** (enforced) | **2** (disabled) |
| Encrypted session required to add an object that has confidential attribute values | 2 | **0** (enforced) | **4** (disabled) |

For more information about `dsHeuristics`, see [6.1.1.2.4.1.2 dSHeuristics](/openspecs/windows_protocols/ms-adts/e5899be4-862e-496f-9a38-33950617d2c5).

When AD DS starts, it checks `dsHeuristics`. If any of the encrypted session requirements are disabled, it logs the appropriate events to document that fact. The following table lists these events, the corresponding disabled requirements, and the events that the `dsHeuristics` setting suppresses.

| Event ID | Effects of the corresponding `dsHeuristic` setting | Suppressed Event ID |
| --- | --- | --- |
| 3076 | Encrypted sessions aren't required for searches of confidential attributes | 3079 |
| 3077 | Encrypted sessions aren't required to modify existing confidential attributes | 3080 |
| 3078 | Encrypted sessions aren't required to add objects that have confidential attributes | 3081 |

#### Details for Event ID 3076

```output
Log Name: Directory Service
Source: Microsoft-Windows-ActiveDirectory_DomainService
Event ID: 3076
Task Category: Security
Level: Warning
Keywords: Classic
User: contoso\admin
Computer: dc25.contoso.com
Description:
The directory has been configured to return confidential attributes for LDAP search requests on unencrypted LDAP connections. No events will be logged and no requests will be blocked.

This setting is not secure and should only be used as a temporary step.
```

#### Details of Event ID 3077

```output
Log Name: Directory Service
Source: Microsoft-Windows-ActiveDirectory_DomainService
Event ID: 3077
Task Category: Security
Level: Warning
Keywords: Classic
User: contoso\admin
Computer: dc25.contoso.com
Description:
The directory has been configured to allow modifying confidential attributes on unencrypted LDAP connections. No events will be logged and no requests will be blocked.

This setting is not secure and should only be used as a temporary step.
```

#### Details of Event ID 3078

```output
Log Name: Directory Service
Source: Microsoft-Windows-ActiveDirectory_DomainService
Event ID: 3078
Task Category: Security
Level: Warning
Keywords: Classic
User: contoso\admin
Computer: dc25.contoso.com
Description:
The directory has been configured to allow adding new objects with confidential attributes on unencrypted LDAP connections. No events will be logged and no requests will be blocked.

This setting is not secure and should only be used as a temporary step.
```

### Deeper investigation

[!INCLUDE [Registry important alert](../../../includes/registry-important-alert.md)]

For queries, if you want to verify that clients are using unencrypted sessions, you can correlate Event ID 3079 with field engineering Event ID 1644. To turn on verbose logging and maximize the event information that the queries generate, run the following commands at a Windows command prompt:

```console
reg add "hklm\system\currentcontrolset\services\ntds\parameters" /v "Expensive Search Results Threshold" /t reg_dword /d 00000001 /f
```

```console
reg add "hklm\system\currentcontrolset\services\ntds\parameters" /v "Inefficient Search Results Threshold" /t reg_dword /d 00000001 /f
```

```console
reg add "hklm\system\currentcontrolset\services\ntds\parameters" /v "Search Time Threshold (msecs)" /t reg_dword /d 00000001 /f
```

```console
reg add "hklm\system\currentcontrolset\services\ntds\diagnostics" /v "15 Field Engineering" /t reg_dword /d 00000005 /f
```

When these settings take effect, all LDAP queries to AD DS generate instances of Event ID 1644. To support the increased log information, consider increasing the maximum size of the Directory Service log.

To continue the previous example, the query for "cn" and "ms-Mcs-AdmPwd" generates Event ID 3079, followed by Event ID 1644. Event ID 1544 resembles the following example:

```output
Log Name: Directory Service
Source: Microsoft-Windows-ActiveDirectory_DomainService
Event ID: 1644
Task Category: Field Engineering
Level: Information
Computer: dc25.contoso.com
Description:
Internal event: A client issued a search operation with the following options.

Client:
10.32.51.5:54994
Starting node:
DC=contoso,DC=com
Filter:
(objectCategory=CN=Computer,CN=Schema,CN=Configuration,DC=contoso,DC=com)
Search scope:
subtree
Attribute selection:
ms-Mcs-AdmPwd,cn
...
User:
Contoso\Admin
```

You might also see Event ID 2041. This event indicates that duplicate log entries are suppressed. The event content resembles the following example:

```output
Log Name: Directory Service
Source: Microsoft-Windows-ActiveDirectory_DomainService
Event ID: 2041
Task Category: Internal Processing
Level: Information
Computer: dc25.contoso.com
Description:
Duplicate event log entries were suppressed.

See the previous event log entry for details. An entry is considered a duplicate if the event code and all its insertion parameters are identical. The time period for this run of duplicates is from the time of the previous event to the time of this event.

Event Code:
80000c07
Number of duplicate entries:
7
```

In this context, the information in these events indicates the following behavior:

- The request tries to inspect a confidential attribute on each of eight AD DS objects.
- For each of the eight objects, the query results omit the confidential attribute.

To identify clients that used an unencrypted session, cross-reference the user details from Event ID 3079 to the query, the port details from Event ID 1644, and the client IP address.

To turn off verbose logging when you finish investigating, run the following commands:

```console
reg delete "hklm\system\currentcontrolset\services\ntds\parameters" /v "Expensive Search Results Threshold" /f
```

```console
reg delete "hklm\system\currentcontrolset\services\ntds\parameters" /v "Inefficient Search Results Threshold" /f
```

```console
reg delete "hklm\system\currentcontrolset\services\ntds\parameters" /v "Search Time Threshold (msecs)" /f
```

```console
reg add "hklm\system\currentcontrolset\services\ntds\diagnostics" /v "15 Field Engineering" /t reg_dword /d 00000000 /f
```
