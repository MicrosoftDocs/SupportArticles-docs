---
title: (Class not registered) error when updating PowerPivot data
ms.author: luche
author: helenclu
manager: dcscontentpm
ms.date: 1/12/2021
audience: Admin
ms.topic: article
ms.prod: office-perpetual-itpro
localization_priority: Normal
search.appverid:
- SPO160
- MET150
appliesto:
- Excel M365
- Excel 2019
- Excel 2016
- Excel 2013
ms.custom: 
- CI 126342
- CSSTroubleshoot 
ms.reviewer: MS aliases for tech reviewers and CI requestor, without "@microsoft.com".  
description: 'Describes how to resolve the "Class not registered" error when updating data in an Excel PowerPivot workbook.'
---

# Error message: "Class not registered" when you update PowerPivot data

## Symptoms

You see the following errors when trying to update data in a PowerPivot workbook that was authored on a different computer:

> The provider \<Provider name> is not registered.<br />
> The following system error occurred: Class not registered  A connection could not be made to the data source with the DataSourceID of \<data source id>', Name of \<data source name>. An error occurred while processing the \<table name>. The provider \<Provider name> is not registered.<br />
> The operation has been cancelled.


> [!note]
> The error may be repeated for each connection that fails.

## Cause

This issue generally occurs under the following scenarios:

- You try to update the data with the most current data from the back-end server by using the **Refresh All** option in the **Refresh** menu.
- You try to import data by using one of the connections under the **Existing Connection** option in the **Design** tab.

This behavior is by design. It occurs when the provider that is defined for the data connection for PowerPivot data doesn't exist on your system.

## Resolution

To resolve the problem, use one of the following procedures.

### Procedure 1: Configure the failing connection to use a different and compatible provider that exists on your system

To do this, follow these steps:

1. In the Power Pivot Window, select the **Design** tab in the ribbon menu.
2. Select **Existing Connections**.
3. From the list of available connections, select the connection that is failing, and then select **Edit**.
4. In the **Edit Connection** window, select **Advanced**.
5. In the **Set Advanced Properties** area, change the **Provider** value to a different and compatible provider, and then update the data.

For example, if the connection is configured to use SQLNCLI10 (SQL Native Client 10 Provider), and if SQL Native client is not installed on your system, change the provider to SQLOLEDB, and then update the data in the workbook.

### Procedure 2: Install the provider

1. Identify the provider that is used for the failing connection. To do this, use the information in the error message or the steps that are documented in [Procedure 1](#procedure-1-configure-the-failing-connection-to-use-a-different-and-compatible-provider-that-exists-on-your-system) to identify the provider.
2. Install that provider on your system by using the installation media or by downloading the provider from the Internet.

## More information

You may also see a similar error message when you use a 32-bit system to work with a workbook that was developed on a 64-bit system. And, there is no 32-bit provider that is available for one or more of the connections that are defined in your workbook, or the 32-bit provider is not installed on your system, or vice-versa.

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).
