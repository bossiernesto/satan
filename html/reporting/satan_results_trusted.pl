#
# List hosts that this host trusts
#
($_TRUSTEE, $_sort_order) = split(/,/, $html_script_args);
($_trustee = $_TRUSTEE) =~ tr/?!/ \//;

print CLIENT <<EOF;
<HTML>
<HEAD>
<title> Trust - $_trustee</title>
<LINK REV="made" HREF="mailto:satan\@fish.com">
</HEAD>
<BODY>
<H1><IMG SRC="$HTML_ROOT/images/satan.gif"> Trust - $_trustee</h1>
<hr>

<h3>Hosts trusted by $_trustee (vulnerability counts). </h3>

<H4> Sort hosts by:
<a href="satan_results_trusted.pl,$_TRUSTEE,name.html">name</a> |
<a href="satan_results_trusted.pl,$_TRUSTEE,domain.html">domain</a> |
<a href="satan_results_trusted.pl,$_TRUSTEE,type.html">system type</a> |
<a href="satan_results_trusted.pl,$_TRUSTEE,subnet.html">subnet</a> |
<a href="satan_results_trusted.pl,$_TRUSTEE,severity.html">problem count</a> |
<a href="satan_results_trusted.pl,$_TRUSTEE,severity_type.html">problem type</a> |
<a href="satan_results_trusted.pl,$_TRUSTEE,trusted_type.html">trust type</a>
</H4>
EOF

@_hosts = split(/\s+/, $total_trusted_names{$_trustee});
do "$html_root/reporting/sort_hosts.pl";
print CLIENT $@ if $@;

print CLIENT <<EOF;
<hr> <a href="$HTML_STARTPAGE"> Back to the SATAN start page </a> |
<a href="analysis.pl.html"> Back to SATAN Reporting and Analysis </a>
</BODY>
</HTML>
EOF
