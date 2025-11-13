# 📝 Ticket 005 – Drive Mapping Issue (Network Drive Not Accessible)
*An anonymized recreation based on the types of drive mapping & network resource issues I handled during my internship.*

---

## 🆔 **Ticket Summary**

**Issue:** User unable to access shared network drive. Drive letter shows a red X and “Location is not available” when clicked.  
**User Impact:** Cannot access shared department resources.  
**Priority:** P2 – Productivity impact for a single user; time-sensitive.  
**SLA:** Response within 1 hour, resolution within 8 hours.

---

## 👤 **User Information**

- **User:** C.P.  
- **Department:** Operations  
- **Device:** WIN-OPS-027  
- **Shared Drive:** `O:\Operations-Share`  
- **Location:** Building D, 1st Floor  

---

## 📅 **Timeline**

| Time | Action |
|------|--------|
| 09:16 | Ticket received |
| 09:20 | Contacted user and confirmed issue |
| 09:26 | Performed remote diagnostics |
| 09:34 | Identified GPO mapping failure after password change |
| 09:43 | Re-applied GPO + purged stale credentials |
| 09:51 | Verified user could access O: drive |
| 10:00 | Ticket documented & closed |

---

## 🔍 **Initial Triage Questions**

- “Has this drive worked before?”  
  ➡️ *Yes, I use it every day.*

- “Does the drive letter show a red X or does it disappear entirely?”  
  ➡️ *Red X.*

- “Can you access other network resources?”  
  ➡️ *Yes — Teams, email, and intranet all work.*

- “Did you recently change your password?”  
  ➡️ *Yes — yesterday morning.*

These answers pointed toward a **credential mismatch** or **GPO not applying** after password change.

---

## 🛠️ **Troubleshooting Steps**

### **1. Tested Path Accessibility**

User reported:  
Trying to open:

```
O:\Operations-Share
```

Returned:  
> “Location is not available.”

Tested UNC path:

```
\\fileserver01\Operations-Share
```

UNC path opened **successfully**, indicating:

✔ File server online  
✔ User has permissions  
❌ Drive mapping failed locally

---

### **2. Checked Group Policy Drive Mapping**

Ran:

```
gpresult /r
```

Observed:

- GPO “Department Drive Mappings” **not applied**
- Security filtering was correct
- User’s login event showed stale credentials from before password change

This aligned with a **credential caching issue blocking GPO application**.

---

### **3. Cleared Stored Credentials**

Opened Credential Manager:  
Removed all entries referencing:

- `fileserver01`
- `\\fileserver01`
- `Operations-Share`
- Stale AD entries

---

### **4. Forced Group Policy Refresh**

Ran:

```
gpupdate /force
```

Output confirmed successful application:

```
User Policy update has completed successfully.
```

Verified with:

```
gpresult /r
```

Now showed:

```
Applied Group Policy Objects:
    Department Drive Mappings
```

---

### **5. Restarted Workstation**

After restart:

- Drive auto-mapped correctly  
- Red X disappeared  
- Drive accessible normally  

---

## ✔ **Issue Resolved**

**Cause:**  
Drive mapping GPO failed due to stale cached credentials after password change.

**Fix:**  
Cleared credential cache, applied updated GPO, and restarted workstation.

---

## 🔎 **Verification Steps**

- O: drive accessible  
- Able to open, modify, and save files  
- Verified permissions in the shared folder  
- Confirmed persistent mapping after logout/login  
- No additional drive mapping errors in Event Viewer  

---

## 🔁 **Escalation (If Needed)**

Not required.

Would escalate if:

- GPO didn't apply (may require sysadmin review)  
- File server permissions were incorrect  
- SYSVOL replication issues detected  
- Netlogon errors observed  

---

## 🧾 **User Communication**

**Initial message:**  
> “Hi C.P., I’m reviewing the issue with the Operations shared drive. I’ll run some diagnostics and update you shortly.”

**Mid-fix update:**  
> “It appears the drive mapping didn’t update after your password change. I’m refreshing your credentials and reapplying your group policy now.”

**Resolution:**  
> “Your O: drive should now be mapped correctly. I verified access and everything looks good. Please let me know if it drops again.”

---

## 📚 **Technician Notes**

- UNC path worked, indicating network and permissions were intact  
- GPO mapping missing due to stale credentials  
- Cleared credential manager entries + forced GPO sync  
- Updated internal notes with steps for drive mapping failure after password change  
- User confirmed issue fully resolved  

---

# 🟢 **Status: Closed**
