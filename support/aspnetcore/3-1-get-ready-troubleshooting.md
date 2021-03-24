**Part 3.1 - Getting ready for troubleshooting - is everything in Linux
a file? Is a process really a file?**

**Prerequisites**

 

This part is structured to place more emphasis on the theory and
principals to follow when starting to troubleshoot. It does not have any
prerequisites, but you should have following set up at the moment if you
followed all the steps of this training so far:

 

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
    > restart automatically when the server is rebooted or the
    > applications stops or crashes.

-   Linux local firewall is enabled and configured to allow SSH and HTTP
    > traffic.

 

**Goal of this part**

 

As you are preparing to troubleshoot potential issues you will run into
with the configuration above, this part will help you consider the
troubleshooting process as a whole.

 

**Is a everything in Linux a file?**

 

You may heard the phrase \"everything in Linux is file\" before. Is this
really the case? Although this article series does not focus on Linux
expertise, the Linux operating system is heavily geared towards exposing
everything through the file system. In the following paragraphs we will
try to delve deeper into why this is.

 

According to [[Wikipedia]{.ul}](https://en.wikipedia.org/wiki/Procfs),
Linux is based on a special file system called **procfs**.

 

> The **proc filesystem** (**procfs**) is a special filesystem
> in [[Unix-like]{.ul}](https://en.wikipedia.org/wiki/Unix-like) operating
> systems that presents information
> about [[processes]{.ul}](https://en.wikipedia.org/wiki/Process_(computing)) and
> other system information in a hierarchical file-like structure,
> providing a more convenient and standardized method for dynamically
> accessing process data held in the kernel than
> traditional [[tracing]{.ul}](https://en.wikipedia.org/wiki/Tracing_(software)) methods
> or direct access
> to [[kernel]{.ul}](https://en.wikipedia.org/wiki/Kernel_(computing)) memory.
> Typically, it is mapped to a [[mount
> point]{.ul}](https://en.wikipedia.org/wiki/Mount_point) named /proc at
> boot time. The proc file system acts as an interface to internal data
> structures in the kernel. It can be used to obtain information about
> the system and to change certain kernel parameters at runtime
> ([[sysctl]{.ul}](https://en.wikipedia.org/wiki/Sysctl)).

 

Hence, if you are a superuser on a Linux machine, you can access
information about each of the executing processes through a file system
file. If [[everything in Linux is a
file]{.ul}](https://en.wikipedia.org/wiki/Everything_is_a_file), so is a
process.

 

You may remember that we briefly discussed about this in previous parts
of this series: a process is seen as a file under **/proc/** directory.
This directory is defined as a special directory
[[here]{.ul}](https://www.linux.com/news/discover-possibilities-proc-directory/):

 

> *This special directory holds all the details about your Linux system,
> including its kernel, processes, and configuration parameters.*

 

If you examine this directory with the **ll /proc/** command you will
see several \"files\" and \"folders\". For example you will see a
\"file\" called /proc/**meminfo** which, if you run the **cat
/proc/meminfo** command will yield detailed information about the
server\'s memory usage statistics:

 

![](media/image1.png){width="6.268055555555556in"
height="1.1555555555555554in"}

 

Similarly, if you run the **cat /proc/cpuinfo** you will see server
processor information:

 

![](media/image2.png){width="6.268055555555556in"
height="1.0416666666666667in"}

 

If you want to get Linux OS version information, you can use **cat
/proc/version** commands:

 

![](media/image3.png){width="6.268055555555556in"
height="0.8131944444444444in"}

 

And so on...

 

**Is a process really a file?**

 

Regarding the processes, each running process on your Linux system will
be shown as a sub-directory under /proc/ folder and each folder is named
as the process ID:

 

![](media/image4.png){width="6.268055555555556in"
height="3.2194444444444446in"}

 

If you examine one of the process ID directories you will see some other
files and folders. You need to prefix the command with \"sudo\" to get
some of the information that is displayed below:

 

![](media/image5.png){width="6.268055555555556in"
height="1.5555555555555556in"}

 

Let\'s examine the **cmdline** for one of the processes. Run the **sudo
cat /proc/19933/cmdline** command - the PID for the process you will
choose will be different - and here is the output. This is the BuggyAmb
application that was installed and configured in Chapter 2:

 

![](media/image6.png){width="6.268055555555556in"
height="0.6097222222222223in"}

 

Finally let\'s look at the environment variables for the BuggyAmb
process by running the **sudo cat /proc/19933/environ** command. In a
previous module you were instructed to use the ASPNETCORE_URLS
environment variable. This was created to instruct the web-application
to listen on port 5001:

 

![](media/image7.png){width="6.268055555555556in"
height="0.9465277777777777in"}

 

Using this technique, you can get a lot of information about a process
using this file system.

 

**The ps command**

 

This article will not go into explaining this command, but it deserves
to be mentioned here when talking about processes because it is one of
the simplest ways to generate a snapshot of the current processes. I
recommend you open the \'man\' page with the **man ps** command and try
it for yourself.

 

This should be enough guidance about how to get information about
running processes on Linux. Next the series will take a look at some
important tools and commands that can be used when troubleshooting
problems.
