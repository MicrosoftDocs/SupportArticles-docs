---
title: Troubleshoot with Solution Health Hub in Customer Insights - Journeys
description: Use Solution Health Hub to troubleshoot Dynamics 365 Customer Insights - Journeys. Run health checks, interpret return statuses, and fix common errors.
ms.date: 07/06/2026
ms.reviewer: alfergus, v-shaywood
search.audienceType: 
  - admin
  - customizer
  - enduser
---

# Use Solution Health Hub to troubleshoot Customer Insights - Journeys

## Summary

Solution Health Hub detects problems in your Dynamics 365 environment, so you get a clear picture of the state of your instances. It extends the [Power Apps checker](/powerapps/maker/common-data-service/use-powerapps-checker) to help keep your environment healthy. Over time, natural system operations can change your environment's configuration. To validate that configuration, Solution Health Hub runs a set of rules against your environment. Each rule is an automated check that inspects a specific part of the setup, such as whether a required process is active, and reports whether it's in the expected state.

Solution Health Hub includes rules for many Dynamics 365 apps. Customer Insights - Journeys provides its own rule set that checks the configuration the app depends on, such as required processes and service user roles. You can run rules on demand when you encounter an issue, or run them automatically outside of business hours. Automatic execution ensures minimal disruption to your Customer Insights - Journeys processes.

Here are a few common problems that Solution Health Hub detects:

- Critical Customer Insights - Journeys processes that are deactivated.
- Processes that cause an upgrade failure because they're assigned to disabled user accounts.
- Customized web resources that later cause runtime problems.

This article shows you how to run a health check, interpret the results, use them to fix problems, and opt out of automatic rule set execution.

## Prerequisites

- Customer Insights - Journeys version 1.35.10057.1054 or later.

## Run a health check

To run a health analysis job for Customer Insights - Journeys:

1. Open the Solution Health Hub app.

    :::image type="content" source="media/troubleshoot-marketing-solution-health/navigation.png" alt-text="Screenshot of the Solution Health Hub in the navigation." lightbox="media/troubleshoot-marketing-solution-health/navigation.png":::

1. On the welcome screen, select **Continue** in the lower right.
1. Select **Analysis Jobs** and create a new analysis job.
1. When the dialog box opens, select **Customer Insights - Journeys rule set**.
1. Select **OK** to start the analysis job.

The following rules are currently included for Customer Insights - Journeys:

| Rule name                                 | What it checks                                                                                                                                                                                                                                                         |
| ----------------------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| CheckIfSdkMessageProcessingStepsAreActive | Checks whether any [SDK message processing steps](/dynamics365/customerengagement/on-premises/developer/entities/sdkmessageprocessingstep) are disabled. Disabled SDK message processing steps result in incorrect behavior when you use Customer Insights - Journeys. |
| CheckIfProcessOwnedByDisabledUsers        | Checks whether any process definitions in the system are assigned to disabled user accounts. If they are, the upgrade fails.                                                                                                                                           |
| CheckIfProcessesAreActive                 | Checks whether any process definitions are in draft status. If processes are in draft status, Customer Insights - Journeys doesn't work correctly.                                                                                                                     |
| MissingMktConfiguration                   | Checks for the presence of a Customer Insights - Journeys configuration entity record. If the configuration entity record is missing, Customer Insights - Journeys doesn't work properly.                                                                              |
| MissingRolesToApplicationUser             | Checks whether MarketingServices ApplicationUser has all required roles assigned. If some of the roles are missing, the Customer Insights - Journeys application might not work properly.                                                                              |

## View health check results

After you start the health analysis job, you're directed to the overview page. The page refreshes automatically when the run finishes. The overview shows the job status, a summary count of passed, failed, and warning rules, and a row for each rule in the run.

The following table shows an example overview of a completed run:

| Rule name                                 | Message          | Return status | Severity |
| ----------------------------------------- | ---------------- | ------------- | -------- |
| CheckIfSdkMessageProcessingStepsAreActive | No issues found. | Pass          | None     |
| CheckIfProcessOwnedByDisabledUsers        | No issues found. | Pass          | None     |
| CheckIfProcessesAreActive                 | No issues found. | Pass          | None     |
| MissingMktConfiguration                   | No issues found. | Pass          | None     |
| MissingRolesToApplicationUser             | No issues found. | Pass          | None     |

:::image type="content" source="media/troubleshoot-marketing-solution-health/rules-analysis.png" alt-text="Screenshot of a complete analysis job overview." lightbox="media/troubleshoot-marketing-solution-health/rules-analysis.png":::

The **Return Status** indicates whether the rule passed, failed, or returned a configuration error. Failing rules also return a severity, which shows how severe each problem is. The following table lists all possible return status values:

| Rule return status | Recommendation                                                                          |
| ------------------ | --------------------------------------------------------------------------------------- |
| Fail               | Highlights specific failures in the system. Fix the issue as suggested.                 |
| Warning            | Be aware of the implications mentioned in the rule message.                             |
| Pass               | Indicates that there are no problems with this rule. All rules should be in this state. |

## Use health check results to fix problems

In the Customer Insights - Journeys rule set, the following rules support **Resolve** actions:

| Rule name                                 | Resolve action                                                                |
| ----------------------------------------- | ----------------------------------------------------------------------------- |
| CheckIfSdkMessageProcessingStepsAreActive | Reactivates deactivated SDK message processing steps.                         |
| CheckIfProcessesAreActive                 | Reactivates deactivated processes that are listed on the failed records tab.  |
| MissingRolesToApplicationUser             | Assigns required roles back to the Customer Insights - Journeys service user. |

To fix problems found on the **Analysis Results** tab, select the rule that failed, and then select the **Resolve** button that appears above the rules.

:::image type="content" source="media/troubleshoot-marketing-solution-health/resolve.png" alt-text="Screenshot of the Resolve button selection." lightbox="media/troubleshoot-marketing-solution-health/resolve.png":::

## Opt out of automatic rule set execution

To opt out of automatically running the Customer Insights - Journeys rule set, complete the following steps:

1. In Solution Health Hub, go to **Setup** in the left navigation pane and select **Solution Health Rule Sets**.

    :::image type="content" source="media/troubleshoot-marketing-solution-health/deactivate-rule-sets.png" alt-text="Screenshot of Solution Health Rule Sets navigation." lightbox="media/troubleshoot-marketing-solution-health/deactivate-rule-sets.png":::

1. Select the **Customer Insights - Journeys rule set**.
1. Select **Deactivate** in the top ribbon.

    :::image type="content" source="media/troubleshoot-marketing-solution-health/deactivate-button.png" alt-text="Screenshot of the deactivate button selection." lightbox="media/troubleshoot-marketing-solution-health/deactivate-button.png":::

1. A confirmation window appears. To confirm, select **Deactivate**.
1. Inactive rule sets appear in the **Inactive Solution Health Rule Sets** section of **Solution Health Rule Sets**. You can reactivate inactive rule sets anytime.

## Related content

- [Troubleshoot Customer Insights - Journeys](/dynamics365/customer-insights/journeys/real-time-marketing-faq)
- [Frequently asked questions for Customer Insights - Journeys](/dynamics365/customer-insights/journeys/troubleshoot-faq)
