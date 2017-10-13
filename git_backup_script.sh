#!/bin/bash

repo_dir="/srv/git/repos"
logfile=${backup_dir}/backup.log

# create git bundles as a backup; remove old bundles
echo "backup.sh start $(date)" >> "${logfile}"
for repo in $(ls $repo_dir);
do
        if [ -d "$repo_dir/$repo/.git" ]
        then
            backup_repo="$repo"
            repo="$repo/.git"
            echo $repo
        else
            backup_repo="$repo"
        fi

        backup_dir="/srv/git/backup"
        echo -n "backup initiated for repo ${repo} ..." >> "${logfile}"

        if [ $(date -d tomorrow +"%e") == 1 ]; then
          backup_dir=${backup_dir}/monthly
          /usr/bin/git --git-dir $repo_dir/$repo bundle create ${backup_dir}/${backup_repo}.bundle --all >> "${logfile}" 2>&1

          if [[ $success -eq 0 ]];
          then
              echo " OK" >> ${logfile}
          else
              echo " FAIL" >> ${logfile}
          fi

        else

          backup_dir=${backup_dir}/"daily_"$(date +"%u")

          /usr/bin/git --git-dir $repo_dir/$repo bundle create ${backup_dir}/${backup_repo}.bundle --all >> "${logfile}" 2>&1

          success=$?
          if [[ $success -eq 0 ]];
          then
              echo " OK" >> ${logfile}
          else
              echo " FAIL" >> ${logfile}
          fi

        fi
done
