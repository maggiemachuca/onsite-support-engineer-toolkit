# 📝 Ticket 008 – Slow Workstation (Performance Degradation)
*An anonymized recreation based on the types of workstation performance issues I handled during my internship.*

---

## 🆔 **Ticket Summary**

**Issue:** User reports workstation running slow when opening applications; frequent freezing and delays.  
**User Impact:** Productivity significantly reduced.  
**Priority:** P2 – User operational but impaired.  
**SLA:** Response within 1 hour, resolution within 8 hours.

---

## 👤 **User Information**

- **User:** H.R.  
- **Department:** Customer Service  
- **Device:** WIN-CS-029  
- **Operating System:** Windows 10  
- **Location:** Building C, 2nd Floor  

---

## 📅 **Timeline**

| Time | Action |
|------|--------|
| 08:57 | Ticket received |
| 09:01 | Contacted user & confirmed symptoms |
| 09:07 | Remoted into workstation |
| 09:18 | Identified high disk usage from Windows Search indexing |
| 09:29 | Disabled indexing + cleared temp files |
| 09:41 | Verified system performance improvement |
| 09:53 | Ticket documented & closed |

---

## 🔍 **Initial Triage Questions**

- “How long has the computer been running slow?”  
  ➡️ *Started this morning.*

- “Does this happen when opening specific programs or everything?”  
  ➡️ *Mainly Outlook, Teams, Chrome.*

- “Have you recently rebooted?”  
  ➡️ *Not today.*

- “Do you see any specific error messages?”  
  ➡️ *No errors, just freezing.*

This suggested a **resource utilization issue** rather than application corruption.

---

## 🛠️ **Troubleshooting Steps**

### **1. Checked Task Manager for Resource Bottlenecks**

Opened Task Manager:  
Observed:

- **Disk usage at 100%**  
- Process `SearchIndexer.exe` repeatedly spiking  
- CPU normal (18–23%)  
- Memory normal (6/16 GB used)

Confirmed bottleneck = **disk I/O**.

---

### **2. Ran System Diagnostics**

Checked Event Viewer for disk-related warnings:

```
Applications and Services Logs →
Microsoft →
Windows →
Diagnostics-Performance
```

Found entries indicating:

- Slow boot times  
- Delays caused by Windows Search Indexing  

No SMART errors or disk health warnings.

---

### **3. Disabled Windows Search Indexing Temporarily**

Ran the following to stop service:

```
net stop "Windows Search"
```

Improvement observed immediately.

Set Windows Search service to **Automatic (Delayed Start)** instead of Standard Automatic to reduce boot load.

---

### **4. Cleared Temporary Files**

Executed:

```
%temp%
temp
prefetch
```

Deleted unnecessary cached files.  
Cleared browser cache (Chrome & Edge).

---

### **5. Checked Startup Applications**

Disabled unnecessary startup items including:

- Microsoft OneDrive auto-launch  
- Teams auto-start  
- Adobe auto-updater  

Left essential apps intact.

---

### **6. Restarted Workstation & Re-tested**

After restart:

- Disk usage stabilized at 5–15%  
- Apps opened normally  
- No freezing observed  
- User confirmed noticeable performance improvement  

---

## ✔ **Issue Resolved**

**Cause:**  
Excessive disk usage caused by Windows Search Indexing combined with heavy startup applications.

**Fix:**  
Stopped indexing temporarily, optimized startup apps, cleared caches, restarted workstation.

---

## 🔎 **Verification Steps**

- Task Manager disk usage under 20%  
- Apps open within normal time  
- No freezing  
- Outlook, Teams, Chrome tested  
- User confirmed improvement  
- Event Viewer showed no critical warnings post-fix  

---

## 🔁 **Escalation (If Needed)**

Not required.

Would escalate if:

- SMART drive errors detected  
- Drive latency persisted after temp file cleanup  
- System logs indicated bad sectors  
- RAM or CPU throttling occurred  
- Reimage was required  

---

## 🧾 **User Communication**

**Initial:**  
> “Hi H.R., I see you're experiencing performance issues. I’ll take a look remotely and figure out what’s causing the slowdown.”

**During troubleshooting:**  
> “It looks like something is using up a lot of disk activity. I’m clearing temporary files and adjusting your indexing and startup settings.”

**Resolution:**  
> “Your computer should be running much better now. Disk usage has normalized and everything is opening quickly. Let me know if the issue returns.”

---

## 📚 **Technician Notes**

- High disk usage traced to Search Indexer service  
- Disabled unnecessary startup apps  
- Cleared temp files & browser cache  
- Verified stable performance after restart  
- Recommended weekly reboot to avoid buildup  

---

# 🟢 **Status: Closed**

