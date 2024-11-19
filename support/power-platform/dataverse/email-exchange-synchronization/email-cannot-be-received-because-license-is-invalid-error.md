---
title: Email can't be received because the license is invalid for the mailbox error
description: You may receive an error that states email can't be received because the license is invalid for the mailbox. This error occurs when you select the Test & Enable Mailbox button in Microsoft Dynamics 365. Provides a resolution.
ms.reviewer: 
ms.topic: troubleshooting
ms.date: 03/31/2021
ms.subservice: d365-sales-email-office-integration
---
# Email can't be received because the license is invalid for the mailbox error occurs in Microsoft Dynamics 365

This article provides a resolution for the error **Email can't be received because the license is invalid for the mailbox** that occurs when you select the **Test & Enable Mailbox** button in Microsoft Dynamics 365.

_Applies to:_ &nbsp; Microsoft Dynamics 365  
_Original KB number:_ &nbsp; 4459027

## Symptoms

After selecting the **Test & Enable Mailbox** button in Microsoft Dynamics 365, the Incoming Email Status shows as **Failure** and an alert is logged with the following details:

> Email can't be received because the license is invalid for the mailbox \<Mailbox Name>.  
**Email Server Error Code:** ErrorInvalidLicense

## Cause

This error can occur if you are attempting to connect to a Microsoft Exchange Online user mailbox and that user/mailbox does not have an Exchange Online license assigned.

## Resolution

Assign an Exchange Online license to the user/mailbox. For more information about how to assign licenses in Office 365, see [Add users and assign licenses at the same time](/microsoft-365/admin/add-users/add-users) .

> [!NOTE]
> If the purpose of the mailbox is to function as a Queue and not a User, it is recommended to use a Shared mailbox in Exchange. Shared mailboxes do not require an Exchange Online license. If you open the Exchange admin center, select recipients, and then select shared, check to see if the mailbox appears in this list. If the mailbox is a regular mailbox and you select it, you will see an option to convert to shared mailbox.

## More information

If you select to view the **Details** within the Alert, you see details similar to the following:

> ActivityId: \<GUID>  
> \>Error : \<ResponseMessageType xmlns:q1="`https://schemas.microsoft.com/exchange/services/2006/messages`" p2:type="`q1:FindItemResponseMessageType`" ResponseClass="Error" xmlns:p2="`https://www.w3.org/2001/XMLSchema-instance`">\<q1:MessageText>An internal server error occurred. The operation failed., Mailbox '\<Mailbox ID>' doesn't have a valid license.</q1:MessageText>\<q1:ResponseCode>ErrorInternalServerError\</q1:ResponseCode>\<q1:DescriptiveLinkKey>0</q1:DescriptiveLinkKey>\<q1:MessageXml><t:Value Name="InnerErrorMessageText" xmlns:t="`https://schemas.microsoft.com/exchange/services/2006/types`">The license is invalid for this mailbox.</t:Value><t:Value Name="InnerErrorResponseCode" xmlns:t="`https://schemas.microsoft.com/exchange/services/2006/types`">ErrorInvalidLicense</t:Value><t:Value Name="InnerErrorDescriptiveLinkKey" xmlns:t="`https://schemas.microsoft.com/exchange/services/2006/types`">0</t:Value></q1:MessageXml>\</ResponseMessageType>
