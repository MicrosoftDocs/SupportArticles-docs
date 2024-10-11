---
title: Request timed out when using DataAdapter
description: This article provides resolutions for Request Timed Out error that occurs when you use the DataAdapter method or run a query that takes more than 90 seconds to process in an ASP.NET Web application.
ms.date: 04/15/2020
ms.custom: sap:Performance
ms.reviewer: koushikd
---
# Request timed out error when you use the DataAdapter method in an ASP.NET application

This article helps you resolve the problem where an error (Request Timed Out) occurs in an ASP.NET Web application.

_Original product version:_ &nbsp; ASP.NET  
_Original KB number:_ &nbsp; 825739

## Symptoms

When you use the `DataAdapter.Fill` method, or you run a query in an ASP.NET Web application that takes more than 90 seconds to process, you may receive the following error message:

> HttpException (0x80004005): Request timed out.

This error occurs only when you run the Web application in release mode, and the value of the `Debug` attribute in the *web.config* file is set to **false**.

## Cause

By default, the value of the `executionTimeout` attribute is set to 90 seconds in the *Machine.config* file. This error occurs when the processing time exceeds 90 seconds.

## Workaround

To work around this problem, increase the time-out value that is set for the `executionTimeout` attribute in the configuration file.

The `executionTimeout` attribute exists under `<httpRequest>` in the *Machine.config* file. You can change these settings either in the *web.config* file or in the *Machine.config* file. The default value for the time-out is 90 seconds. The `executionTimeout` attribute indicates the maximum number of seconds a request is permitted to run before being shut down by the ASP.NET Web application.

### Method 1: Set the ExecutionTimeout attribute value in the Web.config file

1. Open the *web.config* file in Notepad.
2. Add the `<httpRuntime>` element in the `<system.web>` section as follows:

    ```xml
    <configuration>
        <system.web>
            <httpRuntime executionTimeout="90" maxRequestLength="4096" useFullyQualifiedRedirectUrl="false"
            minFreeThreads="8" minLocalRequestFreeThreads="4" appRequestQueueLimit="100" />
        </system.web>
    </configuration>
    ```

3. Modify the value of the `executionTimeout` attribute to avoid time-out errors.
4. Save the *web.config* file.

### Method 2: Set the ExecutionTimeout attribute value in the Machine.config file

1. Open the *Machine.config* file in Notepad. The *Machine.config* file is located in the `%SystemRoot%\Microsoft.NET\Framework\%VersionNumber%\CONFIG\` directory.
2. In the *Machine.config* file, locate the `<httpRuntime>` element. The *web.config* file is located in the Web Application directory.

    ```xml
    <httpRuntime executionTimeout="90" maxRequestLength="4096" useFullyQualifiedRedirectUrl="false"
    minFreeThreads="8" minLocalRequestFreeThreads="4" appRequestQueueLimit="100" />
    ```

3. Modify the value of the `executionTimeout` attribute to avoid time-out errors.
4. Save the *Machine.config* file.

## Status

This behavior is by design.

## Steps to reproduce the behavior

1. Start Microsoft Visual Studio .NET.
2. On the **File** menu, point to **New**, and then select **Project**.
3. Select **Visual Basic Projects** under **Project Types**, and then select **ASP.NET Web Application** under **Templates**. By default, `WebForm1.aspx` is created.
4. In Design view, right-click **WebForm1**, and then select **View Code**.
5. To add the database connection and the `DataAdapter` method to fill the dataset, replace the existing code with the following code:

    ```vb
    Imports System.Data.SqlClient
    Public Class WebForm1
       Inherits System.Web.UI.Page

       Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
          Try
             Dim sConnectionString As String
             sConnectionString = "server=servername;uid=sa;pwd=password;database=testdatabase;"
             Dim objConn As SqlConnection
             objConn = New SqlConnection(sConnectionString)
             objConn.Open()

             Dim daAuthors As SqlDataAdapter

             'Increase the no.of records from existing value, if execution time is less than 90 sec.
             daAuthors = New SqlDataAdapter("Select top 60000 * From timelog (nolock)", objConn)
             Dim myDs As DataSet
             myDs = New DataSet("testTimelog")
             Dim dt As DateTime
             dt = New DateTime()
             dt = dt.Now
             Response.Write("StartTime of DataAdapter fill - " + dt)
             daAuthors.Fill(myDs, "testTimelog")

             dt = New DateTime()
             dt = dt.Now
             Response.Write("<br>EndTime of DataAdapter fill - " + dt)
             Response.Write("<br>No of Rows = " + myDs.Tables(0).Rows.Count.ToString())

          Catch ex As Exception
             Response.Write(ex.ToString())
          End Try
       End Sub
    End Class
    ```

6. Open the *web.config* file in Notepad, and then set the value for the `Debug` attribute to **false** as follows:

    ```xml
    <configuration>
        <system.web>
            <compilation defaultLanguage="vb" debug="false" />
        </system.web>
    </configuration>
    ```

7. Set the application to build in release mode. To do this, follow these steps:

    1. In Solution Explorer, right-click your project.
    2. Select **Properties**, and then select **Configuration Manager**.
    3. Select **Release** under **Active Solution Configuration**, and then select **Close**.
    4. Select **OK**.

8. On the **Debug** menu, select **Start** to build and run the project. You may receive the error message that the [Symptoms](#symptoms) section describes.

> [!NOTE]
> The default value for the time-out as set in the *Machine.config* file is 90 seconds. If the process time is less than 90 seconds, increase the processing time by increasing the number of records to be fetched.

## References

- [Populating a DataSet from a DataAdapter](/previous-versions/dotnet/netframework-1.1/bh8kx08z(v=vs.71))

- [\<httpRuntime> Element](/previous-versions/dotnet/netframework-1.1/e1f13641(v=vs.71))
