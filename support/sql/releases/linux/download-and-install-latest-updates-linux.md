---
title: Latest Updates and Version History for SQL Server on Linux
description: This article lists the builds and updates available for supported versions of SQL Server on Linux.
ms.reviewer: v-shaywood
ms.date: 08/10/2026
ms.update-cycle: 1095-days
ms.custom: sap:Installation, Patching, Upgrade, Uninstall, evergreen, linux-related-content
---

# Latest updates and version history for SQL Server on Linux

This article lists the builds and updates available for supported versions of SQL Server running on Linux.

_Original product version:_ &nbsp; SQL Server  
_Original KB number:_ &nbsp; 5122767  

## Summary

- A downloadable version of an Excel workbook that contains all the build versions together with their current support lifecycle stage for 2005 through the current version is available. The Excel file also contains detailed fix lists for each version. **[Download the Excel file now](https://aka.ms/sqlserverbuilds)**.

- To learn what a specific version number of SQL Server maps to, or to find the KB article information for a specific cumulative update package, search for the version number in the [SQL Server version list](#sql-server-version-list-tables) tables.

- To find the edition of your SQL Server instance, see [Determine which version and edition of SQL Server Database Engine is running](../find-my-sql-version.md).

  > [!NOTE]  
  > The version information and edition information are in the same output string.

For information about SQL Server Support lifecycle, see [SQL Server support lifecycle information](/lifecycle/products/?products=sql-server&preserve-view=true).

## Latest updates available for currently supported versions

Each of the following links provides information for all of the applicable products and technologies.

| Version | Latest GDR | Latest cumulative update |
| --- | --- | --- |
| **SQL Server 2025**<br /><br />- [Build information](#sql-server-2025)<br />- [Installation](/sql/linux/sql-server-linux-setup?view=sql-server-linux-ver17&preserve-view=true) | [GDR](https://support.microsoft.com/help/5102333)<br />(17.0.1125.2 - July 2026) | [CU8 for 2025](https://support.microsoft.com/help/5104822)<br />(17.0.4075.5 - August 2026)<br /><br />[CU6 + GDR](https://support.microsoft.com/help/5101346)<br />(17.0.4060.2 - July 2026) |
| **SQL Server 2022**<br /><br />- [Build information](#sql-server-2022)<br />- [Installation](/sql/linux/sql-server-linux-setup?view=sql-server-linux-ver16&preserve-view=true) | [GDR](https://support.microsoft.com/help/5102334)<br />(16.0.1190.2 - July 2026) | [CU26 for 2022](https://support.microsoft.com/help/5093420)<br />(16.0.4265.3 - July 2026)<br /><br />[CU25 + GDR](https://support.microsoft.com/help/5101347)<br />(16.0.4262.2 - July 2026) |
| **SQL Server 2019**<br /><br />- [Build information](#sql-server-2019)<br />- [Installation](/sql/linux/sql-server-linux-setup?view=sql-server-linux-ver15&preserve-view=true) | [GDR](https://support.microsoft.com/help/5102336)<br />(15.0.2180.2 - July 2026) | [CU32 for 2019](https://support.microsoft.com/help/5054833)<br />(15.0.4430.1 - February 2025)<br /><br />[CU32 + GDR](https://support.microsoft.com/help/5102335)<br />(15.0.4480.2 - July 2026) |
| **SQL Server 2017**<br /><br />- [Build information](#sql-server-2017)<br />- [Installation](/sql/linux/sql-server-linux-setup?view=sql-server-linux-2017&preserve-view=true) | [GDR](https://support.microsoft.com/help/5102338)<br />(14.0.2120.1 - July 2026) | [CU31 for 2017](https://support.microsoft.com/help/5016884)<br />(14.0.3456.2 - September 2022)<br /><br />[CU31 + GDR](https://support.microsoft.com/help/5102337)<br />(14.0.3540.1 - July 2026) |

## SQL Server version list tables

> [!NOTE]  
> Some GDR releases apply only to Windows. These Windows-only GDRs aren't published for Linux and don't appear in this article.

### SQL Server 2025

| Build number or version | Update | Knowledge Base number | Release date |
| --- | --- | --- | --- |
| 17.0.4075.5 | CU8 | [KB5104822](https://support.microsoft.com/help/5104822) | August 13, 2026 |
| 17.0.4065.4 | CU7 | [KB5096981](https://support.microsoft.com/help/5096981) | July 16, 2026 |
| 17.0.4060.2 | CU6 + GDR | [KB5101346](https://support.microsoft.com/help/5101346) | July 14, 2026 |
| 17.0.1125.2 | GDR | [KB5102333](https://support.microsoft.com/help/5102333) | July 14, 2026 |
| 17.0.4055.5 | CU6 | [KB5093421](https://support.microsoft.com/help/5093421) | June 17, 2026 |
| 17.0.4045.5 | CU5 | [KB5084896](https://support.microsoft.com/help/5084896) | May 20, 2026 |
| 17.0.4040.1 | CU4 + GDR | [KB5089899](https://support.microsoft.com/help/5089899) | May 12, 2026 |
| 17.0.1115.1 | GDR | [KB5091223](https://support.microsoft.com/help/5091223) | May 12, 2026 |
| 17.0.4035.5 | CU4 | [KB5081495](https://support.microsoft.com/help/5081495) | April 16, 2026 |
| 17.0.4030.1 | CU3 + GDR | [KB5083245](https://support.microsoft.com/help/5083245) | April 14, 2026 |
| 17.0.1110.1 | GDR | [KB5084814](https://support.microsoft.com/help/5084814) | April 14, 2026 |
| 17.0.4025.3 | CU3 | [KB5077896](https://support.microsoft.com/help/5077896) | March 12, 2026 |
| 17.0.4020.2 | CU2 + GDR | [KB5077466](https://support.microsoft.com/help/5077466) | March 10, 2026 |
| 17.0.1105.2 | GDR | [KB5077468](https://support.microsoft.com/help/5077468) | March 10, 2026 |
| 17.0.4015.4 | CU2 | [KB5075211](https://support.microsoft.com/help/5075211) | February 12, 2026 |
| 17.0.4006.2 | CU1 <sup>1</sup> | [KB5078298](https://support.microsoft.com/help/5078298) | January 29, 2026 |
| 17.0.1050.2 | GDR | [KB5073177](https://support.microsoft.com/help/5073177) | January 13, 2026 |
| 17.0.1000.7 | RTM | NA | November 18, 2025 |

<sup>1</sup> **Red Hat 10** and **Ubuntu 24.04** are fully supported on SQL Server 2025, starting with CU 1.

### SQL Server 2022

| Build number or version | Update | Knowledge Base number | Release date |
| --- | --- | --- | --- |
| 16.0.4265.3 | CU26 | [KB5093420](https://support.microsoft.com/help/5093420) | July 16, 2026 |
| 16.0.4262.2 | CU25 + GDR | [KB5101347](https://support.microsoft.com/help/5101347) | July 14, 2026 |
| 16.0.1190.2 | GDR | [KB5102334](https://support.microsoft.com/help/5102334) | July 14, 2026 |
| 16.0.4255.1 | CU25 | [KB5081477](https://support.microsoft.com/help/5081477) | May 20, 2026 |
| 16.0.4252.3 | CU24 + GDR | [KB5089900](https://support.microsoft.com/help/5089900) | May 12, 2026 |
| 16.0.1180.1 | GDR | [KB5091158](https://support.microsoft.com/help/5091158) | May 12, 2026 |
| 16.0.4250.1 | CU24 + GDR | [KB5083252](https://support.microsoft.com/help/5083252) | April 14, 2026 |
| 16.0.1175.1 | GDR | [KB5084815](https://support.microsoft.com/help/5084815) | April 14, 2026 |
| 16.0.4245.2 | CU24 | [KB5080999](https://support.microsoft.com/help/5080999) | March 12, 2026 |
| 16.0.4240.4 | CU23 + GDR | [KB5077464](https://support.microsoft.com/help/5077464) | March 10, 2026 |
| 16.0.1170.5 | GDR | [KB5077465](https://support.microsoft.com/help/5077465) | March 10, 2026 |
| 16.0.4236.2 | CU23 | [KB5078297](https://support.microsoft.com/help/5078297) | January 29, 2026 |
| 16.0.4230.2 | CU22 + GDR | [KB5072936](https://support.microsoft.com/help/5072936) | January 13, 2026 |
| 16.0.1165.1 | GDR | [KB5073031](https://support.microsoft.com/help/5073031) | January 13, 2026 |
| 16.0.4225.2 | CU22 | [KB5068450](https://support.microsoft.com/help/5068450) | November 13, 2025 |
| 16.0.4222.2 | CU21 + GDR | [KB5068406](https://support.microsoft.com/help/5068406) | November 11, 2025 |
| 16.0.1160.1 | GDR | [KB5068407](https://support.microsoft.com/help/5068407) | November 11, 2025 |
| 16.0.4215.2 | CU21 | [KB5065865](https://support.microsoft.com/help/5065865) | September 11, 2025 |
| 16.0.4212.1 | CU20 + GDR | [KB5065220](https://support.microsoft.com/help/5065220) | September 09, 2025 |
| 16.0.1150.1 | GDR | [KB5065221](https://support.microsoft.com/help/5065221) | September 09, 2025 |
| 16.0.4210.1 | CU20 + GDR | [KB5063814](https://support.microsoft.com/help/5063814) | August 12, 2025 |
| 16.0.1145.1 | GDR | [KB5063756](https://support.microsoft.com/help/5063756) | August 12, 2025 |
| 16.0.4205.1 | CU20 | [KB5059390](https://support.microsoft.com/help/5059390) | July 10, 2025 |
| 16.0.4200.1 | CU19 + GDR | [KB5058721](https://support.microsoft.com/help/5058721) | July 08, 2025 |
| 16.0.1140.6 | GDR | [KB5058712](https://support.microsoft.com/help/5058712) | July 08, 2025 |
| 16.0.4195.2 | CU19 | [KB5054531](https://support.microsoft.com/help/5054531) | May 15, 2025 |
| 16.0.4185.3 | CU18 | [KB5050771](https://support.microsoft.com/help/5050771) | March 13, 2025 |
| 16.0.4175.1 | CU17 | [KB5048038](https://support.microsoft.com/help/5048038) | January 16, 2025 |
| 16.0.4165.4 | CU16 | [KB5048033](https://support.microsoft.com/help/5048033) | November 14, 2024 |
| 16.0.4155.4 | CU15 + GDR | [KB5046862](https://support.microsoft.com/help/5046862) | November 12, 2024 |
| 16.0.1135.2 | GDR | [KB5046861](https://support.microsoft.com/help/5046861) | November 12, 2024 |
| 16.0.4150.1 | CU15 + GDR | [KB5046059](https://support.microsoft.com/help/5046059) | October 08, 2024 |
| 16.0.1130.5 | GDR | [KB5046057](https://support.microsoft.com/help/5046057) | October 08, 2024 |
| 16.0.4145.4 | CU15 | [KB5041321](https://support.microsoft.com/help/5041321) | September 25, 2024 |
| 16.0.4140.3 | CU14 + GDR | [KB5042578](https://support.microsoft.com/help/5042578) | September 10, 2024 |
| 16.0.1125.1 | GDR | [KB5042211](https://support.microsoft.com/help/5042211) | September 10, 2024 |
| 16.0.4135.4 | CU14 | [KB5038325](https://support.microsoft.com/help/5038325) | July 23, 2024 |
| 16.0.4131.2 | CU13 + GDR | [KB5040939](https://support.microsoft.com/help/5040939) | July 09, 2024 |
| 16.0.1121.4 | GDR | [KB5040936](https://support.microsoft.com/help/5040936) | July 09, 2024 |
| 16.0.4125.3 | CU13 | [KB5036432](https://support.microsoft.com/help/5036432) | May 16, 2024 |
| 16.0.4120.1 | CU12 + GDR | [KB5036343](https://support.microsoft.com/help/5036343) | April 09, 2024 |
| 16.0.1115.1 | GDR | [KB5035432](https://support.microsoft.com/help/5035432) | April 09, 2024 |
| 16.0.4115.5 | CU12 | [KB5033663](https://support.microsoft.com/help/5033663) | March 14, 2024 |
| 16.0.4105.2 | CU11 | [KB5032679](https://support.microsoft.com/help/5032679) | January 11, 2024 |
| 16.0.4100.1 | CU10 + GDR <sup>1</sup> | [KB5033592](https://support.microsoft.com/help/5033592) | January 09, 2024 |
| 16.0.1110.1 | GDR | [KB5032968](https://support.microsoft.com/help/5032968) | January 09, 2024 |
| 16.0.4095.4 | CU10 | [KB5031778](https://support.microsoft.com/help/5031778) | November 16, 2023 |
| 16.0.4085.2 | CU9 | [KB5030731](https://support.microsoft.com/help/5030731) | October 12, 2023 |
| 16.0.4080.1 | CU8 + GDR | [KB5029503](https://support.microsoft.com/help/5029503) | October 10, 2023 |
| 16.0.1105.1 | GDR | [KB5029379](https://support.microsoft.com/help/5029379) | October 10, 2023 |
| 16.0.4075.1 | CU8 | [KB5029666](https://support.microsoft.com/help/5029666) | September 15, 2023 |
| 16.0.4065.3 | CU7 | [KB5028743](https://support.microsoft.com/help/5028743) | August 10, 2023 |
| 16.0.4055.4 | CU6 | [KB5027505](https://support.microsoft.com/help/5027505) | July 13, 2023 |
| 16.0.4045.3 | CU5 | [KB5026806](https://support.microsoft.com/help/5026806) | June 15, 2023 |
| 16.0.4035.4 | CU4 <sup>2</sup> | [KB5026717](https://support.microsoft.com/help/5026717) | May 11, 2023 |
| 16.0.4025.1 | CU3 | [KB5024396](https://support.microsoft.com/help/5024396) | April 13, 2023 |
| 16.0.4015.1 | CU2 | [KB5023127](https://support.microsoft.com/help/5023127) | March 15, 2023 |
| 16.0.4003.1 | CU1 | [KB5022375](https://support.microsoft.com/help/5022375) | February 16, 2023 |
| 16.0.1050.5 | GDR | [KB5021522](https://support.microsoft.com/help/5021522) | February 14, 2023 |
| 16.0.1000.6 | RTM | NA | November 16, 2022 |

<sup>1</sup> **Red Hat 9** and **Ubuntu 22.04** are supported on SQL Server 2022 starting with CU 10.

<sup>2</sup> **SLES v15 SP4** is now supported on SQL Server 2022 starting with CU 4.

### SQL Server 2019

| Build number or version | Update | Knowledge Base number | Release date |
| --- | --- | --- | --- |
| 15.0.4480.2 | CU32 + GDR <sup>1</sup> | [KB5102335](https://support.microsoft.com/help/5102335) | July 14, 2026 |
| 15.0.2180.2 | GDR | [KB5102336](https://support.microsoft.com/help/5102336) | July 14, 2026 |
| 15.0.4470.1 | CU32 + GDR | [KB5090407](https://support.microsoft.com/help/5090407) | May 12, 2026 |
| 15.0.2170.1 | GDR | [KB5090408](https://support.microsoft.com/help/5090408) | May 12, 2026 |
| 15.0.4465.1 | CU32 + GDR | [KB5084816](https://support.microsoft.com/help/5084816) | April 14, 2026 |
| 15.0.2165.1 | GDR | [KB5084817](https://support.microsoft.com/help/5084817) | April 14, 2026 |
| 15.0.4460.4 | CU32 + GDR | [KB5077469](https://support.microsoft.com/help/5077469) | March 10, 2026 |
| 15.0.2160.4 | GDR | [KB5077470](https://support.microsoft.com/help/5077470) | March 10, 2026 |
| 15.0.4455.2 | CU32 + GDR | [KB5068404](https://support.microsoft.com/help/5068404) | November 11, 2025 |
| 15.0.2155.2 | GDR | [KB5068405](https://support.microsoft.com/help/5068405) | November 11, 2025 |
| 15.0.4445.1 | CU32 + GDR | [KB5065222](https://support.microsoft.com/help/5065222) | September 09, 2025 |
| 15.0.2145.1 | GDR | [KB5065223](https://support.microsoft.com/help/5065223) | September 09, 2025 |
| 15.0.4440.1 | CU32 + GDR | [KB5063757](https://support.microsoft.com/help/5063757) | August 12, 2025 |
| 15.0.2140.1 | GDR | [KB5063758](https://support.microsoft.com/help/5063758) | August 12, 2025 |
| 15.0.4435.7 | CU32 + GDR | [KB5058722](https://support.microsoft.com/help/5058722) | July 08, 2025 |
| 15.0.2135.5 | GDR | [KB5058713](https://support.microsoft.com/help/5058713) | July 08, 2025 |
| 15.0.4430.1 | CU32 | [KB5054833](https://support.microsoft.com/help/5054833) | February 27, 2025 |
| 15.0.4420.2 | CU31 | [KB5049296](https://support.microsoft.com/help/5049296) | February 13, 2025 |
| 15.0.4415.2 | CU30 | [KB5049235](https://support.microsoft.com/help/5049235) | December 12, 2024 |
| 15.0.4410.1 | CU29 + GDR | [KB5046860](https://support.microsoft.com/help/5046860) | November 12, 2024 |
| 15.0.2130.3 | GDR | [KB5046859](https://support.microsoft.com/help/5046859) | November 12, 2024 |
| 15.0.4405.4 | CU29 | [KB5046365](https://support.microsoft.com/help/5046365) | October 31, 2024 |
| 15.0.4395.2 | CU28 + GDR | [KB5046060](https://support.microsoft.com/help/5046060) | October 08, 2024 |
| 15.0.2125.1 | GDR | [KB5046056](https://support.microsoft.com/help/5046056) | October 08, 2024 |
| 15.0.4390.2 | CU28 + GDR | [KB5042749](https://support.microsoft.com/help/5042749) | September 10, 2024 |
| 15.0.2120.1 | GDR | [KB5042214](https://support.microsoft.com/help/5042214) | September 10, 2024 |
| 15.0.4385.2 | CU28 | [KB5039747](https://support.microsoft.com/help/5039747) | August 01, 2024 |
| 15.0.4382.1 | CU27 + GDR <sup>2</sup> | [KB5040948](https://support.microsoft.com/help/5040948) | July 09, 2024 |
| 15.0.2116.2 | GDR | [KB5040986](https://support.microsoft.com/help/5040986) | July 09, 2024 |
| 15.0.4375.4 | CU27 | [KB5037331](https://support.microsoft.com/help/5037331) | June 13, 2024 |
| 15.0.4365.2 | CU26 | [KB5035123](https://support.microsoft.com/help/5035123) | April 11, 2024 |
| 15.0.4360.2 | CU25 + GDR | [KB5036335](https://support.microsoft.com/help/5036335) | April 09, 2024 |
| 15.0.2110.4 | GDR | [KB5035434](https://support.microsoft.com/help/5035434) | April 09, 2024 |
| 15.0.4355.3 | CU25 | [KB5033688](https://support.microsoft.com/help/5033688) | February 15, 2024 |
| 15.0.4345.5 | CU24 | [KB5031908](https://support.microsoft.com/help/5031908) | December 14, 2023 |
| 15.0.4335.1 | CU23 | [KB5030333](https://support.microsoft.com/help/5030333) | October 12, 2023 |
| 15.0.4326.1 | CU22 + GDR | [KB5029378](https://support.microsoft.com/help/5029378) | October 10, 2023 |
| 15.0.2104.1 | GDR | [KB5029377](https://support.microsoft.com/help/5029377) | October 10, 2023 |
| 15.0.4322.2 | CU22 | [KB5027702](https://support.microsoft.com/help/5027702) | August 14, 2023 |
| 15.0.4316.3 | CU21 | [KB5025808](https://support.microsoft.com/help/5025808) | June 15, 2023 |
| 15.0.4312.2 | CU20 | [KB5024276](https://support.microsoft.com/help/5024276) | April 13, 2023 |
| 15.0.4298.1 | CU19 | [KB5023049](https://support.microsoft.com/help/5023049) | February 16, 2023 |
| 15.0.4280.7 | CU18 + GDR | [KB5021124](https://support.microsoft.com/help/5021124) | February 14, 2023 |
| 15.0.2101.7 | GDR | [KB5021125](https://support.microsoft.com/help/5021125) | February 14, 2023 |
| 15.0.4261.1 | CU18 | [KB5017593](https://support.microsoft.com/help/5017593) | September 28, 2022 |
| 15.0.4249.2 | CU17 | [KB5016394](https://support.microsoft.com/help/5016394) | August 11, 2022 |
| 15.0.4236.7 | CU16 + GDR | [KB5014353](https://support.microsoft.com/help/5014353) | June 14, 2022 |
| 15.0.2095.3 | GDR | [KB5014356](https://support.microsoft.com/help/5014356) | June 14, 2022 |
| 15.0.4223.1 | CU16 | [KB5011644](https://support.microsoft.com/help/5011644) | April 18, 2022 |
| 15.0.4198.2 | CU15 | [KB5008996](https://support.microsoft.com/help/5008996) | January 27, 2022 |
| 15.0.4188.2 | CU14 <sup>3</sup> | [KB5007182](https://support.microsoft.com/help/5007182) | November 22, 2021 |
| 15.0.4178.1 | CU13 | [KB5005679](https://support.microsoft.com/help/5005679) | October 05, 2021 |
| 15.0.4153.1 | CU12 | [KB5004524](https://support.microsoft.com/help/5004524) | August 04, 2021 |
| 15.0.4138.2 | CU11 | [KB5003249](https://support.microsoft.com/help/5003249) | June 10, 2021 |
| 15.0.4123.1 | CU10 <sup>4</sup> | [KB5001090](https://support.microsoft.com/help/5001090) | April 06, 2021 |
| 15.0.4102.2 | CU9 | [KB5000642](https://support.microsoft.com/help/5000642) | February 10, 2021 |
| 15.0.4083.2 | CU8 + GDR | [KB4583459](https://support.microsoft.com/help/4583459) | January 12, 2021 |
| 15.0.2080.9 | GDR | [KB4583458](https://support.microsoft.com/help/4583458) | January 12, 2021 |
| 15.0.4073.23 | CU8 | [KB4577194](https://support.microsoft.com/help/4577194) | October 07, 2020 |
| 15.0.4063.15 | CU7 <sup>7</sup> | [KB4570012](https://support.microsoft.com/help/4570012) | September 02, 2020 |
| 15.0.4053.23 | CU6 | [KB4563110](https://support.microsoft.com/help/4563110) | August 04, 2020 |
| 15.0.4043.16 | CU5 | [KB4552255](https://support.microsoft.com/help/4552255) | June 22, 2020 |
| 15.0.4033.1 | CU4 | [KB4548597](https://support.microsoft.com/help/4548597) | March 31, 2020 |
| 15.0.4023.6 | CU3 <sup>5</sup> | [KB4538853](https://support.microsoft.com/help/4538853) | March 12, 2020 |
| 15.0.4013.40 | CU2 (Removed) | [KB4536075](https://support.microsoft.com/help/4536075) | February 13, 2020 |
| 15.0.4003.23 | CU1 <sup>6</sup> | [KB4527376](https://support.microsoft.com/help/4527376) | January 07, 2020 |
| 15.0.2070.41 | GDR | [KB4517790](https://support.microsoft.com/help/4517790) | November 04, 2019 |
| 15.0.2000.5 | RTM | NA | November 04, 2019 |

<sup>1</sup> This is the final cumulative update for SQL Server 2019.

<sup>2</sup> This is the final cumulative update for **RHEL 7** and **Ubuntu 16.04**.

<sup>3</sup> **SLES v15** is now supported on SQL Server 2019 starting with CU 14. The offline package installation links for SLES are pointing to SLES v15 packages. If you're looking for SLES v12 packages, refer to the download path <https://packages.microsoft.com/sles/12/mssql-server-2019/>.

<sup>4</sup> **Ubuntu 20.04** is now supported on SQL Server 2019 starting with CU 10. The offline package installation links for Ubuntu are pointing to Ubuntu 20.04 packages. If you're looking for Ubuntu 18.04 packages, refer to the download path <https://packages.microsoft.com/ubuntu/18.04/mssql-server-2019/pool/main/m/>.

<sup>5</sup> **Ubuntu 18.04** is now supported on SQL Server 2019 starting with CU 3. The offline package installation links for Ubuntu are pointing to Ubuntu 18.04 packages. If you're looking for Ubuntu 16.04 packages, refer to the download path <https://packages.microsoft.com/ubuntu/16.04/mssql-server-2019/pool/main/m/>.

<sup>6</sup> **RHEL 8** is now supported on SQL Server 2019 starting with CU 1. The offline package installation links for RHEL are pointing to RHEL 8 packages. If you're looking for RHEL 7 packages, refer to the download path <https://packages.microsoft.com/rhel/7/mssql-server-2019/>.

<sup>7</sup> If you already installed this update, install CU 8 instead.

### SQL Server 2017

| Build number or version | Update | Knowledge Base number | Release date |
| --- | --- | --- | --- |
| 14.0.3540.1 | CU31 + GDR <sup>1, 2</sup> | [KB5102337](https://support.microsoft.com/help/5102337) | July 14, 2026 |
| 14.0.2120.1 | GDR | [KB5102338](https://support.microsoft.com/help/5102338) | July 14, 2026 |
| 14.0.3530.2 | CU31 + GDR | [KB5090354](https://support.microsoft.com/help/5090354) | May 12, 2026 |
| 14.0.2110.2 | GDR | [KB5090347](https://support.microsoft.com/help/5090347) | May 12, 2026 |
| 14.0.3525.1 | CU31 + GDR | [KB5084818](https://support.microsoft.com/help/5084818) | April 14, 2026 |
| 14.0.2105.1 | GDR | [KB5084819](https://support.microsoft.com/help/5084819) | April 14, 2026 |
| 14.0.3520.4 | CU31 + GDR | [KB5077471](https://support.microsoft.com/help/5077471) | March 10, 2026 |
| 14.0.2100.4 | GDR | [KB5077472](https://support.microsoft.com/help/5077472) | March 10, 2026 |
| 14.0.3515.1 | CU31 + GDR | [KB5068402](https://support.microsoft.com/help/5068402) | November 11, 2025 |
| 14.0.2095.1 | GDR | [KB5068403](https://support.microsoft.com/help/5068403) | November 11, 2025 |
| 14.0.3505.1 | CU31 + GDR | [KB5065225](https://support.microsoft.com/help/5065225) | September 09, 2025 |
| 14.0.2085.1 | GDR | [KB5065224](https://support.microsoft.com/help/5065224) | September 09, 2025 |
| 14.0.3500.1 | CU31 + GDR | [KB5063759](https://support.microsoft.com/help/5063759) | August 12, 2025 |
| 14.0.2080.1 | GDR | [KB5063760](https://support.microsoft.com/help/5063760) | August 12, 2025 |
| 14.0.3495.9 | CU31 + GDR | [KB5058714](https://support.microsoft.com/help/5058714) | July 08, 2025 |
| 14.0.2075.8 | GDR | [KB5058716](https://support.microsoft.com/help/5058716) | July 08, 2025 |
| 14.0.3490.10 | Azure Connect feature pack <sup>3</sup> | [KB5050533](https://support.microsoft.com/help/5050533) | March 06, 2025 |
| 14.0.3485.1 | CU31 + GDR | [KB5046858](https://support.microsoft.com/help/5046858) | November 12, 2024 |
| 14.0.2070.1 | GDR | [KB5046857](https://support.microsoft.com/help/5046857) | November 12, 2024 |
| 14.0.3480.1 | CU31 + GDR | [KB5046061](https://support.microsoft.com/help/5046061) | October 08, 2024 |
| 14.0.2065.1 | GDR | [KB5046058](https://support.microsoft.com/help/5046058) | October 08, 2024 |
| 14.0.3475.1 | CU31 + GDR | [KB5042215](https://support.microsoft.com/help/5042215) | September 10, 2024 |
| 14.0.2060.1 | GDR | [KB5042217](https://support.microsoft.com/help/5042217) | September 10, 2024 |
| 14.0.3471.2 | CU31 + GDR | [KB5040940](https://support.microsoft.com/help/5040940) | July 09, 2024 |
| 14.0.2056.2 | GDR | [KB5040942](https://support.microsoft.com/help/5040942) | July 09, 2024 |
| 14.0.3465.1 | CU31 + GDR | [KB5029376](https://support.microsoft.com/help/5029376) | October 10, 2023 |
| 14.0.2052.1 | GDR | [KB5029375](https://support.microsoft.com/help/5029375) | October 10, 2023 |
| 14.0.3460.9 | CU31 + GDR | [KB5021126](https://support.microsoft.com/help/5021126) | February 14, 2023 |
| 14.0.2047.8 | GDR | [KB5021127](https://support.microsoft.com/help/5021127) | February 14, 2023 |
| 14.0.3456.2 | CU31 | [KB5016884](https://support.microsoft.com/help/5016884) | September 20, 2022 |
| 14.0.3451.2 | CU30 | [KB5013756](https://support.microsoft.com/help/5013756) | July 13, 2022 |
| 14.0.3445.2 | CU29 + GDR | [KB5014553](https://support.microsoft.com/help/5014553) | June 14, 2022 |
| 14.0.2042.3 | GDR | [KB5014354](https://support.microsoft.com/help/5014354) | June 14, 2022 |
| 14.0.3436.1 | CU29 | [KB5010786](https://support.microsoft.com/help/5010786) | March 30, 2022 |
| 14.0.3430.2 | CU28 | [KB5008084](https://support.microsoft.com/help/5008084) | January 13, 2022 |
| 14.0.3421.10 | CU27 | [KB5006944](https://support.microsoft.com/help/5006944) | October 27, 2021 |
| 14.0.3411.3 | CU26 | [KB5005226](https://support.microsoft.com/help/5005226) | September 14, 2021 |
| 14.0.3401.7 | CU25 | [KB5003830](https://support.microsoft.com/help/5003830) | July 12, 2021 |
| 14.0.3391.2 | CU24 | [KB5001228](https://support.microsoft.com/help/5001228) | May 10, 2021 |
| 14.0.3381.3 | CU23 | [KB5000685](https://support.microsoft.com/help/5000685) | February 24, 2021 |
| 14.0.3370.1 | CU22 + GDR | [KB4583457](https://support.microsoft.com/help/4583457) | January 12, 2021 |
| 14.0.2037.2 | GDR | [KB4583456](https://support.microsoft.com/help/4583456) | January 12, 2021 |
| 14.0.3356.20 | CU22 | [KB4577467](https://support.microsoft.com/help/4577467) | September 10, 2020 |
| 14.0.3335.7 | CU21 | [KB4557397](https://support.microsoft.com/help/4557397) | July 01, 2020 |
| 14.0.3294.2 | CU20 | [KB4541283](https://support.microsoft.com/help/4541283) | April 10, 2020 |
| 14.0.3281.6 | CU19 | [KB4535007](https://support.microsoft.com/help/4535007) | February 05, 2020 |
| 14.0.3257.3 | CU18 <sup>4, 5</sup> | [KB4527377](https://support.microsoft.com/help/4527377) | December 09, 2019 |
| 14.0.3238.1 | CU17 | [KB4515579](https://support.microsoft.com/help/4515579) | October 08, 2019 |
| 14.0.3223.3 | CU16 | [KB4508218](https://support.microsoft.com/help/4508218) | August 01, 2019 |
| 14.0.3192.2 | CU15 + GDR | [KB4505225](https://support.microsoft.com/help/4505225) | July 09, 2019 |
| 14.0.2027.2 | GDR | [KB4505224](https://support.microsoft.com/help/4505224) | July 09, 2019 |
| 14.0.3162.1 | CU15 | [KB4498951](https://support.microsoft.com/help/4498951) | May 23, 2019 |
| 14.0.3103.1 | CU14 + GDR | [KB4494352](https://support.microsoft.com/help/4494352) | May 14, 2019 |
| 14.0.2014.14 | GDR | [KB4494351](https://support.microsoft.com/help/4494351) | May 14, 2019 |
| 14.0.3076.1 | CU14 | [KB4484710](https://support.microsoft.com/help/4484710) | March 25, 2019 |
| 14.0.3048.4 | CU13 | [KB4466404](https://support.microsoft.com/help/4466404) | December 18, 2018 |
| 14.0.3045.24 | CU12 | [KB4464082](https://support.microsoft.com/help/4464082) | October 24, 2018 |
| 14.0.3038.14 | CU11 | [KB4462262](https://support.microsoft.com/help/4462262) | September 20, 2018 |
| 14.0.3037.1 | CU10 | [KB4342123](https://support.microsoft.com/help/4342123) | August 27, 2018 |
| 14.0.3035.2 | CU9 + GDR | [KB4293805](https://support.microsoft.com/help/4293805) | August 18, 2018 |
| 14.0.2002.14 | GDR | [KB4293803](https://support.microsoft.com/help/4293803) | August 18, 2018 |
| 14.0.3030.27 | CU9 | [KB4341265](https://support.microsoft.com/help/4341265) | July 18, 2018 |
| 14.0.3029.16 | CU8 | [KB4338363](https://support.microsoft.com/help/4338363) | June 21, 2018 |
| 14.0.3026.27 | CU7 | [KB4229789](https://support.microsoft.com/help/4229789) | May 24, 2018 |
| 14.0.3025.34 | CU6 | [KB4101464](https://support.microsoft.com/help/4101464) | April 19, 2018 |
| 14.0.3023.8 | CU5 | [KB4092643](https://support.microsoft.com/help/4092643) | March 20, 2018 |
| 14.0.3022.28 | CU4 <sup>6</sup> | [KB4056498](https://support.microsoft.com/help/4056498) | February 20, 2018 |
| 14.0.3015.40 | CU3 + GDR | [KB4058562](https://support.microsoft.com/help/4058562) | January 03, 2018 |
| 14.0.2000.63 | GDR | [KB4057122](https://support.microsoft.com/help/4057122) | January 03, 2018 |
| 14.0.3008.27 | CU2 | [KB4052574](https://support.microsoft.com/help/4052574) | November 28, 2017 |
| 14.0.3006.16 | CU1 | [KB4038634](https://support.microsoft.com/help/4038634) | October 24, 2017 |
| 14.0.1000.169 | RTM | NA | October 02, 2017 |

<sup>1</sup> The latest GDR release includes the Azure Connect Pack for SQL Server 2017.

<sup>2</sup> This is the final cumulative update for SQL Server 2017.

<sup>3</sup> This is the Azure Connect Pack, which includes CU 31 for SQL Server 2017. Any future GDR updates include the Azure Connect Pack.

<sup>4</sup> Change Data Capture (CDC) is supported with SQL Server 2017 on Linux starting with CU 18.

<sup>5</sup> Transactional Replication is supported with SQL Server 2017 on Linux starting with CU 18.

<sup>6</sup> As of CU 4, SQL Server Agent is no longer installed as a separate package. It's installed with the SQL Server Database Engine package and must be enabled to use.

## Related content

- [Release notes for SQL Server on Linux](/sql/linux/sql-server-linux-release-notes)
- [SQL Server on Linux: Known issues](/sql/linux/sql-server-linux-known-issues)
- [Determine which version and edition of SQL Server Database Engine is running](../find-my-sql-version.md)
