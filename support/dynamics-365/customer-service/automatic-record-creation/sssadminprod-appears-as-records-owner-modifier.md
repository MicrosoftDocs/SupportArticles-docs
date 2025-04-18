---
title: SSSAdminProd Appears as Owner or Modifier of Records
description: Explains why "# SSSAdminProd" appears as the owner or Modified By user of records in Microsoft Dynamics 365 Customer Service.
ms.reviewer: ghoshsoham
author: Yerragovula
ms.author: srreddy
ai-usage: ai-assisted
ms.date: 04/18/2025
ms.custom: sap:Automatic Record Creation (ARC), DFM
---
# Record owner unexpectedly set to "# SSSAdminProd"

This article explains why the "# SSSAdminProd" system account may appear as the **Owner** or **Modified By** user of records in Dynamics 365 Customer Service, and steps to change the ownership.

## Symptoms

You might encounter the following behavior in Dynamics 365 Customer Service:

- The "# SSSAdminProd" system account is listed as the user who modifies cases in queues.
- The "# SSSAdminProd" system account is assigned as the owner of newly created records, such as cases or contacts.

As a result, some users can't view records created or modified by the "# SSSAdminProd" account.

## Cause

The "# SSSAdminProd" account appears as the user who modifies cases or owns newly created records, which is typically linked to the use of an Automatic Record Creation (ARC) rule.

The ARC rule or Power Automate flow might be configured to run in the context of a specific user account, usually a [system-provided application user](/power-platform/admin/system-application-users#application-users), such as "# SSSAdminProd."

For example, when a case record is created through an ARC rule and the rule owner is a team, the owner of the case record is the team's administrator user. In this case, "# SSSAdminProd" might be the administrator user for the team that owns the rule. If "# SSSAdminProd" is the owner of the ARC rule or associated flow, the account appears as the user performing actions such as:

- Creating new contact records when unknown senders send emails.
- Creating cases as part of the email-to-case process.

## Resolution

To resolve the issue, reassign the ownership of the ARC rule to an appropriate user or service account with the required privileges. Follow these steps:

1. Go to **Customer Service admin center** > **Case Settings** > **Automatic Record Creation and Update rules**.
2. Identify the ARC rule causing the issue and reassign its owner to a user or service account with the required privileges.
3. Save the changes and publish the rule.

For more information, see:

- [Special system users and application users](/power-platform/admin/system-application-users)
- [Set up rules to automatically create or update records](/dynamics365/customer-service/administer/automatically-create-update-records)
- [View the details of system-provided application users](/power-platform/admin/manage-application-users#view-the-details-of-system-provided-application-users)
