---
title: Changing krbtgt password may fail
description: Changing the krbtgt password may fail with STATUS_PASSWORD_RESTRICTION if a custom password filter is installed. This article provides a workaround for this problem.
ms.date: 03/16/2020
ms.custom: sap:Security development
ms.reviewer: msmall
ms.technology: windows-dev-apps-security-dev
---
# Changing the Krbtgt password may fail when a custom password filter is installed

When a custom password filter is installed, changing the key Distribution Center Service Account (krbtgt) password may fail with `STATUS_PASSWORD_RESTRICTION`. This article helps you resolve this problem.

_Original product version:_ &nbsp; Windows  
_Original KB number:_ &nbsp; 2549833

## Summary

If a custom password filter (for example, passfilt.dll) is installed on a domain controller you may receive the following error when trying to change the password for the krbtgt account.

> 0xc000006  
> STATUS_PASSWORD_RESTRICTION

The password doesn't meet the password policy requirements. Check the minimum password length, password complexity, and password history requirements.

## Cause

This occurs because there is special logic when changing the password for krbtgt. While the Active Directory Users and Computers (dsa.msc) snap-in allows you to enter a password, it won't be used when changing the password. Instead, the Active Directory creates a long string of random bits to use as the password. Since this string contains random data and not Unicode characters, it fails the typical tests included in password filters. These tests typically include checking to see if password contains a certain combination of upper and lower case letters, numbers, and punctuation.

## Workaround

To work around this issue, include a test for random data or special case the account name krbtgt and return **TRUE** indicating that the password meets the required complexity.
