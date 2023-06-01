---
title: "Troubleshooting IIS Performance Issues or Application Errors using LogParser"
author: rick-anderson
description: "This article describes the troubleshooting steps to identify performance issues by using Microsoft's LogParser to analyze IIS logs."
ms.date: 12/18/2012
ms.assetid: 0a84b2a8-5ac6-41f4-b631-c1345b2ddf33
msc.legacyurl: /learn/troubleshoot/performance-issues/troubleshooting-iis-performance-issues-or-application-errors-using-logparser
msc.type: authoredcontent
---
# Troubleshooting IIS Performance Issues or Application Errors using LogParser

by [Benjamin Perkins](https://twitter.com/csharpguitar)

## Tools and knowledge used in this Troubleshooter

- Microsoft LogParser (<https://www.microsoft.com/download/details.aspx?id=24659>)
- Command Prompt
- A basic knowledge of IIS HTTP Status Codes is helpful (<https://support.microsoft.com/kb/943891>)
- A basic knowledge of SQL queries is helpful

## Overview

This troubleshooter will help you analyze IIS log files in an effort to determine the cause when an application that is hosted on IIS is failing or experiencing performance issues. Before you begin, it is important to note that all fields IIS can log are not enabled by default. For example, *Bytes Sent* and *Bytes Received* are not selected, but they are very useful when troubleshooting a performance problem. Therefore, the best time to include these additional fields is before you are experiencing system problems. So if you haven't already done so, select these additional fields, they will help you find solutions when problems happen.

The following blog which discusses how to perform this on IIS 7+:

[Modifying IIS 7 log data in Windows 2008](https://blogs.msdn.com/b/benjaminperkins/archive/2012/08/01/modifying-iis-7-log-data-in-windows-2008.aspx)

## Scenario

As a Systems Administrator you begin to hear reports from users of your system hosted on IIS that the response is slow. There is some mention that web browsers simply time out or stop responding completely when they are accessing your website.

You jump into action and recycle the worker process; all appears to be working again, as normal.

However, you cannot accept that as a solution and need to know why this happened, but don't know where to start. You have no details from the users, such as error codes, screen shots and worse, you have no performance data to compare what just happened to normal performance. In many cases, other new issues take you away from any serious root cause analysis.

Microsoft's LogParser is a good tool that is quick and easy to use. In many situations, the tool will help you quickly get to a deeper understanding of what happened on the server and may help you identify problems. You can take the information you gather with LogParser and pass it along to your database team, your network team or to your developers for more analysis.

## Data Collection

By default, IIS log files are located in the following directories:

- IIS 7 and later: `%SystemDrive%\inetpub\logs\LogFiles`
- IIS 6 and earlier: `%WinDir%\System32\LogFiles`

In this troubleshooter, I will be using IIS 8. Open the **IIS Manager** and select **Sites**, as shown in *Figure 1*. This will show you the ID of each website hosted on your server. You will need this ID to determine which W3SVC\* directory to analyze.

![Screenshot of the I I S Manager window showing Sites in the main pane.](troubleshooting-iis-performance-issues-or-application-errors-using-logparser/_static/image1.png)  
**Figure 1: Getting the ID of your web site**

Open Windows Explorer and navigate to the directory that contains the IIS log files of the website that experienced the performance problem. *Figure 2* shows how that might look like.

![Screenshot of Windows Explorer showing file locations.](troubleshooting-iis-performance-issues-or-application-errors-using-logparser/_static/image3.png)  
**Figure 2: IIS Log file location**

IIS log files can be quite large; for example, in *Figure 2*, the log file *u\_ex12101858.log* is nearly 100MB in size. Because these log files may be huge and contain hundreds of thousands of individual log file entries, manually looking through each of these files for an error is not a good approach, and returns few results for the time that you invest.

This is when LogParser becomes an indispensable tool in your troubleshooting arsenal.

## Data Analysis

Your first step is to determine which log files may contain errors. For example, if customers were complaining about performance on the 3rd of June, 2012, the log file might be *u\_ex120603.log*, where:

- &quot;12&quot; is the abbreviated year for 2012
- &quot;06&quot; refers to the sixth month (June)
- &quot;03&quot; is the 3rd day of the month

Note: The above example assumes that IIS logging is configured to rotate log files on a daily basis, which is the default. If you have changed the settings for IIS to rotate log files on a different time interval, such as weekly or hourly, then the log files names would be different. For more information about the syntax for IIS log file names, see the IIS Log File Naming Syntax (`https://support.microsoft.com/kb/242898`) article.

> [!NOTE]
> By default, the date and time in IIS logs are stored using GMT; you will need to take this into account when you are determining which logs contain errors. That being said, you can adjust the dates/times by using LogParser's `TO_LOCALTIME()` function, as illustrated in the following example:

> [!NOTE]
> [!code-sql[Main](troubleshooting-iis-performance-issues-or-application-errors-using-logparser/samples/sample1.sql?highlight=1)]

Once you have identified the IIS log files that contain errors, you should copy them to a location where they can be analyzed. This step is optional, but it is not recommended that you analyze your logs on your IIS server since your LogParser queries may take a long time to run, and if your log files are large then Log Parser may compete for system resources.

For example, you might copy your IIS logs to a folder on your personal computer where you have already copied the LogParser files, which is how I typically analyze my log files. *Figure 3* shows an example of where I stored them to create this article.

![Screenshot of Windows Explorer showing the location of the log parser executable.](troubleshooting-iis-performance-issues-or-application-errors-using-logparser/_static/image5.png)
**Figure 3: IIS Logs files locally hosted for analysis using LogParser**

After you have downloaded LogParser, you are ready to begin the analysis. The first query I run is shown in *Figure 4*. The results give you an overview of how IIS has been responding to the requests.

[!code-console[Main](troubleshooting-iis-performance-issues-or-application-errors-using-logparser/samples/sample2.cmd)]

**Figure 4: LogParser Query (*sc-status and sc-substatus*)**

The points of interest within the results are:

- The ratio between 200 and 304 HTTP status codes (successful requests)
- The number of 500 HTTP status codes (failed requests)

The significance for each of these status codes is explained below.

### The Ratio Between HTTP 200 and 304 Status Codes (Analyzing Successful Requests)

The ratio between the 200 and 304 HTTP status codes is important because it shows how many requests are being retrieved from the clients' cache instead of directly from the server. The results in *Figure 4* show that there are 3,920,658 requests which resulted in an HTTP Status code of 200. This means that the requested file was served from the server each time. In contrast, there were 178,705 requests which resulted in a 304 HTTP status code. This means that the requested file was retrieved from the local cache. In other words, 95.5% of the requests are being handled from the server.

Caching can have some very positive impact on your system's performance; see the details for both static and dynamic compression in the [Configuring HTTP Compression in IIS 7](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/cc771003(v=ws.10)) article.

### HTTP 500 Status Codes (Analyzing Failed Requests)

HTTP 500 Status codes may indicate serious issues on your system. The level of impact that the root cause of an HTTP 500 error may have on your system can range from nothing to the crash of a worker process. Therefore, when you see these, you should execute the query shown in *Figure 5* in order to find which requests resulted in a 500 HTTP Status code.

[!code-sql[Main](troubleshooting-iis-performance-issues-or-application-errors-using-logparser/samples/sample3.sql)]

**Figure 5: LogParser Query (*cs-uri-stem with a 500 sc-status*)**

These results show the path and the name of the file which, when requested, responded with an HTTP 500 Status code. This kind of information would be valuable to the development team. For example, the development team could look further into that specific code and search for code that executes without being contained in a `try {...} catch {...}` code block, or they are executing large data queries which need to be optimized.

Let's take this example a step further and focus on the top contributor for HTTP 500 Status codes. It would be interesting to know when these errors occurred, because this information can be used to check if dependencies were having any problems at the same time.

[!code-sql[Main](troubleshooting-iis-performance-issues-or-application-errors-using-logparser/samples/sample4.sql)]

**Figure 6: LogParser Query (*cs-uri-stem with a 500 sc-status*)**

The subset of results in *Figure 6* restricts the date range of the issue. This information can be passed along to network, database, operating system administrators and the development teams to check if anything else was happening at that same time. For example: *Were there any additional problems between 08:00 and 09:59:59 GMT and between 14:00:00 and 14:59:59 GMT*?

The next set of LogParser queries utilize the following fields, which may give better insight into performance problems:

| Field | Description | Enabled by default |
| --- | --- | --- |
| time-taken | The length of time the action took, in milliseconds | Yes |
| sc-bytes | The number of bytes sent by the server | No |
| cs-bytes | The number of bytes the server received | No |

As mentioned before, take the time now to request the sc-bytes and cs-bytes fields be enabled or, if possible, enable them yourself. They provide some valuable insight into your system and its' behavior. Take *Figure 7*, for example. You see that the average time is pretty good at a few hundred milliseconds. However, look at the maximum time-taken, that is way too much time.

[!code-console[Main](troubleshooting-iis-performance-issues-or-application-errors-using-logparser/samples/sample5.cmd)]

**Figure 7: LogParser Query (MAX and AVG *time-taken*)**

I know you are asking yourself already the next question that needs to be answered. Which request is taking so much time? *Figure 8* shows the answer to that question. As you will notice, I have gone ahead and included the sc-bytes field in the LogParser query. Remember, sc-bytes represents the size of the file sent from the server back to the client.

[!code-sql[Main](troubleshooting-iis-performance-issues-or-application-errors-using-logparser/samples/sample6.sql)]

**Figure 8: LogParser Query (*MAX and AVG time-taken*)**

We would likely all agree that the time-taken for the requests exceeds a 'normal' response time. However, the size of the files is something which the administrator or developer would need to analyze to determine if the sizes are within an acceptable range.

The conclusion is that the GetDetailsView.aspx file has been throwing a number of 500 HTTP Status codes and has at some point taken a long time to complete, even though it was a relatively small file. You may want to look at the date and time when problems where occurring for this file, and examine the code in the file with any issues that occurred. (For example, the IIS logs contain a list of variables that were passed in the query string; you could check those values for bad data.)

The examples provided in figures 4 - 8 help gain an understanding around where the root cause of an issue may exist. It is likely, however, that this analysis has only rendered a better view of the situation which will lead to more questions and deeper analysis. If that's the case you may want to create a representation of this data in a more presentable manner. The following section covers this in detail.

## Reporting

Screenshots of a command window containing LogParser queries and their results may be fine during the analysis phase of a performance problem; however, if you need to go in front of managers or directors to explain what happened, it may not meet the mark.

> [!NOTE]
> In order to get charting to work via LogParser, you will need to install the Office Web Components. The following articles explain how to do this:
>
> - [Advanced Log Parser Charts Part 3 - Missing Office Web Components for Charting](https://blogs.msdn.com/b/robert_mcmurray/archive/2012/05/25/advanced-log-parser-charts-part-3-missing-office-web-components-for-charting.aspx)
> - [Charting with LogParser](https://blogs.msdn.com/b/carloc/archive/2008/08/07/charting-with-logparser.aspx)

*Figure 9* shows the LogParser query to create a 3D pie chart containing the number of requests and their associated HTTP Status code. I removed status 200, as those are successful. What I am after here are the requests which are something other than OK.

[!code-sql[Main](troubleshooting-iis-performance-issues-or-application-errors-using-logparser/samples/sample7.sql)]

**Figure 9: LogParser Query (Create a 3D pie chart)**

The result of the query is illustrated in *Figure 10*. There are a number of additional parameters which you can pass to LogParser that affect the image. For example, legend, groupSize, config, etc... To get a complete list enter: ***LogParser -h -o:CHART*** for a list of all parameters. This command will also provide a list of the different chart types.

![Diagram of a three-dimensional pie chart showing request status allocations.](troubleshooting-iis-performance-issues-or-application-errors-using-logparser/_static/image7.png)  
**Figure 10: LogParser 3D pie chart**

Another useful chart is the ratio between cached and actual requests. Recall from the Data Analysis section where I discussed that an HTTP Status code of 200 means that the requested files are retrieved from the server however, a 304 is retrieved from the client. *Figure 11* shows the LogParser query for the creation of this chart. Notice that I used the **-values** parameter.

[!code-sql[Main](troubleshooting-iis-performance-issues-or-application-errors-using-logparser/samples/sample8.sql)]

**Figure 11: LogParser Query (Create a 3D pie chart)**

Although the difference between HTTP Status code 200 and 304 are clearly visible, I thought it may add some value to include the number of hits for each. *Figure 12* illustrates the output of the previous LogParser query.

![Diagram of a three-dimensional pie chart showing the allocation of cache.](troubleshooting-iis-performance-issues-or-application-errors-using-logparser/_static/image9.png)  
**Figure 12: LogParser 3D pie chart**

I think you are getting the picture now about how charting the IIS Logs using LogParser can help convey what is happening much better than a table of data. But before I stop, I want to show you one more example using the Column chart type. The LogParser query shown in *Figure 13* produces a 3D Column chart showing the count of 500 HTTPS Status codes per hour.

[!code-sql[Main](troubleshooting-iis-performance-issues-or-application-errors-using-logparser/samples/sample9.sql)]

**Figure 13: LogParser Query (Create a 3D column chart)**

The resulting chart is illustrated in *Figure 14*.

![Diagram of a three dimensional column chart showing the number of 500 errors per hour by date.](troubleshooting-iis-performance-issues-or-application-errors-using-logparser/_static/image11.png)  
**Figure 14: LogParser 3D column chart**

### Creating charts using Excel and CSV

At the beginning of this section I mentioned that the installation of the Office Web Component (OWC) is a requirement if you want to use the LogParser charting capabilities. In your organization, there may be restrictions that prohibit this or you simply might not want to install it. If either is the case, then consider exporting the LogParser query result to a CSV file and import it into Excel.

*Figure 15* shows the LogParser query that extracts the HTTP Status codes for all request which are not 200 to a CSV file.

[!code-sql[Main](troubleshooting-iis-performance-issues-or-application-errors-using-logparser/samples/sample10.sql)]

**Figure 15: LogParser Query (Create a CSV file for import into Excel)**

Notice in *Figure 15* that I used the -o parameter so that LogParser creates the output in CSV format.

To import the CSV file into Excel so that a chart can be created from it, open Excel, navigate to the DATA tab and select From Text. *Figure 16* shows what this looks like.

![Screenshot showing the Excel Data tab menu options.](troubleshooting-iis-performance-issues-or-application-errors-using-logparser/_static/image13.png)
**Figure 16: Import CSV file created by LogParser into Excel**

Select the status.csv file created by the LogParser query and navigate through the import wizard. Import the 'comma' delimited CSV file and you will end up with the Status in column A and the number of occurrences for each status in column B. This assumes you executed the LogParser query shown in *Figure 15*. Lastly, select all the data from column A and B, including the headers and choose the type of Pie chart to create. *Figure 17*, illustrates how this may look.

![Screenshot showing the Excel Insert tab options. The data in columns A and B are selected.](troubleshooting-iis-performance-issues-or-application-errors-using-logparser/_static/image15.png)
**Figure 17: Create a Pie chart using a CSV file**

The end result is a Pie chart, *Figure 18* that is similar to that shown previously in *Figure 10*. There are many options in regards to color, chart type, labels, etc. With a click of a button you can change the chart type from Pie to Bar or to Line. There are a lot of options for creating professional looking charts within Excel.

![Screenshot of a three-dimensional pie chart showing request status.](troubleshooting-iis-performance-issues-or-application-errors-using-logparser/_static/image17.png)  
**Figure 18: A Pie chart using a CSV file similar to Figure 10**

There are so many options and possibilities for analyzing and presenting the results of that analysis using LogParser. For some additional tips and examples, check out these [articles](https://blogs.msdn.com/b/robert_mcmurray/archive/tags/logparser/) written by Robert McMurray. There is also a very useful help file and many prewritten scripts provided within the installation package of LogParser. The next section will discuss this and other topics in more detail.

## Help

When you install LogParser 2.2 onto your machine, it installs by default into the `C:\Program Files (x86)\Log Parser 2.2` directory. Navigate to that location and review the Samples\Queries and Samples\Scripts directories for an abundant supply of prewritten code that will get you moving fast.

You will also realize a great benefit by reading through the contents within the LogParser.chm file.

### Reducing the size of or splitting IIS log files

You may encounter a situation where the IIS log file is too big for LogParser to query. This is most likely on a 32-bit machine, but can happen on a 64-bit machine too. Nonetheless, if you experience 'out of memory' errors when running a LogParser query, consider executing the command shown in *Figure 19*. The query extracts some essential fields from a large IIS log file and places them into another, which results in a smaller log file.

[!code-console[Main](troubleshooting-iis-performance-issues-or-application-errors-using-logparser/samples/sample11.cmd)]

**Figure 19: Reducing the size of an IIS log file (by removing fields)**

In this example, I realized a file size reduction of about 45%. In many cases this may be enough, in others maybe not. It depends on the size of the original log file. If you find that you still need to reduce the size of the IIS log file, consider adding a date time constraint to the LogParser query as shown in *Figure 20*.

[!code-sql[Main](troubleshooting-iis-performance-issues-or-application-errors-using-logparser/samples/sample12.sql)]

**Figure 20: Further reducing the size of an IIS log file by adding a WHERE clause**

This is a valuable technique for reducing the file size, but it is also useful to remove unwanted entries from the IIS Log. For example, when beginning to troubleshoot an issue you realize that time-take, sc-bytes and cs-bytes were not being logged. You enabled them in IIS and want the query to only analyze those entries with the recently enabled fields. Use the where statement to extract the data from the IIS log file from the time in which those fields have been enabled. This is important when you use the AVG, MIN and MAX aggregates.

## Conclusion

LogParser is a small but powerful tool to analyze a number of different system log types. This article focused on queries applicable to IIS Logs. When performance problems or errors are experienced in your IIS environment, it is sometimes difficult to know where to start.

LogParser can be used as a starting point, because a system administrator who has some SQL skills can quickly build some very sophisticated LogParser queries. These queries can be used to further the root cause analysis of the problem.

## Useful Links

Here are the links which are referred to in this article, plus a few links with additional information.

- **Microsoft LogParser**: <http://www.bing.com/search?q=logparser> or <https://www.microsoft.com/download/details.aspx?id=24659>
- [The HTTP status codes in IIS 7.0, IIS 7.5, and IIS 8.0](https://support.microsoft.com/kb/943891)
- [Modifying IIS 7 log data in Windows 2008](https://blogs.msdn.microsoft.com/benjaminperkins/2012/07/31/modifying-iis-7-log-data-in-windows-2008/)
- [Modifying IIS 6 log data in Windows 2003](https://blogs.msdn.microsoft.com/benjaminperkins/2012/05/02/modifying-iis-6-log-data-in-windows-2003/)
- [Configuring HTTP Compression in IIS 7](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/cc771003(v=ws.10))
- [Charting with LogParser using OWC](https://www.cloudnotes.io/charting-with-logparser/)
- [Robert McMurray's Blogs on LogParser](https://blogs.iis.net/robert_mcmurray/Tags/LogParser)
- [Microsoft Log Parser Toolkit: A Complete Toolkit for Microsoft's Undocumented Log Analysis Tool](https://www.amazon.com/Microsoft-Log-Parser-Toolkit-undocumented/dp/1932266526)