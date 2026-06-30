import os

if '/home/stuart/.local/bin' not in $PATH:
    $PATH.insert(0, '/home/stuart/.local/bin')

if '/home/stuart/.opencode/bin' not in $PATH:
    $PATH.append('/home/stuart/.opencode/bin')

$UE_ROOT = "/home/stuart/Apps/Unreal"
$SDL_VIDEODRIVER = "x11"

def _ssh_login(args, stdin=None):
    """Load SSH key into agent with 8-hour timeout."""
    $SSH_AUTH_SOCK = f"/run/user/{os.getuid()}/ssh-agent.socket"
    ssh-add -t 8h ~/.ssh/id_ed25519
    ssh-add -l

aliases['ssh-login'] = _ssh_login
