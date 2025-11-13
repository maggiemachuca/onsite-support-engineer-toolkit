# 📝 Ticket 006 – AD Group Membership Issue (User Missing Required Access)
*An anonymized recreation based on the types of Active Directory access issues I handled during my internship.*

---

## 🆔 **Ticket Summary**

**Issue:** User unable to access department shared folder; permission denied.  
**User Impact:** Cannot access required files for daily workload.  
**Priority:** P2 – Productivity blocker for single user.  
**SLA:** Response within 1 hour, resolution within 8 hours.

---

## 👤 **User Information**

- **User:** K.M.  
- **Department:** Marketing  
- **Device:** WIN-MKT-011  
- **Resource:** `\\fileserver02\Marketing-Share`  
- **Location:** Building B, 1st Floor  

---

## 📅 **Timeline**

| Time | Action |
|------|--------|
| 13:42 | Ticket received |
| 13:46 | Contacted user & confirmed symptoms |
| 13:52 | Verified user permissions in AD |
| 13:58 | Added user to correct security group |
| 14:05 | Forced token refresh + user re-log |
| 14:11 | Verified access working |
| 14:20 | Ticket updated & closed |

---

## 🔍 **Initial Triage Questions**

- “Did this access ever work for you previously?”  
  ➡️ *Yes, earlier this week.*

- “Are other team members able to access the folder?”  
  ➡️ *Yes, others can access normally.*

- “What specific error appears when you try to open it?”  
  ➡️ *‘You do not have permission to access this resource.’*

- “Did you recently change your password or move departments?”  
  ➡️ *Password changed, but no department move.*

This pointed toward a **group membership issue** or a **cached permission token**.

---

## 🛠️ **Troubleshooting Steps**

### **1. Verified Effective Permissions**

Tested UNC path:

```
\\fileserver02\Marketing-Share
```

User received:

> “Access Denied.”

Confirmed user could access other shared folders → permissions issue isolated.

---

### **2. Checked AD Security Group Membership**

Opened ADUC and reviewed user:

- User **was not** a member of:  
  `SG-Marketing-Share-RW`  
  (required read/write group)

- Confirmed group contains all other Marketing users  
- Noted user’s account recently had password reset → possible removal/misconfiguration

---

### **3. Added User to Required Security Group**

Added user to:

```
SG-Marketing-Share-RW
```

Verified group membership replicated across domain controllers.

---

### **4. Forced Kerberos Token Refresh**

Instructed user to:

1. Sign out of Windows completely (not lock screen)  
2. Sign back in after ~20 seconds  

This refreshes the Kerberos ticket-granting token (new permissions).

Alternatively, could run:

```
klist purge
```

—but full sign-out is simpler for end users.

---

### **5. Re-tested Folder Access**

After re-login:

- User opened `Marketing-Share` successfully  
- Confirmed read/write permissions  
- Verified user could open subfolders  
- Tested saving a file → success  

---

## ✔ **Issue Resolved**

**Cause:**  
User missing from required AD security group, likely due to an earlier account update or membership change during password reset.

**Fix:**  
Added user to correct group, forced token refresh, verified access.

---

## 🔎 **Verification Steps**

- User able to browse Marketing share  
- Verified permissions inherited correctly  
- Confirmed no Access Denied prompts  
- Tested read/write access  
- Checked Event Viewer for permission errors → none present  

---

## 🔁 **Escalation (If Needed)**

Not required.

Would escalate if:

- Group membership did not replicate across DCs  
- Token refresh failed  
- File server NTFS permissions did not match AD groups  
- SYSVOL or replication errors observed  

---

## 🧾 **User Communication**

**Initial contact:**  
> “Hi K.M., I see you're having trouble accessing the Marketing shared folder. I’m checking your permissions now and will update you shortly.”

**Update:**  
> “You were missing a required permission group for that share. I’ve added you and will have you sign out and back in to refresh your access.”

**Resolution:**  
> “You should now have full access to the Marketing share. I tested read/write permissions and everything looks good. Please let me know if anything behaves unexpectedly.”

---

## 📚 **Technician Notes**

- Missing AD group membership identified quickly  
- User added to correct Marketing security group  
- Access restored after Kerberos token refresh  
- Updated documentation for Marketing permission groups  
- Verified no NTFS mismatches present  

---

# 🟢 **Status: Closed**

