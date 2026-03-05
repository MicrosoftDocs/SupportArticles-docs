---
title: Troubleshoot Event ID 2866 (Maximum Number of Cached Audit Events)
description: Discusses several methods to troubleshoot Event ID 2866, and discusses how to identify which methods are appropriate for your situation.
ms.date: 02/12/2026
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.reviewer: kaushika, herbertm, v-appelgatet
ai-usage: ai-assisted
ms.custom:
- sap:active directory\user, computer, group, and object management
- pcy:WinComm Directory Services
appliesto:
  - <a href=https://learn.microsoft.com/windows/release-health/windows-server-release-info target=_blank>Supported versions of Windows Server</a>
---
# Troubleshoot Event ID 2866 (maximum number of cached audit events)

## Summary

This article discusses how to resolve Event ID 2866 on supported versions of Windows Server. Event ID 2866 occurs when you modify objects in Active Directory Domain Services (AD DS), and those operations generate enough Security log audit events to overload the local transaction audit queue. This article discusses the two primary causes for this issue, how to identify which cause applies to your situation, and how to resolve the issue so that your AD DS operations can resume.

## Symptoms

You modify AD DS objects. The domain controller (DC) that you use to make the changes has audit logging enabled. The DC is also configured to audit the changes that you make. In this scenario, the modifications start to fail. On the DC, the Security log records Event ID 2866. The event text resembles the following example:

```output
While logging audit events for the following object, the directory service reached the maximum number of audit events that could be cached in memory at any given time. As a result of reaching this limit, the operation was aborted.

Maximum number of audit events that can be cached: 17000

Distinguished name of object:

CN=xxxxx,OU=Groups,DC=Contoso,DC=com

Generally, this occurs if there are a large number of changes being performed on attributes that require auditing. An example of such an operation could be deleting the membership of a large group, where the 'member' attribute is being audited.

Additional Data from the Audit Event
Attribute name or old distinguished name:
<Attribute name>

Attribute value or new distinguished name:
<XXXXXXXXXX>

User Action 
(1) Check that an excessive number of object creation, modification, move, rename or undelete operations are not being performed.
(2) Check that an excessive amount of auditing is not enabled. For example, confirm that auditing is not configured for more attributes than is necessary.
(3) If necessary, increase the size of the audit queue by increasing the 'Maximum Audit Queue Size' registry parameter.
```

Typically, this event occurs in one of the following scenarios.

### Scenario 1

You make bulk changes to AD DS objects. These objects have auditing turned on for multiple types of operations.

The change operation fails, and the Security log records Event ID 2866. This event indicates that the rate at which the changes generated audit events overwhelmed the ability of the transaction audit queue to manage them. Therefore, the DC ran out of audit queue space.

### Scenario 2

You make a bulk change to a set of objects that have an attribute that has many values. You replace those values with a few values (or an empty value). The change fails, and you receive error code `0x21B1`, as shown in the following example:

```ldp
ldap_modify_s(ld, 'CN=test-many-members01,OU=TEST01,DC=contoso,DC=com',[1] attrs);
```

```output
Error: Modify: Operations Error.< 1>
Server error: 000021B1: SvcErr: DSID-0315155D, problem 5005 (UNABLE_TO_PROCEED), data 0

Error 0x21B1 A required audit event could not be generated for the operation.
```

The application that you use might also report this error. The Security log records an event that documents the change for one object, as shown in the following example:

```output
Log Name: Security
Source: Microsoft-Windows-Security-Auditing
Event ID: 4662
Task Category: Directory Service Access
Level: Information
Keywords: Audit Success
Description:
An operation was performed on an object.

Subject:
Security ID:      
S-1-5-21-3905871866-2182712795-2692410964-142473
Account Name:      <User>
Account Domain:    CONTOSO
Logon ID:          0x17F8710266

Object:
Object Server:     DS
Object Type:       %{bf967a9c-0de6-11d0-a285-00aa003049e2}
Object Name:       %{<guid>}
HandleID:          0x0

Operation:
Operation Type:    Object Access
Accesses:          Write Property
Access Mask:       0x20
    
Properties:        %%7685
                  {bc0ac240-79a9-11d0-9020-00c04fc2d4cf}
                  {bf9679c0-0de6-11d0-a285-00aa003049e2}
                  {bf967a9c-0de6-11d0-a285-00aa003049e2}
```

A few seconds after the Security log records the preceding event, it records Event ID 2866. Event ID 2866 references the same object as the change event.

> [!NOTE]  
> In this example, the GUID `bc0ac240-79a9-11d0-9020-00c04fc2d4cf` represents the `member` attribute schema that's being modified, not the object itself.

## Cause

The audit events contain information about security-related occurrences, such as reads of AD DS objects, user sign-in attempts, changes to security policies, and changes to particular objects such as groups. When AD DS generates an audit event, the Local Security Authority (LSA) has to write *and* flush the event to the Security log file on the disk. The transaction audit queue is a memory space that buffers audit events until the LSA processes them. After the LSA finishes logging an event, it purges the event from the transaction audit queue.

Under heavy load (for example, during bulk operations), it's possible to generate multiple audit events while still writing the first one to the disk. When the number of audit events reaches the maximum for the queue, operational threads start pausing until their audit event can be inserted into the queue. At this point, AD DS logs Event ID 2866.

### Cause 1: The rate at which audit events accumulate is greater than the system can process

AD DS is generating Audit events at a rate that's consistently higher than the rate at which the DC can write them to the log file and purge them from the queue. The queue eventually reaches its maximum size.

The rate at which AD DS generates audit events depends on several factors:

- How many event sources you configure for auditing
- The type of auditing that's done (such as success auditing, failure auditing, and successful read auditing). For example, all the following categories of operations can generate failure or success auditing:

  - [Sign in (also known as Logon) auditing](/previous-versions/windows/it-pro/windows-10/security/threat-protection/auditing/audit-logon)
  - [Credential validation auditing](/previous-versions/windows/it-pro/windows-10/security/threat-protection/auditing/audit-credential-validation)
  - [Kerberos Authentication Service auditing](/previous-versions/windows/it-pro/windows-10/security/threat-protection/auditing/audit-kerberos-authentication-service)
  - [Kerberos service ticket operations auditing](/previous-versions/windows/it-pro/windows-10/security/threat-protection/auditing/audit-kerberos-service-ticket-operations)
  - [File system auditing](/windows-hardware/drivers/ifs/auditing) (this category can also generate successful read auditing)
  - Directory Service auditing (this category can also generate successful read auditing)
  - [Windows Filtering Platform auditing](/windows/win32/fwp/auditing-and-logging)
  - Process detailed activity auditing

  > [!NOTE]  
  > Success auditing is typically verbose, especially for authentication-related operations. Remember that Kerberos authentication applies to not only user requests but also application and service communications.

### Cause 2: A single transaction generates too many audit events

When the DC auditing level is set to log an audit event for each successful change, AD DS generates such events for each attribute change. When you change a linked attribute, such as `member`, the change propagates to the other objects that have related attributes. For example, you modify a group object by using commands that resemble the following commands:

```ldifde
changetype: modify
replace: member
member:
```

These commands remove all the current values of `member`. Each of those values identifies another object (a group member), and each of those objects has a `memberof` attribute that AD DS automatically maintains. The transaction (remove all group members) generates an audit event for the change to the group object, *plus* audit events for the changes to the member objects. These audit events can accumulate quickly in the transaction audit queue, because the LSA only starts writing events when the transaction is completed successfully.

The default limit on the number of these audit events that the transaction audit queue can hold is 17,000. If a single transaction exceeds that limit, the transaction returns error code `0x21B1` and rolls back the changes. The Security log records Event ID 2866. The application that started the transaction receives the error. However, depending on the exact commands that the transaction used, the application might not receive information about how many changes the transaction generated.

> [!NOTE]  
> The recommended maximum number of operations per LDAP transaction is 5,000. If the number is higher than 5,000, you risk resource and performance issues. Early versions of Windows Server recommended limits of 5,000 members per group. Although that limit was removed for Windows Server 2003, the recommended limit on the number of operations per LDAP transactions remains. For more information, see the following sections of "Active Directory Maximum Limits - Scalability":
>
> - [Maximum Number of Accounts per LDAP Transaction](/previous-versions/windows/it-pro/windows-server-2008-r2-and-2008/cc756101(v=ws.10)#maximum-number-of-accounts-per-ldap-transaction)
> - [Recommended Maximum Number of Users in a Group](/previous-versions/windows/it-pro/windows-server-2008-r2-and-2008/cc756101(v=ws.10)#recommended-maximum-number-of-users-in-a-group)

## Resolution

The specific methods that you use to resolve this issue depend on the cause:

- The rate at which audit events accumulate is greater than the system can process.
  1. [Reduce the volume of audit events](#method-2-reduce-the-volume-of-audit-events).
  1. If step 1 doesn't resolve the issue, consider [increasing the capacity of the transaction audit queue](#method-3-increase-the-capacity-of-the-transaction-audit-queue).

- A single transaction generates too many audit events.
  1. Consider [reducing the number of operations per transaction](#method-1-reduce-the-number-of-operations-per-transaction).
  1. [Reduce the volume of audit events](#method-2-reduce-the-volume-of-audit-events) for the affected operations or objects.
  1. If the previous steps aren't practical or effective, [increase the capacity of the transaction audit queue](#method-3-increase-the-capacity-of-the-transaction-audit-queue).

### Method 1: Reduce the number of operations per transaction

If you can change your client application or the manner in which you manage multi-valued and linked attributes, this method might be practical. Reduce the maximum number of operations in a single transaction by changing the manner in which your client application interacts with AD DS (or the manner in which you manage attributes).

### Method 2: Reduce the volume of audit events

To reduce the overall rate at which your system generates audit events, review which objects and operations generate audit events. Consider whether you could reduce the level of auditing or audit fewer types of objects. For information about how to change auditing settings for specific objects and operations, see the following articles:

- [Audit Generation](/windows/win32/secauthz/audit-generation)
- [Audit Filtering Platform Connection](/previous-versions/windows/it-pro/windows-10/security/threat-protection/auditing/audit-filtering-platform-connection)

For information about auditing policies and recommended settings, see the [References](#references) section of this article.

### Method 3: Increase the capacity of the transaction audit queue

[!INCLUDE [Registry important alert](../../../includes/registry-important-alert.md)]

Before you change the queue capacity, consider how the change might affect your system's performance. This registry entry has no upper limit beyond the unsigned 32-bit value upper limit. However, the default value is the recommended value. Increasing the value increases the load on the DC, and can degrade DC performance in the following manners:

- The queue uses more memory.
- The Security log might use more disk space.
- Audit events take longer to process.

> [!NOTE]
> If your issue is a high volume of audit events (as opposed to the number of audit events per transaction), these performance effects limit the usefulness of an increased queue capacity. Although the increased capacity gives you more room to buffer bursts of events, it doesn't change the rate at which the DC can manage them.

To increase the capacity of the transaction audit queue, follow these steps:

1. On the DC, in Registry Editor, go to the `HKLM\System\CurrentControlSet\services\NTDS\Parameters` subkey. 
1. Under this subkey, use the following information to create an entry:

   - Value: `Maximum Audit Queue Size`
   - Type: `REG_DWORD`
   - Data: An integer between `100` and `4294967295`. The default value is `17000`.

     > [!NOTE]  
     > The Data value measures the number of audit events that the queue can cache. It doesn't measure memory usage. If your issue is the number of audit events per transaction, make sure that the number you use is large enough to handle that number of events. For example, use a number that's larger than the number of members of the largest group.

1. Restart the DC.

## References

- [Command line process auditing](/windows-server/identity/ad-ds/manage/component-updates/command-line-process-auditing)
- [Advanced security auditing FAQ](/previous-versions/windows/it-pro/windows-10/security/threat-protection/auditing/advanced-security-auditing-faq)
- [Plan and deploy advanced security audit policies](/previous-versions/windows/it-pro/windows-10/security/threat-protection/auditing/planning-and-deploying-advanced-security-audit-policies)
- [Advanced Audit Policy Configuration](/windows-server/identity/ad-ds/plan/security-best-practices/advanced-audit-policy-configuration)
- [Active Directory Maximum Limits - Scalability](/previous-versions/windows/it-pro/windows-server-2008-r2-and-2008/cc756101(v=ws.10))
