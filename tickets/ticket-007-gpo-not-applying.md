# 📝 Ticket 007 – GPO Not Applying (Policy Not Updating on Workstation)
*An anonymized recreation based on the types of GPO & workstation policy issues I handled during my internship.*

---

## 🆔 **Ticket Summary**

**Issue:** User workstation not receiving updated Group Policies. New drive mapping and desktop restrictions not applying.  
**User Impact:** Drive mapping required for daily tasks; missing policies causing inconsistent behavior.  
**Priority:** P3 – Medium impact.  
**SLA:** Response within 4 hours, resolution within 24 hours.

---

## 👤 **User Information**

- **User:** D.S.  
- **Department:** Sales  
- **Device:** WIN-SALES-014  
- **GPO Affected:** `Sales-Workstation-Policy`, `Department-Drive-Mappings`  
- **Location:** Building A, 2nd Floor  

---

## 📅 **Timeline**

| Time | Action |
|------|--------|
| 14:09 | Ticket received |
| 14:14 | Contacted user & confirmed symptoms |
| 14:20 | Collected workstation logs & ran gpresult |
| 14:31 | Identified GPO version mismatch + SYSVOL replication delay |
| 14:42 | Forced policy refresh + corrected DFS path issue |
| 14:55 | GPO applied successfully |
| 15:10 | Ticket documented & closed |

---

## 🔍 **Initial Triage Questions**

- “Has this workstation received policies before?”  
  ➡️ *Yes, normally works fine.*

- “Is this affecting only you or others in Sales?”  
  ➡️ *Just me.*

- “Any recent changes? Password reset? Computer rename? Move to a new location?”  
  ➡️ *System restarted this morning after updates.*

- “Are you connected to the office network (no VPN)?”  
  ➡️ *Yes.*

Common on-prem scenario → workstation can’t read updated policies from **SYSVOL** or **NetLogon**.

---

## 🛠️ **Troubleshooting Steps**

### **1. Verified Basic GPO Application Status**

Ran:

```
gpresult /r
```

Observed:

- `Sales-Workstation-Policy` **missing**
- `Department-Drive-Mappings` showing version **outdated (v5)**  
- Latest version in AD was **v8**

Confirmed workstation not retrieving updated GPOs.

---

### **2. Checked Network Path Access to SYSVOL**

Tested:

```
\\domain.local\SYSVOL
\\domain.local\NETLOGON
```

Results:

- Accessed successfully, but **slow response time**  
- SYSVOL from one DC unreachable:  
  ```
  \\DC02.domain.local\SYSVOL → Access Denied / timeout
  ```

This suggested a **DFSR replication lag** or DC connectivity issue.

---

### **3. Forced Domain Controller Re-Election (Workstation Side)**

Ran:

```
nltest /dsgetdc:domain.local
```

Workstation was using **DC02**, the problematic DC.

Forced workstation to query new DC:

```
ipconfig /flushdns
nltest /dsgetdc:domain.local
```

Now using **DC01** (healthy DC).

---

### **4. Forced Group Policy Refresh**

Ran:

```
gpupdate /force
```

Output confirmed:

```
User Policy update has completed successfully.
Computer Policy update has completed successfully.
```

---

### **5. Re-Ran gpresult**

```
gpresult /r
```

Now showed:

```
Applied Group Policy Objects
    Sales-Workstation-Policy (v8)
    Department-Drive-Mappings (v8)
```

Drive mappings restored.  
Desktop restrictions applied.

---

## ✔ **Issue Resolved**

**Cause:**  
Workstation was attempting to pull GPOs from a domain controller experiencing **SYSVOL replication delays**, resulting in outdated policy data.

**Fix:**  
Refreshed DC assignment, forced GPO update, and validated mappings.

---

## 🔎 **Verification Steps**

- Drive mapping visible & accessible  
- Printer mapping applied  
- Desktop restrictions applied  
- Login script executed normally  
- No errors in Event Viewer under:  
  ```
  Applications and Services Logs → Microsoft → Windows → GroupPolicy
  ```

---

## 🔁 **Escalation (If Needed)**

Not required.

Would escalate if:

- SYSVOL replication errors persisted  
- DC02 repeatedly showed DFSR backlog  
- Policies failed to apply after multiple `gpupdate` attempts  
- GPO permissions were misconfigured  

---

## 🧾 **User Communication**

**Initial:**  
> “Hi D.S., I’m checking why your workstation isn’t receiving updated policies. I’ll run a few tests and update you shortly.”

**Update:**  
> “Your computer was pulling group policies from a domain controller that wasn’t fully synced. I’m correcting that now.”

**Resolution:**  
> “All policies have been applied, and your drive mappings and workstation settings should now be fully updated. Let me know if anything looks off.”

---

## 📚 **Technician Notes**

- GPO version mismatch detected  
- Workstation directed to problematic DC  
- Forced DC re-evaluation resolved issue  
- Policies applied successfully afterward  
- Updated documentation on handling GPO sync issues  

---

# 🟢 **Status: Closed**

