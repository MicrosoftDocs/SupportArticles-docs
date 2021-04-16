---
title: Cannot add a new Deployment Administrator
description: Provides a solution to an issue where a current Deployment Administrator may be unable to add a new Deployment Administrator from a trusted domain.
ms.reviewer: 
ms.topic: troubleshooting
ms.date: 3/31/2021
---
# Unable to add a new Deployment Administrator from trusted domain in same forest

This article provides a solution to an issue where a current Deployment Administrator may be unable to add a new Deployment Administrator from a trusted domain.

_Applies to:_ &nbsp; Microsoft Dynamics CRM 2011  
_Original KB number:_ &nbsp; 2842571

## Symptoms

A current Deployment Administrator may be unable to add a new Deployment Administrator from a trusted domain.

## Cause

When adding a user from another domain as a Deployment Administrator, you can find that user in the UserPickerForm, but only after the current signed in Deployment Administrator enters credentials to be able to browse the object in the trusted domain. Once the user is chosen and we retrieve the user properties with an LDAP call, the credentials are lost and reverted back to the CRM domain credentials (local deployment administrator credentials without access to the trusted domain). Which causes the LDAP call to not find any users and a null value is returned for the user. It simulates that the user canceled out of the wizard.

## Resolution

To fix this issue, follow these steps:

1. Create a two-way trust between the domains to add the user as a new Deployment Administrator.

2. Manage the username and password before assigning it as a Deployment Administrator. To do it:

    Go to Manage your Network Passwords on the server and have the current Deployment Administrator add the Domain Controller and credentials from the trusted domain. Which allows the credentials to be automatically passed for the LDAP query and not dropped.
