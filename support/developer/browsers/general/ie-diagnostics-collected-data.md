---
title: Collected data by Internet Explorer Diagnostics
description: This article describes the information that may be collected from a computer when running Internet Explorer Diagnostics.
ms.date: 02/29/2020
ms.reviewer: louiss
---
# Collected information by Internet Explorer Diagnostics

[!INCLUDE [](../../../includes/browsers-important.md)]

This article lists the information that can be collected by running Internet Explorer Diagnostics.

_Original product version:_ &nbsp; Internet Explorer  
_Original KB number:_ &nbsp; 2547213

## System information

- Operating System
  - Machine Name
  - OS Name
  - Last Reboot/Uptime
  - AntiMalware
  - User Account Control
  - Username

- Computer System
  - Computer Model
  - Processor(s)
  - Machine Domain
  - Role

## Logs

### Environment Variables

|Name|Value|
|---|---|
|Elevated User:|{Computername}_EnvironmentVariables_MSDT.txt|
|Target User:|{Computername}_EnvironmentVariables_{Username}.txt|
  
### Event Logs

|Name|Value|
|---|---|
|Filtered Event Logs (.csv):|{Computername}_ApplicationLog.csv|
|Filtered Event Logs (.csv):|{Computername}_SystemLog.csv|
  
### Group Policy and IEAK

|Name|Value|
|---|---|
|IEAK Logs (.zip):|{Computername}_{Username}_IEAK_Brand.zip|
|HKU:|{Computername}_{Username}_HKU_Policies.TXT|
|HKLM Wow64:|{Computername}_reg_HKLM_Wow6432Node_Policies.TXT|
|HKLM:|{Computername}_reg_HKLM_Policies.TXT|
|HKU:|{Computername}_{Username}_HKU_GPHistory.TXT|
|HKLM:|{Computername}_reg_HKLM_GPHistory.TXT|
|HKLM Wow64:|{Computername}_reg_HKLM_Wow3264Node_GPHistory.TXT|
|HKLM:|{Computername}_reg_HKLM_GPExtensions.TXT|
|HKLM:|{Computername}_reg_HKLM_CurrentVersion_Polcies.TXT|
|HKLM Wow64:|{Computername}_reg_HKLM_Wow3264Node_CurrentVersion_Polcies.TXT|
|SysVol Package:|{Computername}_{Username}_IE_GP_SysVol.zip|
|SysVol Log:|{Computername}_{Username}_IE_GP_SysVol.txt|
|GP User (.txt):|{Computername}_GPResult_User_{Username}.txt|
|GP User (.htm):|{Computername}_GPResult_User_{Username}.htm|
|GP Computer (.txt):|{Computername}_GPResult_Computer.txt|
|GP Computer (.htm):|{Computername}_GPResult_Computer.htm|
  
### Internet Explorer Setup Log

|Name|Value|
|---|---|
| Internet Explorer Setup Log (.log):| {Computername}_IE9_main.log|
  
### Installed updates/hotfixes

|Name|Value|
|---|---|
|Update/Hotfix history:|{Computername}_Hotfixes.CSV|
|Update/Hotfix history:|{Computername}_Hotfixes.htm|
|Update/Hotfix history:|{Computername}_Hotfixes.TXT|
  
### Internet Explorer Core

|Name|Value|
|---|---|
|HKU:|{Computername}_{Username}_HKU_InternetExplorer.txt|
|HKU:|{Computername}_{Username}_HKU_InternetSettings.txt|
|HKU:|{Computername}_{Username}_HKU_FTP.txt|
|HKU:|{Computername}_{Username}_HKU_FeatureControl.|
|HKLM Wow64:|{Computername}_reg_HKLM_Wow6432Node_InternetExplorer.TXT|
|HKLM Wow64:|{Computername}_reg_HKLM_Wow6432Node_InternetSettings.TXT|
|HKLM Wow64:|{Computername}_reg_HKLM_Wow6432Node_FeatureControl.TXT|
|HKLM:|{Computername}_reg_HKLM_InternetSettings.TXT|
|HKLM:|{Computername}_reg_HKLM_FeatureControl.TXT|
  
### Internet Explorer File Versions

|Name|Value|
|---|---|
|Version Info:|{Computername}_IE_File_Version_Info.txt|
  
### Internet Explorer Zones

|Name|Value|
|---|---|
|HKU:|{Computername}_{Username}_HKU_Zones_ZoneMap.txt|
|HKU:|{Computername}_{Username}_HKU_Zones_0_YourComputer.txt|
|HKU:|{Computername}_{Username}_HKU_Zones_1_LocalIntranet.txt|
|HKU:|{Computername}_{Username}_HKU_Zones_2_TrustedSites.txt|
|HKU:|{Computername}_{Username}_HKU_Zones_3_Internet.txt|
|HKU:|{Computername}_{Username}_HKU_Zones_4_RestrictedSites.txt|
|HKU:|{Computername}_{Username}_HKU_LockedDown_Zones_0_YourComputer.txt|
|HKU:|{Computername}_{Username}_HKU_LockedDown_Zones_1_LocalIntranet.txt|
|HKU:|{Computername}_{Username}_HKU_LockedDown_Zones_2_TrustedSites.txt|
|HKU:|{Computername}_{Username}_HKU_LockedDown_Zones_3_Internet.txt|
|HKU:|{Computername}_{Username}_HKU_LockedDown_Zones_4_RestrictedSites.txt|
|HKLM Wow64:|{Computername}_reg_HKLM_Wow6432Node_Zones_ZoneMap.TXT|
|HKLM Wow64:|{Computername}_reg_HKLM_Wow6432Node_Zones_0_YourComputer.TXT|
|HKLM Wow64:|{Computername}_reg_HKLM_Wow6432Node_Zones_1_LocalIntranet.TXT|
|HKLM Wow64:|{Computername}_reg_HKLM_Wow6432Node_Zones_2_TrustedSites.TXT|
|HKLM Wow64:|{Computername}_reg_HKLM_Wow6432Node_Zones_3_Internet.TXT|
|HKLM Wow64:|{Computername}_reg_HKLM_Wow6432Node_Zones_4_RestrictedSites.TXT|
|HKLM Wow64:|{Computername}_reg_HKLM_Wow6432Node_LockedDown_Zones_0_YourComputer.TXT|
|HKLM Wow64:|{Computername}_reg_HKLM_Wow6432Node_LockedDown_Zones_1_LocalIntranet.TXT|
|HKLM Wow64:|{Computername}_reg_HKLM_Wow6432Node_LockedDown_Zones_2_TrustedSites.TXT|
|HKLM Wow64:|{Computername}_reg_HKLM_Wow6432Node_LockedDown_Zones_3_Internet.TXT|
|HKLM Wow64:|{Computername}_reg_HKLM_Wow6432Node_LockedDown_Zones_4_RestrictedSites.TXT|
|HKLM Wow64:|{Computername}_reg_HKLM_Wow6432Node_TemplatePolicies_High.TXT|
|HKLM Wow64:|{Computername}_reg_HKLM_Wow6432Node_TemplatePolicies_Low.TXT|
|HKLM Wow64:|{Computername}_reg_HKLM_Wow6432Node_TemplatePolicies_MedHigh.TXT|
|HKLM Wow64:|{Computername}_reg_HKLM_Wow6432Node_TemplatePolicies_Medium.TXT|
|HKLM Wow64:|{Computername}_reg_HKLM_Wow6432Node_TemplatePolicies_MedLow.TXT|
|HKLM:|{Computername}_reg_HKLM_Zones_ZoneMap.TXT|
|HKLM:|{Computername}_reg_HKLM_Zones_0_YourComputer.TXT|
|HKLM:|{Computername}_reg_HKLM_Zones_1_LocalIntranet.TXT|
|HKLM:|{Computername}_reg_HKLM_Zones_2_TrustedSites.TXT|
|HKLM:|{Computername}_reg_HKLM_Zones_3_Internet.TXT|
|HKLM:|{Computername}_reg_HKLM_Zones_4_RestrictedSites.TXT|
|HKLM:|{Computername}_reg_HKLM_LockedDown_Zones_0_YourComputer.TXT|
|HKLM:|{Computername}_reg_HKLM_LockedDown_Zones_1_LocalIntranet.TXT|
|HKLM:|{Computername}_reg_HKLM_LockedDown_Zones_2_TrustedSites.TXT|
|HKLM:|{Computername}_reg_HKLM_LockedDown_Zones_3_Internet.TXT|
|HKLM:|{Computername}_reg_HKLM_LockedDown_Zones_4_RestrictedSites.TXT|
|HKLM:|{Computername}_reg_HKLM_TemplatePolicies_High.TXT|
|HKLM:|{Computername}_reg_HKLM_TemplatePolicies_Low.TXT|
|HKLM:|{Computername}_reg_HKLM_TemplatePolicies_MedHigh.TXT|
|HKLM:|{Computername}_reg_HKLM_TemplatePolicies_Medium.TXT|
|HKLM:|{Computername}_reg_HKLM_TemplatePolicies_MedLow.TXT|
  
### Networking Information

|Name|Value|
|---|---|
|Host File:|{Computername}_hosts|
|TCP/IP Basic Information:|{Computername}_TcpIp-Info.txt|
|SMB Basic Information:|{Computername}_SMB-Info.txt|
  
### Operating System Registry

|Name|Value|
|---|---|
|HKU:|{Computername}_{Username}_HKU_ActiveSetup_All.txt|
|HKU Wow64:|{Computername}_{Username}_HKU_ActiveSetup_ALL_Wow6432Node.txt|
|HKU:|{Computername}_{Username}_HKU_Wintrust.txt|
|HKU:|{Computername}_{Username}_HKU_Ext_Settings.txt|
|HKLM Wow64:|{Computername}_reg_HKLM_Wow6432Node_ActiveSetup_All.TXT|
|HKLM:|{Computername}_reg_HKLM_Wow6432Node_ActiveX_Compatibility.TXT|
|HKLM:|{Computername}_reg_HKLM_ActiveSetup_All.TXT|
|HKLM:|{Computername}_reg_HKLM_ActiveX_Compatibility.TXT|
|HKLM:|{Computername}_reg_HKLM_Wow6432Node_Classes_Protocols.TXT|
|HKLM:|{Computername}_reg_HKLM_Wow6432Node_Code_Store_Database.TXT|
|HKLM:|{Computername}_reg_HKLM_Wow6432Node_Ext_PreApproved.TXT|
|HKLM:|{Computername}_reg_HKLM_Classes_Mime_Database_Content_Type.TXT|
|HKLM:|{Computername}_reg_HKLM_Classes_Protocols.TXT|
|HKLM:|{Computername}_reg_HKLM_SecurityProviders.TXT|
|HKLM:|{Computername}_reg_HKLM_AEDebug.TXT|
|HKLM:|{Computername}_reg_HKLM_Image_File_Execution_Options.TXT|
|HKLM:|{Computername}_reg_HKLM_Fips_Algorithm_Policy.TXT|
|HKLM:|{Computername}_reg_HKLM_KERB_MaxTokenSize.TXT|
|HKLM:|{Computername}_reg_HKLM_SSL_Ciphers.TXT|
|HKLM:|{Computername}_reg_HKLM_Code_Store_Database.TXT|
|HKLM:|{Computername}_reg_HKLM_Ext_PreApproved.TXT|
  
### REG Export

|Name|Value|
|---|---|
|HKU:|{Computername}_{Username}_HKU_Internet_Explorer.REG.txt|
|HKU:|{Computername}_{Username}_HKU_Internet_Settings.REG.txt|
|HKU:|{Computername}_{Username}_HKU_Policies.REG.txt|
|HKLM:|{Computername}_{Username}_HKU_Classes.REG.txt|
|HKLM:|{Computername}_HKLM_Internet_Explorer.REG.txt|
|HKLM:|{Computername}_HKLM_Internet_Settings.REG.txt|
|HKLM:|{Computername}_HKLM_Policies.REG.txt|
|HKLM Wow64:|{Computername}_HKLM_Wow6432Node_Internet_Explorer.REG.txt|
|HKLM Wow64:|{Computername}_HKLM_Wow6432Node_Internet_Settings.REG.txt|
|HKLM Wow64:|{Computername}_HKLM_Wow6432Node_Policies.REG.txt|
|HKLM Wow64:|{Computername}_HKLM_Wow6432Node_Classes.REG.txt|
  
### Registry - IEAK

|Name|Value|
|---|---|
|HKLM Wow64:|{Computername}_reg_HKLM_Wow6432Node_IEAK.TXT|
  
### Windows Setup API Logs

|Name|Value|
|---|---|
|Windows Setup API Log:|{Computername}_SetupAPI.app.Log|
  
### Windows update log

|Name|Value|
|---|---|
|Windows Update Log File:|{Computername}_WindowsUpdate.log|
  