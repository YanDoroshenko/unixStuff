# Here are some problems I've come across and their solutions

## Sound
### No soundcards found
Check whether the used is in the `audio` group

## General
### Password incorrect after shell change

If a user's shell is unavailable (e. g. package has been removed), the system won't let him log in, reporting an incorrect password. A solution is to load a live-USB, chroot into the system, specifying the shell and change user's shell.

```
chroot /mnt /bin/bash
chsh -s /bin/bash $user
```
