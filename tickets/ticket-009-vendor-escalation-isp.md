# 📝 Ticket 009 – ISP Vendor Escalation (Intermittent Packet Loss / Internet Degradation)
*An anonymized recreation based on the types of vendor escalation issues I handled during my internship.*

---

## 🆔 **Ticket Summary**

**Issue:** Multiple users reporting slow internet, dropped calls (VOIP), and intermittent inability to access cloud services. Packet loss observed on ping tests.  
**User Impact:** Building-wide productivity impact; VOIP calls degraded.  
**Priority:** P1 – High impact affecting multiple users.  
**SLA:** Immediate response required.

---

## 👤 **Location Information**

- **Site:** Building D  
- **Department Affected:** Customer Service & Warehouse staff  
- **Connection:** Fiber circuit (ISP: MetroNet)  
- **Router:** EdgeRouter-01  
- **Switch Stack:** SW-D-01 through SW-D-04  

---

## 📅 **Timeline**

| Time | Action |
|------|--------|
| 15:12 | First user report received |
| 15:15 | Confirmed widespread degradation |
| 15:18 | Performed network diagnostics |
| 15:25 | Identified 20–40% packet loss upstream |
| 15:29 | Opened ticket with ISP & escalated with logs |
| 15:42 | ISP acknowledged upstream issue on their side |
| 16:18 | ISP applied fix + rebooted affected upstream device |
| 16:30 | Verified normal connectivity |
| 16:45 | Ticket documented & closed |

---

## 🔍 **Initial Triage**

### Symptoms from users:
- Teams calls dropping  
- VOIP phones disconnecting  
- Cloud apps loading slowly  
- Webpages timing out intermittently  

### Confirmed:
Issue affected **multiple departments**, not a single workstation.

This immediately indicated a **network or ISP problem**, not a local device issue.

---

## 🛠️ **Troubleshooting Steps**

### **1. Verified Internal Network Health**

Checked:
- Switch CPU/memory → Normal  
- No spanning-tree loops  
- No port flapping  
- Internal pings (switch-to-switch) → 0% loss  

This confirmed:  
✔ LAN is healthy  
❌ Issue is external (WAN/ISP)

---

### **2. Ping Tests to External Targets**

Tested from firewall:

```
ping 8.8.8.8 -n 25
```

Result:

```
Packets: Sent = 25, Received = 18, Lost = 7 (28% loss)
```

Traceroute:

```
tracert 8.8.8.8
```

Showed heavy packet loss beginning at **ISP’s first hop**.

---

### **3. Confirmed Issue Across Multiple Endpoints**

Ran diagnostics from:
- Firewall  
- Windows workstation  
- Warehouse workstation  

Each showed:
- High latency  
- 20–40% packet loss  
- Intermittent connectivity  

---

### **4. Validated Router & Modem Status**

- Router CPU normal  
- No unusual logs  
- Interface to ISP showing **CRC errors** and **flapping**  
- Power-cycled router → No improvement  

Confirmed issue upstream, not onsite.

---

## 📞 **Vendor Escalation (ISP)**

### **Ticket opened with ISP:**  
**Provider:** MetroNet  
**Circuit ID:** MN-FBR-4432  
**Callback Number:** (###) ###-####  

### **Information Provided to ISP:**

```
Summary:
Building D experiencing intermittent connectivity and packet loss.

Tests performed:
- 20–40% packet loss to ISP gateway
- Traceroute shows loss starting at first hop
- LAN tests clean; no internal switches showing issues
- CRC errors observed on ISP-facing interface

Request:
Please investigate upstream routing and light levels on the circuit.
Issue appears on ISP side.
```

### **Attachments sent:**
- Ping logs  
- Traceroute output  
- Interface statistics screenshots  

### **ISP Response:**
At 15:42 → ISP confirmed issue on their aggregation switch feeding our circuit.

### **ISP Fix Applied:**
- Rebooted upstream device  
- Cleared routing table  
- Reprovisioned our circuit port  

---

## ✔ **Issue Resolved**

**Cause:**  
Upstream ISP aggregation switch instability causing packet loss on our fiber circuit.

**Fix:**  
ISP corrected upstream issue; network stabilized after their repairs.

---

## 🔎 **Verification Steps**

Performed from firewall & workstations:

- Ping stable (<20ms)
- 0% packet loss to 8.8.8.8  
- Teams calls tested  
- VOIP phones registered successfully  
- Cloud apps loading normally  
- No CRC errors on WAN interface  

User confirmation: ✔

---

## 🧾 **User Communication**

**Initial notice:**  
> “We’re seeing widespread connectivity issues. I’m running diagnostics now and will update everyone shortly.”

**During ISP escalation:**  
> “The issue appears to be upstream with our ISP. I’ve opened a priority ticket and provided diagnostics. I’ll update you as soon as they respond.”

**Resolution:**  
> “The ISP resolved the upstream issue and everything is stable again. I’ve confirmed connectivity, VOIP, Teams, and cloud access. Please report any lingering issues.”

---

## 📚 **Technician Notes**

- LAN environment verified healthy  
- WAN instability isolated to ISP  
- Provided extensive logs to expedite escalation  
- Updated internal documentation on escalation procedure  
- Added note to vendor contact list  

---

# 🟢 **Status: Closed**

