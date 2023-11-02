---
title: Unknown error when sending e-mails in Microsoft Dynamics GP
description: Provides a solution to an issue where an unknown error occurs when you send e-mail in Microsoft Dynamics GP.
ms.reviewer:
ms.topic: troubleshooting
ms.date: 03/31/2021
---
# Unknown error when sending e-mails in Microsoft Dynamics GP

This article provides a solution to an issue where an unknown error occurs when you send e-mail in Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 2981992

## Symptom

When attempting to email a document or report in Microsoft Dynamics GP, you receive the message:

> "An unknown error occurred".  
"An unknown error has occurred".

## Cause

> [!NOTE]
> This is a generic error message and may have several causes.  

- Most common, either there is a "Reply To" address setup, that doesn't exist in the address book.
- Or the report or document is pulling data that has special characters in it.
- Or the data is invalid.

## Resolution

In Microsoft Dynamics GP, from the **Administration** navigation menu, click on **Setup**, click on **Company** and then click on **E-mail Message Setup**.

Verify that all of the addresses listed in the "Have replies sent to" are valid and exist in the mail address book. If not, remove them and try the emailing of the document or report again, which should now work successfully.

> [!NOTE]
> If emailing a document or report from the Financial or Purchasing series, verify also under that series **E-mail Setup** window, the **Have Replies Sent To** addresses are also valid and exist in the mail address book.

## More information

See [When trying to email a Word Template you get the following message: An unknown error has occurred](https://community.dynamics.com/blogs/post/?postid=96a2539e-2b0d-45be-9e1c-f3dfc29e383b) article with additional troubleshooting steps.
