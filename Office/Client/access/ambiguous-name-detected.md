---
title: Unable to run a procedure with ambiguous name detected
description: Fixes an issue in which you can't run a procedure because there are multiple procedures with the same name in a module.
author: Cloud-Writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - CI 114797
  - CSSTroubleshoot
ms.reviewer: 
appliesto: 
  - Microsoft Office Access 2007
  - Microsoft Office Access 2003
search.appverid: MET150
ms.date: 05/26/2025
---
# "Ambiguous name detected" error when you run a procedure in Access

_Original KB number:_ &nbsp; 817411

> [!NOTE]
> Requires basic macro, coding, and interoperability skills.

## Symptoms

When you run a procedure in Microsoft Access 2000 or later, you may receive the following error message:

> The expression **Event_Name** you entered as the event property setting produced the following error: Ambiguous name detected: **EventProcedure_Name**.

## Cause

This error occurs when there are multiple procedures with the same name in a module.

## Workaround

To work around this problem, delete the unwanted duplicate procedure. To do this, follow these steps:

1. Open the form in Design view.
2. In Microsoft Office Access 2003, click **Code** on the **View** menu.

   In Microsoft Office Access 2007, click **View Code** in the **Tools** group on the **Design** tab.

3. On the **Debug** menu, click **Compile Database Name**.

   You receive the following error message:
   
   > Compile error: Ambiguous name detected: **Procedure Name**.

4. Notice the procedure name, and then click **OK**.
5. In the code, find the other occurrences of the **Procedure Name** procedure, where **Procedure Name** produced the compile error mentioned in step 3.
6. Select and then delete the unwanted procedure.
7. On the **Debug** menu, click **Compile Database Name**.
8. On the **File** menu, click **Close**.
