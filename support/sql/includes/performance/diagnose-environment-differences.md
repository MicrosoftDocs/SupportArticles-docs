- Are the two SQL Server instances the same version or build?

  If not, there could be some fixes that caused the differences. Run the following query to get version information on both servers:

   ```sql
   SELECT @@VERSION
   ```

- Is the amount of physical memory similar on both servers?

  If one server has 64 GB of memory while the other has 256 GB of memory, that would be a significant difference. With more memory available to cache data/index pages and query plans, the query could be optimized differently based on hardware resource availability.

- Are CPU-related hardware configurations similar on both servers? For example:

  - Number of CPUs varies between machines (24 CPUs on one machine versus 96 CPUs on the other).
  - Power plans—balanced versus high performance.
  - Virtual Machine (VM) versus physical (bare metal) machine.
  - Hyper-V versus VMware—difference in configuration.
  - Clock speed difference (lower clock speed versus higher clock speed). For example, 2 GHz versus 3.5 GHz can make a difference. To get the clock speed on a server, run the following PowerShell command:

     ```powershell
     Get-CimInstance Win32_Processor | Select-Object -Expand MaxClockSpeed
     ```

  Use one of the following two ways to test the CPU speed of the servers. If they don't produce comparable results, the issue is outside of SQL Server. It could be a power plan difference, fewer CPUs, VM-software issue, or clock speed difference.

  - Run the following PowerShell script on both servers and compare the outputs.

     ```powershell
     $bf = [System.DateTime]::Now
     for ($i = 0; $i -le 20000000; $i++) {}
     $af = [System.DateTime]::Now
     Write-Host ($af - $bf).Milliseconds " milliseconds"
     Write-Host ($af - $bf).Seconds " Seconds"
     ```
  
  - Run the following Transact-SQL code on both servers and compare the outputs.

     ```sql
     SET NOCOUNT ON 
     DECLARE @spins INT = 0
     DECLARE @start_time DATETIME = GETDATE(), @time_millisecond INT
     
     WHILE (@spins < 20000000)
     BEGIN
       SET @spins = @spins +1
     END
     
     SELECT @time_millisecond = DATEDIFF(millisecond, @start_time, getdate())
     
     SELECT @spins Spins, @time_millisecond Time_ms,  @spins / @time_millisecond Spins_Per_ms
     ```
