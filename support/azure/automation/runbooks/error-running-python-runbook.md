---
title: Troubleshoot issues with python packages in Azure Automation
description: Describes how to import, manage, and use Python packages in Azure Automation and provides a solution to an issue with python packages.
ms.date: 06/20/2025
ms.reviewer: adoyle, v-weizhu
ms.service: azure-automation
ms.custom: sap:Runbook not working as expected
---
# Troubleshoot issues with python packages in Azure Automation

The article shows how to import, manage, and use Python packages in Azure Automation running on the Azure sandbox environment and Hybrid Runbook Workers. Python packages should be downloaded on Hybrid Runbook workers for successful job execution. To help simplify runbooks, you can use Python packages to import the modules you need.

> [!NOTE]
> Azure Automation enables recovery of runbooks deleted in the last 29 days - Restore the deleted runbook by running a PowerShell script as a job in your Automation account. See [Restore deleted runbook](/azure/automation/manage-runbooks#restore-deleted-runbook) for more information.

## Import Python 2 packages

1. In your Automation account, select **Python packages** under **Shared Resources**. Select **+ Add a Python package**.

2. On the **Add Python Package** page, select a local package to upload. The package can be a **.whl** or **.tar.gz** file.

3. Enter the name and select the **Runtime version** as "2.x.x".

4. Select **Import**.

After a package is imported, it's listed on the **Python packages** page in your Automation account. To remove a package, select the package and select **Delete**.

## Import packages with dependencies

Azure Automation doesn't resolve dependencies for Python packages during the import process. Use one of the following two methods to import a package with all its dependencies.

### Method 1: Manually download

On a Windows 64-bit machine with Python 2.7 and the [package installer for Python (pip)](https://pip.pypa.io/en/stable/), download a package and all its dependencies by running the following command:

```console
C:\Python27\Scripts\pip2.7.exe download -d <output-directory> <package-name>
```

Once the packages and all its dependencies are downloaded, you can import them into your Automation account.

#### Method 2: Use a runbook

To get a runbook, [import Python 2 packages from pypi into Azure Automation account](https://github.com/azureautomation/import-python-2-packages-from-pypi-into-azure-automation-account).

When you start the runbook, ensure the following things:

- The **Run on** option under **Run Settings** is set to **Azure**.
- The runbook is started with the following parameters and each parameter is defined with a `switch`.

    - -s \<subscriptionId\>
    - -g \<resourceGroup\>
    - -a \<automationAccount\>
    - -m \<modulePackage\>

    The runbook allows you to specify what package to download. For example, set the `-m` parameter to `Azure` to downloads all Azure modules and all dependencies (approximately 105 packages).
- The runbook requires a managed identity for the Automation account to work.

After the runbook execution is complete, you can check the **Python packages** under **Shared Resources** in your Automation account to verify that the package is imported correctly.

## Default Python 3 packages

To support Python 3.8 runbooks in the Automation service, some Python packages are installed by default. For more information, see [Default Python packages](/azure/automation/default-python-packages). The default version can be overridden by importing Python packages into your Automation account. The imported version is preferred in your Automation account. To import a single package, see [Import a Python 3 package](#import-a-python-3-package). To import a package with multiple packages, see [Import a Python 3 package with dependencies](#import-a-python-3-package-with-dependencies).

> [!NOTE]
> There are no default packages installed for Python 3.10 (preview).

## Import a Python 3 package

1. In your Automation account, select **Python packages** under **Shared Resources**. Then select **+ Add a Python package**.

2. On the **Add Python Package** page, select a local package to upload. The package can be a **.whl** or **.tar.gz** file for Python 3.8 and a **.whl** file for Python 3.10 (preview).

3. Type a name and select the **Runtime Version** as Python 3.8 or Python 3.10 (preview).

4. Select **Import**.

After a package is imported, it's listed on the Python packages page in your Automation account. To remove a package, select the package and select **Delete**.

## Import a Python 3 package with dependencies

You can import a Python 3.8 package and its dependencies by importing the Python script [import_py3package_from_pypi.py](https://github.com/azureautomation/runbooks/blob/master/Utility/Python/import_py3package_from_pypi.py) into a Python 3.8 runbook. Ensure that a managed identity is enabled for your Automation account and has Automation Contributor access to import the package successfully.

### Import the script into a runbook

For more information about importing the runbook, see [Import a runbook from the Azure portal](/azure/automation/manage-runbooks#import-a-runbook-from-the-azure-portal). Copy the file from GitHub to a storage that the Azure portal can access before you run the import.

The **Import a runbook** page defaults the runbook name to match the name of the script. If you have access to the field, you can change the name. **Runbook type** might default to **Python 2.7**. If it does, make sure to change it to **Python 3.8**.

### Execute the runbook to import the package and dependencies

After creating and publishing the runbook, run it to import the package. For more information about executing a runbook, see [Start a runbook in Azure Automation](/azure/automation/start-runbooks).

The script (import_py3package_from_pypi.py) requires the following parameters.

|Parameter|Description|
|----|----|
|`subscription_id`|Subscription ID of the Automation account|
|`resource_group`|Name of the resource group where the Automation account is defined|
|`automation_account`|Automation account name|
|`module_name`|Name of the module to import from *pypi.org*|
|`module_version`|Version of the module|

Parameter value should be provided as a single string in the following format:

-s <subscription_id> -g <resource_group> -a<automation_account> -m <module_name> -v <module_version>

## Scenario: Runbook fails with "Parameter length exceeded" error

Your runbook that uses those parameters fails with the following error:

> Total Length of Runbook Parameter names and values exceeds the limit of 30,000 characters. To avoid this issue, use Automation Variables to pass values to runbook.

**Cause:**

Python 2.7, Python 3.8, and PowerShell 7.1 runbooks have a limit on the total length of characters for all parameters provided. The total length of all parameter names and values can't exceed 30,000 characters.

**Resolution:**

To resolve this issue, use Azure Automation Variables to pass values to the runbook or shorten parameter names and values so they don't exceed 30,000 characters in total.

## Reference

- [Manage modules in Azure Automation](/azure/automation/shared-resources/modules)
- [Runbook execution in Azure Automation](/azure/automation/automation-runbook-execution)
- [Manage Python 2 packages in Azure Automation](/azure/automation/python-packages)
- [Manage Python 3 packages in Azure Automation](/azure/automation/python-3-packages)