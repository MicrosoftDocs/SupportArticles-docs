---
title: Latest updates and version history for SQL Server
description: This article lists various builds or updates that are available for different versions of SQL Server.
ms.date: 01/11/2024
ms.custom: sap:Installation, Patching and Upgrade
ms.topic: how-to
ms.reviewer: v-six
---

<!---Internal note: The screenshots in the article are being or were already updated. Please contact "gsprad" and "christys" for triage before making the further changes to the screenshots.
--->

# Latest updates and version history for SQL Server

This article lists various builds or updates that are available for different versions of SQL Server.

_Original product version:_ &nbsp; SQL Server  
_Original KB number:_ &nbsp; 321185

## Summary

- A downloadable version of an Excel workbook that contains all the build versions together with their current support lifecycle stage for 2005 through the current version is available. The Excel file also contains detailed fix lists for SQL Server 2022, SQL Server 2019, and SQL Server 2017. **[Click to download this new Excel file now](https://aka.ms/sqlserverbuilds)**.

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
|**SQL Server 2022**<br/><br/>- [Build information](#sql-server-2022)<br/>- [Installation](/sql/database-engine/install-windows/install-sql-server?view=sql-server-ver16&preserve-view=true)|None|[GDR](https://support.microsoft.com/help/5032968) <br/>(16.0.1110.1 - January 2024) |[CU11 for 2022](sqlserver-2022/cumulativeupdate11.md) <br/>(16.0.4105.2 - January 2024) <br/><br/>[CU10 + GDR](https://support.microsoft.com/help/5033592) <br/>(16.0.4100.1 - January 2024)|
|**SQL Server 2019**<br/><br/>- [Build information](#sql-server-2019)<br/>- [Installation](/sql/database-engine/install-windows/install-sql-server?view=sql-server-ver15&preserve-view=true)|None|[GDR](https://support.microsoft.com/help/5029377) <br/>(15.0.2104.1 - October 2023)|[CU24 for 2019](sqlserver-2019/cumulativeupdate24.md) <br/>(15.0.4345.5 - December 2023)<br/><br/>[CU22 + GDR](https://support.microsoft.com/help/5029378) <br/>(15.0.4326.1 - October 2023)|
|**SQL Server 2017**<br/><br/>- [Build information](#sql-server-2017)<br/>- [Installation](/sql/database-engine/install-windows/install-sql-server?view=sql-server-ver15&preserve-view=true)|None|[GDR](https://support.microsoft.com/help/5029375) <br/>(14.0.2052.1 - October 2023)|[CU31 for 2017](sqlserver-2017/cumulativeupdate31.md) <br/>(14.0.3456.2 - September 2022)<br/><br/>[CU31 + GDR](https://support.microsoft.com/help/5029376) <br/>(14.0.3465.1 - October 2023)|
|**SQL Server 2016**<br/><br/>- [Build information](#sql-server-2016)<br/>- [Installation](/sql/database-engine/install-windows/install-sql-server?view=sql-server-ver15&preserve-view=true)|[Azure Connect pack](sqlserver-2016/servicepack3-azureconnect.md) <br/>(13.0.7000.253 - May 2022)<br/><br/>[SP3](sqlserver-2016/servicepack3.md) <br/>(13.0.6300.2 - September 2021)<br/><br/>[SP2](sqlserver-2016/servicepack2.md) <br/>(13.0.5026.0 - April 2018)<br/><br/>[SP1](sqlserver-2016/servicepack1.md) <br/>(13.0.4001.0 - November 2016)|[GDR for Azure Connect pack](https://support.microsoft.com/help/5029187) <br/>(13.0.7029.3 - October 2023)<br/><br/>[GDR for SP3](https://support.microsoft.com/help/5029186) <br/>(13.0.6435.1 - October 2023)<br/><br/>[GDR for SP2](https://support.microsoft.com/help/5014365) <br/>(13.0.5108.50 - June 2022)<br/><br/>[GDR for SP1](https://support.microsoft.com/help/4505219) <br/>(13.0.4259.0 - July 2019)<br/><br/>[GDR for RTM](https://support.microsoft.com/help/4058560) <br/>(13.0.1745.2 - January 2018)|[CU17 + GDR for SP2](https://support.microsoft.com/help/5014351) <br/>(13.0.5893.48 - June 2022)<br/><br/>[CU17 for 2016 SP2](sqlserver-2016/servicepack2-cumulativeupdate17.md) <br/>(13.0.5888.11 - March 2021)<br/><br/>[CU15 + GDR for SP1](https://support.microsoft.com/help/4505221) <br/>(13.0.4604.0 - July 2019)<br/><br/>[CU15 for SP1](sqlserver-2016/servicepack1-cumulativeupdate15.md) <br/>(13.0.4574.0 - May 2019)<br/><br/>[CU9 for RTM](sqlserver-2016/rtm-cumulativeupdate9.md) <br/>(13.0.2216.0 - November 2017)|
|**SQL Server 2014**<br/><br/>- [Build information](#sql-server-2014)<br/>- [Installation](https://www.microsoft.com/download/details.aspx?id=42299)|[SP3](https://support.microsoft.com/help/4022619) <br/>(12.0.6024.0 - October 2018)<br/><br/>[SP2](https://support.microsoft.com/help/3171021) <br/>(12.0.5000.0 - July 2016)<br/><br/>[SP1](https://support.microsoft.com/help/3058865) <br/>(12.0.4100.1 - May 2015)|[GDR for SP3](https://support.microsoft.com/help/5029184) <br/>(12.0.6179.1 - October 2023)<br/><br/>[GDR for SP2](https://support.microsoft.com/help/4505217) <br/>(12.0.5223.6 - July 2019)<br/><br/>[GDR for SP1](https://support.microsoft.com/help/4019091) <br/>(August 2017)<br/><br/>[MS15-058](/security-updates/SecurityBulletins/2015/ms15-058) <br/>(July 2015)|[CU4 + GDR for SP3](https://support.microsoft.com/help/5029185) <br/>(12.0.6449.1 - October 2023)<br/><br/>[CU4 for SP3](https://support.microsoft.com/help/4500181) <br/>(12.0.6329.1 - July 2019)<br/><br/>[CU18 for SP2](https://support.microsoft.com/help/4500180) <br/>(12.0.5687.1 - July 2019)<br/><br/>[CU13 for SP1](https://support.microsoft.com/help/4019099) <br/>(12.0.4522.0 - August 2017)|
|**SQL Server 2012**<br/><br/>- [Build information](#sql-server-2012)<br/>- [Installation](/previous-versions/sql/sql-server-2012/cc281837(v=sql.110))|[SP4](https://support.microsoft.com/help/4018073) <br/>(11.0.7001.0 - September 2017)<br/><br/>[SP3](https://support.microsoft.com/help/3072779) <br/>(11.0.6020.0 - November 2015)<br/><br/>[SP2](https://support.microsoft.com/help/2958429) <br/>(11.0.5058.0 - June 2014)<br/><br/>[SP1](https://support.microsoft.com/help/2674319) <br/>(11.0.3000.0 - November 2012)|[GDR for SP4](https://support.microsoft.com/help/5021123) <br/>(11.0.7512.11 - February 2023)<br/><br/>[GDR for SP3](https://support.microsoft.com/help/4057115) <br/>(January 2018)<br/><br/>[MS16-136](/security-updates/SecurityBulletins/2016/ms16-136) <br/>(November 2016)<br/><br/>[MS15-058](/security-updates/SecurityBulletins/2015/ms15-058) <br/>(December 2015)|[CU10 for SP3](https://support.microsoft.com/help/4025925) <br/>(11.0.6607.3 - August 2017)<br/><br/>[CU16 for SP2](https://support.microsoft.com/help/3205054) <br/>(11.0.5678.0 - January 2017)<br/><br/>[CU16 for SP1](https://support.microsoft.com/help/3052476) <br/>(11.0.3487.0 - May 2015)|
|**SQL&nbsp;Server&nbsp;2008&nbsp;R2**<br/><br/>- [Build information](#sql-server-2008-r2)<br/>- [Installation](https://www.microsoft.com/download/details.aspx?id=44271)|[SP3](https://support.microsoft.com/help/2979597) <br/>(10.50.6000.34 - September 2014)<br/><br/>[SP2](https://support.microsoft.com/help/2630458) <br/>(10.50.4000.0 - July 2012)|[GDR for SP3](https://support.microsoft.com/help/5021112) <br/>(10.50.6785.2 - February 2023)<br/><br/>[MS15-058](/security-updates/SecurityBulletins/2015/ms15-058) <br/>(July 2015)|None|
|**SQL Server 2008**<br/><br/>- [Build information](#sql-server-2008)<br/>- [Servicing](/previous-versions/sql/sql-server-2008/dd638062(v=sql.100))|[SP4](https://support.microsoft.com/help/2979596) <br/>(10.0.6000.29 - September 2014)<br/><br/>[SP3](https://support.microsoft.com/help/2546951) <br/>(10.00.5500.0 - October 2011)|[GDR for SP4](https://support.microsoft.com/help/5020863) <br/>(10.0.6814.4 - February 2023)<br/><br/>[MS15-058](/security-updates/SecurityBulletins/2015/ms15-058) <br/>(July 2015)|None|

> [!NOTE]
> "Latest" = During the past 12 months

## SQL Server complete version list tables

> [!NOTE]
> These tables use the following format and are ordered by the build number.

### SQL Server 2022

| Build number or version | Service pack | Update    | Knowledge Base number                                            | Release date       |
|-------------------------|--------------|-----------|-------------------------------------------------------|--------------------|
| 16.0.4105.2             | None         | CU11       | [KB5032679](sqlserver-2022/cumulativeupdate11.md)        | January 11, 2024   |
| 16.0.4100.1             | None         | CU10 + GDR| [KB5033592](https://support.microsoft.com/help/5033592)  | January 9, 2024   |
| 16.0.1110.1             | None         | GDR       | [KB5032968](https://support.microsoft.com/help/5032968)  | January 9, 2024   |
| 16.0.4095.4             | None         | CU10       | [KB5031778](sqlserver-2022/cumulativeupdate10.md)        | November 16, 2023   |
| 16.0.4085.2             | None         | CU9       | [KB5030731](sqlserver-2022/cumulativeupdate9.md)        | October 12, 2023   |
| 16.0.4080.1             | None         | CU8 + GDR | [KB5029503](https://support.microsoft.com/help/5029503) | October 10, 2023   |
| 16.0.1105.1             | None         | GDR       | [KB5029379](https://support.microsoft.com/help/5029379) | October 10, 2023   |
| 16.0.4075.1             | None         | CU8       | [KB5029666](sqlserver-2022/cumulativeupdate8.md)        | September 14, 2023 |
| 16.0.4065.3             | None         | CU7       | [KB5028743](sqlserver-2022/cumulativeupdate7.md)        | August 10, 2023    |
| 16.0.4055.4             | None         | CU6       | [KB5027505](sqlserver-2022/cumulativeupdate6.md)        | July 13, 2023      |
| 16.0.4045.3             | None         | CU5       | [KB5026806](sqlserver-2022/cumulativeupdate5.md)        | June 15, 2023      |
| 16.0.4035.4             | None         | CU4       | [KB5026717](sqlserver-2022/cumulativeupdate4.md)        | May 11, 2023       |
| 16.0.4025.1             | None         | CU3       | [KB5024396](sqlserver-2022/cumulativeupdate3.md)        | April 13, 2023     |
| 16.0.4015.1             | None         | CU2       | [KB5023127](sqlserver-2022/cumulativeupdate2.md)        | March 15, 2023     |
| 16.0.4003.1             | None         | CU1       | [KB5022375](sqlserver-2022/cumulativeupdate1.md)        | February 16, 2023  |
| 16.0.1050.5             | None         | GDR       | [KB5021522](https://support.microsoft.com/help/5021522) | February 14, 2023  |
| 16.0.1000.6             | None         | RTM       | NA                                                    | November 16, 2022  |

### SQL Server 2019

| Build number or version | Service pack | Update     | Knowledge Base number                                            | Release date       |
|-------------------------|--------------|------------|-------------------------------------------------------|--------------------|
| 15.0.4345.5             | None         | CU24       | [KB5031908](sqlserver-2019/cumulativeupdate24.md)       | December 14, 2023   |
| 15.0.4335.1             | None         | CU23       | [KB5030333](sqlserver-2019/cumulativeupdate23.md)       | October 12, 2023   |
| 15.0.4326.1             | None         | CU22 + GDR | [KB5029378](https://support.microsoft.com/help/5029378) | October 10, 2023   |
| 15.0.2104.1             | None         | GDR        | [KB5029377](https://support.microsoft.com/help/5029377) | October 10, 2023   |
| 15.0.4322.2             | None         | CU22       | [KB5027702](sqlserver-2019/cumulativeupdate22.md)       | August 14, 2023    |
| 15.0.4316.3             | None         | CU21       | [KB5025808](sqlserver-2019/cumulativeupdate21.md)       | June 15, 2023      |
| 15.0.4312.2             | None         | CU20       | [KB5024276](sqlserver-2019/cumulativeupdate20.md)       | April 13, 2023     |
| 15.0.4298.1             | None         | CU19       | [KB5023049](sqlserver-2019/cumulativeupdate19.md)       | February 16, 2023  |
| 15.0.4280.7             | None         | CU18 + GDR | [KB5021124](https://support.microsoft.com/help/5021124) | February 14, 2023  |
| 15.0.2101.7             | None         | GDR        | [KB5021125](https://support.microsoft.com/help/5021125) | February 14, 2023  |
| 15.0.4261.1             | None         | CU18       | [KB5017593](sqlserver-2019/cumulativeupdate18.md)       | September 28, 2022 |
| 15.0.4249.2             | None         | CU17       | [KB5016394](sqlserver-2019/cumulativeupdate17.md)       | August 11, 2022    |
| 15.0.4236.7             | None         | CU16 + GDR | [KB5014353](https://support.microsoft.com/help/5014353) | June 14, 2022      |
| 15.0.2095.3             | None         | GDR        | [KB5014356](https://support.microsoft.com/help/5014356) | June 14, 2022      |
| 15.0.4223.1             | None         | CU16       | [KB5011644](sqlserver-2019/cumulativeupdate16.md)       | April 18, 2022     |
| 15.0.4198.2             | None         | CU15       | [KB5008996](sqlserver-2019/cumulativeupdate15.md)       | January 27, 2022   |
| 15.0.4188.2             | None         | CU14       | [KB5007182](sqlserver-2019/cumulativeupdate14.md)       | November 22, 2021  |
| 15.0.4178.1             | None         | CU13       | [KB5005679](sqlserver-2019/cumulativeupdate13.md)       | October 05, 2021   |
| 15.0.4153.1             | None         | CU12       | [KB5004524](sqlserver-2019/cumulativeupdate12.md)       | August 04, 2021    |
| 15.0.4138.2             | None         | CU11       | [KB5003249](sqlserver-2019/cumulativeupdate11.md)       | June 10, 2021      |
| 15.0.4123.1             | None         | CU10       | [KB5001090](sqlserver-2019/cumulativeupdate10.md)       | April 06, 2021     |
| 15.0.4102.2             | None         | CU9        | [KB5000642](sqlserver-2019/cumulativeupdate9.md)        | February 11, 2021  |
| 15.0.4083.2             | None         | CU8 + GDR  | [KB4583459](https://support.microsoft.com/help/4583459) | January 12, 2021   |
| 15.0.2080.9             | None         | GDR        | [KB4583458](https://support.microsoft.com/help/4583458) | January 12, 2021   |
| 15.0.4073.23            | None         | CU8        | [KB4577194](sqlserver-2019/cumulativeupdate8.md)        | September 30, 2020 |
| 15.0.4063.15            | None         | CU7        | [KB4570012](sqlserver-2019/cumulativeupdate7.md)        | September 02, 2020 |
| 15.0.4053.23            | None         | CU6        | [KB4563110](sqlserver-2019/cumulativeupdate6.md)        | August 04, 2020    |
| 15.0.4043.16            | None         | CU5        | [KB4552255](sqlserver-2019/cumulativeupdate5.md)        | June 22, 2020      |
| 15.0.4033.1             | None         | CU4        | [KB4548597](sqlserver-2019/cumulativeupdate4.md)        | March 31, 2020     |
| 15.0.4023.6             | None         | CU3        | [KB4538853](sqlserver-2019/cumulativeupdate3.md)        | March 12, 2020     |
| 15.0.4013.40            | None         | CU2        | [KB4536075](sqlserver-2019/cumulativeupdate2.md)        | February 13, 2020  |
| 15.0.4003.23            | None         | CU1        | [KB4527376](sqlserver-2019/cumulativeupdate1.md)        | January 07, 2020   |
| 15.0.2070.41            | None         | GDR        | [KB4517790](https://support.microsoft.com/help/4517790) | November 04, 2019  |
| 15.0.2000.5             | None         | RTM        | NA                                                    | November 04, 2019  |

### SQL Server 2017

| Build number or version | Service pack | Update     | Knowledge Base number                                            | Release date       |
|-------------------------|--------------|------------|-------------------------------------------------------|--------------------|
| 14.0.3465.1             | None         | CU31 + GDR | [KB5029376](https://support.microsoft.com/help/5029376) | October 10, 2023   |
| 14.0.2052.1             | None         | GDR        | [KB5029375](https://support.microsoft.com/help/5029375) | October 10, 2023   |
| 14.0.3460.9             | None         | CU31 + GDR | [KB5021126](https://support.microsoft.com/help/5021126) | February 14, 2023  |
| 14.0.2047.8             | None         | GDR        | [KB5021127](https://support.microsoft.com/help/5021127) | February 14, 2023  |
| 14.0.3456.2             | None         | CU31       | [KB5016884](sqlserver-2017/cumulativeupdate31.md)       | September 20, 2022 |
| 14.0.3451.2             | None         | CU30       | [KB5013756](sqlserver-2017/cumulativeupdate30.md)       | July 13, 2022      |
| 14.0.3445.2             | None         | CU29 + GDR | [KB5014553](https://support.microsoft.com/help/5014553) | June 14, 2022      |
| 14.0.2042.3             | None         | GDR        | [KB5014354](https://support.microsoft.com/help/5014354) | June 14, 2022      |
| 14.0.3436.1             | None         | CU29       | [KB5010786](sqlserver-2017/cumulativeupdate29.md)       | March 30, 2022     |
| 14.0.3430.2             | None         | CU28       | [KB5008084](sqlserver-2017/cumulativeupdate28.md)       | January 13, 2022   |
| 14.0.3421.10            | None         | CU27       | [KB5006944](sqlserver-2017/cumulativeupdate27.md)       | October 27, 2021   |
| 14.0.3411.3             | None         | CU26       | [KB5005226](sqlserver-2017/cumulativeupdate26.md)       | September 14, 2021 |
| 14.0.3401.7             | None         | CU25       | [KB5003830](sqlserver-2017/cumulativeupdate25.md)       | July 12, 2021      |
| 14.0.3391.2             | None         | CU24       | [KB5001228](sqlserver-2017/cumulativeupdate24.md)       | May 10, 2021       |
| 14.0.3381.3             | None         | CU23       | [KB5000685](sqlserver-2017/cumulativeupdate23.md)       | February 24, 2021  |
| 14.0.3370.1             | None         | CU22 + GDR | [KB4583457](https://support.microsoft.com/help/4583457) | January 12, 2021   |
| 14.0.2037.2             | None         | GDR        | [KB4583456](https://support.microsoft.com/help/4583456) | January 12, 2021   |
| 14.0.3356.20            | None         | CU22       | [KB4577467](sqlserver-2017/cumulativeupdate22.md)       | September 10, 2020 |
| 14.0.3335.7             | None         | CU21       | [KB4557397](sqlserver-2017/cumulativeupdate21.md)       | July 01, 2020      |
| 14.0.3294.2             | None         | CU20       | [KB4541283](sqlserver-2017/cumulativeupdate20.md)       | April 07, 2020     |
| 14.0.3281.6             | None         | CU19       | [KB4535007](sqlserver-2017/cumulativeupdate19.md)       | February 05, 2020  |
| 14.0.3257.3             | None         | CU18       | [KB4527377](sqlserver-2017/cumulativeupdate18.md)       | December 09, 2019  |
| 14.0.3238.1             | None         | CU17       | [KB4515579](sqlserver-2017/cumulativeupdate17.md)       | October 08, 2019   |
| 14.0.3223.3             | None         | CU16       | [KB4508218](sqlserver-2017/cumulativeupdate16.md)       | August 01, 2019    |
| 14.0.3192.2             | None         | CU15 + GDR | [KB4505225](https://support.microsoft.com/help/4505225) | July 09, 2019      |
| 14.0.2027.2             | None         | GDR        | [KB4505224](https://support.microsoft.com/help/4505224) | July 09, 2019      |
| 14.0.3162.1             | None         | CU15       | [KB4498951](sqlserver-2017/cumulativeupdate15.md)       | May 23, 2019       |
| 14.0.3103.1             | None         | CU14 + GDR | [KB4494352](https://support.microsoft.com/help/4494352) | May 14, 2019       |
| 14.0.2014.14            | None         | GDR        | [KB4494351](https://support.microsoft.com/help/4494351) | May 14, 2019       |
| 14.0.3076.1             | None         | CU14       | [KB4484710](sqlserver-2017/cumulativeupdate14.md)       | March 25, 2019     |
| 14.0.3048.4             | None         | CU13       | [KB4466404](sqlserver-2017/cumulativeupdate13.md)       | December 18, 2018  |
| 14.0.3045.24            | None         | CU12       | [KB4464082](sqlserver-2017/cumulativeupdate12.md)       | October 24, 2018   |
| 14.0.3038.14            | None         | CU11       | [KB4462262](sqlserver-2017/cumulativeupdate11.md)       | September 20, 2018 |
| 14.0.3037.1             | None         | CU10       | [KB4342123](sqlserver-2017/cumulativeupdate10.md)       | August 27, 2018    |
| 14.0.2002.14            | None         | GDR        | [KB4293803](https://support.microsoft.com/help/4293803) | August 14, 2018    |
| 14.0.3035.2             | None         | CU9 + GDR  | [KB4293805](https://support.microsoft.com/help/4293805) | August 14, 2018    |
| 14.0.3030.27            | None         | CU9        | [KB4341265](sqlserver-2017/cumulativeupdate9.md)        | July 18, 2018      |
| 14.0.3029.16            | None         | CU8        | [KB4338363](sqlserver-2017/cumulativeupdate8.md)        | June 21, 2018      |
| 14.0.3026.27            | None         | CU7        | [KB4229789](sqlserver-2017/cumulativeupdate7.md)        | May 23, 2018       |
| 14.0.3025.34            | None         | CU6        | [KB4101464](sqlserver-2017/cumulativeupdate6.md)        | April 17, 2018     |
| 14.0.3023.8             | None         | CU5        | [KB4092643](sqlserver-2017/cumulativeupdate5.md)        | March 20, 2018     |
| 14.0.3022.28            | None         | CU4        | [KB4056498](sqlserver-2017/cumulativeupdate4.md)        | February 20, 2018  |
| 14.0.3015.40            | None         | CU3 + GDR  | [KB4058562](https://support.microsoft.com/help/4058562) | January 03, 2018   |
| 14.0.3015.40            | None         | CU3        | [KB4052987](sqlserver-2017/cumulativeupdate3.md)        | January 04, 2018   |
| 14.0.2000.63            | None         | GDR        | [KB4057122](https://support.microsoft.com/help/4057122) | January 03, 2018   |
| 14.0.3008.27            | None         | CU2        | [KB4052574](sqlserver-2017/cumulativeupdate2.md)        | November 28, 2017  |
| 14.0.3006.16            | None         | CU1        | [KB4038634](sqlserver-2017/cumulativeupdate1.md)        | October 24, 2017   |
| 14.0.1000.169           | None         | RTM        | NA                                                    | September 29, 2017 |

### SQL Server 2016

| Build number or version | Service pack | Update                   | Knowledge Base number                                            | Release date       |
|-------------------------|--------------|--------------------------|-------------------------------------------------------|--------------------|
| 13.0.7029.3             | None         | Azure Connect Pack + GDR | [KB5029187](https://support.microsoft.com/help/5029187) | October 10, 2023   |
| 13.0.6435.1             | None         | SP3 + GDR                | [KB5029186](https://support.microsoft.com/help/5029186) | October 10, 2023   |
| 13.0.6430.49            | SP3          | GDR                      | [KB5021129](https://support.microsoft.com/help/5021129) | February 14, 2023  |
| 13.0.7024.30            | SP3          | Azure Connect pack + GDR | [KB5021128](https://support.microsoft.com/help/5021128) | February 14, 2023  |
| 13.0.6419.1             | SP3          | GDR                      | [KB5014355](https://support.microsoft.com/help/5014355) | June 14, 2022      |
| 13.0.7016.1             | SP3          | Azure Connect pack + GDR | [KB5015371](https://support.microsoft.com/help/5015371) | June 14, 2022      |
| 13.0.7000.253           | SP3          | Azure Connect pack       | [KB5014242](sqlserver-2016/servicepack3-azureconnect.md) | May 19, 2022       |
| 13.0.6300.2             | SP3          | RTW/PCU3                 | [KB5003279](sqlserver-2016/servicepack3.md) | September 15, 2021 |
| 13.0.5893.48            | SP2          | CU17 + GDR               | [KB5014351](https://support.microsoft.com/help/5014351) | June 14, 2022      |
| 13.0.5108.50            | SP2          | GDR                      | [KB5014365](https://support.microsoft.com/help/5014365) | June 14, 2022      |
| 13.0.5888.11            | SP2          | CU17                     | [KB5001092](sqlserver-2016/servicepack2-cumulativeupdate17.md) | March 29, 2021     |
| 13.0.5882.1             | SP2          | CU16                     | [KB5000645](sqlserver-2016/servicepack2-cumulativeupdate16.md) | February 11, 2021  |
| 13.0.5865.1             | SP2          | CU15 + GDR               | [KB4583461](https://support.microsoft.com/help/4583461) | January 12, 2021   |
| 13.0.5103.6             | SP2          | GDR                      | [KB4583460](https://support.microsoft.com/help/4583460) | January 12, 2021   |
| 13.0.5850.14            | SP2          | CU15                     | [KB4577775](sqlserver-2016/servicepack2-cumulativeupdate15.md) | September 28, 2020 |
| 13.0.5830.85            | SP2          | CU14                     | [KB4564903](sqlserver-2016/servicepack2-cumulativeupdate14.md) | August 06, 2020    |
| 13.0.5820.21            | SP2          | CU13                     | [KB4549825](sqlserver-2016/servicepack2-cumulativeupdate13.md) | May 28, 2020       |
| 13.0.5698.0             | SP2          | CU12                     | [KB4536648](sqlserver-2016/servicepack2-cumulativeupdate12.md) | February 24, 2020  |
| 13.0.5622.0             | SP2          | CU11 + GDR               | [KB4535706](https://support.microsoft.com/help/4535706) | February 11, 2020  |
| 13.0.5102.14            | SP2          | GDR                      | [KB4532097](https://support.microsoft.com/help/4532097) | February 11, 2020  |
| 13.0.5598.27            | SP2          | CU11                     | [KB4527378](sqlserver-2016/servicepack2-cumulativeupdate11.md) | December 09, 2019  |
| 13.0.5492.2             | SP2          | CU10                     | [KB4524334](sqlserver-2016/servicepack2-cumulativeupdate10.md) | October 08, 2019   |
| 13.0.5426.0             | SP2          | CU8                      | [KB4505830](sqlserver-2016/servicepack2-cumulativeupdate8.md) | July 31, 2019      |
| 13.0.5366.0             | SP2          | CU7 + GDR                | [KB4505222](https://support.microsoft.com/help/4505222) | July 09, 2019       |
| 13.0.5101.9             | SP2          | GDR                      | [KB4505220](https://support.microsoft.com/help/4505220) | July 09, 2019       |
| 13.0.5337.0             | SP2          | CU7                      | [KB4495256](sqlserver-2016/servicepack2-cumulativeupdate7.md) | May 22, 2019       |
| 13.0.5292.0             | SP2          | CU6                      | [KB4488536](sqlserver-2016/servicepack2-cumulativeupdate6.md) | March 19, 2019     |
| 13.0.5264.1             | SP2          | CU5                      | [KB4475776](sqlserver-2016/servicepack2-cumulativeupdate5.md) | January 23, 2019   |
| 13.0.5233.0             | SP2          | CU4                      | [KB4464106](sqlserver-2016/servicepack2-cumulativeupdate4.md) | November 13, 2018  |
| 13.0.5216.0             | SP2          | CU3                      | [KB4458871](sqlserver-2016/servicepack2-cumulativeupdate3.md) | September 20, 2018 |
| 13.0.5201.2             | SP2          | CU2 + GDR                | [KB4458621](https://support.microsoft.com/help/4458621) | August 21, 2018    |
| 13.0.5081.1             | SP2          | GDR                      | [KB4293802](https://support.microsoft.com/help/4293802) | August 14, 2018    |
| 13.0.5153.0             | SP2          | CU2                      | [KB4340355](sqlserver-2016/servicepack2-cumulativeupdate2.md) | July 16 2018       |
| 13.0.5149.0             | SP2          | CU1                      | [KB4135048](sqlserver-2016/servicepack2-cumulativeupdate1.md) | May 30, 2018       |
| 13.0.5026.0             | SP2          | RTW/PCU2                 | [KB4052908](sqlserver-2016/servicepack2.md) | April 24, 2018     |
| 13.0.4604.0             | SP1          | CU15 + GDR               | [KB4505221](https://support.microsoft.com/help/4505221) | July 09, 2019       |
| 13.0.4259.0             | SP1          | GDR                      | [KB4505219](https://support.microsoft.com/help/4505219) | July 09, 2019       |
| 13.0.4574.0             | SP1          | CU15                     | [KB4495257](sqlserver-2016/servicepack1-cumulativeupdate15.md) | May 16, 2019       |
| 13.0.4560.0             | SP1          | CU14                     | [KB4488535](sqlserver-2016/servicepack1-cumulativeupdate14.md) | March 19, 2019     |
| 13.0.4550.1             | SP1          | CU13                     | [KB4475775](sqlserver-2016/servicepack1-cumulativeupdate13.md) | January 23, 2019   |
| 13.0.4541.0             | SP1          | CU12                     | [KB4464343](sqlserver-2016/servicepack1-cumulativeupdate12.md) | November 13, 2018  |
| 13.0.4528.0             | SP1          | CU11                     | [KB4459676](sqlserver-2016/servicepack1-cumulativeupdate11.md) | September 17, 2018 |
| 13.0.4224.16            | SP1          | GDR                      | [KB4458842](https://support.microsoft.com/help/4458842) | August 22, 2018    |
| 13.0.4522.0             | SP1          | CU10 + GDR               | [KB4293808](https://support.microsoft.com/help/4293808) | August 14, 2018    |
| 13.0.4514.0             | SP1          | CU10                     | [KB4341569](sqlserver-2016/servicepack1-cumulativeupdate10.md) | July 16, 2018      |
| 13.0.4502.0             | SP1          | CU9                      | [KB4100997](sqlserver-2016/servicepack1-cumulativeupdate9.md) | May 30, 2018       |
| 13.0.4474.0             | SP1          | CU8                      | [KB4077064](sqlserver-2016/servicepack1-cumulativeupdate8.md) | March 19, 2018     |
| 13.0.4466.4             | SP1          | CU7                      | [KB4057119](sqlserver-2016/servicepack1-cumulativeupdate7.md) | January 04, 2018   |
| 13.0.4210.6             | SP1          | GDR                      | [KB4057118](https://support.microsoft.com/help/4057118) | January 3, 2018    |
| 13.0.4457.0             | SP1          | CU6                      | [KB4037354](sqlserver-2016/servicepack1-cumulativeupdate6.md) | November 20, 2017  |
| 13.0.4451.0             | SP1          | CU5                      | [KB4040714](sqlserver-2016/servicepack1-cumulativeupdate5.md) | September 18, 2017 |
| 13.0.4446.0             | SP1          | CU4                      | [KB4024305](sqlserver-2016/servicepack1-cumulativeupdate4.md) | August 08, 2017     |
| 13.0.4206.0             | SP1          | GDR                      | [KB4019089](https://support.microsoft.com/help/4019089) | August 08, 2017     |
| 13.0.4435.0             | SP1          | CU3                      | [KB4019916](sqlserver-2016/servicepack1-cumulativeupdate3.md) | May 15, 2017       |
| 13.0.4422.0             | SP1          | CU2                      | [KB4013106](sqlserver-2016/servicepack1-cumulativeupdate2.md) | March 20, 2017     |
| 13.0.4411.0             | SP1          | CU1                      | [KB3208177](sqlserver-2016/servicepack1-cumulativeupdate1.md) | January 17, 2017   |
| 13.0.4001.0             | SP1          | RTW/PCU1                 | [KB3182545](sqlserver-2016/servicepack1.md) | November 16, 2016  |
| 13.0.1745.2             | RTM          | GDR                      | [KB4058560](https://support.microsoft.com/help/4058560) | January 06, 2018    |
| 13.0.2218.0             | RTM          | CU9 + GDR                | [KB4058559](https://support.microsoft.com/help/4058559) | January 06, 2018    |
| 13.0.2216.0             | RTM          | CU9                      | [KB4037357](sqlserver-2016/rtm-cumulativeupdate9.md) | November 20, 2017  |
| 13.0.2213.0             | RTM          | CU8                      | [KB4040713](sqlserver-2016/rtm-cumulativeupdate8.md) | September 18, 2017 |
| 13.0.2210.0             | RTM          | CU7                      | [KB4024304](sqlserver-2016/rtm-cumulativeupdate7.md) | August 08, 2017     |
| 13.0.2204.0             | RTM          | CU6                      | [KB4019914](sqlserver-2016/rtm-cumulativeupdate6.md) | May 15, 2017       |
| 13.0.2197.0             | RTM          | CU5                      | [KB4013105](sqlserver-2016/rtm-cumulativeupdate5.md) | March 20, 2017     |
| 13.0.2193.0             | RTM          | CU4                      | [KB3205052](sqlserver-2016/rtm-cumulativeupdate4.md) | January 17, 2017   |
| 13.0.4202.2             | RTM          | GDR                      | [KB3210089](https://support.microsoft.com/help/3210089) | December 16, 2016  |
| 13.0.1728.2             | RTM          | CU3 + GDR                | [KB3210111](https://support.microsoft.com/help/3210111) | December 16, 2016  |
| 13.0.2186.6             | RTM          | CU3                      | [KB3205413](sqlserver-2016/rtm-cumulativeupdate3.md) | November 16, 2016  |
| 13.0.2186.6             | RTM          | CU3 + GDR                | [KB3194717](https://support.microsoft.com/help/3194717) | November 08, 2016   |
| 13.0.1722.0             | RTM          | GDR                      | [KB3194716](https://support.microsoft.com/help/3194716) | November 08, 2016   |
| 13.0.2164.0             | RTM          | CU2                      | [KB3182270](sqlserver-2016/rtm-cumulativeupdate2.md) | September 22, 2016 |
| 13.0.2149.0             | RTM          | CU1                      | [KB3164674](sqlserver-2016/rtm-cumulativeupdate1.md) | July 25, 2016      |
| 13.0.1601.5             | None         | RTM                      | NA                                                    | June 1, 2016       |

### SQL Server 2014

| Build number or version | Service pack | Update                        | Knowledge Base number                                            | Release date          |
|-------------------------|--------------|-------------------------------|-------------------------------------------------------|-----------------------|
| 12.0.6449.1             | None         | SQL Server 2014 SP3 CU4 + GDR | [KB5029185](https://support.microsoft.com/help/5029185) | October 10, 2023      |
| 12.0.6179.1             | None         | SQL Server 2014 SP3 GDR       | [KB5029184](https://support.microsoft.com/help/5029184) | October 10, 2023      |
| 12.0.6444.4             | SP3          | CU4 + GDR                     | [KB5021045](https://support.microsoft.com/help/5021045) | February 14, 2023     |
| 12.0.6174.8             | SP3          | GDR                           | [KB5021037](https://support.microsoft.com/help/5021037) | February 14, 2023     |
| 12.0.6439.10            | SP3          | CU4 + GDR                     | [KB5014164](https://support.microsoft.com/help/5014164) | June 14, 2022         |
| 12.0.6169.19            | SP3          | GDR                           | [KB5014165](https://support.microsoft.com/help/5014165) | June 14, 2022         |
| 12.0.6433.1             | SP3          | CU4 + GDR                     | [KB4583462](https://support.microsoft.com/help/4583462) | January 12, 2021      |
| 12.0.6164.21            | SP3          | GDR                           | [KB4583463](https://support.microsoft.com/help/4583463) | January 12, 2021      |
| 12.0.6372.1             | SP3          | CU4 + GDR                     | [KB4535288](https://support.microsoft.com/help/4535288) | February 11, 2020     |
| 12.0.6118.4             | SP3          | GDR                           | [KB4532095](https://support.microsoft.com/help/4532095) | February 11, 2020     |
| 12.0.6329.1             | SP3          | CU4                           | [KB4500181](https://support.microsoft.com/help/4500181) | July 29, 2019         |
| 12.0.6293.0             | SP3          | CU3 + GDR                     | [KB4505422](https://support.microsoft.com/help/4505422) | July 09, 2019          |
| 12.0.6108.1             | SP3          | GDR                           | [KB4505218](https://support.microsoft.com/help/4505218) | July 09, 2019          |
| 12.0.6259.0             | SP3          | CU3                           | [KB4491539](https://support.microsoft.com/help/4491539) | April 16, 2019        |
| 12.0.6214.1             | SP3          | CU2                           | [KB4482960](https://support.microsoft.com/help/4482960) | February 19, 2019     |
| 12.0.6205.1             | SP3          | CU1                           | [KB4470220](https://support.microsoft.com/help/4470220) | December 12, 2018     |
| 12.0.6024.0             | SP3          | RTW/PCU3                      | [KB4022619](https://support.microsoft.com/help/4022619) | October 30, 2018      |
| 12.0.5687.1             | SP2          | CU18                          | [KB4500180](https://support.microsoft.com/help/4500180) | July 29, 2019         |
| 12.0.5659.1             | SP2          | CU17 + GDR                    | [KB4505419](https://support.microsoft.com/help/4505419) | July 09, 2019          |
| 12.0.5223.6             | SP2          | GDR                           | [KB4505217](https://support.microsoft.com/help/4505217) | July 09, 2019          |
| 12.0.5632.1             | SP2          | CU17                          | [KB4491540](https://support.microsoft.com/help/4491540) | April 16, 2019        |
| 12.0.5626.1             | SP2          | CU16                          | [KB4482967](https://support.microsoft.com/help/4482967) | February 19, 2019     |
| 12.0.5605.1             | SP2          | CU15                          | [KB4469137](https://support.microsoft.com/help/4469137) | December 12, 2018     |
| 12.0.5600.1             | SP2          | CU14                          | [KB4459860](https://support.microsoft.com/help/4459860) | October 15, 2018      |
| 12.0.5590.1             | SP2          | CU13                          | [KB4456287](https://support.microsoft.com/help/4456287) | August 27, 2018       |
| 12.0.5589.7             | SP2          | CU12                          | [KB4130489](https://support.microsoft.com/help/4130489) | June 18, 2018         |
| 12.0.5579.0             | SP2          | CU11                          | [KB4077063](https://support.microsoft.com/help/4077063) | March 19, 2018        |
| 12.0.5571.0             | SP2          | CU10                          | [KB4052725](https://support.microsoft.com/help/4052725) | January 16, 2018      |
| 12.0.5214.6             | SP2          | GDR                           | [KB4057120](https://support.microsoft.com/help/4057120) | January 16, 2018      |
| 12.0.5563.0             | SP2          | CU9                           | [KB4055557](https://support.microsoft.com/help/4055557) | December 18, 2017     |
| 12.0.5557.0             | SP2          | CU8                           | [KB4037356](https://support.microsoft.com/help/4037356) | October 16, 2017      |
| 12.0.5556.0             | SP2          | CU7                           | [KB4032541](https://support.microsoft.com/help/4032541) | August 28, 2017       |
| 12.0.5553.0             | SP2          | CU6                           | [KB4019094](https://support.microsoft.com/help/4019094) | August 08, 2017        |
| 12.0.5207.0             | SP2          | GDR                           | [KB4019093](https://support.microsoft.com/help/4019093) | August 08, 2017        |
| 12.0.5546.0             | SP2          | CU5                           | [KB4013098](https://support.microsoft.com/help/4013098) | April 17, 2017        |
| 12.0.5540.0             | SP2          | CU4                           | [KB4010394](https://support.microsoft.com/help/4010394) | February 21, 2017     |
| 12.0.5538.0             | SP2          | CU3                           | [KB3204388](https://support.microsoft.com/help/3204388) | December 19, 2016     |
| 12.0.5532.0             | SP2          | GDR                           | [KB3194718](https://support.microsoft.com/help/3194718) | November 08, 2016      |
| 12.0.5203.0             | SP2          | GDR                           | [KB3194714](https://support.microsoft.com/help/3194714) | November 08, 2016      |
| 12.0.5522.0             | SP2          | CU2                           | [KB3188778](https://support.microsoft.com/help/3188778) | October 17, 2016      |
| 12.0.5511.0             | SP2          | CU1                           | [KB3178925](https://support.microsoft.com/help/3178925) | August 25, 2016       |
| 12.0.5000.0             | SP2          | RTW/PCU2                      | [KB3171021](https://support.microsoft.com/help/3171021) | July 11, 2016         |
| 12.0.4522.0             | SP1          | CU13                          | [KB4019099](https://support.microsoft.com/help/4019099) | August 08, 2017        |
| 12.0.4237.0             | SP1          | GDR                           | [KB4019091](https://support.microsoft.com/help/4019091) | August 08, 2017        |
| 12.0.4511.0             | SP1          | CU12                          | [KB4017793](https://support.microsoft.com/help/4017793) | April 17, 2017        |
| 12.0.4502.0             | SP1          | CU11                          | [KB4010392](https://support.microsoft.com/help/4010392) | February 21, 2017     |
| 12.0.4491.0             | SP1          | CU10                          | [KB3204399](https://support.microsoft.com/help/3204399) | December 19, 2016     |
| 12.0.4487.0             | SP1          | GDR                           | [KB3194722](https://support.microsoft.com/help/3194722) | November 08, 2016      |
| 12.0.4232.0             | SP1          | GDR                           | [KB3194720](https://support.microsoft.com/help/3194720) | November 08, 2016      |
| 12.0.4474.0             | SP1          | CU9                           | [KB3186964](https://support.microsoft.com/help/3186964) | October 17, 2016      |
| 12.0.4468.0             | SP1          | CU8                           | [KB3174038](https://support.microsoft.com/help/3174038) | August 15, 2016       |
| 12.0.4459.0             | SP1          | CU7                           | [KB3162659](https://support.microsoft.com/help/3162659) | June 20, 2016         |
| 12.0.4457.0             | SP1          | CU6                           | [KB3167392](https://support.microsoft.com/help/3167392) | May 30, 2016          |
| 12.0.4449.0             | SP1          | CU6                           | [KB3144524](https://support.microsoft.com/help/3144524) | April 18, 2016        |
| 12.0.4438.0             | SP1          | CU5                           | [KB3130926](https://support.microsoft.com/help/3130926) | February 22, 2016     |
| 12.0.4436.0             | SP1          | CU4                           | [KB3106660](https://support.microsoft.com/help/3106660) | December 21, 2015     |
| 12.0.4427.24            | SP1          | CU3                           | [KB3094221](https://support.microsoft.com/help/3094221) | October 19, 2015      |
| 12.0.4422.0             | SP1          | CU2                           | [KB3075950](https://support.microsoft.com/help/3075950) | August 17, 2015       |
| 12.0.4416.0             | SP1          | CU1                           | [KB3067839](https://support.microsoft.com/help/3067839) | June 19, 2015         |
| 12.0.4213.0             | SP1          | MS15-058: GDR Security Update | [KB3070446](https://support.microsoft.com/help/3070446) | July 14, 2015         |
| 12.0.4100.1             | SP1          | RTW/PCU1                      | [KB3058865](https://support.microsoft.com/help/3058865) | May 04, 2015          |
| 12.0.2569.0             | RTM          | CU14                          | [KB3158271](https://support.microsoft.com/help/3158271) | June 20, 2016         |
| 12.0.2568.0             | RTM          | CU13                          | [KB3144517](https://support.microsoft.com/help/3144517) | April 18, 2016        |
| 12.0.2564.0             | RTM          | CU12                          | [KB3130923](https://support.microsoft.com/help/3130923) | February 22, 2016     |
| 12.0.2560.0             | RTM          | CU11                          | [KB3106659](https://support.microsoft.com/help/3106659) | December 21, 2015     |
| 12.0.2556.4             | RTM          | CU10                          | [KB3094220](https://support.microsoft.com/help/3094220) | October 19, 2015      |
| 12.0.2553.0             | RTM          | CU9                           | [KB3075949](https://support.microsoft.com/help/3075949) | August 17, 2015       |
| 12.0.2548.0             | RTM          | MS15-058: QFE Security Update | [KB3045323](https://support.microsoft.com/help/3045323) | July 14, 2015         |
| 12.0.2546.0             | RTM          | CU8                           | [KB3067836](https://support.microsoft.com/help/3067836) | June 19, 2015         |
| 12.0.2495.0             | RTM          | CU7                           | [KB3046038](https://support.microsoft.com/help/3046038) | April 20, 2015        |
| 12.0.2480.0             | RTM          | CU6                           | [KB3031047](https://support.microsoft.com/help/3031047) | February 16, 2015     |
| 12.0.2456.0             | RTM          | CU5                           | [KB3011055](https://support.microsoft.com/help/3011055) | December 17, 2014     |
| 12.0.2430.0             | RTM          | CU4                           | [KB2999197](https://support.microsoft.com/help/2999197) | October 21, 2014      |
| 12.0.2402.0             | RTM          | CU3                           | [KB2984923](https://support.microsoft.com/help/2984923) | August 18, 2014       |
| 12.0.2381.0             | RTM          | MS14-044: QFE Security Update | [KB2977316](https://support.microsoft.com/help/2977316) | August 12, 2014       |
| 12.0.2370.0             | RTM          | CU2                           | [KB2967546](https://support.microsoft.com/help/2967546) | Friday, June 27, 2014 |
| 12.0.2342.0             | RTM          | CU1                           | [KB2931693](https://support.microsoft.com/help/2931693) | April 21, 2014        |
| 12.0.2269.0             | RTM          | MS15-058: GDR Security Update | [KB3045324](https://support.microsoft.com/help/3045324) | July 14, 2015         |
| 12.0.2254.0             | RTM          | MS14-044: GDR Security Update | [KB2977315](https://support.microsoft.com/help/2977315) | August 12, 2014       |
| 12.0.2000.8             | RTM          |                               |                                                       | April 01, 2014        |

### SQL Server 2012

| Build number or version | Service pack | Update                        | Knowledge Base number                                            | Release date       |
|-------------------------|--------------|-------------------------------|-------------------------------------------------------|--------------------|
| 11.0.7512.11            | SP4          | GDR Security Update           | [KB5021123](https://support.microsoft.com/help/5021123) | February 14, 2023  |
| 11.0.7507.2             | SP4          | GDR Security Update           | [KB4583465](https://support.microsoft.com/help/4583465) | January 12, 2021   |
| 11.0.7493.4             | SP4          | GDR Security Update           | [KB4532098](https://support.microsoft.com/help/4532098) | February 11, 2020  |
| 11.0.7462.6             | SP4          | GDR Security Update           | [KB4057116](https://support.microsoft.com/help/4057116) | January 16, 2018   |
| 11.0.6614.2             | SP3          | QFE Security Update           | [KB4057121](https://support.microsoft.com/help/4057121) | January 16, 2018   |
| 11.0.6260.1             | SP3          | GDR Security Update           | [KB4057115](https://support.microsoft.com/help/4057115) | January 16, 2018   |
| 11.0.7001.0             | SP4          | RTW/PCU4                      | [KB4018073](https://support.microsoft.com/help/4018073) | October 2, 2017    |
| 11.0.6607.3             | SP3          | CU10                          | [KB4025925](https://support.microsoft.com/help/4025925) | August 08, 2017     |
| 11.0.6251.0             | SP3          | QFE Security Update           | [KB4019092](https://support.microsoft.com/help/4019092) | August 08, 2017     |
| 11.0.6598.0             | SP3          | CU9                           | [KB4016762](https://support.microsoft.com/help/4016762) | May 15, 2017       |
| 11.0.6594.0             | SP3          | CU8                           | [KB4013104](https://support.microsoft.com/help/4013104) | March 20, 2017     |
| 11.0.6579.0             | SP3          | CU7                           | [KB3205051](https://support.microsoft.com/help/3205051) | January 17, 2017   |
| 11.0.6567.0             | SP3          | CU6                           | [KB3194992](https://support.microsoft.com/help/3194992) | November 17, 2016  |
| 11.0.6248.0             | SP3          | MS16-136 GDR Security Update  | [KB3194721](https://support.microsoft.com/help/3194721) | November 08, 2016   |
| 11.0.6567.0             | SP3          | MS16-136 QFE Security Update  | [KB3194724](https://support.microsoft.com/help/3194724) | November 08, 2016   |
| 11.0.5388.0             | SP2          | MS16-136 GDR Security Update  | [KB3194719](https://support.microsoft.com/help/3194719) | November 08, 2016   |
| 11.0.5676.0             | SP3          | MS16-136 QFE Security Update  | [KB3194725](https://support.microsoft.com/help/3194725) | November 08, 2016   |
| 11.0.6544.0             | SP3          | CU5                           | [KB3180915](https://support.microsoft.com/help/3180915) | September 19, 2016 |
| 11.0.6540.0             | SP3          | CU4                           | [KB3165264](https://support.microsoft.com/help/3165264) | July 18, 2016      |
| 11.0.6537.0             | SP3          | CU3                           | [KB3152635](https://support.microsoft.com/help/3152635) | May 16, 2016       |
| 11.0.6523.0             | SP3          | CU2                           | [KB3137746](https://support.microsoft.com/help/3137746) | March 21,2016      |
| 11.0.6518.0             | SP3          | CU1                           | [KB3123299](https://support.microsoft.com/help/3123299) | January 19, 2016   |
| 11.0.6020.0             | SP3          | RTW/PCU3                      | [KB3072779](https://support.microsoft.com/help/3072779) | November 20, 2015  |
| 11.0.5678.0             | SP2          | CU16                          | [KB3205054](https://support.microsoft.com/help/3205054) | November 17, 2016  |
| 11.0.5676.0             | SP2          | CU15                          | [KB3205416](https://support.microsoft.com/help/3205416) | November 17, 2016  |
| 11.0.5657.0             | SP2          | CU14                          | [KB3180914](https://support.microsoft.com/help/3180914) | September 19, 2016 |
| 11.0.5655.0             | SP2          | CU13                          | [KB3165266](https://support.microsoft.com/help/3165266) | July 18, 2016      |
| 11.0.5649.0             | SP2          | CU12                          | [KB3152637](https://support.microsoft.com/help/3152637) | May 16, 2016       |
| 11.0.5646.0             | SP2          | CU11                          | [KB3137745](https://support.microsoft.com/help/3137745) | March 21,2016      |
| 11.0.5644.2             | SP2          | CU10                          | [KB3120313](https://support.microsoft.com/help/3120313) | January 19, 2016   |
| 11.0.5641.0             | SP2          | CU9                           | [KB3098512](https://support.microsoft.com/help/3098512) | November 16, 2015  |
| 11.0.5634.1             | SP2          | CU8                           | [KB3082561](https://support.microsoft.com/help/3082561) | September 21, 2015 |
| 11.0.5623.0             | SP2          | CU7                           | [KB3072100](https://support.microsoft.com/help/3072100) | July 20, 2015      |
| 11.0.5613.0             | SP2          | MS15-058: QFE Security Update | [KB3045319](https://support.microsoft.com/help/3045319) | July 14, 2015      |
| 11.0.5592.0             | SP2          | CU6                           | [KB3052468](https://support.microsoft.com/help/3052468) | May 18, 2015       |
| 11.0.5582.0             | SP2          | CU5                           | [KB3037255](https://support.microsoft.com/help/3037255) | March 16, 2015     |
| 11.0.5569.0             | SP2          | CU4                           | [KB3007556](https://support.microsoft.com/help/3007556) | January 19, 2015   |
| 11.0.5556.0             | SP2          | CU3                           | [KB3002049](https://support.microsoft.com/help/3002049) | November 17, 2014  |
| 11.0.5548.0             | SP2          | CU2                           | [KB2983175](https://support.microsoft.com/help/2983175) | September 15, 2014 |
| 11.0.5532.0             | SP2          | CU1                           | [KB2976982](https://support.microsoft.com/help/2976982) | July 23, 2014      |
| 11.0.5343.0             | SP2          | MS15-058: GDR Security Update | [KB3045321](https://support.microsoft.com/help/3045321) | July 14, 2015      |
| 11.0.5058.0             | SP2          | RTW/PCU2                      | [KB2958429](https://support.microsoft.com/help/2958429) | June 10, 2014      |
| 11.0.3513.0             | SP1          | MS15-058: QFE Security Update | [KB3045317](https://support.microsoft.com/help/3045317) | July 14, 2015      |
| 11.0.3482.0             | SP1          | CU13                          | [KB3002044](https://support.microsoft.com/help/3002044) | November 17, 2014  |
| 11.0.3470.0             | SP1          | CU12                          | [KB2991533](https://support.microsoft.com/help/2991533) | September 15, 2014 |
| 11.0.3460.0             | SP1          | MS14-044: QFE Security Update | [KB2977325](https://support.microsoft.com/help/2977325) | August 12, 2014    |
| 11.0.3449.0             | SP1          | CU11                          | [KB2975396](https://support.microsoft.com/help/2975396) | July 21, 2014      |
| 11.0.3431.0             | SP1          | CU10                          | [KB2954099](https://support.microsoft.com/help/2954099) | May 19, 2014       |
| 11.0.3412.0             | SP1          | CU9                           | [KB2931078](https://support.microsoft.com/help/2931078) | March 17, 2014     |
| 11.0.3401.0             | SP1          | CU8                           | [KB2917531](https://support.microsoft.com/help/2917531) | January 20, 2014   |
| 11.0.3393.0             | SP1          | CU7                           | [KB2894115](https://support.microsoft.com/help/2894115) | November 18, 2013  |
| 11.0.3381.0             | SP1          | CU6                           | [KB2874879](https://support.microsoft.com/help/2874879) | September 16, 2013 |
| 11.0.3373.0             | SP1          | CU5                           | [KB2861107](https://support.microsoft.com/help/2861107) | July 15, 2013      |
| 11.0.3368.0             | SP1          | CU4                           | [KB2833645](https://support.microsoft.com/help/2833645) | May 30, 2013       |
| 11.0.3349.0             | SP1          | CU3                           | [KB2812412](https://support.microsoft.com/help/2812412) | March 18, 2013     |
| 11.0.3339.0             | SP1          | CU2                           | [KB2790947](https://support.microsoft.com/help/2790947) | January 21, 2013   |
| 11.0.3321.0             | SP1          | CU1                           | [KB2765331](https://support.microsoft.com/help/2765331) | November 20, 2012  |
| 11.0.3156.0             | SP1          | MS15-058: GDR Security Update | [KB3045318](https://support.microsoft.com/help/3045318) | July 14, 2015      |
| 11.0.3153.0             | SP1          | MS14-044: GDR Security Update | [KB2977326](https://support.microsoft.com/help/2977326) | August 12, 2014    |
| 11.0.3000.0             | SP1          | RTW/PCU1                      | [KB2674319](https://support.microsoft.com/help/2674319) | November 07, 2012   |
| 11.0.2424.0             | RTM          | CU11                          | [KB2908007](https://support.microsoft.com/help/2908007) | December 16, 2013  |
| 11.0.2420.0             | RTM          | CU10                          | [KB2891666](https://support.microsoft.com/help/2891666) | October 21, 2013   |
| 11.0.2401.0             | RTM          | CU6                           | [KB2728897](https://support.microsoft.com/help/2728897) | February 18, 2013  |
| 11.0.2395.0             | RTM          | CU5                           | [KB2777772](https://support.microsoft.com/help/2777772) | December 17, 2012  |
| 11.0.2383.0             | RTM          | CU4                           | [KB2758687](https://support.microsoft.com/help/2758687) | October 15, 2012   |
| 11.0.2376.0             | RTM          | MS12-070: QFE Security Update | [KB2716441](https://support.microsoft.com/help/2716441) | October 09, 2012    |
| 11.0.2332.0             | RTM          | CU3                           | [KB2723749](https://support.microsoft.com/help/2723749) | August 31, 2012    |
| 11.0.2325.0             | RTM          | CU2                           | [KB2703275](https://support.microsoft.com/help/2703275) | June 18, 2012      |
| 11.0.2316.0             | RTM          | CU1                           | [KB2679368](https://support.microsoft.com/help/2679368) | April 12, 2012     |
| 11.0.2218.0             | RTM          | MS12-070: GDR Security Update | [KB2716442](https://support.microsoft.com/help/2716442) | October 09, 2012    |
| 11.0.2100.60            | RTM          |                               |                                                       | March 06, 2012      |

### SQL Server 2008 R2

| Build number or version | Service pack | Update                        | Knowledge Base number                                            | Release date       |
|-------------------------|--------------|-------------------------------|-------------------------------------------------------|--------------------|
| 10.50.6785.2            | SP3          | GDR Security Update           | [KB5021112](https://support.microsoft.com/help/5021112) | February 14, 2023  |
| 10.50.6560.0            | SP3          | GDR Security Update           | [KB4057113](https://support.microsoft.com/help/4057113) | January 06, 2018    |
| 10.50.6529.0            | SP3          | MS15-058: QFE Security Update | [KB3045314](https://support.microsoft.com/help/3045314) | July 14, 2015      |
| 10.50.6220.0            | SP3          | MS15-058: QFE Security Update | [KB3045316](https://support.microsoft.com/help/3045316) | July 14, 2015      |
| 10.50.6000.34           | SP3          | RTW/PCU3                      | [KB2979597](https://support.microsoft.com/help/2979597) | September 26, 2014 |
| 10.50.4339.0            | SP2          | MS15-058: QFE Security Update | [KB3045312](https://support.microsoft.com/help/3045312) | July 14, 2015      |
| 10.50.4321.0            | SP2          | MS14-044: QFE Security Update | [KB2977319](https://support.microsoft.com/help/2977319) | August 14, 2014    |
| 10.50.4319.0            | SP2          | CU13                          | [KB2967540](https://support.microsoft.com/help/2967540) | June 30, 2014      |
| 10.50.4305.0            | SP2          | CU12                          | [KB2938478](https://support.microsoft.com/help/2938478) | April 21, 2014     |
| 10.50.4302.0            | SP2          | CU11                          | [KB2926028](https://support.microsoft.com/help/2926028) | February 18, 2014  |
| 10.50.4297.0            | SP2          | CU10                          | [KB2908087](https://support.microsoft.com/help/2908087) | December 17, 2013  |
| 10.50.4295.0            | SP2          | CU9                           | [KB2887606](https://support.microsoft.com/help/2887606) | October 28, 2013   |
| 10.50.4286.0            | SP2          | CU7                           | [KB2844090](https://support.microsoft.com/help/2844090) | June 17, 2013      |
| 10.50.4279.0            | SP2          | CU6                           | [KB2830140](https://support.microsoft.com/help/2830140) | April 15, 2013     |
| 10.50.4276.0            | SP2          | CU5                           | [KB2797460](https://support.microsoft.com/help/2797460) | February 18, 2013  |
| 10.50.4270.0            | SP2          | CU4                           | [KB2777358](https://support.microsoft.com/help/2777358) | December 17, 2012  |
| 10.50.4266.0            | SP2          | CU3                           | [KB2754552](https://support.microsoft.com/help/2754552) | October 15, 2012   |
| 10.50.4263.0            | SP2          | CU2                           | [KB2740411](https://support.microsoft.com/help/2740411) | August 31, 2012    |
| 10.50.4260.0            | SP2          | CU1                           | [KB2720425](https://support.microsoft.com/help/2720425) | July 24, 2012      |
| 10.50.4042.0            | SP2          | MS15-058: GDR Security Update | [KB3045313](https://support.microsoft.com/help/3045313) | July 14, 2015      |
| 10.50.4033.0            | SP2          | MS14-044: GDR Security Update | [KB2977320](https://support.microsoft.com/help/2977320) | August 12, 2014    |
| 10.50.4000.0            | SP2          | RTW/PCU2                      | [KB2630458](https://support.microsoft.com/help/2630458) | July 26, 2012      |
| 10.50.2881.0            | SP1          | CU14                          | [KB2868244](https://support.microsoft.com/help/2868244) | August 08, 2013     |
| 10.50.2876.0            | SP1          | CU13                          | [KB2855792](https://support.microsoft.com/help/2855792) | June 17, 2013      |
| 10.50.2874.0            | SP1          | CU12                          | [KB2828727](https://support.microsoft.com/help/2828727) | April 15, 2013     |
| 10.50.2869.0            | SP1          | CU11                          | [KB2812683](https://support.microsoft.com/help/2812683) | February 18, 2013  |
| 10.50.2866.0            | SP1          | CU9                           | [KB2756574](https://support.microsoft.com/help/2756574) | October 15, 2012   |
| 10.50.2861.0            | SP1          | MS12-070: QFE Security Update | [KB2716439](https://support.microsoft.com/help/2716439) | October 09, 2012    |
| 10.50.2822.0            | SP1          | CU8                           | [KB2723743](https://support.microsoft.com/help/2723743) | August 31, 2012    |
| 10.50.2817.0            | SP1          | CU7                           | [KB2703282](https://support.microsoft.com/help/2703282) | June 18, 2012      |
| 10.50.2811.0            | SP1          | CU6                           | [KB2679367](https://support.microsoft.com/help/2679367) | April 16, 2012     |
| 10.50.2806.0            | SP1          | CU5                           | [KB2659694](https://support.microsoft.com/help/2659694) | February 22, 2012  |
| 10.50.2796.0            | SP1          | CU4                           | [KB2633146](https://support.microsoft.com/help/2633146) | December 19, 2011  |
| 10.50.2789.0            | SP1          | CU3                           | [KB2591748](https://support.microsoft.com/help/2591748) | October 17, 2011   |
| 10.50.2772.0            | SP1          | CU2                           | [KB2567714](https://support.microsoft.com/help/2567714) | August 15, 2011    |
| 10.50.2769.0            | SP1          | CU1                           | [KB2544793](https://support.microsoft.com/help/2544793) | July 18, 2011      |
| 10.50.2550.0            | SP1          | MS12-070: GDR Security Update | [KB2754849](https://support.microsoft.com/help/2754849) | October 09, 2012    |
| 10.50.2500.0            | SP1          | RTW/PCU1                      | [KB2528583](https://support.microsoft.com/help/2528583) | July 12, 2011      |
| 10.50.1815.0            | RTM          | CU13                          | [KB2679366](https://support.microsoft.com/help/2679366) | April 16, 2012     |
| 10.50.1810.0            | RTM          | CU12                          | [KB2659692](https://support.microsoft.com/help/2659692) | February 21, 2012  |
| 10.50.1807.0            | RTM          | CU10                          | [KB2591746](https://support.microsoft.com/help/2591746) | October 17, 2011   |
| 10.50.1804.0            | RTM          | CU9                           | [KB2567713](https://support.microsoft.com/help/2567713) | August 15, 2011    |
| 10.50.1790.0            | RTM          | MS11-049: QFE Security Update | [KB2494086](https://support.microsoft.com/help/2494086) | June 14, 2011      |
| 10.50.1777.0            | RTM          | CU7                           | [KB2507770](https://support.microsoft.com/help/2507770) | April 18, 2011     |
| 10.50.1765.0            | RTM          | CU6                           | [KB2489376](https://support.microsoft.com/help/2489376) | February 21, 2011  |
| 10.50.1753.0            | RTM          | CU5                           | [KB2438347](https://support.microsoft.com/help/2438347) | December 20, 2010  |
| 10.50.1746.0            | RTM          | CU4                           | [KB2345451](https://support.microsoft.com/help/2345451) | October 18, 2010   |
| 10.50.1734.0            | RTM          | CU3                           | [KB2261464](https://support.microsoft.com/help/2261464) | August 16, 2010    |
| 10.50.1720.0            | RTM          | CU2                           | [KB2072493](https://support.microsoft.com/help/2072493) | June 21, 2010      |
| 10.50.1702.0            | RTM          | CU1                           | [KB981355](https://support.microsoft.com/help/981355)   | May 18, 2010       |
| 10.50.1617.0            | RTM          | MS11-049: GDR Security Update | [KB2494088](https://support.microsoft.com/help/2494088) | June 14, 2011      |
| 10.50.1600.1            | RTM          |                               |                                                       | May 10, 2010       |

### SQL Server 2008

|Build number or version|Service pack|Update|Knowledge Base number|Release date|
|---|---|---|---|---|
|10.0.6814.4|SP4| GDR Security Update| [KB5020863](https://support.microsoft.com/help/5020863)|February 14, 2023|
|10.00.6535.0|SP4| MS15-058: QFE Security Update| [KB3045308](https://support.microsoft.com/help/3045308)|July 14, 2015|
|10.00.6241.0|SP4| MS15-058: GDR Security Update| [KB3045311](https://support.microsoft.com/help/3045311)|July 14, 2015|
|10.00.5890.0|SP3| MS15-058: QFE Security Update| [KB3045303](https://support.microsoft.com/help/3045303)|July 14, 2015|
|10.00.5869.0|SP3| MS14-044: QFE Security Update| [KB2984340](https://support.microsoft.com/help/2984340)<br/>[2977322](https://support.microsoft.com/help/2977322)|August 12, 2014|
|10.00.5867.0|(on-demand update package)|| [KB2877204](https://support.microsoft.com/help/2877204)| |
|10.00.5861.0|SP3|CU17| [KB2958696](https://support.microsoft.com/help/2958696)|May 19, 2014|
|10.00.5852.0|SP3|CU16| [KB2936421](https://support.microsoft.com/help/2936421)|March 17, 2014|
|10.00.5850.0|SP3|CU15| [KB2923520](https://support.microsoft.com/help/2923520)|January 20, 2014|
|10.00.5848.0|SP3|CU14| [KB2893410](https://support.microsoft.com/help/2893410)|November 18, 2013|
|10.00.5846.0|SP3|CU13| [KB2880350](https://support.microsoft.com/help/2880350)|September 16, 2013|
|10.00.5844.0|SP3|CU12| [KB2863205](https://support.microsoft.com/help/2863205)|July 15, 2013|
|10.00.5840.0|SP3|CU11| [KB2834048](https://support.microsoft.com/help/2834048)|May 20, 2013|
|10.00.5835.0|SP3|CU10| [KB2814783](https://support.microsoft.com/help/2814783)|March 18, 2013|
|10.00.5829.0|SP3|CU9| [KB2799883](https://support.microsoft.com/help/2799883)|January 21, 2013|
|10.00.5828.0|SP3|CU8| [KB2771833](https://support.microsoft.com/help/2771833)|November 19, 2012|
|10.00.5826.0|SP3| MS12-070: QFE Security Update| [KB2716435](https://support.microsoft.com/help/2716435)|October 09, 2012|
|10.00.5794.0|SP3|CU7| [KB2738350](https://support.microsoft.com/help/2738350)|September 17, 2012|
|10.00.5788.0|SP3|CU6| [KB2715953](https://support.microsoft.com/help/2715953)|July 16, 2012|
|10.00.5785.0|SP3|CU5| [KB2696626](https://support.microsoft.com/help/2696626)|May 21, 2012|
|10.00.5768.0|SP3|CU2| [KB2633143](https://support.microsoft.com/help/2633143)|November 21, 2011|
|10.00.5766.0|SP3|CU1| [KB2617146](https://support.microsoft.com/help/2617146)|October 17, 2011|
|10.00.5538.0|SP3| MS15-058: GDR Security Update| [KB3045305](https://support.microsoft.com/help/3045305)|July 14, 2015|
|10.00.5520.0|SP3| MS14-044: GDR Security Update| [KB2977321](https://support.microsoft.com/help/2977321)|August 12, 2014|
|10.00.5512.0|SP3| MS12-070: GDR Security Update| [KB2716436](https://support.microsoft.com/help/2716436)|October 09, 2012|
|10.00.5500.0| SP3| RTW / PCU 3| [KB2546951](https://support.microsoft.com/help/2546951)|October 06, 2011|
|10.00.4371.0|SP2| MS12-070: QFE Security Update| [KB2716433](https://support.microsoft.com/help/2716433)|October 09, 2012|
|10.00.4332.0|SP2|CU10| [KB2696625](https://support.microsoft.com/help/2696625)|May 21, 2012|
|10.00.4330.0|SP2|CU9| [KB2673382](https://support.microsoft.com/help/2673382)|March 19, 2012|
|10.00.4326.0|SP2|CU8| [KB2648096](https://support.microsoft.com/help/2648096)|January 16, 2012|
|10.00.4323.0|SP2|CU7| [KB2617148](https://support.microsoft.com/help/2617148)|November 21, 2011|
|10.00.4321.0|SP2|CU6| [KB2582285](https://support.microsoft.com/help/2582285)|September 19, 2011|
|10.00.4316.0|SP2|CU5| [KB2555408](https://support.microsoft.com/help/2555408)|July 18, 2011|
|10.00.4311.0|SP2| MS11-049: QFE Security Update| [KB2494094](https://support.microsoft.com/help/2494094)|June 14, 2011|
|10.00.4285.0|SP2|CU4| [KB2527180](https://support.microsoft.com/help/2527180)|May 16, 2011|
|10.00.4279.0|SP2|CU3| [KB2498535](https://support.microsoft.com/help/2498535)|March 17, 2011|
|10.00.4266.0|SP2|CU1| [KB2289254](https://support.microsoft.com/help/2289254)|November 15, 2010|
|10.00.4067.0|SP2| MS12-070: GDR Security Update| [KB2716434](https://support.microsoft.com/help/2716434)|October 09, 2012|
|10.00.4064.0|SP2| MS11-049: GDR Security Update| [KB2494089](https://support.microsoft.com/help/2494089)|June 14, 2011|
|10.00.4000.0| SP2| RTW / PCU 2| [KB2285068](https://support.microsoft.com/help/2285068)|September 29, 2010|
|10.00.2850.0|SP1|CU16| [KB2582282](https://support.microsoft.com/help/2582282)|September 19, 2011|
|10.00.2847.0|SP1|CU15| [KB2555406](https://support.microsoft.com/help/2555406)|July 18, 2011|
|10.00.2841.0|SP1| MS11-049: QFE Security Update| [KB2494100](https://support.microsoft.com/help/2494100)|June 14, 2011|
|10.00.2821.0|SP1|CU14| [KB2527187](https://support.microsoft.com/help/2527187)|May 16, 2011|
|10.00.2816.0|SP1|CU13| [KB2497673](https://support.microsoft.com/help/2497673)|March 17, 2011|
|10.00.2804.0|SP1|CU11| [KB2413738](https://support.microsoft.com/help/2413738)|November 15, 2010|
|10.00.2775.0|SP1|CU8| [KB981702](https://support.microsoft.com/help/981702)|May 17, 2010|
|10.00.2746.0|SP1|CU5| [KB975977](https://support.microsoft.com/help/975977)|November 16, 2009|
|10.00.2734.0|SP1|CU4| [KB973602](https://support.microsoft.com/help/973602)|September 21, 2009|
|10.00.2723.0|SP1|CU3| [KB971491](https://support.microsoft.com/help/971491)|July 20, 2009|
|10.00.2714.0|SP1|CU2| [KB970315](https://support.microsoft.com/help/970315)|May 18, 2009|
|10.00.2710.0|SP1|CU1| [KB969099](https://support.microsoft.com/help/969099)|April 16, 2009|
|10.00.2573.0|SP1| MS11-049: GDR Security update| [KB2494096](https://support.microsoft.com/help/2494096)|June 14, 2011|
|10.00.2531.0| SP1| RTW / PCU 1||April, 2009|
|10.00.1835.0|RTM|CU10| [KB979064](https://support.microsoft.com/help/979064)|March 15, 2010|
|10.00.1823.0|RTM|CU8| [KB975976](https://support.microsoft.com/help/975976)|November 16, 2009|
|10.00.1787.0|RTM|CU3| [KB960484](https://support.microsoft.com/help/960484)|January 19, 2009|
|10.00.1779.0|RTM|CU2| [KB958186](https://support.microsoft.com/help/958186)|November 19, 2008|
|10.00.1763.0|RTM|CU1| [KB956717](https://support.microsoft.com/help/956717)|September 22, 2008|
|10.00.1600.22|RTM|||August 6, 2008|

### SQL Server 2005

| Build number or version | Service pack | Update                        | Knowledge Base number                                            | Release date      |
|-------------------------|--------------|-------------------------------|-------------------------------------------------------|-------------------|
| 9.00.5324               | SP4          | MS12-070: QFE Security update | [KB2716427](https://support.microsoft.com/help/2716427) | October 09, 2012   |
| 9.00.5292               | SP4          | MS11-049: QFE Security update | [KB2494123](https://support.microsoft.com/help/2494123) | June 14, 2011     |
| 9.00.5069               | SP4          | MS12-070: GDR Security update | [KB2716429](https://support.microsoft.com/help/2716429) | October 09, 2012   |
| 9.00.5057               | SP4          | MS11-049: GDR Security update | [KB2494120](https://support.microsoft.com/help/2494120) | June 14, 2011     |
| 9.00.5000               | SP4          | RTW / PCU4                    |                                                       | December 16, 2010 |
| 9.00.4309               | SP3          | CU11                          | [KB2258854](https://support.microsoft.com/help/2258854) | August 16, 2010   |
| 9.00.4305               | SP3          | CU10                          | [KB983329](https://support.microsoft.com/help/983329)   | June 21, 2010     |
| 9.00.4285               | SP3          | CU8                           | [KB978915](https://support.microsoft.com/help/978915)   | February 16, 2010 |
| 9.00.4230               | SP3          | CU5                           | [KB972511](https://support.microsoft.com/help/972511)   | August 17, 2009   |
| 9.00.4226               | SP3          | CU4                           | [KB970279](https://support.microsoft.com/help/970279)   | June 15, 2009     |
| 9.00.4211               | SP3          | CU2                           | [KB961930](https://support.microsoft.com/help/961930)   | February 16, 2009 |
| 9.00.4060               | SP3          | MS11-049: GDR Security update | [KB2494113](https://support.microsoft.com/help/2494113) | June 14, 2011     |
| 9.00.4035               | SP3          | RTW                           | [KB955706](https://support.microsoft.com/help/955706)   | December 15, 2008 |
| 9.00.3325               | SP2          | CU13                          | [KB967908](https://support.microsoft.com/help/967908)   | April 20, 2009    |
| 9.00.3282               | SP2          | CU9                           | [KB953752](https://support.microsoft.com/help/953752)   | August 18, 2008   |
| 9.00.3257               | SP2          | CU8                           | [KB951217](https://support.microsoft.com/help/951217)   | June 16, 2008     |
| 9.00.3239               | SP2          | CU7                           | [KB949095](https://support.microsoft.com/help/949095)   | April 14, 2008    |
| 9.00.3077               | SP4          | MS09-004: GDR Security update | [KB960089](https://support.microsoft.com/help/960089)   | February 10, 2009 |
| 9.00.3042               | SP2          |                               | [KB937137](https://support.microsoft.com/help/937137)   |                   |
| 9.00.2047               | SP1          |                               |                                                       |                   |
| 9.00.1399               | RTM          |                               |                                                       |                   |

### SQL Server 2000

| Build number or version | Version description, (KB number for that update), release date |
|-------------------------|----------------------------------------------------------------|
| 8.00.2283               | Post-SP4 hotfix for MS09-004 (971524)                          |
| 8.00.2282               | MS09-004: KB959420 October 29, 2008                            |
| 8.00.2273               | MS08-040 - KB 948111 July 08, 2008                              |
| 8.00.2040               | Post-SP4 AWE fix (899761)                                      |
| 8.00.2039               | SQL Server 2000 SP4                                            |
| 8.00.1007               | Update.exe Hotfix Installer Baseline 2 (891640)                |
| 8.00.977                | Update.exe Hotfix Installer Baseline 1 (884856)                |
| 8.00.818                | (821277)                                                       |
| 8.00.765                | Post SP3 hotfix rollup                                         |
| 8.00.760                | SQL Server 2000 SP3 or SP3a (8.00.766 ssnetlib.dll)            |
| 8.00.701                | Hotfix Installer v.1 released                                  |
| 8.00.534                | SQL Server 2000 SP2                                            |
| 8.00.384                | SQL Server 2000 SP1                                            |
| 8.00.194                | SQL Server 2000 RTM or MSDE 2.0                                |

Older versions of SQL Server

### SQL Server 7.0

Use the version number in the following table to identify the product or service pack level.

| Version number | Service pack                  |
|----------------|-------------------------------|
| 7.00.1063      | SQL Server 7.0 Service Pack 4 |
| 7.00.961       | SQL Server 7.0 Service Pack 3 |
| 7.00.842       | SQL Server 7.0 Service Pack 2 |
| 7.00.699       | SQL Server 7.0 Service Pack 1 |
| 7.00.623       | SQL Server 7.0 RTM            |

### SQL Server 6.5

Use the version number in the following table to identify the product or service pack level.

| Version number | Service pack                          |
|----------------|---------------------------------------|
| 6.50.479       | SQL Server 6.5 Service Pack 5a Update |
| 6.50.416       | SQL Server 6.5 Service Pack 5a        |
| 6.50.415       | SQL Server 6.5 Service Pack 5         |
| 6.50.281       | SQL Server 6.5 Service Pack 4         |
| 6.50.258       | SQL Server 6.5 Service Pack 3         |
| 6.50.240       | SQL Server 6.5 Service Pack 2         |
| 6.50.213       | SQL Server 6.5 Service Pack 1         |
| 6.50.201       | SQL Server 6.5 RTM                    |

## See also

- [Determine version information of SQL Server components and client tools](components-client-tools-versions.md)
- [Determine which version and edition of SQL Server Database Engine is running](find-my-sql-version.md)
