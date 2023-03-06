message=$(date "+%Y-%m-%d %H:%M:%S")

git add .
git commit -m "$message"

git fetch hhzh main && git merge hhzh FETCH_HEAD
git push hhzh main
#git push -u hhzh main

#mkdocs gh-deploy --force