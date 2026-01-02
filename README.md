# Workstation setup
My dotfiles configuration and bootstrapping scripts


## Install

1. Clone repo
```
git clone
```

2. Run this script. Don't forget to set the PRIVATE_KEY_CONTENT/PUBLIC_KEY_CONTENT variables.
```bash
# 1. CHANGE THESE TWO VARIABLES
export PRIVATE_KEY_CONTENT="-----BEGIN OPENSSH PRIVATE KEY-----
your-private-key-content-here
-----END OPENSSH PRIVATE KEY-----"

export PUBLIC_KEY_CONTENT="ssh-rsa AAAAB3Nza...your-public-key-here"



echo "🔑 Setting up SSH configuration..."
SSH_DIR="$HOME/.ssh"
PRIVATE_KEY="$SSH_DIR/id_rsa"
PUBLIC_KEY="$SSH_DIR/id_rsa.pub"

mkdir -p "$SSH_DIR"
chmod 700 "$SSH_DIR"

if [ ! -f "$PRIVATE_KEY" ]; then
    echo "ℹ️ Creating private key..."
    echo "$PRIVATE_KEY_CONTENT" > "$PRIVATE_KEY"
    chmod 600 "$PRIVATE_KEY"
else
    echo "⏩ Private key already exists. Skipping creation."
fi

if [ ! -f "$PUBLIC_KEY" ]; then
    echo "ℹ️ Creating public key..."
    echo "$PUBLIC_KEY_CONTENT" > "$PUBLIC_KEY"
    chmod 644 "$PUBLIC_KEY"
else
    echo "⏩ Public key already exists. Skipping creation."
fi

# Setup git config

```

3. Bootstrap
```
/bin/bash -c "$(curl -fsS https://raw.githubusercontent.com/iczellion/workstation-setup/main/bootstrap.sh)"
```