---
title: Unable to add CRM App due to Missing Email Address
description: This article provides a resolution for the problem where you are unable to deploy the CRM App for Outlook to users when using the Exchange Server (Hybrid) option.
ms.reviewer: 
ms.topic: troubleshooting
ms.date: 3/31/2021
---
# Unable to add CRM App for Outlook due to Missing Email Address

This article helps you resolve the problem where you are unable to deploy the CRM App for Outlook to users when using the Exchange Server (Hybrid) option.

_Applies to:_ &nbsp; Microsoft Dynamics CRM 2016  
_Original KB number:_ &nbsp; 3165820

## Symptoms

When using the Exchange Server (Hybrid) option, you are unable to deploy the CRM App for Outlook to users. The Status column says **Issue when adding to Outlook**. When you click the **Learn more** link, the following message appears in the Details dialog:

> ResponseMessageType : ErrorMissingEmailAddress
>
> When making a request as an account that does not have a mailbox, you must specify the mailbox primary STMP address for any distinguished folder Ids."

## Cause

The Exchange account specified in the Email Server Profile is a service account that doesn't yet have an email address set up for it.

## Resolution

Set up an email address for the Exchange account used in the Email Server Profile. You can access **Email Server Profiles** within the CRM web application by navigating to **Settings**, **Email Configuration**, and then clicking **Email Server Profiles**.
