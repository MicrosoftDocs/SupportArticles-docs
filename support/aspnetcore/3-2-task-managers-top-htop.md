---
title: Use top, htop command to monitor processes
description: This article describes how to use top and htop command line tools to monitor processes.
ms.prod: aspnet-core
ms.reviewer: ramakoni
---
# Part 3.2 - Linux task managers, top, and htop

_Applies to:_ &nbsp; .NET Core 2.1, .NET Core 3.1  

This article introduces how to use `top` and `htop` command line tools to monitor processes.

## Prerequisites

As in the [previous parts](2-1-create-configure-aspnet-core-applications.md), this part is structured to put more emphasis on the theory and principals to follow when you start to troubleshoot. It does not have any prerequisites. However, you should have following items already set up if you followed all the steps of this training so far:

- Nginx has two websites:
  - The first website listens for requests by using the **myfirstwebsite** host header (`http://myfirstwebsite`), and routes the requests to the demo ASP.NET Core application that is listening on port 5000.
  - The second website listens for requests by using the **buggyamb** (`http://buggyamb`) host header, and routes the requests to the second ASP.NET Core sample buggy application that is listening on port 5001.
- Both ASP.NET Core applications are running as services that restart automatically when the server is rebooted, or the applications stops responding or fails.
- A Linux local firewall is enabled and configured to allow SSH and HTTP traffic.

## Goal of this part

When you troubleshoot a performance problem, you might have to monitor the CPU and memory usage of a process to understand how its resource consumption evolves over time. In Windows, you can use Task Manager to do this. Linux has several tools that aim to achieve the same thing.

This part will examine the `top` and `htop` command line tools to monitor processes.

## top

To open the Task Manager equivalent in Linux, run the `top` command.

:::image type="content" source="./media/3-2-task-managers-top-htop/top.png" alt-text="BuggyAmb top" border="true":::

In this example, you can observe in the first listed process for PID 19933 that the process exhibits high CPU usage, and memory usage is also high.

### Selecting and deselecting columns

To add or remove columns in the view that the `top` tool provides, press the F key while you run the tool. The columns that are marked by an asterisk (*) are the ones that are selected for display. Use the arrow keys to move through the available columns, and use the Spacebar to select or deselect the columns. Then, press Esc to exit.

:::image type="content" source="./media/3-2-task-managers-top-htop/columns.png" alt-text="BuggyAmb columns" border="true":::

The changes will be saved for your user account. The next time that you run `top`, you will see the columns that you selected.

### Filtering the output by users

To be able to target problematic resource consumption scenarios, it's important to know how to filter the `top` output. One of the most common methods to do this is to filter processes by username. You can press U, and then type the username. The following screenshot shows the `top` tool filtering the available process snapshots for the www-data user.

:::image type="content" source="./media/3-2-task-managers-top-htop/users.png" alt-text="BuggyAmb users" border="true":::

When you press Enter, you will see the processes that are run by the given user (the www-data user in this example).

:::image type="content" source="./media/3-2-task-managers-top-htop/user.png" alt-text="BuggyAmb user" border="true":::

When you inspecting the output of the filtered `top` view, you can see that two of the processes are .NET processes. These are the processes that run the two ASP.NET Core applications, while the other two processes belong to Nginx.

You can use filters when you run `top` command directly. For example, if you run the `top -u www-data` command, it will yield the same output as you would get if you were to open the `top` tool and press U to filter by user.

### Removing idle processes

Press I or run the `top -i` command to filter the `top` output to show only the processes that are consuming CPU. The following screenshot shows the output of `top -i -u www-data` command. Notice that the `top` output hides the idle processes even though there are four processes that were started by using the www-data user account. Only the process that has PID=19933 consumes CPU.

:::image type="content" source="./media/3-2-task-managers-top-htop/remove.png" alt-text="BuggyAmb remove" border="true":::

Press I again to toggle the switch and show the idle processes, too.

### Killing processes

To kill or terminate a process, you have to send a kill signal to the process. You might recall that we used the `sudo kill -9 <PID>` command earlier to kill a process. You can also kill processes by using `top`. Press K to kill a process while `top` is running, and then type the PID of the process that you want to kill.

:::image type="content" source="./media/3-2-task-managers-top-htop/kill1.png" alt-text="BuggyAmb kill1" border="true":::

After you press Enter, `top` asks for the signal type. Press Enter one more time to send the terminate signal (`15/sigterm`).

:::image type="content" source="./media/3-2-task-managers-top-htop/kill2.png" alt-text="BuggyAmb kill2" border="true":::

After a few seconds, you will see that the process for PID 122632 is missing from the listing. Remember that in the listings, the "122632" process corresponds to the BuggyAmb ASP.NET Core application. Because it was configured to start automatically, you will see that a new .NET process that has a new PID starts after the shutdown.

## htop

[Htop](https://htop.dev/) is a process viewer and a text mode application for system monitoring in real-time, similar to `top`. It's easy to use, and it displays a complete list of the processes that are running.

The `htop` tool is pre-installed in the distribution of Ubuntu Linux that is used to install the virtual server for this course. If `htop` is not installed in your Linux distro, you can use the package managers in Linux to install it. (See Part 1.3 for details.)

To start the tool, simply run the `htop` command. You will see a colorful output that resembles the following.

:::image type="content" source="./media/3-2-task-managers-top-htop/htop.png" alt-text="BuggyAmb htop" border="true":::

> [!NOTE]
> The bottom line indicates the function keys that you can use. Press F6 key to sort by different options, use the arrow keys to select the `PERCENT_MEM` column, and then press Enter. This sorts the processes by memory usage.

:::image type="content" source="./media/3-2-task-managers-top-htop/mem.png" alt-text="BuggyAmb mem" border="true":::

As with the `top` command, you can use keyboard shortcuts for several functions. For example, press U to select the username from a list.

:::image type="content" source="./media/3-2-task-managers-top-htop/username.png" alt-text="BuggyAmb username" border="true":::

However, there is something confusing in the `htop` output. Based on the output of the last examples, you should expect to see four processes for www-data user. However, we see that there are many more entries. What could be causing this?

The difference in the output occurs because `htop` shows both processes and their threads by default. Unless you want to see the threads, we recommend that you always disable thread view to make the output clearer. To disable thread view and see only the processes, press Shift+H. The following screenshot shows the processes without threads.

:::image type="content" source="./media/3-2-task-managers-top-htop/process.png" alt-text="BuggyAmb process" border="true":::

If you have to kill a process, select the process by using the arrow keys, press F9, and then press Enter to send the "terminate" signal.

:::image type="content" source="./media/3-2-task-managers-top-htop/terminate.png" alt-text="BuggyAmb terminate" border="true":::

This succinct overview should allow you to understand which processes are running and consuming resources on your system. To exit `htop`, press either F10 or Ctrl+C.

## Next steps

[Part 3.3 - Debuggers, core dumps, and collecting core dumps](3-3-debuggers-collect-core-dumps.md)

The next part of this series ("Getting ready for troubleshooting") discusses debuggers and dump files.
