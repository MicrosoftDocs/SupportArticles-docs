---
title: Error when you test and enable a mailbox
description: Provides a solution to an error that occurs when you try to Test and Enable a mailbox in Dynamics 365.
ms.reviewer: 
ms.topic: troubleshooting
ms.date: 03/31/2021
ms.subservice: d365-sales-email-office-integration
---
# Appointments, contacts, and tasks can't be synchronized for the mailbox because the mailbox user doesn't have sufficient permissions on this mailbox

This article provides a solution to an error that occurs when you try to Test and Enable a mailbox in Dynamics 365.

_Applies to:_ &nbsp; Microsoft Dynamics 365  
_Original KB number:_ &nbsp; 4052824

## Symptoms

When you attempt to Test and Enable a mailbox in Dynamics 365, the following alert is logged:

> "Appointments, contacts, and tasks can't be synchronized for the mailbox \<Mailbox Name> because the mailbox user doesn't have sufficient permissions on this mailbox.
>
> **Email Server Error Code:** Crm.80048306.Not enough privilege to access the Microsoft Dynamics 365 object or perform the requested operation."

If you select to view the details, the following extra details are shown:

> "T:195  
ActivityId: \<GUID>  
\>Exception : Unhandled Exception: Microsoft.Crm.CrmSecurityException: SecLib::AccessCheckEx failed. Returned hr = -2147187962, ObjectID: \<GUID>, OwnerId: \<GUID>,  OwnerIdType: 8 and CallingUser: \<GUID>. ObjectTypeCode: 4120, objectBusinessUnitId: \<GUID>, AccessRights: WriteAccess     at Microsoft.Crm.BusinessEntities.SecurityLibrary.AccessCheckEx2(ExecutionContext context, SecurityPrincipal principal, SecurityPrincipal ownerPrincipal, Guid objectId, Int32 objectTypeCode, Guid objectBusinessUnitId, AccessRights rights)    at Microsoft.Crm.Asynchronous.EmailConnector.ExchangeSyncUtility.HasExchangeSyncIdMappingAccess(Guid userId, Int32 userIdTypeCode, IACTProviderContext orgContext)    at Microsoft.Crm.Asynchronous.EmailConnector.ExchangeSyncWorker.PerformPreMailboxSyncChecks()    at Microsoft.Crm.Asynchronous.EmailConnector.ExchangeS..."

## Cause

The Dynamics 365 user associated with the mailbox doesn't have sufficient privileges. It's often caused by the user not having a security role assigned or their security role is missing user level read or write access to the Mailbox entity.

> [!IMPORTANT]
> Verify the Owner of the mailbox record is the same as the User. Example: If the mailbox is a User mailbox for Paul Cannon, verify the Owner value within the mailbox record for Paul Cannon shows as Paul Cannon. If it's some other user, that user may not have access to this user's mailbox.

## Resolution

To fix this issue, follow these steps:

1. As a user with the System Administrator role, open the mailbox record in Dynamics 365.
    > [!NOTE]
    > The alert includes a link to the mailbox record.
2. Verify the Owner field on the mailbox form is populated with the name of the User. If some other user is listed, change it to be the same as this user.
3. Select the link within the Owner field to open the User record for the owning user.
4. Select **Manage Roles** to see which security role(s) is assigned to this user.
5. Navigate to **Settings**, select **Security**, and then select **Security Roles**.
6. Open the roles found in step 4. See [PrivilegeDenied error occurs when using Server-Side Synchronization](https://support.microsoft.com/help/4015092) for a list of required privileges and verify the user's security role contains these privileges.
7. After verifying the user is the owner of their mailbox record and their security role contains the required privileges, select the **Test & Enable Mailbox** button within their mailbox record again. If the test doesn't result in Success, review the message that appears within the Alerts section.
