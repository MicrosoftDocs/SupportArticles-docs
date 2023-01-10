---
title: Use Workgroup Administrator utility
description: This article describes how to use the Workgroup Administrator utility in Microsoft Access.
author: helenclu
manager: dcscontentpm
localization_priority: Normal
ms.custom: 
  - CI 111294
  - CSSTroubleshoot
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.author: luche
ms.reviewer: jchishol
appliesto: 
  - Access 2007
ms.date: 3/31/2022
---

# How to use the Workgroup Administrator utility in Access

This article applies to Microsoft Access .mdb files and .accdb files.

## Introduction

This article describes how to use the Workgroup Administrator utility in Microsoft Access.

**Note** User-level security does not exist in an .accdb file, even though you can run the Workgroup Administrator utility from an .accdb file in Access.

## More information

To use the Workgroup Administrator in earlier versions of Access, you could click **Workgroup Administrator** in **Security** on the **Tools** menu. To use the Workgroup Administrator utility in Access, use one of the following methods.

### Method 1: Use Visual Basic code

To use Visual Basic code, use one of the following methods.

- Run the Visual Basic code in the Immediate window:
  1. In Access 2007 or a later version, open a trusted database, or enable macros in the existing database.   
  2. Press CTRL + G to open the **Immediate** window.   
  3. Type the following line of code, and then press ENTER.DoCmd.RunCommand acCmdWorkgroupAdministrator   
   
- Create a module that contains the Visual Basic code:
  1. In Access 2007 and later, open a trusted database, or enable macros in the existing database.   
  2. On the **Create** tab, in the **Other** group, click **Macro**, and then click **Module**.   
  3. Create a subroutine, and then paste the following Visual Basic code example into the subroutine.

      **DoCmd.RunCommand acCmdWorkgroupAdministrator**

  4. Press F5 to run the code.   

### Method 2: Use the RunCommand macro action

1. In Access 2007 or a later version, open a trusted database, or enable macros in the existing database.   
2. On the **Create** tab, in the **Other** group, click **Macro**, and then click **Macro**.   
3. On the **Design** tab, click **Show All Actions** in the **Show/Hide** group.   
4. On the **Macro1** tab, click **RunCommand** in the **Action** column, and then click **WorkgroupAdminstrator** in the **Command** list.   
5. Click **Save**.   
6. In the **Tools** group, click **Run**.   
