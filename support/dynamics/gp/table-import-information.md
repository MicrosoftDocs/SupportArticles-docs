---
title: General information about Table Import in Microsoft Dynamics GP
description: This article lists some facts about Table Import in Microsoft Dynamics GP.
ms.reviewer: theley, dlanglie
ms.date: 03/13/2024
ms.custom: sap:Developer - Customization and Integration Tools
---
# General information about Table Import in Microsoft Dynamics GP

This article contains general information about Table Import in Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 867359

1. The Table Import program is built into Microsoft Dynamics GP. No extra install is needed.
2. To create a new table import **Definition ID**, from the menu, click **Tools** > **Integration** > **Table Import**.
3. The files that store the import definitions are as follows:
    - SY50000.dat
    - SY50000.idx
    - SY50100.dat
    - SY50100.idx
4. For Microsoft Dynamics GP version 10.0:  

    The files are stored in the Data folder in the Microsoft Dynamics GP code folder. This file can be located in the following path:

    *%Program Files%Microsoft Dynamics\GP\Data*  

    For Microsoft Dynamics GP version 9.0 and Microsoft Business Solutions - version 8.0:  

    The files are stored in the GP code folder on the local workstation where the Import Definition was first created.
