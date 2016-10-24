#!/usr/bin/env bash

# -----------------------------------------------------------------------------
# Info:
# 	Miroslav Vidovic
# 	new_sass.sh
# 	13.10.2016.-20:00:48
# -----------------------------------------------------------------------------
# Description:
#   Create the 7-1 sass architecture or directory structure.
#
#├── base
#│   ├── _color.scss
#│   ├── _reset.scss
#│   └── _typography.scss
#├── components
#│   ├── _buttons.scss
#│   ├── _gallery.scss
#│   └── _navigation.scss
#├── helpers
#│   ├── _functions.scss
#│   ├── _mixins.scss
#│   └── _variables.scss
#├── layout
#│   ├── _footer.scss
#│   ├── _forms.scss
#│   ├── _grid.scss
#│   ├── _header.scss
#│   └── _sidebar.scss
#├── main.scss
#├── pages
#│   ├── _about.scss
#│   ├── _contact.scss
#│   └── _home.scss
#├── themes
#│   ├── _admin.scss
#│   └── _theme.scss
#└── vendors
#    └── _bootstrap.scss
#
# Usage:
# 
# -----------------------------------------------------------------------------
# Script:

declare -a root=(base components layout pages themes helpers vendors)
declare -a base=(_reset.scss _typography.scss _color.scss)
declare -a components=(_buttons.scss _navigation.scss _gallery.scss)
declare -a layout=(_header.scss _grid.scss _sidebar.scss _forms.scss _footer.scss)
declare -a pages=(_home.scss _about.scss _contact.scss)
declare -a themes=(_theme.scss _admin.scss)
declare -a helpers=(_variables.scss _functions.scss _mixins.scss)
declare -a vendors=(_bootstrap.scss)

root(){
  mkdir css sass
  for directory in "${root[@]}"
  do
    mkdir -p sass/$directory
  done
}

main_sass(){
  touch sass/main.scss
  
cat > sass/main.scss << EOF
@import 'base/_reset';
@import 'base/_typography';
@import 'base/_color';
@import 'components/_buttons';
@import 'components/_navigation';
@import 'components/_gallery';
@import 'layout/_header';
@import 'layout/_grid';
@import 'layout/_sidebar';
@import 'layout/_forms';
@import 'layout/_footer';
@import 'pages/_home';
@import 'pages/_about';
@import 'pages/_contact';
@import 'themes/_theme';
@import 'themes/_admin';
@import 'helpers/_variables';
@import 'helpers/_functions';
@import 'helpers/_mixins';
@import 'vendors/_bootstrap';
EOF
}

base(){
  for directory in "${base[@]}"
  do
    touch sass/base/$directory
  done
}

components(){
  for directory in "${components[@]}"
  do
    touch sass/components/$directory
  done
}

layout(){
  for directory in "${layout[@]}"
  do
    touch sass/layout/$directory
  done
}

pages(){
  for directory in "${pages[@]}"
  do
    touch sass/pages/$directory
  done
}

themes(){
  for directory in "${themes[@]}"
  do
    touch sass/themes/$directory
  done
}

helpers(){
  for directory in "${helpers[@]}"
  do
    touch sass/helpers/$directory
  done
}

vendors(){
  for directory in "${vendors[@]}"
  do
    touch sass/vendors/$directory
  done
}

main(){
  echo "main"
  root
  main_sass
  base
  components
  layout
  pages
  themes
  helpers
  vendors
}

main

exit 0
