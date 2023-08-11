---
title: Troubleshoot issues with SLA migration in Dynamics 365 Customer Service
description: Provides a resolution for an issue where you can't migrate SLAs to Unified Interface in Microsoft Dynamics 365 Customer Service.
ms.reviewer: sdas
ms.author: ankugupta
ms.date: 08/11/2023
---
# Troubleshoot issues with SLA migration to Unified Interface

This article describes different scenarios in which a service-level agreement (SLA) might not be successfully [migrated to Unified Interface](/dynamics365/customer-service/migrate-automatic-record-creation-and-sla-agreements#migrate-automatic-record-creation-rules-and-service-level-agreements), and provides steps to resolve these issues.

## Scenario 1: Error 404 occurs during SLA migration

When running the SLA migration tool, you receive a 404 error with the "Resource not found for segment mdyn_MigrateSla" message.

#### Cause

This issue occurs because the custom action for migration isn't activated.

#### Resolution

Ensure that the `MigrateSla` workflow process is activated.

## Scenario 2: SLA migration completes, but SLA warning emails aren't correct

#### Symptoms

This issue occurs after you migrate the SLA item using the "Send Email" template. Here are the repro steps:

1. Create the legacy SLA and SLA item.
2. Select **set properties** next to **send email** on the SLA item form.
3. In the **Description** field, add the "Send Email" template.

   :::image type="content" source="media/sla-migration-issues/email-template.png" alt-text="Screenshot that shows a 'Send Email' template.":::

4. Save the SLA item, and migrate it to Unified Interface.
5. Activate the SLA, and set it as default.
6. Create and save the case. Make sure that the SLA is applied. Wait for the SLA status to change to **Nearing non-compliance**, and then resolve the case.

You should receive the email after a few minutes.

#### Resolution

Manually update the dynamic expression to the `FormattedValue` option field.

1. In Customer Service admin center, go to **Service level agreements** under **Service Terms**.
2. Select and expand **migrated SLA from grid**.
3. Select **SLA item** from the **SLA Items** grid and expand it. A Power Automate flow opens.
4. Expand each step until the email template's message.
5. Update the dynamic expression to the `FormattedValue` option field.

   :::image type="content" source="media/sla-migration-issues/format-legacy-sla-option-field.png" alt-text="Screenshot that shows the format of the legacy SLA option field.":::

6. Select **Save**.

## Scenario 3: Status value is displayed instead of text in an email after the legacy SLA is migrated to Unified Interface

The "Assign Case" action isn't migrated correctly. In an external flow, the value of **Status** is displayed instead of the text in an email after the legacy SLA is migrated to Unified Interface.

#### Cause

This issue occurs if the SLA migration code uses the **Status** field instead of the **Formatted** field.

#### Resolution

To solve this issue, take the following steps:

1. In Customer Service admin center, go to **Service level agreements** under **Service Terms**.
2. Select and expand **migrated SLA from grid**.
3. Select **SLA item** from the **SLA Items** grid and expand it. A Power Automate flow opens.
4. Expand each step until the **Is Succeeded** step.
5. Go to the **Description** field. The **Dynamic content** window opens.
6. Search for and select the required entity.
7. Select **Save**.

> [!NOTE]
> This issue also occurs with other datatypes like **Option Set** and **Two Options**. Use a formatted entity with these datatypes as well.

The following screenshot shows an example of an SLA migration flow.

:::image type="content" source="media/sla-migration-issues/sla-migration-flow.png" alt-text="Screenshot that shows an SLA migration flow.":::

The following screenshot shows an email template that shows the value of **Status**.

:::image type="content" source="media/sla-migration-issues/sla-migration-email.png" alt-text="An email template that shows the value of Status during SLA migration.":::

## Scenario 4: Email "subject" field is empty when the "Send Email with template" action is triggered

#### Cause

This issue occurs when a subject like "Hello,{Case Number(Case);Case Title(Case)}" is added in an email template, or when extra braces are added to the subject expression in the migration function.

#### Resolution

To solve this issue, take the following steps:

1. In Customer Service admin center, go to **Service level agreements** under **Service Terms**.
2. Select and expand **migrated SLA from grid**.
3. Select **SLA item** from the **SLA Items** grid and expand it. A Power Automate flow opens.
4. Expand each step until the **Is Succeeded** step.
5. Go to the **Subject** field. The **Dynamic content** window opens.
6. Search for and select the required entity.
7. Select **Save**.

The following screenshot shows an email template that contains a subject like "Hello,{Case Number(Case);Case Title(Case)}" in an SLA flow.

:::image type="content" source="media/sla-migration-issues/sla-flow-email-subject.png" alt-text="Screenshot that shows an email template in an SLA flow.":::

The following screenshot shows an email template that contains a subject.

:::image type="content" source="media/sla-migration-issues/sla-email-template-subject.png" alt-text="Screenshot that shows an email template with a subject.":::

## Scenario 5: SLA migration fails with "VisitSetStateStep: There doesn't exist a valid state code for the status code value 100000000"

#### Cause

This issue occurs if you have deleted the status code of the target entity in customization, which is used in an SLA item action.

#### Resolution

Fix the "Change record status to" SLA item action by setting an existing status value.

> [!NOTE]
> The `StatusCode` value used in an SLA item might be deleted during customization.

## Scenario 6: SLA migration fails with "A process operation associated with this process is not activated"

#### Cause

This issue occurs if you have disabled the custom action for condition control.

#### Resolution

Enable the `msdyn_ConditionXmlConversion` custom action for the condition control conversion.

1. Go to **Settings** > **Processes**.
2. Activate the **Convert legacy xml to fetchxml format and vice versa** process.
