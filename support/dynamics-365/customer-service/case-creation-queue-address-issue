---
title: Case creation fails when mail is sent to same queue address on which automatic record creation role is configured
description: Provides solution to an issue where case creation fails when mail is sent to same queue address on which automatic record creation role is configured in Dynamics 365 Customer Service.
ms.reviewer: 
ms.topic: troubleshooting
ms.date: 04/11/2023
ms.subservice: d365-customer-service
---

# Case creation fails when mail is sent from queue address to same queue address on which automatic record creation rule is configured

## Symptom

When configuring an automatic record creation rule for a queue in the web client, in the rule, set the customer value as null (Channel properties). Then, if you try to send mail from sender as queue mail address to recipient as queue mail address, the case creation fails with the following error message: "Case is missing customer".

## Cause

The automatic record creation rule in the web client considers the queue as a known sender and doesn't create a contact. Subsequently, the case creation fails because no account or contact is associated with the email.

This is an expected behavior.

## Resolution

Perform the following steps as a workaround:

1. Migrate your rule from the web client to Unified Interface. More information: [Migrate automatic record creation rules and service-level agreements](/dynamics365/customer-service/migrate-automatic-record-creation-and-sla-agreements).
2. Follow the information in [Configure advanced settings for rules](/dynamics365/customer-service/automatically-create-update-records) to manage emails from unknown senders.
