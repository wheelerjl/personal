alias main='git checkout main && git pull'
alias push='git push || eval $(git push 2>&1 | grep "set-upstream")'
alias gotest='go test ./... -count=1'
