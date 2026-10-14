---
title: Troubleshoot an app in Azure App Service using Visual Studio
description: Troubleshoot an Azure App Service app with Visual Studio remote debugging, tracing, and logging tools. Follow this tutorial to diagnose app issues.
ms.assetid: def8e481-7803-4371-aa55-64025d116c97
author: kaushika-msft
ms.author: kaushika
ms.reviewer: kaushika
manager: dcscontentpm
ms.topic: troubleshooting
ms.service: azure-app-service
ms.date: 08/21/2026
ms.custom: sap:Availability, Performance, and Application Issues, devx-track-csharp, devx-track-dotnet, sfi-image-nochange
# Customer intent: As a developer, I want to get an overview of Visual Studio tools for debugging apps in App Service so that I can more effectively debug my apps. 

---
# Troubleshoot an app in Azure App Service using Visual Studio

> [!NOTE]
> This article is for Visual Studio 2019. For troubleshooting in Visual Studio 2022, see [Remote Debug ASP.NET Core on Azure App Service.](/visualstudio/debugger/remote-debugging-azure-app-service)
>

## Summary

This tutorial explains how to troubleshoot an [Azure App Service](/azure/app-service/overview) app by using Visual Studio remote debugging, application tracing, and diagnostic logs. Use these tools to identify errors that you can't reproduce locally.

In this tutorial, you learn about the following tasks:

- Which app management functions are available in Visual Studio.
- How to use Visual Studio remote view to make quick changes in a remote app.
- How to run debug mode remotely while a project is running in Azure, both for an app and for a WebJob.
- How to create application trace logs and view them while the application is creating them.
- How to view web server logs, including detailed error messages and failed request tracing.
- How to send diagnostic logs to an Azure Storage account and view them there.

If you have Visual Studio Ultimate, you can also use [IntelliTrace](/visualstudio/debugger/intellitrace) for debugging. IntelliTrace isn't covered in this tutorial.

## Prerequisites

Make sure you meet the following prerequisites before you start this tutorial:

- This tutorial works with the development environment, web project, and App Service app that you set up in [Create an ASP.NET app in Azure App Service](/azure/app-service/quickstart-dotnetcore?tabs=netframework48). For the Azure WebJobs sections, you need the application that you create in [Get Started with the Azure WebJobs SDK](https://github.com/Azure/azure-webjobs-sdk/wiki).
- The code samples shown in this tutorial are for a C# MVC web application, but the troubleshooting procedures are the same for Visual Basic and Web Forms applications.
- The tutorial assumes you're using Visual Studio 2019. 
- The streaming logs feature only works for applications that target .NET Framework 4 or later.

## Configure and manage apps

Visual Studio provides access to a subset of the app management functions and configuration settings available in the [Azure portal](https://portal.azure.com). In this section, you see what's available by using **Server Explorer**. To see the latest Azure integration features, try **Cloud Explorer**. You can open both windows from the **View** menu.

1. If you aren't already signed in to Azure in Visual Studio, right-click **Azure** and select **Connect to Microsoft Azure Subscription** in **Server Explorer**.

You can also install a management certificate that enables access to your account. If you choose to install a certificate, right-click the **Azure** node in **Server Explorer**, and then select **Manage and Filter Subscriptions** in the context menu. In the **Manage Microsoft Azure Subscriptions** dialog box, select the **Certificates** tab, and then select **Import**. Follow the directions to download and then import a subscription file (also called a *.publishsettings* file) for your Azure account.

> [!NOTE]
> If you download a subscription file, save it to a folder outside your source code directories (for example, in the **Downloads** folder), and then delete it once the import finishes. Otherwise, a malicious user who gains access to the subscription file can edit, create, and delete your Azure services.

For more information about connecting to Azure resources from Visual Studio, see [Assign Azure roles using the Azure portal](/azure/role-based-access-control/role-assignments-portal).

2. In **Server Explorer**, expand **Azure** and expand **App Service**.
3. Expand the resource group that includes the app that you created in [Create an ASP.NET app in Azure App Service](/azure/app-service/quickstart-dotnetcore?tabs=netframework48), right-click the app node, and then select **View Settings**.

:::image type="content" source="media/web-sites-dotnet-troubleshoot-visual-studio/tws-viewsettings.png" alt-text="Screenshot of multiple settings for Visual Studio." lightbox="media/web-sites-dotnet-troubleshoot-visual-studio/tws-viewsettings.png":::

The **Azure Web App** tab appears. You can now see the app management and configuration tasks that are available in Visual Studio.  

:::image type="content" source="media/web-sites-dotnet-troubleshoot-visual-studio/tws-configtab.png" alt-text="Screenshot of multiple configuration tabs for Visual Studio." lightbox="media/web-sites-dotnet-troubleshoot-visual-studio/tws-configtab.png":::

In this tutorial, you use the logging and tracing options. 

For information about the **App Settings** and **Connection Strings** boxes in this window, see [Configure app settings](/azure/app-service/configure-common#configure-app-settings).  

If you want to perform an app management task that you can't do in this window, select **Open in Management Portal** to open a browser window to the [Azure portal](https://portal.azure.com).  

## Access app files in Server Explorer

You typically deploy a web project with the `customErrors` flag in the *Web.config* file set to `On` or `RemoteOnly`. This setting means you might not get a detailed error message when something goes wrong.

The following examples show these kinds of error messages:

"Server Error in '/' Application"

:::image type="content" source="./media/web-sites-dotnet-troubleshoot-visual-studio/genericerror.png" alt-text="Screenshot showing a Server Error in '/' Application error in a web browser." lightbox="./media/web-sites-dotnet-troubleshoot-visual-studio/genericerror.png":::

"An error occurred"

:::image type="content" source="./media/web-sites-dotnet-troubleshoot-visual-studio/genericerror1.png" alt-text="Screenshot showing an example of a generic error occurring in a web browser." lightbox="./media/web-sites-dotnet-troubleshoot-visual-studio/genericerror1.png":::

"The website cannot display the page"

:::image type="content" source="./media/web-sites-dotnet-troubleshoot-visual-studio/genericerror2.png" alt-text="Screenshot of a browser showing that the website can't display the requested page."lightbox="./media/web-sites-dotnet-troubleshoot-visual-studio/genericerror2.png":::

The easiest way to find the cause of these errors is to enable detailed error messages. To enable detailed error messages, you need to change the deployed Web.config file. You can make this change in three ways:

- Edit the Web.config file in the project and redeploy the project.
- Create a [`Web.config` transform](/aspnet/core/host-and-deploy/iis/transform-webconfig) and deploy a debug build.  
- Use the *remote view* feature in **Solution Explorer**.

### Use remote view to edit the Web.config file

1. In **Server Explorer**, expand **Azure**, expand **App Service**, expand the resource group that your app is located in, and then expand the node for your app. You can see nodes that give you access to the app's content files and log files.
2. Expand the **Files** node, and then double-click the Web.config file.  

:::image type="content" source="./media/web-sites-dotnet-troubleshoot-visual-studio/webconfig.png" alt-text="Screenshot of the remote Web.config file open in Visual Studio." lightbox="./media/web-sites-dotnet-troubleshoot-visual-studio/webconfig.png":::

Visual Studio opens the Web.config file from the remote app and shows **Remote** next to the file name in the title bar.

3. Add the following line to the `system.web` element: `<customErrors mode="Off"></customErrors>`

:::image type="content" source="./media/web-sites-dotnet-troubleshoot-visual-studio/webconfigedit.png" alt-text="Screenshot of the customErrors setting being edited in Web.config." lightbox="./media/web-sites-dotnet-troubleshoot-visual-studio/webconfigedit.png":::

4. Refresh the browser showing the error message. You should now see a detailed error message like the following example:

:::image type="content" source="./media/web-sites-dotnet-troubleshoot-visual-studio/detailederror.png" alt-text="Screenshot of a browser displaying detailed ASP.NET error information." lightbox="./media/web-sites-dotnet-troubleshoot-visual-studio/detailederror.png":::

## Remote debug apps

If a more detailed error message doesn't provide enough information, and you can't recreate the error locally, another way to troubleshoot is to run in *debug mode* remotely. You can then set breakpoints, manipulate memory directly, step through code, and change the code path.

> [!NOTE]
> Remote debugging doesn't work in any versions of Visual Studio Express.

This section shows how to debug remotely by using the project you created in [Create an ASP.NET app in Azure App Service](/azure/app-service/quickstart-dotnetcore?tabs=netframework48).

1. Open the web project that you created in [Create an ASP.NET app in Azure App Service](/azure/app-service/quickstart-dotnetcore?tabs=netframework48).
2. Open `Controllers\HomeController.cs`.
3. Delete the `About()` method and insert the following code in its place.

   ```csharp
   public ActionResult About()
   {
       string currentTime = DateTime.Now.ToLongTimeString();
       ViewBag.Message = "The current time is " + currentTime;
       return View();
   }
   ```

4. [Set a breakpoint](/visualstudio/debugger/) in the `ViewBag.Message` line.
5. In **Solution Explorer**, right-click the project, and then select **Publish**.
6. In the **Profile** list, select the same profile you used for [Create an ASP.NET app in Azure App Service](/azure/app-service/quickstart-dotnetcore?tabs=netframework48), and then select **Settings**.

7. In **Publish**, select the **Settings** tab. 
8. Change **Configuration** to **Debug**, and then select **Save**.
9. Select **Publish**. After deployment finishes and your browser opens to the Azure URL of your app, close the browser.
10. In **Server Explorer**, right-click your app, and then select **Attach Debugger**.

:::image type="content" source="./media/web-sites-dotnet-troubleshoot-visual-studio/tws-attachdebugger.png" alt-text="Screenshot of the Azure App Service menu with Attach Debugger selected." lightbox="./media/web-sites-dotnet-troubleshoot-visual-studio/tws-attachdebugger.png":::

The browser automatically opens to your Azure home page. You might have to wait about 20 seconds for Azure to set up the server for debugging. 

> [!NOTE]  
> If you have any trouble starting the debugger, use **Cloud Explorer** instead of **Server Explorer**.

11. Select **About** in the menu. Visual Studio stops on the breakpoint and the code is running in Azure, but not on your local computer.
12. Hover over the `currentTime` variable to see the time value.

:::image type="content" source="./media/web-sites-dotnet-troubleshoot-visual-studio/tws-debugviewinwa.png" alt-text="Screenshot of viewing a variable in debug mode running in Azure." lightbox="./media/web-sites-dotnet-troubleshoot-visual-studio/tws-debugviewinwa.png":::

The time you see is the Azure server time which might be in a different time zone than your local computer.

13. Enter a new value for the `currentTime` variable, such as "Now running in Azure".
14. Select the F5 key to continue. The **About** page in Azure displays the new value that you entered into the `currentTime` variable.

:::image type="content" source="./media/web-sites-dotnet-troubleshoot-visual-studio/tws-debugchangeinwa.png" alt-text="Second screenshot of viewing a variable in debug mode running in Azure." lightbox="./media/web-sites-dotnet-troubleshoot-visual-studio/tws-debugchangeinwa.png":::

## Remote debug WebJobs

This section shows how to debug remotely by using the project and app you created in [Get Started with the Azure WebJobs SDK](https://github.com/Azure/azure-webjobs-sdk/wiki).

> [!NOTE]
> The features shown in this section are available only in Visual Studio 2013 with Update 4 or later.

> [!NOTE]
> Remote debugging only works with continuous WebJobs. Scheduled and on-demand WebJobs don't support debugging.

1. Open the web project that you created in [Get Started with the Azure WebJobs SDK](https://github.com/Azure/azure-webjobs-sdk/wiki).
2. In the **ContosoAdsWebJob** project, open `Functions.cs`.
3. [Set a breakpoint](/visualstudio/debugger/) on the first statement in the `GenerateThumbnail` method.

:::image type="content" source="./media/web-sites-dotnet-troubleshoot-visual-studio/wjbreakpoint.png" alt-text="Screenshot of a breakpoint set in the GenerateThumbnail method." lightbox="./media/web-sites-dotnet-troubleshoot-visual-studio/wjbreakpoint.png":::

4. In **Solution Explorer**, right-click the web project (not the WebJob project), and then select **Publish**.
5. In the **Profile** list, select the same profile that you used in [Get Started with the Azure WebJobs SDK](https://github.com/Azure/azure-webjobs-sdk/wiki).
6. Select the **Settings** tab, change **Configuration** to **Debug**, and then select **Publish**. Visual Studio deploys the web and WebJob projects, and your browser opens to the Azure URL of your app.
7. In **Server Explorer**, expand **Azure > App Service > your resource group > your app > WebJobs > Continuous**, and then right-click **ContosoAdsWebJob**.
8. Select **Attach Debugger**.

:::image type="content" source="./media/web-sites-dotnet-troubleshoot-visual-studio/wjattach.png" alt-text="Screenshot of Server Explorer showing ContosoAdsWebJob selected in the menu and Attach Debugger selected." lightbox="./media/web-sites-dotnet-troubleshoot-visual-studio/wjattach.png":::

The browser automatically opens to your Azure home page. You might have to wait about 20 seconds for Azure to set up the server for debugging.

9. In the web browser opened to the **Contoso Ads** home page, create a new ad. Creating an ad causes a queue message to be created, which the WebJob picks up and processes. When the WebJobs SDK calls the function to process the queue message, the code hits your breakpoint.
10. When the debugger breaks at the breakpoint, examine and change variable values while the program is running in the cloud. In the following illustration, the debugger shows the contents of the **blobInfo** object that was passed to the `GenerateThumbnail` method.

:::image type="content" source="./media/web-sites-dotnet-troubleshoot-visual-studio/blobinfo.png" alt-text="Screenshot of blobInfo object in debugger." lightbox="./media/web-sites-dotnet-troubleshoot-visual-studio/blobinfo.png":::

11. Select the F5 key to continue. The `GenerateThumbnail` method finishes creating the thumbnail.
12. In the browser, refresh the **Index** page. You now should see the thumbnail.
13. In Visual Studio, select Shift+F5 to stop debugging.
14. In **Server Explorer**, right-click the **ContosoAdsWebJob** node, and then select **View Dashboard**.
15. Sign in with your Azure credentials, and then select the WebJob name.

:::image type="content" source="./media/web-sites-dotnet-troubleshoot-visual-studio/clickcaw.png" alt-text="Screenshot of the ContosoAdsWebJob entry in the WebJobs dashboard." lightbox="./media/web-sites-dotnet-troubleshoot-visual-studio/clickcaw.png":::

The dashboard shows that the `GenerateThumbnail` function recently ran.  

> [!NOTE]
> The next time you select **View Dashboard**, you don't need to sign in. The browser should go directly to the page for your WebJob.

16. Select the function name to see details about the function operation.

:::image type="content" source="./media/web-sites-dotnet-troubleshoot-visual-studio/funcdetails.png" alt-text="Screenshot of WebJob function operation details in the dashboard." lightbox="./media/web-sites-dotnet-troubleshoot-visual-studio/funcdetails.png":::

If your function [wrote logs](https://github.com/Azure/azure-webjobs-sdk/wiki), select **ToggleOutput** to see them.

### Notes about remote debugging

- Don't run in debug mode in production. If your production app isn't scaled out to multiple server instances, debugging prevents the web server from responding to other requests. If you do have multiple web server instances, when you attach to the debugger, you might get a random instance and have no way to ensure that subsequent browser requests go to the same instance. For troubleshooting production problems, use application tracing and web server logs.
- Avoid long stops at breakpoints when remote debugging. Azure treats a process that's stopped for longer than a few minutes as an unresponsive process and then shuts it down.
- While you're debugging, the server sends data to Visual Studio, which can affect bandwidth charges. For information about bandwidth rates, see [Azure Pricing](https://azure.microsoft.com/pricing/calculator/).
- Make sure that the `debug` attribute of the `compilation` element in the Web.config file is set to `true`. This setting is the default when you publish a debug build configuration as shown in the following example:

```xml
    <system.web>
      <compilation debug="true" targetFramework="4.5" />
      <httpRuntime targetFramework="4.5" />
    </system.web>
```

- If the debugger can't find the code that you want to debug, change the **Just My Code** setting. For more information, see [Specify whether to debug only user code using Just My Code in Visual Studio](/visualstudio/debugger/just-my-code).
- A timer starts on the server when you enable the remote debugging feature. After 48 hours the feature is automatically turned off. This 48-hour limit is for security and performance reasons. Keep it disabled when you aren't actively debugging.
- You can manually attach the debugger to any process (not only the app process (*w3wp.exe*)). For more information about how to use debug mode in Visual Studio, see [Debugging in Visual Studio](/visualstudio/debugger/debugging-in-visual-studio).

## Diagnostic logs overview

An ASP.NET application that runs in an App Service app can create the following kinds of logs:

- **Application tracing logs** - The application creates these logs by calling methods of the [System.Diagnostics.Trace](/dotnet/api/system.diagnostics.trace) class.
- **Web server logs** - The web server creates a log entry for every HTTP request to the app.
- **Detailed error message logs** - The web server creates an HTML page with some extra information for failed HTTP requests (requests that result in status code 400 or greater).
- **Failed request tracing logs** - The web server creates an .xml file with detailed tracing information for failed HTTP requests. The web server also provides an .xsl file to format the .xml in a browser.

Logging affects app performance, so Azure gives you the ability to enable or disable each type of log as needed. For application logs, you can specify that only logs above a certain severity level should be written. When you create a new app, all logging is disabled by default.

The app writes logs to files in a **LogFiles** folder in the file system of your app, and you can access them by using FTP. You can also configure the app to write web server logs and application logs to an Azure Storage account. You can retain a greater volume of logs in a storage account than is possible in the file system. You're limited to a maximum of 100 megabytes of logs when you use the file system.

File system logs are only for short-term retention. Azure deletes old log files to make room for new ones after the limit is reached.  

## Create and view application trace logs

In this section, you perform the following tasks:

- Add tracing statements to the web project that you created in [Get started with Azure and ASP.NET](/azure/app-service/quickstart-dotnetcore?tabs=netframework48).
- View the logs when you run the project locally.
- View the logs as they're generated by the application running in Azure.

For information about how to create application logs in WebJobs, see [How to work with Azure queue storage using the WebJobs SDK - How to write logs](https://github.com/Azure/azure-webjobs-sdk/wiki). The following instructions for viewing logs and controlling how they're stored in Azure also apply to application logs created by WebJobs.

### Add tracing statements to the application

1. Open *Controllers\HomeController.cs*, and replace the `Index`, `About`, and `Contact` methods with the following code in order to add `Trace` statements and a `using` statement for `System.Diagnostics` as shown in the following example:

```csharp
    public ActionResult Index()
    {
        Trace.WriteLine("Entering Index method");
        ViewBag.Message = "Modify this template to jump-start your ASP.NET MVC application.";
        Trace.TraceInformation("Displaying the Index page at " + DateTime.Now.ToLongTimeString());
        Trace.WriteLine("Leaving Index method");
        return View();
    }
    
    public ActionResult About()
    {
        Trace.WriteLine("Entering About method");
        ViewBag.Message = "Your app description page.";
        Trace.TraceWarning("Transient error on the About page at " + DateTime.Now.ToShortTimeString());
        Trace.WriteLine("Leaving About method");
        return View();
    }
    
    public ActionResult Contact()
    {
        Trace.WriteLine("Entering Contact method");
        ViewBag.Message = "Your contact page.";
        Trace.TraceError("Fatal error on the Contact page at " + DateTime.Now.ToLongTimeString());
        Trace.WriteLine("Leaving Contact method");
        return View();
    }        
```

2. Add a `using System.Diagnostics;` statement to the top of the file.

### View the tracing output locally

1. Select the F5 key to run the application in debug mode. The default trace listener writes all trace output to the **Output** window, along with other Debug output. The following illustration shows the output from the trace statements that you added to the `Index` method.

:::image type="content" source="./media/web-sites-dotnet-troubleshoot-visual-studio/tws-debugtrace.png" alt-text="Screenshot of application trace messages in the Visual Studio Output window." lightbox="./media/web-sites-dotnet-troubleshoot-visual-studio/tws-debugtrace.png":::

The following steps show how to view trace output in a web page, without compiling in debug mode.

2. Open the application Web.config file (the one located in the project folder) and add a `<system.diagnostics>` element at the end of the file just before the closing `</configuration>` element as shown in the following example:

``` xml
   <system.diagnostics>
   <trace>
     <listeners>
       <add name="WebPageTraceListener"
           type="System.Web.WebPageTraceListener,
           System.Web,
           Version=4.0.0.0,
           Culture=neutral,
           PublicKeyToken=b03f5f7f11d50a3a" />
     </listeners>
   </trace>
   </system.diagnostics>
```

The `WebPageTraceListener` lets you view trace output by browsing to `/trace.axd`.

3. Add a [trace element](/dotnet/framework/configure-apps/file-schema/trace-debug/) under `<system.web>` in the Web.config file as shown in the following example:

``` xml
   <trace enabled="true" writeToDiagnosticsTrace="true" mostRecent="true" pageOutput="false" />
```

4. Select Control (Ctrl)+F5 to run the application.
5. In the address bar of the browser window, add `trace.axd` to the URL, and then select the Enter key (the URL is similar to `http://localhost:53370/trace.axd`).
6. On the **Application Trace** page, select **View Details** on the first line (not the `BrowserLink` line).

:::image type="content" source="./media/web-sites-dotnet-troubleshoot-visual-studio/tws-traceaxd1.png" alt-text="Screenshot of the Application Trace page in a web browser showing View Details selected on the first line." lightbox="./media/web-sites-dotnet-troubleshoot-visual-studio/tws-traceaxd1.png":::

The **Request Details** page appears. In the **Trace Information** section, you should see the output from the trace statements that you added to the `Index` method.

:::image type="content" source="./media/web-sites-dotnet-troubleshoot-visual-studio/tws-traceaxd2.png" alt-text="Screenshot of the Request Details page in a web browser showing a message highlighted in the Trace Information section." lightbox="./media/web-sites-dotnet-troubleshoot-visual-studio/tws-traceaxd2.png":::

By default, `trace.axd` is only available locally. If you want to make it available from a remote app, add `localOnly="false"` to the `trace` element in the Web.config file as shown in the following example:

```xml
   <trace enabled="true" writeToDiagnosticsTrace="true" localOnly="false" mostRecent="true" pageOutput="false" />
```

> [!IMPORTANT]
> Enabling `trace.axd` in a production app isn't recommended for security reasons. 

### View the tracing output in Azure

1. In **Solution Explorer**, right-click the web project, and then select **Publish**.
2. In **Publish Web**, select **Publish**. After Visual Studio publishes your update, it opens a browser window to your home page.
3. In **Server Explorer**, right-click your app, and then select **View Streaming Logs**.

:::image type="content" source="./media/web-sites-dotnet-troubleshoot-visual-studio/tws-viewlogsmenu.png" alt-text="Screenshot of Server Explorer after right-clicking your app, with View Streaming Logs selected in a new window." lightbox="./media/web-sites-dotnet-troubleshoot-visual-studio/tws-viewlogsmenu.png":::

The **Output** window should show that you're connected to the log-streaming service and should add a notification line each minute that goes by without a log to display.

:::image type="content" source="./media/web-sites-dotnet-troubleshoot-visual-studio/tws-nologsyet.png" alt-text="Screenshot of the Output window showing an example of a connection to a log-streaming service with notification lines." lightbox="./media/web-sites-dotnet-troubleshoot-visual-studio/tws-nologsyet.png":::

4. In the browser window that shows your application home page, select **Contact**. Within a few seconds, the output from the error-level trace you added to the `Contact` method should appear in the **Output** window.  

:::image type="content" source="./media/web-sites-dotnet-troubleshoot-visual-studio/tws-errortrace.png" alt-text="Screenshot of error trace in Output window.":::

Visual Studio is only showing error-level traces because that's the default setting when you enable the log monitoring service. When you create a new App Service app, all logging is disabled by default. 

:::image type="content" source="./media/web-sites-dotnet-troubleshoot-visual-studio/tws-apploggingoff.png" alt-text="Screenshot of application logging disabled in Visual Studio." lightbox="./media/web-sites-dotnet-troubleshoot-visual-studio/tws-apploggingoff.png":::

When you selected **View Streaming Logs**, Visual Studio automatically changed **Application Logging (File System)** to **Error**. This means error-level logs now get reported. 

To see all of your tracing logs, change this setting to **Verbose**. When you select a severity level lower than **Error**, all logs for higher severity levels are also reported. This means when you select **Verbose**, you also see **Information**, **Warning**, and **Error** logs.

5. In **Server Explorer**, right-click the app, and then select **View Settings**.
6. Change **Application Logging (File System)** to **Verbose**, and then select **Save**.

:::image type="content" source="./media/web-sites-dotnet-troubleshoot-visual-studio/tws-applogverbose.png" alt-text="Screenshot of setting trace level to Verbose." lightbox="./media/web-sites-dotnet-troubleshoot-visual-studio/tws-applogverbose.png":::

7. In the browser window that now shows your **Contact** page, select **Home** > **About** > **Contact**.  Within a few seconds, the **Output** window should show all of your tracing output.

:::image type="content" source="./media/web-sites-dotnet-troubleshoot-visual-studio/tws-verbosetraces.png" alt-text="Screenshot of verbose application trace output in Visual Studio." lightbox="./media/web-sites-dotnet-troubleshoot-visual-studio/tws-verbosetraces.png":::

### Output window features

The **Microsoft Azure Logs** tab of the **Output** window has several buttons and a text box as shown in the following illustration. 

:::image type="content" source="./media/web-sites-dotnet-troubleshoot-visual-studio/tws-icons.png" alt-text="Screenshot showing the buttons and text box of the Microsoft Azure Logs tab in the Output window." lightbox="./media/web-sites-dotnet-troubleshoot-visual-studio/tws-icons.png":::

These buttons perform the following functions:

- Clear the **Output** window.
- Enable or disable word wrap.
- Start or stop monitoring logs.
- Specify which logs to monitor.
- Download logs.
- Filter logs based on a search string or a regular expression.
- Close the **Output** window.

If you enter a search string or regular expression, Visual Studio filters logging information at the client. You can enter the criteria after the logs appear in the **Output** window. You can change filtering criteria without regenerating the logs.

## View web server logs

Web server logs record all HTTP activity for the app. To see them in the **Output** window, you must enable them for the app and tell Visual Studio that you want to monitor them.

1. In the **Azure Web App Configuration** tab from **Server Explorer**, change **Web Server Logging** to **On**, and then select **Save**.

:::image type="content" source="./media/web-sites-dotnet-troubleshoot-visual-studio/tws-webserverloggingon.png" alt-text="Screenshot of enabling web server logging." lightbox="./media/web-sites-dotnet-troubleshoot-visual-studio/tws-webserverloggingon.png":::

2. In the **Output** window, select **Specify which Microsoft Azure logs to monitor**.  

:::image type="content" source="./media/web-sites-dotnet-troubleshoot-visual-studio/tws-specifylogs.png" alt-text="Screenshot of specifying which Azure logs to monitor.":::

3. In **Microsoft Azure Logging Options**, select **Web server logs**, and then select **OK**.

:::image type="content" source="./media/web-sites-dotnet-troubleshoot-visual-studio/tws-monitorwslogson.png" alt-text="Screenshot of monitoring web server logs." lightbox="./media/web-sites-dotnet-troubleshoot-visual-studio/tws-monitorwslogson.png":::

4. In the browser window that shows the app, select **Home**, then select **About**, and then select **Contact**. The application logs usually appear first, followed by the web server logs. 

> [!NOTE]
> You might have to wait for the logs to appear.  

:::image type="content" source="./media/web-sites-dotnet-troubleshoot-visual-studio/tws-wslogs.png" alt-text="Screenshot of web server logs in Output window." lightbox="./media/web-sites-dotnet-troubleshoot-visual-studio/tws-wslogs.png":::

By default, when you first enable web server logs by using Visual Studio, Azure writes the logs to the file system. As an alternative, you can use the [Azure portal](https://portal.azure.com) to specify that web server logs should be written to a blob container in a storage account.

If you use the portal to enable web server logging to an Azure storage account and then disable logging in Visual Studio, when you re-enable logging in Visual Studio your storage account settings are restored.

## View detailed error message logs

Detailed error logs provide more information about HTTP requests that result in error response codes (400 or above). To see these logs in the **Output** window, you need to enable them for the app and tell Visual Studio that you want to monitor them.

1. In the **Azure Web App Configuration** tab from **Server Explorer**, change **Detailed Error Messages** to **On**, and then select **Save**.

:::image type="content" source="./media/web-sites-dotnet-troubleshoot-visual-studio/tws-detailedlogson.png" alt-text="Screenshot of enabling detailed error messages." lightbox="./media/web-sites-dotnet-troubleshoot-visual-studio/tws-detailedlogson.png":::

2. In the **Output** window, select **Specify which Microsoft Azure logs to monitor**.
3. In **Microsoft Azure Logging Options**, select **All logs**, and then select **OK**.

:::image type="content" source="./media/web-sites-dotnet-troubleshoot-visual-studio/tws-monitorall.png" alt-text="Screenshot of the option to monitor all Microsoft Azure logs." lightbox="./media/web-sites-dotnet-troubleshoot-visual-studio/tws-monitorall.png":::

4. In the address bar of the browser window, add an extra character to the URL to cause a 404 error (for example, `http://localhost:53370/Home/Contactx`), and then select the Enter key. After several seconds, the detailed error log appears in the Visual Studio **Output** window.

:::image type="content" source="./media/web-sites-dotnet-troubleshoot-visual-studio/tws-detailederrorlog.png" alt-text="Screenshot of a detailed error log in an Output window." lightbox="./media/web-sites-dotnet-troubleshoot-visual-studio/tws-detailederrorlog.png":::

5. Select the Control (Ctrl) key and select the link to see the log output formatted in a browser.

:::image type="content" source="./media/web-sites-dotnet-troubleshoot-visual-studio/tws-detailederrorloginbrowser.png" alt-text="Screenshot of a detailed error log in a browser window." lightbox="./media/web-sites-dotnet-troubleshoot-visual-studio/tws-detailederrorloginbrowser.png":::

## Download file system logs

You can download any logs you monitor in the **Output** window as a .zip file.

1. In the **Output** window, select **Download Streaming Logs**.

:::image type="content" source="./media/web-sites-dotnet-troubleshoot-visual-studio/tws-downloadicon.png" alt-text="Screenshot of the Output window showing the Download Streaming Logs button highlighted." lightbox="./media/web-sites-dotnet-troubleshoot-visual-studio/tws-downloadicon.png":::

File Explorer opens to your **Downloads** folder with the downloaded file selected.  

:::image type="content" source="./media/web-sites-dotnet-troubleshoot-visual-studio/tws-downloadedfile.png" alt-text="Screenshot of the Downloads folder in File Explorer with a downloaded file selected." lightbox="./media/web-sites-dotnet-troubleshoot-visual-studio/tws-downloadedfile.png":::

2. Extract the .zip file. You see the following folder structure:

:::image type="content" source="./media/web-sites-dotnet-troubleshoot-visual-studio/tws-logfilefolders.png" alt-text="Screenshot of the .zip file folder structure after the file has been extracted." lightbox="./media/web-sites-dotnet-troubleshoot-visual-studio/tws-logfilefolders.png":::

- Application tracing logs are in .txt files in the `LogFiles\Application` folder.
- Web server logs are in .log files in the `LogFiles\http\RawLogs` folder. Use a tool like [Log Parser](https://www.iis.net/downloads/community/2010/04/log-parser-22) to view and manipulate these files.
- Detailed error message logs are in .html files in the `LogFiles\DetailedErrors` folder.  

> [!NOTE]
> The **deployments** folder is for files created by source control publishing. It's not related to Visual Studio publishing. The **Git** folder is for traces related to source control publishing and the log file streaming service.  

## View storage logs

Application tracing logs can also be sent to an Azure storage account and you can view them in Visual Studio. To do that, create a storage account, enable storage logs in the [Azure portal](https://portal.azure.com), and then view them in the **Logs** tab of the **Azure Web App** window.

You can send logs to any or all of these three destinations:

- The file system.
- The storage account tables.
- The storage account blobs.

You can specify a different severity level for each destination.

Tables make it easy to view details of logs online, and they support streaming. You can query logs in tables and see new logs as they are being created. Blobs make it easy to download logs in files and to analyze them using HDInsight as HDInsight works with blob storage. For more information, see **Hadoop and MapReduce** in [Data Storage Options (Building Real-World Cloud Apps with Azure)](https://www.asp.net/aspnet/overview/developing-apps-with-windows-azure/building-real-world-cloud-apps-with-windows-azure/data-storage-options).

The following steps walk you through setting up information level logs to go to storage account tables. Information level means all logs created by calling `Trace.TraceInformation`, `Trace.TraceWarning`, and `Trace.TraceError` are displayed, but not logs created by calling `Trace.WriteLine`.

Storage accounts offer more storage and longer-lasting retention for logs compared to the file system. Another advantage of sending application tracing logs to storage is that you get additional information you don't get from file system logs.

1. Right-click **Storage** under the Azure node, and then select **Create Storage Account**.

:::image type="content" source="./media/web-sites-dotnet-troubleshoot-visual-studio/createstor.png" alt-text="Screenshot of the Create Storage Account option in Visual Studio." lightbox="./media/web-sites-dotnet-troubleshoot-visual-studio/createstor.png":::

2. In **Create Storage Account**, enter a name for the storage account, and then select **OK**. The name must be unique (no other Azure storage account can have the same name). The URL to access your storage account should be of the form *{name}*.core.windows.net.
3. Set the **Region or Affinity Group** list to the region closest to you. This setting specifies which Azure datacenter hosts your storage account. 
4. Set the **Replication** list to **Locally redundant**. When geo-replication is enabled for a storage account, the stored content is replicated to a secondary datacenter to enable failover to that location in case of a major disaster in the primary location. Geo-replication can incur additional costs. For test and development accounts, you generally don't want to pay for geo-replication. For more information, see [Create an Azure storage account](/azure/storage/common/storage-account-create?tabs=azure-portal). 
5. Click **Create**.

:::image type="content" source="./media/web-sites-dotnet-troubleshoot-visual-studio/newstorage.png" alt-text="Screenshot of a newly created Azure storage account." lightbox="./media/web-sites-dotnet-troubleshoot-visual-studio/newstorage.png":::

6. In the Visual Studio **Azure Web App** window, select the **Logs** tab, and then select **Configure Logging in Management Portal**.

:::image type="content" source="./media/web-sites-dotnet-troubleshoot-visual-studio/tws-configlogging.png" alt-text="Screenshot of the option to configure application logging." lightbox="./media/web-sites-dotnet-troubleshoot-visual-studio/tws-configlogging.png":::

This opens the **Configure** tab in the portal for your web app.
7. In the portal's **Configure** tab, go to the application diagnostics section, and then change **Application Logging (Table Storage)** to **On**.
8. Change **Logging Level** to **Information**.
9. Click **Manage Table Storage**.

:::image type="content" source="./media/web-sites-dotnet-troubleshoot-visual-studio/tws-stgsettingsmgmtportal.png" alt-text="Screenshot of managing table storage UI." lightbox="./media/web-sites-dotnet-troubleshoot-visual-studio/tws-stgsettingsmgmtportal.png":::

In **Manage table storage for application diagnostics**, you can choose your storage account if you have more than one. You can either create a new table or use an existing one.

:::image type="content" source="./media/web-sites-dotnet-troubleshoot-visual-studio/tws-choosestorageacct.png" alt-text="Screenshot of the table storage account selection dialog." lightbox="./media/web-sites-dotnet-troubleshoot-visual-studio/tws-choosestorageacct.png":::

10. In the **Manage table storage for application diagnostics** box, select the check mark to close the box.
11. In the portal's **Configure** tab, select **Save**.
12. In the browser window that displays the application web app, select **Home** > **About** > **Contact**. The logging information produced by browsing these web pages is written to the storage account.
13. In the **Logs** tab of the **Azure Web App** window in Visual Studio, in **Diagnostic Summary**, select **Refresh**.

:::image type="content" source="./media/web-sites-dotnet-troubleshoot-visual-studio/tws-refreshstorage.png" alt-text="Screenshot of Refresh." lightbox="./media/web-sites-dotnet-troubleshoot-visual-studio/tws-refreshstorage.png":::

The **Diagnostic Summary** section shows logs for the last 15 minutes by default. You can change the period to see more logs.

> [!NOTE]
> If you get a **table not found** error, verify that you browsed to the pages that do the tracing after you enabled **Application Logging (Storage)** and after you selected **Save**.

:::image type="content" source="./media/web-sites-dotnet-troubleshoot-visual-studio/tws-storagelogs.png" alt-text="Screenshot of application logs stored in an Azure storage account." lightbox="./media/web-sites-dotnet-troubleshoot-visual-studio/tws-storagelogs.png":::

In this view you should see **Process ID** and **Thread ID** for each log. You can see additional fields by viewing the Azure storage table directly.

14. Select **View all application logs**. The trace log table appears in the Azure storage table viewer.

> [!NOTE]
> If you get a **sequence contains no elements** error, open **Server Explorer**, expand the node for your storage account in the **Azure** node, right-click **Tables**, and then select **Refresh**.

:::image type="content" source="./media/web-sites-dotnet-troubleshoot-visual-studio/tws-tracelogtableview.png" alt-text="Screenshot of storage logs in table view." lightbox="./media/web-sites-dotnet-troubleshoot-visual-studio/tws-tracelogtableview.png":::

This view enables you to filter logs by using the Query Builder UI to construct a query. For more information, see **Working with Table Resources - Filtering Entities** in [Browsing Storage Resources with Server Explorer](https://msdn.microsoft.com/library/ff683677.aspx).

15. To view the details for a single row, double-click one of the rows.

:::image type="content" source="./media/web-sites-dotnet-troubleshoot-visual-studio/tws-tracetablerow.png" alt-text="Screenshot of a trace table in Server Explorer." lightbox="./media/web-sites-dotnet-troubleshoot-visual-studio/tws-tracetablerow.png":::

## View failed request tracing logs

Failed request tracing logs are useful when you need to understand the details of how Internet Information Services (IIS) handles an HTTP request. These logs help you troubleshoot scenarios like URL rewriting or authentication problems.

App Service apps use the same failed request tracing functionality that's available with IIS 7.0 and later. However, you don't have access to the IIS settings that configure which errors get logged. When you enable failed request tracing, the app captures all errors.

You can enable failed request tracing by using Visual Studio, but you can't view the logs in Visual Studio. These logs are .xml files. The streaming log service only monitors files that are readable in plain text mode. These file types include:  

- .txt 
- .html 
- .log

You can view failed request tracing logs in a browser by using FTP or locally after using an FTP tool to download them to your local computer. In this section, you set up the app to view the logs in a browser.

### View failed request tracing logs in a browser

1. In the **Configuration** tab of the **Azure Web App** window that you opened from **Server Explorer**, change **Failed Request Tracing** to **On**, and then select **Save**.

:::image type="content" source="./media/web-sites-dotnet-troubleshoot-visual-studio/tws-failedrequeston.png" alt-text="Screenshot of enabling failed request tracing." lightbox="./media/web-sites-dotnet-troubleshoot-visual-studio/tws-failedrequeston.png":::

2. In the address bar of the browser window that shows the app, add an extra character to the URL, and then select the Enter key. This action causes a 404 error and creates a failed request tracing log.

The following steps show how to view or download the log.

3. In Visual Studio, in the **Configuration** tab of the **Azure Web App** window, select **Open in Management Portal**.  
4. In the [Azure portal](https://portal.azure.com) **Settings** page for your app, select **Deployment credentials**, and then enter a new user name and password.  

:::image type="content" source="./media/web-sites-dotnet-troubleshoot-visual-studio/tws-enterftpcredentials.png" alt-text="Screenshot of new FTP user name and password." lightbox="./media/web-sites-dotnet-troubleshoot-visual-studio/tws-enterftpcredentials.png":::

> [!NOTE]  
> When you sign in, use the full user name with the app name prefixed to it. For example, if you enter "myid" as a user name and the site is "myexample", you sign in as "myexample\myid".

5. In a new browser window, in the **Overview** page for your app, go to the URL that's shown associated with **FTP hostname** or **FTPS hostname**.
6. Sign in by using the FTP credentials that you created earlier (including the app name prefix for the user name). The browser should show the root folder of the app.  
7. Open the **LogFiles** folder.

:::image type="content" source="./media/web-sites-dotnet-troubleshoot-visual-studio/tws-logfilesfolder.png" alt-text="Screenshot of opening the LogFiles folder." lightbox="./media/web-sites-dotnet-troubleshoot-visual-studio/tws-logfilesfolder.png":::

8. Select the folder named **W3SVC** plus a numeric value as shown in the following illustration.

:::image type="content" source="./media/web-sites-dotnet-troubleshoot-visual-studio/tws-w3svcfolder.png" alt-text="Screenshot of opening the W3SVC folder." lightbox="./media/web-sites-dotnet-troubleshoot-visual-studio/tws-w3svcfolder.png":::

The folder contains .xml files for any errors that were logged after you enabled failed request tracing, and an .xsl file that a browser can use to format the .xml files.

:::image type="content" source="./media/web-sites-dotnet-troubleshoot-visual-studio/tws-w3svcfoldercontents.png" alt-text="Screenshot of XML and XSL files in the W3SVC folder." lightbox="./media/web-sites-dotnet-troubleshoot-visual-studio/tws-w3svcfoldercontents.png":::

9. Select the .xml file for the failed request.

The following illustration shows part of the tracing information for a sample error.  

:::image type="content" source="./media/web-sites-dotnet-troubleshoot-visual-studio/tws-failedrequestinbrowser.png" alt-text="Screenshot of failed request tracing in a browser." lightbox="./media/web-sites-dotnet-troubleshoot-visual-studio/tws-failedrequestinbrowser.png":::

## Related content
 
The following sections provide further resources on related topics.

- [App Service troubleshooting](#app-service-troubleshooting)
- [Debugging in Visual Studio](#debugging-in-visual-studio)
- [Remote debugging in Azure](#remote-debugging-in-azure)
- [Tracing in ASP.NET applications](#tracing-in-aspnet-applications)
- [Analyzing web server logs](#analyzing-web-server-logs)
- [Analyzing failed request tracing logs](#analyzing-failed-request-tracing-logs)

### App Service troubleshooting

For more information about troubleshooting apps in App Service, see the following resources:  

- [How to monitor apps](/azure/app-service/web-sites-monitor)
- [Investigating Memory Leaks in Azure App Service with Visual Studio 2013](https://devblogs.microsoft.com/devops/investigating-memory-leaks-in-azure-web-sites-with-visual-studio-2013/)
- [Azure App Service online tools you should know about](https://azure.microsoft.com/blog/windows-azure-websites-online-tools-you-should-know-about)

### Debugging in Visual Studio

For more information about how to use debug mode in Visual Studio, see [Debugging in Visual Studio](/visualstudio/debugger/debugging-in-visual-studio).

### Remote debugging in Azure

For more information about remote debugging for App Service apps and WebJobs, see the following resources:

- [Introduction to Remote Debugging Azure App Service](https://azure.microsoft.com/blog/introduction-to-remote-debugging-on-azure-web-sites/)
- [Introduction to Remote Debugging Azure App Service part 2 - Inside Remote debugging](https://azure.microsoft.com/blog/introduction-to-remote-debugging-on-azure-web-sites/)
- [Introduction to Remote Debugging on Azure App Service part 3 - Multi-Instance environment and GIT](https://azure.microsoft.com/blog/introduction-to-remote-debugging-on-azure-web-sites/)
- [WebJobs Debugging (video)](https://www.youtube.com/watch?v=ncQm9q5ZFZs&list=UU_SjTh-ZltPmTYzAybypB-g&index=1)

### Tracing in ASP.NET applications

For more information about tracing in ASP.NET applications, see the following resources:

- [Monitoring and Telemetry (Building Real-World Cloud Apps with Azure)](https://www.asp.net/aspnet/overview/developing-apps-with-windows-azure/building-real-world-cloud-apps-with-windows-azure/monitoring-and-telemetry) 
- [ASP.NET Tracing](/shows/on-dotnet/aspnet-core-series-tracing)  
- [Trace Listeners](/dotnet/framework/debug-trace-profile/trace-listeners)
- [WebPageTraceListener](/dotnet/api/system.web.webpagetracelistener)
- [Distributed tracing in System.Net libraries](/dotnet/fundamentals/networking/telemetry/tracing)  
- [Tracing in ASP.NET MVC Razor Views](https://devblogs.microsoft.com/aspnet/tracing-in-asp-net-mvc-razor-views/)  
- [Handle errors in ASP.NET Core](/aspnet/core/fundamentals/error-handling)
- [Streaming Diagnostics Trace Logging from the Azure Command Line](https://www.hanselman.com/blog/StreamingDiagnosticsTraceLoggingFromTheAzureCommandLinePlusGlimpse.aspx) 
- [Glimpse](https://www.hanselman.com/blog/IfYoureNotUsingGlimpseWithASPNETForDebuggingAndProfilingYoureMissingOut.aspx).
- [Scott Hanselman's blog posts about ELMAH](https://www.hanselman.com/blog/NuGetPackageOfTheWeek7ELMAHErrorLoggingModulesAndHandlersWithSQLServerCompact.aspx)

### Analyzing web server logs

For more information about analyzing web server logs, see the following resources:

- [LogParser](https://www.iis.net/downloads/community/2010/04/log-parser-22)  
- [Troubleshooting IIS Performance Issues or Application Errors using LogParser](https://www.iis.net/learn/troubleshoot/performance-issues/troubleshooting-iis-performance-issues-or-application-errors-using-logparser)  
- [Blog posts by Robert McMurray on using LogParser](/archive/blogs/robert_mcmurray/using-logparser-with-ftp-7-x-sessions)  
- [The HTTP status code in IIS 7.0, IIS 7.5, and IIS 8.0](https://support.microsoft.com/kb/943891)

### Analyzing failed request tracing logs

For more information about analyzing failed request tracing logs, see the following resources:

- [Using Failed Request Tracing](https://www.iis.net/learn/troubleshoot/using-failed-request-tracing)
- [GetStarted]: quickstart-dotnetcore.md
- [GetStartedWJ]: https://github.com/Azure/azure-webjobs-sdk/wiki

[!INCLUDE [Third-party contact disclaimer](~/includes/third-party-contact-disclaimer.md)]
