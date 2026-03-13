---
title: Delta AD Group Discovery Doesn't Detect Group Membership Changes in Nested OUs
description: Troubleshoot an issue in which the delta discovery process of AD Group Discovery doesn't detect group membership changes in child organizational units.
ms.date: 01/12/2025
ms.reviewer: kaushika, jarrettr, brianhun, payur
ms.custom: sap:Boundary Groups, Discovery and Collections\Active Directory Discovery (all types)
appliesto:
  - <a href=https://learn.microsoft.com/lifecycle/products/microsoft-configuration-manager target=_blank>Supported versions of Configuration Manager</a>
---
# Delta AD Group Discovery doesn't detect group membership changes in nested OUs

## Summary

Active Directory Group Discovery (AD Group Discovery) in Configuration Manager uses different algorithms for delta and full discovery cycles. During the delta discovery process, Configuration Manager might miss group membership changes when groups belong to nested OUs within your discovery scopes.

This article helps you identify this issue in your environment, and provides workarounds to make sure that Configuration Manager detects all group membership changes.

## Symptoms

You set up discovery scopes for AD Group Discovery to target specific Active Directory Domain Services (AD DS) groups, as described in [Configure Active Directory Group Discovery](/intune/configmgr/core/servers/deploy/configure/configure-discovery-methods#bkmk_config-adgd). The initial full discovery cycle correctly discovers groups in all the in-scope OUs.

Some time after the initial full discovery cycle finishes, you change the membership of a group that belongs to a child OU of another OU. After the delta discovery cycle runs, you notice that Configuration Manager didn't detect your changes. However, if you force a full discovery cycle to run, the issue resolves as the full discovery cycle discovers changes in all groups in the in-scope OUs.

In particular, the issue occurs when you define scopes that resemble the following example:

- **Scope A:** Group A, in organizational unit OU-A
- **Scope B:** Group B, in organizational unit OU-B
- OU-B is a child OU of OU-A

In this example, the delta cycle of AD Group Discovery doesn't detect changes in Group B's membership.

If you want to review log entries to verify this behavior in your system, see [More information](#more-information).

## Cause

During the delta cycle of AD Group Discovery, Configuration Manager identifies the target groups in the discovery scopes, and the OUs to which those groups belong. It builds a tree structure of those OUs. However, that tree doesn't include any child OUs of those OUs.

During the full discovery cycle of AD Group Discovery, Configuration Manager uses a different algorithm that doesn't ignore child OUs. Therefore, the discovery process works as expected.

## Workaround

Microsoft is aware of this issue. To work around this issue, use any of the following methods:

- Move the affected groups to higher-level OUs. For the earlier example, this action means moving Group B to another OU that isn't a child of OU-A (or of any other OU in the discovery scopes).
- Reconfigure the discovery scopes to include the child OUs as target OUs. For the previous example, this action means including OU-B in the discovery scopes as an Organizational Unit.
- Use only the full discovery process for AD Group Discovery.

## More information

To see what this behavior looks like in the ADSGDis.log file, follow these steps:

1. Open ADSGDis.log in a tool such as [CMTrace](/intune/configmgr/core/support/cmtrace), and then review the log entries to identify any discovery cycle.
1. For that discovery cycle, create a list of the discovery scopes that appear in the log entries.
1. Verify the Lightweight Directory Access Protocol (LDAP) path of each scope. In particular, check that the affected group is in a child OU of another one in the list. In the example that this article uses, the scopes and paths resemble the following example:

   ```output
   !!!!Valid Search Scope Name: Unaffected Group     Search Path: LDAP://CN=GROUP-A,OU=OU-A,DC=FOURTHCOFFEE,DC=COM     IsValidPath: TRUE
   !!!!Valid Search Scope Name: Affected Group     Search Path: LDAP://CN=GROUP-B,OU=OU-B,OU=OU-A,DC=FOURTHCOFFEE,DC=COM     IsValidPath: TRUE
   ```

1. Review the log entries to identify any delta discovery cycle. Look for an entry that resembles the following example, and then use the thread ID to filter log entries.

   ```output
   INFO: CADSource::incrementalSync returning 0x00000000~
   ```

1. Review the log entries for the delta discovery cycle. The entries should resemble the following examples:

   1. Delta discovery processes the list of scopes.

      ```output
      INFO: -------- Starting to process search scope (Unaffected Group) --------
      INFO: -------- Finished to process search scope (Unaffected Group) --------
      INFO: -------- Starting to process search scope (Affected Group) --------
      INFO: -------- Finished to process search scope (Affected Group) --------
      ```

   1. Delta discovery processes the LDAP search paths, starting at `immediate search base`.

      ```output
      INFO: -------- Starting to process search scope (Immediate search base) --------
      INFO: Processing search path: 'LDAP://OU=OU-A,DC=FOURTHCOFFEE,DC=COM'.~
      ```

   1. Delta discovery identifies the search path for the child OU (OU-B in the example) as an invalid path, and skips it to process the next path.

      ```output
      INFO: Found invalid Search Path: LDAP://OU=OU-B,OU=OU-A,DC=FOURTHCOFFEE,DC=COM. Probably it's sub search path of other search path and will be covered by them.
      INFO: -------- Finished to process search scope (Immediate search base) --------
      ```
