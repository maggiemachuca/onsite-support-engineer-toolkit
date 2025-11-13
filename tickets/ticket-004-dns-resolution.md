# 📝 Ticket 004 – DNS Resolution Failure (Intermittent Name Lookup Issues)
*An anonymized recreation based on the types of DNS/network tickets I handled during my internship.*

---

## 🆔 **Ticket Summary**

**Issue:** User reports intermittent internet access; some websites load, others do not. Apps dependent on DNS (Teams, Outlook) also fail.  
**User Impact:** Productivity slowed; unable to access multiple cloud services.  
**Priority:** P2 – Medium to high impact isolated to one workstation.  
**SLA:** Response within 1 hour, resolution within 8 hours.

---

## 👤 **User Information**

- **User:** A.R.  
- **Department:** Finance  
- **Device:** WIN-FIN-013  
- **Network:** Wired (Office LAN)  
- **Location:** Building A, 3rd Floor  

---

## 📅 **Timeline**

| Time | Action |
|------|--------|
| 11:21 | Ticket received |
| 11:25 | Contacted user & confirmed symptoms |
| 11:29 | Performed remote diagnostics |
| 11:37 | Identified incorrect DNS server assigned via DHCP |
| 11:44 | Corrected DHCP DNS assignment + flushed local DNS |
| 11:51 | Verified all services working |
| 12:02 | Ticket documented & closed |

---

## 🔍 **Initial Triage Questions**

- “Are you connected via Wi-Fi or Ethernet?”  
  ➡️ *Ethernet.*

- “Do all websites fail, or only some?”  
  ➡️ *Some load, others don’t.*

- “Is Teams or Outlook having connection issues?”  
  ➡️ *Teams fails to log in; Outlook stuck on ‘Disconnected’.*

- “Has this happened before?”  
  ➡️ *No.*

These symptoms strongly pointed to a **DNS issue**, not bandwidth or firewall.

---

## 🛠️ **Troubleshooting Steps**

### **1. Tested Basic Connectivity**

- Verified ping to 8.8.8.8 → **Success**
- Verified ping to google.com → **Failure**
- Verified ping to intranet server by hostname → **Failure**
- Ping by IP to intranet server → **Success**

These tests confirmed **network connectivity is fine** → the problem is **name resolution**.

---

### **2. Checked Current DNS Settings**

Ran:

```
ipconfig /all
```

Observed:

```
DNS Servers . . . . . : 10.10.99.99 (incorrect)
                         8.8.8.8
```

The first DNS server `10.10.99.99` **was not one of our internal DNS servers**.  
This caused inconsistent name resolution.

---

### **3. Validated DHCP Scope**

Checked DHCP scope for the Finance VLAN:

- Primary DNS should be `10.10.1.20`  
- Secondary DNS should be `10.10.1.21`  

The user's device had inherited an incorrect DNS entry due to a **misconfigured static DNS override** on a switch port for testing earlier by another technician.

---

### **4. Corrected DNS Assignment**

Steps performed:

- Cleared incorrect DNS entry by resetting the network adapter  
- Forced DHCP renewal:

```
ipconfig /release
ipconfig /renew
```

- Verified new assignment:

```
DNS Servers . . . . . : 10.10.1.20
                         10.10.1.21
```

### **5. Flushed Local DNS Cache**

```
ipconfig /flushdns
```

### **6. Restarted Network Services**

```
net stop dnscache
net start dnscache
```

---

## ✔ **Issue Resolved**

**Cause:**  
Incorrect DNS server assigned via DHCP due to misconfigured switch port override.

**Fix:**  
Corrected DNS assignment, forced DHCP renewal, flushed DNS cache, restarted DNS client service.

---

## 🔎 **Verification Steps**

- google.com resolves normally  
- Outlook connected instantly  
- Teams logged in successfully  
- Intranet site resolved via hostname  
- No packet loss detected  
- User confirmed all web apps working  

---

## 🔁 **Escalation (If Needed)**

Not required.

If the issue persisted, escalation steps would include:

- Checking DNS server health  
- Reviewing zone transfers  
- Investigating DNS scavenging  
- Checking switch port configuration further  
- Opening a ticket with the networking team

---

## 🧾 **User Communication**

**Initial contact:**  
> “Hi A.R., I’m reviewing the connectivity issues you're seeing. It looks like we may be dealing with a name resolution problem. I’ll run a few tests and update you shortly.”

**Update during fix:**  
> “I found your device was using an incorrect DNS server. I’m correcting that now and refreshing your network settings.”

**Resolution:**  
> “Everything should be working now. I verified Teams, Outlook, and several websites. Please let me know if you see any issues throughout the day.”

---

## 📚 **Technician Notes**

- Incorrect DNS server discovered (`10.10.99.99`)  
- Correct DNS served after renewing DHCP lease  
- Updated internal notes regarding Finance VLAN switch port configuration  
- Suggested auditing switch port overrides in Building A  
- User confirmed no further issues  

---

# 🟢 **Status: Closed**

