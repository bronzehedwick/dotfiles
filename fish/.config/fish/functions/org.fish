#!/usr/bin/env fish

function org --description "Sync org files to and from a mounted webdav remote."

  if not type -q rsync
    echo "Could not find rsync."
    return
  end

  if not test -d /Volumes/webdav.fastmail.com/iam.chrisdeluca.me/files/org
    echo "Webdav volume not mounted."
    return
  end

  # Make a local backup.
  rsync -a ~/org/ /tmp/org.bak

  switch $argv[1]
    case "pull"
      rsync -a /Volumes/webdav.fastmail.com/iam.chrisdeluca.me/files/org/ ~/org/
      return
    case "push"
      rsync -a ~/org/ /Volumes/webdav.fastmail.com/iam.chrisdeluca.me/files/org/
      return
    case "merge"
      if diff -rq ~/org/ /tmp/org.bak/
        echo "Folders are identical."
        return
      end
      set e = nvim
      if test -n "$NVIM_LISTEN_ADDRESS"
        set e = nvr
      end
      diff -rq ~/org/ /tmp/org.bak/ | awk '{print $2, $4}' | xargs $e -d -O2
      return
  end

  # Default case, show help.
  echo 'where:
    help    shows this help text
    pull    copies remote files locally
    push    copies local files to the remote
    merge   resolve changes between local and remote'

end
