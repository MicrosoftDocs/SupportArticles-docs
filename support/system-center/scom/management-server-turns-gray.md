---
title: A management server becomes gray
description: Fixes an issue in which a management server turns gray after being removed from the All Management Servers resource pool in System Center 2012 Operations Manager.
ms.date: 04/15/2024
---
# Removing a server from the All Management Servers resource pool causes the server to become gray

This article helps you fix an issue in which a management server turns gray (grey) after being removed from the All Management Servers resource pool in System Center 2012 Operations Manager.

_Original product version:_ &nbsp; System Center 2012 Operations Manager Service Pack 1  
_Original KB number:_ &nbsp; 2853431

## Symptoms

In the System Center 2012 Operations Manager admin console, a management server turns gray (grey) after being removed from the All Management Servers resource pool. You will also see these errors in the Operations Manager event log related to unloading of workflows or rules:

> Event ID: 1108
>
> An Account specified in the Run As Profile  
> "Microsoft.SystemCenter.Omonline.OutsideIn.RunAsProfile.Configuration" cannot be resolved. Specifically, the account is used in the Secure Reference Override "SecureOverride92d3e014_93cb_d967_17b4_8c5eb18ae099".
>
> This condition may have occurred because the Account is not configured to be distributed to this computer. To resolve this problem, you need to open the Run As Profile specified below, locate the Account entry as specified by its SSID, and either choose to distribute the Account to this computer if appropriate, or change the setting in the Profile so that the target object does not use the specified Account.
>
> Event ID: 1108
>
> An Account specified in the Run As Profile "Microsoft.SystemCenter.DataWarehouse.ActionAccount" cannot be resolved. Specifically, the account is used in the Secure Reference Override "SecureOverride0bc452d6_7bf2_17cc_a183_5aa213df34e6".
>
>This condition may have occurred because the Account is not configured to be distributed to this computer. To resolve this problem, you need to open the Run As Profile specified below, locate the Account entry as specified by its SSID, and either choose to distribute the Account to this computer if appropriate, or change the setting in the Profile so that the target object does not use the specified Account.
>
>
> Alert  
> System Center Management Health Service Unloaded System Rule(s)
>
> The System Center Management Health Service 56D4A306-C0F1-598F-77FF-8E4258FA3060 running on host \<name> and serving management group with id {453EC1E1-382C-DD51-5EB3-81798AD7F7D2} is not healthy. Some system rules failed to load.

## Cause

This occurs because the data warehouse Run As accounts are configured by default to only distribute to the All Management Servers resource pool. There is no runtime method to distribute the account to all management servers automatically. When the management server is removed from the All Management Servers resource pool, the data warehouse account is no longer distributed to it, therefore any workflows requiring this account fail and unload. The failing and unloading of the workflows cause the management server to become grayed out.

## Resolution

To resolve this issue, go to the **Data Warehouse Account** and **Data Warehouse Report Deployment Account** profiles and determine which account(s) you are using. Then, go to those accounts under **Run As Configuration** and change their deployment type to either less secure, to the specific management servers, or to the new resource pool that the management servers belong to.
