---
title: Delta AD Group Discovery Doesn't Detect Membership Changes in Groups in Nested OUs
description: Troubleshoot an issue in which AD Delta Discovery fails to detect group membership changes in child organizational units.
ms.date: 01/12/2025
ms.reviewer: kaushika, jarrettr, brianhun, payur
ms.custom: sap:Boundary Groups, Discovery and Collections\Active Directory Discovery (all types)
appliesto:
  - <a href=https://learn.microsoft.com/lifecycle/products/microsoft-configuration-manager target=_blank>Supported versions of Configuration Manager</a>
---
# Delta AD Group Discovery doesn't detect membership changes in groups in nested OUs

## Summary

Active Directory Group Discovery (AD Group Discovery) in Configuration Manager uses different algorithms for delta and full discovery cycles. During the delta discovery process, Configuration Manager doesn't process child organizational units (OUs). This behavior can cause delta discovery to miss group membership changes when groups belong to nested OUs within your discovery scopes.

This article helps you identify this issue in your environment, and provides workarounds to ensure that Configuration Manager detects all group membership changes.

## Symptoms

You set up discovery scopes for Active Directory Group Discovery to target specific Active Directory Domain Services (AD DS) groups as described in [Configure Active Directory Group Discovery](/intune/configmgr/core/servers/deploy/configure/configure-discovery-methods#bkmk_config-adgd). The initial full discovery cycle correctly discovers groups in all the in-scope OUs.

Later, after the delta discovery cycle runs, you notice that changes in particular group memberships are missed. However, if you force a full discovery cycle to run, the issue resolves as the full discovery cycle discovers changes in all groups in the in-scope OUs.

In particular, the issue occurs when you define scopes that resemble the following example:

- **Scope A:** Group A, in organizational unit OU-A
- **Scope B:** Group B, in organizational unit OU-B
- OU-B is a child OU of OU-A

In this example, the delta cycle of AD Group Discovery doesn't detect changes in Group B's membership.

If you want to review log entries to confirm this behavior in your system, see [More information](#more-information).

## Cause

During the delta cycle of AD Group Discovery, Configuration Manager detects the organizational units (OUs) of the target groups in the discovery scopes and then builds a tree structure of OUs. It ignores any child OUs of the target groups' OUs.

During the full discovery cycle of AD Group Discovery, Configuration Manager uses a different algorithm that doesn't ignore child OUs. Therefore, the discovery process works as expected.

## Workaround

Microsoft is aware of this issue. To work around this issue, use any of the following methods:

- Move all groups to top-level OUs. For the example that's used earlier, that means moving Group B to another OU that isn't a child of OU-A (or any other OU in the discovery scopes).
- Reconfigure the discovery scopes to include the child OUs as target OUs. For the example that's used earlier, that means including OU-B in the discovery scopes as an Organizational Unit.
- Use only the full discovery process for AD Group Discovery.

## More information

To see what this behavior looks like in the ADSGDis.log file, follow these steps:

1. Open ADSGDis.log in a text editor, and then review the log entries to identify any discovery cycle.
1. For that discovery cycle, create a list of the discovery scopes that appear in the log entries.
1. Verify the LDAP path of each scope. In particular, validate that the affected group is in a child OU of another one in the list. The example that this article uses, the scopes and paths resemble the following example:

   ```output
   !!!!Valid Search Scope Name: Unaffected Group     Search Path: LDAP://CN=GROUP-A,OU=OU-A,DC=FOURTHCOFFEE,DC=COM     IsValidPath: TRUE
   !!!!Valid Search Scope Name: Affected Group     Search Path: LDAP://CN=GROUP-B,OU=OU-B,OU=OU-A,DC=FOURTHCOFFEE,DC=COM     IsValidPath: TRUE
   ```

1. Review the log entries to identify any delta discovery cycle. Look for an entry that resembles the following example, and then use the name of the thread to filter log entries.

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

   1. Delta discovery processes the scopes themselves, starting at `immediate search base`.

      ```output
      INFO: -------- Starting to process search scope (Immediate search base) --------
      INFO: Processing search path: 'LDAP://OU=OU-A,DC=FOURTHCOFFEE,DC=COM'.~
      ```

   1. Delta discovery identifies the search path for the child ou (OU-B in the example) as an invalid path, and skips it to process the next path.

      ```output
      INFO: Found invalid Search Path: LDAP://OU=OU-B,OU=OU-A,DC=FOURTHCOFFEE,DC=COM. Probably it's sub search path of other search path and will be covered by them.
      INFO: -------- Finished to process search scope (Immediate search base) --------
      ```
