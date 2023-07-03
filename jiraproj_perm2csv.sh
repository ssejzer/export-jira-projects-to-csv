#!/bin/bash

project=$1

source .env

if [ -z "$project" ] ; then
        keys=$(curl -s -k --request GET \
                -H "Authorization: Bearer $TOKEN" \
                --header 'Accept: application/json' \
                "$URL/rest/api/2/project")

	echo "project,permission,type,group,user"
        echo $keys | jq -r '.[].key|@uri' | while read key ; do
                $0 "$key"
        done

else
        p=$(curl -s -k --request GET \
                -H "Authorization: Bearer $TOKEN" \
                --header 'Accept: application/json' \
		"$URL/rest/api/2/project/$project/permissionscheme/?expand=permissions,user,group")
	echo "$p" | jq -r '.permissions[] | [ "'$project'", .permission, .holder.type, .holder.group.name, .holder.user.name ] | @csv '

fi


