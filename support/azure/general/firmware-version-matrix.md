---
title: Firmware version matrix for Cloud Platform System (CPS) Premium
description: Provides a table that lists the file paths for firmware updates on Cloud Platform System (CPS) Premium. The table also describes the latest firmware version that's supported by the 1607 release of CPS Premium.
author: genlin
ms.author: genli
ms.service: cloud-platform-system
ms.date: 08/14/2020
ms.reviewer: 
---
# Firmware version matrix for Cloud Platform System (CPS) Premium

_Original product version:_ &nbsp; Cloud Platform System  
_Original KB number:_ &nbsp; 3182366

When you perform a field replaceable unit (FRU) operation for Cloud Platform System (CPS) Premium, you will probably have to update the firmware on the replacement part to make sure that it matches the version that's currently installed on the system. In most cases, we have created runbooks that will help you perform this operation. Starting in Update 1607, to use the runbooks, you must first download the required firmware file and save it to a location on the stamp. To make sure that you have the correct version of the firmware, use the table in the [More Information](#more-information) section to locate the path of the supported version of the firmware for your latest release.

Firmware and drivers are posted on the following Dell website:

[http://poweredgec.dell.com/cps](http://poweredgec.dell.com/cps/)  

**Third-party information disclaimer**

Microsoft provides third-party contact information to help you find technical support. This contact information may change without notice. Microsoft does not guarantee the accuracy of this third-party contact information.  

The table in the [More Information](#more-information) section describes the latest firmware version that's supported by the 1607 release. The full path will be `http://poweredgec.dell.com/cps/<FilePath>`.

> [!NOTE]
> The \<FilePath> placeholder represents the file path that's listed in the corresponding row of the table.

## More information

| Component| Platform| Category| Type| Minimum supported version| 1607 Latest version| File path |
|---|---|---|---|---|---|---|
|Mellanox ConnectX-3 PRO (10 Gb Mezz)|C6220|Network - Tenant|Driver||4.8|CPS_P_\<Release>/Firmware/C6220/Network/|
|Mellanox ConnectX-3 PRO (10 Gb Mezz)|C6220 II|Network - Tenant|Driver||4.8|CPS_P_\<Release>/Firmware/C6220II/Network/|
|Mellanox ConnectX-3 PRO (10 Gb Mezz)|C6320|Network - Tenant|Driver||4.8|CPS_P_\<Release>/Firmware/C6320/Network/|
|Chelsio T520-CR|C6320|Network - Datacenter|Driver||Package 5.0.0.44 Driver 5.5.11.0|CPS_P_\<Release>/Firmware/C6320/Network/|
|LSI 9207-8e (Dell Part # 4G89X)|R620|SAS HBA - External|Driver||2.00.78.00|CPS_P_\<Release>/Firmware/R630/Storage/|
|LSI 9207-8e (Dell Part # 4G89X)|R620 v2|SAS HBA - External|Driver||2.00.78.00|CPS_P_\<Release>/Firmware/R630/Storage/|
|LSI 9207-8e (Dell Part # 4G89X)|R630|SAS HBA - External|Driver||2.00.78.00|CPS_P_\<Release>/Firmware/R630/Storage/|
|Chelsio T420-CR|C6220|Network - Datacenter|Driver||Package 5.0.0.44 Driver 5.5.11.0|CPS_P_\<Release>/Firmware/C6220/Network/|
|Chelsio T520-CR|C6220 II|Network - Datacenter|Driver||Package 5.0.0.44 Driver 5.5.11.0|CPS_P_\<Release>/Firmware/C6220II/Network/|
|Chelsio T420-CR|R620|Network - Datacenter|Driver||Package 5.0.0.44 Driver 5.5.11.0|CPS_P_\<Release>/Firmware/R620/Network/|
|Chelsio T520-CR|R620 v2|Network - Datacenter|Driver||Package 5.0.0.44 Driver 5.5.11.0|CPS_P_\<Release>/Firmware/R620v2/Network/|
|Chelsio T520-CR|R630|Network - Datacenter|Driver||Package 5.0.0.44 Driver 5.5.11.0|CPS_P_\<Release>/Firmware/R630/Network/|
|FTOS Firmware|S4810|Network Switch|Firmware||9.10.0.1|CPS_P_\<Release>/Firmware/S4810/|
|U-Boot Bootflash|S4810|Network Switch|Firmware||1.2.0.5|CPS_P_\<Release>/Firmware/S4810/|
|FTOS Firmware|S55|Network Switch|Firmware||8.3.5.6|CPS_P_\<Release>/Firmware/S55/|
|U-Boot Bootflash|S55|Network Switch|Firmware||1.1.0.4|CPS_P_\<Release>/Firmware/S55/|
|OS Version|S4048|Network Switch|Firmware||9.10.0.1|CPS_P_\<Release>/Firmware/S4048/|
|ONIE Boot flash|S4048|Network Switch|Firmware||9.10.0.1|CPS_P_\<Release>/Firmware/S4048/|
|OS Version|S3048|Network Switch|Firmware||9.10.0.1|CPS_P_\<Release>/Firmware/S3048/|
|ONIE Boot flash|S3048|Network Switch|Firmware||9.10.0.1|CPS_P_\<Release>/Firmware/S3048/|
|EMM/ESM|MD3060e|EMM/ESM|Firmware|396|399|CPS_P_\<Release>/Firmware/MD3060e/|
|HGST Mars K Plus, HDD, 6 Gbps SAS, 3.5, 7.2 K, 512n|MD3060e|JBOD HDD|Firmware|W1CG|W350|CPS_P_\<Release>/Firmware/MD3060e/|
|Seagate Megalodon, HDD, 6 Gbps SAS, 3.5, 7.2 K, 512n|MD3060e|JBOD HDD|Firmware|GS0D|GS13|CPS_P_\<Release>/Firmware/MD3060e/|
|Not used- Toshiba MG03SCA400|MD3060e|JBOD HDD|Firmware||DG04|CPS_P_\<Release>/Firmware/MD3060e/|
|Western Digital WD4001FYYG / 202V7|MD3060e|JBOD HDD|Firmware||DXR8|CPS_P_\<Release>/Firmware/MD3060e/|
|Segate Makara HDD, 12 Gbps SAS, 3.5, 7.2 K, 512n|MD3060e|JBOD HDD|Firmware|DXR8|MS05|CPS_P_\<Release>/Firmware/MD3060e/|
|HGST Aries K Plus, HDD, 12 Gbps SAS, 3.5, 7.2 K, 512n|MD3060e|JBOD HDD|Firmware|DXR8|KJ03|CPS_P_\<Release>/Firmware/MD3060e/|
|EOL - SanDisk LB 806M|MD3060e|JBOD SSD|Firmware|D326|D336|CPS_P_\<Release>/Firmware/MD3060e/|
|Toshiba Phoenix M2 MU, SSD, 12 Gbps SAS, 2.5, 512n|MD3060e|JBOD Toshiba PX03SNF080 SSD|Firmware|A3AC|ASAF|CPS_P_\<Release>/Firmware/MD3060e/|
|Toshiba Phoenix M3 MU, SSD, 12 Gbps SAS, 2.5, 512e|MD3060e|JBOD Toshiba PX03SNF080 SSD|Firmware|A3AC|AM04|CPS_P_\<Release>/Firmware/MD3060e/|
|SanDisk SDLTODKM-800G 989r8|MD3060e|JBOD Sandisk SDLTODKM-800G-5C20 SSD|Firmware|D40Z|D414|CPS_P_\<Release>/Firmware/MD3060e/|
|LSI 9207-8e (Dell Part # 4G89X)|R620|SAS HBA - External|Firmware||P20|CPS_P_\<Release>/Firmware/R620/Storage/|
|LSI 9207-8e (Dell Part # 4G89X)|R620 v2|SAS HBA - External|Firmware||P20|CPS_P_\<Release>/Firmware/R620V2/Storage/|
|LSI 9207-8e (Dell Part # 4G89X)|R630|SAS HBA - External|Firmware||P20|CPS_P_\<Release>/Firmware/R630/Storage/|
|Chelsio T4 Firmware|T420-CR|Network - Datacenter|Firmware||1.14.4.0|CPS_P_\<Release>/Firmware/C6320/Network/|
|Chelsio Unified Boot Option ROM|T420-CR|Network - Datacenter|Firmware||1.0.0.68|CPS_P_\<Release>/Firmware/C6320/Network/|
|Chelsio T5 Firmware|T520-CR|Network - Datacenter|Firmware||1.14.4.0|CPS_P_\<Release>/Firmware/C6320/Network/|
|Chelsio Unified Boot Option ROM|T520-CR|Network - Datacenter|Firmware||1.0.0.68|CPS_P_\<Release>/Firmware/C6320/Network/|
|Fan Control Board|C6000 Chassis|Fan Control Board|Firmware DUP||1.25|CPS_P_\<Release>/Firmware/C6000/FCB/|
|Fan Control Board|C6300 Chassis|Fan Control Board|Firmware DUP||2.02|CPS_P_\<Release>/Firmware/C6300/FCB/|
|BIOS|C6220|BIOS|Firmware DUP||2.7.1|CPS_P_\<Release>/Firmware/C6220/BIOS/|
|BMC|C6220|BMC|Firmware DUP||2.59|CPS_P_\<Release>/Firmware/C6220/BMC/|
|Mellanox ConnectX-3 PRO (10 Gb Mezz)|C6220|Network - Tenant|Firmware DUP||2.31.5050|CPS_P_\<Release>/Firmware/C6220/Network/|
|Intel S3700|C6220|Storage|Firmware DUP||DL06|CPS_P_\<Release>/Firmware/C6220/Storage/|
|BIOS|C6220 II|BIOS|Firmware DUP||2.7.1|CPS_P_\<Release>/Firmware/C6220II/BIOS/|
|BMC|C6220 II|BMC|Firmware DUP||2.62|CPS_P_\<Release>/Firmware/C6220II/BMC/|
|Mellanox ConnectX-3 PRO (10 Gb Mezz)|C6220 II|Network - Tenant|Firmware DUP||2.31.5050|CPS_P_\<Release>/Firmware/C6220II/Network/|
|Intel S3700|C6220 II|Storage|Firmware DUP||DL06|CPS_P_\<Release>/Firmware/C6220II/Storage/|
|BIOS|C6320|BIOS|Firmware DUP||2.1.5|CPS_P_\<Release>/Firmware/C6320/BIOS/|
|Chipset Driver|C6320|Chipset Driver|Driver||10.1.2.10|CPS_P_\<Release>/Drivers/Chipset/|
|Mellanox ConnectX-3 PRO (10 Gb Mezz)|C6320|Network - Tenant|Firmware DUP||2.31.5050|CPS_P_\<Release>/Firmware/C6320/Network/|
|Intel S3610|C6320|Storage|Firmware DUP||DL27|CPS_P_\<Release>/Firmware/C6320/Storage/|
|BIOS|R620|BIOS|Firmware DUP||DL27|CPS_P_\<Release>/Firmware/R620/BIOS/|
|Chipset Driver|C6320|Chipset Driver|Driver||10.1.2.19|CPS_P_\<Release>/Drivers/Chipset/|
|iDRAC7|R620|BMC|Firmware DUP||2.30.30.30|CPS_P_\<Release>/Firmware/R620/BMC/|
|Intel X520 (10 Gb NDC)|R620|Network - Tenant|Firmware DUP||16.5.20|CPS_P_\<Release>/Firmware/R620/Network/|
|PERC H310|R620|SAS HBA - Internal|Firmware DUP||20.13.1-0002|CPS_P_\<Release>/Firmware/R620/Storage/|
|Intel S3700|R620|Storage|Firmware DUP||DL06|CPS_P_\<Release>/Firmware/R620/Storage/|
|BIOS|R620 v2|BIOS|Firmware DUP||2.5.4|CPS_P_\<Release>/Firmware/R620v2/BIOS/|
|iDRAC7|R620 v2|BMC|Firmware DUP||2.30.30.30|CPS_P_\<Release>/Firmware/R620V2/BMC/|
|Intel X520 (10 Gb NDC)|R620 v2|Network - Tenant|Firmware DUP||16.5.20|CPS_P_\<Release>/Firmware/R620v2/Network/|
|PERC H310|R620 v2|SAS HBA - Internal|Firmware DUP||20.13.1-0002|CPS_P_\<Release>/Firmware/R620v2/Storage/|
|Intel S3700|R620 v2|Storage|Firmware DUP||DL06|CPS_P_\<Release>/Firmware/R620v2/Storage/|
|BIOS|R630|BIOS|Firmware DUP||2.1.6|CPS_P_\<Release>/Firmware/R630/BIOS/|
|Chipset Driver|R630|Chipset Driver|Driver||10.1.2.19|CPS_P_\<Release>/Drivers/Chipset/|
|iDRAC8|R630|BMC|Firmware DUP||2.30.30.30|CPS_P_\<Release>/Firmware/R630/BMC/|
|PERC H330|R630|SAS HBA - Internal|Firmware DUP||25.4.0.0017|CPS_P_\<Release>/Firmware/R630/Storage/|
|LifeCycle Controller2|R630|Lifecycle Controller|Firmware DUP||2.30.30.30|CPS_P_\<Release>/Firmware/R630/BMC/|
|Intel X520 (10 Gb NDC)|R630|Network - Tenant|Firmware DUP||16.5.20|CPS_P_\<Release>/Firmware/R630/Network/|
|PERC H330|R630|SAS HBA - Internal|Driver DUP||6.603.07.00|CPS_P_\<Release>/Drivers/Storage/|
|Toshiba Phoenix M2 MU P/N K41XJ|R630|Storage - Boot SSD|Firmware DUP||A3AF|CPS_P_\<Release>/Firmware/R630/Storage/|
|Intel S3610 P/N 3481G|R630|Storage - Boot SSD|Firmware DUP||DL2B|CPS_P_\<Release>/Firmware/R630/Storage/|
|BIOS Settings Export Import - syscfg|C6220|BIOS|Tools - Deployment||4.4.3 (32)|CPS_P_\<Release>/Tools/Dell%20C6220%20Syscfg/|
|Mellanox Firmware Tool for Windows|C6220|Network - Tenant|Tools - Deployment||3.5.0|CPS_P_\<Release>/Tools/Mellanox%20Firmware%20Tools/|
|Mellanox Firmware Tool for Windows PE|C6220|Network - Tenant|Tools - Deployment||3.5.0|CPS_P_\<Release>/Tools/Mellanox%20Firmware%20Tools/|
|BIOS Settings Export Import - syscfg|C6220 II|BIOS|Tools - Deployment||4.4.3 (32)|CPS_P_\<Release>/Tools/Dell%20C6220%20Syscfg/|
|Mellanox Firmware Tool for Windows|C6220 II|Network - Tenant|Tools - Deployment||3.5.0|CPS_P_\<Release>/Tools/Mellanox%20Firmware%20Tools/|
|Mellanox Firmware Tool for Windows PE|C6220 II|Network - Tenant|Tools - Deployment||3.5.0|CPS_P_\<Release>/Tools/Mellanox%20Firmware%20Tools/|
|BIOS Settings Export Import - syscfg|C6320|BIOS|Tools - Deployment||5.2|CPS_P_\<Release>/Firmware/C6320/BIOS/|
|Mellanox Firmware Tool for Windows|C6320|Network - Tenant|Tools - Deployment||3.5.0|CPS_P_\<Release>/Tools/Mellanox%20Firmware%20Tools/|
|Mellanox Firmware Tool for Windows PE|C6320|Network - Tenant|Tools - Deployment||3.5.0|CPS_P_\<Release>/Tools/Mellanox%20Firmware%20Tools/|
|Active Fabric Manager (AFM)|Force10|Deployment / Update / Break-Fix|Tools - Deployment||AFM-CPS-2.0.0.0P7|CPS_P_\<Release>/Tools/Dell%20Active%20Fabric%20Manager/|
|SECLI|MD3060e|Deployment / Update / Break-Fix|Tools - Deployment||1.7.0.3548|CPS_P_\<Release>/Tools/Dell%20Storage%20Enclosure%20Management/|
|OMSA Agent|C6220|Management Agent|Tools - Software||7.3.4 (1128)|CPS_P_\<Release>/Tools/Dell%20OMSA%20Agent/|
|Management Pack Suite|C6220|Management Pack|Tools - Software||5.1.1 (X22)|CPS_P_\<Release>/Tools/Dell%20Management%20Pack%20Suite/|
|OMSA Agent|C6220 II|Management Agent|Tools - Software||7.3.4 (1128)|CPS_P_\<Release>/Tools/Dell%20OMSA%20Agent/|
|Management Pack Suite|C6220 II|Management Pack|Tools - Software||5.1.1 (X22)|CPS_P_\<Release>/Tools/Dell%20Management%20Pack%20Suite/|
|BMC Utility|C6220 II|Deployment / Update / Break-Fix|Tools - Deployment||7.3|CPS_P_\<Release>/Tools/Dell%20BMC%20Utility/|
|BMC Utility|C6320|Deployment / Update / Break-Fix|Tools - Deployment||8.2|CPS_P_\<Release>/Tools/Dell%20BMC%20Utility/|
|OMSA Agent|C6320|Management Agent|Tools - Software||8.2|CPS_P_\<Release>/Tools/Dell%20BMC%20Utility/|
|Management Pack Suite|C6320|Management Pack|Tools - Software||6.1.1|CPS_P_\<Release>/Tools/Dell%20Management%20Pack%20Suite/|
|OMSA Agent|R620|Management Agent|Tools - Software||7.3.4 (1128)|CPS_P_\<Release>/Tools/Dell%20OMSA%20Agent/7.3.4/|
|Management Pack Suite|R620|Management Pack|Tools - Software||5.1.1 (X22)|CPS_P_\<Release>/Tools/Dell%20Management%20Pack%20Suite/|
|OMSA Agent|R620 v2|Management Agent|Tools - Software||7.3.4 (1128)|CPS_P_\<Release>/Tools/Dell%20OMSA%20Agent/7.3.4/|
|Management Pack Suite|R620 v2|Management Pack|Tools - Software||5.1.1 (X22)|CPS_P_\<Release>/Tools/Dell%20Management%20Pack%20Suite/|
|BMC Utility|R620 v2|Deployment / Update / Break-Fix|Tools - Deployment||7.3|CPS_P_\<Release>/Tools/Dell%20BMC%20Utility/|
|OMSA Agent|R630|Management Agent|Tools - Software||8.0.1 + 8.0.1.1 patch|CPS_P_\<Release>/Tools/Dell%20OMSA%20Agent/8.0.1/|
|Management Pack Suite|R630|Management Pack|Tools - Software||5.1.1 (X22)|CPS_P_\<Release>/Tools/Dell%20Management%20Pack%20Suite/|
|BIOS Settings Export Import - syscfg (DTK)|R630|BIOS|Tools - Deployment||5.0.1 A00|CPS_P_\<Release>/Tools/Dell%20DTK/|
|BMC Utility|R630|Deployment / Update / Break-Fix|Tools - Deployment||7.3|CPS_P_\<Release>/Tools/Dell%20BMC%20Utility/|

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]
