---
title: One or more duplicate records were found error when saving item from Exchange
description: One or more duplicate records were found in Microsoft Dynamics 365 when saving item from Exchange to Microsoft Dynamics 365 - this error may occur when you try to track a contact in Microsoft Outlook.
ms.reviewer:  
ms.topic: troubleshooting
ms.date: 3/31/2021
---
# One or more duplicate records were found in Microsoft Dynamics 365 when saving item from Exchange to Microsoft Dynamics 365

This article provides a resolution for the error **One or more duplicate records were found in Microsoft Dynamics 365 when saving item from Exchange to Microsoft Dynamics 365** that may occur when you track a contact in Microsoft Outlook.

_Applies to:_ &nbsp; Microsoft Dynamics CRM  
_Original KB number:_ &nbsp; 4053811

## Symptoms

When you track a contact in Microsoft Outlook, the contact is not created in Microsoft Dynamics 365 but the following alert is logged within the mailbox record:

> One or more duplicate records were found in Microsoft Dynamics 365 when saving item "\<Contact Name>" from Exchange to Microsoft Dynamics 365. Do you want to continue and create a duplicate record anyway?
>
> Email Server Error Code: ExchangeSyncDuplicateRecordsError

If you select **Details**, the following more details are displayed:

> T:420  
ActivityId: \<GUID>  
>Exception : Unhandled Exception: Microsoft.Crm.Asynchronous.EmailConnector.ExchangeSyncException: Failed to sync the item to the CRM server, error code : 102    at   Microsoft.Crm.Asynchronous.EmailConnector.CrmItem.PerformActionBasedOnUserDecision(Int32 errorCode,  
SyncItemChangeType changeType)    at Microsoft.Crm.Asynchronous.EmailConnector.CrmItem.UpdateItem()    at  
Microsoft.Crm.Asynchronous.EmailConnector.ExchangeSyncSteps.WriteToCrmStep.UpdateInCrm(IEnumerable`1 syncItems)

## Cause

This will occur if duplicate detection is enabled in Microsoft Dynamics 365 and the contact you tracked in Outlook matches an existing record in Microsoft Dynamics 365.

For example: Assume you have a duplicate detection rule configured based only on first name and last name and there is an existing contact record in Microsoft Dynamics 365 named Nancy Anderson. If you have a contact in Outlook with the same name and choose to track that contact in Microsoft Dynamics 365, the duplicate detection rule will detect a match and won't create the record without confirmation.

## Resolution

Determine if the contact you tracked in Outlook should be created in Microsoft Dynamics 365 or if it is a duplicate of an existing record. If the record should be created in Microsoft Dynamics 365, select the **Yes** option within the alert.

1. Access your Microsoft Dynamics 365 organization in a web browser.
2. Navigate to **Settings** and then select **Email Configuration**.
3. Select **Mailboxes**.
4. Open your mailbox record and then select the **Alerts** section on the left side of the page.
5. Locate the alert for the contact record that was not created because a potential duplicate was found.
6. While hovering your mouse over the alert, you should see a Yes and No option in the upper-right corner. If you want to create the contact in Microsoft Dynamics 365, select **Yes**.
