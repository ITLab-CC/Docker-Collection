# journal

It seems like the project isn't maintained. Thats why I cloned it into the build folder and fixed a bug. I updated the ruby version in the Dockerfile to 3.1.2.

Source: https://github.com/inoda/journal

## Change login credentials
Only one account can exist. To change the login credentials, you can use the following command.
```bash
docker exec -i journal bundle exec rails console << END
User.first.update!(username: "user", password: "passwd")
END
```