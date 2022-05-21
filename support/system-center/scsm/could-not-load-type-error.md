---
title: Could not load type error
description: Fixes an issue where you get the Could not load type error when you try to create an Exchange Connector in System Center 2016 Service Manager.
ms.date: 08/03/2020
ms.reviewer: austinm, luche
---
# Could not load type error when creating an Exchange Connector in System Center 2016 Service Manager

This article helps you fix an issue where you get the **Could not load type** error when you try to create an Exchange Connector in System Center 2016 Service Manager.

_Original product version:_ &nbsp; System Center 2016 Service Manager  
_Original KB number:_ &nbsp; 4089862

## Symptoms

Assume that you try to create an Exchange Connector in System Center 2016 Service Manager. After you enter the credentials for the RunAs account, the connector isn't created, and the following entry is recorded in the Application event log:

> Application: System Center Service Manager  
> Application Version: 7.5.7487.0  
> Severity: Error  
>
> Message: Could not load type 'Microsoft.EnterpriseManagement.ServiceManager.UI.Administration.Administration' from assembly 'Microsoft.EnterpriseManagement.ServiceManager.UI.Administration , Version=7.0.5000.0, Culture=neutral, PublicKeyToken=\<Token>'.
>
> System.TypeLoadException: Could not load type 'Microsoft.EnterpriseManagement.ServiceManager.UI.Administration.Administration' from assembly 'Microsoft.EnterpriseManagement.ServiceManager.UI.Administration, Version=7.0.5000.0, Culture=neutral, PublicKeyToken=\<Token>'.
>  
> at Microsoft.EnterpriseManagement.UI.SdkDataAccess.ConsoleTaskHandler.DoTask(IList\`1 navigationNodes, NavigationModelNodeTask task, List\`1 parameterList)
>
> at Microsoft.EnterpriseManagement.UI.SdkDataAccess.ConsoleTaskHandler.DoTask(IList\`1 navigationNodes, NavigationModelNodeTask task)

## Cause

This issue occurs because the **Microsoft.SystemCenter.ExchangeConnector.dll** file that Service Manager is looking for isn't present.

Service Manager update rollups are cumulative. However, the Exchange Connector isn't part of the update rollups.

## Resolution

After you install Exchange Connector 3.1, install **Microsoft.SystemCenter.ExchangeConnector.dll.exe**.

> [!NOTE]
> This file isn't part of Update Rollup 2 for System Center 2016 Service Manager.

1. Go to [Microsoft.SystemCenter.ExchangeConnector.dll.exe](https://www.microsoft.com/download/details.aspx?id=54655&751be11f-ede8-5a0c-058c-2ee190a24fa6=True&fa43d42b-25b5-4a42-fe9b-1634f450f5ee=True), and select **Download**.
2. Select the **Microsoft.SystemCenter.ExchangeConnector.dll.exe** check box.
3. Select **Next**.
4. Select **Save As** and save the file to your system.
5. Double-click the **Microsoft.SystemCenter.ExchangeConnector.dll.exe** file and follow the instructions to install the **Microsoft.SystemCenter.ExchangeConnector.dll** file. This file should be saved in your Service Manager installation path.

> [!NOTE]
> After you install **Microsoft.SystemCenter.ExchangeConnector.dll**, the version number of the file will be **7.5.2017.19**.

## More information

To determine the version of the Exchange Connector 3.1 files that are installed, run the following PowerShell script:

```powershell
push-location;
$SMFolder = (Get-ItemProperty "HKLM:\SOFTWARE\Microsoft\System Center\2010\Service Manager\Setup").InstallDirectory; CD $SMFolder;
Dir Microsoft.Exchange.Webservices.dll,Microsoft.SystemCenter.ExchangeConnector.dll,Microsoft.SystemCenter.ExchangeConnector.resources.dll | FT @{Label="FileVersion";
Expression={$_.Versioninfo.FileVersion}}, length, name -autosize;
Pop-Location;
```

The following is an example of the output of the script:

> |FileVersion|Length|Name|
> |---|---|---|
> |14.03.0067.001|830488|Microsoft.Exchange.Webservices.dll|
> |7.5.2017.19|277184|Microsoft.SystemCenter.ExchangeConnector.dll|
> |7.5.2017.18|56000|Microsoft.SystemCenter.ExchangeConnector.resources.dll|

> [!NOTE]
> Update Rollup 2 for System Center Service Manager 2016 and later versions need version **7.5.2017.19** or a later version of the **Microsoft.SystemCenter.ExchangeConnector.dll** file.
