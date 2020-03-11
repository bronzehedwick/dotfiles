function fish_prompt
  if test -e "$NVIM_LISTEN_ADDRESS"
    echo "» "
  else
    echo "\$ "
  end
end
