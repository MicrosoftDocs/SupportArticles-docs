---
title: Create a vanilla repro model-driven app for troubleshooting
description: Provides more information about how to isolate a problem by reproducing it in a different environment.
author: tahoon
ms.date: 07/14/2023
ms.author: tahoon
search.audienceType: 
  - maker
search.app: 
  - PowerApps
contributors:
  - tahoon
---
# How to create a vanilla repro model-driven app

A vanilla repro app is a model-driven app that reproduces a problem in a vanilla environment. Unlike canvas apps, model-driven apps in the same environment share customizations like [client scripts](/power-apps/developer/model-driven-apps/client-scripting) and [server plug-ins](/power-apps/developer/data-platform/plug-ins). Therefore, it can be challenging to determine whether a problem is caused by an incorrect customization or a product issue.

Vanilla means no customizations. So a vanilla environment is an environment in its original state, like a fresh installation. Using a vanilla environment with minimal modifications to reproduce an issue can help rule out the possibility of a configuration error.

After creating a vanilla repro app, you can share it with others, such as in the [Microsoft Power Apps Community](https://powerusers.microsoft.com/t5/Power-Apps-Community/ct-p/PowerApps1) or through [Microsoft Support](https://powerapps.microsoft.com/support/).

## Create a vanilla environment

A vanilla environment doesn't refer to any specific [type of environment](/power-platform/admin/environments-overview#types-of-environments) in Power Platform. You can [create a new trial, sandbox, or developer environment](/power-platform/admin/create-environment) to use as a vanilla environment. But you need an appropriate license. 

If you don't have a license to create new environments, consider [simplifying the customizations](isolate-model-app-issues.md#remove-customizations) in your environment.

## Recreate custom tables and other components

Microsoft Power Apps and Microsoft Dynamics 365 have some out-of-the-box tables (entities) like **Accounts** and **Contacts**. To address issues with custom tables, you can create similar ones in the vanilla environment. You don't have to copy the exact configuration. For example, if the issue is with a column (field) of a table, create the column for a new table.

The same principle applies to any customizations, such as [business rules](/power-apps/maker/model-driven-apps/create-business-rules-recommendations-apply-logic-form), [commands](/power-apps/maker/model-driven-apps/command-designer-overview), [forms](/power-apps/maker/model-driven-apps/create-design-forms), and [views](/power-apps/maker/model-driven-apps/create-edit-views).

## Create sample data

A vanilla environment initially has no data. For simple issues, you can manually add a few rows (records). You can also [add sample data for out-of-the-box tables](/power-platform/admin/add-remove-sample-data).

If an issue requires specific data to reproduce, you can prepare a *.csv* or Excel file and [import data using the Power Platform admin center](/power-platform/admin/import-data-all-record-types) or [import data into a model-driven app](/power-apps/user/import-data).

## Simplify developer customizations

Some advanced customizations require programming knowledge. These include [client scripts](/power-apps/developer/model-driven-apps/client-scripting), [code components](/power-apps/developer/component-framework/overview) (custom controls), [classic commands](/power-apps/maker/model-driven-apps/command-designer-overview), [plug-ins](/power-apps/developer/data-platform/plug-ins), and [web resources](/power-apps/developer/model-driven-apps/web-resources). If they're necessary to reproduce an issue, simplify them as much as possible. Remove any irrelevant lines of code and references to third-party libraries.

## Isolate custom pages

Custom pages are a special type of canvas app. You can [create a minimal repro canvas app](minimal-canvas-app-repro.md) to demonstrate issues with custom pages. First, create a regular canvas app with sample data. If the issue doesn't occur, it might be related to how the custom page is integrated into the model-driven app. To further investigate, create a simplified version of the custom page in a new model-driven app.

## Export the vanilla repro app

After verifying that an issue exists in a vanilla environment, you can [create an unmanaged solution](/power-apps/maker/data-platform/create-solution) for the repro app.

It should include relevant customizations such as:

- A model-driven app (if it's not a standard Microsoft Dynamics 365 app like Customer Service Hub or Sales Hub.)
- Custom pages
- Dashboards
- Forms
- Relationships
- Tables
- Views

Then, you can [export the vanilla repro app and any relevant customizations in an unmanaged solution](/power-apps/maker/data-platform/export-solutions).

To verify whether the necessary components have been included, [import the solution](/power-apps/maker/data-platform/import-update-export-solutions) into a different vanilla environment, and check if the issue can be reproduced.

Sometimes, other required materials can't be packaged into solutions. Here are some other things to include with the vanilla repro app.

#### Sample data

Some issues require specific data to reproduce. As data isn't exported in a solution, you need provide a *.csv* or Excel file with the necessary data. Remember to remove any private and confidential data.

#### Source code

Advanced customizations created using JavaScript and C# can be difficult to package into a solution, for example, [classic commands](/power-apps/maker/model-driven-apps/command-designer-overview) or [plug-ins](/power-apps/developer/data-platform/plug-ins).

It's easier to explain the problem by providing a copy of the source code and quoting the relevant lines of code. Specify APIs that aren't working as expected.

#### Describe complex customizations

If the customizations are complicated, it can be difficult for others to understand, even if they have a vanilla repro app. It's helpful to describe how these customizations are made so that others can recreate them.

## Why can't I reproduce an issue in a vanilla environment

If an issue can't be reproduced in a vanilla environment, you need to check the configuration. Some missing factors may not be accounted for in the vanilla environment.

The fact that an issue doesn't occur in one environment is an important clue. By systematically examining different types of customizations, you can figure out the conditions that reproduce the problem.

Here are some reasons why a problem occurs in one environment but not in another:

- **[Customizations](isolate-model-app-issues.md#remove-customizations) are interfering with normal operation.** To confirm whether this is the case, add those customizations one by one to the vanilla environment or remove them from the environment where the problem occurs.
- **Tables, relationships, and other components are configured differently.** To confirm whether this is the case, reexamine the differences between the same components in the vanilla environment and the environment where the problem occurs.
- **Components may be corrupted.** To confirm whether this is the case, recreate them in the environment where the problem occurs.
- **User-specific reasons.** For example, some users have different [security roles](/power-platform/admin/security-roles-privileges) in one environment. To confirm whether this is the case, try alternative ways to access the data or perform the same task. Dataverse tables can be accessed in many ways, such as in model-driven apps, canvas apps, [Power Apps table designer](/power-apps/maker/canvas-apps/create-edit-tables), [Power Pages](/power-pages/introduction), and [Web API requests](/power-apps/developer/data-platform/webapi/query-data-web-api).
- **Different versions.** The environment may be a different version or in a different geographical region. Check the **About** section in the app or [environment details in the Power Platform admin center](/power-platform/admin/environments-overview#environment-details) for version details.
- **Issues with an environment's server.** To confirm whether this is the case, [examine network traffic](isolate-model-app-issues.md#find-out-if-the-issue-occurs-when-getting-data-or-showing-data) to determine if the server is sending the correct information. Compare it with the network traffic in the vanilla environment.

## Next steps

- [Learn more about debugging strategies for model-driven apps](isolate-model-app-issues.md)
- [Ask a question with the Power Apps community](https://powerusers.microsoft.com/t5/Power-Apps-Community/ct-p/PowerApps1)
- [Get Microsoft Support](https://powerapps.microsoft.com/support/)

## See also

- [Debugging model-driven apps with Monitor](/power-apps/maker/monitor-modelapps)
