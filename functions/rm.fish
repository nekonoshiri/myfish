function rm
  if test -z "$argv"
    echo "usage: rm file1 file2 ..."
    return 1
  end
  if not set -q TRASH_DIR
    echo "rm: Please set TRASH_DIR as backup directory path"
    return 1
  end
  if not test -d $TRASH_DIR
    echo "rm: The directory '$TRASH_DIR' (as TRASH_DIR) does not exist"
    return 1
  end

  argparse -n 'rm(safe)' 'h/help' -- $argv
  or return 1

  if set -lq _flag_help
    echo "usage: rm file1 file2 ..."
    return 1
  end

  set destdir (string trim -r -c/ $TRASH_DIR)"/trash_"(date +%Y%m%d)
  if not test -d $destdir
    mkdir $destdir
  end

  for item in $argv
    # シンボリックリンクの場合は単に削除
    if test -L $item
      command rm (string trim -r -c/ $item)
      continue
    end

    set abs_item (realpath $item)
    set abs_dest (realpath $destdir/(basename $item))

    # 既に destdir にあるアイテムを削除しようとしたときなど
    if test $abs_item = $abs_dest
      continue
    end

    # 削除先に既に何かある場合はどかす
    if test -e $abs_dest
      rec_mv $abs_dest
    end

    command mv -f $abs_item $abs_dest
  end
end

function rec_mv
  set source $argv[1]
  set dest $source"~"
  if test -e $dest
    rec_mv $dest
  end
  mv -f $source $dest
end
