---
title: Delta AD Group Discovery skips the membership discovery for a group scope in child OU of other group scope
description: Troubleshoot an issue when AD Delta Discovery fails to detect group membership change.
ms.date: 01/12/2026
ms.reviewer: kaushika, jarrettr, brianhun, payur
ms.custom: sap:Boundary Groups, Discovery and Collections\Active Directory Discovery (all types)
---
# Delta AD Group Discovery skips detecting the membership change for a group scope in child OU of other group in discovery scopes

This article describes how to identify and resolve an issue in which Active Directory Group Discovery fails to detect group membership changes.

_Applies to:_ &nbsp; Configuration Manager (current branch)

## Symptoms

You set up an Active Directory Group Discovery to target specific AD Groups as discovery scopes as per [Configure Active Directory Group Discovery](https://learn.microsoft.com/en-us/intune/configmgr/core/servers/deploy/configure/configure-discovery-methods#bkmk_config-adgd).

You notice that AD Group Delta Discovery fails to catch the changes in certain group membership. At the same time, forcing a Full Discovery cycle resolves the issue.

In particular, the issue happens when the following conditions are met:

- Scope A: Group A located in organizational unit OU-A
- Scope B: Group B located in organizational unit OU-B
- OU-B is located under OU-A (being, hence, a child OU)

If all above conditions are met, changes in Group B's membership aren't detected by AD Group Delta Discovery.

## Cause

During AD Group Delta Discovery, Configuration Manager detects the organizational units (OUs) of the target groups in discovery scopes and builds a tree structure of OUs. It ignores the child OUs of the target groups' OUs.

AD Group Full Discovery follows different algorithm that doesn't ignore child OUs, so it works as expected.

## Resolution

Microsoft is aware of this issue, however as per January 2026 there's no ETA or even commitment to fix it. To work around this issue, you can either:

- Move the Group B to another OU that isn't a child of OU-A (or any other OU in the discovery scopes).
- Include OU-B in the discovery scopes as Organizational Unit.
- Fall back to Full AD Group Discovery.

## Identify the issue

Here are the steps to check logs and identify the issue:

1. Create the list of scopes by checking the beginning of any discovery cycle in ADSGDis.log. Verify the LDAP Paths: in particular, validate that the affected group is in child OU of another one in the list.

```output
!!!!Valid Search Scope Name: Unaffected Group     Search Path: LDAP://CN=GROUP-A,OU=OU-A,DC=FOURTHCOFFEE,DC=COM     IsValidPath: TRUE
!!!!Valid Search Scope Name: Affected Group     Search Path: LDAP://CN=GROUP-B,OU=OU-B,OU=OU-A,DC=FOURTHCOFFEE,DC=COM     IsValidPath: TRUE
```

1. Find any Delta Discovery cycle in the log. Look for the following line and filter by the thread writing it.

```output
INFO: CADSource::incrementalSync returning 0x00000000~
```

1. First, Delta Discovery goes through the list of scopes:

```output
INFO: -------- Starting to process search scope (Unaffected Group) --------
INFO: -------- Finished to process search scope (Unaffected Group) --------
INFO: -------- Starting to process search scope (Affected Group) --------
INFO: -------- Finished to process search scope (Affected Group) --------
```

1. The Delta Discovery proceeds to "immediate search base" then:

```output
INFO: -------- Starting to process search scope (Immediate search base) --------
INFO: Processing search path: 'LDAP://OU=OU-A,DC=FOURTHCOFFEE,DC=COM'.~
```

1. If you see this error message for the OU-B, you successfully identified the issue:

```output
INFO: Found invalid Search Path: LDAP://OU=OU-B,OU=OU-A,DC=FOURTHCOFFEE,DC=COM. Probably it's sub search path of other search path and will be covered by them.
INFO: -------- Finished to process search scope (Immediate search base) --------
```
