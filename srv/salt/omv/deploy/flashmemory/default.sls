# @license   http://www.gnu.org/licenses/gpl.html GPL Version 3
# @author    OpenMediaVault Plugin Developers <plugins@omv-extras.org>
# @copyright Copyright (c) 2019-2020 OpenMediaVault Plugin Developers
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program. If not, see <http://www.gnu.org/licenses/>.

configure_rrd_dir:
  file.directory:
    - name: "/var/lib/openmediavault/rrd"
    - makedirs: True

configure_samba_dir:
  file.directory:
    - name: "/var/cache/samba"
    - makedirs: True

configure_flashmemory:
  file.managed:
    - name: "/etc/folder2ram/folder2ram.conf"
    - source:
      - salt://{{ tpldir }}/files/etc-folder2ram-folder2ram_conf.j2
    - template: jinja
    - user: root
    - group: root
    - mode: 644

remove_cron_apt_file:
  file.absent:
    - name: "/etc/cron-apt/action.d/3-download"

folder2ram_enable_systemd:
  cmd.run:
    - name: "/usr/sbin/folder2ram -enablesystemd"

folder2ram_mountall:
  cmd.run:
    - name: "/usr/sbin/folder2ram -mountall"
