---
title: Scripts to inspect the content of the WMI repository
description: Introduces a script to inspect the content of the WMI repository.
ms.date: 01/15/2025
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.reviewer: kaushika
ms.custom:
- sap:system management components\wmi management and troubleshooting
- pcy:WinComm User Experience
---
# Scripts: Inspect the content of the WMI repository

This article provides a script to inspect the contents of the Windows Management Instrumentation (WMI) repository.

## Details

The WMI repository includes the following types of objects:

- Dynamic classes: These classes retrieve results by executing code in a dynamic link library (DLL) or an external executable. The results come from a system component or an application and aren't stored in the WMI repository.

  - DLLs are used by coupled providers that run in *WMIPrvSE* processes.

  - Executables are used by decoupled providers that run in their own processes.

- Providers: These providers are DLL and executable registrations used by dynamic classes. Providers implement the logic that dynamic classes use to return the results.

- Static classes: These classes contain static content, typically used by components and applications to store configurations or results, such as RSOP or SCCM. With static classes, WMI is used like a database to store and retrieve this information.

- Namespaces: These namespaces are groupings used by all the other objects, and each namespace has a security descriptor that defines the permissions for accessing the objects within it.

## Script

[!INCLUDE [Script disclaimer](../../includes/script-disclaimer.md)]

```powershell
param( [string]$DataPath)

Function Write-Log {
  param( $msg, $onscreen )

  $msg = (get-date).ToString("yyyyMMdd HH:mm:ss.fff") + " " + $msg
  if ($onscreen) {
    Write-Host $msg
  }
  $msg | Out-File -FilePath $global:outfile -Append
}

Function Get-WMINamespace($ns) {
  Write-Log "Inspecting providers in $ns" $true
  Get-WMIProviders $ns

  Write-Log "Inspecting classes in $ns" $true

  Get-Classes $ns

  Write-Log "Inspecting security in $ns" $true
  Get-WmiNamespaceSecurity $ns

  Get-CimInstance -namespace $ns -class "__Namespace" | sort-object Name  |
  ForEach-Object {
    if ((($_.Name.Length -le 2) -or ($_.name.Substring(0,3).ToLower() -ne "ms_")) -and (-not($_.name -match "LDAP"))) {
      Get-WMINamespace ($ns + "\" + $_.name)
    }
  }
}

Function Get-WMIProviders ($ns) {
  Get-CimInstance -NameSpace $ns -Class __Win32Provider | sort-object Name  |
  ForEach-Object {
    Get-ProvDetails $ns $_.name $_.CLSID $_.HostingModel $_.UnloadTimeout
  }
}

Function Get-Classes ($ns) {
  Get-CimClass -Namespace $ns | Sort-Object -Property ClassName  |
  ForEach-Object {  
    $abstract = $_.CimClassQualifiers["abstract"].Value
    $dynamic = $_.CimClassQualifiers["dynamic"].Value
    $static = $_.CimClassQualifiers["static"].Value
    $aggregation = $_.CimClassQualifiers["aggregation"].Value
    $association = $_.CimClassQualifiers["association"].Value
    $UMLPackagePath = $_.CimClassQualifiers["UMLPackagePath"].Value

    $name = $_.CimClassName

    Write-Log "Inspecting class $name in namespace $ns - abstract $abstract, dynamic $dynamic, static $static, aggregation $aggregation, association $association, UMLPackagePath $UMLPackagePath <eol>"

    #if (($name -eq "RSOP_GPO") -or ($name -eq "BaseStatus") -or ($name -eq "CIM_ProtocolEndpoint") ) {
    #  Write-Host ""
    #}

    if( ($abstract -eq $true) -or ($dynamic -eq $true) -or ($aggregation -eq $true) -or ($association -eq $true)) {
      if ($dynamic -eq $true) { # Dynamic class
        $row = $tbDyn.NewRow()
        $row.NameSpace = $ns
        $row.Name = $_.CimClassName
        $row.Provider = $_.CimClassQualifiers["Provider"].value
        $row.Methods = GetClassMethods -className $_.CimClassName -ns $ns 
        $tbDyn.Rows.Add($row)
      } else {
        # Abstract, aggregation or association
      }
    } else {
      if (-not $_.CimClassName.Startswith("__")) {
        if ($static -eq $true) { # Static class = Repository
          $row = $tbStatic.NewRow()
          $row.NameSpace = $ns
          $row.Name = $_.CimClassName
          $instances = Get-CimInstance -ClassName $_.CimClassName -Namespace $ns -ErrorAction SilentlyContinue 
          $instCount = $instances.Count
          if ($instCount   -gt 0) {
            $row.Inst = $instCount
            $row.Size = GetClassSize -className $_.CimClassName  -ns $ns -classObj $instances
          } else {
            $row.Inst = 0
            $row.Size = 0
          }
          $tbStatic.Rows.Add($row)
        } else {
          #Write-Host "Class $_.CimClassName in namespace $ns not specifically defined as static or dynamic"
          $row = $tbStatic.NewRow()
          $row.NameSpace = $ns
          $row.Name = $_.CimClassName

          $properties = $_.CimClassProperties.Count
          $methods = $_.CimClassMethods.Count
 
          if (($properties -gt 0) -and ($methods -eq 0) -and ($UMLPackagePath -ne "CIM::Core::Settings") -and ($UMLPackagePath -ne "CIM::Policy")) {
            $instances = Get-CimInstance -ClassName $_.CimClassName -Namespace $ns -ErrorAction SilentlyContinue 
            $instCount = $instances.Count
            if ($instCount -gt 0) {
              $row.Inst = $instCount
              $row.Size = GetClassSize -className $_.CimClassName  -ns $ns -classObj $instances
            } else {
              $row.Inst = 0
              $row.Size = 0
            }
          } else {
            $row.Inst = 0
            $row.Size = 0
          }
          $tbStatic.Rows.Add($row)
        }
      }
    }
  }
}

Function Get-ObjectSize ($property, $ns, $className) {
  $size = 0

  switch ($property.CimType) {
    "SInt8" { $size += 1 }
    "UInt8" { $size += 1 }
    "SInt16" { $size += 2 }
    "UInt16" { $size += 2 }
    "SInt32" { $size += 4 }
    "UInt32" { $size += 4 }
    "SInt64" { $size += 8 }
    "UInt64" { $size += 8 }
    "Real32" { $size += 4 }
    "Real64" { $size += 8 }
    "Char16" { $size += 2 }
    "Boolean" { $size += 1 }
    "Datetime" { $size += 8 }
    "String" {
      if ($property.Value) {
        $size += [Text.Encoding]::Unicode.GetByteCount($property.Value.ToString())
      }
    }
    "Reference" {
      if ($property.Value) {
        $size += [Text.Encoding]::Unicode.GetByteCount($property.Value.ToString())
      }
    }
    "Instance" {
      if ($property.Value) {
        foreach ($instanceProp in $property.Value.CimInstanceProperties) {
          $size += Get-ObjectSize -property $instanceProp -ns $ns -className $className
        }
      }
    }
    "InstanceArray" {
      if ($property.Value) {
        foreach ($instance in $property.Value) {
          foreach ($instanceProp in $instance.CimInstanceProperties) {
            $size += Get-ObjectSize -property $instanceProp -ns $ns -className $className
          }
        }
      }
    }
    "StringArray" {
      if ($property.Value) {
        foreach ($str in $property.Value) {
          $size += [Text.Encoding]::Unicode.GetByteCount($str.ToString())
        }
      }
    }
    "UInt64Array" {
      if ($property.Value) {
        foreach ($element in $property.Value) {
          $size += 8  # Each UInt16 element is 2 bytes
        }
      }
    }
    "UInt32Array" {
      if ($property.Value) {
        foreach ($element in $property.Value) {
          $size += 4  # Each UInt16 element is 2 bytes
        }
      }
    }
    "UInt16Array" {
      if ($property.Value) {
        foreach ($element in $property.Value) {
          $size += 2  # Each UInt16 element is 2 bytes
        }
      }
    }
    "UInt8Array" {
      if ($property.Value) {
        foreach ($element in $property.Value) {
          $size += 1  # Each UInt8 element is 1 byte
        }
      }
    }
    default {
      Write-Log ("Unmanaged type " + $property.CimType + " " + $ns + " " + $className) $true
    }
  }
  return $size
}

Function GetClassSize {
  param (
    $ns,
    $className,
    $classObj
  )

  $cSize = 0
  #$classObj = Get-CimInstance -ClassName $className -Namespace $ns -ErrorAction SilentlyContinue

  if ($classObj) {
    foreach ($inst in $classObj) {
      foreach ($prop in $inst.CimInstanceProperties) {
        $cSize += Get-ObjectSize -property $prop -ns $ns -className $className
      }
    }
  }

  return $cSize
}

Function GetClassMethods {
  param (
      [string]$ns,
      [string]$className
  )

  $sMethods = ""
  $classObj = Get-CimClass -Namespace $ns -ClassName $className
  foreach ($method in $classObj.CimClassMethods) {
      $sMethods += ($method.Name + " ")
  }
  return $sMethods
}

Function Get-ProvDetails($ns, $name, $clsid, $HostingModel, $UnloadTimeout) {
  $row = $tbProv.NewRow()
  $row.NameSpace = $ns
  $row.Name = $name
  $row.HostingModel = $HostingModel
  $row.CLSID= $clsid
  $row.UnloadTimeout = $UnloadTimeout
  $dll = " "

  if ($clsid -ne $null) {
    if ($HostingModel -match "decoupled") {
      $Keys = Get-ChildItem HKLM:\SOFTWARE\Microsoft\Wbem\Transports\Decoupled\Client -ErrorAction SilentlyContinue
      $Items = $Keys | Foreach-Object {Get-ItemProperty $_.PsPath }
      ForEach ($key in $Items) {
        if ($key.Provider -eq $name) {
          $key.ProcessIdentifier
          $proc = Get-CimInstance -Query ("select ExecutablePath from Win32_Process where ProcessId = " + $key.ProcessIdentifier)
          $exe = get-item ($proc.ExecutablePath)
          $row.DLL = $proc.ExecutablePath
          $row.dtDLL = $exe.CreationTime
          $row.verDLL = $exe.VersionInfo.FileVersion
          $svc = Get-CimInstance -Query ("select Name from Win32_Service where ProcessId = " + $key.ProcessIdentifier)
          if ($svc) {
            $row.ThreadingModel = ("Service: " + $svc.Name)
          }
        }
      }
    } elseif ($HostingModel -ne "SelfHost") {
      $name = (get-itemproperty -ErrorAction SilentlyContinue -literalpath (":\CLSID\" + $clsid)).'(default)'
      $dll = (get-itemproperty -ErrorAction SilentlyContinue -literalpath ("HKCR:\CLSID\" + $clsid + "\InprocServer32")).'(default)'
      $row.DLL= $dll
      if ($dll) {
        $dll = $dll.Replace("""","")
        $file = Get-Item ($dll)
        $row.dtDLL = $file.CreationTime
        $row.verDLL = $file.VersionInfo.FileVersion
      }
      $row.ThreadingModel = (get-itemproperty -ErrorAction SilentlyContinue -literalpath ("HKCR:\CLSID\" + $clsid + "\InprocServer32")).'ThreadingModel'
    }
  }
  $tbProv.Rows.Add($row)
}

Function Get-WmiNamespaceSecurity ($namespace) {

    Process {
        $ErrorActionPreference = "Stop"
 
        Function Get-PermissionFromAccessMask {
            Param ($accessMask)
 
            $WBEM_ENABLE            = 1
            $WBEM_METHOD_EXECUTE    = 2
            $WBEM_FULL_WRITE_REP    = 4
            $WBEM_PARTIAL_WRITE_REP = 8
            $WBEM_WRITE_PROVIDER    = 0x10
            $WBEM_REMOTE_ACCESS     = 0x20
            $READ_CONTROL           = 0x20000
            $WRITE_DAC              = 0x40000
       
            $WBEM_RIGHTS_FLAGS = $WBEM_ENABLE, $WBEM_METHOD_EXECUTE, $WBEM_FULL_WRITE_REP, `
                $WBEM_PARTIAL_WRITE_REP, $WBEM_WRITE_PROVIDER, $WBEM_REMOTE_ACCESS, `
                $READ_CONTROL, $WRITE_DAC
            $WBEM_RIGHTS_STRINGS = "EnableAccount", "ExecuteMethod", "FullWrite", "PartialWrite", `
                "ProviderWrite", "RemoteEnable", "ReadSecurity", "WriteSecurity"
 
            $permission = @()
            for ($i = 0; $i -lt $WBEM_RIGHTS_FLAGS.Length; $i++) {
                if (($accessMask -band $WBEM_RIGHTS_FLAGS[$i]) -gt 0) {
                    $permission += $WBEM_RIGHTS_STRINGS[$i]
                }
            }
       
            $permission
        }

        $res = ""
        $INHERITED_ACE_FLAG = 0x10
 
        if ($credential -ne $null) {
            $cimSessionParams.Credential = $credential
        }
 
        $cimSession = New-CimSession
        $invokeParams = @{
            Namespace = $namespace
            ClassName = "__SystemSecurity"
            MethodName = "GetSecurityDescriptor"
            CimSession = $cimSession
        }
 
        $output = Invoke-CimMethod @invokeParams -ErrorAction SilentlyContinue
        if ($output.ReturnValue -ne 0) {
            $res = "GetSecurityDescriptor failed: $($output.ReturnValue)   "
        }
   
        $acl = $output.Descriptor
        foreach ($ace in $acl.DACL) {
            $user = [PSCustomObject]@{
                Name       = "$($ace.Trustee.Domain)\$($ace.Trustee.Name)"
                Permission = (Get-PermissionFromAccessMask $ace.AccessMask)
                Inherited  = (($ace.AceFlags -band $INHERITED_ACE_FLAG) -gt 0)
            }
            $res += "$($user.Name) ($($user.Permission -join ' ')) / "
        }
        $row = $tbSec.NewRow()
        $row.NameSpace = $namespace
        $row.Security = $res.Substring(0, $res.Length - 3)
        $tbSec.Rows.Add($row)
    }
}

[void][System.Reflection.Assembly]::Load('System.Drawing, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a')
[void][System.Reflection.Assembly]::Load('System.Windows.Forms, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089')

$myWindowsID = [System.Security.Principal.WindowsIdentity]::GetCurrent()
$myWindowsPrincipal = new-object System.Security.Principal.WindowsPrincipal($myWindowsID)
$adminRole = [System.Security.Principal.WindowsBuiltInRole]::Administrator
if (-not $myWindowsPrincipal.IsInRole($adminRole)) {
  Write-Output "This script needs to be run as Administrator"
  exit
}

$global:Root = Split-Path (Get-Variable MyInvocation).Value.MyCommand.Path

$resName = "WMI-Report-" + $env:computername +"-" + $(get-date -f yyyyMMdd_HHmmss)
$resDir = $global:Root + "\" + $resName

if ($DataPath) {
  if (-not (Test-Path $DataPath)) {
    Write-Host "The folder $DataPath does not exist"
    exit
  }
  $resDir = $DataPath + "\" + $resName
} else {
  $resDir = $global:Root + "\" + $resName
}

New-Item -itemtype directory -path $resDir | Out-Null
$global:outfile = $resDir + "\WMI-Report.log"

New-PSDrive -PSProvider registry -Root HKEY_CLASSES_ROOT -Name HKCR | Out-Null

$tbProv = New-Object system.Data.DataTable "WmiProv"
$col = New-Object system.Data.DataColumn NameSpace,([string])
$tbProv.Columns.Add($col)
$col = New-Object system.Data.DataColumn Name,([string])
$tbProv.Columns.Add($col)
$col = New-Object system.Data.DataColumn HostingModel,([string])
$tbProv.Columns.Add($col)
$col = New-Object system.Data.DataColumn ThreadingModel,([string])
$tbProv.Columns.Add($col)
$col = New-Object system.Data.DataColumn DLL,([string])
$tbProv.Columns.Add($col)
$col = New-Object system.Data.DataColumn dtDLL,([string])
$tbProv.Columns.Add($col)
$col = New-Object system.Data.DataColumn verDLL,([string])
$tbProv.Columns.Add($col)
$col = New-Object system.Data.DataColumn UnloadTimeout,([string])
$tbProv.Columns.Add($col)
$col = New-Object system.Data.DataColumn CLSID,([string])
$tbProv.Columns.Add($col)

$tbDyn = New-Object system.Data.DataTable "Classes"
$col = New-Object system.Data.DataColumn NameSpace,([string]); $tbDyn.Columns.Add($col)
$col = New-Object system.Data.DataColumn Name,([string]); $tbDyn.Columns.Add($col)
$col = New-Object system.Data.DataColumn Provider,([string]); $tbDyn.Columns.Add($col)
$col = New-Object system.Data.DataColumn Methods,([string]); $tbDyn.Columns.Add($col)

$tbStatic = New-Object system.Data.DataTable "Repository"
$col = New-Object system.Data.DataColumn NameSpace,([string])
$tbStatic.Columns.Add($col)
$col = New-Object system.Data.DataColumn Name,([string])
$tbStatic.Columns.Add($col)
$col = New-Object system.Data.DataColumn Inst,([Int32])
$tbStatic.Columns.Add($col)
$col = New-Object system.Data.DataColumn Size,([Int64])
$tbStatic.Columns.Add($col)

$tbSec = New-Object system.Data.DataTable "Security"
$col = New-Object system.Data.DataColumn NameSpace,([string])
$tbSec.Columns.Add($col)
$col = New-Object system.Data.DataColumn Security,([string])
$tbSec.Columns.Add($col)


Get-WMINamespace "Root"

Write-Host "Writing Providers.csv"
$tbProv | Export-Csv $resDir"\Providers.csv" -noType
Write-Host "Writing Classes.csv"
$tbDyn | Export-Csv $resDir"\Dynamic.csv" -noType
Write-Host "Writing Repository.csv"
$tbStatic | Export-Csv $resDir"\Static.csv" -noType
Write-Host "Writing Security.csv"
$tbSec | Export-Csv $resDir"\Security.csv" -noType
```

The script can be executed without any parameters, and it creates a subfolder for each run. If the script is executed with the `-DataPath` parameter, a subfolder is created in that specified path. Inside the folder, you can find four CSV files that can be imported into Excel:

### Dynamic.csv

This file contains the list of dynamic classes with the following columns:

- **NameSpace**: Where the class is registered
- **Name**: Name of the class
- **Provider**: The provider on which the class relies
- **Methods**: Methods exposed by the class

### Providers.csv

This file contains the list of registered providers with the following columns:

- **NameSpace**: Where the provider is registered
- **Name**: Name of the provider
- **HostingModel**: See [Provider Hosting and Security](/windows/win32/wmisdk/provider-hosting-and-security)
- **ThreadingModel**: See [COM+ Threading Models](/windows/win32/cossdk/com--threading-models)
- **DLL Path**: Path where the provider is implemented
- **dtDLL**: Date of the DLL
- **verDLL**: Version of the DLL
- **UnloadTimeout**: Configured unload timeout for the provider
- **CLSID**: Assigned CLSID for the provider

### Static.csv

This file contains the list of static classes with the following columns:

- **Namespace**: Where the static class is registered
- **Name**: Name of the static class
- **Inst**: Number of instances stored in the class
- **Size**: Estimated size of the class in bytes 

### Security.csv

This file contains the security configuration for each namespace with the following columns:

- **NameSpace**: Namespace with defined security
- **Security setting**: Type of access granted to each account

If you're troubleshooting repository bloating, the *Static.csv* file can help you identify which static class is using the most space.
