---
title: Install Internet Explorer 10 on hybrid graphics systems
description: Discusses that an Internet Explorer 10 for Windows 7 installation fails because of an incompatible driver for a hybrid video card, and you receive an error message.
ms.date: 06/09/2020
ms.reviewer: 
---
# Internet Explorer 10 does not install on some hybrid graphics systems

[!INCLUDE [](../../../includes/browsers-important.md)]

This article provides information about Internet Explorer 10 can't be installed on Windows 7, because a hybrid video card isn't compatible with it.

_Original product version:_ &nbsp; Internet Explorer 11, Internet Explorer 10  
_Original KB number:_ &nbsp; 2823483

## Symptoms

Internet Explorer 10 for Windows 7 doesn't install correctly, and you receive error code **9C57** together with the following error message:

> Internet Explorer needs an update before installing

## Cause

This issue occurs because some computers have hybrid video cards that are not yet compatible with Internet Explorer 10 or later versions for Windows 7. Internet Explorer 10 or later versions will not install on these computers until updated hardware drivers are available for these video cards.

## More information

The following tables list the known computer models that are affected and include download links to compatible drivers if such links are available. If a link is not available for your computer model, you should check your video card manufacture's website for more details, and then download and install the updated driver.

### Dell systems

|System|Graphics hardware|Latest compatible drivers|
|---|---|---|
|Inspiron 14 R N4110 and N4120|AMD Radeon HD 6470M<br/>AMD Radeon HD 6630M<br/>AMD Radeon HD 7450M<br/>AMD Radeon HD 7650M|None|
|Vostro 3350 & 3550|AMD Radeon HD 6630M<br/>AMD Radeon HD 7650M| [8.901.1.1, A10](http://www.dell.com/support/drivers/us/en/19/driverdetails?driverid=g22hg) (Released 4/2012)|
|Inspiron 15 R N5110|AMD Radeon HD 6470M| [8.901.1.1, A10](http://www.dell.com/support/drivers/us/en/19/driverdetails?driverid=g22hg) (Released 4/2012)|
|Vostro 3450|AMD Radeon HD 6630M<br/>AMD Radeon HD 7650M|None|
|Inspiron 14 N4050|AMD Radeon HD 6470M| [8.930.0.0000, A03](http://www.dell.com/support/drivers/us/en/19/driverdetails?driverid=kk4kw) (Released 4/2012)<br/> [8.860.0.0, A01](http://www.dell.com/support/drivers/us/en/19/driverdetails?driverid=cfj09) (Released 8/2011)|
|Vostro 1450|AMD Radeon HD 6470M<br/>AMD Radeon HD 7450M| [8.88+2342, A02](http://www.dell.com/support/drivers/us/en/19/driverdetails?driverid=2m9xt), A03 (Released 3/2012)<br/> [8.860.0.0, A01](http://www.dell.com/support/drivers/us/en/19/driverdetails?driverid=cfj09) (Released 8/2011)|
  
### HP systems

|System|Graphics hardware|Latest compatible drivers|
|---|---|---|
|Pavilion dv6 (dv6-6007tx, dv6-6b06eg, dv6-6b07sz, dv6-6b56ex)<br/>Pavilion dv7 (dv7-6135dx, dv7-6197ca, dv7-6b40ew)|AMD Radeon HD 6490M<br/><br/>AMD Radeon HD 6770M| [8.882.2.3000](https://h30434.www3.hp.com/t5/Notebooks-Archive-Read-Only/Problems-with-new-AMD-drivers-8-882-2-3000-for-HP-Pavilion/td-p/1073181) (Released 11/2011)|
|Pavilion g4 (1212tx)<br/>Pavilion g6 (1160ee, 1320ee)<br/>Pavilion g7 (1226em)|AMD Radeon HD 6470M| [8.882.2.0](https://drivers.softpedia.com/get/GRAPHICS-BOARD/AMD/HP-2000-211HE-AMD-HD-Graphics-Driver-888220-for-Windows-7.shtml) (Released 10/2011)|
|ProBook 4330 s, 4331 s, 4431 s 4530 s, 4730 s|AMD Radeon HD 6490M| [8.91-111013A-128465C](https://ftp.hp.com/pub/softpaq/sp55001-55500/sp55304.exe) (Released 11/2011)|
|Pavilion dv4 (3029tx)|AMD Radeon HD 6750M|None|
|Envy 14 (2070ez)|AMD Radeon HD 6630M|None|
  
### Lenovo systems

|System|Graphics hardware|Latest compatible drivers|
|---|---|---|
|G570|AMD Radeon HD 6370M<br/>AMD Radeon HD 7370M|None|
|G470|AMD Radeon HD 6370M<br/>AMD Radeon HD 7370M|None|
|ThinkPad Edge E420|AMD Radeon HD 6470M<br/>AMD Radeon HD 6630M| [8.951.0.0000](https://support.lenovo.com/us/en/downloads/ds014099) (Released 7/2012)|
|G770|AMD Radeon HD 6650M|None|
|IdeaPad Y470|AMD Radeon HD 6730M|None|
|ThinkPad Edge E420s<br/>ThinkPad Edge S420|AMD Radeon HD 6630M|None|
|IdeaPad U400|AMD Radeon HD 6470M| [8.851.0.0](https://download.lenovo.com/UserFiles/Driver/en/Downloads%20and%20Drivers/U400/Win7%20Update/IN1VDO77WW5.exe) (Released 11/2011)|
  
### Sony systems

|System|Graphics hardware|Latest compatible drivers|
|---|---|---|
|Sony VPCCA1x<br/>Sony VPCCA2x<br/>Sony VPCCA3x<br/>Sony VPCCA4x<br/>Sony VPCCB1x<br/>Sony VPCCB2x<br/>Sony VPCCB3x<br/>Sony VPCCB4x|AMD Radeon HD 6630M|None|
|Sony VPCJ2x|AMD Radeon HD 6470M|None|
  
> [!NOTE]
> For computers for which **None** is listed in the **Latest compatible drivers** column, Microsoft is currently working with AMD to find the cause of the problem and determine the appropriate fix. If you have platform update KB 2670838 for Windows 7 installed on this computer, we recommend that you uninstall the update.

## Status

Microsoft is working with device manufacturers to provide updated software to resolve this issue. For new information about updated driver software, see [Platform update for Windows 7 SP1 and Windows Server 2008 R2 SP1](https://support.microsoft.com/help/2670838).
