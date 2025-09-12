---
title: How to get next document number for Receivables Management
description: How to retrieve the next document number for Receivables Management documents when you use the Miscellaneous Routines Assembly in eConnect.
ms.reviewer: theley, kjohns
ms.topic: how-to
ms.date: 04/17/2025
ms.custom: sap:Financial - Receivables Management
---
# How to retrieve the next document number for Receivables Management documents when using Miscellaneous Routines Assembly in eConnect

This article describes how to retrieve the next document number for Receivables Management documents when you use the Miscellaneous Routines Assembly in eConnect in Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 939274

## More information

The Miscellaneous Routines Assembly in eConnect contains methods that you can use to retrieve the next document number for various document types in Microsoft Dynamics GP.

The following sample code illustrates how to retrieve the next document number for Receivables Management documents by using Microsoft Visual C# code and by using Microsoft Visual Basic .NET 2003 code.

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
                string nextRMNumber = "";
                GetNextDocNumbers.RMPaymentType docType;

                Console.WriteLine ("Please select a document type: ");
                Console.WriteLine ("1 = RM Credit Memo");
                Console.WriteLine ("2 = RM Debit Memo");
                Console.WriteLine ("3 = RM Finance Charge");
                Console.WriteLine ("4 = RM Invoice");
                Console.WriteLine ("5 = RM Payment");
                Console.WriteLine ("6 = RM Return");
                Console.WriteLine ("7 = RM Scheduled Payment");
                Console.WriteLine ("8 = RM Service Repair");
                Console.WriteLine ("9 = RM Warranty");
                string sDocType = Console.ReadLine ().ToString ();

                switch (sDocType) {
                    case "1":
                        docType = GetNextDocNumbers.RMPaymentType.RMCreditMemo;
                        break;
                    case "2":
                        docType = GetNextDocNumbers.RMPaymentType.RMDebitMemos;
                        break;
                    case "3":
                        docType = GetNextDocNumbers.RMPaymentType.RMFinanceCharges;
                        break;
                    case "4":
                        docType = GetNextDocNumbers.RMPaymentType.RMInvoices;
                        break;
                    case "5":
                        docType = GetNextDocNumbers.RMPaymentType.RMPayments;
                        break;
                    case "6":
                        docType = GetNextDocNumbers.RMPaymentType.RMReturn;
                        break;
                    case "7":
                        docType = GetNextDocNumbers.RMPaymentType.RMScheduledPayments;
                        break;
                    case "8":
                        docType = GetNextDocNumbers.RMPaymentType.RMServiceRepairs;
                        break;
                    case "9":
                        docType = GetNextDocNumbers.RMPaymentType.RMWarranty;
                        break;
                    default:
                        throw new Exception ("Invalid Document Type");
                }
                nextRMNumber = oNextDoc.GetNextRMNumber (GetNextDocNumbers.IncrementDecrement.Increment, docType, cnString);
                Console.WriteLine ("The next Document Number is " + nextRMNumber);
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
            Dim nextRMNumber As String = ""
            Dim docType As GetNextDocNumbers.RMPaymentType

            Console.WriteLine("Please select a document type: ")
            Console.WriteLine("1 = RM Credit Memo")
            Console.WriteLine("2 = RM Debit Memo")
            Console.WriteLine("3 = RM Finance Charge")
            Console.WriteLine("4 = RM Invoice")
            Console.WriteLine("5 = RM Payment")
            Console.WriteLine("6 = RM Return")
            Console.WriteLine("7 = RM Scheduled Payment")
            Console.WriteLine("8 = RM Service Repair")
            Console.WriteLine("9 = RM Warranty")
            Dim sDocType As String = Console.ReadLine().ToString()

            Select Case (sDocType)
                Case "1"
                    docType = GetNextDocNumbers.RMPaymentType.RMCreditMemo
                Case "2"
                    docType = GetNextDocNumbers.RMPaymentType.RMDebitMemos
                Case "3"
                    docType = GetNextDocNumbers.RMPaymentType.RMFinanceCharges
                Case "4"
                    docType = GetNextDocNumbers.RMPaymentType.RMInvoices
                Case "5"
                    docType = GetNextDocNumbers.RMPaymentType.RMPayments
                Case "6"
                    docType = GetNextDocNumbers.RMPaymentType.RMReturn
                Case "7"
                    docType = GetNextDocNumbers.RMPaymentType.RMScheduledPayments
                Case "8"
                    docType = GetNextDocNumbers.RMPaymentType.RMServiceRepairs
                Case "9"
                    docType = GetNextDocNumbers.RMPaymentType.RMWarranty
                Case Else
                    Throw New Exception("Invalid Document Type")
            End Select

            nextRMNumber = oNextDoc.GetNextRMNumber(GetNextDocNumbers.IncrementDecrement.Increment, docType, cnString)
            Console.WriteLine("The next Document Number is " & nextRMNumber)
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
