# Code Server

## Hashed Password

    Reference: https://github.com/coder/code-server/blob/main/docs/FAQ.md#can-i-store-my-password-hashed

Yes, you can do so by setting the value of hashed-password instead of password. Generate the hash with:

```shell
echo -n "thisismypassword" | npx argon2-cli -e
$argon2i$v=19$m=4096,t=3,p=1$wst5qhbgk2lu1ih4dmuxvg$ls1alrvdiwtvzhwnzcm1dugg+5dto3dt1d5v9xtlws4
```
