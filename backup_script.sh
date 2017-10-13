#!/bin/bash

LOCATION=""
logfile="/var/log/backup.log"

backup_dir=""

echo "backup.sh start $(date)" >> "${logfile}"

if [ $(date -d tomorrow +"%e") == 1 ]; then
  backup_dir=${backup_dir}/monthly
  mv $LOCATION/*.zip $backup_dir/backup_mindmeister.zip

  success=$?
  if [[ $success -eq 0 ]];
  then
      echo " OK: $(date): Backup wurde erfoglreich in $backup_dir abgelegt." >> "${logfile}"
  else
      echo " FEHLER: $(date): Backup konnte auf ${INSTANCE} nicht erstellt werden." >> "${logfile}"
  fi

else

  backup_dir=${backup_dir}/"daily_"$(date +"%u")
  mv $LOCATION/*.zip $backup_dir/backup_mindmeister.zip

  success=$?
  if [[ $success -eq 0 ]];
  then
      echo " OK: $(date): Backup wurde erfoglreich in $backup_dir abgelegt." >> "${logfile}"
  else
      echo " FEHLER: $(date): Backup konnte nicht aufgeführt werden." >> "${logfile}"
  fi
fi
