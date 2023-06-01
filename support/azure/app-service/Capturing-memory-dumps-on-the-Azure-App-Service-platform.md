---
title: Capturing memory dumps on the Azure App Service platform
description: There are many features for capturing memory dumps on Azure App Services Web Apps.  This article makes some recommendations about which feature to use based on the scenario being experienced.
author: benperk
ms.author: benperk
ms.service: app-service
ms.date: 06/01/2023
ms.reviewer: kamils
---
# Capturing memory dumps on the Azure App Service platform
The scenario in which you capture a memory dump for troubleshooting a performance or availability issue, dictates the method used.  For example, capturing a memory dump of a process experiencing high memory consumption would be different than if the process is throwing exceptions or responding slowly.  This article will provide some guidance on debugging features available on Azure App Services for capturing memory dumps.  Note that the process in this context is the IIS process, W3WP.exe.
- Memory dump scenarios map to Azure App Service debugging feature
- Expanded process scenario descriptions
- Expanded Azure App Service debugging feature descriptions
- Expanded Command descriptions (as seen in Table 1.1)
- Next steps, analyzing the memory dump

## Memory dump scenarios mapping to Azure App Service debugging feature

This table provides recommendations only and the command that our App Service feature executes to generate a memory dump.  There are many approaches and features that can be used to capture a memory dump, so many that it might be confusing.  If you have built proficiency for capturing a W3WP memory dump that works for you, this information it is not intended to change your approach.  It is to provide guidance for some who might not have yet built the experience, gained the knowledge or developed a preference.
| Scenario | Azure App Service debugging feature | Command |
|--|--|--| 
| Hang / Slowness | Auto-Heal (Request Duration) | procdump -accepteula -r -dc "Message" -ma <PID> <PATH> |
| Crash (process termination) | Crash Monitoring | uses DbgHost to capture memory dump |
| Crash (Handled Exceptions) | Application Insights / Log Analytics (traces) | ---NONE--- | 
| Crash (Unhandled Exceptions) | Application Insights w/ Snapshot Debugger | ---NONE--- |
| High CPU | Proactive CPU Monitoring | procdump -accepteula -dc "Message" -ma <PID> <PATH> |  
| High Memory | Auto-Heal (Memory Limit) | procdump -accepteula -r -dc "Message" -ma <PID> <PATH> |

#### Table 1.1, Recommended process memory dump collection tool per scenario

There is a secondary recommendation for capturing a W3WP process memory dump in the Hang / Slowness scenario.   When the Hand / Slowness scenario is reproducible and you want to capture the dump immediately, you can use the Collect Memory Dump.  This Diagnostic Tool is located in the Diagnose and solve problems toolset blade for the given App Service Web App in the Azure portal.  Another location to check for the general exceptions and poor performance is the Application Event Logs which is also accessible from the Diagnose and solve problems blade in the Azure portal.  Both of these just mentioned and each shown in Table 1.1 will be discussed in the Expanded Azure App Service debugging feature descriptions section. 
## Expanded process scenario descriptions

In this section you will read a detailed descriptions of the 6 scenarios shown in Table 1.1.  
- **Hang / Slowness** – when a request is made to a web server most of the time some code needs to be executed.  The code execution happens within the W3WP.exe process on threads, each thread having a stack that shows what is currently running.  A Hang scenario can be either permanent, which means the request will likely timeout or slow.  Therefore, the Hang / Slowness scenario is one in which as request a taking much longer than expected.  What is considered slow has a lot to do with what the code is doing, so to some 3 seconds is slow while others 15 seconds is acceptable.  Basically, if you see performance metrics showing slowness or a super user who simply states that it is responding slower than normal, then you have a Hang / Slowness scenario.
- **Crash (process termination)** – over many years the .NET Framework has improved the handling of exceptions, now with .NET the experience is even better.  Historically when developers did not place code snippets within an try{} catch(){} block and an exception was thrown, the process would terminate.  In that case an unhandled exception in the developers code would terminate the process.  More modern versions of the .NET Framework and .NET will handle some of these “unhandled” exceptions so that the process that is running the code does not crash.  However, not all unhandled exceptions are thrown directly from the custom code like Access Violations like 0xC0000005 and 0x80070005 or a Stack Overflow, which can result in the termination of the process.
- **Crash (Handled Exceptions)** – although a software programmer takes special care to determine all possible scenarios under which the code will execute, there is a chance that something unexpected happens.  In this case, for example unexpected null values, invalid casting, or a missing instantiated object would trigger an exception.  It is a best practice to place code execution into try{}catch(){} code blocks. Doing so gives the developer an opportunity to fail gracefully by specifically managing what happens after this unexpected event happens. A handled exception is an exception thrown inside a try block and caught in the corresponding catch block. In other words, the developer anticipated that an exception could occur and coded an appropriate try/catch block around that section of code.  One very useful action to take in the catch(){} block is to capture enough information into a logging source so that the issue can be reproduced and ultimately resolved.  Exceptions are very expensive code paths when it comes to performance, so having many exceptions will impact performance.
- **Crash (Unhandled Exceptions)** – these exceptions are encountered when code attempts to perform an action in which it does not expect.  Like the previous example concerning Crash (process termination) that code is not contained within a try{}catch(){} code block. In other words, the developer did not anticipate that an exception could occur in that section of code..  There are 2 differences here when compared to the previous 2 exception scenarios.  First, in Crash (Unhandled Exceptions) scenario the code in question is the code in which the software developer wrote, it is not framework code throwing the exception and it is not one of the unhandled exceptions which will kill the W3WP.exe process.  Second, because the code that is throwing an exception is not within a try{}catch(){} block, there is no opportunity to handle the exception gracefully.  This means, troubleshooting them would be a bit more complex initially.  Your goal would be to find the exception text, type, and stack that identifies the method which is throwing this unhandled exception.  That would give you enough details to know where you need to add the try{}catch(){} code block to.  Then the programmer can add the similar logic to log exception details like should exist in the Crash (Handled Exceptions) scenario. 
- **High CPU** – what is High CPU?  This is dependent on what the code does, but in general if the CPU consumption from the W3WP.exe is 80% then your application is in a critical situation that can result in a variety of symptoms, such as slowness, errors, and other undefined behavior.  However, even a 20% CPU consumption could be considered high if all the web site is doing is delivering static HTML files.  Do keep in mind that post mortem troubleshooting of a High CPU spike with a memory dump will likely not lead to the specific method which is consuming it. Best you can do is see which requests were likely taking the longest and attempt to reproduce the issue by testing the identified method..  That assumes you do not have performance monitors running in on the performance systems which did capture that burst, but having monitoring running in real-time all the time does cause performance issues itself in many cases.
- **High Memory** –when an application is running in a 32bit process, high memory can be a problem because it does not take much to consume the 2-3GB of allocated virtual address space. A 32-bit process can never exceed a total of 4GB regardless of the amount of physical memory available.  A 64bit process is allocated much more memory and is more likely to consume the amount of physical memory on the server than it is to consume its allocated virtual address space.  Therefore, what constitutes a high memory issue depends on the bit-ness and what is considered the normal amount of utilized memory.  In either case, if your process is consuming more memory than expected, collect a memory dump for analysis to determine what is consuming it.  I wrote I nice article that contains some information about memory consumption here.

Now that have a bit more context about the different process scenarios which a memory dump is helpful in troubleshooting, read further about the recommended tool for capturing them on the Azure App Service platform.

## Expanded Azure App Service debugging feature descriptions

There are 6 debugging features which are targeted at collecting memory dumps identified in Table 1.1.  Each of these features are accessible from within the Azure portal here on the Diagnose and solve problems blade, as illustrated in Figure 1. 
![image](https://github.com/MicrosoftDocs/SupportArticles-docs/assets/8362179/62b26419-f7e4-456d-b3b5-ea321798e115)
#### Figure 1, the diagnose and solve problems azure portal blade

In the following section you will see each one of these in more detail.

## Auto-Heal (Request Duration)
This feature is useful for capturing a memory dump when the response is taking a longer than expected amount of time to complete.  You can see the link to Auto-Heal in the Diagnostic Tools tile in Figure 1.  Select that link to go directly to the feature or select the tile and review all the available Diagnostic Tools.  Two resources for configuring this feature and one feature overview link are provided.
- [App Services Auto heal](https://appserviceblog.com/en/app-services-auto-heal/)
- [Collect and Automate Diagnostic Actions with Azure App Services](https://devblogs.microsoft.com/premier-developer/collect-and-automate-diagnostic-actions-with-azure-app-services/)
- [Azure App Service diagnostics overview](https://learn.microsoft.com/en-us/azure/app-service/overview-diagnostics#auto-healing)

The Auto-Heal feature resembles that shown in Figure 2.
![image](https://github.com/MicrosoftDocs/SupportArticles-docs/assets/8362179/e24db37d-fb0d-4c4d-9533-1c412784eddd)
#### Figure 2, Auto-Heal (Request Duration)

As mentioned earlier, there also exists a feature named Collect Memory Dump will be useful in this scenario when the issue is currently happening or reproducible.  This feature is quick and easy and collects a memory dump on manual demand.

## Collect Memory Dump

An article which describes the configuration of this feature in more detail is named Collect Memory Dump App Services and is located here.  This approach requires manual intervention and resembles that shown in Figure 3.
![image](https://github.com/MicrosoftDocs/SupportArticles-docs/assets/8362179/9f27bf1f-c4da-4038-9fe3-084ea2d23ff1)
#### Figure 3, Collect Memory Dump

You select a storage account for storing the the memory dump, then you select which instance you want to collect it from.  If you have more than a single instance you need to make sure the issue you are debugging is happening on that instance (aka server).  Also take note that this configuration will restart you application which might not be optimal on a production application that is in operation.

## Crash Monitoring

This feature is useful for capturing a memory dump when an unhandled exception causes the W3WP process to terminate.  This feature is illustrated in Figure 3.
![image](https://github.com/MicrosoftDocs/SupportArticles-docs/assets/8362179/cba681f4-bd9d-41a2-b91e-1c9c0f6701ed)
#### Figure 4, Crash Monitoring

[Here](https://azure.github.io/AppService/2020/08/11/Crash-Monitoring-Feature-in-Azure-App-Service.html) is a useful document which provides a walkthrough for configuring this feature named Crash Monitoring in Azure App Service.

## Application Insights / Log Analytics (traces)

A handled exception is a scenario where the code path execution that is contained within a try{}catch(){} block attempts to perform an action that is unexpected or unsupported.  Take this code snippet for example.
```
decimal percentage = 0, number = 1000, total = 0;
try
{
  percentage = number / total;
}
catch (DivideByZeroException divEx)
{
  _logger.LogError("A handled exception just happened: -> {divEx.Message}", divEx.Message);
}
```

This code snippet results in a divide by zero exception which is handled because the unsupported mathematical operation is placed within a try{}catch(){} block.  Handled exceptions will not be logged into Application Insights unless you specifically, manually, intentionally include the [Microsoft.ApplicationInsights](https://www.nuget.org/packages/Microsoft.ApplicationInsights/) NuGet package in your application code and add the code to log the information.  After adding the code, if the exception happens, you can view the entry in Log Analytics, as shown in Figure 5.
![image](https://github.com/MicrosoftDocs/SupportArticles-docs/assets/8362179/afde0f08-2298-4686-bb40-d4bc3e49a9b8)
#### Figure 5, Application Insights / Log Analytics (traces)

Notice the query used to extract the data from Log Analytics.

```
traces
| where message has "handled"
 | project timestamp, severityLevel, message, operation_Name, cloud_RoleInstance
```
The **message** column is the location where you can store the details required to find the root cause of the exception.  You can see the code snippet used to write this in the code snippet above.  The programmer who wrote this code is the best person to ask about these kinds of exceptions and the attributes necessary to capture for performing root cause analysis.

The best approach to add this into your application code depends on the application code stack and version you have.  For example, ASP.NET, ASP.NET Core, MVC, Razor, etc…  You can start [here](https://learn.microsoft.com/en-us/azure/azure-monitor/app/ilogger?tabs=dotnet6) and then find the best approach pattern for your given scenario.

## Application Event Logs

You will also be able to find unhandled exceptions in the handled exception in the Application Event Logs in the Diagnostic Tools blade in the Azure portal as seen in Figure 6.
![image](https://github.com/MicrosoftDocs/SupportArticles-docs/assets/8362179/71259a9e-909d-4730-9d9d-a835ee3cb898)
#### Figure 6, Application Event Logs, handled exception

You do get the same error message you logged with your code, but you loose some flexibility with the query-ability gained from Application Insights trace logs.

## Application Insights with Snapshot Debugger

Unhandled exceptions are logged into the Application Event Logs as well, as shown in Figure 7, but you can also enable the Snapshot Debugger, as described [here](https://learn.microsoft.com/en-us/azure/azure-monitor/snapshot-debugger/snapshot-debugger-app-service).  This approach does not require that you add any code to your application.

## Application Event Logs

An example of unhandled application exceptions.
![image](https://github.com/MicrosoftDocs/SupportArticles-docs/assets/8362179/2cdfb381-0500-43e7-b691-4453c4f7920e)
#### Figure 7, Application Event Logs, unhandled exception

One difference from the handled exception Application Event Log you might notice is the existence of the stack which identifies the method and the line from which the exception is thrown.  Also, it is safe to assume that the [Microsoft.AspNetCore.Diagnostics.ExceptionHandlerMiddleware](https://source.dot.net/#Microsoft.AspNetCore.Diagnostics/ExceptionHandler/ExceptionHandlerMiddleware.cs) contains code to catch this unhandled exception so that the termination of the process is avoided.  The exception is shown in Application Insights on the Failures blade as seen in Figure 8.
![image](https://github.com/MicrosoftDocs/SupportArticles-docs/assets/8362179/727cee54-5b4d-49dd-9d96-3050197b5086)
#### Figure 8, Application Insights with Snapshot Debugger

You will see all Exceptions in this view, not just the one your are searching for.  The visual representation of all exceptions happening in your application is helpful to gain an overview of the health of your system.  The Application Insights Dashboard much more helpful in that respect when compared to the Application Event Logs.

# Proactive CPU Monitoring

For High CPU scenarios you can use this tool, a detailed article named Mitigate your CPU problems before they happen is located here.

![image](https://github.com/MicrosoftDocs/SupportArticles-docs/assets/8362179/b6266cbc-2bf5-4fb1-a5d0-6592cde33845)
#### Figure 9, Proactive CPU Monitoring

If you are seeing CPU consumption of 80% or more you should consider this a critical situation that requires immediate investigation.  Notice in Figure 9 that you can set the scenario for when you want to capture a memory dump based on CPU Threshold, Threshold Seconds, and Monitor Frequency.  The CPU Threshold identifies how much of the CPU on the machine is being consumed by the targeted process, in this case W3WP.  Threshold Seconds is the amount of time the CPU was consumed the CPU Threshold.  For example, if the CPU consumed 75% for 30 seconds, the capturing of the memory dump would happen.  As configured in Figure 9, checking the process for threshold breaches would happen every 15 seconds.

## Auto-Heal (Memory Limit)

This feature is useful for capturing a memory dump when the process is consuming more memory than is expected.  Again, pay attention to the bit-ness, I.e. 32 or 64.  If you are experiencing memory pressure in the 32 bit process context and the memory consumption is expected, you might consider changing the bit-ness to 64. Keep in mind that doing so typically requires recompiling of the application. It will also not reduce the amount of memory used but rather allow the process to use more than 4GB of total memory.  However, if the memory consumption is not expected you can use this feature to find out what is consuming the memory and take an action to control the memory consumption.  You can see the link to Auto-Heal in the Diagnostic Tools tile in Figure 1.  Select that link to go directly to the feature or select the tile and review all the available Diagnostic Tools.  More details concerning Auto-healing can be found at the following link.

- [Azure App Service diagnostics overview](https://learn.microsoft.com/en-us/azure/app-service/overview-diagnostics#auto-healing)

The Auto-Heal feature resembles that shown in Figure 10.  When you click on Memory Limit you are given the option to enter a memory value that will trigger the capture of a memory dump when breached.  For example, if you enter 6291456 as the value, a memory dump of the W3WP process will be taken when 6 GB of memory is consumed.
![image](https://github.com/MicrosoftDocs/SupportArticles-docs/assets/8362179/14d41fcc-5475-40e6-8ade-9048eebd28a4)
#### Figure 10, Auto-Heal (Memory Limit)

As mentioned earlier, there also exists a feature named Collect Memory Dump will be useful in this scenario when the issue is currently happening or reproducible.  This feature is quick and easy and collects a memory dump on manual demand.  See Figure 3 for an illustration of the Collect Memory Dump feature.

## Expanded Command descriptions (as seen in Table 1.1)

The art of memory dump collection takes some time to study, experience, and perfect.  As you have read there exists different memory dump collection procedures based on the symptoms the process is showing.  Those symptoms are listed previously in Table 1.1 and again here in Table 1.2.  The difference between the two tables is that Table 1.2 compares the Azure App Service memory dump capture command with the procdump command that you would execute manually from the Kudu console.
| Scenario | Azure App Service Command | General procdump Command |
|--|--|--|
| Hang / Slowness | procdump -accepteula -r -dc "Message" -ma <PID> <PATH> | procdump -accepteula -ma -n 3 -s # <PID> |
| Crash (process termination) | uses DbgHost to capture memory dump | procdump -accepteula -ma -t <PID> |
| Crash (Handled Exceptions) | ---NONE---  (Application Insights) | procdump -accepteula -ma -e 1 -f <filter> <PID> |
| Crash (Unhandled Exceptions) | ---NONE---  (Application Insights / Snapshot debugger) | procdump -accepteula -ma -e <PID> |
| High CPU | procdump -accepteula -dc "Message" -ma <PID> <PATH> | procdump -accepteula -ma -n 3 -s # -c 80 <PID> |
| High Memory | procdump -accepteula -r -dc "Message" -ma <PID> <PATH> | procdump -accepteula -ma -m 2000 <PID> |
#### Table 1.2, Recommended process memory dump collection tool per scenario with associated procdump command

It is obvious that the commands executed using the Azure App Service memory dump capturing features are different than the procdump commands you would use if capturing manually.  If you look back in the previous section you will notice that the Azure App Service memory dump collection portal feature exposes the configuration.  For example, the **High Memory** scenario command executed by the platform does not contain a memory threshold, like the one shown in the General procdump Command column.  There is a tool named [DaaS](https://github.com/Azure/DaaS) which is responsible for managing and monitoring the configuration made in the Azure App Service debugging portal.  This tool runs as a WebJob on the virtual machines running your web app.  A great benefit of this tool is that you can target a specific machine in your web farm.  If you were to try and capture a memory dump using procdump directly, identifying, targeting, accessing, and executing that command on a specific instance is challenging.  Here is a link to an article that discusses DaaS in a bit more detail, followed by a link to procdump documentation.
- [DaaS – Diagnostics as a Service for Azure Web Sites](https://azure.microsoft.com/en-us/blog/daas/)
- [ProcDump - Sysinternals](https://learn.microsoft.com/en-us/sysinternals/downloads/procdump)

Another scenario discussion to help push the reasons how the platform manages the memory dump collection so that they match the recommended procdump patterns is **High CPU**.  The procdump command, as shown in Table 1.2 will collect 3 (-n 3) full memory dumps (-ma), 30 seconds apart (-s #, where # = 30) when the CPU consumption is >= 80% (-c 80).  Finally, you provide the command with the process id (<PID>): **procdump -accepteula -ma -n 3 -s # -c 80 <PID>**, you can see the portal configuration in Figure 9.  For brevity, Figure 9 showed only the first 3 configuration options, CPU Threshold (-c), Threshold Seconds (-s), and Monitor Frequency.  Figure 11 illustrates that Configure Action, Maximum Actions (-n), and Maximum Duration are also available features.
![image](https://github.com/MicrosoftDocs/SupportArticles-docs/assets/8362179/6459fc2a-1854-453c-abf7-840aa20a039c)
#### Figure 11, Proactive CPU Monitoring, extended

After studying the different approaches for capturing memory dumps the next step is to practice doing it.  I have created some code examples on GitHub [here](https://github.com/benperk/CSharpGuitarBugs) and [here](https://github.com/benperk/CsharpGuitarBugs-Function) which can be used to simulate each of the scenarios listed in Table 1.1 and 1.2.  Once you deploy the code onto the Azure App Service platform you can use these tools to capture the memory dump under each given scenario.  Overtime and after much practice you will perfect your approach for the capturing of memory dumps using the Azure App Service debugging features.  Here are a few suggestions to consider as you progress your memory dump collection learnings forward. 
- Capturing a memory dump consumes significant system resource and will disrupt performance even further.
- It is not optimal to capture dumps on first chance because you will most likely get too many dumps.  Those 1st chance dumps are most likely irrelevant.
- It is recommended to disable Application Insights when capturing a w3wp memory dump

After the memory dump is collected, the next step is to analyze them to find the cause and correct it.

## Next steps, analyzing the memory dump

How to analyze a memory dump is outside the scope of this article, but there are many resources for these learnings.  One of my favorite and most hardcore training series are [Defrag-Tools](https://learn.microsoft.com/en-us/shows/defrag-tools/).  This is a great series of trainings which go all the way to the 0’s and 1’.  [Here](https://www.thebestcsharpprogrammerintheworld.com/2017/01/16/must-use-must-know-windbg-commands-my-most-used/) is my list of must know WinDbg commands.

You might have noticed the Configure Action option in Figure 11.  The default setting is CollectAndKill which means the process is killed after the memory dump is collected.  There also exists a setting named CollectKillAndAnalyze which will perform some analysis on the memory dump collected for you.  In that scenario the platform analysis may find the issue for you without having to open the memory dump in WinDbg and analyzing it.

There are indeed other options for troubleshooting and diagnosing performance issues on the Azure App Services platform.  This article does not cover them all, it instead focuses on memory dump collection and makes some recommendations for approaching the diagnosis using this method.  If you have already studied, experienced and perfected your collection procedures, and they work for you, then keep doing that.  But maybe you still learned a thing or two, or three with the words written in this article.  ROCK!

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]
