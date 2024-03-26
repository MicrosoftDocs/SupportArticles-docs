---
title: Group policy application rules for domain controllers
description: Describes group policy application rules for domain controllers.
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, jseifert
ms.custom: sap:Active Directory\DCPromo and the installation or removal of domain controllers, csstroubleshoot
---
# Group Policy application rules for domain controllers

This article describes group policy application rules for domain controllers.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 259576

## Summary

Domain controllers pull some security settings only from group policy objects linked to the root of the domain. Because domain controllers share the same account database for the domain, certain security settings must be set uniformly on all domain controllers. This ensures the members of the domain have a consistent experience regardless of which domain controller they use to log on. Windows 2000 accomplishes this task by allowing only certain setting in the group policy to be applied to domain controllers at the domain level. This group policy behavior is different for member server and workstations.

The following settings are applied to domain controllers in Windows 2000 only when the group policy is linked to the Domain container:

- All settings in **Computer Configuration/Windows Settings/Security Settings/Account Policies** (This includes all of the Account Lockout, Password, and Kerberos policies.)

- The following three settings in **Computer Configuration/Windows Settings/Security Settings/Local Policies/Security Options**:

  - Automatically log off users when logon time expires
  - Rename administrator account
  - Rename guest account

The following settings are applied to Windows Server 2003-based domain controllers only when the group policy is linked to the domain container. (The settings are located in **Computer Configuration/Windows Settings/Security Settings/Local Policies/Security Options**.)

- Accounts: Administrator account status
- Accounts: Guest account status
- Accounts: Rename administrator account
- Accounts: Rename guest account
- Network security: Force logoff when logon hours expire

## More information

These settings from group policy objects aren't applied on the Domain Controllers organizational unit because a domain controller can be moved out of the Domain Controllers organizational unit and into a different organizational unit. Using the Domain container allows these setting to be applied regardless of in which organizational unit the domain container resides.

The process for applying these settings on a domain controller includes:

- The domain controller gathers the list of group policy objects by searching the parent containers of the domain controller's Computer object.
- The domain controller applies the settings listed earlier only if the group policy object is linked to the Domain container.
- If there are multiple group policy objects linked to the Domain container, application of the group policy objects starts with the group policy object at the bottom of the list and ends with the group policy object at the top. This results in the group policy object at the top taking precedence over the others.
