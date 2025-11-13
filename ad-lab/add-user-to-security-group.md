# 🔒 Add User to Active Directory Security Group  
*IT Glue–style documentation for granting or modifying access via AD security groups.*

---

## 📌 Purpose
Standardize the process for adding users to Active Directory security groups to ensure correct permissions for shared folders, applications, and department resources.

---

## 📍 Applies To
- Windows Server AD  
- Hybrid AD + Azure AD  
- All departments  

---

# 🛠️ Steps to Add User to a Security Group

---

## **1. Open Active Directory Users & Computers (ADUC)**

- Launch **ADUC**  
- Navigate to the domain  
- Ensure you are connected to the correct OU structure  

---

## **2. Locate the User**

Search by:

- Username  
- First or last name  
- Email address  

Right-click user → **Properties**.

---

## **3. Open the "Member Of" Tab**

This tab displays all security groups the user currently belongs to.

Check for:

- Department groups  
- Shared folder groups  
- App-specific groups  
- VPN or remote access groups  

---

## **4. Add the User to the Required Group**

Click **Add → Advanced → Find Now**  
(or type the group name directly)

Common group types:

- `SG-<Dept>-Share-RW`  
- `SG-<Dept>-Share-RO`  
- `SG-Software-<AppName>`  
- `VPN-Access`  
- `Remote-Desktop-Users`  

Select group → **OK**.

---

## **5. Confirm Membership Updated**

After adding the user:

- Ensure the group appears under “Member Of”  
- Double-check group names (similar names are common)  
- Document change in ticket  

---

## **6. Force a Token Refresh (User Side)**

Have the user:

1. Sign out of Windows (not lock)  
2. Wait 10–20 seconds  
3. Sign back in  

Alternatively run:

```
klist purge
```

This refreshes Kerberos tokens so new permissions apply.

---

## **7. Test Permissions**

Verify the user can:

- Access the shared folder  
- Open required applications  
- Print (if printer group)  
- Use VPN (if VPN group)  

If not working:
- Run `gpupdate /force`  
- Check GPO errors  
- Confirm NTFS permissions match the group  

---

# 🧾 Escalation Path

Escalate if:

- Permissions not applying after group change  
- GPO not updating  
- NTFS folder permissions misconfigured  
- User appears in group but access still denied  

Escalate to:

- Systems Administrator  
- Domain Admin (if restricted group)

---

# ✔ Status: Published (Ready for Use)
