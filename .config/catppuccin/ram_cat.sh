show_ram_cat() {
  tmux set-option -g @ram_low_bg_color "$thm_yellow" # background color when cpu is low
  tmux set-option -g @ram_medium_bg_color "$thm_orange" # background color when cpu is medium
  tmux set-option -g @ram_high_bg_color "$thm_red" # background color when cpu is high
  local index=$1
  local icon=$(get_tmux_option "@catppuccin_ram_cat_icon" "󰍛")
  local color="$(get_tmux_option "@catppuccin_ram_cat_color" "#{ram_bg_color}")"
  local text="$(get_tmux_option "@catppuccin_ram_cat_text" "#{ram_percentage}")"

  local module=$( build_status_module "$index" "$icon" "$color" "$text" )

  echo "$module"
  }
