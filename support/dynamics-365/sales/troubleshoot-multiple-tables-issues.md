---
title: Troubleshoot issues with multiple tables
description: Provides resolutions for the known issues that are related to multiple tables such as opportunity, quote, order, or invoice in Dynamics 365 Sales.
author: sbmjais
ms.author: shjais
ms.reviewer: lavanyakr
ms.date: 09/25/2023
ms.custom: sap:Opportunity
---
# Troubleshoot common issues with multiple tables

This article helps you troubleshoot and resolve common issues across multiple tables like opportunity, quote, order, or invoice in Microsoft Dynamics 365 Sales.

## Issue 1 - In Context Form may appear in the form selector

The **In Context Form** is used for displaying and customizing the side panel in deal manager, and in the new interface for contacts, opportunities, leads, and accounts.

### Cause

If your environment has any customization that sets the **formActivationState** to **Active** for these tables, the **In Context Form** appears in the form selector dropdown and lets users select this form for viewing the record details.

:::image type="content" source="media/troubleshoot-multiple-tables-issues/form-selector-dropdown.png" alt-text="Form selector dropdown showing the In Context Form option.":::

### Resolution

If the appearance of **In Context Form** leads to confusion, you can deactivate the **In Context Form** as shown in the following screenshot.

:::image type="content" source="media/troubleshoot-multiple-tables-issues/deactivate-in-context-form.png" alt-text="In Context form with the option to deactivate.":::

## Issue 2 - Error or unexpected behavior while working on tables

### Symptoms

While working on tables (such as opportunities, quote, order, invoice, quote product, and order product), you observe unexpected behavior or an error in Dynamics 365 for Sales. The following are some of the errors that you might encounter while working on opportunities, and they might apply to other tables:

- "Extended Amount is wrong after revising quote"- this error might occur due to a custom plug-in.
- "Error while saving the opportunity" - this error might occur due to custom JavaScript.
- "Error while close opportunity" - this error might occur due to a custom workflow.

### Cause

These issues might occur due to improper customization of the application.

### Resolution

You must verify the improper customizations and resolve them. Perform the following verification methods to identify which customization is causing the issue, and then resolve:

- [Deactivate a custom plug-in](#deactivate-a-custom-plug-in)
- [Disable custom JavaScript](#disable-custom-javascript)
- [Deactivate a custom workflow process](#deactivate-a-custom-workflow-process)

#### Deactivate a custom plug-in

1. Go to **Settings** > **Customizations** > **Customize the System**.
2. Select **Sdk Message Processing Steps**.

   A list of available SDK message processing steps is displayed.

3. Select the **Filter** icon, select the column **Primary Object Type Code (Sdk Message Filter)**, and then select the table for which the error is occurring.

    :::image type="content" source="media/troubleshoot-multiple-tables-issues/go-to-custom-plugin-list.png" alt-text="Go to the custom plug-in list to select the table for which the error is occurring." lightbox="media/troubleshoot-multiple-tables-issues/go-to-custom-plugin-list.png":::

4. Select the SDK message processing steps that are coming from the solutions owned by you.

    > [!NOTE]
    > To view your custom SDK message processing steps:
    >
    > 1. Go to **Settings** > **Solutions**, and then open the solution.
    >
    > 2. Select **SDK Message Processing Steps**. Verify that the values are selected as follows: **Component Type** to **SDK Message Processing Step**, and **View** to **All**.

5. Select **Deactivate**.
6. Publish the customizations.

    :::image type="content" source="media/troubleshoot-multiple-tables-issues/deactivate-unmanaged-custom-plugin.png" alt-text="Choose and deactivate unmanaged custom plug-ins." lightbox="media/troubleshoot-multiple-tables-issues/deactivate-unmanaged-custom-plugin.png":::

7. Verify the issue and if it doesn't occur, the issue is with the custom SDK message processing steps. Resolve the issue.

> [!NOTE]
> If the issue occurs, activate the **SDK Message Processing Steps** that you deactivated now and try to [disable custom JavaScript](#disable-custom-javascript) or [deactivate a custom workflow process](#deactivate-a-custom-workflow-process).

#### Disable custom JavaScript

1. Open the form editor of the table in which the error is occurring. In this example, we're selecting the table as Opportunities and the default solution form.

    :::image type="content" source="media/troubleshoot-multiple-tables-issues/javascript-form-editor.png" alt-text="Open form editor." lightbox="media/troubleshoot-multiple-tables-issues/javascript-form-editor.png":::

2. Select **Form Properties** on the form editor.

    :::image type="content" source="media/troubleshoot-multiple-tables-issues/javascript-form-editor-edit-properties.png" alt-text="Select Form Properties on the form editor.":::

    The **Form Properties** dialog box opens.

3. On the **Events** tab, select the control **OnLoad** from the **Events** drop-down list.

   :::image type="content" source="media/troubleshoot-multiple-tables-issues/javascript-form-properties-event-control-selection.png" alt-text="Select the control OnLoad from the Events drop-down list." border="false":::

4. Choose the custom **JavaScript** files that are coming from the solution owned by you.

   > [!NOTE]
   > To view your custom JavaScript:
   >
   > 1. Go to **Settings** > **Solutions**, and then open the solution.
   > 2. Select **WebResources**. Verify the values are selected as: **Component Type** to **WebResources** and **View** to **All**.
   > 3. Select **Filter** icon to enable filter options for columns. Select **Type** and set the filter as **Script (JScript)**.
   >
   > :::image type="content" source="media/troubleshoot-multiple-tables-issues/javascript-view-javascript-filter.png" alt-text="Select Type and set the filter as Script (JScript).":::

5. Select **Edit**. In this example, we have selected the custom JavaScript file **eg_opportunity** to edit.

    :::image type="content" source="media/troubleshoot-multiple-tables-issues/javascript-handler-properties-dialog.png" alt-text="Input details in the Handler properties dialog." border="false":::

6. Clear the **Enabled** option and select **OK**.

    :::image type="content" source="media/troubleshoot-multiple-tables-issues/javascript-handler-properties-uncheck-enabled.png" alt-text="Clear the Enabled option in the Handler properties dialog." border="false":::

7. Publish the customizations.

8. Verify the issue and if it doesn't occur, the issue is with the custom JavaScript. Resolve the issue.

> [!NOTE]
> If the issue occurs, enable the JavaScript that you disabled now and try to [Deactivate a custom plug-in](#deactivate-a-custom-plug-in) or [Deactivate a custom workflow process](#deactivate-a-custom-workflow-process).

#### Deactivate a custom workflow process

1. Go to **Settings** > **Customizations** > **Customize the System**.
2. Select **Processes**. These processes include Workflow, Business Process Flow, and Business Rule.

   A list of available processes is displayed.

3. Select the **Filter** icon, select the column **Primary Entity**, and then select the table for which the error is occurring.

    :::image type="content" source="media/troubleshoot-multiple-tables-issues/custom-process-workflow-list.png" alt-text="Go to the custom process workflow list to select the table for which the error is occurring." lightbox="media/troubleshoot-multiple-tables-issues/custom-process-workflow-list.png":::

4. Choose the processes that are coming from the solutions owned by you.

    > [!NOTE]
    > To view your custom processes:
    >
    > 1. Go to **Settings** > **Solutions**, and then open the solution.
    > 2. Select **Processes**. Verify the values are selected as: **Component Type** to **Processes** and **View** to **All**.

5. Select **Deactivate**.
6. Publish the customizations.

   :::image type="content" source="media/troubleshoot-multiple-tables-issues/deactivate-unmanaged-custom-process-workflow.png" alt-text="Choose and deactivate unmanaged process workflows." lightbox="media/troubleshoot-multiple-tables-issues/deactivate-unmanaged-custom-process-workflow.png":::

7. Verify the issue and if it doesn't occur, the issue is with the custom processes. Resolve the issue.

> [!NOTE]
> If the issue occurs, activate the **Processes** that you deactivated now and try to [Deactivate a custom plug-in](#deactivate-a-custom-plug-in) or [Disable custom JavaScript](#disable-custom-javascript).

## Issue 3 - Custom plug-in handling by using a shared variable

### Symptoms

- Create and update operations on Opportunity, Quote, Order, and Invoice tables trigger updates on their parent tables.
- Retrieving details about Opportunity, Quote, Order, and Invoice tables internally triggers the Price Calculation service, which subsequently triggers custom plug-ins created by customers.

### Resolution

Custom plug-ins execute create, update, and save operations on Opportunity, Quote, Order, and Invoice tables. The create and update operations on these tables internally trigger the Price Calculation service, which then updates the associated price-related fields or attributes of their parent tables.

You can identify or differentiate any updates in Opportunity, Quote, Order, or Invoice tables or parent Opportunity, Quote, Order, or Invoice tables by using the internal Price Calculation service or by using your own custom plug-in. The Boolean shared variable `InternalSystemPriceCalculationEvent`, which is accessible through `IPluginExecutionContext`, is available within the plug-in code. Any create or update event processed by using the Price Calculation service will set the value of the variable `InternalSystemPriceCalculationEvent` to `true`. The default value of `InternalSystemPriceCalculationEvent` is `false`. You can access this variable from your custom plug-in code to control the flow of your existing business logic.

> [!NOTE]
> To perform custom plug-in operations by using a shared variable, make sure that the out-of-the-box Price Calculation service is disabled.

#### Sample code

```csharp
public void Execute(IServiceProvider serviceProvider)
{
   // Obtain the tracing service
   ITracingService tracingService = (ITracingService)serviceProvider.GetService(typeof(ITracingService));

   // Obtain the execution context from the service provider.  
    IPluginExecutionContext executionContext = (IPluginExecutionContext)
    serviceProvider.GetService(typeof(IPluginExecutionContext))
    bool isInternalSystemPriceCalculationEvent = false;

    //Check existence of shared variable and fetch the value from executionContext
    if (executionContext.ParentContext != null && executionContext.ParentContext.SharedVariables.ContainsKey("InternalSystemPriceCalculationEvent"))
                    
    {
        isInternalSystemPriceCalculationEvent = (bool)executionContext.ParentContext.SharedVariables["InternalSystemPriceCalculationEvent"];
    }   

    if (isInternalSystemPriceCalculationEvent)
    {
            //TO DO - Add or skip custom business logic
    }

}
```
