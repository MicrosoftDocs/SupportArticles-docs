---
title: Problems occur when CRMAppPool user account is CRM user
description: List the issue that may occur when the CRMAppPool account is configured as a Microsoft Dynamics CRM user. Provides resolutions.
ms.reviewer: mikehamm
ms.topic: troubleshooting
ms.date: 
---
# Problems occur when the CRMAppPool user account is a Microsoft Dynamics CRM user

This article provides resolutions for the issues that may occur when the CRMAppPool account is configured as a Microsoft Dynamics CRM user.

_Applies to:_ &nbsp; Microsoft Dynamics CRM 2011  
_Original KB number:_ &nbsp; 2593042

## Symptoms

Various operations of Microsoft Dynamics CRM may fail when the CRMAppPool account is configured as a Microsoft Dynamics CRM user.

- Data Import may fail.
- Microsoft Dynamics CRM for Outlook clients may not configure.
- Async Operations may have unexpected behavior including Workflows stopping with a Failed status.
- No users can access Microsoft Dynamics CRM.
- IFD access may fail for some or all users.
- Date/Time fields may not display correct timezone offset.

## Cause

The CRMAppPool account is considered the SYSTEM user in Microsoft Dynamics CRM. It is not a true user, and shouldn't be. It is allowed access in Microsoft Dynamics CRM through the PrivUserGroup in Active Directory, along with other groups that it is a member of on the Microsoft Dynamics CRM server and through internal Microsoft Dynamics CRM platform and application code.

Many Microsoft Dynamics CRM operations are called through the Microsoft Dynamics CRM API's under the context of the SYSTEM user account. If the CRMAppPool user account is a Microsoft Dynamics CRM user these calls will run under the context of the Microsoft Dynamics CRM user and not the SYSTEM user and could fail to execute in various parts of Microsoft Dynamics CRM described in the Symptoms section.

Once this user is created, it may cause various problems if the following is not met:

- The user has been disabled.
- The user has not been granted a security role.
- The role does not contain all privileges to complete various operations including hidden roles.

## Resolution

To fix this issue, follow these steps:

1. Resolution 1: Change the CRMAppPool user account to a new Active Directory user account.
2. Resolution 2: Change the Microsoft Dynamics CRM user to a new Active Directory user account that is not tied to any Microsoft Dynamics CRM services.

## More information

Refer to the [Install Microsoft Dynamics CRM 2011 Server on a server without Microsoft Dynamics CRM installed](/previous-versions/hh367322(v=msdn.10)) for setting up service accounts.

> [!NOTE]
> We strongly recommend that you select a low-privilege domain account that is dedicated to running these services and is not used for any other purpose. Additionally, the user account that is used to run a Microsoft Dynamics CRM service cannot be a Microsoft Dynamics CRM user. This domain account must be a member of the Domain Users group. Additionally, if the Asynchronous Service and Sandbox Processing Service roles are installed, such as in a Full Server or a Back End Server installation, the domain account must a member of the Performance Log Users security group.
