---
title: Useful logs and queries
description: Describes how to some other useful logs and queries for advanced troubleshooting content distribution-related issues.
ms.date: 12/05/2023
ms.reviewer: kaushika
ms.custom: sap:Content Management\Content Distribution to Distribution Points
---
# Advanced troubleshooting tips for content distribution

This article provides some advanced troubleshooting tips to help you identify and solve content distribution issues.

_Original product version:_ &nbsp; Configuration Manager current branch, Microsoft System Center 2012 Configuration Manager, Microsoft System Center 2012 R2 Configuration Manager  

## Enable verbose logging

- **PkgXferMgr.log**

  For Package Transfer Manager, verbose logging provides more information in the log about content copy process, file hashes, and job scheduling. Verbose logging can be enabled by setting the following registry value to **0**:
  
  `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\SMS\Tracing\SMS_PACKAGE_TRANSFER_MANAGER\LoggingLevel`

  For Package Transfer Manager, debug logging provides more information about the content copy process. Debug logging can be enabled by setting the following registry value to **1**:
  
  `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\SMS\Tracing\SMS_PACKAGE_TRANSFER_MANAGER\DebugLogging`

  > [!NOTE]
  > These registry change(s) do not require a restart of `SMS_Executive` service.

- Client logs (includes pull DP and management point logs)

  Verbose logging can be enabled by setting the following registry value to **0**:
  
  `HKEY_LOCAL_MACHINE\Software\Microsoft\CCM\Logging\@GLOBAL\LogLevel`
  
  Debug logging can be enabled by setting the following registry value as REG_SZ with value **True**:
  
  `HKEY_LOCAL_MACHINE\Software\Microsoft\CCM\Logging\DebugLogging\Enabled`

  The CCM log size can be increased to 5M by setting the following registry value to **5242880** (decimal)
  
  `HKEY_LOCAL_MACHINE\Software\Microsoft\CCM\Logging\@GLOBAL\LogMaxSize`
  
  Additionally, you can edit the DWORD value for the following registry value to increase the number of history log files to be retained:

  `HKEY_LOCAL_MACHINE\Software\Microsoft\CCM\Logging\@GLOBAL\LogMaxHistory`
  
  > [!NOTE]
  > These registry change(s) require a restart of `SMS Agent Host` service.

- **StateSys.log**

  Verbose logging for StateSys.log can be enabled by setting the following registry value to **1**:
  
  `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\SMS\COMPONENTS\SMS_STATE_SYSTEM\Verbose logging`
  
  > [!NOTE]
  > This registry key change does not require a restart of `SMS_Executive` service.

- (Global - site server only) SQL queries

  To get information about SQL queries executed by `ConfigMgr` components, SQL tracing can be enabled by setting the following registry value to **1**:
  
  `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\SMS\Tracing\SqlEnabled`
  
  This registry value adds SQL trace logging for all site server logs. This should only be done temporarily while troubleshooting, and should be disabled after getting the relevant logs.

  > [!NOTE]
  > This registry change does not require a restart of `SMS_Executive` service.

- (Global - site server only) Enable log archiving

  There are occasions when the issue does not reproduce on demand and while waiting for the issue to reproduce, there's a risk of logs rolling over. In these situations, enabling log archiving can be useful as it allows you to have more historical logs. This is only relevant for site server logs.

  Log archiving can be enabled by setting the following registry values:
  
  `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\SMS\Tracing\ArchiveEnabled` = **1**

  `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\SMS\Tracing\ArchivePath` = \<ArchiveLocation>
  
  After enabling log archiving, ConfigMgr will archive the rolled over logs to the \<ArchiveLocation>, and will keep 10 copies of each log.

  To increase the number of copies maintained for a specific component when log archiving is enabled, set the following registry value to **20**:

  `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\SMS\Tracing\COMPONENT_NAME\LogMaxHistory`
  
  > [!NOTE]
  > These registry change(s) require a restart of `SMS_Executive` service.

- (Per log - site server only) Increase log file size

  To increase log file size for an individual log to 50 MB, set the component-specific registry value to **52428800** (decimal):
  
  `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\SMS\Tracing\COMPONENT_NAME\MaxFileSize`
  
  > [!NOTE]
  > This registry change requires a restart of `SMS_Executive` service.  

## Resend compressed copy of a package to a site

When a package is first distributed to a site, DistMgr sends a compressed copy of the package to the site. After the package is extracted in the content library on the site, the local copy of the content is used to send the package to DPs as long as the same package version is being distributed to the DPs in the site.

There are a few occasions where it's necessary to force a site to resend the compressed copy of a package to a specified site. Most notably, this is required when:

1. Content is missing from content library (`PkgLib`, `DataLib`, or `FileLib`) on a primary or secondary site server itself.
2. **DistMgr.log** consistently complains about the content not having arrived from the parent site (for example: '_The contents for the package CS100026 hasn't arrived from site CS1 yet, will retry later_').

In most cases, the message '_The contents for the package CS100026 hasn't arrived from site CS1 yet, will retry later_' is logged temporarily while the package content is in transit. When you see this message, review the Sender/Despooler logs to ensure that there are no issues with site communications. Review [Distribute a package to DP across sites](understand-package-actions.md#distribute-a-package-to-dp-across-sites) to understand the log flow.

### How does DistMgr know if the current site has a copy of the package installed

DistMgr checks if there is a Type 1 row in `PkgStatus` for the package for the package version in question. If there is a Type 1 row for the site with **Status** = **Installed**, the local copy of the package content is used to send to the DPs. If there is no Type 1 row in `PkgStatus`, it means that the package content is not yet installed on the site server.

### Does redistribute package to DP colocated on the site server cause the compressed copy of the package to get resent

No. Redistributing the package relies on the site already having the package content in the package source directory. If the package was sent to the site at some point and marked as **Installed**, then a redistribute action on the DP colocated on the site server doesn't do anything as DistMgr thinks that the content is already installed and the following line will be logged in **DistMgr.log**:

> The distribution point is on the siteserver and the package is a content type package. There is nothing to be copied over.

### What if the content is missing in the content library on the package source site

If the content is missing in the content library on the package source site, then resetting the `SourceVersion` will not help. The only way to repopulate the missing content is to update the package. Updating the package causes the package source site to take a package snapshot from the package source location and write the content to the content library.

### How do I force the package source site to resend the compressed copy of the package to a specific site

After confirming that the package source site has the required content, it's possible to force the package source site to resend the package PCK file to a specific site by setting `SourceVersion` to 0 for the Type 1 row in `PkgStatus` for the affected site. This row can be identified by running the following SQL query on the package source site's database after replacing the _PACKAGEID_ and _SITECODE_ of the desired package and site:

```sql
SELECT * FROM PkgStatus WHERE Type = 1 AND ID = 'PACKAGEID' AND SiteCode = 'SITECODE'
```

After confirming that this query returns a unique and correct row, running the below query will reset `SourceVersion` for this row to 0:

```sql
UPDATE PkgStatus SET SourceVersion = 0 WHERE Type = 1 AND ID = 'PACKAGEID' AND SiteCode = 'SITECODE'
```

After resetting the `SourceVersion` to **0** for the Type 1 row, redistributing the package to any DP in the affected site will force the package source site to resend the compressed copy of the package to the affected site.

> [!NOTE]
> It is very important to run the above query on the site that owns the package, i.e., the package source site.

## Relevant tables for content distribution

- `SMSPackages` - Contains a list of all packages

  Interesting columns:

  |Column|Values|
  |---|---|
  |Action|0 - NONE<br/>1 - UPDATE<br/>2 - ADD<br/>3 - DELETE<br/>4 - VALIDATE<br/>5 - CANCEL|
  |PackageType|0 - Regular Package<br/>3 - Driver Package<br/>4 - Task Sequence<br/>5 - Software Updates Package<br/>6 - Device Settings Package<br/>7 - Virtual App Package<br/>8 - Content Package (Application)<br/>257 - Operating System Image<br/>258 - Boot Image<br/>259 - OS Installation Package<br/>260 - VHD Package|

- `PkgServers` - Contains a list of all the packages along with the DPs they are currently targeted to.

  Interesting columns:

  |Column|Values|
  |---|---|
  |Action|0 - NONE<br/>1 - UPDATE<br/>2 - ADD<br/>3 - DELETE<br/>4 - VALIDATE<br/>5 - CANCEL|

- `PkgStatus` - Contains a list of the current package status for each package for each DP.

  Interesting columns:

  |Column|Values|
  |---|---|
  |Type|1 - SITE (MASTER)<br/>2 - DP (COPY)<br/><br/>Type 1 rows are created for each site the package is targeted to. PkgServer for this row is the site server FQDN.<br/> <br/>Type 2 rows are created for each DP the package is targeted to. PkgServer is the DP NALPATH.|
  |Status|0 - NONE<br/>1 - SENT<br/>2 - RECEIVED<br/>3 - INSTALLED<br/>4 - RETRY<br/>5 - FAILED<br/>6 - REMOVED<br/>7 - PENDING REMOVE (Not Used)<br/>8 - REMOVE FAILED<br/>9 - RETRY REMOVE|

- `DistributionJobs` - Contains a list of Package Transfer Manager Jobs along with their current state.

  Interesting columns:

  |Column|Values|
  |---|---|
  |Action|0 - NONE<br/>1 - UPDATE<br/>2 - ADD<br/>3 - DELETE<br/>4 - VALIDATE<br/>5 - CANCEL|
  |State|0 - PENDING<br/>1 - READY<br/>2 - STARTED<br/>3 - INPROGRESS<br/>4 - PENDING RESTART<br/>5 - COMPLETE<br/>6 - FAILED<br/>7 - CANCELED<br/>8 - SUSPENDED|

- `DistributionPoints` - Contains a list of all the distribution points.

  Interesting columns:

  |Column|Values|
  |---|---|
  |Action|0  -  NONE<br/>1  -  UPDATE<br/>2  -  ADD<br/>3  -  DELETE<br/>4  -  VALIDATE<br/>5  -  CANCEL|

- `PullDPResponse` - Temporarily contains the package status response sent from the pull DPs. DistMgr processes the response and updates `PkgStatus`.

  Interesting columns:

  |Column|Values|
  |---|---|
  |ActionState|1 - SUCCESS<br/>2 - WARNING<br/>4 - ERROR<br/>8 - DOWNLOAD STARTED<br/>16 - DOWNLOAD IN PROGRESS<br/>32 - DOWNLOADED<br/>64 - CANCELED<br/>128 - CANCELLATION REQUESTED|

- `PkgNotification` - Notification table monitored by SMSDBMON to trigger DistMgr to process a package. Type column defines the type of package notification. Rows in this table are removed after SMSDBMON triggers DistMgr.

  Interesting columns:

  |Column|Values|
  |---|---|
  |Type|0 - UNKNOWN<br/>1 - PACKAGE<br/>2 - PROGRAM<br/>4 - PACKAGE SERVER (DP)<br/>8 - PACKAGE ACCESS ACCOUNT<br/>15 - ALL|

- **Pull DP state messages** - List of state message IDs raised by pull DP

  Interesting columns:

  |Column|Values|
  |---|---|
  |State ID|1  -  SUCCESS<br/>2  -  WARNING<br/>4  -  FAILURE<br/>8  -  DOWNLOAD STARTED<br/>16 - DOWNLOAD IN PROGRESS<br/>32 - DOWNLOADED<br/>64 - CANCELED|

  Sample State Message Report:

  ```console
      <Report>
       <ReportHeader>
          <Identification>
             <Machine>
                <ClientInstalled>0</ClientInstalled>
                <ClientType>1</ClientType>
                <Unknown>0</Unknown>
                <ClientID IDType="0" IDFlag="1">925b0ab0-247b-466b-be0f-93d7cb032c87</ClientID>
                <ClientVersion>5.00.0000.0000</ClientVersion>
                <NetBIOSName>P01PDP1.CONTOSO.COM</NetBIOSName>
                <CodePage>437</CodePage>
                <SystemDefaultLCID>1033</SystemDefaultLCID>
             </Machine>
          </Identification>
          <ReportDetails>
             <ReportContent>StateMessage</ReportContent>
             <ReportType>Full</ReportType>
             <Date>20190107200618.000000+000</Date>
             <Version>1.0</Version>
             <Format>1.1</Format>
          </ReportDetails>
       </ReportHeader>
       <ReportBody>
          <StateMessage MessageTime="20190107200618.000000+000" SerialNumber="3">
             <Topic ID="P010000F" Type="902" IDType="0"/>
             <State ID="1" Criticality="0"/>
             <UserParameters Flags="0" Count="4">
                <Param>P010000F</Param>
                <Param>["Display=\\P01PDP1.CONTOSO.COM\"]MSWNET:["SMS_SITE=P01"]\\P01PDP1.CONTOSO.COM\</Param>
                <Param>{04AD1BB3-5E54-457A-9873-DFB2E8035090}</Param>
                <Param/>
             </UserParameters>
          </StateMessage>
       </ReportBody>
    </Report>
  ```

## Useful SQL queries

Here are some SQL queries that may be helpful when troubleshooting various content distribution related issues.  

### Package/DP status queries

- All **Failed** packages/DPs

  ```sql
  SELECT distinct DPSD.DPName, DPSD.PackageID, SP.Name, DPSD.MessageState, DPSD.LastStatusTime, DPSD.SiteCode
  FROM vSMS_DPStatusDetails DPSD
  JOIN SMSPackages_All SP ON DPSD.PackageID = SP.PkgID
  WHERE MessageState = 4
  ```

- All **In Progress** packages/DPs

  ```sql
  SELECT distinct DPSD.DPName, DPSD.PackageID, SP.Name, DPSD.MessageState, DPSD.LastStatusTime, DPSD.SiteCode
  FROM vSMS_DPStatusDetails DPSD
  JOIN SMSPackages_All SP ON DPSD.PackageID = SP.PkgID
  WHERE MessageState = 2
  ```

- All **Success** packages/DPs

  ```sql
  SELECT distinct DPSD.DPName, DPSD.PackageID, SP.Name, DPSD.MessageState, DPSD.LastStatusTime, DPSD.SiteCode
  FROM vSMS_DPStatusDetails DPSD
  JOIN SMSPackages_All SP ON DPSD.PackageID = SP.PkgID
  WHERE MessageState = 1
  ```

- All package/DPs in **In Progress** state for more than three days

  ```sql
  SELECT distinct DPSD.DPName, DPSD.PackageID, SP.Name, DPSD.MessageState, DPSD.LastStatusTime, DPSD.SiteCode
  FROM vSMS_DPStatusDetails DPSD
  JOIN SMSPackages_All SP ON DPSD.PackageID = SP.PkgID
  WHERE DPSD.LastStatusTime < DATEAdd(dd,-3,GETDate())  
  AND MessageState = 2
  ```

- All package/DPs in **Failed** state for more than three days

  ```sql
  SELECT distinct DPSD.DPName, DPSD.PackageID, SP.Name, DPSD.MessageState, DPSD.LastStatusTime, DPSD.SiteCode
  FROM vSMS_DPStatusDetails DPSD
  JOIN SMSPackages_All SP ON DPSD.PackageID = SP.PkgID
  WHERE DPSD.LastStatusTime < DATEAdd(dd,-3,GETDate())
  AND MessageState = 4
  ```

- Count of all states

  ```sql
  SELECT MessageState,
  COUNT(MessageState) AS [Count]
  FROM vSMS_DPStatusDetails
  WHERE PackageID <> ''
  GROUP BY MessageState
  ```

- Counts of package states per DP

  ```sql
  SELECT DPName,
  CASE
      WHEN MessageState = 1 THEN 'Success'
      WHEN MessageState = 2 THEN 'InProgress'
      WHEN MessageState = 4 THEN 'Failed'
  END AS [State],  
  COUNT(MessageState) AS [Count]
  FROM vSMS_DPStatusDetails
  WHERE PackageID <> ''
  AND DPName = 'PS1DP1.CONTOSO.COM'
  GROUP BY DPName, MessageState
  ORDER BY DPName
  ```

- State of all DPs for a given package  

  ```sql
  SELECT DPName,
  CASE
      WHEN MessageState = 1 THEN 'Success'
      WHEN MessageState = 2 THEN 'InProgress'
      WHEN MessageState = 4 THEN 'Failed'
  END AS [State]
  FROM vSMS_DPStatusDetails
  WHERE PackageID = '<PackageID>'
  GROUP BY DPName, MessageState
  ORDER BY State
  ```

- Count of DP states per package

  ```sql
  SELECT  
  CASE
      WHEN MessageState = 1 THEN 'Success'
      WHEN MessageState = 2 THEN 'InProgress'
      WHEN MessageState = 4 THEN 'Failed'
  END AS [State],
  COUNT(MessageState) AS [Count]
  FROM vSMS_DPStatusDetails
  WHERE PackageID = '<PackageID>'
  GROUP BY MessageState
  ```

- Package/DP current state

  ```sql
  SELECT distinct DPSD.DPName, DPSD.PackageID, SP.Name, DPSD.LastStatusTime, DPSD.SiteCode, DPSD.MessageState,
  CASE
      WHEN MessageState = 1 THEN 'Success'
      WHEN MessageState = 2 THEN 'InProgress'
      WHEN MessageState = 4 THEN 'Failed'
  END AS [State]
  FROM vSMS_DPStatusDetails DPSD
  JOIN SMSPackages_All SP ON DPSD.PackageID = SP.PkgID
  WHERE DPName = 'PS1DP1.CONTOSO.COM'
  AND DPSD.PackageID = '<PackageID>'
  ```

### Finding orphaned DP references

The query below can be used to identify if there are any orphaned rows left in the database for a DP that is no longer in the environment. There could be orphaned rows if the DP was not removed properly.

```sql
DECLARE @DPName NVARCHAR(100)
SET @DPName = 'PS1DP.CONTOSO.COM'
SELECT * FROM ContentDPMap WHERE ServerName = @DPName
SELECT * FROM DistributionPoints WHERE ServerName = @DPName
SELECT * FROM DPInfo WHERE ServerName = @DPName
SELECT * FROM PkgServers_G WHERE NALPath like '%' + @DPName + '%'
SELECT * FROM PkgServers_L WHERE NALPath like '%' + @DPName + '%'
SELECT * FROM PkgStatus_G WHERE PkgServer like '%' + @DPName + '%'
SELECT * FROM PkgStatus_L WHERE PkgServer like '%' + @DPName + '%'
SELECT * FROM SysResList WHERE RoleName = 'SMS Distribution Point' AND ServerName = @DPName
SELECT * FROM SC_SysResUse WHERE NALPath like '%' + @DPName + '%' AND RoleTypeID = 3
```

Similar query for a specific DP in a specific site:

```sql
DECLARE @DPName NVARCHAR(100)
DECLARE @DPSiteCode NVARCHAR(3)
SET @DPName = 'DPNAME.CONTOSO.COM'
SET @DPSiteCode = 'PS1'

SELECT * FROM ContentDPMap WHERE ServerName = @DPName AND SiteCode = @DPSiteCode
SELECT * FROM DistributionPoints WHERE ServerName = @DPName AND SMSSiteCode = @DPSiteCode
SELECT * FROM DPInfo WHERE ServerName = @DPName AND SiteCode = @DPSiteCode
SELECT * FROM PkgServers_L WHERE NALPath like '%' + @DPName + '%' AND SiteCode = @DPSiteCode
SELECT * FROM PkgServers_G WHERE NALPath like '%' + @DPName + '%' AND SiteCode = @DPSiteCode
SELECT * FROM PkgStatus_L WHERE PkgServer like '%' + @DPName + '%' AND SiteCode = @DPSiteCode
SELECT * FROM PkgStatus_G WHERE PkgServer like '%' + @DPName + '%' AND SiteCode = @DPSiteCode
SELECT * FROM SysResList WHERE RoleName = 'SMS Distribution Point' AND ServerName = @DPName AND SiteCode = @DPSiteCode
SELECT * FROM SC_SysResUse WHERE NALPath like '%' + @DPName + '%SMS_SITE=' + @DPSiteCode +  '%' AND RoleTypeID = 3
```

### Site Control File (SCF) properties

- SCF properties for DistMgr for current site

  ```sql
  SELECT SD.SiteCode, SC.ComponentName, SCP.Name, SCP.Value1, SCP.Value2, SCP.Value3
  FROM SC_Component SC
  JOIN SC_SiteDefinition SD ON SD.SiteNumber = SC.SiteNumber
  JOIN SC_Component_Property SCP ON SCP.ComponentID = SC.ID
  WHERE SD.SiteCode = dbo.fnGetSiteCode() AND SC.ComponentName = 'SMS_DISTRIBUTION_MANAGER'
  ```

- SCF properties for a DP

  ```sql
  SELECT SRU.RoleName, SRU.ServerName, SRUP.* FROM vSMS_SC_SysResUse SRU
  JOIN vSMS_SC_SysResUse_Properties SRUP ON SRU.ID = SRUP.ID
  WHERE SRU.RoleName = 'SMS Distribution Point'
  AND SRU.ServerName = 'PS1DP1.CONTOSO.COM'
  ```

### Packages containing specified software update

List all packages containing the given update Unique ID.

```sql
SELECT distinct UI.ArticleID, CI.CI_UniqueID, CP.PkgID, P.Name FROM v_UpdateInfo UI
JOIN v_ConfigurationItems CI ON UI.CI_ID = CI.CI_ID
JOIN v_CIContents_All CIC ON CI.CI_ID = CIC.CI_ID
JOIN CI_ContentPackages CP ON CP.Content_ID = CIC.Content_ID
JOIN v_Package P ON CP.PkgID = P.PackageID
WHERE CI.CI_UniqueID = '<UniqueID>'
```
