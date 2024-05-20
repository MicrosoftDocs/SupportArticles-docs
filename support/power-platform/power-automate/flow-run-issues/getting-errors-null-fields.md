---
title: Getting errors with null fields
description: Provides a solution to an error that occurs when you create a flow in Microsoft Power Automate.
ms.reviewer: 
ms.date: 03/31/2021
ms.custom: sap:Flow run issues\Actions
---
# Getting errors with null fields

This article provides a solution to an error that occurs when you create a flow in Microsoft Power Automate.

_Applies to:_ &nbsp; Power Automate  
_Original KB number:_ &nbsp; 4535432

## Symptoms

In Microsoft Power Automate, when you create a flow, here's what could happen with null field that cause trouble:

1. You might be expecting wrong behavior when doing an action with null field.
2. If you aren't handling null fields correctly, you might be expecting runtime errors like:

   - > **InvalidTemplate**. Unable to process template language expressions. The provided value is of type 'Null'.

   :::image type="content" source="media/getting-errors-null-fields/invaild-template-error.png" alt-text="Screenshot of the invalid template runtime error." border="false":::

## Cause

- If a flow runs with a null field, it will cause:
  - **Wrong behavior**: flow action's input is receiving null field, when it expects a different value.
- Use expression towards null fields. It will cause:
  - **Runtime error**: expression expects its parameter to be a string, an object, or an array but receives null.

## Flow error resolution

You can set up a condition check for null field. Here are the steps to create a condition check for null.

1. Add a new condition action.

    :::image type="content" source="media/getting-errors-null-fields/add-new-condition-action.png" alt-text="Screenshot to add a new condition action in the Choose an action window.":::

2. Choose dynamic content output (for example, user email) you want to check.

    :::image type="content" source="media/getting-errors-null-fields/choose-user-email.png" alt-text="Screenshot to choose the dynamic content output that you want to check.":::

3. Set the operation to be (for example) **is not equal to**.
4. Put the value field as the expression value **null**.

    :::image type="content" source="media/getting-errors-null-fields/expression-value-null.png" alt-text="Screenshot to put the value field as the expression value null.":::

## Runtime error resolution

You can also use the coalesce function to provide default values when a value is null. For example, using **coalesce(trigger().outputs, '')** will default to empty string when **trigger().outputs** is null.

:::image type="content" source="media/getting-errors-null-fields/coalesce-function-provide-default-values.png" alt-text="Screenshot to use the coalesce function to provide the default values when a value is null.":::

> [!NOTE]
> If you're still getting a runtime error, it may be caused by reference null properties in an object. You should use the question mark operator **?**. For example, to handle null outputs from a trigger, you can use this expression:  
> `@coalesce(trigger().outputs?.body?.<someProperty>, '<property-default-value>').`

For more information, see [Coalesce](/azure/logic-apps/workflow-definition-language-functions-reference#coalesce) and [Operators](/azure/logic-apps/logic-apps-workflow-definition-language#operators).
