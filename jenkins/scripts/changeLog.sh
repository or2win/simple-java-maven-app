#!/bin/bash
# Parameter is a range of commits or number of commits
# Remove Merge commits
# Replace committer name with first 3 characters in lowercase.
function changeLog {
    git log --format="%cs %h <%cn> %s" "$1" \
    | grep -v '> Merge' | sed -e 's/<\(.*\)>/\L&/' -e 's/<\(...\).*>/\1/'
}
echo "Build ${BUILD_NUMBER}" 
if [ $(git tag -l jenkinsBuild) ]
then changeLog jenkinsBuild..HEAD
else changeLog -1 
fi
