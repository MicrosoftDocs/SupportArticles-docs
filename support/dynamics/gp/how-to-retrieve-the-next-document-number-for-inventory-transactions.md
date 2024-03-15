---
title: How to get next document number for Inventory in Miscellaneous Routines Assembly
description: How to retrieve the next document number for Inventory transactions when you use the Miscellaneous Routines Assembly in eConnect.
ms.reviewer: theley, kjohns
ms.topic: how-to
ms.date: 03/13/2024
---
# How to retrieve the next document number for Inventory transactions when you use the Miscellaneous Routines Assembly in eConnect

This article describes how to retrieve the next document number for Inventory transactions when you use the Miscellaneous Routines Assembly in eConnect in Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 939277

## More information

The Miscellaneous Routines Assembly in eConnect contains methods that you can use to retrieve the next document number for various document types in Microsoft Dynamics GP.

The following sample code illustrates how to retrieve the next document number for Inventory transactions by using Microsoft Visual C# code and by using Microsoft Visual Basic .NET 2003 code.

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
                string nextIVNumber = "";
                GetNextDocNumbers.IVDocType docType;

                Console.WriteLine ("Please select a document type: ");
                Console.WriteLine ("1 = IV Adjustment");
                Console.WriteLine ("2 = IV Transfer");
                Console.WriteLine ("3 = IV Variance");
                string sDocType = Console.ReadLine ().ToString ();

                switch (sDocType) {
                    case "1":
                        docType = GetNextDocNumbers.IVDocType.IVAdjustment;
                        break;
                    case "2":
                        docType = GetNextDocNumbers.IVDocType.IVTransfer;
                        break;
                    case "3":
                        docType = GetNextDocNumbers.IVDocType.IVVariance;
                        break;
                    default:
                        throw new Exception ("Invalid Document Type");
                }
                nextIVNumber = oNextDoc.GetNextIVNumber (GetNextDocNumbers.IncrementDecrement.Increment, docType, cnString);
                Console.WriteLine ("The next " + docType + " Document Number is " + nextIVNumber);
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

### Microsoft Visual Basic .NET 2003 sample code

```vb
'Visual Basic .NET
Imports Microsoft.GreatPlains.eConnect.MiscRoutines
Module MiscRoutines

    Sub Main()
        Try
            Dim cnString As String = "Data Source=MYSERVER;initial catalog=TWO;integrated security=SSPI;
            persist security info=False;packet size=4096"
            
            Dim oNextDoc As New GetNextDocNumbers()
            Dim nextIVNumber As String = ""
            Dim docType As GetNextDocNumbers.IVDocType

            Console.WriteLine("Please select a document type: ")
            Console.WriteLine("1 = IV Adjustment")
            Console.WriteLine("2 = IV Transfer")
            Console.WriteLine("3 = IV Variance")
            Dim sDocType As String = Console.ReadLine().ToString()

            Select Case (sDocType)
                Case "1"
                    docType = GetNextDocNumbers.IVDocType.IVAdjustment
                Case "2"
                    docType = GetNextDocNumbers.IVDocType.IVTransfer
                Case "3"
                    docType = GetNextDocNumbers.IVDocType.IVVariance
                Case Else
                    Throw New Exception("Invalid Document Type")
            End Select

            nextIVNumber = oNextDoc.GetNextIVNumber(GetNextDocNumbers.IncrementDecrement.Increment, docType, cnString)
            Console.WriteLine("The next " & docType & " Document Number is " & nextIVNumber)
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
