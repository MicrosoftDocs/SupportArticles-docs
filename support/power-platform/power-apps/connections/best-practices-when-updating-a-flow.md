---
title: Error codes on Flow run
description: This article describes best practices for updating Microsoft Flows used by Power Apps.
ms.reviewer: mlalavat
ms.date: 02/19/2024
---
# Best practices when updating a flow used by a Power App

This article describes best practices for updating Microsoft Flows used by Power Apps.

_Applies to:_ &nbsp; Power Apps  
_Original KB number:_ &nbsp; 4477072

## Error code "InvokerConnectionOverrideFailed" on Flow run

Some flows fail to run in Power Apps. In the Flow run history or the Power Apps telemetry, you might receive an error that resembles the following:

```output
    { 
        "code": "InvokerConnectionOverrideFailed", 
        "message": "Failed to parse invoker connections from trigger 'manual' outputs. Exception: Could not find any valid connection for connection reference name '<some_connection>' in APIM tokens header." 
    }
```

> [!NOTE]
> This error also occurs when you call the `install` API on Common Data Service (CDS), but the response is a generic error "Install flow failed."

### Cause

This issue occurs because the flow has been updated to use a new connection, but the app still uses the old flow metadata. Updating the flow doesn't update the apps that use the flow. To solve this issue, you must manually update the app for changes to be reflected in the app and for the flow to work.

### Mitigation steps

> [!NOTE]
> Make sure to perform the following steps in the source or development environment and update the solution. Once the solution is updated, import it to all the target or production environments.

1. Open the app for editing using the [latest version of Power Apps Studio](/power-platform/released-versions/powerapps).
2. [Remove the flows from the app](/power-apps/maker/canvas-apps/working-with-flows#remove-a-flow) (Remove flows from the Power Automate tab).
3. Re-add the flows to the app.
4. Save and republish the app.

## Error code "ConnectionAuthorizationFailed" on Flow run

```output
    { 
        "code": "ConnectionAuthorizationFailed", 
        "message": "The caller with object id '{user_id}' does not have the minimum required permission to perform the requested operation on connection '{some_connection_id}' under API '{some_connection_api}'." 
    }
```

### Cause

This error means that although the maker has permissions to the flow, the maker doesn't have permissions to the dependent connections that are used in the flow actions. This is a limitation of the Power Apps and Flow integration.

### Mitigation steps

> [!NOTE]
> Make sure to perform the following steps in the source or development environment and update the solution. Once the solution is updated, import it to all the target or production environments.

This mitigation is to have all connections in the flow be owned by a single user and then have that user add the flow to the app.

## Error code "WorkflowTriggerIsNotEnabled" on Flow run

```output
    { 
        "code": "WorkflowTriggerIsNotEnabled", 
        "message": "Could not execute workflow '<GUID>' trigger 'manual' with state 'Disabled': trigger is not enabled."  
    } 
```

### Cause

This error means that the flow is turned off.  

### Mitigation steps

> [!NOTE]
> Make sure to perform the following steps in the source or development environment and update the solution. Once the solution is updated, import it to all the target or production environments.

The mitigation is to [turn on the flow](/power-automate/disable-flow#turn-on-a-flow).

## Inner Error code "ResponseTimeout" on Flow run

```output
        {
            "error": {
            "code": 504,
            "source": "<api hub source>",
            "clientRequestId": "<GUID>",
            "message": "BadGateway",
            "innerError": {
                "error": {
                    "code": "ResponseTimeout",
                    "message": "The server did not receive a timely response from the upstream server. Request tracking id '<some_tracking_id>'."
                    }
                }
            }
        } 
```

### Cause

This error means that the synchronous flow is taking more then 2 minutes to run hence its timing out.

### Mitigation steps

> [!NOTE]
> Make sure to perform the following steps in the source or development environment and update the solution. Once the solution is updated, import it to all the target or production environments.

The mitigation is to find [what part is taking time and optimizing it to run under 2 minutes](/power-automate/fix-flow-failures#identify-specific-flow-runs).

## Error code "0x80040265" or "0x80048d0b" on Flow run

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

### Mitigation steps

> [!NOTE]
> Make sure to perform the following steps in the source or development environment and update the solution. Once the solution is updated, import it to all the target or production environments.

Try the solutions mentioned for one of the following error codes:

- [WorkflowTriggerIsNotEnabled](#error-code-workflowtriggerisnotenabled-on-flow-run)
- [ConnectionAuthorizationFailed](#error-code-connectionauthorizationfailed-on-flow-run)
- [InvokerConnectionOverrideFailed](#error-code-invokerconnectionoverridefailed-on-flow-run)

## Error code "MissingConnectionReference" on Flow run

```output
    { 
        "code": " MissingConnectionReference' ", 
        "message": " Connection reference '<connection name>' was not given by invoker."
    } 
```

Example error:

> Connection reference '\<connection name>' was not given by invoker.

### Cause

Essentially, app and flow metadata must be synchronized. Any changes made to a flow require the app maker to edit the apps using the flow and remove or re-add the changed flow.

For solution apps or flows, an app might successfully invoke the flow in the source environment and then fail in the target environment with this error message:

> Connection not configured for this service.

The reason is that there might be a change to the flow in the target environment, but it doesn't exist in the source environment.

### Mitigation steps

> [!NOTE]
> Make sure to perform the following steps in the source or development environment and update the solution. Once the solution is updated, import it to all the target or production environments.

1. In the source environment, edit the app. Remove and then re-add the flows to the app. Save and publish the changes.
2. In the target environment, remove all unmanaged layers on the app and flow.
3. Export the solution and import it into the target environment.

   > [!NOTE]
   > There can be no unmanaged layers on either the flow or the app because this can cause issues in connection to the flow.

## Error code "NotAllowedConnectionReferenceon" on Flow run

```output
    {
        "code": " NotAllowedConnectionReference", 
        "message": "Connection reference '<connection name>' was not given by invoker."
    }
```

Example error:

> Connection reference '\<connection name>' was not given by invoker.

### Cause

This error means that the app has flow metadata that specifies that a SQL connection is required on the installation, but the actual flow metadata is different.

### Mitigation steps

> [!NOTE]
> Make sure to perform the following steps in the source or development environment and update the solution. Once the solution is updated, import it to all the target or production environments.

#### Mitigation option 1

1. In the source environment, edit the app. Remove and then re-add the flows to the app. Save and publish the changes.
2. In the target environment, remove all unmanaged layers on the app and flow.
3. Export the solution and import it into the target environment.

   > [!NOTE]
   > There can be no unmanaged layers on either the flow or the app because this can cause issues in connection to the flow.

#### Mitigation option 2

1. Change the connection from **Embedded** to **Invoker**.
2. Navigate to the flow portal to edit and update the flow settings.
3. On the flow details page, in the **Run only users** section, select **Edit**.
4. To update the flow connection source to **Invoker**, select **Provided by run-only user** and save.
5. To update the flow connection source to **Embedded**, select **Use this connection** and save.
6. Verify by triggering the flow. You see that the "install flow network" calls now are succeeding.

## Other symptoms

After updating a flow, calls to that flow from Power Apps start failing.

- If a new input is added to a flow without a Power App being updated, the flow will fail with an error message that resembles the following:

    > Unable to process template language expressions in action 'Send_me_a_mobile_notification' inputs at line '1' and column '1900': 'The template language expression 'triggerBody()['Sendmeamobilenotification_Text']' cannot be evaluated because property 'Sendmeamobilenotification_Text' cannot be selected. Please see `https://aka.ms/logicexpressions` for usage details.'.

    :::image type="content" source="media/best-practices-when-updating-a-flow/flow-fail-error-message.png" alt-text="Screenshot of the error message when adding the new input to the flow without updating the Power App." lightbox="media/best-practices-when-updating-a-flow/flow-fail-error-message.png":::

- If the connections required to run a flow change, an error complaining about connections should appear:

    In Power Apps, it might look like:

    :::image type="content" source="media/best-practices-when-updating-a-flow/power-app-error.png" alt-text="Screenshot of the error message complaining about the connections in Power Apps.":::

    Or in Flow, it might look like:

    > Unable to process template language expressions in action 'Send_an_email' inputs at line '1' and column '1899': 'The template language expression 'json(decodeBase64(triggerOutputs().headers['X-MS-APIM-Tokens']))['$connections']['shared_office365']['connectionId']' cannot be evaluated because property 'shared_office365' doesn't exist, available properties are 'shared_flowpush'. Please see `https://aka.ms/logicexpressions` for usage details.'.

    :::image type="content" source="media/best-practices-when-updating-a-flow/flow-run-failed.png" alt-text="Screenshot of the error message complaining about the connections in Flow." lightbox="media/best-practices-when-updating-a-flow/flow-run-failed.png":::

- If a response output is removed, Power Apps will treat the value as blank and the Power App will behave unexpectedly.  

### Cause

To invoke a flow from Power Apps, Power Apps needs to know what inputs the flow needs, what connections to supply to the flow, and what outputs the flow will return. Power Apps stores this information in the definition of your Power App, which creates a binding between a version of a Power App and the flows used in it. Changing any of these three aspects of a flow can break all previous versions of Power Apps that integrate with that flow. To fix an affected Power App or to use one of these flow changes, the Power App needs to be updated.

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

### Resolution

#### Changing a live Power App

Once a Power App is published, it's always recommended to make copies of flows used by the Power Apps to make any updates. Any update to a flow referenced by a live Power App has the potential to break existing users. Don't delete or turn off the existing flows until all users have been upgraded to the new published version of the Power App.

:::image type="content" source="media/best-practices-when-updating-a-flow/make-copies-flow.png" alt-text="Screenshot to make copies of the flows used by the Power App by selecting the Save As option.":::

In the new version of the Power App, reference the new flows. When the new version of the Power App is published, users will start to use the new flows with the correct inputs, outputs, and connections. Which will prevent flow updates for new versions of Power Apps from affecting users of the existing version.

#### Changing a Power App development version

While developing a Power App, making changes to a flow not used by a live version of the Power App is easy. After making changes to the inputs, outputs, or connections of a non-published flow, reselect the flow from the **Flows** pane.

:::image type="content" source="media/best-practices-when-updating-a-flow/reselect-flow.png" alt-text="Screenshot of updating a flow definition in Power Apps.":::

It will update the definition of the flow in the Power App validating that the correct input, outputs, and connections are used in the Power App.

Users of the Power App won't begin using the new flows until the Power App is published. So updating the existing flow is ok until it's used by a live version of the Power App.
