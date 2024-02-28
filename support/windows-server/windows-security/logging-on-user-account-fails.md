---
title: Logging on a user account fails
description: Describes a problem when a user who is a member of more than 1,010 security groups tries to log on. Provides a resolution.
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:kerberos-authentication, csstroubleshoot
---
# Logging on a user account that is a member of more than 1,010 groups may fail on a Windows Server-based computer

This article solves an issue where logging on a user account that's a member of more than 1,010 groups fails.

_Applies to:_ &nbsp; Windows Server 2008 R2 Service Pack 1  
_Original KB number:_ &nbsp; 328889

## Symptoms

When a user tries to log on to a computer by using a local computer account or a domain user account, the logon request may fail. And you receive the following error message:

> Logon Message: The system cannot log you on due to the following error: During a logon attempt, the user's security context accumulated too many security IDs. Please try again or consult your system administrator.

The issue occurs when the logon user is an explicit or transitive member of about 1,010 or more security groups.

Applications and the security event log ID 4625 may display this error code:

> 0xc000015a

The error is **STATUS_TOO_MANY_CONTEXT_IDS**.

## Cause

When a user logs on to a computer, the Local Security Authority (LSA, a part of the Local Security Authority Subsystem) generates an access token. The token represents the user's security context. The access token consists of unique security identifiers (SID) for every group that the user is a member of. These SIDs include transitive groups and SID values from SIDHistory of the user and the group accounts.

The array that contains the SIDs of the user's group memberships in the access token can contain no more than 1,024 SIDs. The LSA cannot drop any SID from the token. So, if there are more SIDs, the LSA fails to create the access token and the user will be unable to log on.

When the list of SIDs is built, the LSA also inserts several generic, well-known SIDs besides the SIDs for the user's group memberships (evaluated transitively). So, if a user is a member of more than about 1,010 custom security groups, the total number of SIDs can exceed the 1,024 SID limit.

> [!IMPORTANT]
>
> - Tokens for both administrator and non-administrator accounts are subject to the limit.
> - The exact number of custom SIDs varies with the logon type (For example, interactive, service, network) and operating system version of the domain controller and computer that creates the token.
> - Using Kerberos or NTLM as the authentication protocol has no bearing on access token limit.
> - The Kerberos client setting **MaxTokenSize** is discussed in [Problems with Kerberos authentication when a user belongs to many groups](https://support.microsoft.com/help/327825). *Token* in the Kerberos Context refers to the buffer for the tickets received by a Windows Kerberos host. Depending on the size of the ticket, the type of SIDs and whether SID compression is enabled, the buffer can hold fewer or many more SIDs than that would fit into the access token.

The list of custom SIDs will include:

- The primary SIDs of the user/computer and the security groups the account is member of.
- The SIDs in the **SIDHistory** attribute of the groups in scope of the logon.

Because the **SIDHistory** attribute can contain multiple values, the limit of 1,024 SIDs can be reached quickly if accounts are migrated multiple times. The number of SIDs in the Access Token will be less than the total number of groups that the user is a member of in the following situation:

- The user is from a trusted domain where SIDHistory and SIDs are filtered out.
- The user is from a trusted domain across a trust where SIDs are quarantined. Then, only SIDs from the same domain as the user's are included.
- Only the Domain Local Group SIDs from the domain of the resource are included.
- Only the Server Local Group SIDs from the resource server are included.

Because of these differences, it's possible that the user can log on to a computer in one domain, but not to a computer in another domain. The user might also be able to log on to one server in a domain, but not to another server in the same domain.

You can find out about the domain group memberships of an affected user with NTDSUTIL. It has a Group Membership Evaluation tool that also works across forests boundaries. The tool also works for the following users:

- users who are well above the limit of 1,024 SIDs
- users who are in so many groups that Kerberos fails ticket retrieval even with 65,535 bytes of the buffer

Follow these steps:

1. Open a command prompt on a computer that has AD Management Tools (Domain Controller or a computer that has RSAT).
1. Switch to the *`gro mem eva`* tool and then get the available commands as the following screenshot:

    :::image type="content" source="media/logging-on-user-account-fails/gro-mem-eva-commands.png" alt-text="Screenshot of the output after running the gro mem eva command.":::

1. Connect to the DCs that are needed for the evaluation:

   - Set Account DC %s - DC of the user's domain
   - Set Global Catalog %s - GC of the user's forest
   - Set Resource DC %s - DC of the resource domain
   - Set credentials as needed, or verbose logs when the results seem incorrect or the collection fails.

1. Run the evaluation as follows (such as for Admin in `contoso.com`):

    `Run contoso.com Admin`

1. The execution will collect the user details in steps 1-2, resource domain group details in step 3, and then compile the report in steps 4 and 5.

1. The results will be stored in a TSV file in the current directory as the following screenshot:

    :::image type="content" source="media/logging-on-user-account-fails/output.png" alt-text="Screenshot shows that the results will be stored in a TSV file in the current directory.":::

See the following guide to read a TSV file:

- **SID type:** Tells you if it's the primary SID of the Group/User or SIDHistory.
- **SID History Count**: How many SIDs from SIDHistory does this account introduce?
- **One Level MemberOf Count**: How many SIDs does this entry add to the collection on a single level (the entries' member of)?
- **Total MemberOf Count**: How many SIDs does this entry add to the collection in total?
- **Group Owner**: For environments that have delegated group management, you may get hints on how is using too many groups to *attack* user logon.
- **Group Type**: Kind Of Sid. WellKnown, user SID, global, and universal security groups would be in all tokens created for this user. Domain local security group would only be in this resource domain. It can be important when a user has logon problems only in a certain resource domain.
- **Member WhenChanged (UTC)**: Latest change to the group membership. It can help correlate with the time when the user(s) first reported logon issues.

Hints to find groups to target for a change:

- Groups that have SIDHistory have a good leverage helping to reduce the SID count.

- Groups that introduce many other groups through nesting have a great leverage to reduce the SID count.

- Look for clues in the group name to determine whether the group may not be used any longer. For example, we had a customer who has a group per application in their software deployment solution. And we found groups that contained *office2000* or *access2000*.

- Pass the report of the group list to your service and application administrators. Identify groups that aren't needed any longer, maybe only for this user in this business unit or department.

Limitations:

- The tool does not include some kinds of special/WellKnown SIDs that are listed below in this article. Therefore, remember that a user has to be clear several SIDs from 1,024 in the report before it can log on successfully.

- The tool also does not cover server-local groups. If you have problems only on certain servers of a resource domain, maybe the user or some of its group are member of server-local groups.

To get a list of server-local groups and its members:

> [!NOTE]
> Run as admin in an elevated command prompt.

```console
Net localgroup | findstr * > %computername%-grouplist.txt
```

To get a list of members from a domain:

```console
Md server-groups

For /f "delims=*" %d in (%computername%-grouplist.txt) do Net localgroup %d | findstr \ > server-groups\%d-domain-memberlist.txt**
```
  
Mix and match the groups reported there with the user-report from NTDSUTIL.

## Resolution

To fix this problem, use one of the following methods, as appropriate for your situation.

### Method 1

This resolution applies to the following situation:

- The user who encounters the logon error isn't an administrator.
- Administrators can successfully log on to the computer or the domain.

This resolution must be performed by an administrator who has permissions to change the user's group memberships. The administrator must change the user's group memberships to make sure that the user is no longer a member of more than about 1,010 security groups. Consider the transitive group memberships and the local group memberships.

Options to reduce the number of SIDs in the user token include the following. The data collection from NTDSUTIL should help you see what groups are in the scope for change or removal:

- Remove the user from a sufficient number of security groups.

- Convert unused security groups to distribution groups. Distribution groups don't count against the access token limit. Distribution groups can be converted back to security groups when a converted group is required.

- Determine whether security principals are relying on SID History for resource access. If not, remove the SIDHistory attribute from these accounts. You can retrieve the attribute value through an authoritative restore.

> [!NOTE]
> Although the maximum number of security groups that a user can be a member of is 1,024, as a best-practice, restrict the number to less than 1,010. This number makes sure that token generation will always succeed because it provides space for generic SIDs that are inserted by the LSA.

### Method 2

The resolution applies to the situation in which administrator account can't log on to the computer.

When the user whose logon fails because of too many group memberships is a member of the Administrators group, an administrator who has the credentials for the Administrator account (that is, an account that has a well-known relative identifier [RID] of 500) must restart a domain controller by selecting the **Safe Mode** startup option (or by selecting the **Safe Mode** with Networking startup option). In safe mode, the administrator must then log on to the domain controller by using the Administrator account credentials.

Microsoft has changed the token generation algorithm. The LSA can create an access token for the Administrator account so that the administrator can log on regardless of how many transitive groups or intransitive groups that the Administrator account is a member of. When one of these safe mode startup options is used, the access token that is created for the Administrator account includes the SIDs of all Built-in and all Domain Global groups that the Administrator account is a member of.

These groups typically include:

- Everyone (S-1-1-0)
- BUILTIN\Users (S-1-5-32-545)
- BUILTIN\Administrators (S-1-5-32-544)
- NT AUTHORITY\INTERACTIVE (S-1-5-4)
- NT AUTHORITY\Authenticated Users (S-1-5-11)
- LOCAL (S-1-2-0)
- Domain\Domain Users (S-1-5-21-xxxxxxxx-yyyyyyyy-zzzzzzzz-513)
- Domain\Domain Admins (S-1-5-21-xxxxxxxx-yyyyyyyy-zzzzzzzz-512)
- BUILTIN\Pre-Windows 2000 Compatible Access(S-1-5-32-554) if Everyone is a member of this group
- NT AUTHORITY\This Organization (S-1-5-15) if the domain controller is running Windows Server 2003

> [!NOTE]
> If the **Safe Mode** startup option is used, the Active Directory Users and Computers snap-in user interface (UI) is not available. In Windows Server 2003, the administrator may alternatively log on by selecting the **Safe Mode** with Networking startup option; in this mode, the Active Directory Users and Computers snap-in UI is available.

After an administrator has logged on by selecting one of the safe mode startup options and by using the credentials of the Administrator account, the administrator must then identify and modify the membership of the security groups that caused the denial of logon service.

After this change is made, users should be able to log on successfully after a time period that is equal to the domain's replication latency has elapsed.

### Method 3

This option has the biggest appeal if you have many groups that are created to grant access to resources that are used on a specific set of servers, and they aren't relevant to many other servers.
The access token of users always contains the SIDs of the user, global, and universal groups. However, it only contains the SIDs of Domain-Local groups of the domain where the resource servers are. Therefore, from 600 groups a user is member of, 400 are helping with giving access to file server resources on two groups of servers, and then the following ideas may be feasible:

- Split up your servers into multiple groups per the number of Domain-Local groups.
- Instead of one resource domain that has all groups and servers, have multiple domains where only the groups that are defined that contain the servers you need.
- Have a separate domain for servers with a little need for domain local groups. One example could be Exchange servers, as Exchange has a strong preference for universal groups.

## More information

The generic SIDs of an account often include:

- Everyone (S-1-1-0)
- BUILTIN\Users (S-1-5-32-545)
- BUILTIN\Administrators (S-1-5-32-544)
- NT AUTHORITY\Authenticated Users (S-1-5-11)
- Logon Session Sid (S-1-5-5-X-Y)
- BUILTIN\Pre-Windows 2000 Compatible Access(S-1-5-32-554) if user is a member of this group (nested)

> [!IMPORTANT]
> The Tool Whoami is often used to inspect Access Tokens. This tool does not show the logon session SID.

Examples for SIDs depending on logon session type:

- LOCAL (S-1-2-0)
- CONSOLE LOGON (S-1-2-1)
- NT AUTHORITY\NETWORK (S-1-5-2)
- NT AUTHORITY\SERVICE (S-1-5-6)
- NT AUTHORITY\INTERACTIVE (S-1-5-4)
- NT AUTHORITY\TERMINAL SERVER USER (S-1-5-13)
- NT AUTHORITY\BATCH (S-1-5-3)

SIDs for frequently used Primary Groups:

- Domain\Domain Computers (S-1-5-21-xxxxxxxx-yyyyyyyy-zzzzzzzz-515)
- Domain\Domain Users (S-1-5-21-xxxxxxxx-yyyyyyyy-zzzzzzzz-513)
- Domain\Domain Admins (S-1-5-21-xxxxxxxx-yyyyyyyy-zzzzzzzz-512)

SIDs that document how the Logon Session got verified, one of the following values:

- Authentication authority asserted identity (S-1-18-1)
- Service asserted identity (S-1-18-2)

SIDs that give details about token context and claim details, more than one possible:

- Device Claims being used (S-1-5-21-0-0-0-496)
- User Claims being used (S-1-5-21-0-0-0-497)
- This Organization Certificate (S-1-5-65-1)
- Token was built with help of a PKI verified Identity (S-1-18-4)
- Token was built using MFA approach (S-1-18-5)
- Credential Guard was used (S-1-18-6)

SIDs that describe the consistency level of the token, the most common examples:

- Medium Mandatory Level (S-1-16-8192)
- High Mandatory Level (S-1-16-12288)

The access-token includes a SID relative to the user/computer origin, one of the following values:

- NT AUTHORITY\OTHER_ORGANIZATION (S-1-5-1000)
- NT AUTHORITY\This Organization (S-1-5-15) if the account is from the same forest as the computer.

> [!NOTE]
>
> - As you can see with the note at SID entry **Logon Session SID**, do not count the SIDs in the list of tool outputs and assume that they are complete for all target computers and logon types. You should consider an account is in danger of running into this limit when it has more than 1,000 SIDs. Don't forget that, depending on the computer where a token is created, server or workstation local groups can also be added.
> - **xxxxxxxx-yyyyyyyy-zzzzzzzz** indicates the domain or workstation components of the SID.

The following example illustrates which domain local security groups will show up in the user's token when the user logs on to a computer in a domain.

In this example, assume that Joe belongs to *Domain A* and is a member of a domain local group *Domain A\Chicago Users*. Joe is also a member of a domain local group *Domain B\Chicago* Users. When Joe logs on to a computer that belongs to Domain A (for example, Domain A\Workstation1), a token is generated for Joe on the computer, and the token contains, in addition to all the universal and global group memberships, the SID for Domain A\Chicago Users. It will not contain the SID for Domain B\Chicago Users because the computer where Joe logged on (Domain A\Workstation1) belongs to Domain A.

Similarly, when Joe logs on to a computer that belongs to *Domain B* (for example, Domain B\Workstation1), a token is generated for Joe on the computer, and the token contains, in addition to all the universal and global group memberships, the SID for Domain B\Chicago Users; it will not contain the SID for Domain A\Chicago Users because the computer where Joe logged on (Domain B\Workstation1) belongs to Domain B.

However, when Joe logs on to a computer that belongs to *Domain C* (for example, Domain C\Workstation1), a token is generated for Joe on the logon computer that contains all universal and global group memberships for Joe's user account. Neither the SID for Domain A\Chicago Users nor the SID for Domain B\Chicago Users appears in the token because the domain local groups that Joe is a member of are in a different domain than the computer where Joe logged on (Domain C\Workstation1). Conversely, if Joe was a member of some domain local group that belongs to Domain C (for example, Domain C\Chicago Users), the token that is generated for Joe on the computer would contain, in addition to all the universal and global group memberships, the SID for Domain C\Chicago Users.

## References

- [Well-Known SIDs](/windows/win32/secauthz/well-known-sids)

- [Well-Known SID Structures](/openspecs/windows_protocols/ms-dtyp/81d92bba-d22b-4a8c-908a-554ab29148ab)

- [group membership evaluation](/previous-versions/windows/it-pro/windows-server-2012-R2-and-2012/cc733025(v=ws.11))
