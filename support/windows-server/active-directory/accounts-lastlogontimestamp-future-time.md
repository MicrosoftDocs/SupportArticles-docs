---
title: Accounts Have the LastLogonTimestamp Value Set to Future
description: Helps resolve an issue in which user or computer accounts have the lastLogonTimestamp value set to a future time.
ms.date: 03/11/2025
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.reviewer: kaushika, herbertm, v-lianna
ms.custom:
- sap:active directory\user,computer,group,and object management
- pcy:WinComm Directory Services
---
# User or computer accounts have the lastLogonTimestamp value set to a future time

This article helps resolve an issue in which user or computer accounts have the lastLogonTimestamp value set to a future time.

You have an Active Directory (AD) domain and use AD queries to look for unused accounts. You query attributes like `pwdLastSet` and `lastLogonTimestamp` to determine which accounts are no longer used.

Although using `lastLogonTimestamp` has its limitations due to Kerberos S4U updating the attribute, you notice that some actively used accounts have the `lastLogonTimestamp` value set to a future time.

## Incorrect time on the local DC

A domain controller (DC) might run with its system time set in the future. In this situation, if a user authenticates with the DC, the DC compares its local time with the time stored in the user account. Then, the DC updates the `lastLogonTimestamp` value as its current time is much more recent.

The time on the DC might be incorrect due to a time synchronization issue with the virtual machine (VM) host, the Network Time Protocol (NTP) infrastructure, or [Secure Time Seeding (STS)](https://techcommunity.microsoft.com/blog/askds/secure-time-seeding-on-dcs-a-note-from-the-field/4238810). The DC might also revert to the correct time quickly, so you might not catch the problem in your reporting.

As NTP prevents large time offsets between DCs from being distributed across the domain, incorrect timestamps might be kept local to a single DC. However, domain members follow their local DC's time, even when the DC detects a time skew during Kerberos requests. This is why Kerberos transactions still work in this situation.

## Use the fixupObjectState attribute with LDIFDE to repair the object

For previous versions of Windows, the approaches to resolve the issue are to:

- Wait until the actual time surpasses the `lastLogonTimestamp` value of the user.
- Ignore the `lastLogonTimestamp` value and use other metrics to identify orphaned accounts.
- Delete the affected accounts and create new ones.

In Windows Server 2022 and Windows Server 2025, there's a new facility to repair broken objects as specified in [[MS-ADTS]: fixupObjectState](/openspecs/windows_protocols/ms-adts/37294765-9e7d-41a1-aded-2d6f744eee8c).

> [!NOTE]
> There's functionality to correct missing `sAMAccountType` and `objectCategory` attributes. For more information, see [Can't edit or delete an AD object and receive the error "attribute is owned by the Security Accounts Manager (SAM)" or "The specified account does not exist"](cannot-edit-delete-ad-object-error-sam.md).

### Step 1: Identify the object name and globally unique identifier (GUID)

For example:

- Distinguished name (DN): `cn=brokenuser,ou=bad-users,dc=contoso,dc=com`
- GUID: `cf2b4aca-0e67-47d9-98aa-30a5fe30dc36`

### Step 2: Prepare an LDIFDE import file using the DN string or GUID-based syntax

- Use the DN string:

    ```output
    DN:
    Changetype:modify
    add: fixupObjectState
    fixupObjectState: cn=brokenuser,ou=bad-users,dc=contoso,dc=com:LastLogonTimestamp
    -
    ```

    > [!NOTE]
    > The line with only a hyphen (`-`) and the empty line are required for a well-formed LDIFDE import file.

- Use the GUID-based syntax:

    If your object name contains special characters, use Unicode for the LDIFDE import file, or use the GUID-based syntax.

    An object name can also be expressed as `<guid=cf2b4aca-0e67-47d9-98aa-30a5fe30dc36>` in the GUID-based syntax.

    So, the expression of `fixupObjectState: cn=brokenuser,ou=bad-users,dc=contoso,dc=com:LastLogonTimestamp` becomes `fixupObjectState: <guid=cf2b4aca-0e67-47d9-98aa-30a5fe30dc36>:LastLogonTimestamp`.

    To use this syntax with the LDIFDE import file, you need to encode the text after the first colon in Base64 format because of the  greater-than (>) and less-than (<) signs:

    ```output
    fixupObjectState:: PGd1aWQ9Y2YyYjRhY2EtMGU2Ny00N2Q5LTk4YWEtMzBhNWZlMzBkYzM2PjpMYXN0TG9nb25UaW1lc3RhbXA=
    ```

    > [!NOTE]
    > The double colon shows the attribute value is in Base64 format. You can use the [Base64 encoder](https://www.bing.com/search?q=site%3Amicrosoft.com%20base64%20encoder&qs=n&form=QBRE&sp=-1&lq=0&pq=site%3Amicrosoft.com%20base64%20encoder&sc=0-33&sk=&cvid=CE994D44ADFC432CA2D3784CEBB3D934&ghsh=0&ghacc=0&ghpl=) to encode the string directly on the web.

    After using the Base64 format, the import file becomes:

    ```output
    DN:
    Changetype:modify
    add: fixupObjectState
    fixupObjectState:: PGd1aWQ9Y2YyYjRhY2EtMGU2Ny00N2Q5LTk4YWEtMzBhNWZlMzBkYzM2PjpMYXN0TG9nb25UaW1lc3RhbXA=
    -
    ```

### Step 3: Repair the object using LDIFDE

Sign in as an Enterprise Administrator, and import the LDIFDE import file (for example, **repair-user.txt**) with the following command:

```console
ldifde /i /f repair-user.txt
Connecting to "<DC name>"
Logging in as current user using SSPI
Importing directory from file " repair-user.txt"
Loading entries...
1 entry modified successfully.
```

Then, the object has the `lastLogonTimestamp` attribute value set to the current time.

## References

For more information about the usage of the `lastLogonTimestamp` attribute, see:

- ["The LastLogonTimeStamp Attribute" - "What it was designed for and how it works"](/archive/blogs/askds/the-lastlogontimestamp-attribute-what-it-was-designed-for-and-how-it-works)
- [How LastLogonTimeStamp is Updated with Kerberos S4u2Self](https://techcommunity.microsoft.com/blog/coreinfrastructureandsecurityblog/how-lastlogontimestamp-is-updated-with-kerberos-s4u2self/257135)
