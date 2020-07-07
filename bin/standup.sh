#!/usr/bin/env bash

AUTHOR="Brandon Siegel"
ICON_URL=https://avatars.slack-edge.com/2015-06-18/6579871506_ce5e1e7fb12da21eb396_32.jpg
TODAY=$(date +"%A, %B %d %Y")
JELL_PATH="$HOME/Library/Mobile Documents/iCloud~com~gl9~markdowns/Documents/jell.md"
SLACK_URL="$1"
FIELDS=$(cat "$JELL_PATH" | awk \
'BEGIN {
  split("good 00f danger", colors);
  comma = "";
  RS = "";
  FS = "\n";
}

NF < 2 {
  next;
}

comma {
  print ",";
}

{
  comma = "true";
  print "{";
}

NR in colors {
  print "  \"color\": \""colors[NR]"\",";
}

{
  sub(/^#[ \t]*/,"",$1);
  print "  \"fields\": [";
  print "    {";
  print "      \"title\": \""$1"\",";
  printf "      \"value\": \"";
  for(i=2; i<NF; i++) {
    sub(/^[ \t]+/, "\t", $i);
    printf $i"\\n";
  };
  sub(/^[ \t]+/, "\t", $NF);
  printf $NF;
  print "\",";
  print "      \"short\": false";
  print "    }";
  print "  ]";
  printf "}";
}')

curl -X POST $SLACK_URL -d @- << EOF
{
  "attachments": [
    {
      "author_name": "$AUTHOR",
      "author_icon": "$ICON_URL",
      "title": "$TODAY",
      "fallback": "$TODAY"
    },
    $FIELDS
  ]
}
EOF
