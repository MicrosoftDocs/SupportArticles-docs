---
title: Configuration Manager console stops responding 
description: Describes an issue in which the Configuration Manager console appears to stop responding while it's loading a list of drivers from the driver catalog.
ms.date: 12/05/2023
ms.reviewer: kaushika, jchornbe
---
# Configuration Manager console appears to hang when you add a driver to a boot image

This article helps you resolve an issue where the Configuration Manager console appears to stop responding while it's loading a list of drivers from the driver catalog.

_Original product version:_ &nbsp; Microsoft System Center 2012 Configuration Manager, Microsoft System Center 2012 R2 Configuration Manager  
_Original KB number:_ &nbsp; 3070057

## Symptoms

When you add a driver on the **Drivers** tab of the properties of a boot image, the Configuration Manager console may appear to hang or stop responding while it's loading the list of drivers from the driver catalog. For example, in an environment that has 500 drivers, the console may appear to stop responding for up to 8 minutes. However, the exact number of drivers and length of delay will vary, depending on system performance.

During this time, a review of the Smsprov.log file on the site server shows that Configuration Manager is in fact enumerating through the available drivers:

> CExtUserContext::EnterThread : User=\<DOMAIN\user> Sid=0x010500000:-000000515XXXXCEBFCF270C2XXXXC3CAFFF0 Caching IWbemContextPtr=0000008DEF086000 in Process 0x1534 (5428)  
> Context: SMSAppName=Configuration Manager Administrator console  
> Context: MachineName=\<siteserver.fqdn>  
> Context: UserName==\<DOMAIN\user>  
> Context: ObjectLockContext=796d1f9e-3512-4fd4-ae23-11cbe5883fda  
> Context: ApplicationName=Microsoft.ConfigurationManagement.exe  
> Context: ApplicationVersion=5.0.8239.1000  
> Context: LocaleID=MS\0x409  
> Context: __ProviderArchitecture=32  
> Context: \__RequiredArchitecture=0 (Bool)  
> Context: __ClientPreferredLanguages=en-US,en  
> Context: __CorrelationId={3ACC714D-97FE-0005-897C-CC3AFE97D001}  
> Context: __GroupOperationId=181360  
> CExtUserContext : Set ThreadLocaleID OK to: 1033  
> CSspClassManager::PreCallAction, dbname=CM_392  
> ExecQueryAsync: START select FromCIID from SMS_CIRelation where ToCIID =16777966 AND RelationType=5  
> Adding Handle -346430696 to async call map  
> CExtProviderClassObject::DoCreateInstanceEnumAsync (SMS_CIRelation)  
> CSspQueryForObject :: Execute...  
> Execute WQL =select FromCIID from SMS_CIRelation where ToCIID =16777966 AND RelationType=5  
> Execute SQL =select all SMS_CIRelation.FromCIID from vSMS_CIRelation AS SMS_CIRelation where (SMS_CIRelation.ToCIID = 16777966 AND SMS_CIRelation.RelationType = 5)  
> Results returned : 0 of 1  
> Removing Handle -346430696 from async call map  
> ExecQueryAsync: COMPLETE select FromCIID from SMS_CIRelation where ToCIID =16777966 AND RelationType=5  
> CExtUserContext::LeaveThread : Releasing IWbemContextPtr=-284663808

## Cause

This issue occurs because of the time that is required to enumerate the available drivers.

## Resolution

Depending on the number of drivers and on individual system performance, the operation may eventually complete successfully. However, to avoid the issue, consider creating additional folders to store your drivers. By doing this, you can reduce the number of drivers that are being enumerated in a single folder view.

The following workarounds are also available:

- In the **Operating Systems\Drivers** node, select the driver to be added, right-click the driver, select **Edit**, select **Boot Images**, and then specify the boot image to which the selected driver is to be added.
- During import or reimport of the driver into the driver catalog, add the driver to the necessary boot image at that time.
- Add the driver to the boot image by using the [Set-CMDriverBootImage](/previous-versions/system-center/powershell/system-center-2012-r2/jj821905(v=sc.20)?redirectedfrom=MSDN) Windows PowerShell cmdlet.
- Use [DISM](/previous-versions/windows/it-pro/windows-8.1-and-8/dn613857(v=win.10)?redirectedfrom=MSDN) to manually add the driver to the boot image.
