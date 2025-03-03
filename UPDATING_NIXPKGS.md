# HOW TO UPDATE A PACKAGE ON NIXPKGS

    > Side note - if you just want to update to whatever is on nixpkgs-unstable, run these two commands:
    > `nix-channel --update nixpkgs`
    > `sudo nixos-rebuild switch --flake .`

Oh no. Oh nooooooooo.

The package on nixpkgs is out of date. oh no. FUCK! Well buddy-o, it's up to you to save the day here. You're going to have to go INTO THE NIXPKGS and 💨 BUMP 🍑 THAT 🍆 PACKAGE ✅

It's gonna suck but that's why we have this guide. You've done it before, and can do it again, champ.

## STEP 1: PREPARE YOUR ~ANUS~ LOCAL NIXPKGS REPO

Remember when I said you've done this before? HERE'S PROOF! Navigate to:

    > `cd ~/nikpkgs`

O shit that's the nixpkgs. ALL OF THEM. Well not really, it hasn't been touched since you last bumped a package so we need to sync it.

    > `git fetch upstream'
    > 'git reset --hard upstream/nixpkgs-unstable

This NUKES your local and replaces everything with what is on the unstable branch at that exact moment. Cooolio now we're in sync.

## STEP 2: BRANCH OUT

The naming of branches is a peculiar thing. You WILL get yelled at if you name it wrong. Stick to something basic like:

    > username:package_name:old -> new

Look at some of these absolute bangers for inspiration:

- r-ryantm:auto-update/python312Packages.pythonqwt
- nbraud:pkgs/vst-sdk
- gepbird:osu-lazer-2025.118.3

IF YOU FUCK UP there's two ways out:

1. If you haven't pushed yet, rename locally with `git branch -m <new-branch-name>`
2. If you already pushed (bless ur heart), you have to delete the remote and push a new one:
    > `git push origin -u <new-branch-name>`
    > `git push origin --delete <old-branch-name>`

## STEP 3: BUMP UP THE VOLUME

This is where you update the version number. It should be in the normal **packages.nix** file and if it isn't then god rest your soul. USUALLY it's gonna look like this:

```nix
let
  pname = "ollama";
  # don't forget to invalidate all hashes each update
  version = "0.5.7";

  src = fetchFromGitHub {
    owner = "ollama";
    repo = "ollama";
    tag = "v${version}";
    hash = "sha256-DW7gHNyW1ML8kqgMFsqTxS/30bjNlWmYmeov2/uZn00=";
    fetchSubmodules = true;
  };
```

Change the string in the version to match the new package version EXACTLY. 

Then YEET the hash string like an unwanted fetus.

## STEP 4: HASH IT UP

The easiest way to get the new hash is to fail hard - something you're damn good at already!

Soooo navigate _back to the root_

    > `cd ~/nixpkgs`

And try to build your new package.

`nix-build -A <package-name>`

IT WILL FAIL and that's OK, because the error message looks like this:

```bash
error: hash mismatch in fixed-output derivation '/nix/store/qz42xa1584gg9f7hddysf169k2ainxyb-source.drv':
         specified: sha256-AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=
            got:    sha256-z7SkvUN/7XB+C4Ldli+mQgxdkBQMfBY8zVm5FVeMRb8=
error: 1 dependencies of derivation '/nix/store/zcj21spvyhymkya32fzr2ahs6zpbjasp-llama-cpp-4543.drv' failed to build
```

Yoooo look at that - the error message just gave us the answers! Copy that like you're cheating on a math exam and pop it into the hash in your `package.nix` file.

Verify this by trying to build again:

`nix-build -A <package-name>`

If it still doesn't work, you're fucked. Sorry.

## STEP 5: COMMIT TO THAT BIIIIIIIIIIIIITCH

Now comes one of the scarier parts: commitment.

Start by making sure you didn't get your greasy nuggets on any other packages:

    > `git diff`

Read the diff and make sure your changes are as they should be.

Then, add the changes:

    > `git add /pkgs/path/to/your/package.nix`

Do NOT just `git add .` like a lazy mfer because who knows what else is lurking. In theory if you manually validated the diff it should be okay but do you really trust yourself??

The Nixlords are _very particular_ about their commit messages. This is what they have to say:

    > (pkg-name): (from -> to | init at version | refactor | etc)
    >
    > (Motivation for change. Link to release notes. Additional information.)

So be careful about your commit messages!

## STEP 6: TESTING

If you made it this far, go grab a cup of tea because these tests might take for everrrrr. Expecially if it is a popular package.

    > `nix-shell -p nixpkgs-review --run "nixpkgs-review rev HEAD --package <your-package-name>"`

## STEP 7: OPEN THE PR

Now it's time to make like a preggers lady and PUSH!

    > git push -u <branch-name>

Then go to https://github.com/NixOS/nixpkgs and use the github GUI to make a PR.

- Fill out their cute little PR template
- Check the boxes for build on x86_64_linux and Tested.

Then PRAY TO THE GODS and submit your PR.

## STEP 8: CLEAN UP

You may have downloaded more GBs than you have years. Remove them and become young again.

    > `rm -rf /tmp/nixpkgs-review-*`
    > `nix-collect-garbage -d`

Then breathe. You did it.
