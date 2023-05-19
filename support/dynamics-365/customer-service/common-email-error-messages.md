---
title: Troubleshoot common email error messages
description: Provides resolutions for common email error messages in Dynamics 365 Customer Service.
ms.reviewer: sdas
ms.author: shchaur
ms.date: 04/11/2023
---
# Troubleshoot common email error messages

This article provides resolutions for common email error messages in Dynamics 365 Customer Service.

## Scenario

Sample: Configuration on **Automatic Record Creation and Update Rule**

- The **Create contact for unknown sender** option should be selected.
- Set condition criteria to **Any incoming email**.
- Add action to create a case, select **View properties**, and set the case fields per business use case.

## Error 1

In the **Customer** field of the **CASE DETAILS** section, the value of **Senders Account (Email)** is set as shown below.

:::image type="content" source="media/common-email-error-messages/email-case-scenario.png" alt-text="Screenshot that shows how the value of Senders Account (Email) is set in the Customer field.":::

This setting results in the following error in system jobs:

:::image type="content" source="media/common-email-error-messages/case-missing-customer-error.png" alt-text="Screenshot that shows the details of the error that states the case is missing customer.":::

## Resolution for Error 1

To resolve this issue, keep the **Customer** field blank or set it to **{Sender(Email)}**. This allows the system to automatically create a contact for the unknown sender and link it to the case.

## Error 2

The **Customer** field is set as **{Senders Account(Email)}**, and the **Contact** field is set as **{Sender(Email)}**.

:::image type="content" source="media/common-email-error-messages/customer-contact-values.png" alt-text="Screenshot that shows the values set for the Customer and Contact fields.":::

This setting results in the following error in system jobs:

:::image type="content" source="media/common-email-error-messages/error-has-occured.png" alt-text="Screenshot that shows the details of the error that occurs due to the value set for the Customer field.":::

## Resolution for Error 2

To resolve this issue, keep the **Customer** field blank or set it to **{Sender(Email)}**. This allows the system to automatically create a contact for the unknown sender and link it to the case.

## Error 3

The **Customer** and **Contact** fields are set as **{Sender(Email)}**.

:::image type="content" source="media/common-email-error-messages/customer-value-set-case-details.png" alt-text="Screenshot that shows the value set for the Customer and Contact fields.":::

This setting results in the following error in system jobs:

:::image type="content" source="media/common-email-error-messages/specified-contact-not-belong-contact-error.png" alt-text="Screenshot that shows the details of the error that states the specified contact doesn't belong to the contact that was specified in the Customer field.":::

## Resolution for Error 3

To resolve this issue, leave the **Contact** field blank and set the **Customer** field either to blank or to **{Sender(Email)}**.

## Validation steps

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
