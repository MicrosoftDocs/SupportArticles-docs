**Part 3.2 - Linux task managers, top and htop\
**

**Prerequisites**

 

Like the chapter that preceded it, this part is structured to place more
emphasis on the theory and principals to follow when starting to
troubleshoot. It does not have any prerequisites, but you should have
following set up at the moment if you followed all the steps of this
training so far:

 

-   Nginx has two web sites:

    -   The first web site listening for requests with the
        > **myfirstwebsite** host header
        > ([[http://myfirstwebsite]{.ul}](http://myfirstwebsite)) and
        > routing the requests to the demo ASP.NET Core application
        > which is listening on port 5000.

    -   The second web site listening for requests with host header
        > **buggyamb** ([[http://buggyamb]{.ul}](http://buggyamb)) and
        > routing the requests to the second ASP.NET Core sample buggy
        > application which is listening on port 5001.

-   Both ASP.NET Core applications should be running as services which
    > restart automatically when the server is rebooted, or the
    > applications stops or crashes.

-   Linux local firewall is enabled and configured to allow SSH and HTTP
    > traffic.

 

**Goal of this part**

 

When troubleshooting a performance problem, you may need to monitor the
CPU and memory usage of a process to understand how its resource
consumption evolves over time. The \"task manager\" in Windows can be
used for such a purpose and there are several tools in Linux which aim
at achieving the same thing.

 

This part will examine the **top** and **htop** command line utilities
to monitor processes.

 

**top**

 

You can run the **top** command to open the \"task manager\" equivalent
in Linux:\
 

![](media/image1.png){width="6.268055555555556in"
height="1.8736111111111111in"}

 

In the example above, inspecting the first listed process with PID
19933, you can observe that the process is exhibiting a very high CPU
usage and the memory usage is also high.

 

**Selecting / deselecting columns**

 

To add or remove columns to the view that the top utility provides you
can hit **f** key while running the tool. The columns marked with \* are
the ones selected for display. Use the arrow keys to move through the
available columns and use the **space** bar to select or deselect the
columns and then hit **esc** to exit:

 

![](media/image2.png){width="6.268055555555556in"
height="2.495833333333333in"}

 

The changes will be saved for your user account and the next time you
run top, you will see the columns you have selected.

 

**Filtering the output by users**

 

To be able to target problematic resource consumption scenarios, it is
important to know how to filter the top output. One of the most common
way is to filter processes by username. You can hit **u** and type the
username. The below screenshot shows the top tool filtering through the
available processes' snapshots for the www-data user:

 

![](media/image3.png){width="6.268055555555556in"
height="1.1493055555555556in"}

 

When you hit enter, you will see the processes that is run by the given
user, the www-data user in the above sample:

 

![](media/image4.png){width="6.268055555555556in"
height="1.676388888888889in"}

 

When inspecting the output of the filtered top view, two of the
processes are dotnet processes - those are the processes running the two
ASP.NET Core applications, while the other two processes belong to
Nginx.

 

You can use filters when running top command directly. For example, if
you run the **top -u www-data** command then it will yield the same
output as with opening the top tool and hitting u to filter by user.

 

**Removing idle processes**

 

Hitting **i** key or running the **top -i** command will filter the top
output to only show the processes that are consuming CPU. The following
shows the output of **top -i -u www-data** command. The below screenshot
shows that the **top** output hides the idle processes although there
are four processes which were started using the www-data user account.
Only the process with PID=19933 consumes CPU in the following
screenshot:

 

![](media/image5.png){width="6.268055555555556in"
height="1.5243055555555556in"}

 

Hitting i key again will toggle the switch and show the idle processes
as well.

 

**Killing processes**

 

To kill / terminate a process you need to send a kill signal to the
process. You may remember that we used the **sudo kill -9 \<PID\>**
command before to kill a process. You can also kill processes using
**top**. Hit **k** to kill a process when top is running and then we
type the PID of the process that you wish to kill:

 

![](media/image6.png){width="6.268055555555556in"
height="1.6958333333333333in"}

 

After you hit enter, top asks for the signal type. Hit enter once again
to send the terminate signal (15/sigterm):

 

![](media/image7.png){width="6.268055555555556in"
height="1.6958333333333333in"}

 

After a few seconds you will see that the process with PID 122632 has
disappeared from the listing. Remember that in the listings above, the
process 122632 was the process corresponding to the BuggyAmb ASP.net
Core Application and since it was configured to start automatically you
will see a new dotnet process with a new PID starting up following the
shutdown.

 

**htop**

[[htop]{.ul}](https://hisham.hm/htop/) is a process viewer and a text
mode application for system monitoring in real-time like top. htop
displays a complete list of the processes that are running and is very
easy to use.

 

**htop** came as pre-installed in the distribution of Ubuntu Linux used
to install the virtual server for this course. If **htop** is not
installed in your Linux distro then you can use the package managers in
Linux to install it (see previous section 1.3 for details)

 

Simply run **htop** command to start it. You will see a colorful output
like the below:

 

![](media/image8.png){width="6.268055555555556in"
height="3.810416666666667in"}

 

Notice the bottom line which indicates that you can make use of function
keys. Press the **F6** key to sort by different options and use the
arrow keys to select the PERCENT_MEM column and hit enter. This will
result in having the processes sorted by memory usage:

 

![](media/image9.png){width="6.268055555555556in"
height="2.6354166666666665in"}

 

As with the top command, you can use keyboard shortcuts for several
functions. Hit **u** and choose the username from list:

 

![](media/image10.png){width="6.268055555555556in"
height="2.6034722222222224in"}

 

However, there is something confusing in the **htop** output. Based on
the output of the last examples, you should be expecting four process
for www-data user, but we see that there are many more entries. What
could be causing this?

 

The difference in output is because **htop** shows both processes [and
their threads]{.ul} by default. Unless we want to see the threads, it is
recommended you always prefer disabling thread view because the output
will be much clearer. To disable thread view and see just the processes,
you can just hit **H** (not **h** but **shift + h**). The following is a
screenshot just showing the processes but not threads:

 

![](media/image11.png){width="6.268055555555556in"
height="1.8541666666666667in"}

 

Should you need to kill a process, select the process using the arrow
keys and hit F9 to send the terminate signal by hitting enter:

 

![](media/image12.png){width="6.268055555555556in"
height="3.810416666666667in"}

 

This succinct overview should allow you to understand what processes are
running and consuming resources on your system. To exit **htop**, either
hit **F10** or use **Ctrl-c** shortcut.

 

The next part of this chapter (\"getting ready for troubleshooting\")
will discuss debuggers and dump files.
