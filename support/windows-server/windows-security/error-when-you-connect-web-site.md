---
title: Error 403 or 500 when you connect to a Web site
description: Describes a problem that occurs if the user tries to connect to a computer that is running ISA Server 2004 SP2 and that requires Basic, RADIUS, or OWA Forms-Based authentication. A script is available to work around this issue.
ms.date: 12/26/2023
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, v-jomcc, jobarner
ms.custom: sap:legacy-authentication-ntlm, csstroubleshoot
---
# Error code 403 or 500 when you connect to a Web site that is published by using ISA Server 2004 Service Pack 2

This article provides a solution to an error that occurs when try to connect to a Web site that is published by using Microsoft Internet Security and Acceleration (ISA) Server 2004 Service Pack 2 (SP2).

_Applies to:_ &nbsp; Windows Server 2003  
_Original KB number:_ &nbsp; 912122

> [!IMPORTANT]
> This article contains information that shows you how to help lower security settings or how to turn off security features on a computer. You can make these changes to work around a specific problem. Before you make these changes, we recommend that you evaluate the risks that are associated with implementing this workaround in your particular environment. If you implement this workaround, take any appropriate additional steps to help protect your system.

## Symptoms

When you try to connect to a Web site that is published by using Microsoft Internet Security and Acceleration (ISA) Server 2004 Service Pack 2 (SP2), you receive an error message. If the ISA Server Web listener has Basic authentication enabled, you receive the following error message:

> Error Code: 403 Forbidden.  
The page must be viewed over a secure channel (Secure Sockets Layer (SSL)). Contact the server administrator. (12211)

If the ISA Server Web listener has RADIUS authentication or Microsoft Outlook Web Access Forms-Based authentication (Cookie-auth) enabled, you receive the following error message:

> Error Code: 500 Internal Server Error.  
An internal error occurred. (1359)

## Cause

This issue occurs if all the following conditions are true:

- The ISA Server 2004 Web listener has any one of the following authentication methods enabled:
  - Basic
  - RADIUS
  - Outlook Web Access Forms-Based

- The ISA Server 2004 Web listener is configured to listen for HTTP traffic.

- The **Require all users to authenticate** check box is selected for the Web listener or the Web publishing rules apply to a user set other than the default **All users** user set.

- You connect to the published Web site by using HTTP instead of by using HTTPS.

This issue occurs because of a security modification that is included in ISA Server 2004 SP2. When you use HTTP-to-HTTP bridging, ISA Server 2004 SP2 does not enable traffic on the external HTTP port if the Web listener is configured to request one or more of the following kinds of credentials:

- Basic
- RADIUS
- Outlook Web Access Forms-Based

This behavior occurs because these kinds of credentials should be encrypted. These credentials should not be sent in clear text over HTTP.

For ISA Server 2004 versions that are earlier than ISA Server 2004 SP2, you are prompted to enter credentials in clear text. This behavior may cause the credentials to be transmitted over the network in clear text if you have not implemented some other form of network security, such as an external Secure Sockets Layer (SSL) accelerator or an encrypted tunnel. ISA Server does not provide these forms of security.

ISA Server 2004 SP2 prevents you from entering credentials in clear text. When you try to do this, you receive an error message.

## Workaround

> [!WARNING]
> This workaround may make your computer or your network more vulnerable to attack by malicious users or by malicious software such as viruses. We do not recommend this workaround but are providing this information so that you can implement this workaround at your own discretion. Use this workaround at your own risk.

To work around this issue, configure ISA Server 2004 SP2 to behave like earlier versions of ISA Server 2004.

To do this, run the following script on the ISA Server 2004 where you want to change the configuration. The script sets a value that is named **AllowAskBasicAuthOverNonSecureConnection** in a new vendor parameters set under the root of the ISA Server 2004 array.

Microsoft provides programming examples for illustration only, without warranty either expressed or implied. This includes, but is not limited to, the implied warranties of merchantability or fitness for a particular purpose. This article assumes that you are familiar with the programming language that is being demonstrated and with the tools that are used to create and to debug procedures. Microsoft support engineers can help explain the functionality of a particular procedure, but they will not modify these examples to provide added functionality or construct procedures to meet your specific requirements.

```vb
''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
'
' Copyright (c) Microsoft Corporation. All rights reserved.
' THIS CODE IS MADE AVAILABLE AS IS, WITHOUT WARRANTY OF ANY KIND. THE ENTIRE
' RISK OF THE USE OR THE RESULTS FROM THE USE OF THIS CODE REMAINS WITH THE
' USER. USE AND REDISTRIBUTION OF THIS CODE, WITH OR WITHOUT MODIFICATION, IS
' HEREBY PERMITTED.
''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''

''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
' This script adds a new VendorParametersSets under the array root.
' add a new VendorParametersSet and add a value name "AllowAskBasicAuthOverNonSecureConnection" set to 1.
''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''

Sub AddAllowAskBasicAuthOverNonSecureConnection()

    ' Create the root object.
    Dim root  ' The FPCLib.FPC root object
    Set root = CreateObject("FPC.Root")

    ' Declare the other objects that are required.
    Dim array       ' An FPCArray object
    Dim VendorSets  ' An FPCVendorParametersSets collection
    Dim VendorSet   ' An FPCVendorParametersSet object

    ' Get references to the array object
    ' and the network rules collection.
    Set array = root.GetContainingArray
    Set VendorSets = array.VendorParametersSets

    On Error Resume Next
    Set VendorSet = VendorSets.Item( "{143F5698-103B-12D4-FF34-1F34767DEabc}" )

    If Err.Number <> 0 Then
        Err.Clear

        ' Add the item
        Set VendorSet = VendorSets.Add( "{143F5698-103B-12D4-FF34-1F34767DEabc}" )
        CheckError
        WScript.Echo "New VendorSet added... " & VendorSet.Name

    Else
        WScript.Echo "Existing VendorSet found... value- " &  VendorSet.Value("AllowAskBasicAuthOverNonSecureConnection")
    End If

    if VendorSet.Value("AllowAskBasicAuthOverNonSecureConnection") <> 1 Then

        Err.Clear
        VendorSet.Value("AllowAskBasicAuthOverNonSecureConnection") = 1

        If Err.Number <> 0 Then
            CheckError
        Else
            VendorSets.Save false, true
            CheckError

            If Err.Number = 0 Then
                WScript.Echo "Done, saved!"
            End If
        End If
    Else
        WScript.Echo "Done, no change!"
    End If

End Sub

Sub CheckError()

    If Err.Number <> 0 Then
        WScript.Echo "An error occurred: 0x" & Hex(Err.Number) & " " & Err.Description
        Err.Clear
    End If

End Sub

AddAllowAskBasicAuthOverNonSecureConnection
```
