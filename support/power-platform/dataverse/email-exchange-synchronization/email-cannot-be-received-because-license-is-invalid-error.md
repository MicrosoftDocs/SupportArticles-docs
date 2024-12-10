---
title: Email can't be received because the license is invalid for the mailbox error
description: Solves an ErrorInvalidLicense error code that occurs when you select Test & Enable Mailbox in Microsoft Dynamics 365.
ms.reviewer: 
ms.date: 12/06/2024
ms.custom: sap:Email and Exchange Synchronization
---
# "Email can't be received because the license is invalid for the mailbox" error when selecting Test & Enable Mailbox

This article provides a resolution for an error that occurs when you test mailbox configuration in Microsoft Dynamics 365.

_Applies to:_ &nbsp; Microsoft Dynamics 365  
_Original KB number:_ &nbsp; 4459027

## Symptoms

After you select [Test & Enable Mailbox](/power-platform/admin/connect-exchange-online#test-the-configuration-of-mailboxes) to test a mailbox, the **Incoming Email Status** shows **Failure**, and an alert is logged with the following details:

> Email can't be received because the license is invalid for the mailbox \<Mailbox Name>.  
> **Email Server Error Code:** ErrorInvalidLicense

## Cause

This error can occur if you try to connect to an Exchange Online user mailbox that doesn't have an Exchange Online license assigned.

## Resolution

To solve this issue, [assign an Exchange Online license to the user mailbox](/microsoft-365/admin/add-users/add-users).

> [!NOTE]
> If the purpose of the mailbox is to function as a queue rather than for individual use, it's recommended to use a shared mailbox in Exchange. Shared mailboxes don't require an Exchange Online license. To check if a mailbox is shared, open the [Exchange admin center](/exchange/features-in-new-eac), select **Recipients**, and then select **Shared**. If the mailbox appears in this list, it's a shared mailbox. If it's a regular mailbox, you'll see an option to convert it to a shared mailbox.

## More information

If you select **Details** in the alert, you see details similar to the following:

> ActivityId: \<GUID>  
> \>Error : \<ResponseMessageType xmlns:q1="`https://schemas.microsoft.com/exchange/services/2006/messages`" p2:type="`q1:FindItemResponseMessageType`" ResponseClass="Error" xmlns:p2="`https://www.w3.org/2001/XMLSchema-instance`">\<q1:MessageText>An internal server error occurred. The operation failed., Mailbox '\<Mailbox ID>' doesn't have a valid license.</q1:MessageText>\<q1:ResponseCode>ErrorInternalServerError\</q1:ResponseCode>\<q1:DescriptiveLinkKey>0</q1:DescriptiveLinkKey>\<q1:MessageXml><t:Value Name="InnerErrorMessageText" xmlns:t="`https://schemas.microsoft.com/exchange/services/2006/types`">The license is invalid for this mailbox.</t:Value><t:Value Name="InnerErrorResponseCode" xmlns:t="`https://schemas.microsoft.com/exchange/services/2006/types`">ErrorInvalidLicense</t:Value><t:Value Name="InnerErrorDescriptiveLinkKey" xmlns:t="`https://schemas.microsoft.com/exchange/services/2006/types`">0</t:Value></q1:MessageXml>\</ResponseMessageType>
