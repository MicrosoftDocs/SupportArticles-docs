---
title: Fix lead qualification errors in Dynamics 365 Sales
description: Resolve common lead qualification errors for salespeople in Dynamics 365 Sales. These errors include duplicate warnings, missing permissions, status code mismatches, and business process flow issues.
ms.reviewer: ramakris, shjais, tapanm, v-shaywood
ms.date: 05/21/2026
ms.custom: sap:Lead
ai-usage: ai-assisted
---

# Troubleshoot lead qualification issues for salespeople

## Summary

This article helps you troubleshoot and resolve lead qualification issues for salespeople in Dynamics 365 Sales. When you [qualify a lead](/dynamics365/sales/qualify-lead-convert-opportunity-sales), you might encounter errors that are related to duplicate records, missing permissions, business process flow stages, or entity mappings. Use the guidance in this article to identify the cause of common lead qualification errors, and apply the right fix.

The following errors or issues can occur when you qualify a lead:

- [Duplicate account or contact match warning](#duplicate-account-or-contact-match-warning)
- [Required fields not filled in the current stage](#required-fields-not-filled-in-the-current-stage)
- [Active stage isn't on the lead entity](#active-stage-isnt-on-the-lead-entity)
- [Lead is already closed](#lead-is-already-closed)
- [Invalid status code for a contact or opportunity](#invalid-status-code-for-a-contact-or-opportunity)
- [Can't proceed to the next stage from the business process flow](#cant-proceed-to-the-next-stage-from-the-business-process-flow)
- [Insufficient permissions when qualifying a lead](#insufficient-permissions-when-qualifying-a-lead)

## Duplicate account or contact match warning

When you try to qualify a lead, you receive the following warning message:

> There might already be a match for this account or contact. If so, please select it.

:::image type="content" source="media/troubleshoot-lead-qualification-issues-for-salespeople/duplicate-warning.png" alt-text="Duplicate warning that occurs when you qualify a lead." border="false":::

When you qualify a lead to an opportunity, the process also creates a corresponding account or contact. The warning appears if a matching account or contact record might already exist.

To resolve this issue, take either of the following actions in the **Duplicate warning** dialog box:

- To avoid creating duplicates, select the existing account or contact.
- To create a new record instead, select **Continue**.

> [!NOTE]
> When you qualify a lead through the Leads grid, the system creates an account or contact, even if a duplicate record exists. This action occurs because the [duplicate detection rule](/power-platform/admin/set-up-duplicate-detection-rules-keep-data-clean) is disabled by design in that flow. But when you qualify a lead through the lead record form, the duplicate detection rule runs and prompts you with a warning to resolve the conflict if it finds any duplicate account or contact records.

## Required fields not filled in the current stage

You receive the following message when you try to qualify a lead:

> To move to the next stage complete the required steps.

This issue occurs if one or more business-required fields in the current stage of the [business process flow](/power-automate/business-process-flows-overview) aren't filled in.

To resolve this issue, fill in all the required fields in the current stage, save the record, and then try again to qualify the lead.

## Active stage isn't on the lead entity

When you try to qualify a lead, you receive the following error message:

> Active stage is not on lead entity.

This issue occurs if the lead that you're trying to qualify isn't in the Active state. This situation can occur if an already qualified lead is reactivated.

To resolve this issue:

1. Open the lead record.
1. On the process stage, select the **Set Active** button.

    :::image type="content" source="media/troubleshoot-lead-qualification-issues-for-salespeople/set-active-button-qualify-stage.png" alt-text="The Set Active button in the Qualify stage of lead form." border="false":::

## Lead is already closed

When you try to qualify a lead, you receive the following error message:

> The lead is closed and you can't convert or qualify a lead that is already closed.

To resolve this issue, make sure that the lead that you're trying to qualify or disqualify is open and isn't already qualified or disqualified. To check, select the **My Open Leads** or **Open Leads** view.

## Invalid status code for a contact or opportunity

When you try to qualify a lead, you receive the following error message:

> Invalid status code error for a contact or an opportunity.

When you qualify a lead, some attributes in the [one-to-many relationship](/power-apps/maker/data-platform/create-edit-1n-relationships) mappings between **Lead to Contact** or **Lead to Opportunity** are copied from the Lead entity to the Contact or Opportunity entity.

Status codes are defined as an [option set](/power-apps/maker/data-platform/types-of-fields). This issue occurs when a user adds a new option to the option set on the Lead entity but not to the option set on the target entity.

In order for [entity mapping](/power-apps/maker/data-platform/map-entity-fields) to work, option sets such as status codes must match between Lead and Contact, or between Lead and Opportunity. This requirement exists because the lead qualification process copies the status code value from the Lead entity to the target entity. If the status codes don't match, the process fails.

To resolve this issue, make sure that the status codes on the Lead entity and the target entity are the same.

### View status codes for the Lead entity and target entity

1. In the Sales Hub app, go to **Settings** > **Customizations** > **Customize the System**.
1. Expand the Lead entity node, and select **Fields**.
1. Find the **statuscode** field, and open it.
1. Open a status to see its value.

    :::image type="content" source="media/troubleshoot-lead-qualification-issues-for-salespeople/lead-status-code.png" alt-text="See the status code of the Lead entity." border="false":::

1. Repeat steps 2 through 4 to see the status code for the target entity, such as Contact.

    :::image type="content" source="media/troubleshoot-lead-qualification-issues-for-salespeople/contact-status-code.png" alt-text="See the status code of the Contact entity." border="false":::

### View entity mappings

1. In the Sales Hub app, go to **Settings** > **Customizations** > **Customize the System**.
1. Expand the Lead entity node, and select **1:N Relationships**.
1. Open the relationship that you need, and select **Mappings** in the left pane.
1. Scroll to see the mapping.

    :::image type="content" source="media/troubleshoot-lead-qualification-issues-for-salespeople/entity-mapping.png" alt-text="Select Mappings to see entity mapping.":::

1. If you don't see the mapping that you need, select **New** to create it.

> [!NOTE]
>
> - If you still receive the error message, remove the status code mapping between the Lead entity and the target entity (Account, Contact, or Opportunity).
> - To add new status codes that have the same values, import the new option set values through a [managed solution](/power-platform/alm/solution-concepts-alm#managed-and-unmanaged-solutions) for the Contact or Opportunity entity.

## Can't proceed to the next stage from the business process flow

When you select **Next Stage** on the business process flow for a lead, the stage doesn't advance.

This behavior is by design. Until you qualify the record, no Opportunity is associated with it. Therefore, you can't move to the next stage in the lead-to-opportunity sales process.

To resolve this issue, qualify the lead. Qualifying the lead creates the Opportunity and automatically moves the record to the next stage.

## Insufficient permissions when qualifying a lead

When you try to qualify a lead, you receive an Insufficient permissions or Access denied error.

This issue occurs if the user's [security role](/dynamics365/sales/security-roles-for-sales) is missing one or more privileges that are required on the Account, Lead, Contact, or Opportunity entities (and related customization entities) that are accessed during lead qualification.

### Assign the required privileges to the security role

> [!NOTE]
> If you're a salesperson, ask your system administrator to grant the required permissions described in this section.

How you resolve this error depends on who owns the lead. The steps are the same in each ownership scenario, but you assign permissions at a different access level:

| Ownership scenario                               | Access level  |
| ------------------------------------------------ | ------------- |
| The user owns the lead they're trying to qualify | User          |
| Lead is in the user's business unit              | Business Unit |
| Lead is in the user's organization               | Organization  |

1. Go to **Settings** > **Security Role**.
1. Open the security role of the user.
1. On the **Core Records** tab, assign **Create**, **Read**, **Append**, and **Append To** permissions to the security role at the access level for your ownership scenario on the following entities:

    - Account
    - Lead
    - Contact
    - Opportunity

1. On the **Custom Entities** tab, assign **Read** access to any custom entity.
1. On the **Customizations** tab, assign **Read** access to **Attribute Map**, **Customizations**, **Entity**, and **Entity Map**.

The following screenshots show the **Core Records** settings at each access level.

- User level:

    :::image type="content" source="media/troubleshoot-lead-qualification-issues-for-salespeople/security-role-sales-person.png" alt-text="Security role with access at User level.":::

- Business Unit level:

    :::image type="content" source="media/troubleshoot-lead-qualification-issues-for-salespeople/security-role-sales-person-business-unit-access.png" alt-text="Security role with access at Business Unit level.":::

- Organization level:

    :::image type="content" source="media/troubleshoot-lead-qualification-issues-for-salespeople/security-role-sales-person-org-access.png" alt-text="Security role with access at Organization level.":::

### Troubleshoot privilege errors that persist after assigning permissions

If the user still encounters privilege-related errors after you assign privileges (as listed in this section), they might be missing privileges on other entities that are accessed when the Account, Contact, or Opportunity records are created. For example, the user might be missing privileges on custom entities that are accessed when [plug-ins](/power-apps/developer/data-platform/plug-ins) or [workflows](/power-automate/workflow-processes) run on the Account, Contact, or Opportunity entities.

To troubleshoot further, follow these steps:

1. **Isolate the issue to creation of an Opportunity, Account, or Contact record:** Ask the user to create individual Account, Contact, and Opportunity records, and check whether they receive the same privilege error. They might have privilege issues on more than one record type. Therefore, you should test each one.

1. **Identify whether a plug-in or workflow registered on entity creation is causing the issue:** After you isolate the issue to creation of a specific entity record, check whether any plug-in or workflow that runs on creation of that record accesses other entities that the current user is missing privileges on. List all plug-ins and workflows that are registered upon creation of the entity record. Then, deactivate them one by one to find the one that causes the issue. Leave it deactivated to unblock record creation.

   For more information about how to identify workflows that are registered for an entity, see [Deactivate custom workflow process](troubleshoot-multiple-tables-issues.md#deactivate-a-custom-workflow-process).

   For more information about how to identify plug-ins that are registered upon creation of an entity record, see [Deactivate custom plug-in](troubleshoot-multiple-tables-issues.md#deactivate-a-custom-plug-in).

## Related content

- [Troubleshoot issues with lead qualification for system admins](troubleshoot-lead-qualification-issues-for-system-admin.md)
- [Troubleshoot issues with automatic creation of contact or company-related fields](troubleshoot-lead-form-auto-generated-contact-company-fields.md)
- [Troubleshoot issues with an opportunity](troubleshoot-opportunities-issues.md)
