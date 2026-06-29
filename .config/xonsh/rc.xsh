import os
import shutil
import subprocess

home_dir = os.path.expanduser("~")
local_bin = os.path.join(home_dir, ".local", "bin")
opencode_bin = os.path.join(home_dir, ".opencode", "bin")

path_entries = (
    opencode_bin,
    local_bin,
    "/opt/homebrew/bin",
    "/opt/homebrew/sbin",
    "/usr/local/bin",
    "/usr/local/sbin",
)

for path_entry in reversed(path_entries):
    if os.path.isdir(path_entry) and path_entry not in $PATH:
        $PATH.insert(0, path_entry)

os.environ["PATH"] = os.pathsep.join($PATH)

if $XONSH_INTERACTIVE:
    fastfetch_bin = shutil.which("fastfetch")
    if fastfetch_bin:
        subprocess.run([fastfetch_bin], check=False)

$UE_ROOT = os.path.join(home_dir, "Apps", "Unreal")
$SDL_VIDEODRIVER = "x11"
