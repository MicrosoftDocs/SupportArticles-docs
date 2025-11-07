---
title: Troubleshoot common issues with triggers
description: Learn how to find and fix issues when your flows don't run.
suite: flow
ms.date: 10/16/2025
ms.custom: sap:Flow run issues\Triggers
ms.update-cycle: 180-days
ms.reviewer: angieandrews, kenseongtan, kisubedi, v-aangie, v-shaywood
search.audienceType: 
  - flowadmin
---
# Troubleshoot common issues with triggers

Here are some tips and tricks for troubleshooting issues with triggers.

## Identify specific flow run

Sometimes, you need to [Identify specific flow runs](/power-automate/fix-flow-failures#identify-specific-flow-runs) to troubleshoot your flows.

## My trigger doesn't fire

1. A data loss prevention policy might be the cause.

   Admins can create [data loss prevention (DLP)](/power-platform/admin/wp-data-loss-prevention) policies that act as guardrails to help prevent users from unintentionally exposing organizational data. DLP policies enforce rules for which connectors can be used together by classifying connectors as either **Business** or **Non-Business**. If you put a connector in the **Business** group, it can only be used with other connectors from that group in any given app or flow.

   If your flow violates a DLP policy, it's suspended, causing the trigger to not fire. To know if your flow is suspended, try to edit the flow and save it. The flow checker reports it if the flow violates a DLP policy. Your admin can change the DLP policy.

1. The trigger might be failing. Follow these steps to confirm:

   1. Sign in to [Power Automate](https://make.powerautomate.com).
   1. On the navigation menu to the left, select **My flows**, then select your flow.
   1. Review the details page. Do you see the following error in the **Details**?

      > There's a problem with the flow's trigger. Fix the trigger.

       :::image type="content" source="./media/triggers-troubleshoot/fix-trigger.png" alt-text="Screenshot of an error message about the flow's trigger." lightbox="media/triggers-troubleshoot/fix-trigger.png":::

   This error means that Power Automate tried multiple times to establish a connection to register the trigger and failed. Your flow doesn't trigger until this problem is resolved.

   One common reason for this failure is that the Power Automate service endpoints aren't part of the allowlist. To fix it, confirm that your IT department added these endpoints to the allowlist.

   Here's the list of [IP addresses and domains](/power-automate/ip-address-configuration) that need to be added to your allowlist.

      For more information about fixing issues with triggers, see [There is a problem with the flow's trigger](there-is-a-problem-with-the-flows-trigger.md).

After the problem is resolved, modify the flow and then save it. You can then change it back to its original state, and then save it again. The flow becomes aware that its configuration changed, and it tries to register its trigger again.

### Verify connections

With the default settings, users only need to sign in to a connection once. They can then use that connection until an admin revokes it. A possible scenario is that the password for the connection expires or there might be a policy in your organization that sets the connector's authentication token to expire after a specific amount of time. Token lifetime policies are configured on Microsoft Entra ID. For more information, see [Configurable token lifetimes in the Microsoft identity platform (preview)](/entra/identity-platform/configurable-token-lifetimes).

Follow these steps to verify if your connections are broken:

1. Sign in to [Power Automate](https://make.powerautomate.com).
1. Go to **More** > **Connections**.
1. Find the connection that your flow uses.
1. To fix a broken connection, select the link next to the **Status** column and follow the instructions.

   :::image type="content" source="./media/triggers-troubleshoot/fix-link.png" alt-text="The Fix connection link to fix a broken connection." lightbox="media/triggers-troubleshoot/fix-link.png":::

### Verify if the flow uses a premium connector trigger

1. Edit your flow to find the connector name for the trigger.
1. Go to the [list of connectors](https://make.powerautomate.com/connectors) and then search for that connector. If the connector is a premium connector, **PREMIUM** displays below the name of the connector.

    :::image type="content" source="./media/triggers-troubleshoot/premium-connector.png" alt-text="Screenshot of a premium connector." lightbox="media/triggers-troubleshoot/premium-connector.png":::

A standalone Power Apps or Power Automate license is required to access all premium, on-premises, and custom connectors. You can [purchase licenses](https://make.powerautomate.com/pricing) at any time.

### Check your license type

Follow these steps to view the type of license that you have:

1. Sign in to [Power Automate](https://make.powerautomate.com).
1. Go to **My flows** in the left pane.
1. Select any flow.
1. In the **Details** section, find **Plan**. Your current license plan is listed.

### Verify if trigger check is skipped

You just completed an event. For example, you added a new list item or sent an email that should have triggered the flow, but the flow didn't run.

1. On the navigation menu to the left, select **My flows**, then select the flow.
1. In the **28-day run history**, select **All runs**.

    :::image type="content" source="./media/triggers-troubleshoot/all-runs.png" alt-text="Screenshot showing all runs." lightbox="media/triggers-troubleshoot/all-runs.png":::

If you expect the flow to run but it didn't run, check if the trigger check was skipped at that time. If the trigger check was skipped, it means that the trigger condition wasn't met for the flow to trigger. Verify the flow inputs and trigger conditions to confirm if you're using the latest configuration to trigger the flow.

### Verify inputs and trigger conditions

Sometimes, the inputs and trigger conditions might cause failures. Follow these steps to verify your inputs and conditions.

Power Automate allows you to use either the [new designer](/power-automate/flows-designer) or the classic designer to configure your cloud flow. The steps are similar in both designers. For more information and examples, see [Identify differences between the new designer and the classic designer](/power-automate/flows-designer#identify-differences-between-the-new-designer-and-the-classic-designer).

# [New designer](#tab/new-designer)

1. Sign in to [Power Automate](https://make.powerautomate.com).
1. On the navigation menu to the left, select **My flows**, then select a flow.
1. On the command bar, select **Edit**.
1. Select the first card to see what folders, sites, mailboxes, and others are used in the trigger in the configuration pane.

    :::image type="content" source="./media/triggers-troubleshoot/copilot-triggers.png" alt-text="Screenshot that shows trigger site in Copilot." lightbox="media/triggers-troubleshoot/copilot-triggers.png":::

1. In the configuration pane, select the **Settings** tab.
1. Find **Trigger conditions**.

   If the field is empty, it means that there are no other customizations and that the title of the card (in this case, **When an item is created or modified**) indicates when the trigger fires.

   If there are other customizations in **Trigger Conditions**, confirm that you're using the expected or correct inputs to trigger the flow.

    :::image type="content" source="./media/triggers-troubleshoot/copilot-trigger-conditions.png" alt-text="Screenshot that shows trigger conditions in Copilot." lightbox="media/triggers-troubleshoot/copilot-trigger-conditions.png":::

# [Classic designer](#tab/classic-designer)

1. Sign in to [Power Automate](https://make.powerautomate.com).
1. On the navigation menu to the left, select **My flows**, then select a flow.
1. On the command bar, select **Edit**.
1. Expand the first card to see what folders, sites, mailboxes, and others are used in the trigger.
1. On the card, select the ellipsis (**…**) > **Settings**.
1. Find **Trigger conditions**.

   If the field is empty, it means that there are no other customizations and that the title of the card (in this case, **When an item is created or modified**) indicates when the trigger fires.

   If there are other customizations in **Trigger Conditions**, confirm that you're using the expected or correct inputs to trigger the flow.

    :::image type="content" source="./media/triggers-troubleshoot/trigger-conditions.png" alt-text="Screenshot that shows trigger conditions." lightbox="media/triggers-troubleshoot/trigger-conditions.png":::

---

### Check permissions

Verify that you have access to the folders, sites, or mailboxes that the trigger uses. For example, to send email from a shared inbox via Power Automate, you need permissions to send an email through the shared inbox. Send a test email from that shared mailbox in Outlook.

### Verify if admin mode is turned on

If you turn on admin mode for an environment, you turn off all background processes, including flows. This change prevents the flow from triggering.

Follow these steps to turn off admin mode:

1. Go to the [Power Platform admin center](https://admin.powerplatform.com) and sign in with Environment Admin or System Administrator role credentials.
1. From the left-side menu, select **Environments**, and then select a sandbox or production environment.
1. On the **Details** page, select **Edit**.
1. Under **Administration mode**, set the slider to **Disabled**.

If everything looks good but your flow still doesn't trigger, check if your flow triggers after every step.

### Try these steps

1. Test the flow manually.
1. Remove, then re-add the trigger.
1. Switch the connection.
1. Turn off, then turn on the flow.
1. [Export](/power-automate/export-flow-solution), then [import](/power-automate/import-flow-solution) the flow.
1. Create a copy of the flow.
1. If the trigger uses special conditions, like when an email arrives in a specific folder, remove the folder, then add it again.

## My trigger fires for old events

There are two types of triggers: polling triggers and Webhook triggers.

If you turn off your flow and then turn it back on, depending on your trigger type, your flow might process old triggers.

A polling trigger periodically calls your service to check for new data. A Webhook trigger responds to a push of new data from the service.

Refer to the following table to understand how your flow responds when you turn it back on.

| Trigger type|Description|
|---|---|
| Polling, such as the `recurrence` trigger | When you turn the flow back on, it processes all unprocessed or pending events. If you don't want to process pending items when you turn your flow back on, delete and then recreate your flow. |
| Webhook  | When you turn the flow back on, it processes new events that are generated after the flow is turned on. |

Follow these steps to determine the type of trigger that your flow uses.

Power Automate allows you to use either the [new designer](/power-automate/flows-designer) or the classic designer to configure your cloud flow. The steps are similar in both designers. For more information and examples, see [Identify differences between the new designer and the classic designer](/power-automate/flows-designer#identify-differences-between-the-new-designer-and-the-classic-designer).

# [New designer](#tab/new-designer)

1. In the configuration pane to the left, select **Code View**.
1. Find the `recurrence` section with an interval `frequency` element. If this section is available, the trigger is a *polling* trigger.

    :::image type="content" source="./media/triggers-troubleshoot/copilot-recurrence.png" alt-text="Screenshot of the recurrence section in Copilot." lightbox="media/triggers-troubleshoot/copilot-recurrence.png":::

# [Classic designer](#tab/classic-designer)

1. On the title bar, select the ellipsis (**...**) > **Peek code**.

    :::image type="content" source="./media/triggers-troubleshoot/peek-code.png" alt-text="Screenshot of peek code." lightbox="media/triggers-troubleshoot/peek-code.png":::

1. Find the `recurrence` section with an interval `frequency` element. If this section is available, the trigger is a *polling* trigger.

    :::image type="content" source="./media/triggers-troubleshoot/frequency.png" alt-text="Screenshot of the recurrence section." lightbox="media/triggers-troubleshoot/frequency.png":::

---

## My flow runs multiple times or some of my actions run multiple times

You might encounter a scenario where a single flow run has some (or all) of its actions duplicated. While the UI doesn't show this problem, you might see the results of the flow being duplicated. For example, duplicate emails sent, or duplicate list items created.

One of the reasons this issue occurs is because of the "at-least-once" design of Azure Logic Apps.

Most of the time, this issue indicates that there was an issue with the Azure service. Usually, these issues self-resolve quickly. To ensure that your flows don't create duplication, design them to be **idempotent**&mdash;which is to say that the flow needs to account for the possibility of duplicate inputs.

An example of idempotency would be checking to see if a duplicate SharePoint document already exists before trying to create it, or using key constraints in Dataverse to prevent duplicate records getting created.

Another possibility for a flow triggering multiple times is having copies of the flow active in different environments that are triggering based on same condition. Use trigger conditions to customize triggers to reduce the number of times it triggers.

## My recurrence trigger runs ahead of schedule

Confirm that you set the **Start time** on the **Recurrence** card to ensure it runs only at the time that you need. For example, set **Start time** to '2022-10-10T10:00:00Z' to start your trigger at 10:00 AM.

## There's a delay before my trigger fires

If the trigger is a polling trigger, it wakes up periodically to check if new events occurred. The wake-up time depends on the license plan on which the flow runs.

For example, your flows might run every 15 minutes if you're on the **Free** license plan. On the **Free** plan, if a cloud flow is triggered less than 15 minutes after its last run, it's queued until 15 minutes elapsed.

If your license is the **Flow for Office 365** plan (from your Enterprise license E3, E5, and more), or the **Flow for Dynamics 365** plan, your flow doesn't run again until five minutes have elapsed. It might be a few minutes between the time the triggering event occurs and the time the flow begins.

Follow these steps to check the trigger wake-up frequency.

Power Automate allows you to use either the [new designer](/power-automate/flows-designer) or the classic designer to configure your cloud flow. The steps are similar in both designers. For more information and examples, see [Identify differences between the new designer and the classic designer](/power-automate/flows-designer#identify-differences-between-the-new-designer-and-the-classic-designer).

# [New designer](#tab/new-designer)

1. Sign in to [Power Automate](https://make.powerautomate.com).
1. On the navigation menu to the left, select **My flows**, then select a flow.
1. On the command bar, select **Edit**.
1. On your flow, select your flow trigger.
1. In the configuration tab, select the **Code view** tab.
1. Find the interval frequency.

    :::image type="content" source="./media/triggers-troubleshoot/copilot-recurrence.png" alt-text="Screenshot of the frequency element in Copilot." lightbox="media/triggers-troubleshoot/copilot-recurrence.png":::

# [Classic designer](#tab/classic-designer)

1. Sign in to [Power Automate](https://make.powerautomate.com).
1. On the navigation menu to the left, select **My flows**, then select a flow.
1. On the command bar, select **Edit**.
1. On your flow trigger, select the ellipsis (**...**) > **Peek code**.

    :::image type="content" source="./media/triggers-troubleshoot/peek-code.png" alt-text="Screenshot of the peek code setting." lightbox="media/triggers-troubleshoot/peek-code.png":::

1. Find the interval frequency.

    :::image type="content" source="./media/triggers-troubleshoot/frequency.png" alt-text="Screenshot of the frequency element." lightbox="media/triggers-troubleshoot/frequency.png":::

---

If your flow takes longer than expected to trigger, the delay is likely caused by one of the following reasons:

1. Too many calls to the connector or flow, which causes throttling. To check if your flow is being throttled, manually test the flow to see if it triggers immediately. If it triggers immediately, it's not throttled.

   You can check the [Power Automate analytics](/power-automate/admin-analytics-report) to learn more about your flows.

   If your flow is frequently throttled, redesign your flow to use fewer actions. For more information, see [Understand platform limits and avoid throttling](/power-automate/guidance/coding-guidelines/understand-limits).

   More tips:

   1. Acquire a Power Automate Premium (previously Power Automate per user) or Power Automate Process license (previously Power Automate per flow). After you acquire this license, open and then save the flow to refresh the entitlement associated with it and change the throttling mode.

   1. Split the flow into several instances. If the flow processes data, you can divide this data into subsets (per country/region, per business area, and so on).

      1. Use **Save As** on the flow to create several instances that process their own data. Since the quota is per flow, this approach serves as a workaround.

1. A communication issue prevents Power Automate from reacting to trigger events. Potentially, a service outage, policy change, password expiry, or similar issue caused the delay. You can view [Help + support](https://admin.powerplatform.microsoft.com/support) to find out if there are any active outages. You can also clear the cache of the browser and then retry.

## Power Apps trigger issues

*Unable to rename actions in a cloud flow* is a known issue for flows that use Power Apps triggers.

Here's a workaround to rename actions:

1. Remove the trigger.
1. Rename the actions.
1. Add your Power Apps trigger.
1. Configure variables where needed.

After you publish an app, make copies of the flows used by that app to make any updates. If you update a cloud flow referenced by a published app, you can break existing users. Don't delete or turn off existing flows until all users upgrade to the new published version of the app.

## SharePoint trigger issues

SharePoint triggers, such as **When a file is created or modified**, don't fire if you add or update a file in a subfolder. If you need the flow to trigger on subfolders, create multiple flows.

## Users can't run flows that are shared with them, but the owner can run the flow

Try one of the following solutions:

1. Fix or update connections.

   If your flow uses a **Manual** trigger, it needs the connection of the user who triggers the flow. If it uses the **Recurrence** trigger, it can run on the flow maker's connections.

1. Confirm the user has the appropriate license for the connections in the flow.

   A Power Automate license is required for the user to perform any actions like save, turn off, and more. A Power Apps, Dynamics 365, or Microsoft 365 license isn't sufficient. Users with whom flows that use premium connectors are shared each need a Power Automate Premium (previously Power Automate per user) or Power Automate Process license (previously Power Automate per flow) license to edit or manually trigger the flow. If the user was previously able to save or modify the flow, it's possible that their license expired.

   Alternatively, you can start a trial for the **Per User** plan for 90 days, after which you need a paid plan to run or edit flows that use premium connectors. Learn more in the [licensing page](https://make.powerautomate.com/pricing) and [Power Automate support](https://www.microsoft.com/en-us/power-platform/products/power-automate/).

### My flows don't trigger after I change the environment URL

To resolve this issue, edit each flow and save it. The triggers should start firing again.

## Triggers don't respect expressions used in them

For triggers, the value of expressions is calculated only when the flow is saved. For example, if your trigger uses `utcNow()` in an input, `utcNow()` is calculated when you save the flow, and the current UTC time is inserted into the trigger definition as a hardcoded value. `utcNow()` isn't recalculated every time the flow is triggered.

## Changes to HTTP or Teams Webhook trigger flows on Logic Apps environment architecture

> [!IMPORTANT]
>
> - This change only affects flows with HTTP or Teams Webhook triggers.
> - This change only affects flows in current environment architecture (Logic Apps). If your environment is Self Host MultiTenant (MTA), you're not impacted. To find which environment architecture your flows are in, see [Power Automate environments move to new architecture](/power-automate/environment-architecture).
> - This alert doesn't affect sovereign clouds.

Starting November 30, 2025, Power Automate flows with [HTTP triggers](/power-automate/oauth-authentication?tabs=classic-designer) or [Teams Webhook triggers](/connectors/teams/?tabs=text1%2Cdotnet#microsoft-teams-webhook) that have `logic.azure.com` in the URL will move to a new URL. This change is part of an infrastructure upgrade to improve execution speed and provide new features. For more information, see [Power Automate environments move to new architecture](/power-automate/environment-architecture).

To ensure that existing flows using these triggers continue to work, update the URLs used by external systems with the new URLs shown on the impacted flows. Complete the following actions by November 30, 2025. Before November 30, 2025 both the old and new URLs are supported; after that, the old URLs no longer work and flows fail to trigger.

### Required actions

To ensure your flows continue to function as expected, follow these steps:

#### Assess the impact

   1. Follow the steps in [Power Automate environments move to new architecture](/power-automate/environment-architecture) to identify the flow's environment type.
      1. You only need to take action for flows in the *Logic Apps* environment that use HTTP or Teams Webhook Triggers.
   1. Identify all flows that are impacted.
      1. If you have admin privileges, you can use a [PowerShell script](#list-all-flows-with-migrating-trigger-urls) to identify all impacted flows.
   1. Make note of the old and new trigger URLs for the impacted flows by navigating to the **Flow Details** page or the **Designer**.

#### Update URL references

   1. Identify all external applications and systems (such as web apps, Power Apps, flows, and others) that reference the old trigger URL.
   1. Replace the old trigger URL with the updated URL displayed in the trigger card of your flow's designer.

#### Validate the new URL

   1. Verify that the updated URL works as expected by triggering the flow and checking for successful execution.
   1. If you're using SAS authentication, confirm that the destination system supports URLs longer than 255 characters.

#### Check the relative path parameter

   1. If your trigger URL uses a relative path parameter, ensure there are no beginning slashes in the field to avoid double slash errors.
   1. Modify the relative path as needed and validate the trigger URL for correctness.

### Key changes

- **Updated trigger URL**: The URL displayed on the HTTP trigger card in your flow's designer will reflect a new URL. This new URL is required for your flows to function correctly.
- **Length of the new URL**: The updated URL might exceed 255 characters, especially when [Shared Access Signature (SAS) authentication](/azure/storage/common/storage-sas-overview) is configured. Verify that your destination system supports URLs longer than 255 characters and adjust its configuration if necessary.
  - Update your system configurations to support URLs longer than 255 characters, if possible.
  - If your system can't support URLs longer than 255 characters, consider other solutions such as using a proxy wrapper like [Azure API Management](/azure/api-management/get-started-create-service-instance), [Azure Functions](/azure/azure-functions/functions-get-started), or a similar approach.
- **Warning banner**: A warning banner will appear on your flow details page or within the designer, displaying the old URL that has been replaced. This serves as a reminder to update any references to the outdated URL with the new URL. If you do not see the warning banner on flows with HTTP or Teams webhook trigger, your environment is most likely on Self Host Multitenant architecture, and your flows will not be impacted.

  > Click here to copy the new trigger URL. The old trigger URL \<trigger URL> will stop working on November 30, 2025. Your tools that use this flow WILL break unless you update them with the new URL.

  :::image type="content" source="./media/triggers-troubleshoot/http-trigger-url.png" alt-text="Screenshot of the warning banner reminding you to update the old URL." lightbox="media/triggers-troubleshoot/http-trigger-url.png":::

> [!NOTE]
> If a flow uses an HTTP action to call another flow, the parent flow is considered to be an external system. The URL in the parent flow should be updated with the new URL that is displayed in the child flow's trigger card. However, if the child flow is called through the **Run a child flow** action, no change is needed.

### List all flows with migrating trigger URLs

Admins can use the [Microsoft.PowerApps.Administration.PowerShell](https://www.powershellgallery.com/packages/Microsoft.PowerApps.Administration.PowerShell/2.0.216) package to list all flows whose trigger URLs will be migrated. After installing the package, run the following PowerShell cmdlet:

```powershell
Get-AdminFlowWithMigratingTriggerUrl -EnvironmentName <EnvironmentName>
```

The cmdlet outputs the `DisplayName` and `FlowName` (ID) of each flow whose trigger URL is migrating.

To find all impacted flows across a tenant:

1. Use [Get-AdminPowerAppEnvironment](/powershell/module/microsoft.powerapps.administration.powershell/get-adminpowerappenvironment) to list all app environments in the tenant:

   ```powershell
   Get-AdminPowerAppEnvironment
   ```

1. Then use `Get-AdminFlowWithMigratingTriggerUrl` to list the impacted flows for each environment.
