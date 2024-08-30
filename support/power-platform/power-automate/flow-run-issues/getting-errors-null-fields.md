---
title: Getting errors with null fields
description: Provides a solution to errors and unexpected behaviors that occur when you run a flow in Microsoft Power Automate.
ms.reviewer: hamenon, samathur 
ms.date: 08/27/2024
ms.custom: sap:Flow run issues\Actions
---
# Getting errors with null fields 

This article provides information to help you handle flow runtime errors and unexpected behaviors related to null fields.

_Applies to:_ &nbsp; Power Automate  
_Original KB number:_ &nbsp; 4535432

## Symptoms

When you create a flow in Power Automate, you might experience the following issues:

- Unexpected behaviors occur when performing an action with a null field.
- Runtime errors occur if you don't handle null fields correctly. For example:

   > **InvalidTemplate**. Unable to process template language expressions. The provided value is of type 'Null'.

   :::image type="content" source="media/getting-errors-null-fields/invaild-template-error.png" alt-text="Screenshot of the invalid template runtime error." border="false":::

## Cause

- If an action receives a null field as input when it expects a different value, it can result in incorrect behavior.
- If an expression expects its parameter to be a string, an object, or an array but instead receives a null response, it can result in a runtime error.

## Resolution 1: Add a condition check

To check for a null response, you can [add a condition](/power-automate/add-condition) to the flow by following these steps. Then you can appropriate action to handle the condition.

1. In the Power Automate flow, add a new **Condition** action.

1. Choose the dynamic content output that you want to check. For example, **User email**.

1. Set the operation to **is not equal to**.

   :::image type="content" source="media/getting-errors-null-fields/condition-is-not-equal-to.png" alt-text="Screenshot of the operation setting.":::

1. In the value field, add the expression value as **null**.

   :::image type="content" source="media/getting-errors-null-fields/add-null-expression-value.png" alt-text="Screenshot of the value setting of the condition.":::

   :::image type="content" source="media/getting-errors-null-fields/set-condition-expression-not-equal-to-null.png" alt-text="Screenshot of the null expression value set up for the condition.":::

## Resolution 2: Use the coalesce function

You can also use the `coalesce` function to provide default values when a value is null. For example, using `coalesce(trigger().outputs, '')` will default to an empty string when `trigger().outputs` is null.

:::image type="content" source="media/getting-errors-null-fields/coalesce-function.png" alt-text="Screenshot to use the coalesce function to provide the default values when a value is null.":::

> [!NOTE]
> If you still get a runtime error after using the `coalesce` function, it might be caused by referencing null properties in an object. You can use the question mark operator (?) to handle null outputs from a trigger. For example:
> `@coalesce(trigger().outputs?.body?.<someProperty>, '<property-default-value>').`

For more information, see [Coalesce](/azure/logic-apps/workflow-definition-language-functions-reference#coalesce) and [Operators](/azure/logic-apps/logic-apps-workflow-definition-language#operators).
