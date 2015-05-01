#!/bin/bash -eux

SSH_USER=root
SSH_USER_HOME=/root
VAGRANT_INSECURE_KEY="ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEA6NF8iallvQVp22WDkTkyrtvp9eWW6A8YVr+kz4TjGYe7gHzIw+niNltGEFHzD8+v1I2YJ6oXevct1YeS0o9HZyN1Q9qgCgzUFtdOKLv6IedplqoPkcmF0aYet2PkEDo3MlTBckFXPITAMzF8dJSIFo9D8HfdOV0IAdx4O7PtixWKn5y2hMNG0zQPyUecp4pzC6kivAIhyfHilFR61RGL+GPXQ2MWZWFYbAGjyiYJnAmCP3NOTd0jMZEnDkbUvxhMmBYSdETk1rRgm+R4LOzFUGaHqHDLKLX+FIPKcF96hrucXzcWyLbIbEgE98OHlnVYCzRdK8jlqm8tehUc9c9WhQ== vagrant insecure public key"

# Packer passes boolean user variables through as '1', but this might change in
# the future, so also check for 'true'.
if [ "$SSH_ROOT" != "true" ] && [ "$SSH_ROOT" != "1" ]; then
    exit 0
fi

echo '==> Configuring settings for root'

echo '==> Setting Root Password'
echo "root:$SSH_PASSWORD" | chpasswd

if [ "$INSTALL_VAGRANT_KEY" = "true" ] || [ "$INSTALL_VAGRANT_KEY" = "1" ]; then

    echo '==> Installing Vagrant SSH key for root'
    mkdir -pm 700 $SSH_USER_HOME/.ssh
    # https://raw.githubusercontent.com/mitchellh/vagrant/master/keys/vagrant.pub
    echo "${VAGRANT_INSECURE_KEY}" > $SSH_USER_HOME/.ssh/authorized_keys
    chmod 600 $SSH_USER_HOME/.ssh/authorized_keys
    chown -R $SSH_USER:$SSH_USER $SSH_USER_HOME/.ssh
fi
