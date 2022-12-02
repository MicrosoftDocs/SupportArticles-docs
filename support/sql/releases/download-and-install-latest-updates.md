---
title: Latest updates and version history for SQL Server
description: This article lists various builds or updates that are available for different versions of SQL Server.
ms.date: 10/15/2022
ms.custom: sap:Installation, Patching and Upgrade
ms.topic: how-to
ms.prod: sql
---

<!---Internal note: The screenshots in the article are being or were already updated. Please contact "gsprad" and "christys" for triage before making the further changes to the screenshots.
--->

# Latest updates and version history for SQL Server

This article lists various builds or updates that are available for different versions of SQL Server.

_Original product version:_ &nbsp; SQL Server  
_Original KB number:_ &nbsp; 321185

## Summary

- A downloadable version of an Excel workbook that contains all the build versions together with their current support lifecycle stage for 2005 through the current version is available. The Excel file also contains detailed fix lists for SQL Server 2019 and SQL Server 2017. **[Click to download this new Excel file now](https://download.microsoft.com/download/d/6/5/d6583d78-9956-45c1-901d-eff8b5270896/SQL%20Server%20Builds%20V4.xlsx)**.

- To learn what a specific version number of SQL Server maps to, or to find the KB article information for a specific cumulative update package or a service pack, search for the version number in the [SQL Server Complete Version](#sql-server-complete-version-list-tables) list tables.

- To find the edition of your SQL Server instance, you can use one of the procedures in Method 2 through Method 5 in the [Determine which version and edition of SQL Server Database Engine is running](find-my-sql-version.md) section.

  > [!NOTE]
  > The version information and edition information are in the same output string.

  > [!NOTE]
  > For information about SQL Server Support lifecycle, see [SQL Server support lifecycle information](/lifecycle/products/?products=sql-server&preserve-view=true).

## Latest updates available for currently supported versions of SQL Server

Each of the following links provides information for all of the applicable products and technologies.

  |Version|Latest service pack|Latest GDR|Latest cumulative update|
  |---|---|---|---|
|**SQL Server 2022**<br/><br/>- [Build information](#sql-server-2022)<br/>- [Installation](/sql/database-engine/install-windows/install-sql-server?view=sql-server-ver16&preserve-view=true)|None|None |None |
  |**SQL Server 2019**<br/><br/>- [Build information](#sql-server-2019)<br/>- [Installation](/sql/database-engine/install-windows/install-sql-server?view=sql-server-ver15&preserve-view=true)|None|[GDR](https://support.microsoft.com/help/5014356) (15.0.2095.3 - June 2022)|[CU18 for 2019](https://support.microsoft.com/help/5017593) (15.0.4261.1 - September 2022)<br/><br/>[CU16 + GDR](https://support.microsoft.com/help/5014353) (15.0.4236.7 - June 2022)|
  |**SQL Server 2017**<br/><br/>- [Build information](#sql-server-2017)<br/>- [Installation](/sql/database-engine/install-windows/install-sql-server?view=sql-server-ver15&preserve-view=true)|None|[GDR](https://support.microsoft.com/help/5014354) (14.0.2042.3 - June 2022)|[CU31 for 2017](https://support.microsoft.com/help/5016884) (14.0.3456.2 - September 2022)<br/><br/>[CU29 + GDR](https://support.microsoft.com/help/5014553) (14.0.3445.2 - June 2022)|
  |**SQL Server 2016**<br/><br/>- [Build information](#sql-server-2016)<br/>- [Installation](/sql/database-engine/install-windows/install-sql-server?view=sql-server-ver15&preserve-view=true)|[Azure Connect pack](https://support.microsoft.com/help/5014242) (13.0.7000.253 - May 2022)<br/><br/>[SP3](https://support.microsoft.com/help/5003279) (13.0.6300.2 - September 2021)<br/><br/>[SP2](https://support.microsoft.com/help/4052908) (13.0.5026.0 - April 2018)<br/><br/>[SP1](https://support.microsoft.com/help/3182545) (13.0.4001.0 - November 2016)|[GDR for Azure Connect pack](https://support.microsoft.com/help/5015371) (13.0.7016.1 - June 2022)<br/><br/>[GDR for SP3](https://support.microsoft.com/help/5014355) (13.0.6419.1 - June 2022)<br/><br/>[GDR for SP2](https://support.microsoft.com/help/5014365) (13.0.5108.50 - June 2022)<br/><br/>[GDR for SP1](https://support.microsoft.com/help/4505219) (13.0.4259.0 - July 2019)<br/><br/>[GDR for RTM](https://support.microsoft.com/help/4058560) (13.0.1745.2 - January 2018)|[CU17 + GDR for SP2](https://support.microsoft.com/help/5014351) (13.0.5893.48 - June 2022)<br/><br/>[CU17 for 2016 SP2](https://support.microsoft.com/help/5001092) (13.0.5888.11 - March 2021)<br/><br/>[CU15 + GDR for SP1](https://support.microsoft.com/help/4505221) (13.0.4604.0 - July 2019)<br/><br/>[CU15 for SP1](https://support.microsoft.com/help/4495257) (13.0.4574.0 - May 2019)<br/><br/>[CU9 for RTM](https://support.microsoft.com/help/4037357) (13.0.2216.0 - November 2017)|
  |**SQL Server 2014**<br/><br/>- [Build information](#sql-server-2014)<br/>- [Installation](https://www.microsoft.com/download/details.aspx?id=42299)|[SP3](https://support.microsoft.com/help/4022619) (12.0.6024.0 - October 2018)<br/><br/>[SP2](https://support.microsoft.com/help/3171021) (12.0.5000.0 - July 2016)<br/><br/>[SP1](https://support.microsoft.com/help/3058865) (12.0.4100.1 - May 2015)|[GDR for SP3](https://support.microsoft.com/help/5014165) (12.0.6169.19 - June 2022)<br/><br/>[GDR for SP2](https://support.microsoft.com/help/4505217) (12.0.5223.6 - July 2019)<br/><br/>[GDR for SP1](https://support.microsoft.com/help/4019091) (August 2017)<br/><br/>[MS 15-058](/security-updates/SecurityBulletins/2015/ms15-058) (July 2015)|[CU4 + GDR for SP3](https://support.microsoft.com/help/5014164) (12.0.6439.10 - June 2022)<br/><br/>[CU4 for SP3](https://support.microsoft.com/help/4500181) (12.0.6329.1 - July 2019)<br/><br/>[CU18 for SP2](https://support.microsoft.com/help/4500180) (12.0.5687.1 - July 2019)<br/><br/>[CU13 for SP1](https://support.microsoft.com/help/4019099) (12.0.4522.0 - August 2017)|
  |**SQL Server 2012**<br/><br/>- [Build information](#sql-server-2012)<br/>- [Installation](/previous-versions/sql/sql-server-2012/cc281837(v=sql.110))| [SP4](https://support.microsoft.com/help/4018073) (11.0.7001.0 - September 2017)<br/><br/>[SP3](https://support.microsoft.com/help/3072779) (11.0.6020.0 - November 2015)<br/><br/>[SP2](https://support.microsoft.com/help/2958429) (11.0.5058.0 - June 2014)<br/><br/>[SP1](https://support.microsoft.com/help/2674319) (11.0.3000.00 - November 2012|[GDR for SP4](https://support.microsoft.com/help/4583465) (11.0.7507.2 - January 2021)<br/><br/>[GDR for SP3](https://support.microsoft.com/help/4057115) (January 2018)<br/><br/>[MS 16-136](/security-updates/SecurityBulletins/2016/ms16-136) (November 2016)<br/><br/>[MS 15-058](/security-updates/SecurityBulletins/2015/ms15-058) (December 2015)|[CU10 for SP3](https://support.microsoft.com/help/4025925) (11.0.6607.3 - August 2017)<br/><br/>[CU16 for SP2](https://support.microsoft.com/help/3205054) (11.0.5678.0 - January 2017)<br/><br/>[CU16 for SP1](https://support.microsoft.com/help/3052476) (11.0.3487.0 - May 2015)|
  |**SQL&nbsp;Server&nbsp;2008&nbsp;R2**<br/><br/>- [Build information](#sql-server-2008-r2)<br/>- [Installation](https://www.microsoft.com/download/details.aspx?id=44271)|[SP3](https://support.microsoft.com/help/2979597) (10.50.6000.34 - September 2014)<br/><br/>[SP2](https://support.microsoft.com/help/2630458) (10.50.4000.0 - July 2012)|[GDR for SP3](https://support.microsoft.com/help/4057113) (January 2018)<br/><br/>[MS 15-058](/security-updates/SecurityBulletins/2015/ms15-058) (July 2015)|None|
  |**SQL Server 2008**<br/><br/>- [Build information](#sql-server-2008)<br/>- [Servicing](/previous-versions/sql/sql-server-2008/dd638062(v=sql.100))|[SP4](https://support.microsoft.com/help/2979596) (10.0.6000.29 - September 2014)<br/><br/>[SP3](https://support.microsoft.com/help/2546951) (10.00.5500.00 - October 2011)|[GDR for SP4](https://support.microsoft.com/help/4057114) (January 2018)<br/><br/>[MS 15-058](/security-updates/SecurityBulletins/2015/ms15-058) (July 2015)|None|

  > [!NOTE]
  > "Latest" = During the past 12 months

## SQL Server complete version list tables

> [!NOTE]
> These tables use the following format and are ordered by the build number.

### SQL Server 2022

|Build number or version|Service pack|Update|KB article|Release date|
|---|---|---|---|---|
|16.0.1000.6|None|RTM|NA|November 16, 2022|

### SQL Server 2019

|Build number or version|Service pack|Update|KB article|Release date|
|---|---|---|---|---|
|15.0.4261.1|None|CU18| [5017593](https://support.microsoft.com/help/5017593)|September 28, 2022|
|15.0.4249.2|None|CU17| [5016394](https://support.microsoft.com/help/5016394)|August 11, 2022|
|15.0.4236.7|None|CU16 + GDR| [5014353](https://support.microsoft.com/help/5014353)|June 14, 2022|
|15.0.2095.3|None| GDR| [5014356](https://support.microsoft.com/help/5014356)|June 14, 2022|
|15.0.4223.1|None|CU16| [5011644](https://support.microsoft.com/help/5011644)|April 18, 2022|
|15.0.4198.2|None|CU15| [5008996](https://support.microsoft.com/help/5008996)|January 27, 2022|
|15.0.4188.2|None|CU14| [5007182](https://support.microsoft.com/help/5007182)|November 22, 2021|
|15.0.4178.1|None|CU13| [5005679](https://support.microsoft.com/help/5005679)|October 05, 2021|
|15.0.4153.1|None|CU12| [5004524](https://support.microsoft.com/help/5004524)|August 04, 2021|
|15.0.4138.2|None|CU11| [5003249](https://support.microsoft.com/help/5003249)|June 10, 2021|
|15.0.4123.1|None|CU10| [5001090](https://support.microsoft.com/help/5001090)|April 06, 2021|
|15.0.4102.2|None|CU9| [5000642](https://support.microsoft.com/help/5000642)|February 11, 2021|
|15.0.4083.2|None|CU8 + GDR| [4583459](https://support.microsoft.com/help/4583459)|January 12, 2021|
|15.0.2080.9|None| GDR| [4583458](https://support.microsoft.com/help/4583458)|January 12, 2021|
|15.0.4073.23|None|CU8| [4577194](https://support.microsoft.com/help/4577194)|September 30, 2020|
|15.0.4063.15|None|CU7| [4570012](https://support.microsoft.com/help/4570012)|September 02, 2020|
|15.0.4053.23|None|CU6| [4563110](https://support.microsoft.com/help/4563110)|August 04, 2020|
|15.0.4043.16|None|CU5| [4552255](https://support.microsoft.com/help/4552255)|June 22, 2020|
|15.0.4033.1|None|CU4| [4548597](https://support.microsoft.com/help/4548597)|March 31, 2020|
|15.0.4023.6|None| CU3| [4538853](https://support.microsoft.com/help/4538853)|March 12, 2020|
|15.0.4013.40|None| CU2| [4536075](https://support.microsoft.com/help/4536075)|February 13, 2020|
|15.0.4003.23|None| CU1| [4527376](https://support.microsoft.com/help/4527376)|January 07, 2020|
|15.0.2070.41|None| GDR| [4517790](https://support.microsoft.com/help/4517790)|November 04, 2019|
|15.0.2000.5|None| RTM|NA|November 04, 2019|

### SQL Server 2017

|Build number or version|Service pack|Update|KB article|Release date|
|---|---|---|---|---|
|14.0.3456.2|None| CU31| [5016884](https://support.microsoft.com/help/5016884)|September 20, 2022|
|14.0.3451.2|None| CU30| [5013756](https://support.microsoft.com/help/5013756)|July 13, 2022|
|14.0.3445.2|None| CU29 + GDR| [5014553](https://support.microsoft.com/help/5014553)|June 14, 2022|
|14.0.2042.3|None| GDR| [5014354](https://support.microsoft.com/help/5014354)|June 14, 2022|
|14.0.3436.1|None| CU29| [5010786](https://support.microsoft.com/help/5010786)|March 30, 2022|
|14.0.3430.2|None| CU28| [5008084](https://support.microsoft.com/help/5008084)|January 13, 2022|
|14.0.3421.10|None| CU27| [5006944](https://support.microsoft.com/help/5006944)|October 27, 2021|
|14.0.3411.3|None| CU26| [5005226](https://support.microsoft.com/help/5005226)|September 14, 2021|
|14.0.3401.7|None| CU25| [5003830](https://support.microsoft.com/help/5003830)|July 12, 2021|
|14.0.3391.2|None| CU24| [5001228](https://support.microsoft.com/help/5001228)|May 10, 2021|
|14.0.3381.3|None| CU23| [5000685](https://support.microsoft.com/help/5000685)|February 24, 2021|
|14.0.3370.1|None| CU22 + GDR| [4583457](https://support.microsoft.com/help/4583457)|January 12, 2021|
|14.0.2037.2|None| GDR| [4583456](https://support.microsoft.com/help/4583456)|January 12, 2021|
|14.0.3356.20|None| CU22| [4577467](https://support.microsoft.com/help/4577467)|September 10, 2020|
|14.0.3335.7|None| CU21| [4557397](https://support.microsoft.com/help/4557397)|July 01, 2020|
|14.0.3294.2| None| CU20| [4541283](https://support.microsoft.com/help/4541283)|April 07, 2020|
| 14.0.3281.6| None| CU19| [4535007](https://support.microsoft.com/help/4535007)|February 05, 2020|
|14.0.3257.3|None| CU18| [4527377](https://support.microsoft.com/help/4527377)|December 09, 2019|
|14.0.3238.1|None| CU17| [4515579](https://support.microsoft.com/help/4515579)|October 08, 2019|
| 14.0.3223.3|None| CU16| [4508218](https://support.microsoft.com/help/4508218)|August 01, 2019|
|14.0.3192.2|None| CU15 + GDR| [4505225](https://support.microsoft.com/help/4505225)|July 09, 2019|
|14.0.2027.2|None| GDR| [4505224](https://support.microsoft.com/help/4505224)|July 09, 2019|
|14.0.3162.1|None| CU15| [4498951](https://support.microsoft.com/help/4498951)|May 23, 2019|
|14.0.3103.1|None| CU14 + GDR| [4494352](https://support.microsoft.com/help/4494352)|May 14, 2019|
|14.0.2014.14|None| GDR| [4494351](https://support.microsoft.com/help/4494351)|May 14, 2019|
|14.0.3076.1|None| CU14| [4484710](https://support.microsoft.com/help/4484710)|March 25, 2019|
|14.0.3048.4|None| CU13| [4466404](https://support.microsoft.com/help/4466404)|December 18, 2018|
|14.0.3045.24|None| CU12| [4464082](https://support.microsoft.com/help/4464082)|October 24, 2018|
|14.0.3038.14|None| CU11| [4462262](https://support.microsoft.com/help/4462262)|September 20, 2018|
|14.0.3037.1|None| CU10| [4342123](https://support.microsoft.com/help/4342123)|August 27, 2018|
|14.0.2002.14|None| GDR| [4293803](https://support.microsoft.com/help/4293803)|August 14, 2018|
|14.0.3035.2|None| CU9 + GDR| [4293805](https://support.microsoft.com/help/4293805)|August 14, 2018|
|14.0.3030.27|None| CU9| [4341265](https://support.microsoft.com/help/4341265)|July 18, 2018|
|14.0.3029.16|None| CU8| [4338363](https://support.microsoft.com/help/4338363)|June 21, 2018|
|14.0.3026.27|None| CU7| [4229789](https://support.microsoft.com/help/4229789)|May 23, 2018|
|14.0.3025.34|None| CU6| [4101464](https://support.microsoft.com/help/4101464)|April 17, 2018|
|14.0.3023.8|None| CU5| [4092643](https://support.microsoft.com/help/4092643)|March 20, 2018|
|14.0.3022.28|None| CU4| [4056498](https://support.microsoft.com/help/4056498)|February 20, 2018|
|14.0.3015.40|None| CU3 + GDR| [4058562](https://support.microsoft.com/help/4058562)|January 03, 2018|
|14.0.3015.40|None| CU3| [4052987](https://support.microsoft.com/help/4052987)|January 03, 2018|
|14.0.2000.63|None| GDR| [4057122](https://support.microsoft.com/help/4057122)|January 03, 2018|
|14.0.3008.27|None| CU2| [4052574](https://support.microsoft.com/help/4052574)|November 28, 2017|
|14.0.3006.16|None| CU1| [4038634](https://support.microsoft.com/help/4038634)|October 24, 2017|

### SQL Server 2016

|Build number or version|Service pack|Update|KB article|Release date|
|---|---|---|---|---|
|13.0.6419.1|SP3|GDR|[5014355](https://support.microsoft.com/help/5014355)|June 14, 2022|
|13.0.7016.1|SP3|Azure Connect pack + GDR|[5015371](https://support.microsoft.com/help/5015371)|June 14, 2022|
|13.0.7000.253|SP3|Azure Connect pack|[5014242](https://support.microsoft.com/help/5014242)|May 19, 2022|
|13.0.6300.2|SP3|RTW/PCU3|[5003279](https://support.microsoft.com/help/5003279)|September 15, 2021|
|13.0.5893.48|SP2|CU17 + GDR|[5014351](https://support.microsoft.com/help/5014351)|June 14, 2022|
|13.0.5108.50|SP2|GDR|[5014365](https://support.microsoft.com/help/5014365)|June 14, 2022|
|13.0.5888.11|SP2|CU17|[5001092](https://support.microsoft.com/help/5001092)|March 29, 2021|
|13.0.5882.1|SP2|CU16| [5000645](https://support.microsoft.com/help/5000645)|February 11, 2021|
|13.0.5865.1|SP2|CU15 + GDR| [4583461](https://support.microsoft.com/help/4583461)|January 12, 2021|
|13.0.5103.6|SP2|GDR|[4583460](https://support.microsoft.com/help/4583460)|January 12, 2021|
|13.0.5850.14|SP2|CU15| [4577775](https://support.microsoft.com/help/4577775)|September 28, 2020|
|13.0.5830.85|SP2|CU14| [4564903](https://support.microsoft.com/help/4564903)|August 06, 2020|
|13.0.5820.21|SP2|CU13| [4549825](https://support.microsoft.com/help/4549825)|May 28, 2020|
|13.0.5698.0|SP2|CU12| [4536648](https://support.microsoft.com/help/4536648)|February 24, 2020|
|13.0.5622.0|SP2|CU11 + GDR| [4535706](https://support.microsoft.com/help/4535706)|February 11, 2020|
|13.0.5102.14|SP2|GDR|[4532097](https://support.microsoft.com/help/4532097)|February 11, 2020|
|13.0.5598.27|SP2|CU11| [4527378](https://support.microsoft.com/help/4527378)|December 09, 2019|
|13.0.5492.2| SP2|CU10| [4524334](https://support.microsoft.com/help/4524334)|October 08, 2019|
| 13.0.5426.0|SP2|CU8| [4505830](https://support.microsoft.com/help/4505830)|July 31, 2019|
|13.0.5366.0|SP2| CU7 + GDR| [4505222](https://support.microsoft.com/help/4505222)|July 9, 2019|
|13.0.5101.9|SP2|GDR|[4505220](https://support.microsoft.com/help/4505220)|July 9, 2019|
|13.0.5337.0|SP2|CU7| [4495256](https://support.microsoft.com/help/4495256)|May 22, 2019|
|13.0.5292.0|SP2| CU6| [4488536](https://support.microsoft.com/help/4488536)|March 19, 2019|
|13.0.5264.1|SP2| CU5| [4475776](https://support.microsoft.com/help/4475776)|January 23, 2019|
|13.0.5233.0|SP2| CU4| [4464106](https://support.microsoft.com/help/4464106)|November 13, 2018|
|13.0.5216.0|SP2| CU3| [4458871](https://support.microsoft.com/help/4458871)|September 20, 2018|
|13.0.5201.2|SP2| CU2 + Security Update| [4458621](https://support.microsoft.com/help/4458621)| August 21, 2018|
|13.0.5081.1|SP2|GDR|[4293802](https://support.microsoft.com/help/4293802)|August 14, 2018|
|13.0.5153.0|SP2| CU2| [4340355](https://support.microsoft.com/help/4340355)| July 16 2018|
|13.0.5149.0|SP2| CU1| [4135048](https://support.microsoft.com/help/4135048)|May 30, 2018|
|13.0.5026.0|SP2| RTW/PCU2| [4052908](https://support.microsoft.com/help/4052908)|April 24, 2018|
|13.0.4604.0|SP1| CU15 + GDR| [4505221](https://support.microsoft.com/help/4505221)|July 9, 2019|
|13.0.4259.0|SP1|GDR|[4505219](https://support.microsoft.com/help/4505219)|July 9, 2019|
|13.0.4574.0|SP1|CU15| [4495257](https://support.microsoft.com/help/4495257)|May 16, 2019|
|13.0.4560.0|SP1| CU14| [4488535](https://support.microsoft.com/help/4488535)|March 19, 2019|
|13.0.4550.1|SP1| CU13| [4475775](https://support.microsoft.com/help/4475775)|January 23, 2019|
|13.0.4541.0|SP1| CU12| [4464343](https://support.microsoft.com/help/4464343)|November 13, 2018|
|13.0.4528.0|SP1| CU11| [4459676](https://support.microsoft.com/help/4459676)|September 17, 2018|
|13.0.4224.16|SP1|GDR|[4458842](https://support.microsoft.com/help/4458842)|August 22, 2018|
|13.0.4522.0|SP1| CU10 + Security Update| [4293808](https://support.microsoft.com/help/4293808)|August 14, 2018|
|13.0.4514.0|SP1| CU10| [4341569](https://support.microsoft.com/help/4341569)|July 16, 2018|
|13.0.4502.0|SP1| CU9| [4100997](https://support.microsoft.com/help/4100997)|May 30, 2018|
|13.0.4474.0|SP1| CU8| [4077064](https://support.microsoft.com/help/4077064)|March 19, 2018|
|13.0.4466.4|SP1| CU7| [4057119](https://support.microsoft.com/help/4057119)|January 04, 2018|
|13.0.4210.6|SP1|GDR|[4057118](https://support.microsoft.com/help/4057118)|January 3, 2018|
|13.0.4457.0|SP1| CU6| [4037354](https://support.microsoft.com/help/4037354)|November 20, 2017|
|13.0.4451.0|SP1| CU5| [4040714](https://support.microsoft.com/help/4040714)|September 18, 2017|
|13.0.4446.0|SP1| CU4| [4024305](https://support.microsoft.com/help/4024305)|August 8, 2017|
|13.0.4206.0|SP1|GDR|[4019089](https://support.microsoft.com/help/4019089)|August 8, 2017|
|13.0.4435.0|SP1| CU3| [4019916](https://support.microsoft.com/help/4019916)|May 15, 2017|
|13.0.4422.0|SP1| CU2| [4013106](https://support.microsoft.com/help/4013106)|March 20, 2017|
|13.0.4411.0|SP1| CU1| [3208177](https://support.microsoft.com/help/3208177)|January 17, 2017|
|13.0.4001.0|SP1| RTW/PCU1| [3182545](https://support.microsoft.com/help/3182545)|November 16, 2016|
|13.0.1745.2|RTM|GDR|[4058560](https://support.microsoft.com/help/4058560)|January 6, 2018|
|13.0.2218.0|RTM|CU9 + GDR|[4058559](https://support.microsoft.com/help/4058559)|January 6, 2018|
|13.0.2216.0|RTM| CU9| [4037357](https://support.microsoft.com/help/4037357)|November 20, 2017|
|13.0.2213.0|RTM| CU8| [4040713](https://support.microsoft.com/help/4040713)|September 18, 2017|
|13.0.2210.0|RTM| CU7| [4024304](https://support.microsoft.com/help/4024304)|August 8, 2017|
|13.0.2204.0|RTM| CU6| [4019914](https://support.microsoft.com/help/4019914)|May 15, 2017|
|13.0.2197.0|RTM| CU5| [4013105](https://support.microsoft.com/help/4013105)|March 20, 2017|
|13.0.2193.0|RTM| CU4| [3205052](https://support.microsoft.com/help/3205052)|January 17, 2017|
|13.0.4202.2|RTM|GDR|[3210089](https://support.microsoft.com/help/3210089)|December 16, 2016|
|13.0.1728.2|RTM|CU3 + GDR|[3210111](https://support.microsoft.com/help/3210111)|December 16, 2016|
|13.0.2186.6|RTM| CU3| [3205413](https://support.microsoft.com/help/3205413)|November 16, 2016|
|13.0.2186.6|RTM|CU3 + GDR|[3194717](https://support.microsoft.com/help/3194717)|November 8, 2016|
|13.0.1722.0|RTM|GDR|[3194716](https://support.microsoft.com/help/3194716)|November 8, 2016|
|13.0.2164.0|RTM| CU2| [3182270](https://support.microsoft.com/help/3182270)|September 22, 2016|
|13.0.2149.0|RTM| CU1| [3164674](https://support.microsoft.com/help/3164674)|July 25, 2016|

### SQL Server 2014

|Build number or version|Service pack|Update|KB article|Release date|
|---|---|---|---|---|
|12.0.6439.10|SP3|CU4 + GDR| [5014164](https://support.microsoft.com/help/5014164)|June 14, 2022|
|12.0.6169.19|SP3|GDR|[5014165](https://support.microsoft.com/help/5014165)|June 14, 2022|
|12.0.6433.1|SP3|CU4 + GDR| [4583462](https://support.microsoft.com/help/4583462)|January 12, 2021|
|12.0.6164.21|SP3|GDR|[4583463](https://support.microsoft.com/help/4583463)|January 12, 2021|
|12.0.6372.1|SP3|CU4 + GDR| [4535288](https://support.microsoft.com/help/4535288)|February 11, 2020|
|12.0.6118.4|SP3|GDR|[4532095](https://support.microsoft.com/help/4532095)|February 11, 2020|
|12.0.6329.1|SP3|CU4| [4500181](https://support.microsoft.com/help/4500181)|July 29, 2019|
|12.0.6293.0|SP3|CU3 + GDR| [4505422](https://support.microsoft.com/help/4505422)|July 9, 2019|
|12.0.6108.1|SP3|GDR|[4505218](https://support.microsoft.com/help/4505218)|July 9, 2019|
|12.0.6259.0|SP3|CU3| [4491539](https://support.microsoft.com/help/4491539)|April 16, 2019|
|12.0.6214.1|SP3|CU2| [4482960](https://support.microsoft.com/help/4482960)|February 19, 2019|
|12.0.6205.1|SP3|CU1| [4470220](https://support.microsoft.com/help/4470220)|December 12, 2018|
|12.0.6024.0|SP3| RTW/PCU3| [4022619](https://support.microsoft.com/help/4022619)|October 30, 2018|
|12.0.5687.1|SP2|CU18| [4500180](https://support.microsoft.com/help/4500180)|July 29, 2019|
|12.0.5659.1|SP2|CU17 + GDR| [4505419](https://support.microsoft.com/help/4505419)|July 9, 2019|
|12.0.5223.6|SP2|GDR|[4505217](https://support.microsoft.com/help/4505217)|July 9, 2019|
|12.0.5632.1|SP2|CU17| [4491540](https://support.microsoft.com/help/4491540)|April 16, 2019|
|12.0.5626.1|SP2|CU16| [4482967](https://support.microsoft.com/help/4482967)|February 19, 2019|
|12.0.5605.1|SP2|CU15| [4469137](https://support.microsoft.com/help/4469137)|December 12, 2018|
|12.0.5600.1|SP2|CU14| [4459860](https://support.microsoft.com/help/4459860)|October 15, 2018|
|12.0.5590.1|SP2|CU13| [4456287](https://support.microsoft.com/help/4456287)|August 27, 2018|
|12.0.5589.7|SP2|CU12| [4130489](https://support.microsoft.com/help/4130489)|June 18, 2018|
|12.0.5579.0|SP2|CU11| [4077063](https://support.microsoft.com/help/4077063)|March 19, 2018|
|12.0.5571.0|SP2|CU10| [4052725](https://support.microsoft.com/help/4052725)|January 16, 2018|
|12.0.5214.6|SP2|GDR|[4057120](https://support.microsoft.com/help/4057120)|January 16, 2018|
|12.0.5563.0|SP2|CU9| [4055557](https://support.microsoft.com/help/4055557)|December 18, 2017|
|12.0.5557.0|SP2|CU8| [4037356](https://support.microsoft.com/help/4037356)|October 16, 2017|
|12.0.5556.0|SP2|CU7| [4032541](https://support.microsoft.com/help/4032541)|August 28, 2017|
|12.0.5553.0|SP2|CU6| [4019094](https://support.microsoft.com/help/4019094)|August 8, 2017 |
|12.0.5207.0|SP2|GDR|[4019093](https://support.microsoft.com/help/4019093)|August 8, 2017|
|12.0.5546.0|SP2|CU5| [4013098](https://support.microsoft.com/help/4013098)|April 17, 2017 |
|12.0.5540.0|SP2|CU4| [4010394](https://support.microsoft.com/help/4010394)|February 21, 2017 |
|12.0.5538.0|SP2|CU3| [3204388](https://support.microsoft.com/help/3204388)|December 19, 2016 |
|12.0.5532.0|SP2|GDR|[3194718](https://support.microsoft.com/help/3194718)|November 8, 2016|
|12.0.5203.0|SP2|GDR|[3194714](https://support.microsoft.com/help/3194714)|November 8, 2016|
|12.0.5522.0|SP2|CU2| [3188778](https://support.microsoft.com/help/3188778)|October 17, 2016|
|12.0.5511.0|SP2|CU1| [3178925](https://support.microsoft.com/help/3178925)|August 25, 2016|
|12.0.5000.0|SP2| RTW/PCU2| [3171021](https://support.microsoft.com/help/3171021)|July 11, 2016|
|12.0.4522.0|SP1|CU13| [4019099](https://support.microsoft.com/help/4019099)|August 8, 2017 |
|12.0.4237.0|SP1|GDR|[4019091](https://support.microsoft.com/help/4019091)|August 8, 2017|
|12.0.4511.0|SP1|CU12| [4017793](https://support.microsoft.com/help/4017793)|April 17, 2017 |
|12.0.4502.0|SP1|CU11| [4010392](https://support.microsoft.com/help/4010392)|February 21, 2017 |
|12.0.4491.0|SP1|CU10| [3204399](https://support.microsoft.com/help/3204399)|December 19, 2016 |
|12.0.4487.0|SP1|GDR|[3194722](https://support.microsoft.com/help/3194722)|November 8, 2016|
|12.0.4232.0|SP1|GDR|[3194720](https://support.microsoft.com/help/3194720)|November 8, 2016|
|12.0.4474.0|SP1|CU9| [3186964](https://support.microsoft.com/help/3186964)|October 17, 2016|
|12.0.4468.0|SP1|CU8| [3174038](https://support.microsoft.com/help/3174038)|August 15, 2016|
|12.0.4459.0|SP1|CU7| [3162659](https://support.microsoft.com/help/3162659)|June 20, 2016|
|12.0.4457.0|SP1|CU6| [3167392](https://support.microsoft.com/help/3167392)|May 30,2016|
|12.0.4449.0|SP1|CU6| [3144524](https://support.microsoft.com/help/3144524)|April 18, 2016|
|12.0.4438.0|SP1|CU5| [3130926](https://support.microsoft.com/help/3130926)|February 22, 2016|
|12.0.4436.0|SP1|CU4| [3106660](https://support.microsoft.com/help/3106660)|December 21, 2015|
|12.0.4427.24|SP1|CU3| [3094221](https://support.microsoft.com/help/3094221)|October 19, 2015|
|12.0.4422.0|SP1|CU2| [3075950](https://support.microsoft.com/help/3075950)|August 17, 2015|
|12.0.4416.0|SP1|CU1| [3067839](https://support.microsoft.com/help/3067839)|June 19, 2015|
|12.0.4213.0|SP1| MS15-058: GDR Security Update| [3070446](https://support.microsoft.com/help/3070446)|July 14, 2015|
|12.0.4100.1|SP1| RTW/PCU1| [3058865](https://support.microsoft.com/help/3058865)|May 04, 2015|
|12.0.2569.0|RTM|CU14| [3158271](https://support.microsoft.com/help/3158271)|June 20, 2016|
|12.0.2568.0|RTM|CU13| [3144517](https://support.microsoft.com/help/3144517)|April 18, 2016|
|12.0.2564.0|RTM|CU12| [3130923](https://support.microsoft.com/help/3130923)|February 22, 2016|
|12.0.2560.0|RTM|CU11| [3106659](https://support.microsoft.com/help/3106659)|December 21, 2015|
|12.0.2556.4|RTM|CU10| [3094220](https://support.microsoft.com/help/3094220)|October 19, 2015|
|12.0.2553.0|RTM|CU9| [3075949](https://support.microsoft.com/help/3075949)|August 17, 2015|
|12.0.2548.0|RTM| MS15-058: QFE Security Update| [3045323](https://support.microsoft.com/help/3045323)|July 14, 2015|
|12.0.2546.0|RTM|CU8| [3067836](https://support.microsoft.com/help/3067836)|June 19, 2015|
|12.0.2495.0|RTM|CU7| [3046038](https://support.microsoft.com/help/3046038)|April 20, 2015|
|12.0.2480.0|RTM|CU6| [3031047](https://support.microsoft.com/help/3031047)|February 16, 2015|
|12.0.2456.0|RTM|CU5| [3011055](https://support.microsoft.com/help/3011055)|December 17, 2014|
|12.0.2430.0|RTM|CU4| [2999197](https://support.microsoft.com/help/2999197)|October 21, 2014|
|12.0.2402.0|RTM|CU3| [2984923](https://support.microsoft.com/help/2984923)|August 18, 2014|
|12.0.2381.0|RTM| MS14-044: QFE Security Update| [2977316](https://support.microsoft.com/help/2977316)|August 12, 2014|
|12.0.2370.0|RTM|CU2| [2967546](https://support.microsoft.com/help/2967546)|Friday, June 27, 2014|
|12.0.2342.0|RTM|CU1| [2931693](https://support.microsoft.com/help/2931693)|April 21, 2014|
|12.0.2269.0|RTM| MS15-058: GDR Security Update| [3045324](https://support.microsoft.com/help/3045324)|July 14, 2015|
|12.0.2254.0|RTM| MS14-044: GDR Security Update| [2977315](https://support.microsoft.com/help/2977315)|August 12, 2014|
|12.0.2000.8|RTM|||April 01, 2014|

### SQL Server 2012

|Build number or version|Service pack|Update|KB article|Release date|
|---|---|---|---|---|
|11.0.7507.2|SP4| GDR Security Update| [4583465](https://support.microsoft.com/help/4583465)|January 12, 2021|
|11.0.6260.1|SP3| GDR Security Update| [4057115](https://support.microsoft.com/help/4057115)|January 16, 2018|
|11.0.7001.0|SP4| RTW/PCU4| [4018073](https://support.microsoft.com/help/4018073)|October 2, 2017|
|11.0.6607.3|SP3|CU10| [4025925](https://support.microsoft.com/help/4025925)|August 8, 2017|
|11.0.6598.0|SP3|CU9| [4016762](https://support.microsoft.com/help/4016762)|May 15, 2017|
|11.0.6594.0|SP3|CU8| [4013104](https://support.microsoft.com/help/4013104)|March 20, 2017|
|11.0.6579.0|SP3|CU7| [3205051](https://support.microsoft.com/help/3205051)|January 17, 2017|
|11.0.6567.0|SP3|CU6| [3194992](https://support.microsoft.com/help/3194992)|November 17, 2016|
|11.0.6248.0|SP3|MS16-136 GDR Security Update| [3194721](https://support.microsoft.com/help/3194721)|November 8, 2016|
|11.0.6544.0|SP3|CU5| [3180915](https://support.microsoft.com/help/3180915)|September 19, 2016|
|11.0.6540.0|SP3|CU4| [3165264](https://support.microsoft.com/help/3165264)|July 18, 2016|
|11.0.6537.0|SP3|CU3| [3152635](https://support.microsoft.com/help/3152635)|May 16, 2016|
|11.0.6523.0|SP3|CU2| [3137746](https://support.microsoft.com/help/3137746)|March 21,2016|
|11.0.6518.0|SP3|CU1| [3123299](https://support.microsoft.com/help/3123299)|January 19, 2016|
|11.0.6020.0|SP3| RTW/PCU3| [3072779](https://support.microsoft.com/help/3072779)|November 20, 2015|
|11.0.5678.0|SP2|CU16| [3205054](https://support.microsoft.com/help/3205054)|November 17, 2016|
|11.0.5676.0|SP2|CU15| [3205416](https://support.microsoft.com/help/3205416)|November 17, 2016|
|11.0.5657.0|SP2|CU14| [3180914](https://support.microsoft.com/help/3180914)|September 19, 2016|
|11.0.5655.0|SP2|CU13| [3165266](https://support.microsoft.com/help/3165266)|July 18, 2016|
|11.0.5649.0|SP2|CU12| [3152637](https://support.microsoft.com/help/3152637)|May 16, 2016|
|11.0.5646.0|SP2|CU11| [3137745](https://support.microsoft.com/help/3137745)|March 21,2016|
|11.0.5644.2|SP2|CU10| [3120313](https://support.microsoft.com/help/3120313)|January 19, 2016|
|11.0.5641.0|SP2|CU9| [3098512](https://support.microsoft.com/help/3098512)|November 16, 2015|
|11.0.5634.1|SP2|CU8| [3082561](https://support.microsoft.com/help/3082561)|September 21, 2015|
|11.0.5623.0|SP2|CU7| [3072100](https://support.microsoft.com/help/3072100)|July 20, 2015|
|11.0.5613.0|SP2| MS15-058: QFE Security Update| [3045319](https://support.microsoft.com/help/3045319)|July 14, 2015|
|11.0.5592.0|SP2|CU6| [3052468](https://support.microsoft.com/help/3052468)|May 18, 2015|
|11.0.5582.0|SP2|CU5| [3037255](https://support.microsoft.com/help/3037255)|March 16, 2015|
|11.0.5569.0|SP2|CU4| [3007556](https://support.microsoft.com/help/3007556)|January 19, 2015|
|11.0.5556.0|SP2|CU3| [3002049](https://support.microsoft.com/help/3002049)|November 17, 2014|
|11.0.5548.0|SP2|CU2| [2983175](https://support.microsoft.com/help/2983175)|September 15, 2014|
|11.0.5532.0|SP2|CU1| [2976982](https://support.microsoft.com/help/2976982)|July 23, 2014|
|11.0.5343.0|SP2| MS15-058: GDR Security Update| [3045321](https://support.microsoft.com/help/3045321)|July 14, 2015|
|11.0.5058.0|SP2| RTW/PCU2| [2958429](https://support.microsoft.com/help/2958429)|June 10, 2014|
|11.0.3513.0|SP1| MS15-058: QFE Security Update| [3045317](https://support.microsoft.com/help/3045317)|July 14, 2015|
|11.0.3482.00|SP1|CU13| [3002044](https://support.microsoft.com/help/3002044)|November 17, 2014|
|11.0.3470.00|SP1|CU12| [2991533](https://support.microsoft.com/help/2991533)|September 15, 2014|
|11.0.3460.0|SP1| MS14-044: QFE Security Update| [2977325](https://support.microsoft.com/help/2977325)|August 12, 2014|
|11.0.3449.00|SP1|CU11| [2975396](https://support.microsoft.com/help/2975396)|July 21, 2014|
|11.0.3431.00|SP1|CU10| [2954099](https://support.microsoft.com/help/2954099)|May 19, 2014|
|11.0.3412.00|SP1|CU9| [2931078](https://support.microsoft.com/help/2931078)|March 17, 2014|
|11.0.3401.00|SP1|CU8| [2917531](https://support.microsoft.com/help/2917531)|January 20, 2014|
|11.0.3393.00|SP1|CU7| [2894115](https://support.microsoft.com/help/2894115)|November 18, 2013|
|11.0.3381.00|SP1|CU6| [2874879](https://support.microsoft.com/help/2874879)|September 16, 2013|
|11.0.3373.00|SP1|CU5| [2861107](https://support.microsoft.com/help/2861107)|July 15, 2013|
|11.0.3368.00|SP1|CU4| [2833645](https://support.microsoft.com/help/2833645)|May 30, 2013|
|11.0.3349.00|SP1|CU3| [2812412](https://support.microsoft.com/help/2812412)|March 18, 2013|
|11.0.3339.00|SP1|CU2| [2790947](https://support.microsoft.com/help/2790947)|January 21, 2013|
|11.0.3321.00|SP1|CU1| [2765331](https://support.microsoft.com/help/2765331)|November 20, 2012|
|11.0.3156.00|SP1| MS15-058: GDR Security Update| [3045318](https://support.microsoft.com/help/3045318)|July 14, 2015|
|11.0.3153.00|SP1| MS14-044: GDR Security Update| [2977326](https://support.microsoft.com/help/2977326)|August 12, 2014|
|11.0.3000.00|SP1| RTW/PCU1| [2674319](https://support.microsoft.com/help/2674319)|November 7, 2012|
|11.0.2424.00|RTM|CU11| [2908007](https://support.microsoft.com/help/2908007)|December 16, 2013|
|11.0.2420.00|RTM|CU10| [2891666](https://support.microsoft.com/help/2891666)|October 21, 2013|
|11.0.2401.00|RTM|CU6| [2728897](https://support.microsoft.com/help/2728897)|February 18, 2013|
|11.0.2395.00|RTM|CU5| [2777772](https://support.microsoft.com/help/2777772)|December 17, 2012|
|11.0.2383.00|RTM|CU4| [2758687](https://support.microsoft.com/help/2758687)|October 15, 2012|
|11.0.2376.00|RTM| MS12-070: QFE Security Update| [2716441](https://support.microsoft.com/help/2716441)|October 9, 2012|
|11.0.2332.00|RTM|CU3| [2723749](https://support.microsoft.com/help/2723749)|August 31, 2012|
|11.0.2325.00|RTM|CU2| [2703275](https://support.microsoft.com/help/2703275)|June 18, 2012|
|11.0.2316.00|RTM|CU1| [2679368](https://support.microsoft.com/help/2679368)|April 12, 2012|
|11.0.2218.00|RTM| MS12-070: GDR Security Update| [2716442](https://support.microsoft.com/help/2716442)|October 9, 2012|
|11.0.2100.60|RTM|||March 6, 2012|

### SQL Server 2008 R2

|Build number or version|Service pack|Update|KB article|Release date|
|---|---|---|---|---|
|10.50.6529.00|SP3| MS15-058: QFE Security Update| [3045314](https://support.microsoft.com/help/3045314)|July 14, 2015|
|10.50.6220.00|SP3| MS15-058: QFE Security Update| [3045316](https://support.microsoft.com/help/3045316)|July 14, 2015|
|10.50.6000.34|SP3| RTW/PCU3| [2979597](https://support.microsoft.com/help/2979597)|September 26, 2014|
|10.50.4339.00|SP2| MS15-058: QFE Security Update| [3045312](https://support.microsoft.com/help/3045312)|July 14, 2015|
|10.50.4321.00|SP2| MS14-044: QFE Security Update| [2977319](https://support.microsoft.com/help/2977319)|August 14, 2014|
|10.50.4319.00|SP2|CU13| [2967540](https://support.microsoft.com/help/2967540)|June 30, 2014|
|10.50.4305.00|SP2|CU12| [2938478](https://support.microsoft.com/help/2938478)|April 21, 2014|
|10.50.4302.00|SP2|CU11| [2926028](https://support.microsoft.com/help/2926028)|February 18, 2014|
|10.50.4297.00|SP2|CU10| [2908087](https://support.microsoft.com/help/2908087)|December 17, 2013|
|10.50.4295.00|SP2|CU9| [2887606](https://support.microsoft.com/help/2887606)|October 28, 2013|
|10.50.4285.00|SP2|CU7| [2844090](https://support.microsoft.com/help/2844090)|June 17, 2013|
|10.50.4279.00|SP2|CU6| [2830140](https://support.microsoft.com/help/2830140)|April 15, 2013|
|10.50.4276.00|SP2|CU5| [2797460](https://support.microsoft.com/help/2797460)|February 18, 2013|
|10.50.4270.00|SP2|CU4| [2777358](https://support.microsoft.com/help/2777358)|December 17, 2012|
|10.50.4266.00|SP2|CU3| [2754552](https://support.microsoft.com/help/2754552)|October 15, 2012|
|10.50.4263.00|SP2|CU2| [2740411](https://support.microsoft.com/help/2740411)|August 31, 2012|
|10.50.4260.00|SP2|CU1| [2720425](https://support.microsoft.com/help/2720425)|July 24, 2012|
|10.50.4042.00|SP2| MS15-058: GDR Security Update| [3045313](https://support.microsoft.com/help/3045313)|July 14, 2015|
|10.50.4033.00|SP2| MS14-044: GDR Security Update| [2977320](https://support.microsoft.com/help/2977320)|August 12, 2014|
|10.50.4000.0|SP2| RTW/PCU2| [2630458](https://support.microsoft.com/help/2630458)|July 26, 2012|
|10.50.2881.00|SP1|CU14| [2868244](https://support.microsoft.com/help/2868244)|August 8, 2013|
|10.50.2876.00|SP1|CU13| [2855792](https://support.microsoft.com/help/2855792)|June 17, 2013|
|10.50.2874.00|SP1|CU12| [2828727](https://support.microsoft.com/help/2828727)|April 15, 2013|
|10.50.2869.00|SP1|CU11| [2812683](https://support.microsoft.com/help/2812683)|February 18, 2013|
|10.50.2866.00|SP1|CU9| [2756574](https://support.microsoft.com/help/2756574)|October 15, 2012|
|10.50.2861.00|SP1| MS12-070: QFE Security Update| [2716439](https://support.microsoft.com/help/2716439)|October 9, 2012|
|10.50.2822.00|SP1|CU8| [2723743](https://support.microsoft.com/help/2723743)|August 31, 2012|
|10.50.2817.00|SP1|CU7| [2703282](https://support.microsoft.com/help/2703282)|June 18, 2012|
|10.50.2811.00|SP1|CU6| [2679367](https://support.microsoft.com/help/2679367)|April 16, 2012|
|10.50.2806.00|SP1|CU5| [2659694](https://support.microsoft.com/help/2659694)|February 22, 2012|
|10.50.2796.00|SP1|CU4| [2633146](https://support.microsoft.com/help/2633146)|December 19, 2011|
|10.50.2789.00|SP1|CU3| [2591748](https://support.microsoft.com/help/2591748)|October 17, 2011|
|10.50.2772.00|SP1|CU2| [2567714](https://support.microsoft.com/help/2567714)|August 15, 2011|
|10.50.2769.00|SP1|CU1| [2544793](https://support.microsoft.com/help/2544793)|July 18, 2011|
|10.50.2550.00|SP1| MS12-070: GDR Security Update| [2754849](https://support.microsoft.com/help/2754849)|October 9, 2012|
|10.50.2500.0|SP1| RTW/PCU1| [2528583](https://support.microsoft.com/help/2528583)|July 12, 2011|
|10.50.1815.00|RTM|CU13| [2679366](https://support.microsoft.com/help/2679366)|April 16, 2012|
|10.50.1810.00|RTM|CU12| [2659692](https://support.microsoft.com/help/2659692)|February 21, 2012|
|10.50.1807.00|RTM|CU10| [2591746](https://support.microsoft.com/help/2591746)|October 17, 2011|
|10.50.1804.00|RTM|CU9| [2567713](https://support.microsoft.com/help/2567713)|August 15, 2011|
|10.50.1790.00|RTM| MS11-049: QFE Security Update| [2494086](https://support.microsoft.com/help/2494086)|June 14, 2011|
|10.50.1777.00|RTM|CU7| [2507770](https://support.microsoft.com/help/2507770)|April 18, 2011|
|10.50.1765.00|RTM|CU6| [2489376](https://support.microsoft.com/help/2489376)|February 21, 2011|
|10.50.1753.00|RTM|CU5| [2438347](https://support.microsoft.com/help/2438347)|December 20, 2010|
|10.50.1746.00|RTM|CU4| [2345451](https://support.microsoft.com/help/2345451)|October 18, 2010|
|10.50.1734.00|RTM|CU3| [2261464](https://support.microsoft.com/help/2261464)|August 16, 2010|
|10.50.1720.00|RTM|CU2| [2072493](https://support.microsoft.com/help/2072493)|June 21, 2010|
|10.50.1702.00|RTM|CU1| [981355](https://support.microsoft.com/help/981355)|May 18, 2010|
|10.50.1617.00|RTM| MS11-049: GDR Security Update| [2494088](https://support.microsoft.com/help/2494088)|June 14, 2011|
|10.50.1600.1|RTM|||May 10, 2010|

### SQL Server 2008

|Build number or version|Service pack|Update|KB article|Release date|
|---|---|---|---|---|
|10.00.6535.00|SP4| MS15-058: QFE Security Update| [3045308](https://support.microsoft.com/help/3045308)|July 14, 2015|
|10.00.6241.00|SP4| MS15-058: GDR Security Update| [3045311](https://support.microsoft.com/help/3045311)|July 14, 2015|
|10.00.5890.00|SP3| MS15-058: QFE Security Update| [3045303](https://support.microsoft.com/help/3045303)|July 14, 2015|
|10.00.5869.00|SP3| MS14-044: QFE Security Update| [2984340](https://support.microsoft.com/help/2984340)<br/>[2977322](https://support.microsoft.com/help/2977322)|August 12, 2014|
|10.00.5867.00|(on-demand update package)|| [2877204](https://support.microsoft.com/help/2877204)| |
|10.00.5861.00|SP3|CU17| [2958696](https://support.microsoft.com/help/2958696)|May 19, 2014|
|10.00.5852.00|SP3|CU16| [2936421](https://support.microsoft.com/help/2936421)|March 17, 2014|
|10.00.5850.00|SP3|CU15| [2923520](https://support.microsoft.com/help/2923520)|January 20, 2014|
|10.00.5848.00|SP3|CU14| [2893410](https://support.microsoft.com/help/2893410)|November 18, 2013|
|10.00.5846.00|SP3|CU13| [2880350](https://support.microsoft.com/help/2880350)|September 16, 2013|
|10.00.5844.00|SP3|CU12| [2863205](https://support.microsoft.com/help/2863205)|July 15, 2013|
|10.00.5840.00|SP3|CU11| [2834048](https://support.microsoft.com/help/2834048)|May 20, 2013|
|10.00.5835.00|SP3|CU10| [2814783](https://support.microsoft.com/help/2814783)|March 18, 2013|
|10.00.5829.00|SP3|CU9| [2799883](https://support.microsoft.com/help/2799883)|January 21, 2013|
|10.00.5828.00|SP3|CU8| [2771833](https://support.microsoft.com/help/2771833)|November 19, 2012|
|10.00.5826.00|SP3| MS12-070: QFE Security Update| [2716435](https://support.microsoft.com/help/2716435)|October 9, 2012|
|10.00.5794.00|SP3|CU7| [2738350](https://support.microsoft.com/help/2738350)|September 17, 2012|
|10.00.5788.00|SP3|CU6| [2715953](https://support.microsoft.com/help/2715953)|July 16, 2012|
|10.00.5785.00|SP3|CU5| [2696626](https://support.microsoft.com/help/2696626)|May 21, 2012|
|10.00.5768.00|SP3|CU2| [2633143](https://support.microsoft.com/help/2633143)|November 21, 2011|
|10.00.5766.00|SP3|CU1| [2617146](https://support.microsoft.com/help/2617146)|October 17, 2011|
|10.00.5538.00|SP3| MS15-058: GDR Security Update| [3045305](https://support.microsoft.com/help/3045305)|July 14, 2015|
|10.00.5520.00|SP3| MS14-044: GDR Security Update| [2977321](https://support.microsoft.com/help/2977321)|August 12, 2014|
|10.00.5512.00|SP3| MS12-070: GDR Security Update| [2716436](https://support.microsoft.com/help/2716436)|October 9, 2012|
|10.00.5500.00| SP3| RTW / PCU 3| [2546951](https://support.microsoft.com/help/2546951)|October 6, 2011|
|10.00.4371.00|SP2| MS12-070: QFE Security Update| [2716433](https://support.microsoft.com/help/2716433)|October 9, 2012|
|10.00.4332.00|SP2|CU10| [2696625](https://support.microsoft.com/help/2696625)|May 21, 2012|
|10.00.4330.00|SP2|CU9| [2673382](https://support.microsoft.com/help/2673382)|March 19, 2012|
|10.00.4326.00|SP2|CU8| [2648096](https://support.microsoft.com/help/2648096)|January 16, 2012|
|10.00.4323.00|SP2|CU7| [2617148](https://support.microsoft.com/help/2617148)|November 21, 2011|
|10.00.4321.00|SP2|CU6| [2582285](https://support.microsoft.com/help/2582285)|September 19, 2011|
|10.00.4316.00|SP2|CU5| [2555408](https://support.microsoft.com/help/2555408)|July 18, 2011|
|10.00.4311.00|SP2| MS11-049: QFE Security Update| [2494094](https://support.microsoft.com/help/2494094)|June 14, 2011|
|10.00.4285.00|SP2|CU4| [2527180](https://support.microsoft.com/help/2527180)|May 16, 2011|
|10.00.4279.00|SP2|CU3| [2498535](https://support.microsoft.com/help/2498535)|March 17, 2011|
|10.00.4266.00|SP2|CU1| [2289254](https://support.microsoft.com/help/2289254)|November 15, 2010|
|10.00.4067.00|SP2| MS12-070: GDR Security Update| [2716434](https://support.microsoft.com/help/2716434)|October 9, 2012|
|10.00.4064.00|SP2| MS11-049: GDR Security Update| [2494089](https://support.microsoft.com/help/2494089)|June 14, 2011|
|10.00.4000.00| SP2| RTW / PCU 2| [2285068](https://support.microsoft.com/help/2285068)|September 29, 2010|
|10.00.2850.0|SP1|CU16| [2582282](https://support.microsoft.com/help/2582282)|September 19, 2011|
|10.00.2847.0|SP1|CU15| [2555406](https://support.microsoft.com/help/2555406)|July 18, 2011|
|10.00.2841.0|SP1| MS11-049: QFE Security Update| [2494100](https://support.microsoft.com/help/2494100)|June 14, 2011|
|10.00.2821.00|SP1|CU14| [2527187](https://support.microsoft.com/help/2527187)|May 16, 2011|
|10.00.2816.00|SP1|CU13| [2497673](https://support.microsoft.com/help/2497673)|March 17, 2011|
|10.00.2804.00|SP1|CU11| [2413738](https://support.microsoft.com/help/2413738)|November 15, 2010|
|10.00.2775.00|SP1|CU8| [981702](https://support.microsoft.com/help/981702)|May 17, 2010|
|10.00.2746.00|SP1|CU5| [975977](https://support.microsoft.com/help/975977)|November 16, 2009|
|10.00.2734.00|SP1|CU4| [973602](https://support.microsoft.com/help/973602)|September 21, 2009|
|10.00.2723.00|SP1|CU3| [971491](https://support.microsoft.com/help/971491)|July 20, 2009|
|10.00.2714.00|SP1|CU2| [970315](https://support.microsoft.com/help/970315)|May 18, 2009|
|10.00.2710.00|SP1|CU1| [969099](https://support.microsoft.com/help/969099)|April 16, 2009|
|10.00.2573.00|SP1| MS11-049: GDR Security update| [2494096](https://support.microsoft.com/help/2494096)|June 14, 2011|
|10.00.2531.00| SP1| RTW / PCU 1||April, 2009|
|10.00.1835.00|RTM|CU10| [979064](https://support.microsoft.com/help/979064)|March 15, 2010|
|10.00.1823.00|RTM|CU8| [975976](https://support.microsoft.com/help/975976)|November 16, 2009|
|10.00.1787.00|RTM|CU3| [960484](https://support.microsoft.com/help/960484)|January 19, 2009|
|10.00.1779.00|RTM|CU2| [958186](https://support.microsoft.com/help/958186)|November 19, 2008|
|10.00.1763.00|RTM|CU1| [956717](https://support.microsoft.com/help/956717)|September 22, 2008|
|10.00.1600.22|RTM|||August 6, 2008|

### SQL Server 2005

|Build number or version|Service pack|Update|KB article|Release date|
|---|---|---|---|---|
|9.00.5324|SP4| MS12-070: QFE Security update| [2716427](https://support.microsoft.com/help/2716427)|October 9, 2012|
|9.00.5292|SP4| MS11-049: QFE Security update| [2494123](https://support.microsoft.com/help/2494123)|June 14, 2011|
|9.00.5069|SP4| MS12-070: GDR Security update| [2716429](https://support.microsoft.com/help/2716429)|October 9, 2012|
|9.00.5057|SP4| MS11-049: GDR Security update| [2494120](https://support.microsoft.com/help/2494120)|June 14, 2011|
|9.00.5000| SP4| RTW / PCU4||December 16, 2010|
|9.00.4309|SP3|CU11| [2258854](https://support.microsoft.com/help/2258854)|August 16, 2010|
|9.00.4305|SP3|CU10| [983329](https://support.microsoft.com/help/983329)|June 21, 2010|
|9.00.4285|SP3|CU8| [978915](https://support.microsoft.com/help/978915)|February 16, 2010|
|9.00.4230|SP3|CU5| [972511](https://support.microsoft.com/help/972511)|August 17, 2009|
|9.00.4226|SP3|CU4| [970279](https://support.microsoft.com/help/970279)|June 15, 2009|
|9.00.4211|SP3|CU2| [961930](https://support.microsoft.com/help/961930)|February 16, 2009|
|9.00.4060|SP3| MS11-049: GDR Security update| [2494113](https://support.microsoft.com/help/2494113)|June 14, 2011|
|9.00.4035|SP3| RTW| [955706](https://support.microsoft.com/help/955706)|December 15, 2008|
|9.00.3325|SP2|CU13| [967908](https://support.microsoft.com/help/967908)|April 20, 2009|
|9.00.3282|SP2|CU9| [953752](https://support.microsoft.com/help/953752)|August 18, 2008|
|9.00.3257|SP2|CU8| [951217](https://support.microsoft.com/help/951217)|June 16, 2008|
|9.00.3239|SP2|CU7| [949095](https://support.microsoft.com/help/949095)|April 14, 2008|
|9.00.3077|SP4| MS09-004: GDR Security update| [960089](https://support.microsoft.com/help/960089)|February 10, 2009|
|9.00.3042| SP2|| [937137](https://support.microsoft.com/help/937137)| |
|9.00.2047| SP1||| |
|9.00.1399| RTM||| |

### SQL Server 2000

|Build number or version|Version description, (KB number for that update), release date|
|---|---|
|8.00.2283|Post-SP4 hotfix for MS09-004 (971524)|
|8.00.2282|MS09-004: KB959420 October 29,2008|
|8.00.2273|MS08-040 - KB 948111 July 8, 2008|
|8.00.2040|Post-SP4 AWE fix (899761)|
|8.00.2039| SQL Server 2000 SP4 |
|8.00.1007|Update.exe Hotfix Installer Baseline 2 (891640)|
|8.00.977|Update.exe Hotfix Installer Baseline 1 (884856)|
|8.00.818|(821277)|
|8.00.765|Post SP3 hotfix rollup|
|8.00.760| SQL Server 2000 SP3 or SP3a (8.00.766 ssnetlib.dll)|
|8.00.701|Hotfix Installer v.1 released|
|8.00.534| SQL Server 2000 SP2 |
|8.00.384| SQL Server 2000 SP1 |
|8.00.194| SQL Server 2000 RTM or MSDE 2.0 |

Older versions of SQL Server

### SQL Server 7.0

Use the version number in the following table to identify the product or service pack level.

|Version number|Service pack|
|---|---|
|7.00.1063|SQL Server 7.0 Service Pack 4|
|7.00.961|SQL Server 7.0 Service Pack 3|
|7.00.842|SQL Server 7.0 Service Pack 2|
|7.00.699|SQL Server 7.0 Service Pack 1|
|7.00.623|SQL Server 7.0 RTM|

### SQL Server 6.5

Use the version number in the following table to identify the product or service pack level.

|Version number|Service pack|
|---|---|
|6.50.479|SQL Server 6.5 Service Pack 5a Update|
|6.50.416|SQL Server 6.5 Service Pack 5a|
|6.50.415|SQL Server 6.5 Service Pack 5|
|6.50.281|SQL Server 6.5 Service Pack 4|
|6.50.258|SQL Server 6.5 Service Pack 3|
|6.50.240|SQL Server 6.5 Service Pack 2|
|6.50.213|SQL Server 6.5 Service Pack 1|
|6.50.201|SQL Server 6.5 RTM|

## See also

- [Determine version information of SQL Server components and client tools](components-client-tools-versions.md)
- [Determine which version and edition of SQL Server Database Engine is running](find-my-sql-version.md)
