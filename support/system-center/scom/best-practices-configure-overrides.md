---
title: Best practices to configure overrides
description: Describes a list of best practices to use when you configure overrides in System Center Operations Manager.
ms.date: 04/15/2024
ms.reviewer: antoniha, v-jomcc
---
# Best practices for configuring overrides in Operations Manager

This article contains a list of best practices to use when you configure overrides in Microsoft System Center Operations Manager.

_Original product version:_ &nbsp; System Center 2012 Operations Manager  
_Original KB number:_ &nbsp; 943239

## Store overrides in a separate management pack

For each management pack that you use in Operations Manager, create an additional management pack in which to store overrides. For example, after you import the Active Directory management pack, create an Active Directory Override management pack. Then, store any overrides that you configure for the Active Directory management pack objects in the Active Directory Override management pack.

## Don't use the Disable command to disable a management pack object

When you want to disable a management pack object, don't use the **Disable the ObjectName** command on the **Overrides** menu. Instead, select the **Override** option to override the object. Then, follow these steps:

1. In the **Override Properties** dialog box, select the **Override** check box that corresponds to the **Enabled** parameter.
2. In the **Override Setting** column, select **False**.
3. In the **Select destination management pack** list, select the appropriate management pack in which to store the override.

> [!NOTE]
> This method lets you specify a management pack in which to create the override.

## Set an overridden parameter for every rule and monitor that uses the parameter

When you override a parameter, make sure that the parameter is configured for each rule that uses the parameter and for each monitor that uses the parameter. There may be more than one rule or monitor that uses the particular parameter.

For example, the following rules and monitors use the **Intersite Expected Max Latency** parameter:

Monitors

- AD Replication Monitoring

Rules

- AD Replication Performance Collection - Metric Replication Latency
- AD Replication Performance Collection - Metric Replication Latency: Maximum
- AD Replication Performance Collection - Metric Replication Latency: Minimum
- AD Replication Performance Collection - Metric Replication Latency: Average

## Configure overrides for groups instead of for specific instances

We recommend that you configure an override for a group instead of using an override to target a specific instance. Configuring overrides for groups allows for better manageability than what is available if you target a specific instance. To configure an override for a group, follow these steps:

1. Create a group that has the following characteristics:

   - Create the group in the appropriate overrides management pack.
   - Configure the group to contain the particular instances or formulas that target the instances that you want to override.

   For example, create a group that's named *AD DC 2003 Role*. Then, manually put instances of the **AD Domain Controller 2003 Role** objects into the *AD DC 2003 Role* group.

2. Select the **For a group** command on the submenu of the **Overrides** menu.
3. In the **Select Object** dialog box that appears, select the new group that you created.

## Test overrides in a test environment

You can test overrides in one environment and then apply the overrides to another environment. For example, you can test an override in a test environment and then implement the override in a production environment. To do this, follow these steps:

1. Create the test groups in the appropriate override management pack.
2. Add the appropriate instances from the test environment to the test groups. You can explicitly specify the instances. Or, you can use a formula to specify the instances.
3. Perform sufficient testing to validate the override.
4. Export the particular management pack from the test environment.
5. Import the override management pack into the production environment.
6. Populate the groups that are contained in the override management pack by using the appropriate instances from the production environment.
