---
title: Mailbox user doesn't have sufficient permissions error when you test and enable a mailbox
description: Solves an email server error code 80048306 that occurs when you try to test and enable a mailbox in Microsoft Dynamics 365.
ms.reviewer: 
ms.date: 11/29/2024
ms.custom: sap:Email and Exchange Synchronization
---
# "mailbox user doesn't have sufficient permissions" error when you test and enable a malbox in Dynamics 365

This article provides a solution to an error that occurs when you try to test and enable a mailbox in Microsoft Dynamics 365.

_Applies to:_ &nbsp; Microsoft Dynamics 365  
_Original KB number:_ &nbsp; 4052824

## Symptoms

When you attempt to [test and enable a mailbox](/power-platform/admin/connect-exchange-online#test-the-configuration-of-mailboxes) in Dynamics 365, the following alert is logged:

> "Appointments, contacts, and tasks can't be synchronized for the mailbox \<Mailbox Name> because the mailbox user doesn't have sufficient permissions on this mailbox.
>
> **Email Server Error Code:** Crm.80048306.Not enough privilege to access the Microsoft Dynamics 365 object or perform the requested operation."

If you select to view the details, the following extra details are shown:

> "T:195  
ActivityId: \<GUID>  
\>Exception : Unhandled Exception: Microsoft.Crm.CrmSecurityException: SecLib::AccessCheckEx failed. Returned hr = -2147187962, ObjectID: \<GUID>, OwnerId: \<GUID>,  OwnerIdType: 8 and CallingUser: \<GUID>. ObjectTypeCode: 4120, objectBusinessUnitId: \<GUID>, AccessRights: WriteAccess     at Microsoft.Crm.BusinessEntities.SecurityLibrary.AccessCheckEx2(ExecutionContext context, SecurityPrincipal principal, SecurityPrincipal ownerPrincipal, Guid objectId, Int32 objectTypeCode, Guid objectBusinessUnitId, AccessRights rights)    at Microsoft.Crm.Asynchronous.EmailConnector.ExchangeSyncUtility.HasExchangeSyncIdMappingAccess(Guid userId, Int32 userIdTypeCode, IACTProviderContext orgContext)    at Microsoft.Crm.Asynchronous.EmailConnector.ExchangeSyncWorker.PerformPreMailboxSyncChecks()    at Microsoft.Crm.Asynchronous.EmailConnector.ExchangeS..."

## Cause

The Dynamics 365 user associated with the mailbox doesn't have sufficient privileges. It's often caused by the user not having a security role assigned or their security role is missing user level read or write access to the `Mailbox` entity.

> [!IMPORTANT]
> Verify the owner of the mailbox record is the same as the user. Example: If the mailbox is a user mailbox for Paul Cannon, verify the **Owner** value within the mailbox record for Paul Cannon shows as Paul Cannon. If it's some other user, that user might not have access to this user's mailbox.

## Resolution

To fix this issue, follow these steps:

1. Open the mailbox record as a user with the System Administrator role in Dynamics 365.
    > [!TIP]
    > The alert includes a link to the mailbox record.

2. Verify the **Owner** field in the mailbox form has the user's name. If another name is listed, change it to the user's name.
3. Select the link within the **Owner** field to open the user record for the owning user.
4. Select **Manage Roles** to see which security role(s) is assigned to the user.
5. Navigate to **Settings**, select **Security**, and then select **Security roles**.

6. Open the roles found in step 4. See [PrivilegeDenied error occurs when using server-side synchronization](/previous-versions/troubleshoot/dynamics/crm/privilegedenied-error-when-using-server-side-sync) for a list of required privileges and verify the user's security role contains these privileges.

7. After verifying the user is the owner of their mailbox record and their security role contains the required privileges, select the **Test & Enable Mailbox** button in their mailbox record again. If the test doesn't result in **Success**, review the message shown in the **Alerts** section.
