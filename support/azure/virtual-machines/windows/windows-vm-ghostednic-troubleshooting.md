
# Troubleshooting: Multiple Mellanox Ethernet Adapters After VM Deallocation (Ghost NICs)

> [!NOTE]
> For VMs **without Accelerated Networking**, MAC addresses can be reserved at the software layer (virtual switch), so this issue does not occur.
> Learn more: [Accelerated Networking overview](https://learn.microsoft.com/azure/virtual-network/accelerated-networking-overview)

## Symptom
When an Azure Virtual Machine running Windows Server or Windows Client with **Accelerated Networking** enabled is **deallocated**, the following may occur:

- No connectivity issues occur for the active NIC
- Interfere with scripts or automation that enumerate NICs
- Lead to stale IP configurations associated with removed adapters.
- Windows Update failures
- Performance issues that may be unexplainable
- Windows Activation failures

> **Note:**
> This issue does **not** occur when the VM is shut down from inside the OS without deallocation.
> if there are over 500+ ghosted nics, there is a larger negative impact to the VM.

## Cause

- This behavior typically occurs after:
  - **Stop (deallocate)** and **Start** operations via the Azure Portal, CLI, or PowerShell.
  - VM redeployment or host migration events

This behavior is **by design** due to the architecture of Accelerated Networking:

- When you **stop (deallocate)** a VM, it is removed from its current physical host.
- When you **start** the VM again, it is allocated to a different physical server in the datacenter.
- Each physical server has a **unique hardware MAC address**.
- Because Accelerated Networking **bypasses the virtual switch for performance**, the OS cannot reuse the previous MAC address. As a result, the old NIC becomes a **ghosted device**.


The Product Group is evaluating improvements, but there is **no ETA** for this feature.

## Resolution

## **Recommended Actions – When VM Is Accessible**

### **1. Detect the Scenario**
Use **RunCommand** to check for ghosted NICs:  
[Ghosted NIC Check Script](https://github.com/Azure/azure-support-scripts/tree/master/GhostedNIC_Check_Time_warning)


### **2. Clean Up Ghosted NICs**

**Option A: Manual Removal via Device Manager**
- Open **Device Manager** → **View** → **Show hidden devices** → Remove ghosted NICs.

**Option B: Force Removal via RunCommand**
- Use RunCommand to check then remove ghosted NICs:  
https://github.com/Azure/azure-support-scripts/tree/master/RunCommand/Windows/Windows_GhostedNIC_Removal_time


### **3. Plan for Design Behavior**
If Accelerated Networking is required for performance:

- Expect ghosted NICs after VM deallocation.
- Include NIC cleanup in your regular maintenance process by **scheduling a task monthly**.

- [Azure Accelerated Networking overview](https://learn.microsoft.com/azure/virtual-network/accelerated-networking-overview)
- [Azure Virtual Network Interface](hhttps://learn.microsoft.com/azure/virtual-network/virtual-network-network-interface)
- [Cause: Azure Instance Metadata Service connection issue](ghosted-nic-troubleshoot#Cause)
- [Azure VM - Windows Ghosted NIC Check Warning Script](https://github.com/Azure/azure-support-scripts/tree/master/GhostedNIC_Check_Time_warning)
- [Azure VM - Windows Ghosted NIC Check Removal Script](https://github.com/Azure/azure-support-scripts/tree/master/RunCommand/Windows/Windows_GhostedNIC_Removal_time)

[!INCLUDE [azure-help-support](~/includes/azure-help-support.md)]

[!INCLUDE [Third-party contact disclaimer](~/includes/third-party-contact-disclaimer.md)]