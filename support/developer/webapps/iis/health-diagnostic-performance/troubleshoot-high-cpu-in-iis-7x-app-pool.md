---
title: "Troubleshooting High CPU in an IIS 7.x Application Pool"
author: rick-anderson
description: "Debug Diagnostics 1.2 Performance Monitor This material is provided for informational purposes only. Microsoft makes no warranties, express or implied. Overv..."
ms.date: 04/09/2012
ms.assetid: 038c309a-e1be-4bb1-871a-aa40e370c391
msc.legacyurl: /learn/troubleshoot/performance-issues/troubleshooting-high-cpu-in-an-iis-7x-application-pool
msc.type: authoredcontent
---
# Troubleshooting High CPU in an IIS 7.x Application Pool

by Jim Cheshire

#### Tools Used in this Troubleshooter:

- Debug Diagnostics 1.2
- Performance Monitor

This material is provided for informational purposes only. Microsoft makes no warranties, express or implied.

## Overview

This troubleshooter will help you to identify the cause of sustained high CPU in an IIS application pool. It's important to keep in mind that it is normal for CPU usage to increase as a web application serves requests. However, if you consistently see CPU remain at a high level (in the area of 80% or greater) for prolonged periods, the performance of your application will suffer. For that reason, it's important to understand the cause of sustained high CPU so that it can be addressed and corrected if possible

## Scenario

An application pool in IIS is experiencing a prolonged period of high CPU that exceeds 90%. When the application is tested, no problems are encountered. However, once the application experiences actual user load, CPU climbs to a high percentage and remains. To recover, the application pool must be restarted, but after doing so, CPU again climbs to a high level.

## Data Collection

The first thing you should do when you encounter high CPU is to determine the process that is consuming CPU. You can use Processes tab in Task Manager to do this. Make sure that you check the **Show processes from all users** checkbox. Figure 1 shows this box checked and shows the w3wp.exe process (the process that hosts an IIS application pool) consuming a high level of CPU.

![Screenshot shows Windows Task Manager. Under the C P U column, 85 is highlighted on the w 3 w p executable row. Show processes from all users is selected.](troubleshooting-high-cpu-in-an-iis-7x-application-pool/_static/image1.png)

Figure 1 - Task Manager showing high CPU.

You can also use Performance Monitor to determine what process is using CPU. For more information on using Performance Monitor, see Analyzing Performance Data later in this troubleshooter.

> [!TIP]
> If you need to identify which application pool is associated with a particular w3wp.exe process, open an Administrative Command Prompt, switch into the `%windir%\System32\inetsrv` folder `cd %windir%\System32\inetsrv` and run appcmd list wp. This will show the process identifier (PID) of the w3wp.exe process in quotes. You can match that PID with the PID available in Task Manager.

Once you have confirmed that a w3wp.exe process is experiencing high CPU, you will need to collect two pieces of information in order to determine what is causing the problem.

- A Performance Monitor data collector set.
- A user-mode memory dump of the w3wp.exe process.

Both of these will need to be collected during the high CPU event.

**Collecting a Performance Monitor Data Collector Set**

Performance Monitor (Perfmon) data is often critical in determining the cause of high CPU issues. It can also be extremely helpful in getting a "big picture" view of how your application performs.

Perfmon data can be viewed in real-time or it can be collected in a data collector set that can be reviewed later. For troubleshooting a high CPU issue, we need to collect a data collector set. To create a data collector set for troubleshooting high CPU, follow these steps.

1. Open Administrative Tools from the Windows Control Panel.
2. Double-click on Performance Monitor.
3. Expand the Data Collector Sets node.
4. Right-click on User Defined and select New, Data Collector Set.
5. Enter High CPU as the name of the data collector set.
6. Select the Create Manually (Advanced) radio button.
7. Click Next.
8. Select the Create Data Logs radio button.
9. Check the Performance Counter checkbox.
10. Click Next.
11. Click the Add button.

    If your application is not an ASP.NET application, proceed to step 19.
12. Scroll to the top of the list of counters and select .NET CLR Memory.
13. In the list of instances, select &lt;all instances&gt;.
14. Click the Add button to add the counters to the list of added counters.
15. Select ASP.NET from the list of counters and click Add.
16. Select ASP.NET Applications from the list of counters.
17. Select &lt;all instances&gt;from the list of instances.
18. Click Add.
19. Expand Process from the list of counters. (Make sure you expand Process and not Processor.)
20. Select % Processor Time from the Process object.
21. Select &lt;all instances&gt;from the list of instances.
22. Click Add.
23. Expand Thread from the list of counters.
24. Select % Processor Time from the Thread object.
25. Select &lt;all instances&gt;from the list of instances.
26. Click Add.
27. Select ID Thread from the list of instances.
28. Click Add.

Your dialog should now look like the one shown in Figure 2.

![Screenshot that shows the Data Collection 0 1 Properties dialog box. I D Thread is selected on the Performance Counters tab.](troubleshooting-high-cpu-in-an-iis-7x-application-pool/_static/image3.png)

Figure 2 - Creating a data collector set.

Click the OK button and then the Next button. Make note of where the data collector set is being saved. (You can change this location if you need to.) Then click on Finish.

The data collector set is not yet running. To start it, right-click on High CPU under the User Defined node and select Start from the menu.

**Creating a Debug Diagnostics 1.2 Rule**

The easiest way to collect user-mode process dumps when a high CPU condition occurs is to use Debug Diagnostics 1.2, or DebugDiag. You can download DebugDiag from the following URL.

`https://www.microsoft.com/download/en/details.aspx?id=26798`

Install DebugDiag 1.2 on your server and run it. (You'll find it on the Start menu after installation.) When you run DebugDiag, it will display the Select Rule Type dialog. Follow these steps to create a crash rule for your application pool.

1. Select Performance and click Next.
2. Select Performance Counters and click Next.
3. Click Add Perf Triggers.
4. Expand the Processor (not the Process) object and select % Processor Time. Note that if you are on Windows Server 2008 R2 and you have more than 64 processors, please choose the Processor Information object instead of the Processor object.)
5. In the list of instances, select \_Total.
6. Click Add and then click OK.
7. Select the newly added trigger and click Edit Thresholds as shown in Figure 3.
8. Select Above in the dropdown.
9. Change the threshold to 80.
10. Enter 20 for the number of seconds. (You can adjust this value if needed, but be careful not to specify a small number of seconds in order to prevent false triggers.)
11. Click OK.
12. Click Next.
13. Click Add Dump Target.
14. Select Web Application Pool from the dropdown.
15. Select your application pool from the list of app pools.
16. Click OK.
17. Click Next.
18. Click Next again.
19. Enter a name for your rule if you wish and make note of the location where the dumps will be saved. You can change this location if desired.
20. Click Next.
21. Select Activate the Rule Now and click Finish.

> [!TIP]
> You can create dumps of multiple application pools by adding multiple dump targets using the same technique used in steps 13-15.

![Screenshot that shows the Select Performance Counters dialog box.](troubleshooting-high-cpu-in-an-iis-7x-application-pool/_static/image5.png)

Figure 3 - Adding perf triggers in DebugDiag.

This rule will create 11 dump files. The first 10 will be "mini dumps" which will be fairly small in size. The final dump will be a dump with full memory, and that dumps will be much larger.

Once the high CPU problem has occurred, you will want to stop the Perfmon data collector set from collecting data. To do that, right-click on the High CPU data collector set listed under the User Defined node and select Stop.

## Data Analysis

After the high CPU event, you will have two sets of data to review; the Perfmon data collector set and the memory dumps. Let's begin by reviewing the Perfmon data.

**Analyzing Performance Data**

To review the Perfmon data for your issue, right-click on the High CPU data collector set listed under the User Defined node and select Latest Report. You'll see something similar to the screen shown in Figure 4.

![Screenshot that shows the Performance Monitor window.](troubleshooting-high-cpu-in-an-iis-7x-application-pool/_static/image7.png)

Figure 4 - Perfmon displaying the High CPU data.

The first thing to do is remove all of the current counters so that you can add explicit ones that you want to review. Select the first counter in the list. Then scroll to the bottom of the list and click on the last counter while holding the Shift key on your keyboard. Once you've selected all counters, press Delete on your keyboard to remove them.

Now add the Process / % Processor Time counter using these steps.

1. Right-click anywhere in the right pane of Perfmon and select Add Counters.
2. Expand the Process object.
3. Select % Processor Time from the list.
4. Select &lt;all instances&gt;from the instance list.
5. Click Add.
6. Click OK.

You will now have a display that shows a graph of processor time used by each process on the computer during the time that the data collector set was running. The easiest way to isolate which process was using the highest level of CPU is to enable the highlight feature of Perfmon.

To do that, select the first counter in the list and then press Ctrl+H. After you've done this, the selected process will show as a bolded black line on the graph.

Use the down arrow on your keyboard to move down through the list of processes until you find the process that shows the most CPU usage. In Figure 5, you can clearly see that the w3wp.exe process was using a large amount of CPU on the machine. This confirms that the IIS application pool is causing high CPU utilization on the computer.

![Screenshot that shows the Performance Monitor window. Perfmon shows the C P U usage of the w 3 w p executable.](troubleshooting-high-cpu-in-an-iis-7x-application-pool/_static/image9.png)

Figure 5 - Perfmon showing CPU usage of w3wp.exe.

> [!TIP]
> Perfmon can be very useful in determining performance problems in your application. The data collected in the Perfmon log can show you how many requests are executing (using the ASP.NET and ASP.NET Applications objects) and can also show you other important performance data about how your application is performing.

To get to the root of what is causing the high CPU problem, let's review the dumps that were created using DebugDiag.

**Dump Analysis with DebugDiag**

DebugDiag has the ability to recognize many problems by doing an automated dump analysis. For this particular issue, DebugDiag's Performance Analyzers are well-suited to helping to identify the root cause of the high CPU issue. To use the analyzer, follow these steps

1. Select the Advanced Analysis tab in DebugDiag.
2. Select the Performance Analyzers.
3. Click Add Data Files.
4. Browser to the location where the dumps were created. By default, this will be a subfolder of the `C:\Program Files\DebugDiag\Logs` folder.
5. Select one of the dumps and then press Ctrl+A to select all of the dumps in that folder.
6. Click Open.
7. Click Start Analysis.

DebugDiag will take a few minutes to parse through the dumps and provide an analysis. When it has completed the analysis, you will see a page similar to that shown in Figure 6.

![Screenshot that shows Internet Explorer. The Debug Diag analysis report page is displayed.](troubleshooting-high-cpu-in-an-iis-7x-application-pool/_static/image11.png)

Figure 6 - A DebugDiag analysis report.

Notice that the top of the report tells you that high CPU was detected. In the right column, you'll see recommendations which include a link to the top 7 threads by average CPU time. Click that link and you'll see information about what those top CPU consumers were doing. Figure 7 shows what those threads are doing in my application.

![Screenshot that shows the Functions Stats page in a browser.](troubleshooting-high-cpu-in-an-iis-7x-application-pool/_static/image13.png)

Figure 7 - Details on high CPU threads.

I can tell from this analysis that the default.aspx page in the FastApp application is running. If I look further down the call stack (at the bottom of the page), I can see that this thread is doing string concatenation. (Notice the call to System.String.Concat on the call stack.) If I analyze the other top CPU threads, I see the same pattern.

The next step is to review the Page\_Load event in the default.aspx page of the FastApp application. When I do that, I find the following code.

[!code-html[Main](troubleshooting-high-cpu-in-an-iis-7x-application-pool/samples/sample1.html)]

This kind of code will definitely cause high CPU. See `https://support.microsoft.com/kb/307340` in the Microsoft Knowledge Base for more information.

## Conclusion

By using Perfmon and DebugDiag, you can easily collect data that can be helpful in determining the cause of high CPU in application pools. If you are unable to find the root cause using these techniques, you can open a support ticket with Microsoft via [https://support.microsoft.com/](https://support.microsoft.com/) and we can assist you with determining the cause of your issue. By having the Perfmon data and dumps ready for us when you open a case, you will dramatically reduce the amount of time necessary for us to assist you.

### Other Resources

- [Troubleshooting High CPU Utilization](https://technet.microsoft.com/library/bb742546.aspx)
- [Troubleshooting High CPU Performance Issues](https://blogs.msdn.com/b/mike/archive/2007/12/06/troubleshooting-high-cpu-performance-issues.aspx)
- [What to Gather to Troubleshoot High CPU or Hang](https://blogs.msdn.com/b/tom/archive/2008/05/02/8450990.aspx)
- [.NET Debugging Demos](https://blogs.msdn.com/b/tess/archive/2008/02/04/net-debugging-demos-information-and-setup-instructions.aspx)
- [IIS Worker Process Performance Monitoring Tips](https://blogs.msdn.com/b/lexli/archive/2010/02/26/iis-worker-process-performance-monitoring-tips.aspx)
