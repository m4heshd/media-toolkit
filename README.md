# subs-burner

Easily create videos with subtitles burned-in. Created for my personal use on the cloud. But if you're planning on using
this, that's cool too. 🙂

# Support my work 🙏🏽

I dedicate a significant amount of time and energy to open-source projects. While I don't seek personal gain, any
support would be immensely valuable in helping me achieve my ultimate goal of becoming a full-time open-source
developer.

You can help me by buying me a few coffees ☕, so I'm all buzzed up and got time to work on this further.
Or you can send a few monies my way to simply say thanks for the work that's already been done.

[![Donate to m4heshd](https://i.ibb.co/8PgVcwK/Paypal.png)](https://paypal.variatix.net)

Or you can buy me a "ko-fi" by clicking this button

[![ko-fi](https://i.ibb.co/QmQknmc/ko-fi.png)](https://ko-fi.variatix.net)

## Features

### Can use custom fonts

Just place them inside the `fonts` directory before starting the container.

### [`ttyd`](https://github.com/tsl0922/ttyd) is built-in

You can enable or disable it using the `TTYD_ENABLED` environment variable.

### SSH is supported

If you mount your public key as a volume to `/config/ssh/key.pub`, SSH support will be automatically enabled. Check the docker compose configuration in [Usage](#usage).

## Usage

Spin up a container using the following docker compose setup.

```yaml
version: "3"

services:
  subs-burner:
    image: m4heshd/subs-burner:latest
    container_name: subs-burner
    restart: no
    environment:
      TTYD_ENABLED: "1"
    ports:
      - "8585:2525" # ttyd web-ui
      - "2222:22" # SSH
    volumes:
      - ./ssh/my_public_key.pub:/config/ssh/key.pub # Public key you want to use to access this container via SSH
      - ./fonts:/usr/share/fonts/custom # Custom fonts that your subtitles burn-in process might require
      - ~/Videos:/data # Media files you plan to process with subs-burner
```

Connect to the started container via SSH or ttyd then use `burn_subs.sh` from anywhere. That's it.