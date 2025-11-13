📝 Ticket 001 – Password Reset & MFA Sync Issue

Anonymized recreation based on the types of tickets I handled during my internship.

🆔 Ticket Summary

- <p><b>Issue:</b> User unable to log into Windows; password not accepted. Claims password was reset the previous day.</p>
- <p><b>User Impact:</b> Blocked from logging in (productivity halted).</p>
- <p><b>Priority:</b> P2 – User unable to work but issue isolated.</p>

- <p><b>SLA:</b> Response within 1 hour, resolution within 4 hours.</p>

👤 User Information

- <p>User: J.D.</p>

- <p>Department: Accounting</p>

- <p>Device: WIN-ACCT-044</p>

- <p>Location: Building B, 2nd Floor</p>

---

📅 Timeline
Time	Action
<p>08:12	Ticket received & acknowledged</p>
<p>08:15	Contacted user; confirmed the issue</p>
<p>08:17	Remoted into PC via RMM</p>
<p>08:23	AD password reset & MFA sync verified</p>
<p>08:28	User able to log in; tested Outlook + Teams</p>
<p>08:33	Ticket documented & closed</p>

🔍 Initial Triage Questions

<p>“When did you last successfully log in?”</p>
<p>➡️ Yesterday afternoon after resetting password.</p>

<p>“Have you recently changed your password via another device?”</p>
<p>➡️ Yes — user changed it from laptop at home.</p>

<p>“Are you seeing ‘incorrect password’ or another message?”</p>
<p>➡️ Incorrect password.</p>

<p>This indicated a password synchronization issue between Azure AD & on-prem AD.</p>

🛠️ Troubleshooting Steps
1. Verified Current AD Account Status

- Checked account in ADUC

- Account was not locked

- Noted timestamp showed password was changed ~18 hours ago

- Confirmed user is in correct security groups

2. Verified Password Sync Status

- Checked DirSync/Azure Sync status in the admin dashboard

- Password hash sync timestamp appeared slightly outdated

3. Reset Password Manually

- Reset password in ADUC

- Re-synced MFA via Azure portal

- Instructed user to use new, temporary password once onsite

4. Session Cache Clear

- Remotely restarted user’s machine

- Cleared cached credentials using control keymgr.dll

5. Walked User Through Login

- User successfully logged into Windows

- Forced password change on login

- Confirmed MFA prompt worked correctly

✔ Issue Resolved

<p>Cause: Password changed offsite did not fully sync between Azure and on-prem AD. Cached credentials prevented proper authentication.</p>
<p>Fix: Reset password in on-prem AD, forced resync, cleared cached credentials, and verified MFA.</p>

🔎 Verification Steps

- Login successful

- Outlook synced

- Teams signed in

- Mapped drives visible

- No further errors reported

🔁 Escalation (If Needed)

<p>Not required.</p>
<p>If issue persisted, next steps would have included:</p>

- Checking AD replication across domain controllers

- Reviewing Azure AD Connect health

- Checking logs under Applications and Services Logs → Directory Services

🧾 User Communication

<p><b>Initial response:</b></p>

<p>“Hi J.D., I’m reviewing your login issue now. I’ll give you a call in a few minutes so we can get you back into your account.”</p>

<p><b>Mid-troubleshooting update:</b></p>

<p>“I’m resetting your password and clearing cached credentials. I’ll stay on the line while you test.”</p>

<p><b>Completion:</b></p>

<p>“Your password and MFA are now fully synced and everything is working. If you run into any issues today, please reach out and I’ll take care of it.”</p>

📚 Ticket Notes (Technician)

- Password had been reset offsite → likely sync delay

- No AD account lockout

- Resync resolved issue immediately

- Updated internal documentation on handling MFA desync events

<p>Closed ticket with full user verification</p>

🟢 Status: Closed
