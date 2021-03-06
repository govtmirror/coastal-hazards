#!/bin/bash

CONFIG_FILE="/wps_config.xml"
R_SERVE_HOST=${R_SERVE_HOST:-rserve}
R_SERVE_PORT=${R_SERVE_PORT:-5311}
R_SERVE_USER=${R_SERVE_USERNAME:-"rserve"}
R_SERVE_PASS=${R_SERVE_PASSWORD:-"rserve"}
R_SERVE_HOME=${R_SERVE_HOME:-""}
R_SERVE_SCRIPTDIR=${R_SERVE_SCRIPTDIR:-"${R_SERVE_HOME}/R/r_scripts"}
R_SERVE_RESOURCEDIR=${R_SERVE_RESOURCEDIR:-"${R_SERVE_HOME}/R/resources"}
R_SERVE_WORKDIR=${R_SERVE_WORKDIR:-"default"}
WPS_HOST=${WPS_HOST:-"localhost"}
WPS_PORT=${WPS_PORT:-"8080"}

# Update RServe configuration
sed -i -e "s#\(<Property name=\"Rserve_Host\" active=\"true\">\).*\(</Property>\)#\1${R_SERVE_HOST}\2#g" $CONFIG_FILE
sed -i -e "s#\(<Property name=\"Rserve_Port\" active=\"true\">\).*\(</Property>\)#\1${R_SERVE_PORT}\2#g" $CONFIG_FILE
sed -i -e "s#\(<Property name=\"Rserve_User\" active=\"true\">\).*\(</Property>\)#\1${R_SERVE_USER}\2#g" $CONFIG_FILE
sed -i -e "s#\(<Property name=\"Rserve_Password\" active=\"true\">\).*\(</Property>\)#\1${R_SERVE_PASS}\2#g" $CONFIG_FILE
sed -i -e "s#\(<Property name=\"Script_Dir\" active=\"true\">\).*\(</Property>\)#\1${R_SERVE_SCRIPTDIR}\2#g" $CONFIG_FILE
sed -i -e "s#\(<Property name=\"Resource_Dir\" active=\"true\">\).*\(</Property>\)#\1${R_SERVE_RESOURCEDIR}\2#g" $CONFIG_FILE
sed -i -e "s#\(<Property name=\"R_Work_Dir\" active=\"true\">\).*\(</Property>\)#\1${R_SERVE_WORKDIR}\2#g" $CONFIG_FILE

# Figure out what the line number the "Server" node is on and replace the entire line 
repl_line_num=$(grep -n "<Server" /wps_config.xml |cut -f1 -d:)
sed -i -e "${repl_line_num}s/.*/<Server hostname=\"${WPS_HOST}\" hostport=\"${WPS_PORT}\" webappPath=\"wps\" includeDataInputsInResponse=\"true\" computationTimeoutMilliSeconds=\"5\" cacheCapabilites=\"false\">/" $CONFIG_FILE

