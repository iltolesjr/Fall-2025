# vcenter lab: create user accounts and ssh - sample submission

student: your name
course: itec 1475-60
lab: week 3 - users and ssh
date: 2025-11-01

## short answers
- what i set up: users alice and bob, group project, and ssh service
- how i proved it: id/group output, ssh service status, and ssh login to localhost

---

## shot 01 - id alice and group project
Shows the user exists and is in the project group.

![shot 01 id alice](https://via.placeholder.com/1200x700?text=id%20alice%20and%20group%20project)

what this proves
- account created and group membership set

---

## shot 02 - ssh service
Shows the ssh service is enabled and running.

![shot 02 ssh status](https://via.placeholder.com/1200x700?text=systemctl%20status%20ssh)

what this proves
- ssh is active at boot and listening on port 22

---

## shot 03 - ssh login
Shows a successful ssh session to localhost as alice.

![shot 03 ssh localhost](https://via.placeholder.com/1200x700?text=ssh%20alice%40localhost%20whoami%2C%20groups%2C%20hostname)

what this proves
- account login works and groups are correct

---

## commands run (high level)
```
sudo groupadd project || true
sudo useradd -m -s /bin/bash alice || true
sudo usermod -aG project alice
echo 'alice:Password1!' | sudo chpasswd
sudo apt update && sudo apt install -y openssh-server
sudo systemctl enable --now ssh
ssh alice@localhost 'whoami && groups && hostname'
```

## submission notes
- screenshots taken from the vcenter console window
- only the requested images included; cropped to avoid private info
- file exported to pdf and uploaded to lms
