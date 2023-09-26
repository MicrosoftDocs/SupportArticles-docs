---
title: Exchange error appears in Alert in a Dynamics 365 mailbox
description: Exchange Error appears in Alert in a Dynamics 365 mailbox.
ms.reviewer: 
ms.topic: troubleshooting
ms.date: 03/31/2021
ms.subservice: d365-sales-email-office-integration
---
# Exchange Error appears in Alert in Microsoft Dynamics 365 mailbox

This article helps you fix an issue in which you get a message referencing an Exchange error when you view an alert in a Microsoft Dynamics 365 mailbox.

_Applies to:_ &nbsp; Microsoft Dynamics 365 Customer Engagement Online  
_Original KB number:_ &nbsp; 4514016

## Symptoms

If you view an alert within a Microsoft Dynamics 365 mailbox and click the **Learn More** link next to a message referencing an Exchange error, you may be redirected to this article. For example: You may see a message that contains the following text followed by an error number. Clicking the **Learn More** link at the end of the message may direct you to this article.

> "Email Server Error Code: Exchange server returned..."

## Cause

If your Dynamics 365 organization is configured with Microsoft Exchange, Dynamics 365 will communicate with Exchange using a web service such as Exchange Web Services (EWS). If Dynamics 365 sends a request to Exchange and Exchange returns a failure message, that error may be logged in the **Alerts** section of the corresponding Mailbox record in Dynamics 365. If you're directed to this article, it indicates the Dynamics 365 team doesn't yet have an article focused on that specific Exchange error.

## Resolution

Although Dynamics 365 doesn't yet have an article for this error code returned by Exchange, you can refer to the following Microsoft Exchange article for a description of the different error codes returned by Exchange Web Services (EWS):

[ServiceError Enum](/dotnet/api/microsoft.exchange.webservices.data.serviceerror)

For example: If the error code was 363, the article above describes this as the ErrorServerBusy message and documents this "Occurs when the server is busy". So this may indicate that Dynamics 365 tried to retrieve information from Exchange but Exchange indicated it was currently to busy to process the request. Something like this can indicate Exchange is busy processing other requests and retrying the request later may succeed.
