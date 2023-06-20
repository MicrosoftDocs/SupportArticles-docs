---
title: Troubleshoot common configuration issues with automatic record creation and update rules
description: Provides resolutions for common configuration issues with automatic record creation and update rules in Dynamics 365 Customer Service.
ms.reviewer: sdas
ms.author: shchaur
ms.date: 06/08/2023
---
# Troubleshoot common configuration issues with automatic record creation and update rules

This article provides resolutions for common configuration failure scenarios with automatic record creation and update rules, due to which record creation might fail or get skipped.

## Scenario 1

Sample: Configuration on **Automatic Record Creation and Update Rule**

- The **Create contact for unknown sender** option should be selected.
- Set condition criteria to **Any incoming email**.
- Add action to create a case, select **View properties**, and set the case fields per business use case.

### Error 1 - "The case is missing customer"

In the **Customer** field of the **CASE DETAILS** section, the value of **Senders Account (Email)** is set as shown below.

:::image type="content" source="media/common-email-error-messages/email-case-scenario.png" alt-text="Screenshot that shows how the value of Senders Account (Email) is set in the Customer field.":::

This setting results in the following error in system jobs:

> The case is missing customer.

:::image type="content" source="media/common-email-error-messages/case-missing-customer-error.png" alt-text="Screenshot that shows the details of the error that states the case is missing customer.":::

#### Resolution for Error 1

To resolve this issue, keep the **Customer** field blank or set it to **{Sender(Email)}**. This allows the system to automatically create a contact for the unknown sender and link it to the case.

### Error 2 - "An error has occurred"

The **Customer** field is set as **{Senders Account(Email)}**, and the **Contact** field is set as **{Sender(Email)}**.

:::image type="content" source="media/common-email-error-messages/customer-contact-values.png" alt-text="Screenshot that shows the values set for the Customer and Contact fields.":::

This setting results in the following error in system jobs:

> An error has occurred. Try this action again. If the problem continues, check the Microsoft Dynamics 365 Community for solutions or contact your organization's Microsoft Dynamics 365 Administrator. Finally, you can contact Microsoft Support.

:::image type="content" source="media/common-email-error-messages/error-has-occured.png" alt-text="Screenshot that shows the details of the error that occurs due to the value set for the Customer field.":::

#### Resolution for Error 2

To resolve this issue, keep the **Customer** field blank or set it to **{Sender(Email)}**. This allows the system to automatically create a contact for the unknown sender and link it to the case.

### Error 3 - "The specified contact doesn't belong to the contact that was specified in the customer field."

The **Customer** and **Contact** fields are set as **{Sender(Email)}**.

:::image type="content" source="media/common-email-error-messages/customer-value-set-case-details.png" alt-text="Screenshot that shows the value set for the Customer and Contact fields.":::

This setting results in the following error in system jobs:

> The specified contact doesn't belong to the contact that was specified in the customer field. Remove the value from the contact field, or select a contact associated to the selected customer, and then try again.

:::image type="content" source="media/common-email-error-messages/specified-contact-not-belong-contact-error.png" alt-text="Screenshot that shows the details of the error that states the specified contact doesn't belong to the contact that was specified in the Customer field.":::

#### Resolution for Error 3

To resolve this issue, leave the **Contact** field blank and set the **Customer** field either to blank or to **{Sender(Email)}**.

### Validation steps

You must validate the configuration and validation steps provided in the following table to understand the main cause of the issue and resolve it.

|Option in Automatic Record Creation and Update Rule in Service Management  |If selected as  |Validation steps  |Outcome  |
|---------|---------|---------|---------|
|Create a case if a valid entitlement exists for the customer     |  Yes     |  Validate that an active entitlement exists for the customer. Valid active entitlement is evaluated as below:  </br> - If the sender of the email is a contact with a parent account, then Dynamics 365 Customer Service creates a case if the contact's parent account has a valid entitlement, and the contact is listed in the **Contacts** section of the entitlement </br> Or, </br> - If the **Contacts** section is empty (which means that the entitlement is applicable to all contacts for the customer) |   A case is created.      |
|Create a case from an email sent by unknown senders     |   Yes       |        For any incoming email from an unknown sender |     - A case is created. </br>  - A contact is also created for the unknown sender.|
|     |   Yes      |    For an incoming email with email address of inactive account or contact     |   - A case is created. </br> - An inactive account or contact is activated.|
|     |   No      |     For an incoming email with email address of active account or contact   |  A case is created.       |
|    |     No    |      For an incoming email sent by record type other than account or contact   |    No case is created.     |
|  |   No      |     For an incoming email with email address of inactive account or contact    |  No case is created.           |
|Create a case for activities associated with a resolved case     |    Yes     |   For an incoming email related to a resolved case      |    A case is created.     |
|   |    Yes      |   For an incoming email related to an active case         |   No case is created.      |

## Scenario 2 - Use of {Regarding(Email)} in legacy experience doesn't give the correct data in flow

In legacy "automatic record creation and update rules" items in Customer Service, to look up the entity (either a contact or an account) that sends an email, you can use the **Sender (Email)** polymorphic lookup, which automatically fetches the appropriate entity and displays the entity's name. Polymorphic lookups are lookups where the target of the lookup is more than one kind of entity. For example, it can point to either a contact or an account. However, in modern "automatic record creation and update rules," this automatic display isn't supported, so you need to specify the type of entity you want to retrieve along with the fields to display from that entity.

### Cause

A flow doesn't use the **{Regarding(Email)}** value like a legacy workflow because flow expressions reference a data value from one of the previous flow step's payload. For example, if the **{Regarding(Email)}** value is empty when the flow begins, the value in the trigger step payload for **{Regarding(Email)}** will remain empty. Even if the **{Regarding(Email)}** value gets updated after a case is created, the email record data gets updated, but the payload in flow doesn't. So, when the value from the payload is referenced in the subsequent flow steps, it remains empty.

### Resolution

If the **{Regarding(Email)}** value is used in legacy rule items, you need to manually update the migrated flow to use the "Incident Id" or "OData Id." Use the "OData Id" for fields that require entity reference or lookups. Use the case-unique identifier for fields that require GUID.

## Scenario 3 - Issues with rendering polymorphic lookups on non-lookup fields during migration from legacy to modern "automatic record creation and update rules"

A legacy "automatic record creation and update rules" item using polymorphic lookups, such as **Sender**, results in an invalid lookup when assigned to a text field.

In legacy "automatic record creation and update rules" items in Customer Service, to look up the entity (either a contact or an account) that sent an email, you can use the **Sender (Email)** polymorphic lookup, which automatically fetches the appropriate entity and displays the entity's name. Polymorphic lookups are lookups where the target of the lookup is more than one kind of entity. For example, it can point to either a contact or an account. However, in modern "automatic record creation and update rules," this automatic display isn't supported. So, you need to specify the type of entity you want to retrieve along with the fields to display from that entity.

### Cause

The classic workflow behavior used by legacy "automatic record creation and update rules" has many hidden behaviors. For example, automatically determining the type of entity and fetching a field as the display name if the parameter is used in a string but returning the ID if assigned to a lookup field. The platform migration code that "automatic record creation and update rules" uses when converting from legacy to modern workflows doesn't add the required steps and fields.

### Resolution 

To solve this issue,

- Update the lookup to a specific type.
- Use a different field on the incoming entity that contains the desired text.
