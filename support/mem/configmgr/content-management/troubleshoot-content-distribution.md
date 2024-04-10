---
title: Troubleshoot Content Distribution issues
description: Describes how to troubleshoot common content distribution problems.
ms.date: 12/05/2023
ms.reviewer: kaushika
ms.custom: sap:Content Management\Content Distribution to Distribution Points
---
# Troubleshoot content distribution

This article discusses how to troubleshoot common content distribution issues.

_Original product version:_ &nbsp; Configuration Manager current branch, Microsoft System Center 2012 Configuration Manager, Microsoft System Center 2012 R2 Configuration Manager  

## Sample problem

For this example, let's say that you distributed a package to a distribution point but the package is in either a **Failed** or **In Progress** state for the DP.

1. First, review **DistMgr.log** on the site (primary/secondary) where the DP resides.

   1. Look for *~Processing package* entries in the log and identify the package processing thread for the package ID in question. Filter DistMgr.log for the thread ID you identified. Review step 4 in [Distribute a package to standard DP](understand-package-actions.md#distribute-a-package-to-standard-dp) to see log excerpts.
   2. Review the filtered log and check if a DP thread was created for the DP in question. Filter **DistMgr.log** for the thread ID to make this easier.
   3. Review the filtered log and check whether a PkgXferMgr job was created.

2. Review **PkgXferMgr.log** on the site (primary/secondary) where the DP resides.

   1. Look for *Found send request with ID* entries in the log and identify the sending thread for the affected DP/package combination. Filter **PkgXferMgr.log** for the thread ID identified. Review step 6 in [Distribute a package to standard DP](understand-package-actions.md#distribute-a-package-to-standard-dp) to see log excerpts.
   2. Review the filtered log to see if the content was successfully transferred to the DP or if there was an error.

3. For Standard DPs, PkgXferMgr copies the content file(s) to the DP, it instructs the DP WMI Provider to add the file to the content library by calling WMI methods. Review **SMSDPProv.log** on the DP to ensure that content was added to the content library. Review step 7 in [Distribute a package to standard DP](understand-package-actions.md#distribute-a-package-to-standard-dp) to see log excerpts.

   For pull DPs, PkgXferMgr notifies pull DP to initiate the content download. Review steps 8-16 in [Distribute a package to pull DP](understand-package-actions.md#distribute-a-package-to-standard-dp) to understand the flow and review **PullDP.log** and **DataTransferService.log** to ensure content was downloaded successfully.

4. For standard DPs, PkgXferMgr sends a status message to DistMgr. Review **DistMgr.log** to verify if the status message was processed successfully. Review step 8 in [Distribute a package to standard DP](understand-package-actions.md#distribute-a-package-to-standard-dp) to see log excerpts.

   For pull DPs, pull DP sends a state message to indicate success. Review steps 16-22 in [Distribute a package to pull DP](understand-package-actions.md#distribute-a-package-to-pull-dp) to understand the flow and review the relevant logs to ensure state message is processed successfully.

5. If multiple sites are involved, ensure that database replication is working and the database links between relevant sites are active.

## Common DistMgr issues

- **DistMgr.log** shows the following entry for the package ID in question:

  ```output
  SMS_DISTRIBUTION_MANAGER 2732 (0xaac) ~The contents for the package \<PackageID> hasn't arrived from site CS1 yet, will retry later.
  ```

  This usually happens temporarily while the content is in transit from one site to another. Review the Sender/Despooler logs to ensure that there are no issues with site communications. If you see errors during site to site communication (**Scheduler** -> **Sender** -> **Despooler**), focus on resolving those errors before troubleshooting the above message in **DistMgr.log**. Review [Distribute a package to DP across sites](understand-package-actions.md#distribute-a-package-to-dp-across-sites) to understand the log flow.

  If there are no errors, it may be necessary to force the parent site to resend the package to the affected site. See [Resend compressed copy of a package to a site](advanced-troubleshooting-tips.md#resend-compressed-copy-of-a-package-to-a-site) for more information.

- **DistMgr.log** may show that it's busy processing other packages and is using all the available threads for package processing.

  ```output
  SMS_DISTRIBUTION_MANAGER 4824 (0x12d8) ~Currently using 3 out of 3 allowed package processing threads.
  ```

  If you see this, review the current package processing threads in **DistMgr.log** to see if they are stuck. You can also review the **Package Processing Queue** and **Packages Being Processed** registry values under the following registry key to see how many packages are currently in the Processing Queue:

  `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\SMS\Components\SMS_DISTRIBUTION_MANAGER`

  If the **Packages Being Processed** values do not change and are stuck over a long period of time, it is possible that DistMgr is hung/stuck. If this happens, capture a [process dump](/sysinternals/downloads/procdump) of SMSExec.exe for review.

  If there are many packages in the queue but the queue is moving, it may be necessary to review and change the thread configuration.

- **DistMgr.log** does not process the incoming PKN files, and as a result packages are not being processed. This is resulting in a backlog of PKN files in the DistMgr inbox.

  PKN files are processed by the main DistMgr thread so in these cases it's helpful to identify the main DistMgr thread ID by looking for the *SMS_EXECUTIVE started SMS_DISTRIBUTION_MANAGER* log entry, then filter the **DistMgr.log** for the thread ID identified.

  In most cases, this issue occurs when the main DistMgr thread is making a WMI call to a remote DP but WMI on the DP is not responding, causing DistMgr to wait for it indefinitely. Filtering the **DistMgr.log** for the main DistMgr thread can provide clues about the DP it's trying to communicate with. Once identified, check if the DP is responding and WMI is functional on the DP. If necessary, reboot the DP to see if that helps.

  If the filtered **DistMgr.log** doesn't provide any clues, capture a [process dump](/sysinternals/downloads/procdump) of SMSExec.exe while in problem state for review.

## Common PkgXferMgr issues

- **PkgXferMgr.log** shows an error while adding files to the content library on the DP:

  ```output
  SMS_PACKAGE_TRANSFER_MANAGER 5744 (0x1670) ~Sending completed  
  [D:\SCCMContentLib\FileLib\B53B\B53B6F96ECC3FB2AF59D02C84A2D31434904BACF2F9C90D80107B6602860BCFD]  
  SMS_PACKAGE_TRANSFER_MANAGER 5744 (0x1670) ~ExecStaticMethod failed (80041001)  
  SMS_DistributionPoint, AddFile  
  SMS_PACKAGE_TRANSFER_MANAGER 5744 (0x1670) CSendFileAction::AddFile failed; 0x80041001  
  SMS_PACKAGE_TRANSFER_MANAGER 5744 (0x1670) ~Deleting remote file  
  \\DPNAME.CONTOSO.COM\SMS_DP$\Content_b034813c-bc60-4a16-b471-7a0dc3d9662b.1-B53B6F96ECC3FB2AF59D02C84A2D31434904BACF2F9C90D80107B6602860BCFD  
  SMS_PACKAGE_TRANSFER_MANAGER 5744 (0x1670) ~ Sending failed. Failure count = 1, Restart time = 12/4/2014 6:14:27 AM Eastern Standard Time
  ```

  After PkgXferMgr copies the content file to the DP, it executes WMI methods to instruct the remote DP to add the file to the content library. If the remote DP fails to add the file to the content library, you will see a generic WMI error (**0x80041001 = WBEM_E_FAILED**) in **PkgXferMgr.log**.

  When this happens, it is necessary to review **SMSDPProv.log** on the DP to identify the reason that the DP failed to add the file to the content library. If you see **File/Path not found** errors in **SMSDPProv.log**, you would need to capture a [Process Monitor](/sysinternals/downloads/procmon) trace to determine the reason for failure.

- **PkgXferMgr.log** shows that only one connection is allowed to the DP:
  
  ```output
  SMS_PACKAGE_TRANSFER_MANAGER 21216 (0x52e0) ~Address to DPNAME.CONTOSO.COM is currently under bandwidth control, therefore only one connection is allowed, returning send request to the pool.
  ```
  
  or

  ```output
  SMS_PACKAGE_TRANSFER_MANAGER 21216 (0x52e0) ~Address to DPNAME.CONTOSO.COM is currently in pulse mode, therefore only one connection is allowed.
  ```

    If **PkgXferMgr.log** shows that '*only one connection is allowed*' to the DP, it means that the DP is configured for bandwidth throttling. If this is the case, PkgXferMgr can only use one thread for the DP, and as a result only send one package to the DP at a time. See [Bandwidth control and threads](components-and-threads.md#bandwidth-control-and-threads) for more information.

- **PkgXferMgr.log** shows the address is closed:

  ```output
  SMS_PACKAGE_TRANSFER_MANAGER 7156 (0x1BF4) Address is closed for priority 2 jobs, stop sending[E:\SCCMContentLib\FileLib\2F08\2F0819F959E788CF843F42E9CA7B44E258B8B4BA37BB63902DB39ACF747BE7DA]  
  SMS_PACKAGE_TRANSFER_MANAGER 7156 (0x1BF4) Deleting remote file \\DPNAME.CONTOSO.COM\SMS_DP$\<PackageID>.6-2F0819F959E788CF843F42E9CA7B44E258B8B4BA37BB63902DB39ACF747BE7DA  
  SMS_PACKAGE_TRANSFER_MANAGER 7156 (0x1BF4) CSendFileAction::SendFiles failed; 0x80004005  
  SMS_PACKAGE_TRANSFER_MANAGER 7156 (0x1BF4) Sending failed. Failure count = 1, Restart time = 3/15/2016 8:30:08 AM Mountain Daylight Time
  ```

  If you see this in the log, it means that the DP is under bandwidth control and the address to the DP closed while content transfer was in progress. In the example above, the DP schedule was configured for *Allow high priority* only during 8:00AM to 10:00AM. As a result, PkgXferMgr stopped sending content at 8:00AM and marked the package/DP in a failed state.

- **PkgXferMgr.log** shows multiple threads starting at the same time for the same job:

  ```output
  SMS_PACKAGE_TRANSFER_MANAGER 8360 (0x20a8) Sending thread starting for Job: 12771, package: <PackageID>, Version: 8, Priority: 2, server: DPNAME.CONTOSO.COM, DPPriority: 200  
  SMS_PACKAGE_TRANSFER_MANAGER 10752 (0x2a00) Sending thread starting for Job: 12771, package: <PackageID>, Version: 8, Priority: 2, server: DPNAME.CONTOSO.COM, DPPriority: 200  
  SMS_PACKAGE_TRANSFER_MANAGER 12208 (0x2fb0) Sending thread starting for Job: 12771, package: <PackageID>, Version: 8, Priority: 2, server: DPNAME.CONTOSO.COM, DPPriority: 200  
  SMS_PACKAGE_TRANSFER_MANAGER 4244 (0x1094) Sending thread starting for Job: 12771, package: <PackageID>, Version: 8, Priority: 2, server: DPNAME.CONTOSO.COM, DPPriority: 200  
  SMS_PACKAGE_TRANSFER_MANAGER 8348 (0x209c) Sending thread starting for Job: 12771, package: <PackageID>, Version: 8, Priority: 2, server: DPNAME.CONTOSO.COM, DPPriority: 200
  ```

  Typically, PkgXferMgr uses one thread for a job, but if it uses multiple threads for the same job, the content transfer may start failing because of error **0x80070020 (ERROR_SHARING_VIOLATION)**. This happens if the site server and the site database servers are in different time zones. The solution here is to ensure that the site server and site database servers have the same time zone set.

## Common pull DP issues

- **PkgXferMgr.log** shows that the Pull DP is at capacity and no more jobs are sent to the pull DP:

  ```output
  SMS_PACKAGE_TRANSFER_MANAGER 4712 (0x1268) PullDP ["Display=\\P01PDP1.CONTOSO.COM\"]MSWNET:["SMS_SITE=P01"]\\P01PDP1.CONTOSO.COM\ has reached maximum capacity 50  
  SMS_PACKAGE_TRANSFER_MANAGER 4712 (0x1268) ~ PullDP has no capacity. Restart time = 1/10/2019 1:16:33 PM Eastern Standard Time
  ```

  PkgXferMgr runs the following query to check how many jobs are currently in an unfinished state on the pull DP. If the query returns more than 50 jobs, it will not send any more jobs to the pull DP.
  
  ```sql
  SELECT COUNT(*) FROM DistributionJobs job
  JOIN DistributionPoints dp ON dp.DPID=job.DPID AND dp.NALPath='["Display=\\P01PDP1.CONTOSO.COM\"]MSWNET:["SMS_SITE=P01"]\\P01PDP1.CONTOSO.COM\'
  WHERE job.State in (2, 3, 4) AND (job.Action<>5) AND (ISNULL(job.SendAction, '') <> '')
  ```

  These jobs are removed from the `DistributionJobs` table when pull DP sends a **Success** state message or when the status polling stops (based on configured values). To see the jobs on the pull DP, you can use wbemtest or [WMI Explorer](https://github.com/vinaypamnani/wmie2/releases) to review the instance count for `SMS_PullDPNotification` class. You can also review the instances of `ROOT\SCCMDP:SMS_PullDPState` WMI class on the pull DP to identify packages that are in a **Failed** state and review **PullDP.log** as well as **DataTransferService.log** to investigate the failures.

- `SignatureDownload` job on pull DP fails with HTTP 404 error.

  > Created SignatureDownload DTS job {JOBID} for package C010000D.28, content id ContentID. JobState = NotStarted  
  > DTS error message received for C010000D.28, content job {JOBID}, 0x80070002 : BITS error: 'HTTP status 404: The requested URL does not exist on the server.
  
  This is a known issue because the signature files are not present on a Source DP that is colocated on a site server. This issue only occurs when the distribution action is not **redist**.

  To work around this issue, use one of the following methods:

  - Redistribute the package (redistributing the package does not require downloading signatures since full content is downloaded).
  - Configure the pull DP to use a source DP that is not colocated on the site server.

- **DataTransferService.log** shows **0x800706D9** when trying to download content from the source DP:

  ```output
  DataTransferService 4864 (0x1300) CDTSJob::HandleErrors: DTS Job '{5285F8B3-C426-4882-85F2-AD5331DD4179}' BITS Job '{D53BA625-24AA-41FA-A357-6EB1B7D7E701}' under user 'S-1-5-18' OldErrorCount 29 NewErrorCount 30 ErrorCode
  ```

  0x800706D9 means that there are no more endpoints available from the endpoint mapper. This issue may occur due to RPC port allocation failures caused by firewall. It can also occur when **Windows Firewall** service is disabled.

  Check to see if there is a firewall between the site server and the affected server and find out if [RPC ports](/mem/configmgr/core/plan-design/hierarchy/ports?redirectedfrom=MSDN) are open. You can also [capture a Network Trace](https://blogs.technet.microsoft.com/msindiasupp/2011/08/10/how-to-setup-and-collect-network-capture-using-network-monitor-tool/) (from the pull DP as well as the source DP server) while reproducing the error for review.

- Pull DP shows that it has a large number of jobs but the jobs are not getting processed.

  In some instances (normally after installation of a new pull DP when all content is sent to the pull DP), too many job failures on the pull DP can end up stalled processing of the jobs. Although most of these issues are fixed in the recent releases of the product (Configuration Manager version 1810), some environmental factors can result in pull DP not processing jobs. When this happens, you would likely see thousands of DTS jobs in `ROOT\ccm\DataTransferService:CCM_DTS_JobEx` WMI class and ~50 (or more) BITS jobs in **Failed** state. In this scenario, it can be beneficial to remove all the job-specific items from WMI on the pull DP and distribute the content again to the pull DP in a controlled manner and investigate failures.

  To remove all the job-specific items from WMI on the Pull DP, you can use the below PowerShell script (review the script comments for help):

  **Reset-PullDPState.ps1**

    ```PowerShell
    <#

    .SYNOPSIS  
    Resets the state of the Pull DP and deletes data from various WMI classes related to Pull DP. You need to run this script as Administrator.

    .DESCRIPTION
    This script deletes the data from following WMI classes:
    - CCM_DTS_JobEx
    - CCM_DTS_JobItemEx
    - SMS_PullDPState
    - SMS_PullDPContentState
    - SMS_PullDPNotification (optional)

    The script also checks and reports the count of BITS Jobs.

    .PARAMETER ComputerName
    (Optional) Name of the Pull DP. You can leave this blank for local machine.

    .PARAMETER DeletePullDPNotifications
    (Optional) Use this switch if you want to delete the job notifications from SMS_PullDPNotification class.

    .PARAMETER KeepBITSJobs
    (Optional) Use this switch if you don't want the script to delete ALL BITS Jobs. If this switch is not used, ALL BITS jobs are deleted (even the ones that are not created by ConfigMgr)

    .PARAMETER NotifyPullDP
    (Optional) Use this switch if you want the script to execute NotifyPullDP method against SMS_DistributionPoint class. This is only useful when there aren't a lot of notifications in WMI and -DeletePullDPNotifications switch was not used.

    .PARAMETER WhatIf
    (Optional) Use this switch to see how many instances will be deleted.

    .EXAMPLE
    Reset-PullDPState -WhatIf
    This command checks how many Pull PD jobs will get deleted when running the script

    .EXAMPLE
    Reset-PullDPState
    This command resets the Pull DP related WMI classes except the Pull DP job Notification XML's

    .EXAMPLE
    Reset-PullDPState -DeletePullDPNotifications
    This command resets the Pull DP related WMI classes along with the Pull DP job Notification XML's. If you do this, you would need to distribute/redistribute these packages to the Pull DP again.

    .NOTES
    07/28/2016 - Version 1.0 - Initial Version of the script
    01/09/2019 - Version 2.0 - Added batch size for instance removal to prevent WMI Quota issues. Also added removal of BITS jobs (can be disabled by using -KeepBITSJobs switch) and restart of CcmExec service.

    #>

    [CmdletBinding()]
    Param(
      [Parameter(Mandatory=$false)]
       [string]$ComputerName = $env:COMPUTERNAME,

       [Parameter(Mandatory=$false)]
       [switch]$DeletePullDPNotifications,

       [Parameter(Mandatory=$false)]
       [switch]$KeepBITSJobs,

       [Parameter(Mandatory=$false)]
       [switch]$NotifyPullDP,

       [Parameter(Mandatory=$false)]
       [switch]$WhatIf
    )

    $LogFile = Join-Path (Split-Path $SCRIPT:MyInvocation.MyCommand.Path -Parent) "Reset-PullDPState.log"
    $ErrorActionPreference = "SilentlyContinue"

    Function Write-Log {
        Param(
          [string] $text,
          [switch] $NoWriteHost,
          [switch] $IsErrorMessage,
          [switch] $IsWarning,
          [switch] $WhatIfMode
        )

        $timestamp = Get-Date -Format "MM-dd-yyyy HH:mm:ss"
        "$timestamp $text" | Out-File -FilePath $LogFile -Append

        if ($WhatIfMode) {
            Write-Host $text -ForegroundColor Yellow
            return
        }

        if (-not $NoWriteHost) {
            if ($IsErrorMessage) {
                Write-Host $text -ForegroundColor Red
            }
            elseif ($IsWarning) {
                Write-Host $text -ForegroundColor Yellow
            }
            else {
                Write-Host $text -ForegroundColor Cyan
            }
        }
    }

    Function Delete-WmiInstances {
        Param(
            [string] $Namespace,
            [string] $ClassName,
            [string] $Filter = $null,
            [string] $Property1,
            [string] $Property2 = "",
            [string] $Property3 = "",
            [int] $BatchSize = 10000
        )

        $success = 0
        $totalfailed = 0
        $counter = 0
        $total = 0

        Write-Host ""
        Write-Log "$ClassName - Connecting to WMI Class on $ComputerName"

        do {

            if ($Filter -eq $null) {
                $Instances = Get-WmiObject -ComputerName $ComputerName -Namespace $Namespace -Class $ClassName -ErrorVariable WmiError -ErrorAction SilentlyContinue | Select -First $BatchSize
            }
            else {
                $Instances = Get-WmiObject -ComputerName $ComputerName -Namespace $Namespace -Class $ClassName -Filter $Filter -ErrorVariable WmiError -ErrorAction SilentlyContinue | Select -First $BatchSize
            }

            if ($WmiError.Count -ne 0) {
                Write-Log "    Failed to connect. Error: $($WmiError[0].Exception.Message)" -IsErrorMessage
                $WmiError.Clear()
                return
            }

            $currentfailed = 0
            $current = ($Instances | Measure-Object).Count
            if ($current -gt 0) {$script:serviceRestartRequired = $true}
            if ($WhatIf) { break }

            if ($current -ne $null -and $current -gt 0) {
                Write-Log "    Found $total total instances (Batch size $BatchSize)"

                foreach($instance in $Instances) {

                    $instanceText = "$Property1 $($instance.$Property1)"

                    if ($Property2 -ne "") {
                        $instanceText += ", $Property2 $($instance.$Property2)"
                    }

                    if ($Property3 -ne "") {
                        $instanceText += ", $Property3 $($instance.$Property3)"
                    }

                    Write-Log "    Deleting instance for $instanceText" -NoWriteHost
                    $counter += 1

                    $percentComplete = "{0:N2}" -f (($counter/$total) * 100)
                    Write-Progress -Activity "Deleting instances from $ClassName" -Status "Deleting instance #$counter/$total - $instanceText" -PercentComplete $percentComplete -CurrentOperation "$($percentComplete)% complete"

                    Remove-WmiObject -InputObject $instance -ErrorVariable DeleteError -ErrorAction SilentlyContinue
                    if ($DeleteError.Count -ne 0) {
                        Write-Log "    Failed to delete instance. Error: $($DeleteError[0].Exception.Message)" -NoWriteHost -IsErrorMessage
                        $DeleteError.Clear()
                        $currentfailed += 1
                    }
                    else {
                        $success += 1
                    }
                }

                $totalfailed += $currentfailed

                if ($currentfailed -eq $current) {
                    # Every instance in current batch failed. Break to avoid infinite while loop
                    break
                }
            }

        } while (($Instances | Measure-Object).Count -ne 0)

        if ($WhatIf) {
            if ($total -eq $BatchSize) {
                Write-Log "    (What-If Mode) Found more than $BatchSize instances which will be deleted" -WhatIfMode
            }
            else {
                Write-Log "    (What-If Mode) $total instances will be deleted" -WhatIfMode
            }
        }
        else {
            if ($total -gt 0) {
                # $totalfailed is likely not the accurate count here as it could include duplicate failures due to batching
                Write-Log "    Deleted $success instances. Failed to delete $totalfailed instances."
            }
            else {
                Write-Log "    Found 0 instances."
            }
        }
    }

    Function Check-BITSJobs {

        $DisplayName = "BITS Jobs"

        Write-Host ""
        Write-Log "$DisplayName - Gettting jobs on $ComputerName"
        Import-Module BitsTransfer
        $Instances = Get-BitsTransfer -AllUsers -Verbose -ErrorVariable BitsError -ErrorAction SilentlyContinue | Where-Object {$_.DisplayName -eq 'CCMDTS Job'}

        if ($BitsError.Count -ne 0) {
            Write-Log "    $DisplayName - Failed to get jobs. Error: $($BitsError[0].Exception.Message)" -IsErrorMessage
            $BitsError.Clear()
        }
        else {
            $total = ($Instances | Measure-Object).Count
            Write-Log "    $DisplayName - Found $total jobs"

            if ($KeepBITSJobs) {
                Write-Log "    BITS Jobs will not be removed because KeepBITSJobs is true." -WhatIfMode
            }
            else {
                if ($WhatIf) {
                    Write-Log "    (What-If Mode) ALL BITS jobs will be removed since KeepBITSJobs is NOT specified." -WhatIfMode
                }
                else {
                    if ($total -gt 0) {
                        Write-Log "    Removing ALL jobs since KeepBITSJobs is NOT specified."
                        Remove-BITSJobs
                    }
                    else {
                        Write-Log "    There are no jobs to delete."
                    }
                }
            }
        }
    }

    Function Remove-BITSJobs {

        try {
            Stop-Service BITS
            Rename-Item "$($env:ALLUSERSPROFILE)\Microsoft\Network\Downloader" -NewName "Downloader.OLD.$([Guid]::NewGuid().Guid.Substring(0,8))"
            Start-Service BITS
            $script:serviceRestartRequired = $true
            Write-Log "    Removed ALL BITS Jobs successfully."
        } catch {
            Write-Log "    Failed to delete the BITS jobs."
            Write-Log "    If necessary, run 'bitsadmin /reset /allusers' command under SYSTEM account (using psexec.exe) to delete the BITS Jobs."
            Write-Log "    Additionally, you can delete these jobs by stopping BITS service, renaming %allusersprofile%\Microsoft\Network\Downloader folder, and starting BITS service."
        }
    }

    Function Restart-CcmExec {

        $DisplayName = "SMS Agent Host"

        Write-Host ""
        Write-Log "$DisplayName - Checking if service restart is required."
        if ($script:serviceRestartRequired) {

            if ($WhatIf) {
                Write-Log "    (What-If Mode) Service Restart will be required." -WhatIfMode
                if ($NotifyPullDP) {
                    Write-Log "    (What-If Mode) NotifyPullDP method will be executed." -WhatIfMode
                }
                else {
                    Write-Log "    (What-If Mode) NotifyPullDP method will NOT be executed because -NotifyPullDP switch was NOT used." -WhatIfMode
                }
                return
            }

            try {
                Write-Host ""
                Write-Log "### Restarting CCMEXEC service... ###"
                Restart-Service CcmExec
                Write-Log "### Success! ###"
            } catch {
                Write-Log "### ERROR! Restart CcmExec Manually in order to recreate BITS jobs for content transfer! ###"
            }

            if (-not $DeletePullDPNotifications -and $NotifyPullDP) {
                # Only do this if notifications were not deleted. If they were deleted, NotifyPullDP will not do anything.
                try {
                    Write-Host ""
                    Write-Log "### Invoking NotifyPullDP WMI method against the SMS_DistributionPoint class in $DPNamespace."
                    Invoke-WmiMethod -Namespace root\SCCMDP -Class SMS_DistributionPoint -Name NotifyPullDP | Out-Null
                    Write-Log "### Success! ###"
                } catch {
                    Write-Log "### ERROR! Failed to invoke NotifyPullDP method! You can use wbemtest or WMI Explorer to invoke the method manually. ###"
                }
            }
            else {
                if (-not $NotifyPullDP) {
                    Write-Log "### Skipped invoking NotifyPullDP WMI method because -NotifyPullDP was NOT specified" -IsWarning
                    Write-Log "### You can use wbemtest or WMI Explorer to invoke the method manually, if necessary. ###"
                }

                if ($DeletePullDPNotifications) {
                    Write-Log "### Skipped invoking NotifyPullDP WMI method because -DeletePullDPNotifications was specified" -IsWarning
                    Write-Log "### Executing NotifyPullDP when there are no notifications does not do anything." -IsWarning
                }

            }
        }
        else {
            Write-Log "    Service Restart is NOT required. " -WhatIfMode
            if ($NotifyPullDP) {
                Write-Log "    NotifyPullDP method skipped. " -WhatIfMode
            }
        }
    }

    Write-Host ""
    Write-Log "### Script Started ###"
    $script:serviceRestartRequired = $false

    if ($WhatIf) {
        Write-Host ""
        Write-Log "*** Running in What-If Mode" -WhatIfMode
    }

    $DPNamespace = "root\SCCMDP"
    $DTSNamespace = "root\CCM\DataTransferService"

    Delete-WmiInstances -Namespace $DTSNamespace -ClassName "CCM_DTS_JobEx" -Filter "NotifyEndpoint like '%PullDP%'" -Property1 "ID"
    Delete-WmiInstances -Namespace $DTSNamespace -ClassName "CCM_DTS_JobItemEx" -Property1 "JobID"
    Delete-WmiInstances -Namespace $DPNamespace -ClassName "SMS_PullDPState" -Property1 "PackageID" -Property2 "PackageVersion" -Property3 "PackageState"
    Delete-WmiInstances -Namespace $DPNamespace -ClassName "SMS_PullDPContentState" -Property1 "PackageKey" -Property2 "ContentId" -Property3 "ContentState"

    if ($DeletePullDPNotifications) {
        Delete-WmiInstances -Namespace $DPNamespace -ClassName "SMS_PullDPNotification" -Property1 "PackageID" -Property2 "PackageVersion"
    }
    else {
        Write-Host ""
        Write-Log "SMS_PullDPNotification - Connecting to WMI Class on $ComputerName"

        $temp = Get-WmiObject -ComputerName $ComputerName -Namespace $DPNamespace -Class "SMS_PullDPNotification" -ErrorVariable WmiError -ErrorAction SilentlyContinue

        if ($WmiError.Count -ne 0) {
            Write-Log "    SMS_PullDPNotification - Failed to connect. Error: $($WmiError[0].Exception.Message)" -IsErrorMessage
            $WmiError.Clear()
        }
        else {
            Write-Log "    Found $(($temp | Measure-Object).Count) instances."
            Write-Log "    Skipped because DeletePullDPNotifications switch was NOT used." -IsWarning
        }
    }

    if ($ComputerName -eq $env:COMPUTERNAME) {
        Check-BITSJobs
    }
    else {
        Write-Host ""
        Write-Log "BITS Jobs"
        Write-Log "    Skipped because script is running against a remote computer." -IsWarning
    }

    Restart-CcmExec

    Write-Host ""
    Write-Log "### Script Ended ###"
    Write-Host "### Check $LogFile for more details. ###" -ForegroundColor Cyan
    #if (-not $WhatIf -and $serviceRestartRequired) {Write-Log "### Please restart the WMI service (which also restarts CcmExec). ###" -IsWarning}
    Write-Host ""
    ```

- Content shows **Installed** on the pull DP but URL and URLSubPath for the pull DP is not populated in `ContentDPMap`, which causes issues with packages having SMB Access enabled.

  When the pull DP has the content successfully installed, it sends a state message that contains the data necessary to update the `URL/URLSubPath` values in `ContentDPMap`. This happens when the pull DP response is processed. Review steps 16-22 in [Distribute a package to pull DP](understand-package-actions.md#distribute-a-package-to-pull-dp) to understand the flow and review the relevant logs to investigate why the state message is not getting processed. Most likely cause for this issue is either a backlog of state messages in the `\MP\outboxes\StateMsg.box` on the management point or MPFDM failing to copy files to the site server due to permission issues.  

## Missing content files in content library

There are times when you would notice content missing from the content library. This could happen due to previous content distribution issues or someone/something accidentally deleting files from the content library. To confirm that the content is missing from the content library, identify an affected package and track the package content from `PkgLib` to `FileLib`.

Once you confirm that the required content for a Package is missing in the Content Library, see [Resend compressed copy of a package to a site](advanced-troubleshooting-tips.md#resend-compressed-copy-of-a-package-to-a-site) for information on how to re-populate the content.  

## Generic issues

- The DistMgr or PkgXferMgr log shows a file/path not found error:

  ```output
  SMS_PACKAGE_TRANSFER_MANAGER 3776 (0xec0) CContentDefinition::TotalFileSizes failed; 0x80070003
  SMS_PACKAGE_TRANSFER_MANAGER 3776 (0xec0) Sending content 000f8a0a-825c-457b-a15b-57ade145a09b for package \<PackageID>
  SMS_PACKAGE_TRANSFER_MANAGER 3776 (0xec0) CSendFileAction::SendFiles failed; 0x80070003
  SMS_PACKAGE_TRANSFER_MANAGER 3776 (0xec0) CSendFileAction::SendContent failed; 0x80070003
  SMS_PACKAGE_TRANSFER_MANAGER 648 (0x288) Sent status to the distribution manager for pkg <PackageID>, version 14, status 4 and distribution point ["Display=\\DPNAME.CONTOSO.COM\"]MSWNET:["SMS_SITE=S01"]\\DPNAME.CONTOSO.COM\~
  ```

  or

  ```output
  SMS_PACKAGE_TRANSFER_MANAGER 11228 (0x2bdc) Sending legacy content P0100053.2 for package <PackageID>  
  SMS_PACKAGE_TRANSFER_MANAGER 11228 (0x2bdc) CContentDefinition::TotalFileSizes failed; 0x80070003  
  SMS_PACKAGE_TRANSFER_MANAGER 11228 (0x2bdc) CSendFileAction::SendFiles failed; 0x80070003
  ```

  Common error codes: **0x80070002**, **0x80070003**.

  For file/path not found errors, the problem is likely due to the fact that the content library on the site server is missing content files for the package. As a result, PkgXferMgr is not able to send the files to the DP.

  In these cases, you can identify the content ID from the log and track the content from `PkgLib` to `FileLib` to ensure that the files exist. You can also use Content Library Explorer to check if the package content files are available in the content library, however Content Library Explorer can take some time to load and it may be easier to manually track the content from `PkgLib` to `FileLib`. Alternatively, you can capture a [Process Monitor](/sysinternals/downloads/procmon) trace to verify if the necessary files are missing from the content library on the site server.

  If the site that is missing content in the content library is the package source site, it is necessary to update the package to increment the **Package Source** version so that DistMgr takes a snapshot of the content from the package source directory again and re-populates the missing content.

  If the site missing the content in the content library is different from the package source site, you can force the package source site to resend the compressed copy of the package to the affected site. See [Resend compressed copy of a package to a site](advanced-troubleshooting-tips.md#resend-compressed-copy-of-a-package-to-a-site) for more information.

- DistMgr/PkgXferMgr log shows a network error:

  ```output
  SMS_DISTRIBUTION_MANAGER 5112 (0x13f8) Failed to make a network connection to \\DPNAME.CONTOSO.COM\ADMIN$ (0x35).~  
  SMS_DISTRIBUTION_MANAGER 5112 (0x13f8) ~Cannot establish connection to ["Display=\\DPNAME.CONTOSO.COM\"]MSWNET:["SMS_SITE=PS1"]\\DPNAME.CONTOSO.COM\. Error = 53
  SMS_DISTRIBUTION_MANAGER 5112 (0x13f8) Error occurred. Performing error cleanup prior to returning.
  ```

  Common error codes: **2**, **3**, **53**, **64**.

  For network related errors, review the log and identify the server you're trying to communicate with when you get the error. Once identified, test the following:

  1. Can you ping the affected SERVERNAME using the FQDN/NetBIOS/IP address?
  2. Can you access *\\\SERVERNAME\admin$* share using the FQDN/NetBIOS/IP address using the SYSTEM account from the site server?
  3. Can you access *\\\SERVERNAME\admin$* share using the FQDN/NetBIOS/IP address using the logged in user's account from the site server?
  4. Is there a firewall between the site server and the affected server? Are [relevant ports (RPC/SMB)](/mem/configmgr/core/plan-design/hierarchy/ports?redirectedfrom=MSDN) open?
  
  If the above tests are successful, [capture a network trace](/archive/blogs/msindiasupp/how-to-setup-and-collect-network-capture-using-network-monitor-tool) (from the site server as well as the affected server) while reproducing the error for review.

- DistMgr/PkgXferMgr log shows an access denied error:

  ```output
  SMS_DISTRIBUTION_MANAGER    7076 (0x1ba4)    Taking package snapshot for package <PackageID> from source \\PS1SITE\PKGSOURCE\DummyPackage
  SMS_DISTRIBUTION_MANAGER    7076 (0x1ba4)    ~The source directory \\PS1SITE\PKGSOURCE\DummyPackage doesn't exist or the SMS service cannot access it, Win32 last error = 5
  SMS_DISTRIBUTION_MANAGER    7076 (0x1ba4)    ~Failed to take snapshot of package <PackageID>
  ```

  Common error codes: **5**, **0x80070005**.

  For permissions related errors, review the log and identify the path you're trying to access when you get the error. Once identified, test the following:

  1. Can you ping the affected SERVERNAME if the path is a UNC path?
  2. Does the site server computer account have permissions to access the path?
  3. Can you access the affected path using the FQDN/NetBIOS/IP address when using the SYSTEM account from the site server?
  4. Can you access the affected path using the FQDN/NetBIOS/IP address when using the logged in user's account from the site server?
  5. Is there a firewall between the site server and the affected server? Are [relevant ports (RPC/SMB)](/mem/configmgr/core/plan-design/hierarchy/ports?redirectedfrom=MSDN) open?
  
  If the above tests are successful, capture a [Process Monitor](/sysinternals/downloads/procmon) trace from the site server while reproducing the error for review.

- DistMgr/PkgXferMgr look for content in the `\bin\x64\FileLib` directory instead of the actual content library location.

  This is due to a known issue in the Content Library Transfer tool.
