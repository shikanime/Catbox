all: home terraform helm docker kube gcloud cpp java erlang elixir python opam go rust node haskell commit

terraform: base
	buildah run catbox-working-container bash -c "curl -fsSL https://apt.releases.hashicorp.com/gpg | apt-key add -"
	buildah run catbox-working-container apt-add-repository -y "deb [arch=amd64] https://apt.releases.hashicorp.com focal main"
	buildah run catbox-working-container apt-get install -y --no-install-recommends terraform

helm: base
	buildah run catbox-working-container bash -c "curl https://baltocdn.com/helm/signing.asc | apt-key add -"
	buildah run catbox-working-container apt-add-repository -y "deb https://baltocdn.com/helm/stable/debian/ all main"
	buildah run catbox-working-container apt-get install -y --no-install-recommends helm

docker: base
	buildah run catbox-working-container apt-get install -y --no-install-recommends podman
	buildah run catbox-working-container apt-get install -y --no-install-recommends buildah

kube: base gcloud
	buildah run --user devas catbox-working-container -- zsh -i -c " \
		gcloud components install --quiet \
			kubectl \
			skaffold \
			kustomize"
  buildah run catbox-working-container bash -c " \
		mkdir -p /tmp/krew-install && \
		cd /tmp/krew-install && \
		curl -fsSLO "https://github.com/kubernetes-sigs/krew/releases/latest/download/krew.tar.gz" && \
		tar zxvf krew.tar.gz krew-linux_amd64 && \
		./krew-linux_amd64 install krew \
		rm -rf /tmp/krew-install

gcloud: home
	buildah run --user devas catbox-working-container bash -c "curl https://sdk.cloud.google.com | bash -s -- --disable-prompts"
	buildah run --user devas catbox-working-container -- zsh -i -c " \
		gcloud components install --quiet \
			beta \
			alpha"

cpp: base asdf
	buildah run catbox-working-container apt-get install -y --no-install-recommends \
		build-essential \
		clang-format \
		clang-tidy \
		clang-tools \
		clang \
		libc++-dev \
		libc++1 \
		libc++abi-dev \
		libc++abi1 \
		libclang-dev \
		libclang1 \
		libomp-dev \
		libomp5 \
		lld \
		lldb \
		llvm-dev \
		llvm-runtime \
		llvm \
		ninja-build \
		xorg-dev \
		mesa-utils \
		libglu1-mesa-dev
	buildah run --user devas catbox-working-container -- zsh -i -c "asdf plugin add cmake"

elixir: base erlang asdf
	buildah run catbox-working-container mix do \
		local.hex --force, \
		local.rebar --force
	buildah run --user devas catbox-working-container -- zsh -i -c "asdf plugin add elixir"

erlang: base asdf java
	buildah run catbox-working-container apt-get install -y --no-install-recommends \
		m4 \
		libreadline-dev \
		libncurses-dev \
		libssh-dev \
		libyaml-dev \
		libxslt1-dev \
		libffi-dev \
		libncurses5-dev \
		libtool \
		unixodbc-dev \
		libwxgtk3.0-gtk3-dev \
		libgl1-mesa-dev \
		libglu1-mesa-dev \
		libpng-dev \
		libssl-dev \
		automake \
		autoconf \
		libxml2-utils \
		xsltproc \
		fop
	buildah run --user devas catbox-working-container -- zsh -i -c "asdf plugin add erlang"
	buildah run --user devas catbox-working-container -- zsh -i -c "asdf plugin add rebar"

java: base asdf
	buildah run --user devas catbox-working-container -- zsh -i -c "asdf plugin add java"
	buildah run cat <<-EOF >> /home/devas/.zshrc
	# Java
	if [ -f "${HOME}/.asdf/plugins/java/set-java-home.zsh" ]; then
		. ${HOME}/.asdf/plugins/java/set-java-home.zsh
	fi

	EOF

python: base asdf
	buildah run catbox-working-container apt-get install -y --no-install-recommends \
		libbz2-dev \
		libsqlite3-dev

opam: base asdf
	buildah run catbox-working-container apt-get install -y --no-install-recommends opam

go: base asdf
	buildah run catbox-working-container apt-get install -y --no-install-recommends golang
	buildah run cat <<-EOF >> /home/devas/.zshrc
	# OPAM configuration
	if [ -f "${HOME}/.opam/opam-init/init.zsh" ]; then
		. ${HOME}/.opam/opam-init/init.zsh
	fi

	EOF

rust: base asdf
	buildah run catbox-working-container bash -c "curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh"

node: base asdf
	buildah run --user devas catbox-working-container -- zsh -i -c "asdf plugin add nodejs"
	bash ~/.asdf/plugins/nodejs/bin/import-release-team-keyring
	buildah run catbox-working-container bash -c "curl -sSL https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -"
	buildah run catbox-working-container add-apt-repository "deb https://dl.yarnpkg.com/debian/ stable main"
	buildah run catbox-working-container apt-get install -y --no-install-recommends yarn

haskell: base asdf
	buildah run catbox-working-container bash -c "curl -sSL https://get.haskellstack.org/ | sh"

home: devas asdf

asdf: base devas
	buildah run catbox-working-container git clone https://github.com/asdf-vm/asdf.git /home/devas/.asdf --branch v0.8.0

devas: base zsh starship
	buildah run catbox-working-container adduser --disabled-password --shell /usr/bin/zsh devas --gecos "Shikanime Deva"
	buildah run catbox-working-container usermod -a -G sudo devas
	buildah copy --chown devas catbox-working-container ./home/devas/.gitconfig /home/devas/.gitconfig
	buildah copy --chown devas catbox-working-container ./home/devas/.gitignore /home/devas/.gitignore
	buildah copy --chown devas catbox-working-container ./home/devas/.zshrc /home/devas/.zshrc
	buildah run --user devas catbox-working-container -- zsh -i -c "curl -sSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh | bash -s --  --keep-zshrc --skip-chsh"

zsh: base
	buildah run catbox-working-container apt-get install -y --no-install-recommends zsh
	buildah config --cmd "/usr/bin/zsh" catbox-working-container

starship: base
	buildah run catbox-working-container bash -c "curl -sSL https://starship.rs/install.sh | bash -s -- -y"

base: locale utils

locale: container
	buildah run catbox-working-container apt-get install -y --no-install-recommends locales
	buildah run catbox-working-container locale-gen en_US.UTF-8
	buildah config --env LANG=en_US.UTF-8 --env LANGUAGE=en_US:en --env LC_ALL=en_US.UTF-8 catbox-working-container

utils: container
	buildah run catbox-working-container bash -c " \
		DEBIAN_FRONTEND=noninteractive \
		apt-get install -y --no-install-recommends \
			libssl1.1 \
			apt-utils \
			git \
			openssh-client \
			gnupg2 \
			inotify-tools \
			neovim \
			iproute2 \
			procps \
			lsof \
			htop \
			net-tools \
			psmisc \
			curl \
			wget \
			rsync \
			ca-certificates \
			unzip \
			software-properties-common \
			zip \
			nano \
			vim-tiny \
			less \
			jq \
			lsb-release \
			apt-transport-https \
			dialog \
			libc6 \
			libgcc1 \
			libkrb5-3 \
			libgssapi-krb5-2 \
			libicu[0-9][0-9] \
			liblttng-ust0 \
			libstdc++6 \
			zlib1g \
			sudo \
			ncdu \
			man-db \
			strace"

container:
	buildah from --name catbox-working-container ubuntu:20.10
	buildah config --author="Shikanime Deva" catbox-working-container
	buildah run catbox-working-container apt-get update -y

commit: base
	buildah config --user devas catbox-working-container
	buildah commit --rm catbox-working-container docker.pkg.github.com/Shikanime/Shikanime/catbox:20.10

clean:
	buildah rm catbox-working-container
