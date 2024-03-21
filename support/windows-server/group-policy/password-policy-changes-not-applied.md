---
title: Password policy changes aren't applied
description: Provides a solution to an issue where the changes aren't applied as expected when you change the password policy.
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:Group Policy\Problems Applying Group Policy, csstroubleshoot
---
# Changes are not applied when you change the password policy

This article helps solve an issue where the changes aren't applied as expected when you change the password policy.

_Applies to:_ &nbsp; Windows 10 - all editions, Windows Server 2012 R2  
_Original KB number:_ &nbsp; 269236

## Symptoms

When you change the password policy, the changes are not applied as expected.

## Cause

This issue can occur in either of the following scenarios:

- The **Block Policy Inheritance** option is enabled on the Domain Controllers organizational unit.
- The password policy is not set in the Default Domain policy.

## Resolution

To resolve this issue, disable the **Block Policy Inheritance** option on the Domain Controllers organizational unit:

1. Start the Active Directory Users and Computers snap-in.
2. Right-click the Domain Controllers organizational unit, click Properties, and then click to clear the **Block Policy Inheritance** check box.
3. On the domain controllers, run the following command: secedit/refreshpolicy machine_policy/enforce  
If this issue occurs because you did not set password policy in the Default Domain policy, set all password policies in the Default Domain policy.

## Status

This behavior is by design.  

## More information

In Windows 2000, password policies are read-only at the domain level. The policy must be applied to the domain controllers for the policy to be applied. If you initiate a password change for a domain password from anywhere in the domain, the change actually occurs on a domain controller.

## Data collection

If you need assistance from Microsoft support, we recommend you collect the information by following the steps mentioned in [Gather information by using TSS for Group Policy issues](../../windows-client/windows-troubleshooters/gather-information-using-tss-group-policy.md).
