---
title: "Troubleshoot with Failed Request Tracing"
author: rick-anderson
description: "When running PHP, it is sometimes not possible to inspect an error page to diagnose an error condition. This can happen if: You do not know which URL is expe..."
ms.date: 11/15/2009
ms.assetid: c7947671-74a4-41e0-bab7-eb589d7f2c72
msc.legacyurl: /learn/troubleshoot/using-failed-request-tracing/troubleshoot-with-failed-request-tracing
msc.type: authoredcontent
---
# Troubleshoot with Failed Request Tracing

by Tali Smith

When running PHP, it is sometimes not possible to inspect an error page to diagnose an error condition. This can happen if:

- You do not know which URL is experiencing an error.
- The error happens intermittently, and you are not able to manually reproduce it (the error may depend on user input or external operating conditions that may happen infrequently).
- The error only happens in the production environment.

This can make it very hard to define what the error is, and even harder to diagnose it. You may be able to determine which URLs are causing the errors by inspecting the request logs or an error log, but you may still have trouble determining what caused the error to happen.

Internet Information Services (IIS) and above makes it easier to track down and diagnose these difficult error conditions with Failed Request Tracing, which lets you create failure definitions that automatically capture detailed execution traces of certain requests. See [Troubleshooting Failed Requests Using Tracing in IIS 7.0 and Above](troubleshooting-failed-requests-using-tracing-in-iis.md) and [Using Failed Request Tracing to Trace Rewrite Rules](../../extensions/url-rewrite-module/using-failed-request-tracing-to-trace-rewrite-rules.md). This article is based on a hands-on lab from the [PHP on Windows Training Kit](https://www.microsoft.com/downloads/details.aspx?FamilyID=c8498c9b-a85a-4afa-90c0-593d0e4850cb&amp;DisplayLang=en).

To help with PHP diagnostics, these traces can also be made to capture the request input data and the response data from PHP. This can provide the insight needed to diagnose these error conditions.

Another fairly common application problem is code that hangs or enters into a resource-intensive loop. This can often happen because:

- A blocking I/O operation on a file or network takes a long time to complete, such as when accessing a remote Web service or database.
- The code has a bug that causes it to enter into an endless (or long-running) loop, possibly also spinning the CPU or allocating memory.
- The code hangs or deadlocks on a shared resource or lock.

These conditions result in long wait times or timeouts for the user making the request, and the conditions can also negatively impact the performance of the application and even the server as a whole.

IIS provides a quick way to determine which requests are hanging by inspecting the currently executing requests.

## Use Failed Request Tracing to Diagnose Unknown or Hard-to-Reproduce Errors

Failed Request Tracing can be an effective way of tracking down intermittent or hard to reproduce error conditions and diagnosing the error conditions by inspecting details about the request, response, and the wealth of trace events from IIS modules.

Failed Request Tracing can be used in a production environment since it can be configured to only trace requests that meet the specific failure definition and can avoid most of the tracing overhead for successful requests.

To enable Failed Request Tracing for a site (for example, Troubleshooting.PHP), use the following steps:

1. Switch to **IIS Manager**. If it is closed, click **Start**,and then click **Internet Information Services (IIS) Manager**.
2. Expand the **Server** node, and then expand the **Sites** node.
3. In the tree view on the left, locate and click the *name of the site*.
4. Under **IIS**, double-click **Failed Request Tracing Rules**.  
    ![Screenshot of the I I S section with a focus on the Failed Request Tracing Rules icon.](troubleshoot-with-failed-request-tracing/_static/image1.jpg)  
    *Figure 1: Failed Request Tracing rules in IIS*
5. Click **Edit Site Tracing**.
6. Select the **Enable** check box.
7. Click **OK**.
8. Now, create a Failed Request Tracing rule. Click **Add**.
9. Leave the **All content** option selected.  
    ![Screenshot of the Add Failed Request Tracing Rule dialog box with the All content option selected.](troubleshoot-with-failed-request-tracing/_static/image3.jpg)  
    *Figure 2: Add a failed request tracing rule*
10. Click **Next**.
11. Type **400-999** in the **Status code(s)** text box.  
    ![Screenshot of the Define Trace Conditions screen with 4 0 0 dash 9 9 9 entered as the Status code.](troubleshoot-with-failed-request-tracing/_static/image5.jpg)  
    *Figure 3: Assign a status rule to tracing rule*
12. Click **Next**.
13. Leave the default trace providers enabled.  
    ![Screenshot of the Select Trace Providers screen with the default providers enabled.](troubleshoot-with-failed-request-tracing/_static/image7.jpg)  
    *Figure 4: Select tracing providers*
14. Click **Finish**.
15. Now, you can make requests. Assume for these steps that the requests are made by other users of your site and you are not aware of their requests or responses. For example, make the following requests using Windows&reg; Internet Explorer&reg;:  

    - Request `http://localhost:84/hello.php`
    - Request `http://localhost:84/products.php?productid=3`
    - Request `http://localhost:84/products.php?productid=5` (this page produces an error).
16. Find the failed request trace:  

    - Click **Start,** and then select **Command Prompt** to open the Command Prompt window.
    - Run the following command to list the trace logs generated for our site:  

        [!code-console[Main](troubleshoot-with-failed-request-tracing/samples/sample1.cmd)]

    This should produce an output similar to:  

       [!code-console[Main](troubleshoot-with-failed-request-tracing/samples/sample2.cmd)]

    This output indicates that a trace log was generated for a request to **/products.php?product=5**, which resulted in an HTTP 500 error. This immediately tells you that:  

       - The Products.php page caused an error.
       - The input that caused an error is most likely **product=5**, as you don't see failures for other querystrings (this conclusion would be more accurate if this page is accessed frequently; in that case you will see multiple errors only for this specific querystring).
17. You can now obtain a specific trace log to gather more information about the request and the possible cause for the failure. To do this, run the following from the command prompt (using the quoted ID of the trace log from the previous output):  

    [!code-console[Main](troubleshoot-with-failed-request-tracing/samples/sample3.cmd)]

    This should have the following output similar to the following:  

    [!code-console[Main](troubleshoot-with-failed-request-tracing/samples/sample4.cmd)]
18. Inspect the trace log. Open the trace log file in the browser, using the path specified in the previous output (that is, `C:\inetpub\logs\FailedReqLogFiles\W3SVC2\fr000001.xml`). The Summary tab gives basic information about the request. You can see that the error status was set by the FastCGIModule, which suggests that the error came from PHP. In other cases, you may see that the error came from other IIS modules, in which case you could use the wealth of tracing information in the log to determine why. In this case, however, you need to actually see the response that was generated by PHP to get more insight into the error.  
    ![Screenshot of the Request Summary tab of the Request Diagnostics webpage.](troubleshoot-with-failed-request-tracing/_static/image9.jpg)  
    *Figure 5: Inspect the trace logs*
19. Click the **Compact View** tab. This tab shows the detailed list of trace events generated by IIS and IIS modules during the processing of the request.  
    ![Screenshot of the Request Diagnostics screen with the Compact View tab being highlighted.](troubleshoot-with-failed-request-tracing/_static/image11.jpg)  
    *Figure 6: Inspect the Compact View tab*  

    Note the following:  

    - **GENERAL\_REQUEST\_START** event shows some basic information, including the request URL, verb, runtime information about the site, and application to which the request was dispatched.
    - **GENERAL\_REQUEST\_HEADERS** event gives the complete list of headers, which in some cases may be significant when determining which user input may have lead to the error.
    - **GENERAL\_RESPONSE\_HEADERS** and **GENERAL\_RESPONSE\_ENTITY\_BUFFER** events provide the complete response headers and the response body that was sent to the client. In this case, the response body provides the additional information needed to diagnose the error, indicating an incorrect product ID.

These are other sections you should consider while inspecting the trace log:

- The **Request Summary** panel provides a summary of the request, its result, and also highlights any warning or error events during the request execution.
- The **Request Details** panel provides a hierarchical view of the request execution, also allowing you to filter the events by various categories such as Module notifications, Authentication/Authorization, etc. It also offers the Performance View, which helps you understand which parts of execution took the longest time.
- The **Compact View** offers the complete list of events, including a wealth of information about the request execution. Many of the IIS modules produce information about their execution that can be used to understand various aspects of the request processing and the outcome. This information can be invaluable when troubleshooting complex interactions, such as URL rewriting or authentication.

## Locate Hanging Requests by Inspecting Current Requests Execution

This provides a quick way to determine which requests are hanging by inspecting the currently executing requests in IIS.

Suppose you request a page that enters into an endless loop due to a programming bug. In the steps that follow, this page is loop.php. In task manager, you may observe that the Php-cgi.exe is busy, consuming near 100 percent of the CPU (if you have multiple CPU cores, you will see the process consuming 1/# of cores of total CPU). You can determine which request is hanging:

1. Click **Start**, and then select **Internet Information Services (IIS) Manager**.
2. In the tree view on the left, click on the **Server** node.
3. Under **IIS**, double-click **Worker Processes**.
4. Under **Application Pool** Name, double-click on your *site name*. (In this example, the site is Troubleshooting.PHP.)  
    ![Screenshot of the Worker Processes screen with the Application Pool Name being highlighted.](troubleshoot-with-failed-request-tracing/_static/image13.jpg)  
    *Figure 7: View the Application Pool in a worker process*
5. Switch over to a Web browser, and refresh the page if the page has timed out. This may need to be done throughout these steps. Switch back to **IIS Manager**, and then refresh the **Requests** view.  
    ![Screenshot of the Requests view with slash loop dot P H P being highlighted.](troubleshoot-with-failed-request-tracing/_static/image15.jpg)  
    *Figure 8: View the requests*
6. Observe the list of currently executing requests, showing the request to the problem page, in this case, /loop.php. The request entry shows:  

    - That the request has been executing for some time (Time Elapsed).
    - The URL of the request (in this case, /loop.php).
    - The module name (FastCGIModule).
    - The execution stage (ExecuteRequestHandler).

You can refresh the view several times to observe that the same request continues to execute in the same stage, pointing out the hanging request.

- Determine which request is hanging using the command prompt. With the command prompt, you can filter out the requests of interest, for example requests to a specific application or a specific URL. It can be used to automate scripts that monitor currently executing requests. Open the Command Prompt window by clicking **Start**, and then selecting **Command Prompt**.
- Switch to a Web browser, and then refresh the `http://localhost:84/loop.php` page. (Note that loop.php is a sample name; the name of your page should be used.) You may need to continually refresh this page for the following steps. Switch to the **command prompt**.
- Run the following command to list the requests that have been executing for more than one second:  

    [!code-console[Main](troubleshoot-with-failed-request-tracing/samples/sample5.cmd)]

    This will produce output similar to the following, with your page name instead of loop.php:  

    [!code-console[Main](troubleshoot-with-failed-request-tracing/samples/sample6.cmd)]
- Filter the requests returned by specifying any number of criteria based on the available request attributes. For example, to show only the requests to a specific URL:  

    [!code-console[Main](troubleshoot-with-failed-request-tracing/samples/sample7.cmd)]
- You can also leverage **AppCmd** command linking to perform more complex queries, for example to determine all applications that have long-running requests:  

    [!code-console[Main](troubleshoot-with-failed-request-tracing/samples/sample8.cmd)]

    This produces the list of applications, similar to the following:  

    [!code-console[Main](troubleshoot-with-failed-request-tracing/samples/sample9.cmd)]
- Here is an example of taking an action based on the current request data: Recycling the application pools with requests that have been executing for more than five seconds:  

    [!code-console[Main](troubleshoot-with-failed-request-tracing/samples/sample10.cmd)]

    This will produce the following output, with the name of your application:

    [!code-console[Main](troubleshoot-with-failed-request-tracing/samples/sample11.cmd)]

> [!NOTE]
> This article uses material from the [PHP on Windows Training Kit](https://www.microsoft.com/downloads/details.aspx?FamilyID=c8498c9b-a85a-4afa-90c0-593d0e4850cb&amp;DisplayLang=en), published on August 25, 2009.*

## Links for Further Information

- [IIS 7.0 Server-Side](http://mvolo.com/do-complex-iis-management-tasks-easily-with-appcmd-command-piping/)
- [Error Handling and Logging](http://www.php.net/errorfunc)