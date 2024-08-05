---
title: Reporting installation or upgrade fails with error 0xffffffff
description: Error 0xffffffff occurs when installing or upgrading to System Center 2012 Operations Manager Reporting.
ms.date: 04/15/2024
---
# Installation or upgrade of System Center 2012 Operations Manager Reporting fails with error 0xffffffff

This article provides a resolution to solve the error 0xffffffff that occurs during the installation or upgrade of System Center 2012 Operations Manager Reporting.

_Original product version:_ &nbsp; System Center 2012 Operations Manager, System Center 2012 R2 Operations Manager  
_Original KB number:_ &nbsp; 2771907

## Symptoms

When installing or upgrading to System Center 2012 Operations Manager Reporting, a failure may occur and this error is logged in OMReporting.log:

> ExecNetFx: Error: The specified assembly is not installed.  
> ExecNetFx: Error 0xffffffff: Command line returned an error.  
> ExecNetFx: failed to execute Ngen command (with error 0xffffffff): C:\Windows\Microsoft.NET\Framework64\v4.0.30319\ngen.exe uninstall "Microsoft.EnterpriseManagement.Core, Version=7.0.5000.0, Culture=neutral, PublicKeyToken=31BF3856AD364E35", continuing anyway

In addition, OMReporting.log may show the following:

> Error: :Application Monitoring reports publishing failed.: Threw Exception.Type:  
System.Web.Services.Protocols.SoapException, Exception Error Code: 0x80131501, Exception.Message: System.Web.Services.Protocols.SoapException: There is an error on line 45 of custom code: [BC30002] Type 'Microsoft.EnterpriseManagement.Presentation.Util.AntiXssEncoder' is not defined.  
> at Microsoft.ReportingServices.WebServer.ReportingService2005Impl.CreateReport(String Report, String Parent, Boolean Overwrite, Byte[] Definition, Property[] Properties, Warning[]& Warnings)  
> at Microsoft.ReportingServices.WebServer.ReportingService2005.CreateReport(String Report, String Parent, Boolean Overwrite, Byte[] Definition, Property[] Properties, Warning[]& Warnings)  
> Error: :StackTrace: at System.Web.Services.Protocols.SoapHttpClientProtocol.ReadResponse(SoapClientMessage message, WebResponse response, Stream responseStream, Boolean asyncCall)  
> at System.Web.Services.Protocols.SoapHttpClientProtocol.Invoke(String methodName, Object[] parameters)  
> at Microsoft.Reporting.Setup.ReportService.ReportingService2005.CreateReport(String Report, String Parent, Boolean Overwrite, Byte[] Definition, Property[] Properties)
> at Microsoft.EnterpriseManagement.OperationsManager.Setup.ReportServices.ApplicationDiagnostics.ReportManager.PublishReport(FileInfo reportFile, String parent)  
> at Microsoft.EnterpriseManagement.OperationsManager.Setup.ReportServices.ApplicationDiagnostics.ReportManager.PublishReports(DirectoryParameter directoryParam)  
> at Microsoft.EnterpriseManagement.OperationsManager.Setup.ReportServices.ApplicationDiagnostics.ReportManager.RunActionForDirectory(Predicate\`1 action, DirectoryInfo directory, String currentPath)  
> at Microsoft.SystemCenter.Essentials.SetupFramework.InstallItemsDelegates.OMReportingProcessor.PublishAppDiagnosticsReports()  
> Error: :Error:Publishing App Diagnostics Reports failed.  
> Error: :FATAL ACTION: ConfigureReportingForInstall

## Cause

This can occur if assembly `Microsoft.EnterpriseManagement.Reporting.Code` is present in `C:\Windows\Assembly`.

## Resolution

To resolve this issue, complete the steps below:

1. Navigate to `C:\Windows\Assembly`.
2. Find `Microsoft.EnterpriseManagement.Reporting.Code`.
3. Right-click it and select **Uninstall**.
4. Restart the server and run the Reporting installation again. This time it should succeed.
