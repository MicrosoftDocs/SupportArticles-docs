---
title: Troubleshoot PHP errors with Failed Request Tracing
description: Describes how to troubleshoot PHP errors with Failed Request Tracing
ms.date: 04/17/2025
ms.author: haiyingyu
author: HaiyingYu
ms.reviewer: johnhart, riande
ms.custom: sap:Health, Diagnostic, and Performance Features\Failed Request Tracing
---
# Troubleshoot PHP errors with Failed Request Tracing

_Applies to:_ &nbsp; Internet Information Services

When running PHP, sometimes it's not possible to inspect an error page to diagnose an error condition. This can happen if:

- You don't know which URL is experiencing an error.
- The error happens intermittently, and you aren't able to manually reproduce it (the error may depend on user input or external operating conditions that may happen infrequently).
- The error only happens in the production environment.

In these cases, it's hard to define what the error is, and even harder to diagnose it. You may be able to determine which URLs are causing the errors by inspecting the request logs or an error log, but you may still have trouble determining what caused the error to happen.

Internet Information Services (IIS) makes it easier to track down and diagnose these difficult error conditions with Failed Request Tracing, which lets you create failure definitions that automatically capture detailed execution traces of certain requests. See [Troubleshoot Failed Requests using tracing in IIS](troubleshoot-failed-requests-using-tracing-in-iis-85.md) and [Use Failed Request Tracing to trace rewrite rules](/iis/extensions/url-rewrite-module/using-failed-request-tracing-to-trace-rewrite-rules).

To help with PHP diagnostics, these traces can also be made to capture the request input data and the response data from PHP. This can provide the insight needed to diagnose these error conditions.

Another fairly common application problem is code that hangs or enters into a resource-intensive loop. This can often happen because:

- A blocking I/O operation on a file or network takes a long time to complete, such as when accessing a remote Web service or database.
- The code has a bug that causes it to enter into an endless (or long-running) loop, possibly also spinning the CPU or allocating memory.
- The code hangs or deadlocks on a shared resource or lock.

These conditions result in long wait times or timeouts for the user making the request, and the conditions can also negatively impact the performance of the application and even the server as a whole.

IIS provides a quick way to determine which requests are hanging by inspecting the currently executing requests.

## Use Failed Request Tracing to diagnose unknown or hard-to-reproduce errors

Failed Request Tracing can be an effective way of tracking down intermittent or hard to reproduce error conditions and diagnosing the error conditions by inspecting details about the request, response, and the wealth of trace events from IIS modules.

Failed Request Tracing can be used in a production environment since it can be configured to only trace requests that meet the specific failure definition and can avoid most of the tracing overhead for successful requests.

To enable Failed Request Tracing for a site (in this sample, we use _TroubleshootingPhp_), use the following steps:

1. Switch to **IIS Manager**. If it's closed, select **Start**,and then select **Internet Information Services (IIS) Manager**.
1. Expand the **Server** node, and then expand the **Sites** node.
1. In the tree view on the left, locate and select the name of your site.
1. Under **IIS**, double-click **Failed Request Tracing Rules**.  
    :::image type="content" source="media/troubleshoot-php-with-failed-request-tracing/iis-focus-frt-rules.png" alt-text="Screenshot of the I I S section with a focus on the Failed Request Tracing Rules icon.":::
1. In the **Actions** panel, select **Edit Site Tracing**.
1. Select the **Enable** checkbox.
1. Select **OK**.
1. Now, create a Failed Request Tracing rule. In the **Actions** panel, select **Add**.
1. Leave the **All content** option selected.  
    :::image type="content" source="media/troubleshoot-php-with-failed-request-tracing/add-frt-rule-dialog-all-content-selected.png" alt-text="Screenshot of the Add Failed Request Tracing Rule dialog box with the All content option selected.":::
1. Select **Next**.
1. Enter _400-999_ in **Status code(s)**.  
    :::image type="content" source="media/troubleshoot-php-with-failed-request-tracing/define-trace-condition-400-999-code.png" alt-text="Screenshot of the Define Trace Conditions screen with 4 0 0 dash 9 9 9 entered as the Status code.":::
1. Select **Next**.
1. Leave the default trace providers enabled, and then select **Finish**.
1. Now, you can make requests. Assume for these steps that the requests are made by other users of your site and you aren't aware of their requests or responses. For example, make the following requests using Internet Explorer:  

    - Request `http://localhost:84/hello.php`
    - Request `http://localhost:84/products.php?productid=3`
    - Request `http://localhost:84/products.php?productid=5` (this page produces an error)
1. Find the failed request trace:  

    - Select **Start,** and then select **Command Prompt** to open the Command Prompt window.
    - Run the following command to list the trace logs generated for our site:  

        ```console
        %windir%\system32\inetsrv\appcmd.exe list traces /site.name:"TroubleshootingPhp"
        ```

    - You get an output similar to:  

        ```output
        TRACE "troubleshootingPhp/fr000001.xml" (url:http://localhost:84/products.php?product=5,statuscode:500,wp:2864)
        ```

    - The output indicates that a trace log was generated for a request to `/products.php?product=5`, which resulted in an HTTP 500 error. It tells you that:  

        - The _Products.php_ page caused an error.
        - The input that caused an error is most likely `product=5`, as you don't see failures for other query strings (this conclusion would be more accurate if this page is accessed frequently; in that case you see multiple errors only for this specific query string).
1. You can now obtain a specific trace log to gather more information about the request and the possible cause for the failure. To do this, run the following command from the command prompt (using the quoted ID of the trace log from the previous output):  

    ```console
    %windir%\system32\inetsrv\appcmd.exe list traces /site.name:"TroubleshootingPhp" /text:*
    ```

    This should have the output similar to the following:  

    ```output
    TRACELOG
      TRACE.NAME:" troubleshootingPhp/fr000001.xml"
      PATH:"C:\inetpub\logs\FailedReqLogFiles\W3SVC2\fr000001.xml"
    URL:"http://localhost:84/products.php?product=5"
      STATUSCODE:"500"
      SITE.ID:"2"
      SITE.NAME:"TroubleshootingPhp"
      WP.NAME:"2864"
      APPPOOL.NAME:"TroubleshootingPhp"
      verb:"GET"
      remoteUserName:""
      userName:""
      tokenUserName:"NT
    AUTHORITY\IUSR"
      authenticationType:"anonymous"
      activityId:"{ 00000000-0000-0000-1400-0080000000FA }"
      failureReason:"STATUS_CODE"
      triggerStatusCode:"500"
      timeTaken:"100"
    xmlns:freb:"http://schemas.microsoft.com/win/2006/06/iis/freb"
    ```

1. Inspect the trace log. Open the trace log file in the browser, using the path specified in the previous output (in this sample, it's _C:\inetpub\logs\FailedReqLogFiles\W3SVC2\fr000001.xml_). The Summary tab gives basic information about the request. You can see that the error status was set by the FastCGIModule, which suggests that the error came from PHP. In other cases, you may see that the error came from other IIS modules, in which case you could use the wealth of tracing information in the log to determine the cause. In this case, however, you need to actually see the response that was generated by PHP to get more insight into the error.  
    :::image type="content" source="media/troubleshoot-php-with-failed-request-tracing/request-summary-request-diagnostics.png" alt-text="Screenshot of the Request Summary tab of the Request Diagnostics webpage.":::
1. Select the **Compact View** tab. This tab shows the detailed list of trace events generated by IIS and IIS modules during the processing of the request.  
    :::image type="content" source="media/troubleshoot-php-with-failed-request-tracing/request-diagnostics-compact-view.png" alt-text="Screenshot of the Request Diagnostics screen with the Compact View tab being highlighted.":::

    **Note:**

    - **GENERAL\_REQUEST\_START** event shows some basic information, including the request URL, verb, runtime information about the site, and application to which the request was dispatched.
    - **GENERAL\_REQUEST\_HEADERS** event gives the complete list of headers, which in some cases may be significant when determining which user input may have lead to the error.
    - **GENERAL\_RESPONSE\_HEADERS** and **GENERAL\_RESPONSE\_ENTITY\_BUFFER** events provide the complete response headers and the response body that was sent to the client. In this case, the response body provides the additional information needed to diagnose the error, indicating an incorrect product ID.

These are other sections you should consider while inspecting the trace log:

- The **Request Summary** panel provides a summary of the request, its result, and also highlights any warning or error events during the request execution.
- The **Request Details** panel provides a hierarchical view of the request execution, also allowing you to filter the events by various categories such as Module notifications, Authentication/Authorization, etc. It also offers the Performance View, which helps you understand which parts of execution took the longest time.
- The **Compact View** offers the complete list of events, including a wealth of information about the request execution. Many of the IIS modules produce information about their execution that can be used to understand various aspects of the request processing and the outcome. This information can be invaluable when troubleshooting complex interactions, such as URL rewriting or authentication.

## Locate hanging requests by inspecting current requests execution

This provides a quick way to determine which requests are hanging by inspecting the currently executing requests in IIS.

Suppose you request a page that enters into an endless loop due to a programming bug. In the steps that follow, this page is _loop.php_. In task manager, you may observe that the Php-cgi.exe is busy, consuming near 100 percent of the CPU (if you have multiple CPU cores, you see the process consuming 1/# of cores of total CPU). You can determine which request is hanging:

1. Select **Start**, and then select **Internet Information Services (IIS) Manager**.
1. In the tree view on the left, select on the **Server** node.
1. Under **IIS**, double-click **Worker Processes**.
1. Under **Application Pool Name**, double-click on your application pool name to open the **Requests** view. (In this example, it's _TroubleshootingPhp_.)  
    :::image type="content" source="media/troubleshoot-php-with-failed-request-tracing/worker-processes-app-pool-highlighted.png" alt-text="Screenshot of the Worker Processes screen with the Application Pool Name being highlighted.":::
1. Switch over to a Web browser, and refresh the page if the page has timed out. This may need to be done throughout these steps. Switch back to **IIS Manager**, and then refresh the **Requests** view.
1. Observe the list of currently executing requests, showing the request to the problem page, in this sample, _/loop.php_. The request entry shows:  

    - That the request has been executing for some time (Time Elapsed).
    - The URL of the request (in this sample, _/loop.php_).
    - The module name (FastCGIModule).
    - The execution stage (ExecuteRequestHandler).

You can refresh the view several times to observe that the same request continues to execute in the same stage, pointing out the hanging request.

- Determine which request is hanging using the command prompt. With the command prompt, you can filter out the requests of interest, for example requests to a specific application or a specific URL. It can be used to automate scripts that monitor currently executing requests. Open the Command Prompt window by selecting **Start**, and then selecting **Command Prompt**.
- Switch to a Web browser, and then refresh the `http://localhost:84/loop.php` page. (Note that _loop.php_ is a sample name; the name of your page should be used.) You may need to continually refresh this page for the following steps. Switch to the **command prompt**.
- Run the following command to list the requests that have been executing for more than one second:

    ```console
    %windir%\system32\inetsrv\appcmd.exe list requests /elapsed:1000
    ```

    You get an output similar to the following, with your page name instead of _loop.php_:  

    ```output
    REQUEST " fa000000080000026" (url:GET /loop.php, time:2840 msec, client:localhost, stage:ExecuteRequestHandler, module:FastCgiModule)
    ```

- Filter the requests returned by specifying any number of criteria based on the available request attributes. For example, to show only the requests to a specific URL:  

    ```console
    %windir%\system32\inetsrv\appcmd.exe list requests /url:/loop.php /elapsed:1000
    ```

- You can also use **AppCmd** command linking to perform more complex queries, for example, to determine all applications that have long-running requests:  

    ```console
    %windir%\system32\inetsrv\appcmd.exe list requests /elapsed:1000 /xml | %windir%\system32\inetsrv\appcmd list apps /in
    ```

    You get the list of applications that's similar to the following:  

    ```output
    APP "troubleshootingPhp/" (applicationPool:troubleshootingPhp)
    ```

- Here's an example of taking an action based on the current request data: recycling the application pools with requests that have been executing for more than five seconds:  

    ```console
    %windir%\system32\inetsrv\appcmd.exe list requests /elapsed:1000 /xml | %windir%\system32\inetsrv\appcmd list apppools /in /xml | %windir%\system32\inetsrv\appcmd recycle apppools /in
    ```

    You get the following output, with the name of your application:

    ```output
    "TroubleshootingPhp" successfully recycled
    ```

## More information

- [Error Handling and Logging](http://www.php.net/errorfunc)
