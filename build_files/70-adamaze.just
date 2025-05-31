# vim: set ft=make :
########################
### aurora-system.just
########################
## Standardized verbs
# configure- = configure something that is pre-installed on the image
# install-   = install something, no uninstall or configuration provided
# setup-     = install something and also provide configuration and/or uninstallation options
# toggle-    = turn something on/off, logic can be automatic or manual selection
# fix-       = apply fix/patch/workaround for something
# foo        = no verb is used for shortcuts or something deemed important enough to use a super memorable name

# Install my flatpaks
[group('System')]
install-my-flatpaks:
    #!/usr/bin/env bash

    # Add Flathub remote if it does not exist
    flatpak remote-add --if-not-exists --system flathub https://flathub.org/repo/flathub.flatpakrepo

    # Disable Fedora Flatpak remotes
    for remote in fedora fedora-testing; do
        if flatpak remote-list | grep -q "$remote"; then
            flatpak remote-delete "$remote"
        fi
    done
    FLATPAK_LIST=($(cat /usr/share/ublue-os/flatpak_list_adamaze))
    flatpak --system -y install --or-update "${FLATPAK_LIST[@]}"
