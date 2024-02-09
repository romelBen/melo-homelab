# Ansible Role: NTP
This role installs and configures NTP on RHEL/CentOS, Debian/Ubuntu, Fedora and Suse servers.

## Requirements
No special requirements; note that this role requires root access, so either run it in a playbook with a global `become: yes`, or invoke the role in your playbook like:

## Role Variables
Available variables are listed below, along with default values (see `defaults/main.yml`):

    ntp_driftfile: /var/lib/ntp/drift

Configure the drift file for ntp.

    ntp_server:
      - 0.de.pool.ntp.org
      - 1.de.pool.ntp.org
      - 2.de.pool.ntp.org
      - 3.de.pool.ntp.org

Configure servers for ntp.

    ntp_restrict:
      - "restrict -4 default kod notrap nomodify nopeer noquery"
      - "restrict -6 default kod notrap nomodify nopeer noquery"
      - "restrict 127.0.0.1"

Configure restrictions for ntp.

    ntp_includefile: no

Configure includefile for ntp.

    ntp_statistics: no

Configure statistics for ntp.

## Dependencies

None.

## OS Compatibility
This role ensures that it is not used against unsupported or untested operating systems by checking, if the right distribution name and major version number are present in a dedicated variable named like `<role-name>_stable_os`. You can find the variable in the role's default variable file at `defaults/main.yml`:

    role_stable_os:
      - Debian 10
      - Ubuntu 18
      - CentOS 7
      - Fedora 30

If the combination of distribution and major version number do not match the target system, the role will fail. To allow the role to work add the distribution name and major version name to that variable and you are good to go. But please test the new combination first!

Kudos to [HarryHarcourt](https://github.com/HarryHarcourt) for this idea!

## Example Playbook

    ---
    - name: "Run role."
      hosts: all
      become: yes
      roles:
        - ntp