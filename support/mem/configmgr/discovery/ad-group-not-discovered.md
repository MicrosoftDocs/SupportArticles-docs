---
title: Delta AD Group Discovery doesn't detect membership changes in nested OUs
description: Troubleshoot an issue when AD Delta Discovery fails to detect group membership changes in child organizational units.
ms.date: 01/12/2025
ms.reviewer: kaushika, jarrettr, brianhun, payur
ms.custom: sap:Boundary Groups, Discovery and Collections\Active Directory Discovery (all types)
---
# Delta AD Group Discovery doesn't detect membership changes in nested OUs

This article describes how to identify and resolve an issue in which Active Directory Group Discovery fails to detect group membership changes when groups are located in nested organizational units.

_Applies to:_ &nbsp; Configuration Manager (current branch)

## Summary

Active Directory Group Discovery in Configuration Manager uses different algorithms for delta and full discovery cycles. During delta discovery, Configuration Manager builds a tree structure of organizational units (OUs) and excludes child OUs from processing. This behavior can cause delta discovery to miss group membership changes when groups are located in nested OUs within your discovery scopes.

This article helps you identify when this issue affects your environment and provides workarounds to ensure that group membership changes are detected correctly.

## Symptoms

You set up an Active Directory Group Discovery to target specific AD Groups as discovery scopes as per [Configure Active Directory Group Discovery](/intune/configmgr/core/servers/deploy/configure/configure-discovery-methods#bkmk_config-adgd).

You notice that AD Group Delta Discovery fails to catch the changes in certain group memberships. However, forcing a Full Discovery cycle resolves the issue.

In particular, the issue occurs when the following conditions are met:

- Scope A: Group A located in organizational unit OU-A
- Scope B: Group B located in organizational unit OU-B
- OU-B is a child OU located under OU-A

When all these conditions are met, changes in Group B's membership aren't detected by AD Group Delta Discovery.

## Cause

During AD Group Delta Discovery, Configuration Manager detects the organizational units (OUs) of the target groups in discovery scopes and builds a tree structure of OUs. It then ignores any child OUs of the target groups' OUs.

AD Group Full Discovery follows a different algorithm that doesn't ignore child OUs, so it works as expected.

## Resolution

Microsoft is aware of this issue. However, as of January 2026, there's no ETA or commitment to fix it. To work around this issue, you can:

- Move Group B to another OU that isn't a child of OU-A (or any other OU in the discovery scopes).
- Include OU-B in the discovery scopes as an Organizational Unit.
- Fall back to Full AD Group Discovery.

## Identify the issue

Here are the steps to check logs and identify the issue:

1. Create the list of scopes by checking the beginning of any discovery cycle in ADSGDis.log. Verify the LDAP paths. In particular, validate that the affected group is in a child OU of another one in the list.

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

1. If you see this error message for OU-B, you have successfully identified the issue:

   ```output
   INFO: Found invalid Search Path: LDAP://OU=OU-B,OU=OU-A,DC=FOURTHCOFFEE,DC=COM. Probably it's sub search path of other search path and will be covered by them.
   INFO: -------- Finished to process search scope (Immediate search base) --------
   ```
