message=$(date "+%Y-%m-%d %H:%M:%S")
git add .
git commit -m "$message"
git pull hhzh main:main && git push -u hhzh main
mkdocs gh-deploy