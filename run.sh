#!/bin/bash

# "hillvalley" - time machine for linux
#
#  Copyright (C) Alexey Shishkin 2017
#
#  This file is part of Project "hillvalley".
#
#  Project "hillvalley" is free software: you can redistribute it and/or modify
#  it under the terms of the GNU Lesser General Public License as published by
#  the Free Software Foundation, either version 3 of the License, or
#  (at your option) any later version.
#
#  Project "hillvalley" is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
#  GNU Lesser General Public License for more details.
#
#  You should have received a copy of the GNU Lesser General Public License
#  along with Project "hillvalley". If not, see <http://www.gnu.org/licenses/>.

set -e

if [ "$EUID" -ne 0 ]
then 
  echo -e "Please run me as \033[1;31mroot\033[0m, as only\n"`
         `"root can mess with time and matter" 1>&2
  exit
fi

user=$( who am i | awk '{print $1}' )
echo -e  "Simulation user set to \033[1;34m$user\033[0m"
echo -ne "Enter destination time\n(YYYY-MM-DD hh:mm:ss): "
read fake_inp

real_now=$( date +%s )
fake_now=$( date -d "$fake_inp" +"%s" )

echo "Destination time: $( date -d @$fake_now )"
date +%s -s @$fake_now > /dev/null 2>&1
echo "Arrived to      : $( date )"

echo "Accessing local tools"
echo "Enter exit to go back"

su $user

echo "Returning home"

fake_aft=$( date +%s )
time_cmp=$(( $fake_aft - $fake_now ))

real_now=$(( $real_now + $time_cmp ))

echo "Destination time: $( date -d @$real_now )"
date +%s -s @$real_now > /dev/null 2>&1
echo "Returned to     : $( date )"