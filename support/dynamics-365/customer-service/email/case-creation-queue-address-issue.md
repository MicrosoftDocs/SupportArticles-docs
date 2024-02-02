---
title: Case creation fails with Case is missing customer error
description: Provides a workaround for the issue where case creation fails when a mail is sent to same queue address on which the automatic record creation role is configured in Dynamics 365 Customer Service.
ms.reviewer: sdas
ms.author: shchaur
ms.date: 05/23/2023
---
# Case creation fails with "Case is missing" error

This article provides a workaround for the issue where the case creation fails due to mail being sent from a queue address to the same queue address on which an automatic record creation rule is configured in Dynamics 365 Customer Service.

## Symptoms

When configuring an automatic record creation rule for a queue in the web client, in the rule, set the **Customer** field as **{null(Channel Properties)}**. Then, if you try to send mail from sender as queue mail address to recipient as queue mail address, the case creation fails with the following error message:

> Case is missing customer.

## Cause

The automatic record creation rule in the web client considers the queue as a known sender and doesn't create a contact. Subsequently, the case creation fails because no account or contact is associated with the email.

This is an expected behavior.

## Workaround

To work around this issue,

1. Migrate your rules from the web client to Unified Interface. For more information, see [Migrate automatic record creation rules and service-level agreements](/dynamics365/customer-service/migrate-automatic-record-creation-and-sla-agreements).
2. Follow the information in [Configure advanced settings for rules](/dynamics365/customer-service/automatically-create-update-records#configure-advanced-settings-for-rules) to manage emails from unknown senders.
