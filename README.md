# Gordy's NIXOS System!

A _lot_ of this is teken from Vimjoyer's setup [here](https://github.com/vimjoyer/nixconf/tree/main)

Can also check out his Youtube video "Ultimate NixOS Guide | Flakes | Home-manager". Avoid older videos; they do not use a modular setup and you _will_ get even more confused.

## Building the OS

Run:

`nixos-rebuild switch --flake ~/mysystem/#work`

Then fix whatever error comes up and try again!

## Current errors
what i'm dealing with rn

### home-manager.users.gordy.environment does not exist!
```
[gordy@nixos:~/mysystem]$ nixos-rebuild switch --flake ~/mysystem/#work --verbose
$ nix --extra-experimental-features nix-command flakes build --out-link /tmp/nixos-rebuild.DLoHcD/nixos-rebuild /home/gordy/mysystem/#nixosConfigurations."work".config.system.build.nixos-rebuild --verbose
$ exec /nix/store/9wfnnfzqqg0z00gqwc09pz6gswp2yr1z-nixos-rebuild/bin/nixos-rebuild switch --flake /home/gordy/mysystem/#work --verbose
building the system configuration...
Building in flake mode.
$ nix --extra-experimental-features nix-command flakes build /home/gordy/mysystem/#nixosConfigurations."work".config.system.build.toplevel --verbose --out-link /tmp/nixos-rebuild.NsiUNO/result
error:
       … while calling the 'head' builtin

         at /nix/store/4cpakzyvfw1rmm9v5i3387x6jd2h1v86-source/lib/attrsets.nix:1575:11:

         1574|         || pred here (elemAt values 1) (head values) then
         1575|           head values
             |           ^
         1576|         else

       … while evaluating the attribute 'value'

         at /nix/store/4cpakzyvfw1rmm9v5i3387x6jd2h1v86-source/lib/modules.nix:821:9:

          820|     in warnDeprecation opt //
          821|       { value = addErrorContext "while evaluating the option `${showOption loc}':" value;
             |         ^
          822|         inherit (res.defsFinal') highestPrio;

       (stack trace truncated; use '--show-trace' to show the full trace)

       error: The option `home-manager.users.gordy.environment' does not exist. Definition values:
       - In `/nix/store/da5hjsld2q4k54xykml11p4c50pvp3kc-source/nixos/common.nix':
           {
             _type = "if";
             condition = false;
             content = {
               pathsToLink = [
           ...
```

I have no idea where the .environment is being called! Or is this a problem where it is not being called but is supposed to? I don't know! These logs are trash!!

### Unknown homeConfigurations and homeManagerModules
This _might_ be related to the above. When I run `nix flake show` I see that the nix config and modules are A OK, but the home manager stuff is not recognized. This probable has to do with the ./hosts/default/home.nix file?

```
[gordy@nixos:~/mysystem]$ nix flake show ~/mysystem
path:/home/gordy/mysystem?lastModified=1723015892&narHash=sha256-baVHD%2BPpBbmTAgJz9pW6pZLrGJzHPbZNfX1Rr8oJEM4%3D
├───homeConfigurations: unknown
├───homeManagerModules: unknown
├───nixosConfigurations
│   └───work: NixOS configuration
└───nixosModules
    └───default: NixOS module


