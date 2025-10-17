---
title: Error codes on Flow run
description: Describes best practices and steps to mitigate common errors when running Microsoft flows in Power Apps.
ms.reviewer: mlalavat
ms.date: 04/18/2025
ms.custom: sap:Connections\Creating or updating connections
---
# Troubleshoot Power Apps flow integration issues

*Applies to:* Power Apps
*Original KB number:* 4477072

When integrating Power Automate flows with Power Apps, you might encounter various errors that prevent flows from running correctly. This article helps you troubleshoot common integration issues and provides best practices for managing flow updates.

Flow integration errors typically occur when:

- Flow metadata becomes out of sync with your app
- Connection permissions are insufficient or misconfigured
- Flows are disabled or timed out
- Flow definitions change after app deployment

This document covers the following error codes along with their causes and mitigation strategies:

- [InvokerConnectionOverrideFailed](#error-code-invokerconnectionoverridefailed-on-power-automate-flow-run)
- [ConnectionAuthorizationFailed](#error-code-connectionauthorizationfailed-on-power-automate-flow-run)
- [WorkflowTriggerIsNotEnabled](#error-code-workflowtriggerisnotenabled-on-power-automate-flow-run)
- [ResponseTimeout](#inner-error-code-responsetimeout-on-power-automate-flow-run)
- [0x80040265/0x80048d0b](#error-code-0x80040265-or-0x80048d0b-on-power-automate-flow-run)
- [MissingConnectionReference](#error-code-missingconnectionreference-on-power-automate-flow-run)
- [NotAllowedConnectionReference](#error-code-notallowedconnectionreference-on-power-automate-flow-run)

## Error code "InvokerConnectionOverrideFailed" on Power Automate flow run

Some Power Automate flows might fail to run in Power Apps and you might see an error that resembles the following in the Power Automate flow run history or the Power Apps telemetry:

```output
    { 
        "code": "InvokerConnectionOverrideFailed", 
        "message": "Failed to parse invoker connections from trigger 'manual' outputs. Exception: Could not find any valid connection for connection reference name '<some_connection>' in APIM tokens header." 
    }
```

> [!NOTE]
> This error might also occur when you call the install API on Dataverse (formerly Common Data Service), resulting in a generic error message: "Install flow failed."

### Cause

This issue occurs when the Power Automate flow is updated to use a new connection, but the app still uses the old flow metadata. Even though the flow is updated, the apps that reference the flow still retain the previous flow metadata. To resolve this error, manually edit the app so changes appear in the app and the flow works.

### Mitigation steps

> [!NOTE]
> Make sure to perform the following steps in the source or development environment and update the solution. After you update the solution in the source or development environment, export and import it into all target or production environments.

1. Open the app for editing using the [latest version of Power Apps Studio](/power-platform/released-versions/powerapps).
2. [Remove the Power Automate flows from the app](/power-apps/maker/canvas-apps/working-with-flows#remove-a-flow).
3. Readd the flows to the app.
4. Save and republish the app.

## Error code "ConnectionAuthorizationFailed" on Power Automate flow run

```output
    { 
        "code": "ConnectionAuthorizationFailed", 
        "message": "The caller with object id '{user_id}' does not have the minimum required permission to perform the requested operation on connection '{some_connection_id}' under API '{some_connection_api}'." 
    }
```

### Cause

This error means that the maker doesn't have permissions to the dependent connections that are used in the flow actions. This error can occur even if the maker has permissions to the Power Automate flow itself. This issue is a limitation of the Power Apps and Power Automate flow integration.

### Mitigation steps

> [!NOTE]
> Make sure to perform the following steps in the source or development environment and update the solution. After you update the solution in the source or development environment, export and import it into all target or production environments.

To mitigate this issue, ensure that all connections used in the Power Automate flow are authorized for the user who is adding the flow to the app. The user must have the necessary permissions for each connection referenced by the Power Automate flow. For more information, see [Understand flow ownership and access](/power-automate/guidance/coding-guidelines/understand-access-to-flows).

## Error code "WorkflowTriggerIsNotEnabled" on Power Automate flow run

```output
    { 
        "code": "WorkflowTriggerIsNotEnabled", 
        "message": "Could not execute workflow '<GUID>' trigger 'manual' with state 'Disabled': trigger is not enabled."  
    } 
```

### Cause

The Power Automate flow is disabled or turned off.

### Mitigation steps

> [!NOTE]
> Make sure to perform the following steps in the source or development environment and update the solution. After you update the solution in the source or development environment, export and import it into all target or production environments.

Ensure that the [Power Automate flow is turned on](/power-automate/disable-flow#turn-on-a-flow) and verify the flow run by testing it manually.

## Inner error code "ResponseTimeout" on Power Automate flow run

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

This error indicates that a synchronous Power Automate flow run exceeds the maximum allowed execution time of 120 seconds (2 minutes), resulting in a timeout. [Learn more about the timeout limit of an outbound synchronous request.](/power-automate/limits-and-config#request-limits)

### Mitigation steps

> [!NOTE]
> Make sure to perform the following steps in the source or development environment and update the solution. After you update the solution in the source or development environment, export and import it into all target or production environments.

To mitigate this issue, [identify which Power Automate flow runs are exceeding the timeout limit](/power-automate/fix-flow-failures#identify-specific-flow-runs) and optimize the flow's actions to complete within 120 seconds. Review the recommendations in [Troubleshoot slow running flows](~/power-platform/power-automate/flow-run-issues/troubleshoot-slow-running-flows.md).

## Error code "0x80040265" or "0x80048d0b" on Power Automate flow run

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
> Make sure to perform the following steps in the source or development environment and update the solution. After you update the solution in the source or development environment, export and import it into all target or production environments.

Try the mitigation steps described for the following error codes, as the underlying causes might be similar:

- [WorkflowTriggerIsNotEnabled](#error-code-workflowtriggerisnotenabled-on-power-automate-flow-run)
- [ConnectionAuthorizationFailed](#error-code-connectionauthorizationfailed-on-power-automate-flow-run)
- [InvokerConnectionOverrideFailed](#error-code-invokerconnectionoverridefailed-on-power-automate-flow-run)

## Error code "MissingConnectionReference" on Power Automate flow run

```output
    { 
        "code": " MissingConnectionReference' ", 
        "message": " Connection reference '<connection name>' was not given by invoker."
    } 
```

Example error:

> Connection reference '\<connection name>' was not given by invoker.

### Cause

Power App and Power Automate flow metadata must always be synchronized. When changes are made to a Power Automate flow, the app maker must edit the apps that use the flow to remove or readd the changed flow.

For apps or flows included in a solution, an app might successfully invoke the flow in the source environment but fail in the target environment with this error message:

> Connection not configured for this service.

This error occurs when the flow in the target environment has changes that aren't present in the source environment, leading to mismatched connection references or metadata.

### Mitigation steps

> [!NOTE]
> Make sure to perform the following steps in the source or development environment and update the solution. After you update the solution in the source or development environment, export and import it into all target or production environments.

1. In the source environment, edit the app. Remove and then readd the flows to the app. Save and publish the changes.
2. In the target environment, remove all unmanaged solution layers from the app and flow.
3. Export the solution and import it into the target environment.

   > [!NOTE]
   > Ensure that both the flow and the app have no unmanaged solution layers. Unmanaged solution layers can interfere with connection references and cause integration issues.

## Error code "NotAllowedConnectionReference" on Power Automate flow run

```output
    {
        "code": " NotAllowedConnectionReference", 
        "message": "Connection reference '<connection name>' was not given by invoker."
    }
```

Example error:

> Connection reference '\<connection name>' was not given by invoker.

### Cause

This error occurs when the app's flow metadata expects a specific connection reference (such as a SQL connection) during installation. If flow's current metadata doesn't match this expectation, an error occurs.

### Mitigation steps

> [!NOTE]
> Make sure to perform the following steps in the source or development environment and update the solution. After you update the solution in the source or development environment, export and import it into all target or production environments.

#### Mitigation option 1

Reset the Power Automate flows in the app:

1. In the source environment, edit the app. Remove and then readd the Power Automate flows to the app. Save and publish the changes.
2. In the target environment, remove all unmanaged solution layers from the app and Power Automate flow.
3. Export the solution and import it into the target environment.

   > [!NOTE]
   > Ensure that both the flow and the app have no unmanaged solution layers. Unmanaged solution layers can interfere with connection references and cause integration issues.

#### Mitigation option 2

Change the connection from **Embedded** to **Invoker**:

1. To edit and update the flow settings, navigate to the Power Automate flow portal.
2. On the flow details page, in the **Run only users** section, select **Edit**.
3. To update the flow connection source to **Invoker**, select **Provided by run-only user** and save.
4. Verify by triggering the flow. You should now find the "install flow network" calls to be successful.

## Failures caused by Power Automate flow updates

When flow updates cause integration problems, you might see these other symptoms that can help you identify and troubleshoot the specific issue.

### Symptom 1

When new input is added to a Power Automate flow but the Power App isn't updated, the flow might fail. If the flow fails, it returns an error message that resembles the following example:

> Unable to process template language expressions in action 'Send_me_a_mobile_notification' inputs at line '1' and column '1900': 'The template language expression 'triggerBody()['Sendmeamobilenotification_Text']' cannot be evaluated because property 'Sendmeamobilenotification_Text' cannot be selected. Please see `https://aka.ms/logicexpressions` for usage details.'.

:::image type="content" source="media/best-practices-when-updating-a-flow/flow-fail-error-message.png" alt-text="Screenshot of the error message when adding the new input to the flow without updating the Power App." lightbox="media/best-practices-when-updating-a-flow/flow-fail-error-message.png":::

### Symptom 2

If the connections required to run a Power Automate flow change, you might receive an error.

In Power Apps, it might look like:

:::image type="content" source="media/best-practices-when-updating-a-flow/power-app-error.png" alt-text="Screenshot of the error message complaining about the connections in Power Apps.":::

In Power Automate flow, it might look like:

> Unable to process template language expressions in action 'Send_an_email' inputs at line '1' and column '1899': 'The template language expression 'json(decodeBase64(triggerOutputs().headers['X-MS-APIM-Tokens']))['$connections']['shared_office365']['connectionId']' cannot be evaluated because property 'shared_office365' doesn't exist, available properties are 'shared_flowpush'. Please see `https://aka.ms/logicexpressions` for usage details.'.

:::image type="content" source="media/best-practices-when-updating-a-flow/flow-run-failed.png" alt-text="Screenshot of the error message complaining about the connections in Flow." lightbox="media/best-practices-when-updating-a-flow/flow-run-failed.png":::

### Symptom 3

If a response output is removed, Power Apps treats the value as blank and the app behaves unexpectedly.

### Cause

Power Apps needs to know three things to invoke a flow: what inputs the flow requires, what connections to provide, and what outputs the flow returns. Power Apps stores this information in your app definition, creating a binding between your app version and the flows it uses. When you change any of these three flow aspects, you can break all previous app versions that integrate with that flow. To fix an affected app or use these flow changes, you need to update the app.

Types of changes most likely to break a Power Apps ability to call a Power Automate flow include:

1. Adding a new **Ask in Power Apps** token.

   :::image type="content" source="media/best-practices-when-updating-a-flow/ask-power-apps.png" alt-text="Screenshot of adding a new Ask in Power Apps token." lightbox="media/best-practices-when-updating-a-flow/ask-power-apps.png":::

1. Adding a new connection. For example, by adding a new action from a Connector that wasn't previously used like the SharePoint connector.

   :::image type="content" source="media/best-practices-when-updating-a-flow/add-new-connection.png" alt-text="Screenshot shows an example of adding a new connection.":::

1. Changing an existing connection. For example, changing an existing connection to a new connection.

   :::image type="content" source="media/best-practices-when-updating-a-flow/change-existing-connection.png" alt-text="Screenshot of changing an existing connection in Flow.":::

1. Removing an output from a **Respond to Power Apps** action.

   :::image type="content" source="media/best-practices-when-updating-a-flow/remove-output.png" alt-text="Screenshot of removing an output from a Respond to Power Apps action.":::

Other changes to the inputs or outputs might not break the integration between Power Apps and the Power Automate flow. However, the app must be updated to recognize and utilize new or modified inputs and outputs.

### Resolution

The approach you take to resolve the issue depends on whether you're working with a live app or a development version. Each scenario requires different steps to prevent disruption to users.

#### Changing a published (live) Power App

When your app is already published and in use, always create copies of flows before making updates. Updating flows directly can break the app for existing users.

Follow these steps:

1. Create copies of the flows you need to update using the **Save As** option.

   :::image type="content" source="media/best-practices-when-updating-a-flow/make-copies-flow.png" alt-text="Screenshot to make copies of the flows used by the Power App by selecting the Save As option.":::

1. Make your changes to the copied flows.
1. Update your app to use the new flows instead of the original ones.
1. Test and publish the updated app.
1. After all users upgrade to the new app version, you can safely delete or turn off the original flows.

This approach ensures users continue working with the original app and flows until they're ready to use the updated version.

#### Changing a development version Power App

When you're still developing your app (not yet published), you can safely update flows directly without creating copies.

Follow these steps:

1. Make your changes to the flow (inputs, outputs, or connections).
2. In Power Apps Studio, go to the **Flows** pane.
3. Remove the flow from your app.
4. Add the updated flow back to your app.
5. Save your app.

:::image type="content" source="media/best-practices-when-updating-a-flow/reselect-flow.png" alt-text="Screenshot of updating a flow definition in Power Apps.":::

This process updates your app to use the flow's new configuration. Since the app isn't published yet, your changes don't affect users.

## References

- [Use Power Automate pane](/power-apps/maker/canvas-apps/working-with-flows)
