# Start by showing ff version
firefox -v
# First step: update the channel
nix-channel --update
# Then, remove the old flake.lock and re-generate it
rm ~/mysystem/flake.lock
nix flake update --flake ~/mysystem
# Commit to GH so tree isn't dirty
git add . && git commit -a -m "updating packages"
# Rebuild
sudo nixos-rebuild switch --flake ~/mysystem
# Check ff again
firefox -v

