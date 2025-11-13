# 🧑‍💻 Add New Active Directory User  
*IT Glue–style documentation for creating a new user account in Active Directory.*

---

## 📌 Purpose
Provide a standardized process for creating a new user account in Active Directory, ensuring correct OU placement, username formatting, and security compliance.

---

## 📍 Applies To
- Windows Server (AD Domain Services)  
- Hybrid AD + Azure AD environments  
- New hires and contractors  

---

# 🛠️ Steps to Create a New AD User

---

## **1. Open Active Directory Users & Computers (ADUC)**

- Launch **ADUC** from RSAT tools  
- Ensure you are connected to the correct domain  
- Confirm you have proper permissions  

---

## **2. Navigate to the Correct Organizational Unit (OU)**

Typical structure:

```
Company.com
 └── Users
      └── Department OU (e.g., Sales, Accounting)
```

Placing users in the wrong OU can break:
- Group Policy inheritance  
- Login scripts  
- Security group auto-assignment  
- Azure AD sync  

---

## **3. Create the User**

Right-click inside the OU:  
**New → User**

Fill out:

- First Name  
- Last Name  
- Full Name  
- User Logon Name (username)  

**Username best practices:**
- first initial + last name  
- e.g., jdoe or mrodriguez  

---

## **4. Set Initial Password**

Enter a strong temporary password.

Check:

- ✔ “User must change password at next logon”  
- ✔ “User cannot change password” → **Do NOT enable**  
- ✔ “Password never expires” → **DO NOT check unless specifically approved**  

Click **Next → Finish**.

---

## **5. Assign Security Groups (DO NOT SKIP)**

User will have *no access* until placed in proper groups.

Examples:

- Department group  
- Shared drive groups  
- Printer access groups  
- VPN group (if applicable)  
- Application-specific groups  

Document all group assignments.

---

## **6. Verify Azure Sync (If Hybrid Environment)**

Check Azure AD Connect:

```
Start-ADSyncSyncCycle -PolicyType Delta
```

Verify that the user appears in Azure AD within 5–15 minutes.

---

## **7. Notify Manager & Create Ticket Notes**

Document:

- Username  
- Email created  
- Groups assigned  
- Laptop assigned (if applicable)  
- Any special access requested  

---

# ✔ Status: Published (Ready for Use)
