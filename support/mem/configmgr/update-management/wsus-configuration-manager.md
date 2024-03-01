---
title: WSUS Configuration Manager configures the WSUS server
description: Describes how WSUS Configuration Manager configures the WSUS server with the settings that are defined for the software update point in the Configuration Manager console.
ms.date: 12/05/2023
ms.reviewer: kaushika
---
# WSUS Configuration Manager configures the WSUS server

_Original product version:_ &nbsp; Configuration Manager

Windows Server Update Services (WSUS) Configuration Manager connects to the WSUS server once every hour and configures the WSUS server with the settings that are defined for the software update point in the Configuration Manager console.

## How it works

WSUS Configuration Manager uses the WSUS APIs to connect to the WSUS server. The WSUS Administration console must be installed on the Configuration Manager site server, because the WSUS Administration console installs the APIs that are used to connect to the WSUS server.

The following are logged in WCM.log:

> Checking for supported version of WSUS (min WSUS 3.0 SP2 + KB2720211 + KB2734608)  SMS_WSUS_CONFIGURATION_MANAGER  
> Checking runtime v2.0.50727...   SMS_WSUS_CONFIGURATION_MANAGER  
> Did not find supported version of assembly Microsoft.UpdateServices.Administration.   SMS_WSUS_CONFIGURATION_MANAGER  
> Checking runtime v4.0.30319...   SMS_WSUS_CONFIGURATION_MANAGER  
> Found supported assembly Microsoft.UpdateServices.Administration version 4.0.0.0, file version 6.2.9200.16384     SMS_WSUS_CONFIGURATION_MANAGER  
> Found supported assembly Microsoft.UpdateServices.BaseApi version 4.0.0.0, file version 6.2.9200.16384     SMS_WSUS_CONFIGURATION_MANAGER  
> Supported WSUS version found   SMS_WSUS_CONFIGURATION_MANAGER

If the products or classifications defined for the software update point are modified, SMS Provider makes changes in the appropriate CI_* tables in the database. For example, when a product is selected for synchronization, SMS Provider updates rows in the `CI_CategoryInstances` and `CI_UpdateCategorySubscription` tables.

SMS Database Monitor monitors these tables for changes. When an update is detected, SMS Database Monitor drops a CSB file in the WSUSMgr.box folder notifying WCM to update the WSUS server configuration. The following are logged in SMSDBMon.log:

> RCV: UPDATE on CI_CategoryInstances for CategoryNotify_iud [**177**][**14252**] SMS_DATABASE_NOTIFICATION_MONITOR  
> RCV: UPDATE on CI_UpdateCategorySubscription for SubNotify_iu_WCM [**177**][**14253**]   SMS_DATABASE_NOTIFICATION_MONITOR  
> SND: Dropped E:\ConfigMgr\inboxes\\**objmgr.box**\\**177**.CTN [**14252**]          SMS_DATABASE_NOTIFICATION_MONITOR  
> SND: Dropped E:\ConfigMgr\inboxes\\**WSUSMgr.box**\\**177**.CSB [**14253**]         SMS_DATABASE_NOTIFICATION_MONITOR

WCM then wakes up and connects to the WSUS server to make sure that it is configured with the options defined in the Configuration Manager console. The following are logged in WCM.log:

> File notification triggered WCM Inbox. SMS_WSUS_CONFIGURATION_MANAGER  
> Setting new configuration state to 4 (WSUS_CONFIG_SUBSCRIPTION_PENDING)    SMS_WSUS_CONFIGURATION_MANAGER  
> Attempting connection to WSUS server: CE1SITE.CONTOSO.COM, port: 8530, useSSL: False SMS_WSUS_CONFIGURATION_MANAGER  
> Successfully connected to server: CE1SITE.CONTOSO.COM, port: 8530, useSSL: False SMS_WSUS_CONFIGURATION_MANAGER  
> Subscribed Update Categories \<?xml version="1.0" ?>\~~\<Categories>~~      \<Category Id="Product:a105a108-7c9b-4518-bbbe- 73f0fe30012b">\<![CDATA[Windows Server 2012]]>\</Category>~~ \<Category Id="Product:fdfe8200-9d98-44ba-a12a- 772282bf60ef">\<![CDATA[Windows Server 2008 R2]]>\</Category>~~           \<Category Id="UpdateClassification:0fa1201d-4330- 4fa8-8ae9-b877473b6441">\<![CDATA[Security Updates]]>\</Category>~~ \<Category Id="UpdateClassification:28bc880e-0592- 4cbf-8f95-c79b17911d5f">\<![CDATA[Update Rollups]]>\</Category>~~              \<Category Id="UpdateClassification:cd5ffd1e-e932- 4e3a-bf74-18bf0b1bbd83">\<![CDATA[Updates]]>\</Category>~~ \<Category Id="UpdateClassification:e6cf1350-c01b-414d- a61f-263d14d133b4">\<![CDATA[Critical Updates]]>\</Category>~~\</Categories>  SMS_WSUS_CONFIGURATION_MANAGER  
> Configuration successful. Will wait for 1 minute for any subscription or proxy changes SMS_WSUS_CONFIGURATION_MANAGER  
> Setting new configuration state to 2 (WSUS_CONFIG_SUCCESS)      SMS_WSUS_CONFIGURATION_MANAGER

Using WSUS APIs to connect to the WSUS server works by connecting to the `ApiRemoting30` virtual directory on the WSUS website. Therefore, it's important that you specify the correct port configuration when you install the software update point role.
