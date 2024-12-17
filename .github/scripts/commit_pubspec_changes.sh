if git diff --name-only | grep -q 'pubspec.yaml'; then
    git config --global user.name "github-actions[bot]"
    git config --global user.email "github-actions[bot]@users.noreply.github.com"
    git add pubspec.yaml
    git commit -m "Bump version in pubspec.yaml"
fi 