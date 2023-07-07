---
title: Create a vanilla repro model-driven app for troubleshooting
description: Provides more information about how to isolate a problem by reproducing it in a different environment.
author: tahoon
ms.date: 07/06/2023
ms.author: tahoon
search.audienceType: 
  - maker
search.app: 
  - PowerApps
contributors:
  - tahoon
---
# How to create a vanilla repro model-driven app

A vanilla repro app is an app that reproduces a problem on a vanilla environment. Unlike canvas apps, model-driven apps in the same environment share customizations like [client scripts](/power-apps/developer/model-driven-apps/client-scripting) and [server plug-ins](/power-apps/developer/data-platform/plug-ins). It can be difficult to find out whether a problem is caused by a bad customization or a product bug.

Vanilla means "no customizations". So, a vanilla environment is one that's in its original state, like with a fresh installation. Use a vanilla environment and make minimal modifications to reproduce an issue, to rule out the possibility of a configuration error.

After creating a vanilla repro app, you can share it with others, like in the [Microsoft Power Apps Community](https://powerusers.microsoft.com/t5/Power-Apps-Community/ct-p/PowerApps1) or with [Microsoft Support](https://powerapps.microsoft.com/support/).

## Create a vanilla environment

A vanilla environment does not refer to any specific [type of environment](/power-platform/admin/environments-overview#types-of-environments) from Power Platform. You can [create a new trial, sandbox, or developer environment](/power-platform/admin/create-environment) to use as a vanilla environment. You will need an appropriate license.

If you don't have a license to create new environments, try to simplify the customizations in your environment, as described below.

## Re-create custom tables and other components

Some tables (entities) like **Accounts** and **Contacts** come out-of-the-box with Power Apps and Dynamics. For issues with custom tables, you can create similar ones in the vanilla environment. You don't have to copy the exact configuration. For example, if the issue is about a column (field) of the table, create just that column for the new table.

The same principle applies to any customization, like [business rules](/power-apps/maker/model-driven-apps/create-business-rules-recommendations-apply-logic-form), [commands](/power-apps/maker/model-driven-apps/command-designer-overview), [forms](/power-apps/maker/model-driven-apps/create-design-forms), and [views](/power-apps/maker/model-driven-apps/create-edit-views).

## Create sample data

A vanilla environment doesn't have data initially. You can manually add a few rows (records) for simple issues. You can also [add sample data for out-of-the-box tables](/power-platform/admin/add-remove-sample-data).

When the issue requires specific data to reproduce, prepare a *.csv* or Excel file and [import data with Microsoft Power Platform admin center](/power-platform/admin/import-data-all-record-types) or [import data in a model-driven app](/power-apps/user/import-data).

## Simplify developer customizations

Some advanced customizations require programming knowledge. These include [client scripts](/power-apps/developer/model-driven-apps/client-scripting), [code components](/power-apps/developer/component-framework/overview) (custom controls), [classic commands](/power-apps/maker/model-driven-apps/command-designer-overview), [plug-ins](/power-apps/developer/data-platform/plug-ins), and [web resources](/power-apps/developer/model-driven-apps/web-resources). If they are necessary to reproduce an issue, simplify them as much as possible. Remove irrelevant lines of code and references to third-party libraries.

## Isolate custom pages

Custom pages are just a special type of canvas app. You can [create a minimal repro canvas app](minimal-canvas-app-repro.md) to demonstrate issues with custom pages.

## Export the vanilla repro app

After verifying that an issue also exists in a vanilla environment, you can [create an unmanaged solution](/power-apps/maker/data-platform/create-solution) for the repro app.

It should include relevant customizations such as:

- the model-driven app, if it's not a standard Microsoft Dynamics app like Customer Service Hub or Sales Hub
- dashboards
- forms
- relationships
- tables
- views

You can then [export the vanilla repro app and any relevant customizations in an unmanaged solution](/power-apps/maker/data-platform/export-solutions).

To verify whether the necessary components have been included, [import the solution](/power-apps/maker/data-platform/import-update-export-solutions) in a different vanilla environment. Check whether the issue can be reproduced.

Sometimes, other materials are needed that can't be packaged in solutions. Here are some other things to include with the vanilla repro app.

### Provide sample data

Some issues require specific data to reproduce. Since data is not exported in a solution, provide a *.csv* or Excel file with the necessary data. Remember to remove any private and confidential data.

### Explain source code

Advanced customizations created with JavaScript and C# can be difficult to package in a solution. For example, [classic commands](/power-apps/maker/model-driven-apps/command-designer-overview) or [plug-ins](/power-apps/developer/data-platform/plug-ins).

It's easier to explain the problem by providing a copy of the source code and quoting the relevant lines of code. Mention which APIs are not working as expected.

### Describe complex customizations

If the customizations are complicated, it can be difficult for others to understand even if they have a vanilla repro app. It helps to describe how these customizations were made so that others can re-create them if they wish.

## What to do when an issue cannot be reproduced in a vanilla environment

The obvious question to ask is "why not?" In many cases, the difference is because of configuration. There's some missing factor not accounted for in the vanilla environment.

The fact that an issue does not happen in one environment is an important clue. By systematically examining different types of customizations, you can figure out the conditions that reproduce the problem.

Some reasons why a problem happens in one environment but not another:
* **[Customizations](isolate-model-app-issues.md#remove-customizations) are interfering with normal operation.** To confirm, add those customizations one by one to the vanilla environment or remove them from the problem environment.
* **Tables, relationships, and other components are configured differently.** To confirm, re-examine the differences between the same component in the vanilla and problem environment.
* **Components could be corrupted.** To confirm, re-create them in the problem environment.
* **User-specific reasons.** For example, some users have a different [security role](/power-platform/admin/security-roles-privileges) in one environment. To confirm, try alternative ways to access data or perform the same task. Dataverse tables can be accessed in many ways such as in model-driven apps, canvas apps, [Power Apps table designer](/power-apps/maker/canvas-apps/create-edit-tables), [Power Pages](/power-pages/introduction), and [Web API requests](/power-apps/developer/data-platform/webapi/query-data-web-api).
* **Different version.** The environment may be a different version or in a different geographical region. Check the **About** section in the app or [environment details in Power Platform admin center](/power-platform/admin/environments-overview#environment-details) for version details.
* **Issues with an environment's server.** To confirm, [examine network traffic](isolate-model-app-issues.md#find-out-if-the-issue-occurs-when-getting-data-or-showing-data) to determine if the server is sending the right information. Compare it with the network traffic of the vanilla environment.

## Next steps

- [Learn more about debugging strategies for model-driven apps](isolate-model-app-issues.md)
- [Ask a question with the Power Apps community](https://powerusers.microsoft.com/t5/Power-Apps-Community/ct-p/PowerApps1)
- [Get Microsoft Support](https://powerapps.microsoft.com/support/)

### See also

- [Debugging model-driven apps with Monitor](/power-apps/maker/monitor-modelapps)
