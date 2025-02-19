---
title: Build cascading drop-down list in ASP.NET
description: This article describes that how to build a cascading drop-down list by using the standard DropDownList control in ASP.NET together with the ASP.NET AJAX framework.
ms.date: 04/09/2020
ms.custom: sap:General Development
ms.reviewer: v-zhiqni
ms.topic: how-to
---
# Steps to create a cascading drop-down list by using the Microsoft ASP.NET AJAX framework

This article shows how to build a cascading drop-down list by using the ASP.NET AJAX framework.

_Original product version:_ &nbsp; .NET Framework 3.5  
_Original KB number:_ &nbsp; 976156

## Introduction

> [!NOTE]
> You must have the .NET Framework 3.5 installed to use the ASP.NET AJAX features. If you want to incorporate ASP.NET AJAX features in the .NET Framework 2.0, you must have ASP.NET 2.0 AJAX Extensions 1.0 installed.

A cascading drop-down list is a series of dependent `DropDownList` controls in which one `DropDownList` control depends on the parent or previous `DropDownList` controls. The items in the `DropDownList` control are populated based on an item that is selected by the user from another `DropDownList` control. When the selection of a parent `DropDownList` control changes, the web page calls the AJAX Web service to retrieve the list of values for the child `DropDownList` control. The ASP.NET AJAX framework enables you to call Web services (.asmx files) from the browser by using client scripts. So when you call the Web service in the client-side `onchange` event of the parent `DropDownList` control, the Web page will be only partly refreshed to populate the items for the child `DropDownList` control.

> [!NOTE]
> The ASP.NET AJAX Control Toolkit provides a `CascadingDropDown` control as an ASP.NET AJAX extender. You can use the `CascadingDropDown` control to create a cascading drop-down list. This article discusses how to use the standard `DropDownList` control in ASP.NET together with the ASP.NET AJAX framework to achieve the cascading drop-down function.

## Steps to create a cascading drop-down list

1. Create an ASP.NET Web Service application in Visual Studio.

    > [!NOTE]
    > In the sample code that is provided, the project name of the C# sample project is *KB_CascadingDDL_CS*. The project name of the Visual Basic .NET sample project is *KB_CascadingDDL_VB*.

2. Add an AJAX Web Form to the project.

    > [!NOTE]
    > In the sample code, the file name of the Web form is *Default.aspx*. The AJAX Web service name is *WebService*.

3. Open the *WebServiceName.asmx* file for the AJAX Web service, and then remove the comment mark for the class declaration as follows.

    Visual Basic

    ```vb
    <System.Web.Script.Services.ScriptService()>
    Public Class WebService
    ```

    Visual C#

    ```csharp
    [System.Web.Script.Services.ScriptService]
    public class WebService : System.Web.Services.WebService
    ```

    > [!NOTE]
    > This step enables the AJAX Web service to be accessed from the client-side scripts. An AJAX Web service class must have the `ScriptServiceAttribute` attribute applied, and the individual methods that will be called from client-side scripts must have the `WebMethodAttribute` attribute applied.

4. Open the *WebFormName.aspx* file of the Web form, and then change the \<asp:ScriptManager> tag as follows:

    ```aspx
    <asp:ScriptManager ID="ScriptManager1" runat="server">
        <Services>
            <asp:ServiceReference Path="~/WebServiceName.asmx" />
        </Services>
    </asp:ScriptManager>
    ```

    To enable an AJAX Web service to be called from the client-side scripts in an ASP.NET Web form, you must first add a `ScriptManager` control to the Web page. Then, reference the Web service by adding an `<asp:ServiceReference>` child element to the `<asp:ScriptManager>` tag. In the `<asp:ScriptManager>` tag, set the `Path` attribute to point to the Web service file.

    The `ServiceReference` object instructs ASP.NET 2.0 AJAX extensions to generate a JavaScript proxy class for calling the specified Web service from the client-side scripts in the Web page. The proxy class has methods that correspond to each Web Service method in the AJAX Web service. The Web page also contains JavaScript proxy classes that correspond to server data types that are used as input parameters or return values for the Web Service methods. These proxy classes enable you to write client-side scripts that initialize these parameters and pass them to the Web Service method call.

5. Set the `EnableEventValidation` property of the Web page to **false** in the source code of the *WebFormName.aspx* file, as shown in the following example.

    ```aspx
    <%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Default.aspx.vb" Inherits="KB_CascadingDDL_VB._Default"
     EnableEventValidation="false" %>
    ```

    > [!NOTE]
    > This step is to avoid invalid postback when you use Web Service method calls.

6. Add the following code under the \<asp:ScriptManager> tag to generate the required ASP.NET controls.

    ```html
    <table>
        <tr>
            <td>
                Make:
            </td>
            <td>
                <asp:DropDownList ID="ddlMake" Width="200" runat="server" AutoPostBack="false" onchange="ddl_changed(this)" />
            </td>
        </tr>
        <tr>
            <td>
                Model:
            </td>
            <td>
                <asp:DropDownList ID="ddlModel" Width="200" runat="server" AutoPostBack="false" onchange="ddl_changed(this)" />
            </td>
        </tr>
        <tr>
            <td>
                Color:
            </td>
            <td>
                <asp:DropDownList ID="ddlColor" Width="200" runat="server" AutoPostBack="false" onchange="DisplayResult()" />
            </td>
        </tr>
        <tr>
            <td>
                <asp:Button ID="btnReset" runat="server" Text="Reset" />
            </td>
        </tr>
    </table>
    <a id="aResult" />
    ```

7. Create Web Service methods for the AJAX Web service. Copy and paste the following code into the *WebServiceName.asmx* file.

    Visual Basic

    ```vb
    Imports System.Web.Services
    Imports System.Web.Services.Protocols
    Imports System.ComponentModel

    ' To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line.
    <System.Web.Script.Services.ScriptService()> _
    <System.Web.Services.WebService(Namespace:="http://tempuri.org/")> _
    <System.Web.Services.WebServiceBinding(ConformsTo:=WsiProfiles.BasicProfile1_1)> _
    <ToolboxItem(False)> _
    Public Class WebService
        Inherits System.Web.Services.WebService

        <WebMethod()> _
        Public Function GetMakeValue() As String()
            Return New String() {"Please select", "Ford", "Dodge"}
        End Function

        <WebMethod()> _
        Public Function GetChildValue(ByVal parentID As String, ByVal parentValue As String) As String()
            If parentValue = "Please select" Then
                Return Nothing
            End If

            Dim values As String()
            If parentID = "ddlMake" Then
                If parentValue = "Ford" Then
                    values = New String() {"Please select", "Explorer", "F150", "Mustang"}
                ElseIf parentValue = "Dodge" Then
                    values = New String() {"Please select", "Durango", "Dakota", "Viper"}
                Else
                    Return New String() {"Invalid Make value!"}
                End If
            ElseIf parentID = "ddlModel" Then
                Select Case parentValue
                    Case "Explorer", "Dakota", "Viper"
                        values = New String() {"Please select", "Black", "Green", "Yellow"}
                    Case "Durango", "F150", "Mustang"
                        values = New String() {"Please select", "White", "Red", "Blue"}
                    Case Else
                        values = New String() {"Invalid Model value!"}
                End Select
            Else
                Return New String() {"Invalid Category value!"}
            End If
            Return values
        End Function
    End Class
    ```

    Visual C#

    ```csharp
    using System;
    using System.Collections.Generic;
    using System.Linq;
    using System.Web;
    using System.Web.Services;

    namespace KB_CascadingDDL_CS
    {
        /// <summary>
        /// Summary description for WebService
        /// </summary>
        [WebService(Namespace = "http://tempuri.org/")]
        [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
        [System.ComponentModel.ToolboxItem(false)]
        // To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line.
        [System.Web.Script.Services.ScriptService]
        public class WebService : System.Web.Services.WebService
        {
            [WebMethod()]
            public string[] GetMakeValue()
            {
                return new string[] { "Please select", "Ford", "Dodge" };
            }

            [WebMethod()]
            public string[] GetChildValue(string parentID, string parentValue)
            {
                if (parentValue == "Please select")
                {
                    return null;
                }

                string[] values;
                if (parentID == "ddlMake")
                {
                    if (parentValue == "Ford")
                    {
                        values = new string[] { "Please select", "Explorer", "F150", "Mustang" };
                    }
                    else if (parentValue == "Dodge")
                    {
                        values = new string[] { "Please select", "Durango", "Dakota", "Viper" };
                    }
                    else
                    {
                        return new string[] { "Invalid Make value!" };
                    }
                }
                else if (parentID == "ddlModel")
                {
                    switch (parentValue)
                    {
                        case "Explorer":
                        case "Dakota":
                        case "Viper":
                            values = new string[] { "Please select", "Black", "Green", "Yellow" };
                            break;
                        case "Durango":
                        case "F150":
                        case "Mustang":
                            values = new string[] { "Please select", "White", "Red", "Blue" };
                            break;
                        default:
                            values = new string[] { "Invalid Model value!" };
                            break;
                    }
                }
                else
                {
                    return new string[] { "Invalid Category value!" };
                }
                return values;
            }
        }
    }
    ```

8. Call the Web Service methods for the AJAX Web service from client-side scripts. Copy and paste the following code under the code that you added in step 6.

    ```csharp
    <script type="text/javascript">
        function pageLoad()
        {
            // call a Web service method with no parameters and the user context.
            KB_CascadingDDL_VB.WebService.GetMakeValue(SucceededCallbackWithContext, FailedCallback, "fillMake");
        }

        // Event handler for ddlMake and ddlModel.
        // This function calls a Web service method
        // passing simple type parameters and the user context.
        function ddl_changed(sender)
        {
            // This initiates the call to the server-side method in your code-behind
            // The parameters are as follows:
            // 1st : Specify all the parameters expected by your code-behind method
            //      (in this case there are 2: parentControl's ID, parentControl's selected text)
            // 2nd : Specify a callback method when the call succeeds
            // 3rd : Specify a callback method when the call fails(optional)
            // 4th : Specify a user context object (option - not shown)
            //      (in this case we need to assign the parentControl's ID as the user context)
            KB_CascadingDDL_VB.WebService.GetChildValue(sender.id, sender[sender.selectedIndex].text,
            SucceededCallbackWithContext, FailedCallback, sender.id);
        }

        // This is the callback function called if the
        // Web service succeeded. It accepts the result
        // object, the user context, and the method name as
        // parameters.
        function SucceededCallbackWithContext(result, userContext) {

            if (userContext == "fillMake") {
                //fill the Make
                var ddl = $get('ddlMake');
            } else if (userContext == "ddlMake") {
                // fill the Model
                var ddl = $get('ddlModel');
                $get('ddlColor').options.length = 0;
            } else if (userContext == "ddlModel") {
                // fill the Color
                var ddl = $get('ddlColor');
            }
            // clear the options
            ddl.options.length = 0;
            if (result)
            {
                var i = 0;
                for (var item in result)
                {
                    // item is the key, result[item] is the value
                    ddl.options.add(new Option(result[item], item));
                    i++;
                }
            } else {
                alert("Invalid! Please reset the selection!");
                $get(userContext).focus();
            }
        }

        // This is the callback function called if the
        // Web service failed. It accepts the error object
        // as a parameter.
        function FailedCallback(error)
        {
            if (error)
            {
                alert(error.get_message());
            }
            else
                alert("An unexpeceted error occurred");
        }

        //This the function to show the three DropDownLists'selection
        function DisplayResult()
        {
            $get("aResult").innerHTML = "You have selected a " +
            $get("ddlMake")[$get("ddlMake").selectedIndex].text + "," +
            $get("ddlModel")[$get("ddlModel").selectedIndex].text + "," +
            $get("ddlColor")[$get("ddlColor").selectedIndex].text + " car!";
        }
    </script>
    ```

    Calling a Web service method from a script is asynchronous. To obtain a return value or to determine when the request has returned, you must provide a succeeded callback function. The callback function is invoked when the request has finished successfully, and it contains the return value from the Web Service Method call. You can also provide a failed callback function to handle errors. Additionally, you can pass user context information to use in the callback functions.

    You can call a Web Service method in an AJAX Web service in the following format:

    ```csharp
    theServiceNameSpace.WebServiceName.ServiceMethodName(parameters, SucceededCallbackFunctionName, FailedCallbackFunctionName, userContextString);
    ```

    You can provide a single succeeded callback function that is invoked from multiple Web service method calls. To enable the function to differentiate different callers, you can pass the user context information to the function in the parameter.

9. Build the project.

## References

[ASP.NET Ajax : Enhanced Interactivity and Responsiveness](/aspnet/ajax/)
