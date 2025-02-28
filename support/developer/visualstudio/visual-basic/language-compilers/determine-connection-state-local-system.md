---
title: Determine the connection state of your local system
description: This article describes how to determine the connection state of your local system and how to initiate or end an Internet connection by using Visual Basic .NET or Visual Basic 2005.
ms.date: 09/24/2020
ms.custom: sap:Language or Compilers\Visual Basic .NET (VB.NET)
ms.topic: how-to
---
# Determine the connection state of your local system and how to initiate or end an Internet connection by using Visual Basic .NET or Visual Basic 2005

This article shows how to determine the connection state of your local system and how to initiate or end an Internet connection by using Visual Basic .NET or Visual Basic 2005.

_Original product version:_ &nbsp; Visual Studio  
_Original KB number:_ &nbsp; 821770

## Summary

This step-by-step article describes how to determine the connected state of your local system by using the `InternetGetConnectedState` function that the Microsoft Windows Internet (WinINet) API provides. This article also describes how to initiate an Internet connection and how to end an Internet connection by using the `InternetDial` `WinINet` API function and by using the `InternetHangUp` `WinINet` API function.

The `WinINet` API is a set of functions that enables applications to interact with Gopher, with File Transfer Protocol (FTP), and with Hypertext Transfer Protocol (HTTP) to access many resources on the Internet. The `InternetGetConnectedState` function returns True or False based on whether a connection exists. After a call to the `InternetGetConnectedState` function, the *lpdwFlags* parameter contains a predefined value that provides more information about the connection. For example, the value that *IpdwFlags* contains may indicate that the connection is a local area network (LAN) connection, a modem connection, or another type of connection. You can infer whether connection exists from the return value of the `InternetGetConnectedState` function.

When the `InternetGetconnectionState` function call returns True, a network connection exists. However, this does not guarantee that you have access to data or that you have access to Web sites across the network.

The `InternetDial` function initiates a connection to the Internet by using a modem. The *lpszConnectoid* parameter specifies the name of the dial-up connection that the `InternetDial` function uses. You can use the `InternetHangUp` `WinINet` API function to instruct the modem to end the connection that the *dwConnection* parameter specifies.

## Step-by-Step Example

1. Start Microsoft Visual Studio .NET or Microsoft Visual Studio 2005.
2. On the **File** menu, point to **New**, and then click **Project**.
3. Under **Project types**, click **Visual Basic Projects**.

    > [!NOTE]
    > In Visual Studio 2005, click **Visual Basic** under **Project Types**.
4. Under **Templates**, click **Windows Application**.

    By default, Form1 is created.
5. Right-click **Form1**, and then click **View Code**.
6. Add the following declaration statements to the **Form1** class:

    ```vbnet
    Private Declare Function InternetGetConnectedState Lib "wininet.dll" (ByRef lpdwFlags As Int32, _
    ByVal dwReserved As Int32) As Boolean
  
    Private Declare Function InternetDial Lib "Wininet.dll" (ByVal hwndParent As IntPtr, _
    ByVal lpszConnectoid As String, ByVal dwFlags As Int32, ByRef lpdwConnection As Int32, _
    ByVal dwReserved As Int32) As Int32
  
    Private Declare Function InternetHangUp Lib "Wininet.dll" _
    (ByVal lpdwConnection As Int32, ByVal dwReserved As Int32) As Int32
  
    Private Enum Flags As Integer
     'Local system uses a LAN to connect to the Internet.
     INTERNET_CONNECTION_LAN = &H2
     'Local system uses a modem to connect to the Internet.
     INTERNET_CONNECTION_MODEM = &H1
     'Local system uses a proxy server to connect to the Internet.
     INTERNET_CONNECTION_PROXY = &H4
     'Local system has RAS installed.
     INTERNET_RAS_INSTALLED = &H10
    End Enum
  
    'Declaration Used For InternetDialUp.
    Private Enum DialUpOptions As Integer
     INTERNET_DIAL_UNATTENDED = &H8000
     INTERNET_DIAL_SHOW_OFFLINE = &H4000
     INTERNET_DIAL_FORCE_PROMPT = &H2000
    End Enum
  
    Private Const ERROR_SUCCESS = &H0
    Private Const ERROR_INVALID_PARAMETER = &H87
  
    Private mlConnection As Int32
    ```

7. On the **View** menu, click **Designer**.
8. Add a **Button** control to Form1.
9. Right-click **Button1**, and then click **Properties**.
10. In the Properties window, modify the **Text** property of the **Button1** control to Detect Connection.
11. Double-click **Detect Connection**, and then add the following code in the **Button1_Click** event handler:

    ```vbnet
    Dim lngFlags As Long
  
    If InternetGetConnectedState(lngFlags, 0) Then
        'connected.
        If lngFlags And Flags.INTERNET_CONNECTION_LAN Then
            'LAN connection.
            MsgBox("LAN connection.")
        ElseIf lngFlags And Flags.INTERNET_CONNECTION_MODEM Then
            'Modem connection.
            MsgBox("Modem connection.")
        ElseIf lngFlags And Flags.INTERNET_CONNECTION_PROXY Then
            'Proxy connection.
            MsgBox("Proxy connection.")
        End If
    Else
        'not connected.
        MsgBox("Not connected.")
    End If
    ```

12. Add another **Button** control to Form1.
13. Right-click **Button2**, and then click **Properties**.
14. In the Properties window, change the **Text** property of the **Button2** control to Dial Up.
15. Double-click **Dial Up**, and then add the following code in the **Button2_Click** event handler:

    ```vbnet
    Dim DResult As Int32
  
    DResult = InternetDial(Me.Handle, "My Connection", DialUpOptions.INTERNET_DIAL_FORCE_PROMPT, mlConnection, 0)
  
    If (DResult = ERROR_SUCCESS) Then
        MessageBox.Show("Dial Up Successful", "Dial-Up Connection")
    Else
        MessageBox.Show("UnSuccessFull Error Code" & DResult, "Dial-Up Connection")
    End If
    ```
  
    > [!NOTE]
    > Replace **My Connection** with the name of the dial-up connection on your computer.

16. Add another **Button** control to Form1.
17. Right-click **Button3**, and then click **Properties**.
18. In the Properties window, modify the **Text** property of the **Button3** control to Hang Up.
19. Double-click **Hang Up**, and then add the following code in the **Button3_Click** event handler:

    ```vbnet
    Dim Result As Int32
  
    If Not (mlConnection = 0) Then
        Result = InternetHangUp(mlConnection, 0&)
        If Result = 0 Then
            MessageBox.Show("Hang up successful", "Hang Up Connection")
        Else
            MessageBox.Show("Hang up NOT successful", "Hang Up Connection")
        End If
    Else
        MessageBox.Show("You must dial a connection first!", "Hang Up Connection")
    End If
    ```

20. On the **File** menu, click **Save All** to save the project.
21. On the **Debug** menu, click **Start** to run the application.

## Verify that tt works

1. Run the application that you created in the [Step-by-Step Example](#step-by-step-example) section of this article.

    Form1 is displayed.
2. Click **Detect Connection**, and then notice the current connected state of your local computer.
3. Click **Dial Up**.

    The dial-up connection dialog box is displayed.
4. Click **Hang Up**.

    The Internet connection that you established in step 3 ends.

## References

For more information, visit to the following Web sites:

- [About WinINet](/windows/win32/wininet/about-wininet)
- [WinINet Functions](/windows/win32/wininet/wininet-functions)
- [InternetGetConnectedState function (winineti.h)](/windows/win32/api/winineti/nf-winineti-internetgetconnectedstate)
- [InternetDial function (winineti.h)](/windows/win32/api/winineti/nf-winineti-internetdial)
- [InternetHangUp function (winineti.h)](/windows/win32/api/winineti/nf-winineti-internethangup)
