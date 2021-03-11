---
title: An item with the same key has been added
description: Provides a solution to an error that occurs when you create a new or editing an existing workflow in Microsoft Dynamics 365.
ms.reviewer: 
ms.topic: troubleshooting
ms.date: 
---
# An item with the same key has already been added error occurs when creating a workflow in Microsoft Dynamics 365

This article provides a solution to an error that occurs when you create a new or editing an existing workflow in Microsoft Dynamics 365.

_Applies to:_ &nbsp; Microsoft Dynamics CRM  
_Original KB number:_ &nbsp; 4053915

## Symptoms

When creating a new or editing an existing workflow in Microsoft Dynamics 365, you may be presented with the error:

> "An item with the same key has already been added".

Selecting the **Download Log** button will display the following information:

> Unhandled Exception: System.ServiceModel.FaultException\`1[[Microsoft.Xrm.Sdk.OrganizationServiceFault, Microsoft.Xrm.Sdk, Version=8.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35]]: System.ArgumentException: An item with the same key has already been added.Detail:  
\<OrganizationServiceFault xmlns:i="`https://www.w3.org/2001/XMLSchema-instance`" xmlns="`https://schemas.microsoft.com/xrm/2011/Contracts`">  
  \<ActivityId>afa2227c-21ba-4588-a11f-e8d0dd02a289\</ActivityId>  
  \<ErrorCode>-2147220970\</ErrorCode>  
  \<ErrorDetails xmlns:d2p1="`https://schemas.datacontract.org/2004/07/System.Collections.Generic`" />  
  \<Message>System.ArgumentException: An item with the same key has already been added.\</Message>  
  \<Timestamp>2017-11-08T20:52:35.6280057Z\</Timestamp>  
  \<ExceptionRetriable>false\</ExceptionRetriable>  
  \<ExceptionSource i:nil="true" />  
  \<InnerFault i:nil="true" />  
  \<OriginalException i:nil="true" />  
  \<TraceText i:nil="true" />  
\</OrganizationServiceFault>

If platform tracing has been enabled, you'll see the following errors logged within the trace.

> MSCRM Error Report:  
Error: An item with the same key has already been added.  
Error Message: An item with the same key has already been added.  
Source File: Not available  
Line Number: Not available  
Request URL: `https://CrmOrgName.dynamics.com/AppWebServices/Workflow.asmx`  
Stack Trace Info: [ArgumentException: An item with the same key has already been added.]  
   at System.ThrowHelper.ThrowArgumentException(ExceptionResource resource)  
   at System.Collections.Generic.Dictionary`2.Insert(TKey key, TValue value, Boolean add)  
   at Microsoft.Crm.Application.Components.UI.OptionGroup.AddItem(String text, String value, ListDictionary expandos)  
   at Microsoft.Crm.Application.Controls.CreateStepControl.RenderEntityList(HtmlTextWriter writer, StepControlType stepType, String onChange)  
   at Microsoft.Crm.Application.Controls.StepBaseControl.RenderEntity(HtmlTextWriter writer, StepControlType stepType, String onChange)  
   at Microsoft.Crm.Application.Controls.CreateStepControl.Render(HtmlTextWriter writer)  
   at System.Web.UI.Control.RenderControlInternal(HtmlTextWriter writer, ControlAdapter adapter)  
   at Microsoft.Crm.Application.Controls.CompositeStepBaseControl.RenderChildSteps(HtmlTextWriter writer)  
   at Microsoft.Crm.Application.Controls.WorkflowStepControl.Render(HtmlTextWriter writer)  
   at System.Web.UI.Control.RenderControlInternal(HtmlTextWriter writer, ControlAdapter adapter)  
   at Microsoft.Crm.Application.WebServices.WorkflowWebService.RenderWorkflow(WorkflowStep workflowStep, Boolean bSave, String parentStepId, String rendererTypeCode)  
   at Microsoft.Crm.Application.WebServices.WorkflowWebService.RenderWorkflow(WorkflowStep workflowStep, String parentStepId, String rendererTypeCode)  
   at Microsoft.Crm.Application.WebServices.WorkflowWebService.AddCreateEntityStep(String parentId, String entityId, String descriptionXml, String parentStepId, String rendererTypeCode)  

Additionally, you may also see the following message.
> ***MSCRM:ASSERTEX*** - ENTITY Singular LOCALIZED NAME NOT FOUND: logical name = 'msdyn_orginsightsuserdashboarddefinition' LANGUAGE ID = 1033

## Cause

One possible cause to this error is with an Entity naming convention within Customizations. For this particular error, refer to the attribute name listed in the `MSCRM:ASSERTEX` portion of the error. See below:

> ***MSCRM:ASSERTEX*** - ENTITY Singular LOCALIZED NAME NOT FOUND: logical name = '**msdyn_orginsightsuserdashboarddefinition**' LANGUAGE ID = 1033

The problem stays with the Entity that contains the attribute `msdyn_orginsightsuserdashboarddefinition`. You'll need to look for this attribute in the Microsoft Dynamics 365 customizations.

The problematic entity is easy to find within customizations as it's normally listed at the top of the entities with no name listed. See the below screenshot:

:::image type="content" source="media/an-item-with-same-key-has-been-added/solution-default-solution.jpg" alt-text="Dynamics 365 Entity Customization.":::

## Resolution

To resolve this error, you'll need to give the entity you located in the [cause](#cause) section a Display Name along with a Plural Name.

1. Open the Microsoft Dynamics 365 web client as a D365 admin.
2. Next, select **Settings**, select **Customizations**, and then select **Customize the System**.
3. Once the customization window opens, expand **Entities**.
4. Select the entity at the top with no display name listed.
5. In the right window pane, give the entity a Display Name and a Plural Name. See below screenshot.

    :::image type="content" source="media/an-item-with-same-key-has-been-added/entity-definition.jpg" alt-text="give the entity a Display Name and a Plural Name.":::

6. After naming the entity, select **Save** and then select **Publish**.
7. Finally, go back to your workflow editor and attempt to create a new workflow or edit an existing. It will now succeed.
