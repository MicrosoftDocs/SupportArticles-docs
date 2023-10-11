---
title: Workflow element has invalid child element
description: Provides a solution to the 8004801a error that occurs when you try to import a solution in Microsoft Dynamics 365.
ms.reviewer: 
ms.topic: troubleshooting
ms.date: 03/31/2021
ms.subservice: d365-sales-custom-solutions
---
# The element Workflow has invalid child element ProcessTriggers error occurs when importing a Microsoft Dynamics 365 solution

This article provides a solution to an error that occurs when you try to import a solution in Microsoft Dynamics 365.

_Applies to:_ &nbsp; Microsoft Dynamics 365  
_Original KB number:_ &nbsp; 4462895

## Symptoms

When attempting to import a solution in Dynamics 365, you receive the following error:

> "This solution package cannot be imported because it contains invalid XML. You can attempt to repair the file by manually editing the XML contents using the information found in the schema validation errors, or you can contact your solution provider.  
Error code 8004801a."

If you select **Technical Details**, you see the following message along with other error details:

> "Schema validation of the customizations.xml file within the compressed solution package file failed. To manually validate and edit the file, you can download the schema file [here](https://go.microsoft.com/fwlink/?LinkId=196060) and use an XML editor that supports schema validation to get more details."

The textbox showing more details include the following information:

> "The element 'Workflow' has invalid child element 'ProcessTriggers'. List of possible elements expected: 'XamlFileName, ImageFileName, Type, Subprocess, Category, Mode, LanguageCode, Scope, OnDemand, TriggerOnUpdateAttributeList, TriggerOnCreate, TriggerOnDelete, AsyncAutodelete, SyncWorkflowLogOnFailure, StateCode, StatusCode, CreateStage, UpdateStage, DeleteStage, Rank, processorder, processroleassignment, RunAs, SdkMessageId, UniqueName, IsTransacted, IntroducedVersion, IsCustomizable, RendererObjectTypeCode, BusinessProcessType, FormId, PrimaryEntity'."

The textbox also includes extra details such as the name of a Business Process Flow process. If you find the name of this process, you can reference it when following the workaround included in the [Resolution](#resolution) section of this article.

## Cause

If you export a standard Business Process Flow process and try to import it, you may meet this error. Microsoft is aware of an issue that can cause this error to occur and is planning to release a fix.

## Resolution

You can work around this issue by adding the missing \<PrimaryEntity> node that is expected:

1. Extract the contents of the solution .zip file you're trying to import.
2. Open the customizations.xml file in a text editor.
3. Search for **ProcessTriggers**.
4. Above the `ProcessTriggers` node, add the following node replacing the `ReplaceEntityName` text with the primary entity for the Business Process Flow:

    `<PrimaryEntity>ReplaceEntityName</PrimaryEntity>`

    Refer to the following example for a before and after example:

    Before:

    ```xml
    <Workflow WorkflowId="{919e14d1-6489-4852-abd0-a63a6ecaac5d}" Name="Lead to Opportunity Sales Process" Description="This is the default process flow to work on a lead and convert it to an opportunity." unmodified="1">
    <ProcessTriggers />
        </Workflow>
    ```

    After:

    ```xml
    <Workflow WorkflowId="{919e14d1-6489-4852-abd0-a63a6ecaac5d}" Name="Lead to Opportunity Sales Process" Description="This is the default process flow to work on a lead and convert it to an opportunity." unmodified="1">
     **<PrimaryEntity>lead</PrimaryEntity>**  
    <ProcessTriggers />
        </Workflow>
    ```

    > [!NOTE]
    > If there are multiple Business Process Flows, you may need to add it for each of them.

5. Select all of the components from the solution including the modified customization.xml file and compress them into a .zip file.
6. Attempt to import the .zip file that includes these modifications.
