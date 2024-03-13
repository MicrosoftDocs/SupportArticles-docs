---
title: Retrieve next payment number for Payables Management payments when you use the Miscellaneous Routines Assembly in eConnect
description: Describes how to retrieve the next payment number for Payables Management payments when you use the Miscellaneous Routines Assembly in eConnect.
ms.topic: how-to
ms.reviewer: dclauson
ms.date: 03/13/2024
---
# How to retrieve the next payment number for Payables Management payments when you use the Miscellaneous Routines Assembly in eConnect

This article describes how to retrieve the next payment number for Payables Management payments when you use the Miscellaneous Routines Assembly in eConnect in Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 939276

## Introduction

The Miscellaneous Routines Assembly in eConnect contains methods that you can use to retrieve the next document number for various document types in Microsoft Dynamics GP.

The following sample code illustrates how to retrieve the next payment number for Payables Management payments by using Microsoft Visual C# code and by using Microsoft Visual Basic .NET 2003 code.

Before you use the sample code, you have to set the following references:

- eConnect.MiscRoutines.dll
- System.Enterprise.Services

To set these references, follow these steps:

1. In Microsoft Visual Studio, right-click **References**. In **Solution Explorer**, click **Add Reference**.
2. Open the following folder: C:\\Program Files\\Microsoft Great Plains\\eConnect9\\Objects\\DOT NET
3. Click the **eConnect.MiscRoutines.dll** reference.
4. Under **.NET**, click the **System.Enterprise.Services** reference.

## Visual Csharp sample code

```csharp
using System;
using System.Collections.Generic;
using System.Text;
using Microsoft.GreatPlains.eConnect.MiscRoutines;

namespace MiscRoutinesConsole
{
    class ClassMiscRoutines
    {
        static void Main(string[] args)
        {
            try
            {
                string cnString = @"Data Source=MYSERVER;initial catalog=TWO;integrated security=SSPI;
                persist security info=False;packet size=4096";
                
                GetNextDocNumbers oNextDoc = new GetNextDocNumbers();
                string nextPMPaymentNumber = "";

                nextPMPaymentNumber = oNextDoc.GetNextPMPaymentNumber(GetNextDocNumbers.IncrementDecrement.Increment, cnString);
                Console.WriteLine("The next PM Payment Number is " + nextPMPaymentNumber);
                Console.WriteLine("Press <Enter> to close...");
                Console.Read();
            }
            catch (Exception ex)
            {
                Console.WriteLine(ex.ToString());
                Console.WriteLine("Press <Enter> to close...");
                Console.Read();
            }
        }
    }
}
```

## Visual Basic .NET 2003 sample code

```vb
Imports Microsoft.GreatPlains.eConnect.MiscRoutines
Module MiscRoutines

    Sub Main()
        Try
            Dim cnString As String = "Data Source=MYSERVER;initial catalog=TWO;integrated security=SSPI;
            persist security info=False;packet size=4096"
            
            Dim oNextDoc As New GetNextDocNumbers()
            Dim nextPMPaymentNumber As String = ""

            nextPMPaymentNumber = oNextDoc.GetNextPMPaymentNumber(GetNextDocNumbers.IncrementDecrement.Increment, cnString)
            Console.WriteLine("The next PM Payment Number is " & nextPMPaymentNumber)
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
