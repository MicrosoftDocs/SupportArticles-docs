---
title: Can't restore a SharePoint default.aspx file
description: Describes a behavior in which you can't restore a SharePoint default.aspx file by using Data Protection Manager.
ms.date: 04/08/2024
ms.reviewer: Mjacquet, msadoff
---
# Restoring a SharePoint default.aspx file fails with Invalid Pointer (0x80004003) error

This article describes an unsupported scenario in which you receive **Invalid Pointer (0x80004003)** error when restoring a SharePoint default.aspx file in Data Protection Manager (DPM).

_Original product version:_ &nbsp; System Center Data Protection Manager  
_Original KB number:_ &nbsp; 2851583

## Summary

When you try to restore a SharePoint default.aspx file using Data Protection Manager, the restore operation fails.

## Cause

This occurs because default.aspx is placed in the root of the website when a site collection is created, and files at the website root cannot be restored using the DPM Item Level Recovery (ILR) feature. This is an unsupported scenario as DPM only supports Item Level Recovery for files in SharePoint document lists. Microsoft is evaluating this for change in future releases.

## More information

When the failure occurs, the **Monitoring** view in the DPM console contains alerts that are similar to the following:

> Warning:  
Affected area: Sharepoint Farm\MOSS\SharePoint\SharePoint_Config_0952a7dc-acec-4f1d-94b5-98b1b7738136  
Occurred since: \<*date/time*>  
Description: The job to recover SharePoint Farm SharePoint Farm\MOSS\SharePoint\SharePoint_Config_0952a7dc-acec-4f1d-94b5-98b1b7738136 to MOSS.contoso.com, that started at Thursday, March 07, 2013 12:34:54 PM, failed using optimized ILR. Another job using unoptimized ILR has been triggered. (ID 33330)  
DPM was unable to export the item *`https://moss/default.aspx`* from the content database MOSS\SHAREPOINT\WSS_Content. Exception Message = Source Url is Absent. (ID 32017 Details: Internal error code: 0x80990E14)  
>
> Critical:  
Affected area: SharePoint Farm\MOSS\SharePoint\SharePoint_Config_0952a7dc-acec-4f1d-94b5-98b1b7738136  
Occurred since: \<*date/time*>  
Description: The recovery jobs for SharePoint Farm SharePoint Farm\MOSS\SharePoint\SharePoint_Config_0952a7dc-acec-4f1d-94b5-98b1b7738136 that started at Thursday, March 07, 2013 12:38:33 PM, with the destination of MOSS.contoso.com, have completed. Most or all jobs failed to recover the requested data. (ID 3111)  
DPM was unable to export the item `https://moss/default.aspx` from the content database MOSS\SHAREPOINT\WSS_Content. Exception Message = \<nativehr>0x80004003\</nativehr>\<nativestack>\</nativestack>. (ID 32017 Details: Invalid pointer (0x80004003))  

The WssCmdletsWrapper.errlog file on the DPM agent contains messages that are similar to the following:

> WSSCmdlets.cs(419) NORMAL Triggering Export of Source Url = `https://moss/default.aspx` to File = C:\stagetools\DPM_ed2d3980_977e_4dbb_af3e_e1ec5738c0e9\cmp\  
WssExportHelper.cs(128) NORMAL Export Parameters:- SourceUrl = `https://moss/default.aspx`, ExportFilePath = [C:\stagetools\DPM_ed2d3980_977e_4dbb_af3e_e1ec5738c0e9\cmp], ExportFileName = [], RoType = [ListItem], IsAlternateUrl = [False]  
WssExportHelper.cs(134) NORMAL Export Parameters:- Unattached Database:: [MOSS\SharePoint\DPM_ed2d3980_977e_4dbb_af3e_e1ec5738c0e9]  
WssExportHelper.cs(310) NORMAL Source url: `https://moss/default.aspx`, HostHeaderIsSiteName = False  
WSSObjectModelHelper.cs(103) NORMAL Modified Source Url = `https://moss:3268/default.aspx`  
WssExportHelper.cs(355) NORMAL Triggering Export of ListItem = `https://moss:3268/default.aspx`  
WssExportHelper.cs(494) WARNING The specified Folder Url `https://moss:3268/` is absent in the database  
WSSCmdlets.cs(451) WARNING Caught Exception while trying to export Url `https://moss/default.aspx` to File [C:\stagetools\DPM_ed2d3980_977e_4dbb_af3e_e1ec5738c0e9\cmp\\].  
WSSCmdlets.cs(1269) WARNING --------------------------------------------------  
WSSCmdlets.cs(1270) WARNING Exception Message =  
WSSCmdlets.cs(1270) WARNING Source Url is Absent  
WSSCmdlets.cs(1271) WARNING Exception Stack =  
WSSCmdlets.cs(1271) WARNING at WSSCmdlets.CWssExportHelper.AddExportObjectsForListItem(SPExportSettings spExportSettings, String sourceUrl)  
WSSCmdlets.cs(1271) WARNING at WSSCmdlets.CWssExportHelper.SpecifyExportObjectsIfRequired(SPExportSettings spExportSettings, String sourceUrl, ComponentTypeType roType)  
WSSCmdlets.cs(1271) WARNING at WSSCmdlets.CWssExportHelper.GetExportSettings(String sourceUrl, String exportPath, String exportFileName, ComponentTypeType roType, SPContentDatabase spUnAttachedContentDatabase, Boolean isAlternateURLRecovery)  
WSSCmdlets.cs(1271) WARNING at WSSCmdlets.CWssExportHelper.ExportUrlDelegate()  
WSSCmdlets.cs(1271) WARNING at Microsoft.SharePoint.SPSecurity.<>c__DisplayClass4.\<RunWithElevatedPrivileges>b__2()  
WSSCmdlets.cs(1271) WARNING at Microsoft.SharePoint.Utilities.SecurityContext.RunAsProcess(CodeToRunElevated secureCode)  
WSSCmdlets.cs(1271) WARNING at Microsoft.SharePoint.SPSecurity.RunWithElevatedPrivileges(WaitCallback secureCode, Object param)  
WSSCmdlets.cs(1271) WARNING at Microsoft.SharePoint.SPSecurity.RunWithElevatedPrivileges(CodeToRunElevated secureCode)  
WSSCmdlets.cs(1271) WARNING at WSSCmdlets.CWSSCmdlets.ExportUrl(String sourceUrl, String exportPath, String exportFileName, String roType, Boolean isAlternateURLRecovery, Int32& hr, String& exceptionMessage)

> [!NOTE]
> If you customize the default.aspx file for a SharePoint website, create a copy of the file in an alternate location to protect against unwanted changes or accidental deletion.
