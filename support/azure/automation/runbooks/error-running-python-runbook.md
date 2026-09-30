---
title: Troubleshoot issues with Python packages in Azure Automation
description: Learn how to import, manage, and use Python packages in Azure Automation, and fix the runbook parameter length exceeded error. Get step-by-step guidance.
ms.date: 09/29/2026
ms.topic: troubleshooting
manager: dcscontentpm
author: kaushika-msft
ms.author: kaushika
ms.reviewer: adoyle, v-weizhu, kaushika
ms.service: azure-automation
ms.custom: sap:Runbook not working as expected
ai-usage: ai-assisted
---

# Troubleshoot issues with Python packages in Azure Automation

## Summary

This article shows how to import, manage, and use Python packages in Azure Automation running on the Azure sandbox environment and Hybrid Runbook Workers. For successful job execution, download Python packages on Hybrid Runbook Workers. To help simplify runbooks, use Python packages to import the modules you need.

> [!NOTE]
> Azure Automation enables the recovery of runbooks you deleted in the last 29 days. You can restore the deleted runbook by running a PowerShell script as a job in your Automation account. For more information, see [Restore deleted runbook](/azure/automation/manage-runbooks#restore-deleted-runbook).

## Import Python 2 packages

Follow these steps to import Python 2 packages into your Azure Automation account.

1. In your Automation account, select **Python packages** under **Shared Resources**. Select **+ Add a Python package**.
2. On the **Add Python Package** page, select a local package to upload. The package can be a **.whl** or **.tar.gz** file.
3. Enter the name and select the **Runtime version** as "2.x.x".
4. Select **Import**.

After you import a package, it appears on the **Python packages** page in your Automation account. To remove a package, select the package and then select **Delete**.

## Import packages with dependencies

Azure Automation doesn't resolve dependencies for Python packages during the import process. Use one of the following methods to import a package with all its dependencies.

### Method 1: Manual download

On a Windows 64-bit machine with Python 2.7 and the [package installer for Python (pip)](https://pip.pypa.io/en/stable/), download a package and all its dependencies by running the following command.

```console
C:\Python27\Scripts\pip2.7.exe download -d <output-directory> <package-name>
```

When you finish downloading the packages and all dependencies, import them into your Azure Automation account.

### Method 2: Use a runbook

To get a runbook, [import Python 2 packages from pypi into Azure Automation account](https://github.com/azureautomation/import-python-2-packages-from-pypi-into-azure-automation-account).

When you start the runbook, ensure the following conditions:

- The **Run on** option under **Run Settings** is set to **Azure**.
- You start the runbook with the following parameters, and each parameter is defined with a `switch`:
    - -s \<subscriptionId\>
    - -g \<resourceGroup\>
    - -a \<automationAccount\>
    - -m \<modulePackage\>
    The runbook lets you specify which package to download. For example, set the `-m` parameter to `Azure` to download all Azure modules and all dependencies (approximately 105 packages).
- The runbook requires a managed identity for the Azure Automation account to work.

After the runbook execution finishes, check the **Python packages** in **Shared Resources** of your Azure Automation account to verify that the runbook imported the package correctly.

## Default Python 3 packages

To support Python 3.8 runbooks in the Azure Automation service, the service installs some Python packages by default. For more information, see [Default Python packages](/azure/automation/default-python-packages). You can override the default version by importing Python packages into your Azure Automation account. Your Azure Automation account prefers the imported version. 

To import a single package, see [Import a Python 3 package](#import-a-python-3-package). To import a package with multiple packages, see [Import a Python 3 package with dependencies](#import-a-python-3-package-with-dependencies).

> [!NOTE]
> Python 3.10 (preview) doesn't have default packages installed.

## Import a Python 3 package

1. In your Azure Automation account, select **Python packages** in **Shared Resources**. Then, select **+ Add a Python package**.
2. On the **Add Python Package** page, select a local package to upload. The package can be a **.whl** or **.tar.gz** file for Python 3.8 and a **.whl** file for Python 3.10 (preview).
3. Enter a name and select the **Runtime Version** as Python 3.8 or Python 3.10 (preview).
4. Select **Import**.

After you import a package, it appears on the Python packages page in your Azure Automation account. To remove a package, select the package and then select **Delete**.

## Import a Python 3 package with dependencies

You can import a Python 3.8 package and its dependencies by importing the Python script [import_py3package_from_pypi.py](https://github.com/azureautomation/runbooks/blob/master/Utility/Python/import_py3package_from_pypi.py) into a Python 3.8 runbook. Ensure that you enable a managed identity for your Azure Automation account and that it has Azure Automation Contributor access to import the package successfully.

### Import the script into a runbook

For more information about importing a runbook, see [Import a runbook from the Azure portal](/azure/automation/manage-runbooks#import-a-runbook-from-the-azure-portal). Copy the file from GitHub to storage so that the [Azure portal](https://portal.azure.com) can access it before you run the import.

The **Import a runbook** page defaults the runbook name to match the name of the script. If you have access to the field, you can change the name. **Runbook type** might default to **Python 2.7**. If it does, make sure to change it to **Python 3.8**.

### Execute the runbook to import the package and dependencies

After creating and publishing the runbook, run it to import the package. For more information about executing a runbook, see [Start a runbook in Azure Automation](/azure/automation/start-runbooks).

The script (import_py3package_from_pypi.py) requires the following parameters.

|Parameter|Description|
|----|----|
|`subscription_id`|Subscription ID of the Azure Automation account|
|`resource_group`|Name of the resource group where the Azure Automation account is defined|
|`automation_account`|Azure Automation account name|
|`module_name`|Name of the module to import from *pypi.org*|
|`module_version`|Version of the module|

Provide parameter values as a single string in the following format.

`-s <subscription_id> -g <resource_group> -a<automation_account> -m <module_name> -v <module_version>`

## Scenario: Runbook fails with "Parameter length exceeded" error

Your runbook that uses those parameters fails with the following error.

> Total Length of Runbook Parameter names and values exceeds the limit of 30,000 characters. To avoid this issue, use Automation Variables to pass values to runbook.

### Cause

Python 2.7, Python 3.8, and PowerShell 7.1 runbooks have a limit on the total length of characters for all parameters provided. The total length of all parameter names and values can't exceed 30,000 characters.

### Resolution

To resolve this issue, use Azure Automation variables to pass values to the runbook or shorten parameter names and values so they don't exceed 30,000 characters in total.

## References

- [Manage modules in Azure Automation](/azure/automation/shared-resources/modules)
- [Runbook execution in Azure Automation](/azure/automation/automation-runbook-execution)
- [Manage Python 2 packages in Azure Automation](/azure/automation/python-packages)
- [Manage Python 3 packages in Azure Automation](/azure/automation/python-3-packages)
