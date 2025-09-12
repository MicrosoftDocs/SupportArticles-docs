---
title: Troubleshoot issues with lead qualification for salespeople
description: Provides resolutions for the lead qualification issues for salespeople in Dynamics 365 Sales.
author: sbmjais
ms.author: shjais
ms.topic: troubleshooting
ms.date: 04/17/2025
ms.custom: sap:Lead
---

# Troubleshoot issues with lead qualification issues for salespeople

This article helps you troubleshoot and resolve lead qualification issues for salespeople.

## How do I convert or qualify my leads?

You qualify a lead when you determine that the lead you've nurtured has a potential to turn into business. When you qualify a lead, it becomes an opportunity.

To qualify a lead, select **Qualify** on the command bar of the lead record.

:::image type="content" source="media/troubleshoot-lead-qualification-issues-for-salespeople/qualify-button-lead-form.png" alt-text="Select the Qualify button on the Lead form." border="false":::

You can also qualify a lead from the list of leads. Go to **Sales** > **Leads**. Select the lead you want to qualify and on the command bar, select **Qualify**.

## Issue: Can't qualify a lead

There are multiple errors or issues that occur when you qualify a lead:

1. [Error 1 - There might already be a match for this account or contact](#error-1---there-might-already-be-a-match-for-this-account-or-contact)
2. [Error 2 - To move to the next stage complete the required steps](#error-2---to-move-to-the-next-stage-complete-the-required-steps)
3. [Error 3 - Active stage is not on lead entity](#error-3---active-stage-is-not-on-lead-entity)
4. [Error 4 - Access denied or Insufficient permissions](#error-4---access-denied-or-insufficient-permissions)
5. [Error 5 - The lead is closed and you cannot convert or qualify a lead that is already closed](#error-5---the-lead-is-closed-and-you-cannot-convert-or-qualify-a-lead-that-is-already-closed)
6. [Error 6 - Invalid status code error for a contact or an opportunity](#error-6---invalid-status-code-error-for-a-contact-or-an-opportunity)
7. [Issue: Can't proceed to the next stage when you select Next stage on the business process flow](#issue-cannot-proceed-to-the-next-stage-when-you-select-next-stage-on-the-business-process-flow)

The following sections describe each of these errors and how you can resolve them.

### Error 1 - There might already be a match for this account or contact

You may receive the following error message when you try to qualify a lead:

> There might already be a match for this account or contact. If so, please select it.

:::image type="content" source="media/troubleshoot-lead-qualification-issues-for-salespeople/duplicate-warning.png" alt-text="Duplicate warning that occurs when you qualify a lead." border="false":::

#### Cause

When the lead is qualified to an opportunity, a corresponding account or contact is created. There might already be a match for this account or contact.

#### Resolution

In the **Duplicate warning** dialog box, select the existing account or contact to avoid creating duplicates. To create a new record instead, select **Continue**.

> [!NOTE]
> When you qualify a lead through the Leads grid, the system creates an account or contact even though a duplicate record exists. By design, the rule that detects the duplicate records gets disabled. However, when you qualify a lead through the lead record form, the duplicate detection rule works. The rule prompts you with a warning to resolve the conflict if any duplicate records for account or contact are found.

### Error 2 - To move to the next stage complete the required steps

#### Cause

You haven't filled in data in all the business-required fields in the current stage of the process stage.

#### Resolution

Fill in data in all the mandatory fields in the current stage, save the record, and then try qualifying the lead again.

### Error 3 - Active stage is not on lead entity

#### Cause

The lead that you're trying to qualify isn't in the Active state. This might happen when an already qualified lead has been reactivated.

#### Resolution

1. Open the lead record.
2. On the process stage, select the **Set Active** button.

    :::image type="content" source="media/troubleshoot-lead-qualification-issues-for-salespeople/set-active-button-qualify-stage.png" alt-text="The Set Active button in the Qualify stage of lead form." border="false":::

### Error 4 - Access denied or Insufficient permissions

#### Cause

You don't have sufficient permissions on the lead record.

#### Resolution

Ask your system administrator to grant you the necessary permissions.

If there's no error, and you're still not able to qualify a lead, contact the technical support.

### Error 5 - The lead is closed and you cannot convert or qualify a lead that is already closed

#### Cause

You're trying to qualify or disqualify a lead that's closed.

#### Resolution

Make sure the lead that you're trying to qualify or disqualify is open and not already qualified or disqualified. You can do this by selecting the My Open leads or Open Leads view.

### Error 6 - Invalid status code error for a contact or an opportunity

#### Cause

When you qualify a lead, some of the attributes in the mapping of 1:N (one-to-many) relationships between **Lead to Contact** or **Lead to Opportunity** are copied from the Lead to Contact or Lead to Opportunity entities.

Status codes are defined as an option set. This issue occurs when a user adds a new option to the option set in the Lead entity, but not to the option set in the target entity.

For entity mapping to work, option sets, such as status codes, should be the same between lead and contact or lead and opportunity, because the lead qualification process copies the status code value from lead to contact or from lead to opportunity. If the status codes don't match, the process fails.

#### Resolution

Ensure that the status codes of Lead and Contact entities, or Lead and Opportunity entities, are the same.

##### To see the status codes of the Lead entity and the target entity

1. In the Sales Hub app, go to **Settings** > **Customizations** > **Customize the System**.
2. Expand the Lead entity node, and select **Fields**.
3. Find the **statuscode** field, and double-click to open it.
4. Double-click a status to see its value.

    :::image type="content" source="media/troubleshoot-lead-qualification-issues-for-salespeople/lead-status-code.png" alt-text="See the status code of the Lead entity." border="false":::

5. Repeat steps 2 through 4 to see the status code for the target entity (for example, Contact).

    :::image type="content" source="media/troubleshoot-lead-qualification-issues-for-salespeople/contact-status-code.png" alt-text="See the status code of the Contact entity." border="false":::

##### To see mappings

1. In the Sales Hub app, go to **Settings** > **Customizations** > **Customize the System**.
2. Expand the Lead entity node, and select **1:N Relationships**.
3. Open the required relationship, and select **Mappings** in the left pane.
4. Scroll to see the mapping.

    :::image type="content" source="media/troubleshoot-lead-qualification-issues-for-salespeople/entity-mapping.png" alt-text="Select Mappings to see entity mapping.":::

5. If you don't see the required mapping, select **New** to create it.

> [!NOTE]
>
> - If you're still getting the error, remove the mapping of the status code between the Lead entity and the target entity (Account, Contact, or Opportunity).
> - To add new status codes that have the same values, import the new option set values through a managed solution for the Contact or Opportunity entity.

### Issue: Cannot proceed to the next stage when you select Next stage on the business process flow

#### Cause

This is by design. When you haven't qualified the record, there will be no opportunity associated with it and you can't proceed to next stage (lead to opportunity sales process).

#### Resolution

To resolve this issue, you must qualify the lead. Qualifying the lead automatically moves the lead to next stage (creating an opportunity).
