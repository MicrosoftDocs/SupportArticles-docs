---
title: Can't install Reporting Services in System Center Operations Manager
description: Troubleshoot the error, Data Reader account provided is not same, which occurs when installing Reporting Services in System Center Operations Manager.
ms.reviewer: blakedrumm, luisferreira, alexkre, jarrettr, msadoff
ms.date: 09/26/2022
---
# "Data Reader account provided is not same" error when installing Reporting Services

_Applies to:_ &nbsp; System Center Operations Manager

## Symptoms

When you try to install Reporting Services in System Center Operations Manager, you receive the following error message:

> Data Reader account provided is not same as that in the management group.

## Cause

This issue occurs because there's misconfiguration of the **Data Warehouse Report Deployment Account** and **Data Warehouse Account** Run As profiles, which causes problems with data warehouse workflows. Data Warehouse maintenance and running of reports will fail if the default action account doesn't have the necessary SQL Server permissions.

## Resolution

To fix the issue, reconfigure the profiles as follows. You can also [reconfigure profiles by using PowerShell automatically](#reconfigure-profiles-using-powershell-automatically).

### Step 1: Data Warehouse Report Deployment Account profile

Set the Data Warehouse Report Deployment account to be used for the following classes:

- `Collection Server`
- `Data Warehouse Synchronization Server`

:::image type="content" source="media/reporting-services-installation-fails/data-warehouse-report-deployment-account-profile.png" alt-text="Screenshot shows the configuration of the Data Warehouse Report Deployment account.":::

### Step 2: Data Warehouse Account profile

Set the Data Warehouse Action account to be used for the following classes:

- `Collection Server`
- `Data Warehouse Synchronization Server`
- `Data Set`
- `Operations Manager APM Data Transfer Service`

:::image type="content" source="media/reporting-services-installation-fails/data-warehouse-action-account-profile.png" alt-text="Screenshot shows the configuration of the Data Warehouse Action account.":::

After the reconfiguration, you can install Reporting Services successfully by using the Data Warehouse Report Deployment account.

> [!NOTE]
> If the issue remains, verify the permissions of the System Center Operations Manager databases (**OperationsManager** and **OperationsManagerDW**) are set correctly.

### Reconfigure profiles using PowerShell automatically

> [!TIP]
> Before running the following PowerShell script, we suggest removing all Run As accounts from the **Data Warehouse Report Deployment Account** and **Data Warehouse Account** Run As profiles.

```powershell
function Invoke-TimeStamp
{
    $TimeStamp = (Get-Date).DateTime
    return "$TimeStamp - "
}
Write-Host "`n`n------------------------------------------------------------" -ForegroundColor Green
#Associate Run As Account association in Data Warehouse and Report Deployment Run As Profile.
Write-Output "$(Invoke-TimeStamp)Script started"

Import-Module OperationsManager

#Get the run as profiles
$DWActionAccountProfile = Get-SCOMRunAsProfile -DisplayName "Data Warehouse Account"
$ReportDeploymentProfile = Get-SCOMRunAsProfile -DisplayName "Data Warehouse Report Deployment Account"

#Get the run as accounts
$DWActionAccount = Get-SCOMrunAsAccount -Name "Data Warehouse Action Account"
$DWReportDeploymentAccount = Get-SCOMrunAsAccount -Name "Data Warehouse Report Deployment Account"

#Get all the required classes
$CollectionServerClass = Get-SCOMClass -DisplayName "Collection Server"
$DataSetClass = Get-SCOMClass -DisplayName "Data Set"
$APMClass = Get-SCOMClass -DisplayName "Operations Manager APM Data Transfer Service"
$DWSyncClass = Get-SCOMClass -DisplayName "Data Warehouse Synchronization Server"

#Setting the association
Write-Output "$(Invoke-TimeStamp)Setting the Run As Account Association for Data Warehouse Account Profile"
try
{
    Set-SCOMRunAsProfile -ErrorAction Stop -Action "Add" -Profile $DWActionAccountProfile -Account $DWActionAccount -Class $CollectionServerClass, $DataSetClass, $APMClass, $DWSyncClass
    Write-Output "$(Invoke-TimeStamp)   Completed Successfully!"
}
catch
{
    Write-Output "$(Invoke-TimeStamp)   Unable to set the RunAs accounts, try removing all accounts from inside the RunAs Profile (`"Data Warehouse Account`"), and run the script again.`n"
}
Write-Output "$(Invoke-TimeStamp)Setting the Run As Account Association for Data Warehouse Report Deployment Account Profile"
try
{
    Set-SCOMRunAsProfile -ErrorAction Stop -Action "Add" -Profile $ReportDeploymentProfile -Account $DWReportDeploymentAccount -Class $CollectionServerClass, $DWSyncClass
    Write-Output "$(Invoke-TimeStamp)   Completed Successfully!"
}
catch
{
    Write-Output "$(Invoke-TimeStamp)   Unable to set the RunAs accounts, try removing all accounts from inside the RunAs Profile (`"Data Warehouse Report Deployment Account`"), and run the script again."
}

Write-Output "$(Invoke-TimeStamp)Script ended"
Write-Host '------------------------------------------------------------' -ForegroundColor Green
```
