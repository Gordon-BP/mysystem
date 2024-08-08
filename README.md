# NixOS Install Diary

## General Goals
1. Turn my computer from an object to a config and back that shit up on Github
2. Have the prettiest damn desktop and terminal experience
3. Configure NixOS in a way that doesn't disappoint future Gordy

nixos.wiki bad! wiki.nixos.org good!
nix.dev bad! nixos.org good!

## Instructions:
1. Update nix channels to use the latest OS version and latest packages (this is like apt-get update or brew update)
    `sudo nix-channel --add https://channels.nixos.org/24.05 nixos`
    `sudo nix-channel --add https://nixos.org/channels/nixpkgs-unstable nixpkgs`
    `sudo nix-channel --update`

    **Why?**
    * Because your installer USB is using nix 23 or something
    * Because it gets you the most up to date versions of packages
### NO FLAKES NO FLAKES NO FLAKES NO FLAKES NO FLAKES

2. Build ~/mysystem directory
    `mkdir ~/mysystem`
    `cp /etc/nixos/configuration.nix ~/mysystem`
    `cp /etc/nixos/hardware-configuration.nix ~/mysystem`
    `echo 'export MY_NIX="/home/gordy/mysystem/configuration.nix"' | tee -a ~/.bashrc && source ~/.bashrc`

    **Why?**
    * Because putting the working configuration.nix outside of /etc/ gives you non-root access
    * Because if you fuck the configuration.nix up you have a backup right there
    * Because you can push the entire /mysystem folder to github

3. System Build 1: Minimum-viable packages
    `nano ~/mysystem/configuration.nix`
    Add to system packages:
        * neovim
        * git
        * neofetch
    `sudo nixos-rebuild switch -I nixos-config=$MY_NIX`

    **Why?**
    * Because nano fucking sucks and you're not gonna configure nvidia drivers with it
    * Because they are really obvious when the install goes right
    * Because git is needed for your precious nvim plugins


4. System Build 2: Nvidia drivers
    `nvim ~/mysystem/configuration.nix`
    Add to system packages:
        * pciutils
        * lf
        * ripgrep
    Add this at the top underneath `boot.loader.efi.canTouchEfiVariables`:
```python
  # Enable OpenGL
  hardware.graphics.enable = true;
  # Load nvidia driver for Xorg and Wayland
  services.xserver.videoDrivers = ["nvidia"];

  hardware.nvidia = {

  # Modesetting is required.
  modesetting.enable = true;
  powerManagement.enable = true;
  powerManagement.finegrained = false;
  open = false;
  nvidiaSettings = true;
  package = config.boot.kernelPackages.nvidiaPackages.stable;
    };
```
    
    `sudo nixos=rebuild switch -I nixos-config=$MY_NIX`

    (How often do I need to reboot the system for these changes to take effect?)

    **Why?**
    * Because it comes from the offical NixOS wiki
    * Beause the latest nvidia drivers are less fucky about Wayland / XWayland
    * Because those packages can help troubleshoot when the driver inevitably doesn't work
    * Because many of the custom settings (package, boot things) come from troubleshooting threads on Discourse

5. Troubleshoot Nvidia drivers
    `nvidia-smi` Opens info about the GPU activity
    `nvidia-settings` GUI with GPU settings and profiles
    `lsmod | grep nvidia` Checks if the driver is loaded
    `sudo modprobe nvidia` Loads the driver
    `sudo reboot` to reboot the system

6. System build 3: Add hyprland
7. Add all the user packages
8. Push to github

## Attempt 1:
First attempt, starting out strong!
* Flakes
* Home-Manager
* Following vimjoyer's early Youtube videos and git repo
* Modular project with a large footprint
* Many dependancies that I didn't want to use

### Post-Mortem
**Cause of death:** Playing picky-choosy with the dependencies upset the balance, and broke the config. Either I need to start from something simpler, or jsut do all the same things as vimjoyer.

## Attempt 2:
Going back to where attempt #1 left off to try and push it through.
I made a post on the NixOS Discourse asking for help, and I learned:
* Home Manager and flakes have a weird relationship
* NixOs Modules and Home Manager Modules can step on each other's toes
* Home Manager is responsible for why the error messages look like trash.

### Post-Mortem
**Cause of death:** Could not fix an error message about "cannot set property on 'home.users.gordy.environment' because environment don't exist.

## Attempt #3
Starting my own modular project skeleton from scratch.
* Flakes
* Home manager
* different folders for nix modules, home manager modules
* individual configs for packages
* leveraging some of vimjoyer's macros and libraries
This one was okay but still very confusing. Yes I was building it from scratch, but it was a bit like tracing over a drawing of something unknown and then saying that it's all your work. I was able to get an initial build going, but then I ran into the error that killed the run.

### Post-Mortem
**Cause of death:** Ran out of space on the boot drive.

## Attempt #4
Armed with new knowledge from Discourse, I re-installed nixOS so that I could put it on a larger partition. The new tenants were:
* Flakes
* home manager
* one single modules/ dir
* build from first principles
This time started off okay, but then went downhill. I couldn't figure out how to install home manager again! Then I set up a flake that leveraged home manager (without installing home manager) and somehow it built? But then the NVidia drivers were still wonky. The drivers installed but didn't run. Like, `neofetch` shows the GPU, but `nvidia-smi` and `nvidia-settings` say that there is no driver running.

### Post-Mortem 
**Cause of death:** De-privlidged myself, and without `sudo` I could not build new system generations. Fresh install!

## Attempts #5 & #6
Both of these attempts never got past the boot loader.

### Post-Mortem
**Cause of death:** Timeout waiting for /boot to mount.
I played around with re-mounting a larger partition to /boot to try and fix the out-of-space problem from Attempt 3; however it also turns out that when I start playing around with partitions again and make a new /boot partition, then things go awry. Both attempts killed by the same bug, but I repeated it just to make sure.

## Attempt #7
This time I'm just overwriting the entire 4TB NVME drive - bye bye, windows partition!
Started off strong! Writing my process down and having step-by-step instructions is super helpful. Not because I know what I'm doing, but it's great for:
* Context switching - there is a lot of hurry upand wait, so I do other stuff. But then when I come back, or after I complete a step, the instructions eliminate that "uhhhh what now?" feeling
* Copy of what's on the computer - While dealing with all the system crashes, it was really handy to have a refrence of what was supposed to be in the config. 
* Record of things tried

### Post-Mortem
**Cause of death:** Deleted my working backup.
I was dealing with an issue where the nvidia driver was crashing. Or maybe the OS itself was crashing? What would happen is Nix would boot, I'd select the latest generation, it would show some logs, then blank screen instead of GNOME login. When this happened, I would think "No problem, I'm using NixOS so I can just boot into an older profile (Gen 4) and try again! I don't have to worry abotu safe mode or anything, and my user data persists so I don't even have to re-trace my steps! Nix is great!"

During one of those times I had booted into the backup, I realized that I now have 14 generations of nix clogging up my boot menu, so I went to work cleaning them up. I ran:

`sudo nix-env --delete-generations --profile /nix/var/nix/profiles/system 1 2 3 5 6 7 8 9 10 11 12 13`

`sudo nix-collect-garbage -d`

NOOOOOOOOOO gen 4 got deleted somehow!! I have no idea how, but I suspect either:
* the `--delete-generations` 1 arg was interpreted as 1 day, and since all my generations have happened just today, all got deleted
* The `--delete-generations` interpreted `3 5` as a range meaning `[3,4,5]`
* the `nix-collect-garbage -d` yeets all old generations

After reading the manual, I found this lovely little bit:

> There is also a convenient little utility nix-collect-garbage, which when invoked with the -d (--delete-old) switch deletes all old generations of all profiles in /nix/var/nix/profiles

ah well, onto the next attempt.

## Attempt #8
OK I want to try something different this time, and try to minimize the number of system rebuilds. I'll hold my nose and use nano editor to add the nvidia drivers in to `configuration.nix`.
After only 2 system rebuilds (!) I was able to get back to where I was on attempt #7. Thing is, I'm still running into the blank screen issue. 

Here is a list of settings I have tried tweaking. **None have fixed it!**
* Remove the `boot.kernelParams`
* Remove the `boot.extraModulesPackages`
* Remove the `boot.initrd`
* Switch driver version from 'latest` to `production`
* Switch driver version from `production` to `stable`
* Moved `services.xserver.videoDrivers = ["nvidia"]` from after `hardware.nvidia` to before it
* Set `hardware.nvidia.powerManagement.enable` to `true` 
* Updated NixOS from 24.05 to unstable branch
