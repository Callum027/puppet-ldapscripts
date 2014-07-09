# == Class: ldapscripts
#
# Class for setting up the ldapscripts suite of LDAP
# user management tools.
#
# === Parameters
#
# === Variables
#
# === Examples
#
#  include ldapscripts
#
#  class
#  { ldapscripts:
#    gidstart => 5000,
#    uidstart => 10000,
#
#    gclass   => [ 'posixGroup', 'inetOrgPerson' ],
#  }
#
# === Authors
#
# Callum Dickinson <callum@huttradio.co.nz>
#
# === Copyright
#
# Copyright 2014 Callum Dickinson.
#
class ldapscripts
(
	$server			= undef,

	$suffix			= undef,
	$gsuffix		= undef,
	$usuffix		= undef,
	$msuffix		= undef,

	$saslauth		= undef,

	$binddn			= "cn=Manager,dc=example,dc=com",
	$bindpwdfile		= "/etc/ldapscripts/ldapscripts.passwd",
	$bindpwd		= undef,

	$gidstart		= 10000,
	$uidstart		= 10000,
	$midstart		= 20000,

	$gclass			= [ 'posixGroup' ],
	$gdummymember		= undef,

	$ushell			= undef,
	$uhomes			= undef,
	$createhomes		= "no",
	$homeskel		= undef,
	$homeperms		= undef,

	$passwordgen		= "pwgen",

	$recordpasswords	= "no",
	$passwordfile		= "/var/log/ldapscripts_passwd.log",

	$logfile		= "/var/log/ldapscripts.log",

	$tmpdir			= undef,

	$ldapsearchbin		= "/usr/bin/ldapsearch",
	$ldapaddbin		= "/usr/bin/ldapadd",
	$ldapdeletebin		= "/usr/bin/ldapdelete",
	$ldapmodifybin		= "/usr/bin/ldapmodify",
	$ldapmodrdnbin		= "/usr/bin/ldapmodrdn",
	$ldappasswdbin		= "/usr/bin/ldappasswd",

	$ldapbinopts		= undef,

	$ldapsearchopts		= "-o ldif-wrap=no",

	$iconvbinvar		= undef,
	$iconvchar		= undef,

	$uudecodebin		= undef,

	$getentpwcmd		= "",
	$getenrgrcmd		= "",

	$gtemplate		= "",
	$utemplate		= "",
	$mtemplate		= ""
)
{
	package
	{ "ldapscripts":
		ensure	=> installed,
	}

	# Workaround for bugged local ldapscripts.conf with invalid
	# UTF-8. Delete before we apply ours.
	exec { '/bin/rm -f /etc/ldapscripts/ldapscripts.conf': } ->
	file
	{ "/etc/ldapscripts/ldapscripts.conf":
		mode	=> 444,
		owner	=> root,
		group	=> root,
		content	=> template("ldapscripts/ldapscripts.conf.erb"),
	}
}
