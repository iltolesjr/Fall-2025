# vcenter lab: ldap server (one-file)

objective: install and prove ldap works with a test user.

use the all-in-one helper already in repo:
- open `week4_to_now_all_in_one.md`
- paste the script block into the vm console
- during prompts, use simple values
- take the three screenshots listed at the end

extra proof commands:
```bash
ldapsearch -x -LLL -H ldap://localhost -b "dc=example,dc=com" "(uid=testuser)" cn uid
```
