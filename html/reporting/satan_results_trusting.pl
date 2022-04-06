#
# List hosts that trust this host by trust relation
#
($_TRUSTED, $_sort_order) = split(/,/, $html_script_args);
($_trusted = $_TRUSTED) =~ tr/?!/ \//;

print CLIENT <<EOF;
<HTML>
<HEAD>
<title> Trust - $_trusted</title>
<LINK REV="made" HREF="mailto:satan\@fish.com">
</HEAD>
<BODY>
<H1><IMG SRC="$HTML_ROOT/images/satan.gif"> Trust - $_trusted</h1>
<hr>

<h3>Hosts trusting $_trusted (vulnerability counts). </h3>

<H4> Sort hosts by:
<a href="satan_results_trusting.pl,$_TRUSTED,name.html">name</a> |
<a href="satan_results_trusting.pl,$_TRUSTED,domain.html">domain</a> |
<a href="satan_results_trusting.pl,$_TRUSTED,type.html">system type</a> |
<a href="satan_results_trusting.pl,$_TRUSTED,subnet.html">subnet</a> |
<a href="satan_results_trusting.pl,$_TRUSTED,severity.html">problem count</a> |
<a href="satan_results_trusting.pl,$_TRUSTED,severity_type.html">problem type</a> |
<a href="satan_results_trusting.pl,$_TRUSTED,trustee_type.html">trust type</a>
</H4>
EOF

@_hosts = split(/\s+/, $total_trustee_names{$_trusted});
do "$html_root/reporting/sort_hosts.pl";
print CLIENT $@ if $@;

print CLIENT <<EOF;
<hr> <a href="$HTML_STARTPAGE"> Back to the SATAN start page </a> |
<a href="analysis.pl.html"> Back to SATAN Reporting and Analysis </a>
</BODY>
</HTML>
EOF
