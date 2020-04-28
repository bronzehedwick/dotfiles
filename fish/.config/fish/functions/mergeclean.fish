function mergeclean --description "Removes .orig files after git merge"
  command git status -s|grep orig|awk -F ' ' '{print $2}'|xargs rm
end
