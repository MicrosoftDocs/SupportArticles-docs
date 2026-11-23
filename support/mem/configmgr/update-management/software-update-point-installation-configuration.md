---
title: Software update point installation and configuration
description: Understand how Configuration Manager installs and configures a software update point, communicates with WSUS, and applies LEDBAT settings.
ms.date: 08/31/2026
ms.topic: reference
ms.reviewer: payur, andad, emank
ai-usage: ai-assisted
ms.custom: "sap: Software Update Management (SUM)/Software Update Point Installation or Configuration"
---

# Software update point installation and configuration

Applies to: Configuration Manager (current branch)

## Summary

To assess software update compliance and deploy software updates to clients, Configuration Manager requires a software update point on the central administration site and primary sites. This article explains how Configuration Manager installs the site system role and applies its settings to Windows Server Update Services (WSUS).

## Prerequisites and supported configuration

Before you install the software update point role, install WSUS on the target site system server. When you install the first software update point in a site, also install the WSUS Administration Console on the site server. WSUS Configuration Manager and WSUS Synchronization Manager use the WSUS administration APIs from this console.

For dependencies and planning considerations, see [Prerequisites for software updates](/intune/configmgr/sum/plan-design/prerequisites-for-software-updates) and [Plan for software updates](/intune/configmgr/sum/plan-design/plan-for-software-updates).

For the supported procedures to install the role and configure WSUS ports, TLS/SSL, proxy settings, synchronization options, products, classifications, languages, and accounts, see [Install and configure a software update point](/intune/configmgr/sum/get-started/install-a-software-update-point).

## Track software update point installation

The following diagram shows the components involved when Configuration Manager installs the software update point role.

:::image type="content" source="./media/software-update-point-installation-flow.png" alt-text="Flowchart that shows the process flow from SMS Provider through Site Component Manager and the bootstrap service to software update point setup." lightbox="./media/software-update-point-installation-flow-expanded.png":::

When you add the role, SMS Provider (SMSProv) creates an instance of the `SMS_SCI_SysResUse` class. Entries that resemble the following example appear in the SMSProv.log file:

```output
PutInstanceAsync SMS_SCI_SysResUse~
CExtProviderClassObject::DoPutInstanceInstance~
GetObjectAsync : SMS_SCI_SysResUse.FileType=2,ItemName="  [\"Display=\\\\[SiteServer]\\\"]MSWNET:[\"SMS_SITE=[SiteCode]\"]\\\\[SiteServer]\\,SMS Software Update Point",ItemType="System Resource Usage",SiteCode="[SiteCode]"~
```

Site Component Manager (SiteComp) detects the site control change and starts role installation. If the site system server doesn't have another role, Configuration Manager first installs the component server role. Entries that resemble the following example appear in the SiteComp.log file:

```output
Synchronizing component server [SiteServer]...
Component SMS_WSUS_CONTROL_MANAGER flagged for installation.
Installing component SMS_WSUS_CONTROL_MANAGER...
Starting service SMS_SERVER_BOOTSTRAP_[SiteCode] with command-line arguments "[SiteCode] E:\ConfigMgr /install E:\ConfigMgr\bin\x64\rolesetup.exe SMSWSUS "...
```

Site Component Manager starts the `SMS_SERVER_BOOTSTRAP_[SiteCode]` service on the site system. The bootstrap service runs rolesetup.exe, which creates the SUPSetup.log file and performs the prerequisite and installation checks. The SUPSetup.log file records entries that resemble the following examples:

```output
SMSWSUS Setup Started....
Installing Pre Reqs for SMSWSUS
======== Installing Pre Reqs for Role SMSWSUS ========
Found 0 Pre Reqs for Role SMSWSUS
======== Completed Installation of Pre Reqs for Role SMSWSUS ========
Installing the SMSWSUS
Checking for supported version of WSUS (min WSUS 4.0)
Checking runtime v4.0.30319...
Found supported assembly Microsoft.UpdateServices.Administration version 4.0.0.0
Found supported assembly Microsoft.UpdateServices.BaseApi version 4.0.0.0
Supported WSUS version found
Registered DLL E:\ConfigMgr\bin\x64\wsusmsp.dll
Installation was successful.
~RoleSetup().
```

After installation succeeds, Site Component Manager removes the bootstrap service. The SiteComp.log file records entries that resemble the following examples:

```output
"E:\ConfigMgr\bin\x64\rolesetup.exe /install /siteserver:[SiteServer]" executed successfully on server [SiteServer].
Bootstrap operation successful.
Deinstalled service SMS_SERVER_BOOTSTRAP_[SiteCode].
```

## Review software update point configuration data

Configuration Manager stores software update point settings as component properties. The following read-only query returns those properties:

```sql
SELECT SC_Component.ComponentName,
       SC_Component.Name,
       vSMS_SC_Component_Properties.Name,
       vSMS_SC_Component_Properties.Value1,
       vSMS_SC_Component_Properties.Value2,
       vSMS_SC_Component_Properties.Value3
FROM vSMS_SC_Component_Properties
JOIN SC_Component
  ON SC_Component.ID = vSMS_SC_Component_Properties.ID
WHERE SC_Component.ComponentName LIKE '%SMS_WSUS%';
```

The following read-only query returns the products and update classifications enabled in the component properties:

```sql
SELECT CI_LocalizedCategoryInstances.CategoryInstanceName,
       CI_CategoryInstances.CategoryTypeName,
       CI_CategoryInstances.CategoryInstance_UniqueID,
       CI_UpdateCategorySubscription.IsSubscribed,
       CI_CategoryInstances.DateLastModified,
       CI_CategoryInstances.CategoryInstanceID
FROM CI_CategoryInstances
JOIN CI_UpdateCategorySubscription
  ON CI_CategoryInstances.CategoryInstanceID = CI_UpdateCategorySubscription.CategoryInstanceID
JOIN CI_LocalizedCategoryInstances
  ON CI_CategoryInstances.CategoryInstanceID = CI_LocalizedCategoryInstances.CategoryInstanceID
WHERE CI_UpdateCategorySubscription.IsSubscribed = 1;
```

## Track software update point configuration

WSUS Configuration Manager (WCM) connects to the WSUS server every hour and applies the settings defined for the software update point. WCM uses the WSUS administration APIs, so the site server must have the WSUS Administration Console installed. During these sessions, WCM.log records entries that resemble the following examples:

```output
Checking for supported version of WSUS (min WSUS 3.0 SP2 + KB2720211 + KB2734608)
Checking runtime v4.0.30319...
Supported WSUS version found
Successfully connected to local WSUS server
Verify Upstream Server settings on the Active WSUS Server
No changes - WSUS Server settings are correctly configured and Upstream Server is set to Microsoft Update
for [SiteServer], no connection account is available
Successfully refreshed categories from WSUS server
Successfully connected to local WSUS server
```

The following diagram shows how a console configuration change reaches WCM and the WSUS API endpoint.

:::image type="content" source="./media/software-update-point-wsus-configuration-flow.png" alt-text="Flowchart that shows the process flow from SMS Provider through database monitoring and WCM to the WSUS API endpoint." lightbox="./media/software-update-point-wsus-configuration-flow-expanded.png":::

When you change products or classifications, SMS Provider modifies the applicable rows in the `CI_CategoryInstances` and `CI_UpdateCategorySubscription` tables. SMS Database Monitor detects the change and places a .csb file in WSUSMgr.box to notify WCM. When products or categories change, it also places a .ctn file in objmgr.box so Configuration Manager can populate configuration items in the database. The SMSDBMon.log file records entries that resemble the following examples:

```output
SND: Dropped E:\ConfigMgr\inboxes\objmgr.box\347.CTN [39252]
SND: Dropped E:\ConfigMgr\inboxes\WSUSMgr.box\347.CSB [39253]
```

WCM processes the notification, connects to WSUS, and applies the software update point subscription options through the WSUS APIs. The SWCM.log file records entries that resemble the following examples:

```output
File notification triggered WCM Inbox.
Setting new configuration state to 4 (WSUS_CONFIG_SUBSCRIPTION_PENDING)
Successfully connected to local WSUS server
Subscribed Update Categories <?xml version="1.0" ?> ~<Categories>~ <Category Id="[CategoryID]"><![CDATA[Example product]]></Category>~ <Category Id="[ClassificationID]"><![CDATA[Critical Updates]]></Category>~ </Categories>
Setting new configuration state to 2 (WSUS_CONFIG_SUCCESS)
```

WCM connects to the `ApiRemoting30` virtual directory on the WSUS website. The WSUS ports in the software update point properties must match the ports assigned to the WSUS website.

## WSUS configuration states

WCM uses the following states during WSUS configuration:

| State | Value |
| --- | --- |
| `WSUS_CONFIG_NONE` | 0 |
| `WSUS_CONFIG_PENDING` | 1 |
| `WSUS_CONFIG_SUCCESS` | 2 |
| `WSUS_CONFIG_FAILED` | 3 |
| `WSUS_CONFIG_SUBSCRIPTION_PENDING` | 4 |

## References

- [Install and configure a software update point](/intune/configmgr/sum/get-started/install-a-software-update-point)
- [Synchronize software updates](/intune/configmgr/sum/get-started/synchronize-software-updates)
- [Configure classifications and products to synchronize](/intune/configmgr/sum/get-started/configure-classifications-and-products)
- [Manage settings for software updates](/intune/configmgr/sum/get-started/manage-settings-for-software-updates)
