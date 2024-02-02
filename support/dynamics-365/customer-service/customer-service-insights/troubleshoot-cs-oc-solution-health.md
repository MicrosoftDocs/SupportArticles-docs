---
title: Troubleshoot issues with Solution Health Hub
description: Provides more information about how to troubleshoot issues using Solution Health Hub in Dynamics 365 Customer Service and Omnichannel for Customer Service.
ms.reviewer: sdas
ms.author: shchaur
ms.date: 12/04/2023
---
# Troubleshoot issues in Customer Service and Omnichannel for Customer Service using Solution Health Hub

[!INCLUDE [cc-use-with-omnichannel](~/../dynamics-365-customer-engagement-pr/ce/includes/cc-use-with-omnichannel.md)]

## Introduction

You can use Solution Health Hub to get a better picture of the state of your Power Platform environment and detect any issues it might have. Solution Health Hub runs rules within an instance to validate the environment's configuration, which might change over time through natural system operations. The rules are specific to Dynamics 365 Customer Service and Omnichannel for Customer Service. You can run the rules on demand when you run into an issue. Some rules are automatically triggered when Dynamics 365 Customer Service or Omnichannel for Customer Service is installed or updated. You can regularly run the rule sets to monitor the health of your environment.

Here are some issues that the Solution Health Hub app helps detect:

- **Customer Service**
  - Critical Customer Service processes that are deactivated.
  - Processes that will cause an upgrade to fail are assigned to disabled users.
  - Presence of customized web resources that might lead to runtime issues.

- **Omnichannel for Customer Service**
  - Missed or wrong configurations.
  - Queues with no agents.
  - Agents with no capacity.
  - Agents who aren't part of any queues.
  - Workstream configuration problems.

## Prerequisites

To run the Dynamics 365 Customer Service rules, the following prerequisites must be met:

- The Customer Service Hub app is installed in your environment.
- You should have either the CSR Manager or System Administrator security role.

To run the Omnichannel for Customer Service rules, you must have Omnichannel for Customer Service installed in your environment.

## Run a health check

Take the following steps to run an analysis job to check for issues in Omnichannel for Customer Service:

1. Open the Solution Health Hub app.
2. Select **Analysis Jobs** > **New**.
3. In the **Create Analysis Job** dialog box, in **Rule Set**, select **Omnichannel** or **Customer Service**, and then select **OK**.

> [!NOTE]
> For Dynamics 365 Customer Service, you can run the health check from **Analysis Jobs** in the **Service Management** site map of Customer Service Hub.

## Analyze the health check results

After the analysis job completes its run, the results are displayed on the **Job Details** tab.

The following information is available:

- **Name**: The name of the analysis job.
- **Status**: The status of the run.
- **Start Time**: The date and time when the job was started.
- **End Time**: The date and time when the job completed its run.
- **Failed Rules**: The number of rules that failed.
- **Warnings**: The number of rules that resulted in warnings.
- **Passed Rules**: The number of rules that passed successfully.
- **Total Rules**: The number of available rules.
- **Rule Run Count**: The count of rules that have been run.

The details of the results are displayed in a table as follows:

- **Name**: The name of the rule.
- **Message**: A brief summary of the result.
- **Return Status**: Whether the rule passed, failed, or returned a warning.
- **Severity**: The severity level.

You can do the following:

1. Select a rule for which the status appears as failed. The analysis results of the failed objects are displayed in the **Failing Records** area.

    :::image type="content" source="media/troubleshoot-cs-oc-solution-health/oc-solution-health-results.png" alt-text="Screenshot that shows the analysis job results for a rule.":::

2. Optionally, select the **Summary** tab for an overview of the results.

> [!NOTE]
> If you see any discrepancy in the health check results, rerun the job.

## Out-of-the-box rule sets for Dynamics 365 Customer Service

The out-of-the-box rules for Dynamics 365 Customer Service are as follows. These rules can't be edited.

| Rule | What the rule checks for | Reason for failure and fix |
|----|--------|----------|
|Automatic Record Creation process definitions in draft status |Checks whether `ExecutePrimaryCreatePostActions` and `ExecuteARC` custom actions are in the active or draft state when a rule for creating records automatically is being used. | The processes to create records are deactivated automatically.<br> Review whether the deactivated processes are required for your business logic and reactivate them if necessary. You can select the rule and then select **Resolve**, which will activate the processes. |
|Check if activity monitor for automatic record creation is enabled.  |Check for `msdyn_ArcActivityMonitorForFailedScenarios` and `msdyn_ArcActivityMonitorForSkippedScenarios` flag values to decide whether activity monitor is enabled. | Activity monitor isn't enabled for creating records automatically. Enable the activity monitor to monitor rules to know whether they succeeded or failed.<br> For more information, see [Use activity monitor to review and track rules](/dynamics365/customer-service/automatically-create-update-records#use-activity-monitor-to-review-and-track-rules). |
|Check if `autoRouteToOwnerQueue` for the `Email` entity is enabled.|Checks whether rules to create records automatically are enabled and autoroute to owner queue is set on the `Email` entity. |The rule for creating records automatically might not be triggered to the right user if the **Automatically move records to owner's default queue** check box is selected for the Email entity.<br> For more information, see [Entity records routing](/dynamics365/customer-service/enable-entities-for-queues). |
|Check if Customer Service forms are from unmanaged layer.|The rule fails when Customer Service forms are found in the unmanaged layer. |Customer Service forms are found in the active layer. Because unmanaged solutions overwrite Customer Service metadata fixes, we recommend that you don't place the system forms in active layers in a production environment.|
|Check workflow type for convert rule and convert rule items|<ul><li> **Modern rule**: Associated workflow should be a Power Automate flow <li>**Legacy rule**: Associated workflow should be a legacy workflow <li>Workflow state check <ul><li> **Active rule**: Associated workflow on the rule and rule item should be present and in active state. <li> **Draft rule**: The rule for creating records automatically should have no associated workflow; the rule item should have an associated workflow in the draft state. </ul></ul> | <ul><li>**Workflow type issue**: You've performed an activate or deactivate action on a legacy rule in Unified Interface form. <li> **Workflow type issue**: Created rule items for a modern rule in the legacy experience. </li> <li> **Workflow state issue**: You've turned on or off flow in Power Automate. </li></ul> <br> How to fix the issue<ul><li>**Workflow state issue**: should be automatically corrected for the customer to update the relevant workflow to its required state. </li> <li> **Workflow type issue**: contact Microsoft Support </li></ul> <br> We recommend the following: <ul><li> Rules created in Unified Interface should only be edited, activated, or deactivated in Unified Interface experience.</li><li> Rules created in legacy experience should only be edited, activated, or deactivated in legacy experience.</li> <li> In Power Automate, do not manually turn on or off flows to create records automatically.</li> |
|ConditionXml format check| <ul><li> **Modern rule**: The `conditionxml` attribute value of all the related rule items should be in fetchxml format. </li><li>**Legacy rule**: The `conditionxml` attribute value of all the related rule items should be in conditionxml format. </li></ul> |<ul><li> Format is mismatched in the rule type for creating records automatically.</li><li> You've performed the activate or deactivate action on a legacy rule in the Unified Interface form experience. </li><li>You've created rule items of a modern rule in the legacy experience.</li></ul><br> We recommend that the rules created in the Unified Interface app and legacy app be edited, activated, or deactivated in the corresponding app, respectively, and do not use the apps interchangeably. |
|Custom customizations on the Customer Service Hub site map|Checks for customizations on the Customer Service Hub site map. |Fails when the site map is customized. For more information, see [Merge site map customizations](/dynamics365/customerengagement/on-premises/developer/understand-managed-solutions-merged#merge-navigation-sitemap-customizations).|
|Custom customizations on the Customer Service Workspace site map|Checks for customizations on the Customer Service workspace site map. |Fails when the site map is customized. For more information, see [Merge site map customizations](/dynamics365/customerengagement/on-premises/developer/understand-managed-solutions-merged#merge-navigation-sitemap-customizations).|
|Customized option sets|Detects whether any option set in Customer Service has been customized. Customizing option sets can lead to unexpected behavior for unintended option sets.|Option set has been modified by customization.<br> Manually remove customizations from the Customer Service option set if they aren't required for your business.|
|Deleted Sdk message processing steps|Checks whether any SDK message processing steps are deleted. Deleted SDK message processing steps will lead to incorrect behavior when using Customer Service. |Fails if any of the shipped Customer Service SDK message processing steps have been deleted from the system. <br>Contact Microsoft Support to resolve the issue.|
|Disabled Sdk message processing steps|Checks whether any SDK message processing is disabled. Disabled SDK message processing steps will lead to incorrect behavior when using Customer Service.|`SdkMessageProcessingSteps` are deactivated. Review if the disabled `SdkMessageProcessingSteps` processes are required for your business logic and reactivate them if necessary. |
|Process definitions in draft status|Checks whether any process definitions related to Customer Service are in draft status. <br> **Note**: The `ManageContract`, `Contractline`, and `Entitlement` workflows are excluded from the validation check when they are in the draft state.|Processes are deactivated. Customer Service might not work correctly when processes are disabled. <br>To resolve the issue, reactivate process definition from customizations.|
|Process definitions owned by disabled users|Checks whether any process definitions in the system are assigned to disabled users. |Processes will fail because they are owned by disabled users. Make sure that all workflows are assigned to users who have the required permissions.<br> To resolve the issue, reactivate the user accounts that own workflows or assign the workflows to another user account with the proper security privileges.|
|Validate Email response template type for Modern Automatic Record Creation | The template type code of the auto-response email template set on a rule should match the primary entity set on all its rule items:<ul><li>`responsetemplateid` stores the auto-response email template on the `convertrule` entity. </li><li>`templatetypecode` stores the template type code on the email template entity. </li><li>`primarycreateentitylogicalname` stores the primary create entity on the `convertruleitem` entity. </li> |The template type code of the auto-response email template set on a rule didn't match with the primary entity set on its rule items. As a result, the automatic response won't be sent because the template type didn't match the rule item primary action entity type. But won't cause failure. |
|Waiting workflow instances are owned by disabled users|Detects waiting workflow instances that are assigned to disabled users. These workflows will fail to correctly generate the records that they are supposed to generate. | The workflows are assigned to disabled users.<br> To resolve the issue, reactivate the user accounts that own the workflows or assign the workflows to another user account with the proper security privileges. |

## Out-of-the-box rule sets for Omnichannel for Customer Service

When you run the analysis job, the following out-of-the-box rules are run. These rules can't be edited.

| Rule | Description |
|----|--------|
| Agents should have capacity | Verifies that capacity has been defined for agents. For more information, see [Manage users](/dynamics365/customer-service/users-user-profiles). |
| Bots should have capacity | Verifies that the bot's capacity is greater than zero. For more information, see [Configure a bot](/dynamics365/customer-service/configure-bot-azure).|
| Bots shouldn't have potentially low capacity  | Verifies that the bot's capacity is at least a hundred times the capacity of the work stream. |
| Custom channel configuration should have work stream | Verifies that all custom channels have an active work stream. For more information, see [Configure a custom channel](/dynamics365/customer-service/configure-custom-channel). |
| Custom channel settings should have all required fields | Verifies that custom channel settings have the messaging endpoint URL field. |
| Facebook page configuration should have work stream | Verifies that all Facebook pages have an active work stream. For more information, see [Configure a Facebook channel](/dynamics365/customer-service/configure-facebook-channel). |
| Facebook settings should have all required fields | Verifies that Facebook channel settings have the messaging endpoint URL field. |
|Line channel configuration should have work stream | Verifies that all LINE channel configurations have an active work stream. For more information, see [Configure a LINE channel](/dynamics365/customer-service/configure-line-channel). |
| Line settings should have all required fields  | Verifies that the LINE settings webhook URL isn't empty. |
|Live chat channel configuration should have work stream | Verifies that Live Chat has an active work stream. For more information, see [Configure a chat channel](/dynamics365/customer-service/add-chat-widget). |
| Omnichannel service endpoint should be configured | Verifies that the underlying services needed for the functioning of Omnichannel for Customer Service are configured correctly. For more information, see [Provisioning Omnichannel for Customer Service](/dynamics365/customer-service/implement/omnichannel-provision-license). |
| Queues should have agents | Verifies that the queues that are assigned to the work streams have agents assigned. For more information, see [Manage queues](/dynamics365/customer-service/queues-omnichannel). |
| SDK message/plugins should be active | Verifies that the SDK messages or plug-ins are active. For more information, see [Remove deactivated or disabled customizations](/powerapps/developer/model-driven-apps/best-practices/business-logic/remove-deactivated-disabled-configurations). |
|SMS channel configuration should have work stream | Verifies that the SMS channel has an active work stream. For more information, see [Configure an SMS channel for TeleSign](/dynamics365/customer-service/configure-sms-channel) and [Configure an SMS channel for Twilio](/dynamics365/customer-service/configure-sms-channel-twilio). |
| SMS settings should have all required fields | Verifies that SMS settings don't have empty customer ID and API key fields. |
|Teams channel configuration should have work stream | Verifies that the Microsoft Teams channel configuration has an active work stream. For more information, see [Configure a Microsoft Teams channel](/dynamics365/customer-service/configure-microsoft-teams). |
|Teams settings should have all required fields | Verifies that the bot ID field isn't missing from the Teams settings. |
|WeChat channel configuration should have work stream | Verifies that all WeChat channel configurations have an active work stream. |
| WeChat settings should have all required fields | Verifies that the **IP allowlist** and **Server address (URL)** fields aren't empty in the WeChat settings. For more information, see [Configure a WeChat channel](/dynamics365/customer-service/configure-wechat-channel). |
|WhatsApp channel configuration should have work stream | Verifies that all WhatsApp phone numbers have an active work stream. For more information, see [Configure a WhatsApp channel](/dynamics365/customer-service/configure-whatsapp-channel). |
| WhatsApp settings should have all required fields | Verifies that WhatsApp settings have a valid Twilio inbound URL and validation hasn't failed. |
| Work stream capacity should be less than agents | Verifies that the capacity defined for agents is more than that defined for the work streams. For more information, see [Understand work streams](/dynamics365/customer-service/create-workstreams). |
| Work stream should have notification templates set | Verifies that notification templates have been set for work streams. For more information, see [Associate templates with work streams](/dynamics365/app-profile-manager/associate-templates). |
| Work stream should have session template set | Verifies that session templates have been set for work streams. For more information, see [Associate templates with work streams](/dynamics365/app-profile-manager/associate-templates). |
| Work stream shouldn't have duplicate context variables | Verifies that duplicate context variables haven't been defined for work streams. For more information, see [Create a work stream](/dynamics365/customer-service/create-workstreams).  |
| Work stream shouldn't have empty routing rules above rules with condition | Verifies that empty routing rules haven't been defined for a work stream that prevents routing rules with a lower priority from running. For more information, see [Create and manage routing rules](/dynamics365/customer-service/routing-rules). |
| Work stream with push mode shouldn't allow offline mode | Verifies that "Offline" isn't an allowed presence for work streams that have push mode enabled. For more information, see [Create a work stream](/dynamics365/customer-service/create-workstreams). |

### See also

- [Troubleshoot issues in Omnichannel for Customer Service](/dynamics365/customer-service/troubleshoot-omnichannel-customer-service)
- [Frequently asked questions](/dynamics365/customer-service/implement/cs-troubleshooting-faqs)  

[!INCLUDE [footer-include](~/../dynamics-365-customer-engagement-pr/ce/includes/footer-banner.md)]
