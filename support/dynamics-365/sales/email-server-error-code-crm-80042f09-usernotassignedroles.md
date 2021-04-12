---
title: Email Server Error Code Crm.80042f09.UserNotAssignedRoles
description: Email Server Error Code Crm.80042f09.UserNotAssignedRoles occurs after you select the Test & Enable Mailbox button on a mailbox record in Microsoft Dynamics 365. Provides a resolution.
ms.reviewer: 
ms.topic: troubleshooting
ms.date: 3/31/2021
---
# Email Server Error Code Crm.80042f09.UserNotAssignedRoles after selecting Test & Enable Mailbox on a mailbox record

This article provides a resolution for the **Crm.80042f09.UserNotAssignedRoles** error code that occurs after you select the **Test & Enable Mailbox** button on a mailbox record in Microsoft Dynamics 365.

_Applies to:_ &nbsp; Microsoft Dynamics CRM  
_Original KB number:_ &nbsp; 4014646

## Symptoms

When you select the **Test & Enable Mailbox** button on a mailbox record in Microsoft Dynamics 365, the following alert is logged and Appointment, Contacts, and Tasks synchronization fails:

> Appointments, contacts, and tasks can't be synchronized for the mailbox \<Mailbox Name> because the mailbox user doesn't have sufficient permissions on this mailbox.  
Email Server Error Code: Crm.80042f09.UserNotAssignedRoles

If you select to view the **Details**, the following additional details are shown:  

> T:1738ActivityId: \<ID> >Exception : Unhandled Exception: Microsoft.Crm.Asynchronous.EmailConnector.ExchangeSyncException: Failed to retrieve the sync state : Unhandled Exception: System.ServiceModel.FaultException`1[[Microsoft.Xrm.Sdk.OrganizationServiceFault, Microsoft.Xrm.Sdk, Version=8.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35]]: SecLib::RetrievePrivilegeForUser failed - no roles are assigned to user. Returned hr = -2147209463, User: \<GUID> Detail: \<ID> -2147209463 SecLib::RetrievePrivilegeForUser failed - no roles are assigned to user. Returned hr = -2147209463, User: \<GUID>...  

## Cause

A Microsoft Dynamics 365 security role is not assigned to the user.  

## Resolution

Assign a Microsoft Dynamics 365 security role to the user. For step by instructions for how to assign a security role, see [Create users and assign security roles](/power-platform/admin/create-users-assign-online-security-roles#BKMK_AssignSecurity).
