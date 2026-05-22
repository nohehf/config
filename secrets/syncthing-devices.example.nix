# SyncThing device configuration template
# Copy this file to syncthing-devices.nix and fill in your actual device IDs.
# syncthing-devices.nix is gitignored; the rebuild scripts pass --impure so
# nix can read it from the local filesystem without committing device IDs.
{
  devices = {
    "device-name-1" = {
      # Name of SyncThing instance on other machine
      id = "DEVICE-ID-1-HERE";
    };
    "device-name-2" = {
      # Name of SyncThing instance on mobile device
      id = "DEVICE-ID-2-HERE";
    };
  };
}
