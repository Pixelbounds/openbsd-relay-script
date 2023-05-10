#!/bin/sh

update_os() {
    echo "It is highly recommended to update your system before installing additional packages.(1 for yes, 0 for no)"
    read systctl
        if [ "systctl" -eq 1 ]; then
            syspatch
            pkg_add -Uuv
        else
            echo "User did not update system."
        fi
}

update_os

package_install() {
    echo "The following packages will be installed: wireguard-tools, wget"
    echo "1 for yes, 0 for no"
    read install_packages
        if [ "install_packages" -eq 1 ]; then
            sudo pkg_add -v wireguard-tools wget
        else
            echo "No packages installed."
}

package_install