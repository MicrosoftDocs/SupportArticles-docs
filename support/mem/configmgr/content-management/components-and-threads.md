---
title: Understand components and threads
description: Helps administrators understand components and threads for content distribution.
ms.date: 12/05/2023
ms.reviewer: kaushika
---
# Components and threads for content distribution

This article helps you understand components and threads for content distribution.

_Original product version:_ &nbsp; Configuration Manager current branch, Microsoft System Center 2012 Configuration Manager, Microsoft System Center 2012 R2 Configuration Manager

## The components used for content distribution

Here's a quick list of the primary components used for content distribution:

| Name | Component name | Friendly name | Description |
| --- | --- | --- | --- |
| Distribution Manager | SMS_DISTRIBUTION_MANAGER | DistMgr | Manages content and creates jobs for PkgXferMgr |
| Package Transfer Manager | SMS_PACKAGE_TRANSFER_MANAGER | PkgXferMgr | Transfers packages to distribution points |
| Hierarchy Manager | SMS_HIERARCHY_MANAGER | Hman | Processes and replicates changes to the site hierarchy |
| Sender | SMS_SENDER | Sender | Initiates inter-site communications across TCP/IP networks |
| Despooler | SMS_DESPOOLER | Despooler | Processes incoming replication files from parent or child sites |
| Scheduler | SMS_SCHEDULER | Scheduler|Creates sender jobs |
| Database Notification Monitor | SMS_DATABASE_NOTIFICATION_MONITOR | SmsDbMon | Watches the database for changes to certain tables and creates files in the inboxes of components responsible for processing those changes |
| SMS Provider | SMS Provider | SMSProv|Windows Management Instrumentation (WMI) Provider that assigns read and write access to the Configuration Manager database at a site |
| SMS DP Provider | SMS DP Provider | SMSDPProv | Windows Management Instrumentation (WMI) Provider that manages Content Library operations on the DP |
| SMS Agent Host | SMS Agent Host|CcmExec | SMS Agent Host is the Configuration Manager client agent service that also hosts server-side components such as Management Point and Pull Distribution Point |
| Data Transfer Service | DataTransferService | DTS | Data Transfer Service is a component of CcmExec responsible for download files via BITS. |

## Distribution Manager (DistMgr) threads

Distribution Manager (DistMgr) performs a variety of operations to distribute content to the distribution points (DPs). These operations are handled by the different types of threads, and the diagram below explains the DistMgr thread hierarchy for the default thread configuration:

:::image type="content" source="media/components-and-threads/distmgr-thread-hierarchy.png" alt-text="Diagram shows the Distribution Manager thread hierarchy." lightbox="media/components-and-threads/distmgr-thread-hierarchy.png":::

- **Main DistMgr thread**

  Log entry for identification: `SMS_EXECUTIVE started SMS_DISTRIBUTION_MANAGER as thread ID 3648 (0xE40)`

  This thread is started by `SMS_Executive` on service startup. The main DistMgr thread starts the replication processing, DP Manager, content cleanup, DP certificate monitoring, content library move, IIS config change processing, DP reassignment and upgrade processing threads when it starts. It also starts package processing threads on-demand when a package change occurs

  In addition to managing these threads, this thread also handles changes to the Site Control File and updates DP settings (configure DP/PXE, update registry settings, create monitoring/usage tasks on the DP, and so on).

- **Replication processing thread**

  Log entry for identification: `Starting thread for processing replication, thread ID = 0x1A14 (6676)`

  This thread is started by the main DistMgr thread and processes the following files in the `DistMgr.box\incoming` directory:

  | File | Description |
  | --- | --- |
  |.STA|Updates package status in the `PkgStatus` table in the database.|
  |.FWD|Forwards the specified package to the specified destination site by creating a mini-job to send the package.|
  |.DMD|Distributes on-demand requests. Targets the specified package to the specified DP.|
  |.PUL|Updates pull DP package response in the `PullDPResponse` table in the DB.|
  
  > [!NOTE]
  > This thread is single-threaded and doesn't create more threads to process any of these files.

- **DP Manager thread**

  Log entry for identification: `Starting the DP Manager thread, thread ID = 0x5D8 (1496)`

  This thread is started by the main DistMgr thread and processes removal of DPs when detecting a Site Control File change. When an appropriate Site Control File change occurs, SMSDBMON drops a DPN (DP Notification) file in `DistMgr.box` that's processed by this thread.

  DPN files are used to notify a DP change, which involves DP removal (detected by Action = 3 in the `DistributionPoints` table).

  > [!NOTE]
  > This thread is single-threaded and doesn't create more threads to perform work.

- **Content cleanup thread**

  Log entry for identification: `Starting the content cleanup thread, thread ID = 0x1604 (5636)`

  This thread is started by the main DistMgr thread, and runs content cleanup. It determines if content cleanup is required by detecting orphaned content from the database. This thread uses default batch size of 50 for the number of contents it can instruct a remote DP to delete at a time. However, this value can be overridden by setting the following registry key:

  `SMS\Components\SMS_DISTRIBUTION_MANAGER\RemoteContentCleanupBatchSize`
  
  DWORD value can be between **1** and **500**.

  > [!NOTE]
  > Do not change this value without consulting Microsoft support professional. This thread is single-threaded and doesn't create more threads to perform work.

- **DP certificate monitoring thread**

  Log Entry for identification: `Starting the DP cert monitoring thread, thread ID = 0x7290 (29328)`

  This thread is started by the main DistMgr thread. This thread processes *.CER* files and configures the certificate binding in IIS when enhanced HTTP mode is enabled. This mode requires use of Configuration Manager generated certificates in IIS.

  > [!NOTE]
  > This thread is single-threaded and doesn't create more threads to perform work.

- **Content library move thread**

  Log Entry for identification: `Starting the content library move thread, thread ID = 0x11D6C (73068)`

  This thread is started by the main DistMgr thread, and moves content library to the new location after a *.CML* file is dropped in `DistMgr.box`.

  > [!NOTE]
  > This thread is single-threaded and doesn't create more threads to perform work.

- **IIS config change processing thread**

  Log Entry for identification: `Starting the IIS config change processing thread, thread ID = 0x408C (16524)`

  This thread is started by the main DistMgr thread, and handles configuring IIS virtual directories for standard and pull distribution points after IIS files are dropped in `DistMgr.box`. This thread reads the `IISConfigChangeThreadLimit` Site Control File (SCF) property for `SMS_DISTRIBUTION_MANAGER` component to determine the number of threads it can start for performing IIS changes simultaneously. The default value of `IISConfigChangeThreadLimit` SCF Property is **50**, but it can be changed if necessary. However, if this SCF property doesn't exist for some reason, the default value of **50** is used for `IISConfigChangeThreadLimit`.

  > [!NOTE]
  > This thread does create more threads to perform DP IIS config changes. Each worker thread handles configuration of IIS virtual directories of a specific DP.

- **DP reassignment thread**

  Log Entry for identification: `Starting the shared DP reassignment thread, thread ID = 0x9C0C (39948)`

  This thread is started by the main DistMgr thread, and handles DP reassignments for standard and pull distribution points when a *.DPU* file is dropped in `DistMgr.box`. This thread reads the `SharedDPImportThreadLimit` Site Control File (SCF) property for `SMS_DISTRIBUTION_MANAGER` component to determine the number of threads it can start for performing DP reassignments simultaneously. The default value of `SharedDPImportThreadLimit` SCF Property is **50**, but it can be changed if necessary. However, if this SCF property doesn't exist for some reason, the default value of **50** is used for `SharedDPImportThreadLimit`.

  > [!NOTE]
  > This thread does create more threads to perform DP reassignments. Each worker thread handles reassignment of a specific DP.

- **Upgrade processing thread**

  Log entry for identification: `Starting the DP upgrade processing thread, thread ID = 0x1968 (6504)`

  This thread is started by the main DistMgr thread, and handles DP installations and upgrades for standard and pull distribution points. It calls `spGetDPsForUpgrade` to get a list of DPs that need to be upgraded. This thread reads the `DPUpgradeThreadLimit` Site Control File (SCF) property for `SMS_DISTRIBUTION_MANAGER` component to determine the number of threads it can start for performing DP Installations/Upgrades simultaneously. The default value of `DPUpgradeThreadLimit` SCF Property is **50**, but it can be changed if necessary. However, if this SCF property doesn't exist for some reason, the default value of **5** is used for `DPUpgradeThreadLimit`.

  > [!NOTE]
  > This thread does create more threads to perform DP installation/upgrade work. Each worker thread handles installation/upgrade of a specific DP.

- **Package processing thread**

  Log entry for identification: `Started package processing thread for package 'PKGID', thread ID = 0x8E8 (2280)`

  These threads are started by the main DistMgr thread. The number of package processing threads is determined by the **Maximum number of packages** thread setting in the **Software Distribution Component Configuration** properties. Each package processing thread performs the hashing of the package content and creates a compressed copy of the content.

  > [!NOTE]
  > Although all package processing threads run simultaneously, they are responsible for hashing and compressing package source. There is a Critical Section around the compression, meaning only one thread can be compressing content at a time. If a bunch of new, large packages are created and distributed, the per-package threads can block in a chain waiting for their turn to get the compression lock.

  Depending on the package actions (add/update/delete), each package processing thread also creates:

  - DP threads to create a Package Transfer Manager job for adding/updating content on a DP.
  - DP threads to instruct a remote distribution point to remove content from the content library.

  The number of DP threads each package processing thread can create is determined by the **Maximum threads per package** setting in the **Software Distribution Component Configuration** properties.

  > [!NOTE]
  > Package processing threads are multi-threaded and each package processing thread creates more threads to perform work. Each worker thread handles add/update/remove operations for the DPs.  

## Distribution Manager thread configuration

All Configuration Manager sites (including the central administration site) allow configuring the number of threads that can be used for distributing content to the distribution points (DPs). This configuration is specific to each site and can be accessed by right-clicking the site under the **Sites** node and selecting **Configure Site Components** > **Software Distribution**. Here's a look at the default configuration:

:::image type="content" source="media/components-and-threads/software-distribution.png" alt-text="Screenshot of the Software Distribution Component Properties window." border="false":::

In most cases, you would only be concerned with the **Maximum number of packages** and **Maximum threads per package** settings.

- **Maximum number of packages**: Specifies the maximum number of packages that ConfigMgr can send to the DPs simultaneously. The specified value should be between **1** and **50**.
- **Maximum threads per package**: Specifies the maximum number of threads assigned to each package during distribution. Specified value should be between **1** and **999**.

The default configuration of **Maximum number of packages=3** and **Maximum threads per package=5** can also be referred to **3x5**. This is how the thread configuration will be often denoted in the workflow.

### What this really means

#### Effect on Distribution Manager (DistMgr)

With the default thread configuration of **3x5**, DistMgr can simultaneously process three packages and use up to five threads for each package, allowing it to use up to a total of 15 threads to perform work. Here's how this breaks down assuming we have more than three packages that need to get distributed to more than 5 DPs:  

:::image type="content" source="media/components-and-threads/default-thread-configuration.png" alt-text="Diagram shows how DistMgr process three packages at the same time when Thread Configuration = 3x5." lightbox="media/components-and-threads/default-thread-configuration.png":::

To process each individual package, a package processing thread is spawned by the main DistMgr thread. This package processing thread uses one out of three package processing slots from the **Maximum number of packages** setting. There is a unique package processing thread per package - DistMgr does not start multiple package processing threads for the same package. This means that three unique packages will utilize three unique package processing threads. Each of these package processing threads can spawn up to five DP threads to distribute the package to five DPs simultaneously.

#### Effect on Package Transfer Manager (PkgXferMgr)

For each PkgXferMgr job created by DistMgr, PkgXferMgr uses one thread. Thread configuration of **3x5** means that the sending capacity for PkgXferMgr is set to **15**, which means that PkgXferMgr can't work on more than 15 jobs simultaneously, limiting it to a maximum of 15 threads.

### How long a thread runs

#### DistMgr threads

The purpose of a DP thread is to create a job for Package Transfer Manager, which then does the actual content copy to the DP. DP threads finish after creating the PkgXferMgr job, and as a result, the lifetime of a DP thread is short. Due to this nature, most of the time there is no need to set up aggressive thread configuration to speed up content distribution. Instead of setting aggressive values, look towards **Choosing the right values** (more information below).

#### PkgXferMgr threads

For standard DPs, since PkgXferMgr threads perform the real work of sending the content, the lifetime of these threads depends on the size of the packages. For larger packages, these threads can take a long time depending on the package size and network speed. While these threads can take a long time to complete, the lifetime of DistMgr threads is much shorter, which means that DistMgr can queue a large number of jobs for PkgXferMgr, creating a backlog of jobs in the queue.

For pull DPs, PkgXferMgr threads notify the pull DP, asking the pull DP to download the content. As a result, the lifetime of PkgXferMgr threads for pull DPs is short. PkgXferMgr does start another thread to perform pull DP polling (based on the configured polling interval) to check on the progress of the job. However, this is also a quick operation and these threads do have a short lifetime as well.

### Choosing the right values

To determine the appropriate values for these settings, you first need to understand the Configuration Manager hierarchy. Let's consider the following hypothetical Configuration Manager environment:

- Central administration site: CS1
- Primary site: PS1
- Number of regular distribution points reporting to PS1: 200
- Total number of packages: 1000

In this environment, the default thread configuration (**3x5**) means that if a new package needs to get distributed to all 200 DPs, we will only process 5 DPs at a time. Once a DP thread exits, another DP thread will then spawn and the process will continue until all the DPs are processed. This process will take some time to loop through all 200 DPs.

To optimize this, we first need to ask a couple of questions:

1. How many packages do you foresee getting added/updated/distributed simultaneously on an average?
2. How many DPs do you have in the site? How is the network configuration between the site server and these DPs?

Assuming the answer to the first question is **5**, and the answer to the second question is **200** with good network connectivity, you could theoretically set **Maximum number of packages** to **5** and **Maximum threads per package** to **200**, allowing Configuration Manager to send up to five packages to all 200 DPs simultaneously. However, this means that when there is more than the average load we can create up to 1000 threads, which is many threads. More threads are usually good, but not always since the work being performed also relies on hardware and network configurations. Too many threads can sometimes cause bottlenecks and slow things down instead of improving them.

The most important thing to remember when configuring these settings is to **find a balance**. For the example above, a reasonable option would be to set the thread configuration to **5x100** (or even **5x50** depending on hardware/network) which still allows Configuration Manager to process up to 100 DPs simultaneously for five different packages. With these settings, the maximum number of threads that can spawn during high load will not exceed 500.

> [!NOTE]
> As a general guideline, it is recommended that the total number of threads not exceeds 750. This means you could set the thread configuration to **3x250**, **5x150**, **10x75** and so on.

In the same hierarchy, you may run into a situation where you are bringing a new DP in the environment and you need to distribute all 1000 packages to the DP. In this case, thread configuration of **5x100** is not going to be effective since we can only process 5 packages at a time, and processing a 1000 packages will take a considerable amount of time. In this scenario, you could choose to either:

- Temporarily set the thread configuration to something like **50x10** that is more suitable for the current requirement, but is not a good option in the long run considering we have 200 DPs.
- Permanently set the thread configuration to something like **20x25** that provides a far better balance and will offer similar performance in a scenario where more packages need to go to handful of DPs as well as a scenario where a handful of packages need to go to many DPs.

> [!IMPORTANT]
> There isn't a set recommendation on values for thread configuration; it varies for each environment and should be set after understanding your environment and requirements. Always remember to **find a balance**!

## Sender thread configuration

Each Configuration Manager site (including the central administration site and secondary sites) has one sender. The sender manages the network connection from one site to a destination site, and can establish connections to multiple sites at the same time. To connect to a site, the sender uses the file replication route to the site to identify the account to use to establish the network connection. The sender also uses this account to write data to the destination site's `SMS_SITE` share.

By default, sender writes data to a destination site by using multiple concurrent threads. Each concurrent thread can transfer a different file-based object to the destination site. By default, when the sender begins to send an object, it continues to write blocks of data for that object until the entire object is sent.

All Configuration Manager sites allow you to configure the number of threads that can be used by the Sender component to send data concurrently to other sites. This configuration is specific to each site, and can be accessed from the **Site Properties** under the **Sites** node by selecting the **Sender** tab. Here's a look at the default configuration:

:::image type="content" source="media/components-and-threads/configmgr-primary-site.png" alt-text="Screenshot shows information under the Sender tab in the ConfigMgr Primary Site Properties window." border="false":::

**All sites**: The maximum number of simultaneous communications allowed for this sender. The default value is **5**. These communications can be destined for different sites or all for the same site, except as restricted by the maximum value specified in **Per site**.

**Per site**: The maximum number of simultaneous communications allowed to any single destination site. The default value is **3**.

> [!NOTE]
> When configuring the total number of concurrent sending threads to be used when communicating with other sites, the total number of sending threads should be configured as a greater number than the threads configured for the per site setting. If the total number of sending threads is equal to the number configured to be used per site and a receiving site is unavailable, it could cause all sending threads to become used when attempting to communicate with the unavailable site and prevent site-to-site communication to other sites.

### What this means

The value specified under **All sites** defines the total number of threads that Sender can use for sending data concurrently to other sites. Out of the total number of threads for **All sites**, you can allot a maximum number of threads under **Per site** that can be used for sending data to any one destination site. By default, each site is configured to use five concurrent threads, with three available for use when sending data to any one destination site. When you increase this number, you can increase the throughput of data between sites by enabling Configuration Manager to transfer more files at the same time. Increasing this number also increases the demand for network bandwidth between sites.

### Choose the right values

To determine appropriate values for these settings, you first need to understand the Configuration Manager hierarchy. Let's consider the following hypothetical Configuration Manager environment:

- Central administration site: CS1
- Primary site: PS1
- Primary site: PS2
- Primary site: PS3
- Primary site: PS4

In this environment, the default Sender thread configuration will allow using a total of 5 threads. Out of those 5 threads, 3 can be used for any one of the 4 destination primary sites. If an administrator sends 3 to all of these sites, it is possible that sender will end up using three threads for one of these sites (let's say PS1), leaving only 2 threads for the remaining sites. Out of the remaining 2 threads, sender may use 1 for PS2 and the other for PS3 utilizing all five allowed threads leaving no room for sending data concurrently to PS4. At this point, Sender will have to wait for one of the existing 5 threads to finish before it can send more data. Once an existing thread finishes, Sender will then be able to use another thread for sending more data to the PS2/PS3/PS4 sites.

It is recommended to set aside 10 threads for each site that Sender will communicate with. In this case, the CS1 site can communicate with four other sites, which means that a **Per site** value of **10** for four sites will require setting the **All sites** value to **40**.

> [!NOTE]
> This is a general recommendation and these values may require further tweaking depending on the number of packages a site needs to send concurrently to other sites.  

## Bandwidth control and threads

In Configuration Manager, you can configure a schedule and set specific throttling settings for remote distribution points as well as for file replication routes for sites. The controls for scheduling and throttling to the remote distribution point are similar to the settings for a standard sender address, but in this case, the settings are used by a component called Package Transfer Manager.

For the Package Transfer Manager component (for *Site Server* - > *DP*), the throttling settings are configured in the properties for a standard distribution point that is not on a site server.

For the Sender component (for *Site Server* <-> *Site Server*), the throttling settings are configured in the properties of the file replication route under **Hierarchy Configuration** > **File Replication**.

> [!NOTE]
> The time settings are based on the time zone from the sending site, not the distribution point.

### Schedule options

To restrict data, select the time period, and then select one of the following settings for availability:

- **Open for all priorities**: Specifies that Configuration Manager sends data to the distribution point with no restrictions.
- **Allow medium and high priority**: Specifies that Configuration Manager sends only medium and high priority data to the distribution point.
- **Allow high priority only**: Specifies that Configuration Manager sends only high priority data to the distribution point.
- **Closed**: Specifies that Configuration Manager does not send any data to the distribution point.

  You can restrict data by priority or close the connection for selected time periods.

### Rate limit options

This is used to configure rate limits to control the network bandwidth that is in use when transferring content to the distribution point. You can choose from the following options:

- **Unlimited when sending to this destination**: Specifies that Configuration Manager sends content to the distribution point with no rate limit restrictions.
- **Pulse mode**: Specifies the size of the data blocks that are sent to the distribution point. You can also specify a time delay between sending each data block. Use this option when you must send data across a low-bandwidth network connection to the distribution point. For example, you might have constraints to send 1 KB of data every five seconds, regardless of the speed of the link or its usage at a given time.
- **Limited to specified maximum transfer rates by hour**: Specify this setting to have a site send data to a distribution point by using only the percentage of time that you configure. When you use this option, Configuration Manager does not identify the networks available bandwidth, but instead divides the time it can send data into slices of time. Then data is sent for a short block of time, which is followed by blocks of time when data is not sent. For example, if the maximum rate is set to 50%, Configuration Manager transmits data for a period of time followed by an equal period of time when no data is sent. The actual size amount of data, or size of the data block, is not managed. Instead, only the amount of time during which data is sent is managed.

For more information on these settings, see [Configuring Content Management in Configuration Manager](/previous-versions/system-center/system-center-2012-R2/gg682115(v=technet.10)?redirectedfrom=MSDN#BKMK_ModifyDistributionPointSettings).

### How this affects Sender and PkgXferMgr threads

When bandwidth control is enabled for a site, the sender component will ignore the Sender thread configuration for the site and will only use one thread for that site. Similarly, when bandwidth control is enabled for a DP, PkgXferMgr will ignore the thread configuration and will only use one thread for the DP.

> [!NOTE]
> This applies even when the **Limit available bandwidth (%)** is set to **100%**.

When bandwidth control is in effect, **PkgXferMgr.log** will log one of these lines:

Scheduling:

> ~Address to DPNAME.CONTOSO.COM is currently under bandwidth control, therefore only one connection is allowed, returning send request to the pool.

Pulse Mode:

> ~Addres to DPNAME.CONTOSO.COM is currently in pulse mode, therefore only one connection is allowed.  
> ~Abandoning send request because only one connection is allowed in pulse mode.

**Sender.log** will show similar entries when bandwidth throttling is configured.
