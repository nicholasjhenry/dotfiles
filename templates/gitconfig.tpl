[user]
	name = Nicholas Henry
	email = {{ op://Setup/git/email }}
	signingkey = {{ op://Setup/git/signingkey }}

[gpg]
  format = ssh

[gpg "ssh"]
  program = "/Applications/1Password.app/Contents/MacOS/op-ssh-sign"

[commit]
  gpgsign = true
