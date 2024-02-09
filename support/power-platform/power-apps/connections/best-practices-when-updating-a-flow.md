---
title: Best practices when updating a Flow
description: This article describes best practices around updating Microsoft Flows used by Power Apps.
ms.reviewer: 
ms.topic: troubleshooting
ms.date: 03/31/2021
---
# Best practices when updating a Flow used by a Power App

This article describes best practices around updating Microsoft Flows used by Power Apps.

_Applies to:_ &nbsp; Power Apps  
_Original KB number:_ &nbsp; 4477072

## Error code InvokerConnectionOverrideFailed on Flow run 

We have been noticing that some flows fail to run within PowerApps. Within the Flow run history or the powerapps telemetry, you may see a similar error to this one: 

```output
    { 
        "code": "InvokerConnectionOverrideFailed", 
        "message": "Failed to parse invoker connections from trigger 'manual' outputs. Exception: Could not find any valid connection for connection reference name '<some_connection>' in APIM tokens header." 
    }
```

> [!NOTE]
> This error also happens when calling install api on CDS, but the response is a generic "Install flow failed" 

**The cause of the error:**

This is caused usually because the flow was updated to use a new connection, but the app still as the old flow metadata. Updating the flow will not update the apps that use the flow, so customer must manually update apps in order for changes to reflect in app and for flow to work 

**Mitigation Steps:**

**Make sure to do this steps in the Source/Dev environment and update the solution. Once solution is updated import it to all the Target/Prod environment.**

The first thing to try when you have users hitting these issues is: 

- open the app for edit using the latest version of the studio 
- Remove the flows from the app (Remove flow from power automate tab).
- Re-add the flows to the app. 
- Save and republish the app. 

## Error code ConnectionAuthorizationFailed on Flow run 

```output
    { 
        "code": "ConnectionAuthorizationFailed", 
        "message": "The caller with object id '{user_id}' does not have the minimum required permission to perform the requested operation on connection '{some_connection_id}' under API '{some_connection_api}'." 
    }
```

**The cause of the error:** 

This means that although the maker has permissions to the flow, the maker does not have permissions to the dependent connections that are used in the flow actions. This a limitation of PowerApps and Flow integration.  

**Mitigation Steps:**

**Make sure to do this steps in the Source/Dev environment and update the solution. Once solution is updated import it to all the Target/Prod environment.**

Mitigation is to simply have all connections in the flow be owned by a single user and then have that user add the flow to the app. 

## Error code WorkflowTriggerIsNotEnabled on Flow run 

```output
    { 
        "code": "WorkflowTriggerIsNotEnabled", 
        "message": "Could not execute workflow ‘<GUID>' trigger 'manual' with state 'Disabled': trigger is not enabled."  
    } 
```

**The cause of the error:**

This means that the flow is turned off.  

**Mitigation Steps:**

**Make sure to do this steps in the Source/Dev environment and update the solution. Once solution is updated import it to all the Target/Prod environment.**

Mitigation is to simply turn on the flow. 

## Error code  0x80040265/0x80048d0b on Flow run 

```output
    {

        "code": " 0x80040265", 
        "message": "Failed to install the flow."  

    }  
    {

        "code": " 0x80048d0b", 
        "message": "Failed to install the flow."  

    } 
 ```

**The cause of the error:**

This could be due to many reasons. Try solution mentioned for the following error codes 

- WorkflowTriggerIsNotEnabled 
- ConnectionAuthorizationFailed 
- InvokerConnectionOverrideFailed 

**Mitigation Steps:** 

**Make sure to do this steps in the Source/Dev environment and update the solution. Once solution is updated import it to all the Target/Prod environment.**

Try solution mentioned for the following error codes 

- WorkflowTriggerIsNotEnabled 
- ConnectionAuthorizationFailed 
- InvokerConnectionOverrideFailed 
 
## Error code MissingConnectionReference on Flow run 

```output
    { 
        "code": " MissingConnectionReference' ", 
        "message": " Connection reference ‘<connection name>’ was not given by invoker.” 
    } 
```

> Example Error : Connection reference '<connection name>' was not given by invoker. 

**The cause of the error:** 

Essentially, app and flow metadata must be in sync and any changes made to a flow require that the app maker edit the apps using the flow and remove/re-add the changed flow. 

With solution apps/flows, an app may successfully invoke the flow in the source environment and then fail in the target environment with this error message: "Connection not configured for this service." 

The reason that it works in the source environment and not the target environment is that there may be a change in the flow on the target environment that does not exist in the source environment. 

**Mitigation Steps:**

**Make sure to do this steps in the Source/Dev environment and update the solution. Once solution is updated import it to all the Target/Prod environment.**

- In the source environment, edit the app and remove then re-add the flows to the app. Save and publish the changes. 
- In the target environment, remove all unmanaged layers on the app and flow if there is any. 
- Export the solution and import into target environment (Note: there can be no unmanaged layers on either the flow or the app as this can cause issues in connection to the flow)
 
## Error code NotAllowedConnectionReferenceon Flow run 

```output
    {
        "code": " NotAllowedConnectionReference", 
        "message": "Connection reference ‘<connection name>’ was not given by invoker.” 
    }
```

> Example Error : Connection reference ‘<connection name>’ was not given by invoker. 

**The cause of the error:** 

This means that the app has flow metadata that specifies that a sql connection is required on the install, but the actual flow metadata is different. 

**Mitigation Steps:** 

**ake sure to do this steps in the Source/Dev environment and update the solution. Once solution is updated import it to all the Target/Prod environment.**  

**Mitigation Option 1** 

- In the source environment, edit the app and remove then re-add the flows to the app. Save and publish the changes. 
- In the target environment, remove all unmanaged layers on the app and flow if there is any. 
- Export the solution and import into target environment (Note: there can be no unmanaged layers on either the flow or the app as this can cause issues in connection to the flow) 

**Mitigation Option 2**

- Change the connection from Embedded to Invoker 
- Navigate to the flow portal, edit & update the flow settings 
- Edit the "run only users". 
- To update the flow connection source as Invoker - select "Provided by run-only user" and save. 
- To update the flow connection source as Embedded -select "Use this connection" and save. 
- Verify triggering the flow and see install flow network calls are succeeding now. 


## Other Symptoms

After updating a Flow, calls to that Flow from Power Apps start failing.

- If a new input is added to a Flow without a Power App being updated, the Flow will fail with an error message like:

    > Unable to process template language expressions in action 'Send_me_a_mobile_notification' inputs at line '1' and column '1900': 'The template language expression 'triggerBody()['Sendmeamobilenotification_Text']' cannot be evaluated because property 'Sendmeamobilenotification_Text' cannot be selected. Please see `https://aka.ms/logicexpressions` for usage details.'.

    :::image type="content" source="media/best-practices-when-updating-a-flow/flow-fail-error-message.png" alt-text="Screenshot of the error message when adding the new input to the Flow without updating the Power App." lightbox="media/best-practices-when-updating-a-flow/flow-fail-error-message.png":::

- If the connections required to run a flow change, an error complaining about connections should appear:

    In Power Apps, it may look like

    :::image type="content" source="media/best-practices-when-updating-a-flow/power-app-error.png" alt-text="Screenshot of the error message complaining about the connections in Power Apps.":::

    Or in Flow

    > Unable to process template language expressions in action 'Send_an_email' inputs at line '1' and column '1899': 'The template language expression 'json(decodeBase64(triggerOutputs().headers['X-MS-APIM-Tokens']))['$connections']['shared_office365']['connectionId']' cannot be evaluated because property 'shared_office365' doesn't exist, available properties are 'shared_flowpush'. Please see `https://aka.ms/logicexpressions` for usage details.'.

    :::image type="content" source="media/best-practices-when-updating-a-flow/flow-run-failed.png" alt-text="Screenshot of the error message complaining about the connections in Flow." lightbox="media/best-practices-when-updating-a-flow/flow-run-failed.png":::

- If a response output is removed, Power Apps will treat the value as blank and the PowerApp will behave unexpectedly.  

## Cause

To invoke a Flow from Power Apps, Power Apps needs to know what inputs the Flow needs, what connections to supply to Flow and what outputs a Flow will return. Power Apps store this information in the definition of your Power App. Which creates a binding between a version of a Power App and the Flows used in it. Changing any of these three aspects of a Flow can break all previous versions of Power Apps that integrate with that Flow. To fix an affected Power App or to make use of one of these Flow changes, the Power App needs to be updated.

Types of changes most likely to break a Power Apps ability to call a flow include:

- Adding a new Ask in Power Apps token.

    :::image type="content" source="media/best-practices-when-updating-a-flow/ask-power-apps.png" alt-text="Screenshot of adding a new Ask in Power Apps token." lightbox="media/best-practices-when-updating-a-flow/ask-power-apps.png":::

- Adding a new connection. For example, by adding a new action from a Connector that wasn't previously used like the SharePoint Connector.

    :::image type="content" source="media/best-practices-when-updating-a-flow/add-new-connection.png" alt-text="Screenshot shows an example of adding a new connection.":::

- Changing an existing connection. For example, changing an existing connection to a new connection.

    :::image type="content" source="media/best-practices-when-updating-a-flow/change-existing-connection.png" alt-text="Screenshot of changing an existing connection in Flow.":::

- Removing an output from a Respond to Power Apps action.

    :::image type="content" source="media/best-practices-when-updating-a-flow/remove-output.png" alt-text="Screenshot of removing an output from a Respond to Power Apps action.":::

Other changes to the inputs or outputs won't break the integration between Power Apps and Flow but will require the Power App to be updated so that it can use them.

## Resolution

- **Changing a live PowerApp**  

    Once a Power App is published, it's **always** recommended to make copies of Flows used by the Power Apps to make any updates. Any update to a Flow referenced by a live Power App has the potential to break existing users. **Don't** delete or turn off the existing Flows until all users have been upgraded to the new published version of the Power App.

    :::image type="content" source="media/best-practices-when-updating-a-flow/make-copies-flow.png" alt-text="Screenshot to make copies of the Flows used by the Power Apps by selecting the Save As option.":::

    In the new version of the Power App, reference the new Flows. When the new version of the Power App is published, users will start to use the new Flows with the correct inputs, outputs, and connections. Which will prevent Flow updates for new versions of Power Apps from affecting users of the existing version.

- **Changing a PowerApp development version**

    While developing a Power App, making changes to a Flow not used by a live version of the PowerApp is easy. After making changes to the inputs, outputs, or connections of a non-published Flow,  reselect the Flow from the Flows Pane.

    :::image type="content" source="media/best-practices-when-updating-a-flow/reselect-flow.png" alt-text="Screenshot of updating a Flow definition in Power Apps.":::

    It will update the definition of the Flow in the PowerApp validating that the correct input, outputs, and connections are used in the Power App.

    Users of the Power App won't begin using the new Flows until the Power App is published. So updating the existing Flow is ok until it's used by a live version of the Power App.
