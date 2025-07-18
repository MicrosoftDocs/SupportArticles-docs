---
title: How To parse City, State, and Zip Code into separate values
description: Describes how to parse a single variable containing US City, State, and Zip Code information into three separate variables.
author: Cloud-Writer
manager: dcscontentpm
search.appverid: 
  - MET150
audience: ITPro
ms.custom: 
  - CSSTroubleshoot
ms.topic: troubleshooting
ms.author: meerak
appliesto: 
  - Access for Microsoft 365
  - Access 2019
  - Access 2016
  - Access 2013
  - Access 2010
  - Access 2007
  - Access 2003
ms.reviewer: malcolms
ms.date: 05/26/2025
---
# How To Parse City, State, and Zip Code into Separate Values

_Original product version:_ &nbsp; Microsoft Office Access 2003, Microsoft Office Access 2007, Access 2010  
_Original KB number:_ &nbsp; 168798

## Summary

This article provides a procedure for parsing a single variable containing US City, State, and Zip Code information into three separate variables. The routine supports:

- Either 5- or 9-digit zip code.
- Multi-word state names (if preceded by a comma).
- Any number of intermediate spaces.

Examples of supported inputs:

> New York, New York, 99999  
New York, NY, 99999-9999  
New York, NY 99999-9999  
New York NY 99999

## More information

WARNING: ANY USE BY YOU OF THE CODE/MACRO PROVIDED IN THIS ARTICLE IS AT YOUR OWN RISK. Microsoft provides this code/macro "as is" without warranty of any kind, either express or implied, including but not limited to the implied warranties of merchantability and/or fitness for a particular purpose.

NOTE: In the following sample code, an underscore (_) at the end of a line is used as a line-continuation character. For versions of BASIC that don't support line-continuation characters, remove the underscore from the end of the line and merge with the following line when re-creating this code.

Fields are parsed in the following order if no commas are found in the address:
Zip Code, State, City
If at least one comma is present, it is presumed to be between City and State, and the fields are parsed in a different order:
City, State, Zip Code

### Step-by-Step Example

1. Enter the following code:

    ```vb
    Function CutLastWord (ByVal S As String, Remainder As String) _
             As String
        ' CutLastWord: returns the last word in S.
        ' Remainder: returns the rest.
        '
        ' Words are separated by spaces
        '
        Dim I           As Integer, P As Integer
        S = Trim$(S)
        P = 1
        For I = Len(S) To 1 Step -1
            If Mid$(S, I, 1) = " " Then
                P = I + 1
                Exit For
            End If
        Next I
        If P = 1 Then
            CutLastWord = S
            Remainder = ""
        Else
            CutLastWord = Mid$(S, P)
            Remainder = Trim$(Left$(S, P - 1))
        End If
    End Function

    Sub ParseCSZ (ByVal S As String, City As String, State As String, _
        Zip             As String)
        Dim P           As Integer
        '
        ' Check for comma after city name
        '
        P = InStr(S, ",")
        If P > 0 Then
            City = Trim$(Left$(S, P - 1))
            S = Trim$(Mid$(S, P +        '
            ' Check for comma after state
            '
            P = InStr(S, ",")
            If P > 0 Then
                State = Trim$(Left$(S, P - 1))
                Zip = Trim$(Mid$(S, P + 1))
            Else        ' No comma between state and zip
                Zip = CutLastWord(S, S)
                State = S
            End If
        Else        ' No commas between city, state, or zip
            Zip = CutLastWord(S, S)
            State = CutLastWord(S, S)
            City = S
        End If
        '
        ' Clean up any dangling commas
        '
        If Right$(State, 1) = "," Then
            State = RTrim$(Left$(State, Len(State) - 1))
        End If
        If Right$(City, 1) = "," Then
            City = RTrim$(Left$(City, Len(City) - 1))
        End If
    End Sub
    ```

2. To test, create a form with four text boxes (txtAddress, txtCity, txtState, txtZip), and a command button. Add the following code:

    ```vb
    Sub Command1_Click()
        Dim City        As String, State As String, Zip As String
        ParseCSZ txtAddress, City, State, Zip
        txtCity = City
        txtState = State
        txtZip = Zip
    End Sub
    ```

3. Display the form, type an address into txtAddress, and click the command button. The other three fields should contain the parsed values.
