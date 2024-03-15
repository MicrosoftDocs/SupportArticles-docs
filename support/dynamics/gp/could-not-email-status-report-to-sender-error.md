---
title: Could not email status report to Sender error
description: Provides a resolution for the Could not email status report to Sender error that occurs when you send Receivables Management statements by email in Microsoft Dynamics GP.
ms.reviewer: theley
ms.topic: troubleshooting
ms.date: 03/13/2024
---
# "Could not e-mail status report to Sender. Invalid Recipients" error when emailing Receivables Management Statements

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 857308

## Symptoms

When you try to send Receivables Management statements (not Word Templates) by an email, you receive the following error message:

> Could not e-mail status report to Sender. Invalid Recipients.

## Resolution

The error message is a warning message letting you know that a status report can't be sent. The statements will still be sent to the customer, but the status report isn't going to be sent.

A status report is sent to the sender of the statements so they'll know that the statements were sent successfully.

To prevent the error from occurring, so the statements status report will be sent, the sender can go to **Setup** > **Sales** > **Receivables** and enter their email address under the **E-mailed Statement** section where it says **Status Recipient**. When they enter their email address here and then email the statements, they'll see an email in their inbox letting them know that the statements were sent successfully.
