---
title: AppData folder redirect causes Lookup fields to break
description: AppData folder redirect causes Lookup fields to break and you receive an error stating that the system cannot find the file specified in Microsoft Dynamics CRM 2011. Provides a resolution.
ms.reviewer: debrau
ms.topic: troubleshooting
ms.date: 3/31/2021
---
# AppData folder redirect causes Lookup fields to break with the system cannot find the file specified error in Microsoft Dynamics CRM 2011

This article provides a resolution for the issue Lookup fields fail to populate correctly after selecting a record in Microsoft Dynamics CRM 2011.

_Applies to:_ &nbsp; Microsoft Dynamics CRM 2011  
_Original KB number:_ &nbsp; 2622335

## Symptoms

Users who have the %AppData% folder redirected to a network share notice that Lookup fields fail to populate correctly after selecting a record. In addition, users may notice that after selecting a record in the Lookup Field web dialog box, a red **x** will populate in the field instead of the record that was selected. This issue occurs in both the web and Outlook clients.

If a trace is run on the Outlook client, the following error appears during this process:

>\> JavaScript Error: The system cannot find the file specified.  
>\>  
>\> \<Function>anonymous($p0){var$v_0=null;try{$v_0=this.$k_3();if(!IsNull($p0)){var$v_1=String.format("Timestamp:Loaded={0},Updated={1},Saved={2}{3}{4}",this.$H_3.toString(),!IsNull(this.$A_3)?this.$A_3.toString():(newDate).toString(),!IsNull(this.$9_3)?this.$9_3.toString():"","\n",$p0);this.get_element().setAttribute(this.$J_3,$v_1) }} catch($$e_1_0){if(!IsNull($v_0)){var$v_2=String.format("Timestamp:Loaded={0},Updated={1},Saved={2}{3}{4}",this.$H_3.toString(),this.$A_3.toString(),!IsNull(this.$9_3)?this.$9_3.toString():"","\n",$v_0);this.get_element().setAttribute(this.$J_3,$v_2) }} this.get_element().save("LookupMruItems")}\</Function>  
>\> \<Function>anonymous($p0){this.$H_3=this.$19_3;var$v_0=this.$14_3($p0);$v_0=this.$15_3($v_0);this.$W_3($v_0);for(var$v_1=0;$v_1<this.$F_3.length;$v_1++){var$v_2=this.$F_3[$v_1];$v_2($v_0)}this.$F_3=newArray(0);return$v_0}\</Function>  
>\> \<Function>anonymous($p0){var$v_0=null;if($p0&&this.$j_3)return$v_0;this.$19_3=newDate;var$v_1=newRemoteCommand("LookupMruWebService","RetrieveLookupMruData",null);$v_1.ErrorHandler=this.$Y;var$v_2=null;if($p0)$v_2=this.$t;var$v_3=$v_1.Execute($v_2);if(!$p0){if($v_3.Success){var$v_4=$v_3.ReturnValue;$v_0=this.$16_3($v_4) }} elsethis.$j_3=true;return$v_0}\</Function>  
>\> \<Function>anonymous($p0){var$v_0=this.$k_3(),$v_1=false;if(!isNullOrEmptyString($v_0)){var$v_2=$v_0.match(this.$g_3);if(!IsNull($v_2)&&$v_2.length===5){var$v_3=newDate($v_2[1]),$v_4=newDate;if(elapsedTime($v_3,$v_4)<1.8e6){this.$H_3=$v_3;$v_0=$v_2[4];$v_1=true }} }if($v_1){if(!IsNull($v_0))$v_0=this.$15_3($v_0);!IsNull($p0)&&$p0($v_0)}else{this.$e_3();if(!IsNull($p0))this.$F_3[this.$F_3.length]=$p0;$v_0=this.$1O_3(!IsNull($p0))}return$v_0}\</Function>  
>\> \<Function>anonymous(items){var$v_0=this.$B_3(null);this.$1D_3($v_0,items)}\</Function>  
>\>  
>\> Url: `https://server/_static/_controls/LookupMru/LookupMruList.js?ver=1637096040`  
>\> Line: 1  
>\> Original function: anonymous($p0){var$v_0=null;try{$v_0=this.$k_3();if(!IsNull($p0)){var$v_1=String.format("Timestamp:Loaded={0},Updated={1},Saved={2}{3}{4}",this.$H_3.toString(),!IsNull(this.$A_3)?this.$A_3.toString():(newDate).toString(),!IsNull(this.$9_3)?this.$9_3.toStr  
>\> Report to Watson:False

If the %AppData% folder redirection is disabled, the issue goes away.

## Cause

The issue occurs because the lookup field MRU save function is hampered by the folder redirection policy for %AppData%. Essentially, Microsoft Dynamics CRM needs to write information to a file (LookupMRUList.xml), which is typically located in `C:\Users\<User>\AppData\Roaming\Microsoft\Internet Explorer\UserData`. The LookupMRUList.xml file stores the recently viewed records for a particular entity.

However, if the registry key `HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Internet Settings\5.0\Cache\Extensible Cache\UserData` points to a local profile, and if the UserData folder does not exist in the %AppData% network share, the issue will reproduce.

## Resolution

To fix this issue, follow these steps:

1. Copy the UserData folder from a local profile, and paste this into `%APPDATA%\Microsoft\Internet Explorer\`.

    - Windows 7/Vista local profile: `C:\Users\<User>\AppData\Roaming\Microsoft\Internet Explorer\UserData`
    - Windows XP local profile: `C:\Documents and Settings\<user>\UserData`

2. Update the registry key: `HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Internet Settings\5.0\Cache\Extensible Cache\UserData` to point to `%APPDATA%\Microsoft\Internet Explorer\UserData`.
