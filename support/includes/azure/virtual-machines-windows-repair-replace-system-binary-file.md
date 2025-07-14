---
author: genlin
ms.author: genli
ms.service: azure-virtual-machines
ms.topic: include
ms.date: 07/12/2024
ms.reviewer: jarrettr
---
#### Repair the corrupt binary file

Open an elevated CMD prompt and run chkdsk on the disk:

```cmd
chkdsk <drive-letter>: /F
```

#### Replace the corrupt binary file

1. On the attached disk, browse to the location of the binary file that's displayed in the error message.

1. Rename the file from *\<binary-name>.sys* to *\<binary-name>.sys.old*.

1. On the attached disk, browse to the *\\Windows\\WinSxS* folder. Then, search for the binary file that's displayed in the error message. To do this, run the following command at a command prompt:

   ```cmd
   dir <binary-name> /s
   ```

   The command lists all the different versions of the binary file together with the created date. Copy the latest version of the binary file to the *\\Windows\\System32\\Drivers* folder by running the following command:

   ```cmd
   copy <drive>:\Windows\WinSxS\<directory-where-file-is>\<binary-name>.sys <drive>:\Windows\System32\Drivers\
   ```

   For example, see the following console output:

   ```output
   E:\Windows\WinSxS>dir ACPI.sys /s 
    Volume in drive E has no label. 
    Volume Serial Number is A0B1-C2D3 
    
    Directory of E:\Windows\WinSxS\amd64_acpi.inf_0123456789abcdef_6.3.9600.16384_none_cdef0123456789ab 
    
   11/21/2014  07:48 PM            94,989 acpi.sys 
                  1 File(s)         94,989 bytes 
    
    Directory of E:\Windows\WinSxS\amd64_acpi.inf_0123456789abcdef_6.3.9600.16384_none_89abcdef01234567 
    
   11/21/2014  07:48 PM           119,547 acpi.sys 
                  1 File(s)        119,547 bytes 
    
    Directory of E:\Windows\WinSxS\amd64_acpi.inf_0123456789abcdef_6.3.9600.16384_none_456789abcdef0123 
    
   11/21/2014  04:06 PM           533,824 acpi.sys 
                  1 File(s)        533,824 bytes 
    
        Total Files Listed: 
                  3 File(s)        748,360 bytes 
                  0 Dir(s)  123,967,512,576 bytes free 
    
   E:\Windows\WinSxS>copy E:\Windows\WinSxS\amd64_acpi.inf_0123456789abcdef_6.3.9600.16384_none_cdef0123456789ab\acpi.sys E:\Windows\System32\Drivers\ 
           1 file(s) copied. 
    
   E:\Windows\WinSxS> 
   ```

   > [!NOTE]
   >
   > - If the system binary file can't be renamed, [take ownership of the file](/windows-server/administration/windows-commands/takeown). This action gives you full access to this file.
   >
   > - The example console output shows volume *E* as an example. The actual letter should reflect the faulty drive (the OS disk attached as a data disk on the troubleshooting VM).
   >
   > - If the latest binary doesn't work, you can try the previous file version to obtain an earlier system update level on that component.
   >
   > - If the only binary that's returned in this step matches the file that you're trying to replace on the affected VM, and if both files have the same size and time stamp, you can replace the corrupted file by copying it from another working VM that has the same OS and, if possible, the same system update level.

1. Detach the repaired disk from the troubleshooting VM. Then, [create a VM from the OS disk](/azure/virtual-machines/attach-os-disk).
