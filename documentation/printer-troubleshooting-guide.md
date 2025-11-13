# 🖨️ Printer Troubleshooting Guide  
*IT Glue–style documentation for resolving common printer issues.*

---

## 📌 Purpose
Provide a standardized step-by-step procedure for diagnosing and resolving common printer issues, including offline status, connection failures, print spooler problems, and network configuration errors.

This runbook follows MSP best practices and is designed for use during onsite and remote support sessions.

---

## 📍 Applies To
- Windows 10 / 11 workstations  
- Network printers (shared via print server or direct IP)  
- Local USB printers  
- Onsite or remote troubleshooting  

---

## 🧩 Prerequisites
Before beginning:

- Technician must have RMM/remote access to the workstation  
- Access to printer web interface (if networked)  
- Knowledge of print server layout (if applicable)  
- Permissions to restart print spooler service  

---

# 🛠️ Step-by-Step Troubleshooting

---

## **1. Gather Initial Information**

Ask the user:

- “Is the printer showing any errors on the display screen?”
- “Is this happening to just you or other users?”
- “Are you printing to the correct printer?”
- “Is this printer networked or plugged into your computer?”
- “Did this work earlier today or yesterday?”

**Document answers in the ticket.**

---

# **2. Check Printer Status in Windows**

### **Windows Settings → Bluetooth & Devices → Printers & Scanners**

Common issues to look for:

- ❌ “Offline”  
- ❌ “Driver unavailable”  
- ❌ Red X on printer icon  
- ❌ Using wrong printer queue (often duplicates exist)  

If duplicate queues exist:

➡️ Remove all queues  
➡️ Reinstall using the correct method (see Step 6)

---

# **3. Verify Network Reachability (For Network Printers)**

### **Ping the printer:**

```
ping <printer-ip>
```

Results:

- ✔ Success → Move to next step  
- ❌ Failure → Check cabling, switch port, IP assignment, VLAN  

### **Access printer web interface:**

```
http://<printer-ip>
```

If accessible → Printer is online  
If not → Issue is at the printer or network layer

---

# **4. Check Physical Printer Status (Onsite)**

Verify:

- Printer is powered on  
- No paper jams  
- No low toner errors stopping printing  
- NIC lights are blinking  
- Printer has valid IP address  
- Printer is connected to correct port  

If printer is frozen → reboot gently.

---

# **5. Check the Print Spooler**

### Stop the spooler:

```
net stop spooler
```

### Clear the spool folder:

```
C:\Windows\System32\spool\PRINTERS
```

Delete all files.

### Restart the spooler:

```
net start spooler
```

Have the user retry printing.

---

# **6. Reinstall the Printer (Recommended Method)**

### **A. For Print Server–Managed Printers**

1. Remove existing printer  
2. Run:

```
\\printserver
```

3. Double-click printer name to reinstall  
4. Let driver reinstall automatically  

---

### **B. For Direct IP Printers**

1. Remove existing printer  
2. Go to:

```
Printers & Scanners → Add Device → Add Manually
```

3. Choose:  
   **“Add a printer using TCP/IP address or hostname”**

4. Enter IP address  
5. Uncheck:  
   **“Query the printer…”**  
6. Select proper driver  

---

# **7. Check User Permissions (Print Server Shares)**

On print server:

- Verify user or group is in **Print/Manage Docs** permissions  
- Ensure no Deny permissions  
- Check if the queue is paused  

Correct as needed.

---

# **8. Check for IP Conflicts**

If printer intermittently drops offline:

- Confirm it has a **DHCP reservation**  
- Or set a **static IP** outside DHCP pool  
- Verify no duplicate devices on ARP table  

---

# **9. Update or Reinstall Drivers**

Old drivers can cause:

- Delayed printing  
- Unresponsive queues  
- Spooler crashes  

Download from manufacturer website or update driver via print server.

---

# **10. Test Printing**

Have the user:

- Print a Test Page  
- Print from Outlook or Adobe (these often reveal driver issues)  
- Print from a browser  

Confirm:

- ✔ No latency  
- ✔ No queue hang  
- ✔ No “printer offline” messages  

---

# 🧾 Escalation Path

Escalate if:

- Printer unreachable at network level  
- VLAN or switch port misconfiguration suspected  
- Repeating IP conflicts  
- Printer firmware outdated or corrupt  
- Multiple users affected simultaneously  
- Suspected ISP or network outage affecting cloud print management  

Escalate to:

- Networking Team  
- Printer Vendor  
- ISP (if cloud-managed printers lose connectivity)  
- Internal SysAdmin for print server issues  

---

# 📚 Notes / Best Practices

- Always document the printer’s **IP**, **location**, **model**, and **user impact**.  
- Avoid adding printers using WSD — always use **Standard TCP/IP**.  
- Rebooting the printer solves 40% of issues.  
- Clearing the spooler solves another 30%.  
- Most “printer offline” issues are IP conflicts or stale driver queues.  

---

# ✔ Status: Published (Ready for Use)
