---
title: Troubleshoot Issues with SLA Migration in Dynamics 365 Customer Service
description: Provides resolutions for issues that prevent you from migrating SLAs to Unified Interface in Microsoft Dynamics 365 Customer Service.
ms.reviewer: sdas
ms.author: ghoshsoham
author: soham-msft
ms.date: 04/22/2025
ms.custom: sap:Service Level Agreements\Facing errors during SLA migration
---
# Troubleshoot issues with SLA migration to Unified Interface

This article describes different scenarios in which a service-level agreement (SLA) might not be successfully [migrated to Unified Interface](/dynamics365/customer-service/migrate-automatic-record-creation-and-sla-agreements#migrate-automatic-record-creation-rules-and-service-level-agreements), and provides steps to resolve these issues.

## Scenario 1: Error 404 during SLA migration

When running the SLA migration tool, you receive a 404 error with the "Resource not found for segment mdyn_MigrateSla" message.

#### Cause

This issue occurs because the custom action for migration isn't activated.

#### Resolution

Ensure that the `MigrateSla` workflow process is activated.

## Scenario 2: SLA migration completes, but the SLA warning email doesn't display the correct values

#### Symptoms

This issue occurs after you migrate the SLA item using the "Send Email" template. Here are the steps to reproduce the issue:

1. Create the legacy SLA and SLA item.
2. Select **Set Properties** next to **Send Email** on the SLA item form.
3. In the **Description** field, add the "Send Email" template.

   :::image type="content" source="media/sla-migration-issues/email-template.png" alt-text="Screenshot that shows a 'Send Email' template.":::

4. Save the SLA item, and migrate it to Unified Interface.
5. Activate the SLA, and set it as default.
6. Create and save the case. Make sure that the SLA is applied. Wait for the SLA status to change to **Nearing non-compliance**, and then resolve the case.

You should receive a warning email after a few minutes. You might find that the details of the warning email show the dynamic expression instead of the actual value.

#### Resolution

Manually update the dynamic expression to the `FormattedValue` option field.

1. In the Customer Service admin center, go to **Service level agreements** under **Service Terms**.
2. Select and expand the migrated SLA from the grid.
3. Select **SLA item** from the **SLA Items** grid and expand it. A Power Automate flow opens.
4. Expand each step until the email template's message appears.
5. Update the dynamic expression to the `FormattedValue` option field.

   :::image type="content" source="media/sla-migration-issues/format-legacy-sla-option-field.png" alt-text="Screenshot that shows the format of the legacy SLA option field." lightbox="media/sla-migration-issues/format-legacy-sla-option-field.png":::

6. Select **Save**.

## Scenario 3: Status value is displayed instead of text in an email after the legacy SLA is migrated to Unified Interface

The "Assign Case" action isn't migrated correctly. After the legacy SLA is migrated to Unified Interface, the email displays the value of **Status** (status code "5") instead of the expected text ("Resolved").

#### Cause

This issue occurs if the SLA migration code uses the **Status** field instead of the **Formatted** field.

#### Resolution

To solve this issue, take the following steps:

1. In the Customer Service admin center, go to **Service level agreements** under **Service Terms**.
2. Select and expand the migrated SLA from the grid.
3. Select the SLA item from the **SLA Items** grid and expand it. A Power Automate flow opens.
4. Expand each step until you reach the **Is Succeeded** step.
5. Go to the **Description** field. The **Dynamic content** window opens.
6. Search for and select the required entity.
7. Select **Save**.

> [!NOTE]
> This issue also occurs with other data types, such as **Option Set** and **Two Options**. Use a formatted entity for these data types as well.

The following screenshot shows an example of an SLA migration flow.

:::image type="content" source="media/sla-migration-issues/sla-migration-flow.png" alt-text="Screenshot that shows an SLA migration flow.":::

The following screenshot shows an email template that shows the expected text of **Status**.

:::image type="content" source="media/sla-migration-issues/sla-migration-email.png" alt-text="Screenshot of an email template that shows the text of Status during SLA migration.":::

## Scenario 4: Email "Subject" field is empty when the "Send Email with template" action is triggered

#### Cause

This issue occurs when a subject like "Hello,{Case Number(Case);Case Title(Case)}" is added in an email template, or when extra braces are added to the subject expression in the migration function.

#### Resolution

To solve this issue, take the following steps:

1. In the Customer Service admin center, go to **Service level agreements** under **Service Terms**.
2. Select and expand the migrated SLA from the grid.
3. Select the SLA item from the **SLA Items** grid and expand it. A Power Automate flow opens.
4. Expand each step until you reach the **Is Succeeded** step.
5. Go to the **Subject** field. The **Dynamic content** window opens.
6. Search for and select the required entity.
7. Select **Save**.

The following screenshot shows an email template that contains a subject like "Hello,{Case Number(Case);Case Title(Case)}" in an SLA flow.

:::image type="content" source="media/sla-migration-issues/sla-flow-email-subject.png" alt-text="Screenshot that shows an email template in an SLA flow.":::

The following screenshot shows an email template that contains a subject.

:::image type="content" source="media/sla-migration-issues/sla-email-template-subject.png" alt-text="Screenshot that shows an email template with a subject.":::

## Scenario 5: SLA migration fails with "VisitSetStateStep: There doesn't exist a valid state code for the status code value 100000000"

#### Cause

This issue occurs if the status code of the target entity that is used in an SLA item action is deleted, which might happen during customization.

#### Resolution

Use the "Change record status to" SLA item action to set a valid status value.

## Scenario 6: SLA migration fails with "A process operation associated with this process is not activated"

#### Cause

This issue occurs if you have disabled the `msdyn_ConditionXmlConversion` custom action for condition control.

#### Resolution

To enable the `msdyn_ConditionXmlConversion` custom action for the condition control conversion, follow these steps:

1. Go to **Settings** > **Processes**.
2. Make sure the **Convert legacy xml to fetchxml format and vice versa** process with the unique name `msdyn_ConditionXmlConversion` is in the **Activated** status.

:::image type="content" source="media/sla-migration-issues/convert-legacy-xml-to-fetchxml-format-and-vice-versa.png" alt-text="Screenshot that shows the Convert legacy xml to fetchxml format and vice versa process in the Activated status." lightbox="media/sla-migration-issues/convert-legacy-xml-to-fetchxml-format-and-vice-versa.png":::

:::image type="content" source="media/sla-migration-issues/msdyn-condition-xml-conversion.png" alt-text="Screenshot that shows the unique name of the Convert legacy xml to fetchxml format and vice versa process." lightbox="media/sla-migration-issues/msdyn-condition-xml-conversion.png":::

## Scenario 7: SLA migration is stuck

When you migrate SLAs in Dynamics 365 Customer Service, you might experience the following issues:

- SLA items fail to reflect correctly after migration.
- The SLA timer grid doesn't display the timer as expected.
- Some SLA items appear to be stuck or incomplete in the migration process.

#### Cause

These issues might occur due to one or more of the following reasons:

- Some SLA items might not have been migrated successfully and might be stuck in the migration process.
- Certain conditions configured within the SLA items aren't supported, causing them to malfunction.

#### Resolution

Follow these steps to troubleshoot and resolve the SLA migration issues:

1. Navigate to **Settings** > **Service Management** > **SLAs** to review the list of migrated SLAs.

2. Verify that all SLA items have been migrated successfully:

    - Check if any SLA items are stuck in the migration process.
    - If certain SLA items are stuck, try to publish or reactivate them manually.

3. Review the criteria configured in the SLA items and ensure the following:

    - All conditions are compatible with the Unified Client Interface (UCI).
    - Deprecated triggers or actions are removed or replaced.
    - The "Applicable When" and "Success Conditions" criteria are configured correctly.

4. If the issue persists, create a simple SLA item for testing purposes:

   - Define straightforward criteria, such as "Case Priority = High."
   - Verify if the SLA timer displays correctly for the test case.

5. If the simple SLA item works as expected, incrementally increase the complexity of the SLA to identify any incompatible conditions.

6. After making the necessary adjustments, test the SLAs in a sandbox environment. Confirm that the SLA timer grid displays correctly and functions as expected.
