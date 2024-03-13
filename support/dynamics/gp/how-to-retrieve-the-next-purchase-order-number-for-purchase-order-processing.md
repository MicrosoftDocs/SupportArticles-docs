---
title: How to get next purchase order number for Purchase Order Processing documents
description: How to retrieve the next purchase order number for Purchase Order Processing documents when you use the Miscellaneous Routines Assembly in eConnect.
ms.reviewer: dclauson
ms.topic: how-to
ms.date: 03/13/2024
---
# How to retrieve the next purchase order number for Purchase Order Processing documents when you use the Miscellaneous Routines Assembly in eConnect

This article describes how to retrieve the next purchase order number for Purchase Order Processing documents when you use the Miscellaneous Routines Assembly in eConnect in Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 939275

## More information

The Miscellaneous Routines Assembly in eConnect contains methods that you can use to retrieve the next purchase order number for various document types in Microsoft Dynamics GP.

The following sample code illustrates how to retrieve the next purchase order number for Purchase Order Processing documents by using Microsoft Visual C# code and by using Microsoft Visual Basic .NET 2003 code.

Before you use the sample code, you have to set the following references:

- eConnect.MiscRoutines.dll
- System.Enterprise.Services

To set these references, follow these steps:

1. In Microsoft Visual Studio, right-click **References**. In **Solution Explorer**, select **Add Reference**.

2. Open the folder: C:\Program Files\Microsoft Great Plains\eConnect9\Objects\DOT NET.
3. Select the **eConnect.MiscRoutines.dll** reference.
4. Under **.NET**, select the **System.Enterprise.Services** reference.

### Microsoft Visual C# sample code

```cs
//C#
using System;
using System.Collections.Generic;
using System.Text;
using Microsoft.GreatPlains.eConnect.MiscRoutines;

namespace MiscRoutinesConsole {
    class ClassMiscRoutines {
        static void Main (string[] args) {
            try {
                string cnString = @"Data Source=MYSERVER;initial catalog=TWO;integrated security=SSPI;
                persist security info=False;packet size=4096";

                GetNextDocNumbers oNextDoc = new GetNextDocNumbers ();
                string nextPONumber = "";

                nextPONumber = oNextDoc.GetNextPONumber (GetNextDocNumbers.IncrementDecrement.Increment, cnString);
                Console.WriteLine ("The next Purchase Order Number is " + nextPONumber);
                Console.WriteLine ("Press <Enter> to close...");
                Console.Read ();
            } catch (Exception ex) {
                Console.WriteLine (ex.ToString ());
                Console.WriteLine ("Press <Enter> to close...");
                Console.Read ();
            }
        }
    }
}
```

### Microsoft Visual Basic .NET 2003

```vb
'Visual Basic .NET
Imports Microsoft.GreatPlains.eConnect.MiscRoutines
Module MiscRoutines

    Sub Main()
        Try
            Dim cnString As String = "Data Source=MYSERVER;initial catalog=TWO;integrated security=SSPI;
            persist security info=False;packet size=4096"
            
            Dim oNextDoc As New GetNextDocNumbers()
            Dim nextPONumber As String = ""

            nextPONumber = oNextDoc.GetNextPONumber(GetNextDocNumbers.IncrementDecrement.Increment, cnString)
            Console.WriteLine("The next Purchase Order Number is " & nextPONumber)
            Console.WriteLine("Press <Enter> to close...")
            Console.Read()
        Catch ex As Exception
            Console.WriteLine(ex.ToString())
            Console.WriteLine("Press <Enter> to close...")
            Console.Read()
        End Try
    End Sub
End Module
```
