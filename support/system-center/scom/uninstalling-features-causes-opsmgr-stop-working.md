---
title: OpsMgr stops working after uninstalling features
description: Fixes an issue where Operations Manager stops working after you use msiexec.exe to manually uninstall some features on the Operations Manager management servers.
ms.date: 04/15/2024
ms.reviewer: adoyle, jchornbe, mihsar, delhan
---
# Operations Manager stops working after you use msiexec.exe to uninstall features on management servers

This article helps you fix an issue where Operations Manager stops working after you use msiexec.exe to manually uninstall some features on the Operations Manager management servers.

_Original product version:_ &nbsp; System Center 2012 R2 Operations Manager, Microsoft System Center 2012 Operations Manager  
_Original KB number:_ &nbsp; 3031977

## Symptoms

You install System Center 2012 Operations Manager or System Center 2012 R2 Operations Manager. Then, you use the msiexec.exe utility to manually remove certain features, such as the Application Performance Monitoring (APM) Agent or Operational Insights Agent (Advisor Agent). In this situation, unexpected issues may occur. For example, when you import new management packs, the configuration is never loaded successfully on all management servers and agents.

Additionally, the following issues may occur:

- Error 1209 events are logged in the Operations Manager log on all management servers.
- **All Management Server Resource Pool is unavailable** alerts are displayed on the console.

> [!NOTE]
> Microsoft doesn't support the manual removal of the APM Agent or Advisor Agent. However, the installation wizard UI does let you uninstall these features.

## Cause

When you use msiexec.exe to uninstall certain features, some necessary components or registry keys may be unintentionally removed. For example, when you uninstall APM Agent or Advisor Agent, the following registry key is deleted:

Registry location: `HKEY_LOCAL_MACHINE\Software\Microsoft\System Center\2010\Common\Machine Settings`  
DWORD name: `LegacyMode`  
DWORD value: **0**

This registry key is required on all management servers and on all computers that have the console installed.

## Resolution

To determine whether you're affected by this issue, run the following SQL query on the Operations Manager database:

```sql
select ManagementPackId, MPVersionDependentId, MPName, MPVersion, MPKeyToken
from ManagementPack
where MPIsSealed = 1 and MPVersionDependentId != dbo.fn_MPVersionDependentId(MPName, MPKeyToken, MPVersion)
```

If you receive any results from this query, you are affected by this specific issue. In this situation, run the following SQL query on the Operations Manager database to obtain the rehashed GUIDs from the correct string.

> [!NOTE]
> Make sure that you have a current backup before you run this query. Changing the database directly may leave you in an unsupported state where you have to rebuild or restore the database to its pre-change state.

```sql
update ManagementPack
set MPVersionDependentId = dbo.fn_MPVersionDependentId(MPName, MPKeyToken, MPVersion), MPRunTimeXML = replace(MPRunTimeXML, 'RevisionId="' + convert(nvarchar(255), MPVersionDependentId) + '"', 'RevisionId="' + convert(nvarchar(255), dbo.fn_MPVersionDependentId(MPName, MPKeyToken, MPVersion)) + '"')
where MPIsSealed = 1 and MPVersionDependentId != dbo.fn_MPVersionDependentId(MPName, MPKeyToken, MPVersion)
go
update ManagementPackHistory
set MPVersionDependentId = dbo.fn_MPVersionDependentId(MPName, MPKeyToken, Version)
where IsSealed = 1 and MPVersionDependentId != dbo.fn_MPVersionDependentId(MPName, MPKeyToken, Version)
go
```

After you do this, make sure that the following registry key exists and that it has the correct value (**0**) on all management servers and on all computers that have the console installed:

Registry location: `HKEY_LOCAL_MACHINE\Software\Microsoft\System Center\2010\Common\Machine Settings`  
DWORD name: `LegacyMode`  
DWORD value: **0**

Then, clear the Health Service cache on all management servers. To do this, follow these steps:

1. Stop the **System Center Management** service (also known as **Microsoft Monitoring Agent** in System Center 2012 R2 Operations Manager).
2. Delete the **Health Service State** folder that's located in the `SCOM_INSTALL_DIR\Server` directory.
3. Start the **System Center Management** service (also known as **Microsoft Monitoring Agent** in System Center 2012 R2 Operations Manager).

## More information

If the `LegacyMode` registry key is missing or is set to a value other than **0** when you import new management packs, the `MPVersionDependentId` value (GUID) will obtain a different value than it should. In this case, it won't include the `Schema=2` string that's used to create the GUID.
