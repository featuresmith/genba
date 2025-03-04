#!/bin/sh

printf 'Do you agree to the terms of the Contributor License Agreement (cla.md)?\n\n'
printf 'Answer YES or NO: '
read -r agreement

agreement=$(echo "$agreement" | LC_ALL=C tr '[:upper:]' '[:lower:]')
if [ "$agreement" != 'yes' ] && [ "$agreement" != 'y' ]; then
    printf '\nYou must read the Contributor License Agreement before you can contribute.'
    exit 0
fi

while [ -z "$name" ]; do
    printf 'Write your full name: '
    read -r name
done

while [ -z "$username" ]; do
    printf 'Write your GitHub username: '
    read -r username
done

date=$(date -u +%Y-%m-%d)

mkdir -p contributors
file="contributors/${username}.md"

cat <<EOF > "$file"
---
date: "$date"
user: "$username"
---

I, the undersigned, hereby confirm that I have read and agreed to the terms of the [Contributor License Agreement v1.0](../cla.md).

*${name}*
EOF

printf '\nYour agreement has been recorded. Please include the %s file in your PR.' "$file"
printf '\nThank you for contributing!'
