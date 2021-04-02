---
title: Power Automate Approval Email information
description: Describes the information about Power Automate approval emails.
ms.reviewer: 
ms.topic: article
ms.date: 
---
# Power Automate Approval Email delivery information

This article describes the information about Power Automate approval emails.

_Applies to:_ &nbsp; Power Automate  
_Original KB number:_ &nbsp; 4559558

## Overview

Approval emails are sent from outside of the organization boundary and routed to the email domain of the specified recipient. Which is to ensure that all organizational policies for inbound mail are respected.

For customers whose MX record points at another filtering service (for instance, Proofpoint or Mimecast), messages will be routed to those services first per MX routing priorities, and not directly to Office 365 or on-premises mailboxes.

## Commercial

For commercial Power Automate (all geos), Approval mails may come from any IP within the following ranges:

- 65.55.52.224/27
- 207.46.200.0/27
- 65.55.234.192/26
- 94.245.112.0/27
- 207.46.50.192/26

All approval emails will be sent with a sender address of `maccount@microsoft.com.`

## GCC (Government)

For GCC and GCC High Power Automate, Approval mails may come from any of the following IPs:

- 131.253.121.20
- 131.253.121.52

Approval emails will be sent in these environments with a sender address of `flow-noreply@microsoft.com`

## China

Approval mails may come from any of the following IPs:

- 103.9.8.121
- 103.9.8.122
- 103.9.8.123
- 42.159.163.81
- 42.159.163.82
- 42.159.163.83

All approval emails will be sent with a sender address of `maccount@microsoft.com`.
