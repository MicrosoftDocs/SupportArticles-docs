---
title: Logged-on user does not have appropriate security permissions error after upgrading 
description: Describes a problem that may occur if a user's role is not granted a required privilege. Explains how to determine the missing privilege and grant it to the user.
ms.reviewer: v-sasing
ms.topic: troubleshooting
ms.date: 
---
# The logged-on user does not have the appropriate security permissions error after upgrading to Microsoft Dynamics CRM 2011

This article provides a resolution to solve the issue that you can't upgrade to Microsoft Dynamics CRM 2011 due to **The logged on user does not have the appropriate security permissions to view these records or perform the specific action**  this error.

_Applies to:_ &nbsp; Microsoft Dynamics CRM 2011  
_Original KB number:_ &nbsp; 953962

## Symptoms

After upgrading to Microsoft Dynamics CRM 2011, a user may encounter the error below when trying to perform an action in Microsoft Dynamics CRM:

> The logged on user does not have the appropriate security permissions to view these records or perform the specific action.

If the Microsoft Dynamics CRM platform trace is enabled, the platform trace includes the following error information:

> MSCRM Error Report:
>
> \--------------------------------------------------------------------------------------------------------  
> Error: Server was unable to process request.  
> Error Number: 0x80040220  
> Error Message: SecLib::CrmCheckPrivilege failed. Returned hr = -2147220960 on UserId: \<ID> and PrivilegeId: \<ID>

> [!NOTE]
> In this example information, the UserId value and the PrivilegeId value are placeholders for the actual values.

## Cause

When you upgrade to Microsoft Dynamics CRM 2011, custom security roles are not automatically granted privileges to all the new features. Only Out-of-the-box roles will be granted default privileges.

This problem may also occur if the user's role is not granted a privilege that is required to perform the action. This situation may occur if one of the following conditions is true:

- The role was created from scratch.
- The role was copied from a standard role. Then, the role was edited extensively.

## Resolution

To resolve this problem, follow these steps.

> [!NOTE]
> These steps require you to have information from the Microsoft Dynamics CRM platform trace.

1. In the error information that appears in the Microsoft Dynamics CRM platform trace, locate the PrivilegeId value.
2. Determine the missing privilege by running an SQL query that uses the PrivilegeId value. For example, run an SQL query that resembles the following against the **OrganizationName**_MSCRM database:

    ```sql
    select Name, * from PrivilegeBase where PrivilegeId = 'a8ecac53-09e8-4a13-b598-8d8c87bc3d33'
    ```

3. To grant the missing privilege to the user, follow these steps:

   1. Start Microsoft Dynamics CRM 2011.
   2. Select **Settings**, select **Administration** under **Settings**, and then select **Security Roles**.
   3. Double-click the role that is assigned to the user.
   4. Grant the missing privilege to the user's role. For example, to grant the prvReadLead privilege to the user's role, select the **Core Records** tab, and then on the **Lead** row, select the appropriate Read privilege.
   5. Select **Save and Close**.
