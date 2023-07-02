#!/bin/bash

project=$1

source .env

if [ -z "$project" ] ; then
        keys=$(curl -s -k --request GET \
                -H "Authorization: Bearer $TOKEN" \
                --header 'Accept: application/json' \
                "$URL/rest/api/2/project")

	echo "project,role,users,groups"
        echo $keys | jq -r '.[].key|@uri' | while read key ; do
                $0 "$key"
        done

else
	#echo $project
        p=$(curl -s -k --request GET \
                -H "Authorization: Bearer $TOKEN" \
                --header 'Accept: application/json' \
		"$URL/rest/projectconfig/latest/roles/$project?pageNumber=1&pageSize=500&query=")
	#echo "$p" | jq -r '.roles[] | [ "'$project'", .name, .users[].name, .groups[].name ] | @csv '
	#echo "$p" | jq -r '.roles[] | [ "'$project'", .name, ( .users | map(.name) | join(";") ), ( .groups[].name ) ] | @csv '
	echo "$p" | jq -r '.roles[] | [ "'$project'", .name, ( .users | map(.name) | join(";") ), ( .groups | map(.name) | join(";") ) ] | @csv '

#jq '.roles[] | [ "OI", .name, ( .users | map (.name) | join(";") ), ( .groups | map ( .name ) | join(";") ) ] | @csv '

#	echo "$p" | jq -r '.roles | map( {.name} ) | .[] | [ "'$project'", .name, ( .users | map (.name) | join(";") ), ( .groups | map (.name) | join(";") ) ] | @csv '
fi


